# FFmpeg build with x264 and vpx support

This set of scripts will compile and install FFmpeg packages with x264 and vpx support.
It is heavily inspired from the guide at https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide
It has been mainly tested on Ubuntu >= 12.04 (Precise Pangolin).

By default, it will not include AAC support since the `libfaac` libraries contain some non-free code;
see the `LIBFAAC` parameter.

## Usage

Run as root or with sudo:

    build-all.sh [LIBFAAC]

    LIBFAAC: Whether to include AAC support (i.e. compile 'ffmpeg' with "--enable-libfaac --enable-nonfree" options).
    If true, then the package 'libfaac-dev' will be installed.
    If parameter is not set, then it is true if the package 'libfaac-dev' is installed.

## WARNING

**If nuxeo has been installed with the debian package, the script will remove it along with the nuxeo data**

This will also remove the following packages:

- `ffmpeg`
- `ffmpeg-nuxeo`
- `x264`
- `x264-nuxeo`
- `libvpx-dev`
- `libx264-dev`
- `yasm` (if `BUILD_YASM=true`)
- `libav-tools`

 your existing x264, libvpx, libx264-dev, ffmpeg and libav-tools packages.

### Shell parameters

    BUILD_YASM: If true, then yasm is built from sources, else its package is installed if not already present.


