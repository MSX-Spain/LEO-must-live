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
    local BASFILE
    local SRCFILESDIRGAME
    local SRCFILESDEL
    # Creamos la carpeta onj si no existe
    #mkdir -p ./obj
    #Copiamos el autoexec y el loader
    cp src/autoexec.bas dsk
    cp src/loader.bas dsk
    #Le quitamos los comentarios a los archivos que haya dentro de la carpeta src/game
    SRCFILESDIRGAME=$(find "./src/game" -iname *.bas -type f)
    for BASFILE in ${SRCFILESDIRGAME[*]}; do
      java -jar tools/MSXTools/MSXTools-mac.jar -m=delete-comments -o="${BASFILE}"
    done
    #Utilizamos los del para crear uno solo
    SRCFILESDEL=$(find "./src/game" -iname *-del.bas -type f)
    for BASFILE in ${SRCFILESDEL[*]}; do
        cat "${BASFILE}" >> ./dsk/game.bas
        rm "${BASFILE}"
    done
    #Los pasamos a formato dos
    unix2dos ./dsk/game.bas

    #Método 2 de borrado de comentarios
    #grep -v "^1 *'" ${BASFILE} > ${OBJBASFILE}


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
    /Applications/openMSX.app/Contents/MacOS/openMSX -script ./tools/emulators/openMSX/emul_start_config.txt &
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
    cleanObjects
    preparar_archivos_fuente
    #convertir_imagenes
    #crear_dir_as_disk
    abrir_emulador_con_dsk

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

