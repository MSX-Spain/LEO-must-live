#!/bin/bash
# glass compiler: http://www.grauw.nl/projects/glass/
#java -jar  tools/assemblers/glass/glass-0.5.jar src/main.asm main.bin main.lst

#sjasmplus: https://github.com/z00m128/sjasmplus
./tools/assemblers/sjasmplus/mac/sjasmplus --raw=obj/main.bin  --sym=obj/main.sym --lst=main.lst src/main.asm 
# mv main.com obj/main.com
mv obj/main.bin dsk/main.bin
#mv obj/main.lst obj/main.lst
#mv obj/main.sym obj/main.sym

./tools/emulators/openmsx/mac/openMSX.app/Contents/MacOS/openmsx -script ./tools/emulators/openmsx/emul_start_config.txt