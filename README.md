# Escape Guldur

A retro action-RPG written in [Zig](https://ziglang.org/), originally for [WASM-4 Jam #2](https://itch.io/jam/wasm4-v2).

![title screen image](assets/images/title_screen_capture.png)

## Building

#### Requirements
- [Zig 0.9.1](https://github.com/ziglang/zig/releases/tag/0.9.1)
- [wasm-opt](https://www.npmjs.com/package/wasm-opt)
- [WASM-4](https://wasm4.org/)

Build (debug) the cart (zig-out/lib/cart.wasm) by running:

```shell
zig build
```

then run it with:

```shell
w4 watch zig-out/lib/cart.wasm
```

Produce a size-optimised release build (zig-out/lib/opt.wasm) by running:

```shell
zig build release
```

and remember to test it with:

```shell
w4 run zig-out/lib/opt.wasm
```
