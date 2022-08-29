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

pub const Texture = struct {
    bytes: [*]const u8,
    width: u16,
    height: u16,
    channels: u8,

    pub const door = @This(){
        .bytes = &[8]u8{
            0b00111100,
            0b01111110,
            0b11111111,
            0b11111111,
            0b11111111,
            0b11111111,
            0b11111111,
            0b11111111,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const player = @This(){
        .bytes = &[10]u8{
            0b00011000,
            0b00011000,
            0b00111000,
            0b01111100,
            0b10111100,
            0b10111010,
            0b00111000,
            0b00101100,
            0b00100100,
            0b00100100,
        },
        .width = 8,
        .height = 10,
        .channels = 1,
    };

    pub const monster = @This(){
        .bytes = &[10]u8{
            0b00000000,
            0b00000001,
            0b00000001,
            0b00011001,
            0b00011001,
            0b00111101,
            0b01011011,
            0b01011001,
            0b00100100,
            0b00100100,
        },
        .width = 8,
        .height = 10,
        .channels = 1,
    };

    pub const fire_monster = @This(){
        .bytes = &[8]u8{
            0b00100100,
            0b01011010,
            0b01111110,
            0b11111011,
            0b10111111,
            0b10111010,
            0b00101000,
            0b00101000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const fire_small = @This(){
        .bytes = &[8]u8{
            0b00000000,
            0b00000100,
            0b01000000,
            0b00001000,
            0b00011000,
            0b00110100,
            0b01111000,
            0b00000000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const fire_big = @This(){
        .bytes = &[8]u8{
            0b00100000,
            0b00001000,
            0b00011000,
            0b00110100,
            0b01100110,
            0b11111110,
            0b01111100,
            0b00000000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const heart = @This(){
        .bytes = &[8]u8{
            0b00000000,
            0b00110110,
            0b01111111,
            0b01111111,
            0b01111111,
            0b00111110,
            0b00011100,
            0b00001000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const sword = @This(){
        .bytes = &[8]u8{
            0b00000000,
            0b00000110,
            0b00001110,
            0b00011100,
            0b11011000,
            0b00110000,
            0b01010000,
            0b10001000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };

    pub const small_axe = @This(){
        .bytes = &[8]u8{
            0b00000000,
            0b00001100,
            0b00011111,
            0b00001110,
            0b00010100,
            0b00100000,
            0b01000000,
            0b00000000,
        },
        .width = 8,
        .height = 8,
        .channels = 1,
    };
};
