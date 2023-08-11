
# SAM must live

SAM debe vivir esperamos que sea un juego para el concurso de Konamito de MSXBlog

 https://msx-spain.github.io/SAM-must-live/disk=game.dsk

# Uso

Escriba en en el terminal o ventana de comandos:

make: para correr su emulador favorito utilizando la función DirAsDisk.

make all: para correr su emulador y generar los archivos .dsk, .rom, .cas y .tsx

make dsk: para correr su emulador, utilizando un archivo dsk generado

make rom: para correr su emulador, utilizando un archivo rom generado

make cas: para correr su emulador, utilizando un archivo cas generado

make rsx: para correr su emulador, utilizando un archivo tsx generado

otra opción es crear una tarea en vscode y ejecutarla


make clean

make clean all: borrar los archivos temporales y los archivos obj, dsk, rom, cas y tsx


# Structure / scafolding

src: están los archivos fuente bas y asm

assets: irán los archivos creados con programas que no tienen que ser copiados pero si pueden ser automatizados

    *.xspr son archivos creados con spritedevtools que serán convertidos a .bas o .bin

    *.tmx y *.csv archivos creados con tilemap que serán convertidos a .bin

    *.psd, creados con photoshop

    *.jpg y *.png capturas, fotos descargadas o retocadas

    *.sc2  Screens generados por MSX1-graphic-converter,*.sc5,etc generados con msxviewer, nMSXTIles/MSXTilesdevtool, 

    *.pt3,*.wiz,*.mwm, *.mbm audios creados con vortes tracker, arckos tracker, wiz tracker, moundblaster, etc 

    * compiladores xbasic.bin, nbasic.bin turbobasic, nextorbasic

dsk: carpeta que es utilizada para trabajar como DiskAsDir

tools: van todos los programas que necesitemos

docs: irán los archivos de la documentación, también el index.html con el webMSX y el dsk de prueba

