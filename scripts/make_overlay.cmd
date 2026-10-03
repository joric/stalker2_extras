@echo off

set dstdir=..\tiles\dlc_ug_overlay

vips dzsave dlc_ug_overlay.png %dstdir% --layout google --tile-size 512 --suffix .webp[Q=85] --centre --vips-progress
