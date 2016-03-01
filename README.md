# FFmpeg build with x264 and vpx support

This set of scripts will compile and install FFmpeg packages with x264 and vpx support.
It is heavily inspired from the guide at https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide
It has been mainly tested on Ubuntu >= 12.04 (Precise Pangolin).

By default, it will not include AAC support since the `libfaac` libraries contain some non-free code;
see the `LIBFAAC` parameter.

## WARNING

The preferred build method is to run this inside a docker container to avoid polluting your environment.
See: https://github.com/nuxeo/nuxeo-tools-docker/tree/master/ffmpeg

If you do not want to use docker, be aware of the following:

Due to cascading dependencies, the script would purge the nuxeo debian package if present.
To be safe, the build will refuse to execute if it detects the package.

This will also remove the following packages:

- `ffmpeg`
- `ffmpeg-nuxeo`
- `x264`
- `x264-nuxeo`
- `libvpx-dev`
- `libx264-dev`
- `yasm` (if `BUILD_YASM=true`)
- `libav-tools`

## Usage

Run as root or with sudo:

    build-all.sh [LIBFAAC]

    LIBFAAC: Whether to include AAC support (i.e. compile 'ffmpeg' with "--enable-libfaac --enable-nonfree" options).
    If true, then the package 'libfaac-dev' will be installed.
    If parameter is not set, then it is true if the package 'libfaac-dev' is installed.

### Shell parameters

    BUILD_YASM: If true, then yasm is built from sources, else its package is installed if not already present.


