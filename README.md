# FFmpeg build with x264 and vpx support

This set of scripts will compile and install FFmpeg packages with x264 and vpx support.  
It is heavily inspired from the guide at https://ffmpeg.org/trac/ffmpeg/wiki/UbuntuCompilationGuide  
It has only been tested on Ubuntu 12.04 (Precise Pangolin) beta 2 so far.

By default, it will not include AAC support since the libfaac libraries contain some non-free code, but you can enable it by changing LIBFAAC to "true" in the build-all.sh script.

## How to build

Just run the "buil-all.sh" script as root or with sudo.  

WARNING: this will remove your existing x264, libvpx, ffmpeg and libav-tools packages.

