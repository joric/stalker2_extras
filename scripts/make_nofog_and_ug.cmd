@echo off

call :RearrangeBands "C:\Temp\Exports\Stalker2\Plugins\GameFeatures\S2_DLC1\Content\UI\WorldMap\T_DLCWorldMap_UDIM.png" ..\tiles\dlc_nofog
call :RearrangeBands "C:\Temp\Exports\Stalker2\Content\Mods\ZoneUnderground\T_ZU_UndergroundMapDLC_UDIM.png" ..\tiles\dlc_ug
call :RearrangeBands "C:\Temp\Exports\Stalker2\Content\Mods\ZoneUnderground\T_ZU_UndergroundMap_UDIM.png" ..\tiles\ug

goto :eof

:RearrangeBands

set "infile=%~1"
set "basename=%~n1"
set "dstdir=%~2"

echo extracting the top band (2048px that should be at the bottom)
vips extract_area "%infile%" top_band.png 0 0 16384 2048 --vips-progress

echo extracting the rest of the image
vips extract_area "%infile%" rest.png 0 2048 16384 14336 --vips-progress

echo joining the halves
vips join rest.png top_band.png fixed.v vertical --vips-progress
del top_band.png rest.png

rem saving fixed.v as PNG (uncomment to save to PNG)
vips copy fixed.v "%basename%_fixed.png" --vips-progress

rem tile images here (uncomment to tile)
rem vips dzsave fixed.v %dstdir% --layout google --tile-size 512 --suffix .webp[Q=85] --centre --vips-progress

goto :eof

