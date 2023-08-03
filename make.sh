#!/bin/bash
#
# Script configuration
#
# si estás en mac 1 escribe chmod +x make.sh

#Multursor: mac Alt+command+flecha arriba /abajo
#duplicar linea: shift+Alt sobre la línea
#--------------------------------------------------------------------------
# Shows script help and exits
#
function help() {
   cat <<EndOfHelpMessage

 Usage: 
   ./make.sh {all/dsk/rom/cass/clean}

   Generates a dsk or rom or cass file from the BAS files in source folder and Images 
 in assets folder.

   On Clean parameter, it cleans up all previously produced object files.

EndOfHelpMessage
   
   exit 1
}

function preparar_archivos_fuente() {
    local FILES
    local FILE
    local DELFILES
    local BASFILE_SRCDIR
    ## escribe man find para estudiarlo
    #SRCFILES=$(find "./src" -iname *.bas -type f)
    ## Remove comments from files and put them on OBJ folder
    #for BASFILE in ${SRCFILES[*]}; do
    #    #Obtenemos la ruta completa del archivo
    #    BASFILE_SRCDIR=$(dirname "$BASFILE")
    #    #escribe "java -jar tools/MSXTools/MSXTools.jar -h" para la ayuda
    #    java -jar tools/MSXTools/MSXTools.jar -m=d -o="${BASFILE_SRCDIR}"
    #    #unix2dos ${OBJBASFILE}
    #done
    #Creamos el array de archivos que después recorreremos
    FILES=$(find "./src" -type f)
    for FILE in ${FILES[*]}; do
        java -jar tools\MSXTools\MSXTools.jar -m=-m=delete-commits -o="${FILE}"
    done

    #for BAS in src/*bas; do
    #    java -jar tools/MSXTools/MSXTools.jar -m=d -o="${BAS}"
    #    #mv "${BAS}"
    #done
    # Creamos la carpeta onj si no existe
    #mkdir -p ./obj
    #java -jar tools/MSXTools/MSXTools.jar -m=d -o=src/main.bas
    #java -jar tools/MSXTools/MSXTools.jar -m=d -o=src/loader.bas
    #java -jar tools/MSXTools/MSXTools.jar -m=d -o=src/autoexec.bas
    mv main-del.bas obj/game.bas
    mv loader-del.bas obj/loader.bas
    mv autoexec-del.bas obj/autoexec.bas
    unix2dos obj/game.bas
    unix2dos obj/loader.bas
    unix2dos obj/autoexec.bas
}

function convertir_imagenes(){
    echo "Vamos a convertir imagenes"
    #MSX 1
    #rm -f /Q gmon.out

    #MSX2
    #java -jar tools/MSXTools/MSXTools.jar -m=t -o=./assets/loader.png
    java -jar tools/MSXTools/MSXTools.jar -m=s -o=assets/loader.bmp
}
function crear_dir_as_disk(){
    local FILES
    local FILE
    # Creamos la carpeta dsk si no existe
    mkdir -p ./dsk
    #Creamos el array de archivos que después recorreremos
    FILES=$(find "./obj" -type f)
    for FILE in ${FILES[*]}; do
        cp "${FILE}" dsk/
    done

}

function abrir_emulador_con_dsk(){
    #/Applications/openMSX.app/Contents/MacOS/openMSX -machine Philips_NMS_8255  -diska dsk/ &
    /Applications/openMSX.app/Contents/MacOS/openMSX -script ./tools/emulators/openMSX-16.0/emul_start_config.txt &
}
function cleanObjects() {
   echo "objetos borrados"
   rm -rf ./obj/*.*
   rm -rf ./dsk/*.*
}
########################################################################
########################################################################
## SCRIPT MAIN
########################################################################
########################################################################

# Check parameter number
if (( $# < 1 )); then
    echo Escogiste crear dir as disk
    preparar_archivos_fuente
    convertir_imagenes
    crear_dir_as_disk
    abrir_emulador_con_dsk
    #cleanObjects
fi

## Check parameter
PARAM=$1   
case "$PARAM" in
   "-h") 
        #help
   ;;
   "all") 
        echo "vamos a crear un dir as disk, dsk, rom y cas"
   ;;
   "dsk")
        echo "Vamos a crear un dsk"
   ;;
   "rom")
        echo "Vamos a crear un rom"
   ;;
   "cass")
        echo "Vamos a crear un cass"
   ;;
   "clean")
      cleanObjects
   ;;
   #*) echo "ERROR: Parameter '${PARAM}' not valid"
   #help
   #;;
esac

