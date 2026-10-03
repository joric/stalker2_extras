@echo off

set infile=C:\Temp\Exports\Stalker2\Content\Mods\ZoneUnderground\T_ZU_UndergroundMap_UDIM.png
set dstdir=..\tiles\ug

del fixed.v

if exist fixed.v goto tiles

echo extracting the top band (2048px that should be at the bottom)
vips extract_area %infile% top_band.png 0 0 16384 2048 --vips-progress

echo extracting the rest of the image
vips extract_area %infile% rest.png 0 2048 16384 14336 --vips-progress

echo joining the halves
vips join rest.png top_band.png fixed.v vertical --vips-progress
del top_band.png rest.png


:tiles

vips dzsave fixed.v %dstdir% --layout google --tile-size 512 --suffix .webp[Q=85] --centre --vips-progress
