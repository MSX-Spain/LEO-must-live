@echo off
rem dependences
    rem java JRE >=1.8
    rem python>3.5 for tokenizer
    rem disk-manager
    rem deletecomments
    rem disk2rom
    rem mkcas
    rem mcp
    rem Emulators: bluemsx, openmsx, fuse

rem Varibles de configuración
set TARGET_DIR=dsk/
set TARGET_CAS=juego.cas
set TARGET_WAV=juego.wav
set TARGET_DSK=juego.dsk
set TARGET_ROM=juego.rom

rem Con esta línea le estamos diciendo que tiene que empezar por la función main
rem With this line we are telling you that you have to start with the main function
@echo off&cls&call:main %1&goto:EOF

:main
    echo MSX Spain 2023
    rem Ckequeando parámetros
    if [%1]==[] (call :create)
    if [%1]==[all] (call :create_all)
    if [%1]==[dsk] (call :create_dsk)
    if [%1]==[rom] (call :create_rom)
    if [%1]==[cas] (call :create_cas)
    if [%1]==[clean] (call :clean_objets)
    rem Si el argumento no está vacío, ni es dsk, ni es cas, etc
    rem If the argument is not empty, neither is it dsk, nor is it cas, etc.
    if [%1] NEQ [] (
        if [%1] NEQ [all] (
            if [%1] NEQ [rom] (
                if [%1] NEQ [dsk] (
                    if [%1] NEQ [cas] ( 
                        if [%1] NEQ [clean] (call :help) 
                    )
                )
            )
        }
    )    
goto:eof

:create
    echo Escogiste crear dir as disk
    call :preparar_archivos_fuente
    rem call :convertir_imagenes
    rem call :crear_dir_as_disk
    call :abrir_emulador_con_dir_as_disk
goto:eof
:create_all
    echo Escogiste crear dsk, rom y cas
    call :preparar_archivos_fuente
    call :convertir_imagenes
    call :crear_dsk
    call :crear_rom
    call :crear_cas
    call :crear_wav
    call :abrir_emulador_con_dsk
    call :clean_objets
goto:eof

:create_dsk
    echo Escogiste crear dsk
    call :preparar_archivos_fuente
    call :convertir_imagenes
    call :crear_dsk
    call :abrir_emulador_con_dsk
    call :clean_objets
goto:eof


:create_rom
    echo Escogiste crear rom
    call :preparar_archivos_fuente
    call :convertir_imagenes
    call :crear_dsk
    call :crear_rom
    call :abrir_emulador_con_rom
    call :clean_objets
goto:eof



:create_cas
    echo Escogiste crear cas
    call :preparar_archivos_fuente
    call :convertir_imagenes
    call :crear_cas
    call :crear_wav
    call :abrir_emulador_con_wav
    call :clean_objets
goto:eof

:clean_objets
    echo escogiste borrar objetos
    if exist obj del /F /Q obj\*.*
    if exist dsk del /F /Q dsk\*.*
goto:eof

:help
     echo No reconozco la sintaxis, pon:
     echo .
     echo make [dsk] [rom] [cas] [clean]
goto:eof





rem ----------------------------------------------------------------------------
rem Esta función crea los binarios a partir de los asm
rem sjasm (http://www.xl2s.tk/) es un compilador de ensamblador z80 que puedo convertir tu código ensamblador en los archivos binarios.rom y .bin
rem necesitamos el .bin de la pantalla de carga y del reproductor de música
:compilar_asembler
    for /R src/asm %%a in (*.asm) do (
        start /wait tools/sjasm42c/sjasm.exe "%%a")
    for /R src/asm %%a in (*.bin) do (
        copy "%%a" obj)
goto:eof








rem ----------------------------------------------------------------------------
rem Esta función prepará los archivos fuente pata incluirlos en un dsk, cas 

:preparar_archivos_fuente
    rem del /F /Q obj\loader.bas
    rem creamos la carpeta obj (objects) si no existe, si existe borramos su contenido
    If not exist .\obj (md .\obj) else (call :clean_objets)

    rem Copiamos todos los archivos.bas de la carpeta de src(fuentes)/game a la carpeta obj y mostramos un mensaje
    rem for /R src/game %%a in (*.bas) do (
    rem   copy "%%a" obj)
    rem Copiamos 
    copy src\autoexec.bas dsk
    copy src\loader.bas dsk

    rem copy "src\game\main.bas"+"\r\n"+"src\game\utils.bas"+"\r\n" "dsk\temp.bas"
    type "src\game\initialize.bas" >> "dsk\temp.bas"
    echo. >> "dsk\temp.bas"
    type "src\game\main.bas" >> "dsk\temp.bas"
    echo. >> "dsk\temp.bas"
    type "src\game\utils.bas" >> "dsk\temp.bas"

    rem Le quitamos los comentarios a temp.bas
    if not exist tools\MSXTools\MSXTools.jar GOTO :not_exist_deletecomments
    java -jar tools\MSXTools\MSXTools.jar -m=-m=delete-commits -o=dsk\temp.bas 
    move dsk\temp-del.bas dsk\game.bas

    rem lo tokenizamos
    rem if not exist tools\tokenizer\msxbatoken.py GOTO :not_exist_tokenizer
    rem tools\tokenizer\msxbatoken.py obj\game.bad
    rem escribe tyoe /? y find /? paa más ayuda
    rem type obj\temp.bas | find /V  "1 '"  > obj\game.bas
    echo Comentarios eliminados y creado game.bas tokenizado
goto:eof









:convertir_imagenes
    rem Todos los formatos ir a: http://msx.jannone.org/conv/
    rem MSX1
    tools\MSX1-graphic-converter\windows\GraphxConv.exe assets\loader.bmp obj\loader.sc2 -i=0
    del /F /Q gmon.out
goto:eof


:crear_dir_as_disk
    if not exist dsk mkdir dsk
    rem Copiando todos los archivos.bas de la carpeta src
    rem los pegamos en objects y mostramos un mensajito
    for /R obj %%a in (*.*) do (
        copy "%%a" dsk )
   
goto:eof


rem -----------------------------------------------------------------------------
rem Creará un nuevo archivo .dsk con los archivos .bin y .bas especificados
:crear_dsk
    rem comprobamos que existe el disk manager
    if not exist tools\Disk-Manager-v0.17 GOTO :not_exist_disk_manager
    rem Crear nuevo dsk
    rem como diskmanager no puede crear dsk vacíos desde el cmd copiamos y pegamos uno vacío
    if exist %TARGET_DSK% del /f /Q %TARGET_DSK%
    copy tools\Disk-Manager-v0.17\main.dsk .\%TARGET_DSK%
    rem añadimos todos los .bas de la carpeta obj al disco
    rem por favor mirar for /?
    for /R obj/ %%a in (*.bas) do (
        start /wait tools/Disk-Manager-v0.17/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   

    rem añadimos todos los arhivos binarios de la carpeta bin al disco
    rem recuerda que un sc2, sc5, sc8 es también un archivo binario, renombralo
    rem por favor mirar for /?
    for /R bin/ %%a in (*.*) do (
        start /wait tools/Disk-Manager-v0.17/DISKMGR.exe -A -F -C %TARGET_DSK% "%%a")   
goto:eof



:crear_rom
    rem esto generará una rom de 32kb
    if not exist tools\dsk2rom-0.80 GOTO :not_exist_disk2rom
    start /wait tools\dsk2rom-0.80\dsk2rom.exe -c 2 -f %TARGET_DSK% %TARGET_ROM% 
goto:eof



:crear_cas
    if not exist tools\mkcas GOTO :not_exist_mkcas
    rem set TYPE=$1
    rem set TAPENAME=$2
    rem set PATHFILE=$3
    rem start /wait tools\mkcas\mkcas.py %TAPENAME% %TYPE% %PATHFILE%
    rem por favor, visita https://github.com/reidrac/mkcas
    if exist %TARGET_CAS% del /f /Q %TARGET_CAS%
    rem start /wait tools\mkcas\mkcas.py %TARGET_CAS% ascii obj\game.bas
    rem Copiando todos los archivos.bas de la carpeta src
    rem los pegamos en objects y mostramos un mensajito
    rem for /R src %%a in (*.bas) do (copy "%%a" obj & echo %%a)
    start /wait tools\mkcas\mkcas.py %TARGET_CAS% --add --addr 0x8000 --exec 0x8000  ascii obj\game.bas
    start /wait tools\mkcas\mkcas.py %TARGET_CAS% --add --addr 0x9000 --exec 0x9000  binary bin\sc5-01.bin
goto:eof

:crear_wav:
    if not exist tools\mcp GOTO :not_exist_mcp
    start /wait tools\mcp\mcp.exe -e %TARGET_CAS% %TARGET_WAV%
goto:eof














rem ----------------------------------------------------------------
rem Abrir Emulador
if not exist tools/emulators GOTO :not_exist_emulators
rem BlueMSX: http://www.msxblue.com/manual/commandlineargs_c.htm
rem openMSX poner "tools\emulators\openmsx-16.0\openmsx.exe -h" en el cmd
rem Machines:
    rem MSX 1
    rem start /wait tools/emulators/openmsx/openmsx.exe  -ext Sony_HBD-50 -ext ram32k -diska %TARGET_DSK% 
    rem start /wait tools/emulators/openmsx/openmsx.exe -script tools/emulators/openmsx/emul_start_config.txt
    rem MSX2
    rem start /wait tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska %TARGET_DSK%
    rem MSX2+
    rem start /wait tools/emulators/openmsx/openmsx.exe -machine Sony_HB-F1XV -diska %TARGET_DSK%
rem FMSX: FMSX https://fms.komkon.org/fMSX/fMSX.html
rem para utilizar dir as disk tendrás que crear un directorio dsk/

:abrir_emulador_con_dir_as_disk
    rem copy main.dsk tools\emulators\BlueMSX
    rem start /wait tools/emulators/BlueMSX/blueMSX.exe -diska dsk/
    rem start /wait emulators/fMSX/fMSX.exe -diska dsk/
    rem start /wait tools/emulators/openmsx/openmsx.exe -machine Philips_NMS_8255 -diska dsk/
    start tools\emulators\openmsx\openmsx.exe -script tools\emulators\openmsx\emul_start_config.txt
goto:eof

:abrir_emulador_con_dsk
    rem copy %TARGET_DSK% tools\emulators\BlueMSX
    rem start /wait tools/emulators/BlueMSX/blueMSX.exe -diskA %TARGET_DSK%
    rem start /wait tools/emulators/fMSX/fMSX.exe -diska %TARGET_DSK%
    rem start /wait tools/emulators/openmsx-16.0/openmsx.exe -machine Philips_NMS_8255 -diska %TARGET_DSK%
    start tools\emulators\openmsx-16.0\openmsx.exe -script tools\emulators\openmsx-16.0\emul_start_config.txt
goto:eof
:abrir_emulador_con_cas
    rem copy %TARGET_CAS% tools\emulators\BlueMSX
    rem start /wait tools/emulators/BlueMSX/blueMSX.exe -cas %TARGET_CAS%
    rem start /wait tools/emulators/fMSX/fMSX.exe -cas %TARGET_CAS%
    start /wait tools/emulators/openmsx-16.0/openmsx.exe -machine Philips_NMS_8255 -cassetteplayer %TARGET_CAS%
goto:eof
:abrir_emulador_con_wav
    rem start /wait tools/emulators/fMSX/fMSX.exe -cas %TARGET_WAV%
    start /wait tools/emulators/openmsx-16.0/openmsx.exe -machine Philips_NMS_8255 -cassetteplayer %TARGET_WAV%
goto:eof
:abrir_emulador_con_rom   
    copy %TARGET_ROM% tools\emulators\BlueMSX
    start /wait tools/emulators/BlueMSX/blueMSX.exe -rom1 %TARGET_ROM%
    rem start /wait tools/emulators/fMSX/fMSX.exe -cas %TARGET_ROM%
    rem start /wait tools/emulators/openmsx-16.0/openmsx.exe -machine Philips_NMS_8255 -carta %TARGET_ROM%
goto:eof






:not_exist_deletecomments
    echo "Not exit deletecomments"
goto :end
:not_exist_disk2rom
    echo "Not exit disk2rom"
goto :end
:not_exist_mkcas
    echo "Not exit mkcas"
goto :end
:not_exist_mcp
    echo "Not exit mcp"
goto :end
:not_exist_disk_manager
    echo "Not exit diskmanager"
goto :end
:not_exist_tokenizer
    echo "Not exit tokenizer"
goto :end
:not_exist_emulators
    echo "Not exit emulators"
goto :end
:not_exist_bluemsx
goto :end
:not_exist_openmsx
goto :end

:error
    echo "ha habido un error"
goto:eof
