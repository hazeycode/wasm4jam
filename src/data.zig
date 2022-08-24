pub const levels = [4][20 * 20]u4{
    [_]u4{ // LEVEL 1
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
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 7, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 10, 0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,  0, 0, 0, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,  0, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,  1, 1, 1, 1, 1, 1, 1, 1,
    },

    [_]u4{ // LEVEL 2
        1, 1, 1,  1, 3,  1, 1, 1, 1, 1, 1,  1,  1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1,  0, 12, 0, 1, 1, 1, 1, 0,  0,  0, 1, 1, 0, 0, 0, 0, 1,
        1, 1, 0,  0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 0, 0, 6, 0, 0, 1,
        1, 4, 11, 0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0,  0, 0,  0, 0, 0, 0, 0, 0,  0,  0, 0, 1, 0, 0, 0, 0, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 0, 0, 0, 0, 1,
        1, 1, 1,  1, 1,  1, 1, 1, 1, 1, 0,  0,  0, 1, 1, 0, 0, 0, 0, 1,
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
    },

    [_]u4{ // LEVEL 3
        1, 1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1, 1, 3,  1, 1,  1, 1,  1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 11, 0, 0, 0, 0, 0,  0, 11, 0, 0, 1, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 1, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 1, 1, 1,  1, 0,  0, 0, 1, 1, 1,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 12, 0, 0, 0, 0, 1,  0, 11, 0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 1,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 1, 1, 1,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 11, 0, 0,  1, 1, 1, 1, 1,  1, 1,  1, 1,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 0, 0, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0,  1,
        1, 0, 0,  0, 1, 1, 1, 0,  0, 12, 0, 0, 0, 0, 0,  0, 0,  0, 11, 1,
        1, 0, 0,  0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 11, 0, 0,  0, 0,  1,
        1, 0, 10, 0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  5, 0,  1,
        1, 0, 0,  0, 0, 0, 1, 0,  0, 0,  0, 0, 0, 0, 0,  0, 0,  0, 0,  1,
        1, 1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1, 1, 1, 1,  1, 1,  1, 1,  1,
    },

    [_]u4{ // LEVEL 4
        1, 1, 1,  1,  1, 1, 1, 1,  1,  3,  1, 1,  1,  1, 1,  1, 1,  1,  1, 1,
        1, 0, 0,  0,  0, 0, 0, 1,  0,  0,  0, 1,  1,  1, 11, 0, 0,  0,  0, 1,
        1, 0, 11, 0,  0, 0, 0, 1,  12, 11, 0, 1,  1,  1, 0,  0, 0,  12, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 1,  0,  1,  0, 1,  1,  1, 0,  0, 1,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 1, 1,  0,  0,  0, 0,  0,  0, 1,  1, 1,  0,  0, 1,
        1, 0, 12, 0,  0, 0, 0, 1,  0,  0,  0, 0,  0,  0, 1,  1, 1,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 1,  1,  1,  1, 1,  1,  0, 1,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 12, 0,  12, 0, 0,  12, 0, 1,  0, 11, 0,  0, 1,
        1, 0, 0,  11, 0, 0, 0, 0,  0,  0,  0, 0,  0,  0, 1,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  0,  0, 0,  1,  1, 1,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  11, 0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  0,  0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  1, 0, 0, 11, 0,  0,  1, 1,  1,  1, 0,  0, 0,  1,  1, 1,
        1, 0, 0,  0,  1, 0, 0, 0,  0,  0,  0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  1, 0, 0, 0,  0,  0,  0, 11, 0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 11, 0,  0, 0, 0, 0,  0,  0,  0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  0,  0, 0,  0,  0, 11, 0, 0,  12, 0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  0,  0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 0, 0,  0,  0, 0, 0, 0,  0,  10, 0, 0,  0,  0, 0,  0, 0,  0,  0, 1,
        1, 1, 1,  1,  1, 1, 1, 1,  1,  1,  1, 1,  1,  1, 1,  1, 1,  1,  1, 1,
    },
};

pub const Sprites = struct {
    pub const floor = [8]u8{
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
    };

    pub const door = [8]u8{
        0b11111111,
        0b11111111,
        0b11000011,
        0b11000011,
        0b10000001,
        0b10000001,
        0b10000001,
        0b10000001,
    };

    pub const player = [8]u8{
        0b00110000,
        0b00110000,
        0b01111100,
        0b11111010,
        0b10111010,
        0b01101100,
        0b01000100,
        0b01000100,
    };

    pub const monster = [8]u8{
        0b11011011,
        0b11000011,
        0b10000001,
        0b00100100,
        0b00000000,
        0b10111101,
        0b10100101,
        0b11000011,
    };

    pub const fire_monster = [8]u8{
        0b11011011,
        0b10100101,
        0b10000001,
        0b00000100,
        0b01000000,
        0b01000101,
        0b11010111,
        0b11010111,
    };

    pub const fire_small = [8]u8{
        0b00000000,
        0b00000100,
        0b01000000,
        0b00001000,
        0b00011000,
        0b00110100,
        0b01111000,
        0b00000000,
    };

    pub const fire_big = [8]u8{
        0b00100000,
        0b00001000,
        0b00011000,
        0b00110100,
        0b01100110,
        0b11111110,
        0b01111100,
        0b00000000,
    };

    pub const heart = [8]u8{
        0b00000000,
        0b00110110,
        0b01111111,
        0b01111111,
        0b00111110,
        0b00011100,
        0b00001000,
        0b00000000,
    };

    pub const sword = [8]u8{
        0b00010000,
        0b00010000,
        0b00010000,
        0b00010000,
        0b01111100,
        0b00010000,
        0b00010000,
        0b00000000,
    };

    pub const small_axe = [8]u8{
        0b00000000,
        0b00001100,
        0b00011111,
        0b00001110,
        0b00010100,
        0b00100000,
        0b01000000,
        0b00000000,
    };

    pub const tile_reticule_inactive = [8]u8{
        0b01011010,
        0b10000001,
        0b00000000,
        0b10000001,
        0b10000001,
        0b00000000,
        0b10000001,
        0b01011010,
    };

    pub const tile_reticule_active = [8]u8{
        0b01100110,
        0b11000011,
        0b10100101,
        0b00011000,
        0b00011000,
        0b10100101,
        0b11000011,
        0b01100110,
    };
};