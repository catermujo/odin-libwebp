# odin-libwebp

Pinned static builds of [libwebp](https://chromium.googlesource.com/webm/libwebp/) for Catermujo projects.

The tracked upstream release is libwebp 1.6.0. Its source is stored in `libwebp/`; public headers and release static
libraries are stored in the canonical platform directories. `COPYING` and `PATENTS` must accompany distributions.

## Build

Run `./build.sh` on Linux or macOS, or `build.bat` from a Visual Studio developer prompt on Windows. The scripts build
only static, position-independent libraries and disable libwebp command-line tools, examples, JavaScript, fuzz targets,
and internal threading.

