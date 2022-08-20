const w4 = @import("wasm4.zig");
const wasm4_util = @import("wasm4_util.zig");

const std = @import("std");
const sqrt = std.math.sqrt;
var rng = std.rand.DefaultPrng.init(42);

const sprites = @import("sprites.zig");
const world = @import("world.zig");

const bresenham_line = @import("bresenham.zig").line;

const world_tile_width_px = 8;
const world_size_x = w4.SCREEN_SIZE / world_tile_width_px;
const world_size_y = w4.SCREEN_SIZE / world_tile_width_px;
const max_world_distance = sqrt(world_size_x * world_size_x + world_size_y * world_size_y);

const max_player_health = 5;

const WorldMap = world.Map(world_size_x, world_size_y);

const Path = struct {
    locations: [max_world_distance]world.Location = undefined,
    len: usize = 0,
};

const Entity = struct {
    location: world.Location,
    path: Path = .{},
    health: i8,
    cooldown: u8 = 0,
};

pub const State = struct {
    world: WorldMap,
    world_light_map: WorldMap,
    player: Entity,
    monsters: [16]Entity,
    spit_monsters: [8]Entity,
    fire: [16]Entity,
    monster_count: u8,
    spit_monster_count: u8,
    fire_count: u8,
    turn: u8 = 0,
    level: u8 = 0,

    pub fn reset(self: *@This()) void {
        w4.trace("reset");
        self.player.health = max_player_health;
    }

    pub fn load_level(self: *@This(), level: u8) void {
        w4.trace("load_level");

        self.level = level;
        self.world = levels[level];

        for (self.monsters) |*monster| monster.health = 0;
        self.monster_count = 0;

        for (self.spit_monsters) |*spit_monster| spit_monster.health = 0;
        self.spit_monster_count = 0;

        for (self.fire) |*fire| fire.health = 0;
        self.fire_count = 0;

        var location: world.Location = .{ .x = 0, .y = 0 };
        while (location.x < world_size_x) : (location.x += 1) {
            defer location.y = 0;
            while (location.y < world_size_y) : (location.y += 1) {
                switch (world.map_get_tile_kind(self.world, location)) {
                    .player_spawn => {
                        self.player.location = location;
                    },
                    .monster_spawn => {
                        self.monsters[self.monster_count] = .{
                            .location = location,
                            .health = 1,
                        };
                        self.monster_count += 1;
                    },
                    .spit_monster_spawn => {
                        self.spit_monsters[self.spit_monster_count] = .{
                            .location = location,
                            .health = 2,
                        };
                        self.spit_monster_count += 1;
                    },
                    else => {},
                }
            }
        }

        update_world_lightmap(self);

        self.turn = 0;
    }
};

const ScreenPosition = struct { x: i32, y: i32 };

fn world_to_screen(state: *State, location: world.Location) ScreenPosition {
    const cam_offset = state.player.location;
    return .{
        .x = (location.x - cam_offset.x) * world_tile_width_px + w4.SCREEN_SIZE / 2,
        .y = (location.y - cam_offset.y) * world_tile_width_px + w4.SCREEN_SIZE / 2,
    };
}

const LineOfSightResult = struct {
    path: Path = .{},
    hit_target: bool = false,
};

fn check_line_of_sight(
    world_map: WorldMap,
    origin: world.Location,
    target: world.Location,
) LineOfSightResult {
    var plotter = struct {
        world_map: WorldMap,
        target: world.Location,
        result: LineOfSightResult = .{},

        pub fn plot(self: *@This(), x: i32, y: i32) bool {
            const location = world.Location{ .x = @intCast(u8, x), .y = @intCast(u8, y) };

            self.result.path.locations[self.result.path.len] = location;
            self.result.path.len += 1;

            if (location.eql(self.target)) {
                self.result.hit_target = true;
                return false;
            }

            if (world.map_get_tile_kind(self.world_map, location) == .wall) {
                return false;
            } else {
                return true;
            }
        }
    }{
        .world_map = world_map,
        .target = target,
    };

    bresenham_line(
        @intCast(i32, origin.x),
        @intCast(i32, origin.y),
        @intCast(i32, target.x),
        @intCast(i32, target.y),
        &plotter,
    );

    return plotter.result;
}

fn try_move(state: *State, pos: world.Location) void {
    switch (world.map_get_tile_kind(state.world, pos)) {
        .wall => {
            // you shall not pass!
            return;
        },
        else => {
            var monster_killed = false;
            for (state.monsters) |*monster| {
                if (monster.health > 0 and
                    monster.location.eql(pos))
                {
                    monster.health -= 1;
                    monster_killed = true;
                }
            }
            for (state.spit_monsters) |*spit_monster| {
                if (spit_monster.health > 0 and
                    spit_monster.location.eql(pos))
                {
                    spit_monster.health -= 1;
                    monster_killed = true;
                }
            }

            if (monster_killed) {
                w4.tone(
                    880 | (440 << 16),
                    2 | (4 << 8),
                    100,
                    w4.TONE_PULSE1,
                );
            } else {
                state.player.location = pos;
                w4.tone(220, 2 | (4 << 8), 80, w4.TONE_TRIANGLE);
            }
        },
    }

    end_move(state);
}

fn end_move(state: *State) void {
    defer {
        if (state.player.health < 0) state.player.health = 0;
    }

    w4.trace("end_move...");

    if (world.map_get_tile_kind(state.world, state.player.location) == .door) {
        state.level += 1;
        if (state.level < levels.len) {
            w4.trace("load next level");
            state.load_level(state.level);
        }
        return;
    }

    for (state.fire) |*fire| {
        if (fire.health > 0) {
            move_fire(state, fire);
        }
    }

    for (state.monsters) |*monster| {
        if (monster.health > 0) find_move: {
            w4.trace("monster: begin move...");
            defer w4.trace("monster: move complete");

            const d = monster.location.manhattan_to(state.player.location);

            if (d == 1) {
                w4.trace("monster: hit player!");
                w4.tone(300, 2 | (4 << 8), 100, w4.TONE_NOISE);
                state.player.health -= 2;
                break :find_move;
            } else if (d < 10) {
                const res = check_line_of_sight(state.world, monster.location, state.player.location);
                if (res.hit_target) {
                    std.debug.assert(res.path.len > 1);

                    w4.trace("monster: chase player!");

                    { // find best tile to get closer to player
                        var min_dist = d;
                        const possible: [4]world.Location = .{
                            monster.location.north(),
                            monster.location.east(),
                            monster.location.south(),
                            monster.location.west(),
                        };
                        for (&possible) |new_location| {
                            if (test_walkable(state, new_location)) {
                                const dist = new_location.manhattan_to(state.player.location);
                                if (dist < min_dist) {
                                    monster.location = new_location;
                                    min_dist = dist;
                                } else if (dist == min_dist) {
                                    if (state.player.location.x != new_location.x) {
                                        monster.location = new_location;
                                    }
                                }
                            }
                        }
                    }
                    break :find_move;
                }
            }

            w4.trace("monster: walk around randomly");
            random_walk(state, monster);
        }
    }

    for (state.spit_monsters) |*spit_monster| {
        if (spit_monster.cooldown > 0) {
            spit_monster.cooldown -= 1;
        } else if (spit_monster.health > 0) find_move: {
            w4.trace("spit_monster: begin move...");
            defer w4.trace("spit_monster: move complete");

            const d = spit_monster.location.manhattan_to(state.player.location);

            if (d > 3 and d < 20) {
                const res = check_line_of_sight(state.world, spit_monster.location, state.player.location);
                if (res.hit_target) {
                    w4.trace("spit_monster: spit at player");
                    spawn_fire(state, res.path);
                    break :find_move;
                }
            }

            w4.trace("spit_monster: walk around randomly");
            random_walk(state, spit_monster);
        }
    }

    update_world_lightmap(state);
}

/// Returns true if the location is not occupied by a blocking tile or blocking entity
fn test_walkable(state: *State, location: world.Location) bool {
    if (world.map_get_tile_kind(state.world, location) == .wall) {
        return false;
    }
    if (state.player.location.eql(location)) {
        return false;
    }
    for (state.monsters) |*other| {
        if (other.location.eql(location)) {
            return false;
        }
    }
    for (state.spit_monsters) |*other| {
        if (other.location.eql(location)) {
            return false;
        }
    }
    return true;
}

fn spawn_fire(state: *State, path: Path) void {
    std.debug.assert(path.len > 1);

    if (state.fire_count < state.fire.len) {
        var new_fire = Entity{
            .location = path.locations[0],
            .health = 1,
        };
        new_fire.path.len = path.len - 1;
        var i: usize = 0;
        while (i < new_fire.path.len - 1) : (i += 1) {
            new_fire.path.locations[i] = path.locations[i + 1];
        }
        state.fire[state.fire_count] = new_fire;
        move_fire(state, &state.fire[state.fire_count]);
        state.fire_count += 1;
    }
}

fn move_fire(state: *State, fire: *Entity) void {
    if (fire.path.len > 0) {
        var i: usize = 0;
        while (i < fire.path.len - 1) : (i += 1) {
            fire.path.locations[i] = fire.path.locations[i + 1];
        }
        fire.path.len -= 1;

        fire.location = fire.path.locations[0];

        if (fire.location.eql(state.player.location)) {
            w4.trace("fire hit player!");
            w4.tone(300, 2 | (4 << 8), 100, w4.TONE_NOISE);
            state.player.health -= 1;
        }

        if (world.map_get_tile_kind(state.world, fire.location) != .wall) {
            return;
        }
    }

    fire.health = 0;
    fire.path.len = 0;
    state.fire_count -= 1;
}

/// finds walkable adjacent tile (random walk), remains still if there are none walkable
fn random_walk(state: *State, entity: *Entity) void {
    const north = entity.location.north();
    const east = entity.location.east();
    const south = entity.location.south();
    const west = entity.location.west();

    var random_dir = @intToEnum(world.Direction, @mod(rng.random().int(u8), 3));

    var possible_location = switch (random_dir) {
        .north => north,
        .east => east,
        .south => south,
        .west => west,
    };

    var i: usize = 0;
    while (i < 4) : (i += 1) {
        if (test_walkable(state, possible_location)) {
            entity.location = possible_location;
        }

        random_dir = @intToEnum(world.Direction, @mod(@enumToInt(random_dir) + 1, 3));
    }
}

fn update_world_lightmap(state: *State) void {
    var location: world.Location = .{ .x = 0, .y = 0 };
    while (location.x < world_size_x) : (location.x += 1) {
        defer location.y = 0;
        while (location.y < world_size_y) : (location.y += 1) {
            if (location.manhattan_to(state.player.location) > 13) {
                world.map_set_tile(&state.world_light_map, location, @as(u8, 0));
            } else {
                const res = check_line_of_sight(state.world, location, state.player.location);
                world.map_set_tile(
                    &state.world_light_map,
                    location,
                    @as(u4, if (res.hit_target) 1 else 0),
                );
            }
        }
    }
}

pub fn update(global_state: anytype, pressed: u8) void {
    if (@typeInfo(@TypeOf(global_state)) != .Pointer) {
        @compileError("global_state type must be a pointer");
    }

    var state = &global_state.game_state;

    if (state.player.health <= 0) {
        global_state.screen = .dead;
    }

    if (pressed & w4.BUTTON_UP != 0) {
        try_move(state, state.player.location.north());
    } else if (pressed & w4.BUTTON_RIGHT != 0) {
        try_move(state, state.player.location.east());
    } else if (pressed & w4.BUTTON_DOWN != 0) {
        try_move(state, state.player.location.south());
    } else if (pressed & w4.BUTTON_LEFT != 0) {
        try_move(state, state.player.location.west());
    }

    if (state.level == levels.len) {
        global_state.screen = .win;
    }

    { // draw world
        var location: world.Location = .{ .x = 0, .y = 0 };
        while (location.x < world_size_x) : (location.x += 1) {
            defer location.y = 0;
            while (location.y < world_size_y) : (location.y += 1) {
                if (world.map_get_tile(state.world_light_map, location) > 0) {
                    switch (world.map_get_tile_kind(state.world, location)) {
                        .floor, .player_spawn, .monster_spawn, .spit_monster_spawn => {
                            w4.DRAW_COLORS.* = 0x43;
                            const screen_pos = world_to_screen(state, location);
                            w4.blit(
                                &sprites.floor,
                                screen_pos.x,
                                screen_pos.y,
                                8,
                                8,
                                w4.BLIT_1BPP,
                            );
                        },
                        .door => {
                            w4.DRAW_COLORS.* = 0x03;
                            const screen_pos = world_to_screen(state, location);
                            w4.blit(
                                &sprites.door,
                                screen_pos.x,
                                screen_pos.y,
                                8,
                                8,
                                w4.BLIT_1BPP,
                            );
                        },
                        else => {},
                    }
                }
            }
        }
    }

    { // draw monsters
        w4.DRAW_COLORS.* = 0x02;

        for (state.monsters) |*monster| {
            if (monster.health > 0 and
                world.map_get_tile(state.world_light_map, monster.location) > 0)
            {
                const screen_pos = world_to_screen(state, monster.location);
                w4.blit(
                    &sprites.monster,
                    screen_pos.x,
                    screen_pos.y,
                    8,
                    8,
                    w4.BLIT_1BPP,
                );
            }
        }
        for (state.spit_monsters) |*spit_monster| {
            if (spit_monster.health > 0 and
                world.map_get_tile(state.world_light_map, spit_monster.location) > 0)
            {
                const screen_pos = world_to_screen(state, spit_monster.location);
                w4.blit(
                    &sprites.spit_monster,
                    screen_pos.x,
                    screen_pos.y,
                    8,
                    8,
                    w4.BLIT_1BPP,
                );
            }
        }
    }

    { // draw player sprite
        w4.DRAW_COLORS.* = 0x20;

        const screen_pos = world_to_screen(state, state.player.location);
        w4.blit(
            &sprites.player,
            screen_pos.x,
            screen_pos.y,
            8,
            8,
            w4.BLIT_1BPP,
        );
    }

    { // draw fire
        w4.DRAW_COLORS.* = 0x40;

        for (state.fire) |*fire| {
            if (fire.health > 0 and world.map_get_tile(state.world_light_map, fire.location) > 0) {
                const screen_pos = world_to_screen(state, fire.location);
                w4.blit(
                    &sprites.fire,
                    screen_pos.x,
                    screen_pos.y,
                    8,
                    8,
                    w4.BLIT_1BPP,
                );
            }
        }
    }

    { // draw hud
        { // draw health bar
            w4.DRAW_COLORS.* = 0x40;

            std.debug.assert(state.player.health >= 0);
            const health = @intCast(u16, state.player.health);
            const piece_width: u16 = 8;
            const piece_height: u16 = 8;
            const width: u16 = health * piece_width;
            const y = @intCast(i32, w4.SCREEN_SIZE) - piece_height - 1;
            var x: i32 = @intCast(i32, w4.SCREEN_SIZE) / 2 - width / 2;
            var i: usize = 0;
            while (i < state.player.health) : (i += 1) {
                w4.blit(
                    &sprites.heart,
                    x,
                    y,
                    piece_width,
                    piece_height,
                    w4.BLIT_1BPP,
                );
                x += piece_width;
            }
        }
    }
}

const levels: [4]WorldMap = .{
    @bitCast(WorldMap, [_]u4{
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,  0, 0, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 10, 0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
    }),

    @bitCast(WorldMap, [_]u4{
        1, 1, 1,  1, 3,  1, 1, 1, 1, 1, 1,  1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  0, 12, 0, 1, 1, 1, 1, 0,  0,  0, 1, 1, 0, 0, 0, 0, 1,
        1, 1, 0,  0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 1,
        1, 4, 11, 0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0,  0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 1, 0, 0, 0, 0, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 0, 0, 0, 0, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  11, 0, 1, 1, 0, 0, 0, 0, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 0, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 0, 0,  0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 0, 0, 0,  0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 0, 0, 0,  0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 4, 0, 0, 0,  0,  0, 0, 0, 4, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 0, 0, 11, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 0, 0, 0,  0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 0, 0,  0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  10, 0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 1,  1,  1, 1, 1, 1, 1, 1, 1, 1,
    }),

    @bitCast(WorldMap, [_]u4{
        1, 1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1, 1, 3,  1, 1,  1, 1, 1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 11, 0, 0, 0, 0, 0,  0, 11, 0, 0, 1, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 1, 1, 1,  1, 0,  0, 0, 1, 1, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 12, 0, 0, 0, 0, 1,  0, 11, 0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 1, 1, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 11, 0, 0,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 1, 1, 1, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 11, 0, 0,  0, 0, 1,
        1, 0, 10, 0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1,
        1, 1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1,
    }),

    @bitCast(WorldMap, [_]u4{
        1, 1, 1,  1,  1, 1, 1, 1,  3, 1,  1, 1,  1,  1, 1,  1, 1,  1, 1, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 11, 0,  0, 0, 0, 0,  0, 11, 0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 1,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 1, 1,  1, 0,  0, 0,  0,  1, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 12, 0, 12, 0, 0,  12, 0, 1,  0, 11, 0, 0, 1,
        1, 0, 0,  11, 0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  1,  1, 1,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 11, 0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  1, 0, 0, 11, 0, 0,  1, 1,  1,  1, 0,  0, 0,  0, 1, 1,
        1, 0, 0,  0,  1, 0, 0, 0,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  1, 0, 0, 0,  0, 0,  0, 11, 0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 11, 0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 0,  0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0, 10, 0, 0,  0,  0, 0,  0, 0,  0, 0, 1,
        1, 1, 1,  1,  1, 1, 1, 1,  1, 1,  1, 1,  1,  1, 1,  1, 1,  1, 1, 1,
    }),
};
