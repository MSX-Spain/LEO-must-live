       output "game.bin"   ; debemos de poner esta instrucción o nos generaría un archivo.out, ponle espacios al principio
        
;Llamadas a rutinas bios

;Funciones
CHGET equ #009F    ; Se queda esperando que se pulse una tecla
CHPUT equ #00A2    ; escribe el caracter ascii almacenado en a    
GTSTCK equ #00D5   ; Devuelve el estado del joystick, necesita previamente poner algo en el registro A (0 cursor, 1 puerto joystick 1, 2 puerto joystick 2)                     
GTTRIG equ #00D8   ; Devuelve el estado del botón destinado al disparo, necesita que A se ponga que botón es el que va dispara (0 barra espacio, 1 puerto joystick 1 boton A, etc)
CHGMOD equ #005F   ; Cambia el modo de screen pero previamente necesita que se le asigne el modo en el registro a
LDIRVM equ #005C   ; Tansfiere bloques de la RAM a la VRAM, es la más importante, necesita previamente asignar valor al registro bc con la longitud, dc con la dirección de inicio de la VRAM y hl con la dirección de inicio de la RAM:
LDIRMV equ #0059
RDVDP equ #013E    ; Lee el registro de estado del VDP
WRTVDP equ #0047   ; Escribe en los registros del VDP 
GRPPRT equ 0x008D  ; Pinta un carácter en modo gráfico
BEEP equ #00C0     ; Genera un beep
CLS equ #00C3      ; Borra la pantalla
CHGCLR equ #0062   ; Esta rutina necesita que se acceda 1a las constanes de FORCLR,BAKCLR y BDRCLR con un ld,hl(FORCLR) obtenemos su posición
;Constantes bios
FORCLR equ 0xF3E9  ; color de tinta (+1=color del fondo, +1 color del borde) 
SNSMAT equ #0141   ; Devuelve un buffer con estado de las teclas de la fila especifixada en el registro A


;Constantes
;Llamadas direcciones de la ram
RG15AV equ #F3E0 ; alamcena el valor del registro 1 de escritura del VDP, hay unas rutinas de la bios que guardan es entas direcciones valores globals del sistema



    ; https://www.faq.msxnet.org/suffix.html
    db   #fe              
    dw   INICIO            
    dw   FINAL             
    dw   MAIN               
    
    org 33280                 
INICIO:
 

MAIN:  
    call poner_pantalla_en_modo_screen_2
    call volcar_sprite_y_atributos_en_VRAM
    call inicializar_personaje_principal
    call main_loop

    ret




inicializar_personaje_principal:
    ;el entender como fncionan los registros ix del z80 es crucial, lo que hacen es servir de referencia o puntero para las posiciones de moeoria
    ld ix, atributos_personaje_sprite ;fijate en mover_persona_derecha,izquieda, arriba y abajo
    ld hl, atributos_personaje_sprite ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b00; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc,4; solo tenemos 1 plano de un personaje
    call  LDIRVM ; Mira arriba, pone la explicación
    ret
main_loop:
    halt ; sincroniza el teclado y pantalla con el procesador (que va muy rápido)

    call check_cursors
    call check_space_bar
    
    ;Salto incondicional
    jr main_loop






check_cursors:
    xor a
    call GTSTCK
    cp 1
    call z, mover_personaje_arriba
    cp 3
    call z, mover_personaje_derecha
    cp 5
    call z, mover_personaje_abajo
    cp 7
    call z, mover_personaje_izquierda



    ret

check_space_bar:
    ;Ponemos a 0 el registro a que lo necesita GTTRIG para indicarle que vamos a trabajar con la barra espciadora
    xor a
    call GTTRIG
    ;GTTRIG devuelve 255 si está presionada y 0 sino lo está
    cp 255
    jp z, make_sound
   
    ret
make_sound:
    call BEEP
    ret



mover_personaje_arriba:
    ;obtenemos el valor de la posición y del plano 0 y lo ponemos en la dirección de la etiqueta atributos...
    ld hl, #1b00 ;Start address of VRAM
    call #004a ;leemos el contenido de la VRAM
    sub 8
    call #004d

    call main_loop
mover_personaje_abajo:
    ld hl, #1b00 ;Start address of VRAM
    call #004a ;leemos el contenido de la VRAM
    add 8
    call #004d
   
    call main_loop
mover_personaje_derecha:
    ld hl, #1b01 ;Start address of VRAM
    ld de, 60001 ;Start address of memory
    ld bc, 1 ;Block length
    call LDIRMV ;realizamos la trasferencia


    ld a,(60001)
    add 8
    ld (60001), a ; se lo metemos al atributo
    
    ld hl, 60001 ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b01; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc,1; solo tenemos 1 plano de un personaje
    call  LDIRVM ; Mira arriba, pone la explicación
    call main_loop
mover_personaje_izquierda:
    ld hl, #1b01 ;Start address of VRAM
    ld de, 60001 ;Start address of memory
    ld bc, 1 ;Block length
    call LDIRMV ;realizamos la trasferencia


    ld a,(60001)
    sub 8
    ld (60001), a ; se lo metemos al atributo
    
    ld hl, 60001 ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 0000 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #1b01; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc,1; solo tenemos 1 plano de un personaje
    call  LDIRVM ; Mira arriba, pone la explicación
    call main_loop








poner_pantalla_en_modo_screen_2:
     ;Cambiamos el modo de pantalla
    ld  a,2     ; La rutina CHGMOD nos obliga a poner en el registro a el modo de pantalla que queremos
    call CHGMOD ; Mira arriba, pone la explicación

    ld a,(RG15AV) ; esta direcciónd e memoria alamcena el valor el registro de lectura del VDP, mira arriba
    ;En or 0+0=0, 0+1=1, 1+1=1
    ;En and 0+0=0, 0+1=0, 1+1=1
    ;Con eso queremos cambiar los bits 7 y 8 del registro de escritura 1 del z80, queremos poner el 7 a 1 y también el 8 a 1
    ;el bit 7 del registro 1 pone los sprites en modo 16x16 (los que nostros queremos dibujar)
    ;el bit 8 queremos desactivarlo para no utilizar los sprites agrandados
    or 00000010b ; con or poniendo un 0 siempre respetamos los bits que hay y poniendo 1 1 obligamos a que sea 1
    and 11111110b ; con and obligamos a que el ultimo bit valga 0

    ld b,a ;carga en b el valor de a
    ld c,1 ; La rutina WRTVDP necesta que le carguemos previamente el entero en C del z80 del registro que queroms modificar
    call WRTVDP ;Escribe en los registros del VDP 

    ;Ponemos los colores de:
    ld      hl,FORCLR
	ld      [hl],15; le poneos el 15 en tinta que es el blanco
	inc     hl
	ld      [hl],1 ; le metemos 1 en fondo que es el negro
	inc		hl
	ld		[hl],6 ;en borde también el negro
	call    CHGCLR
    ret

volcar_sprite_y_atributos_en_VRAM:
;por favor antes de nada mira este dibujo: https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png
;-----------------------------Definición del sprite en #3800  y volcado a la VRAM-------------------------------------------

    ld hl, sprites_personaje ; la rutina LDIRVM necesita haber cargado previamente la dirección de inicio de la RAM, para saber porqué he puesto 03800 fíjate este dibujo https://sites.google.com/site/multivac7/files-images/TMS9918_VRAMmap_G2_300dpi.png ,así es como está formado el VDP en screen 2
    ld de, #3800; la rutina necesita haber cargado previamente con de la dirección de inicio de la VRAM          
    ld bc, 8*4*4; 8 byte de cada tile * 4 que son los sprites de 16x16 y * 4 que son los sprites o planos que forman el sprite
    call  LDIRVM ; Mira arriba, pone la explicación

;-----------------------------Definición de los atributos en #1b00 y volcado a la VRAM------------------------------------

    ret
;para una expresión hexadecimal se puede utilizar tambiénm el sign $ mirar http://www.xl2s.tk/sjasmman4.html
;Definición de sprite 4 tiles

sprites_personaje:
    ; sprite 1
    ; patrón 1 del sprite_personaje, del @00 al #04 mirando arriba
    DB $03,$03,$03,$1F,$17,$17,$17,$17
    DB $17,$07,$04,$04,$04,$04,$04,$0C
    DB $00,$00,$00,$E0,$A0,$A0,$A0,$A0
    DB $A0,$80,$80,$80,$80,$80,$80,$C0

    ; sprite 2
    ; patrón 2 del sprite_personaje, del #04 al #07, mirando hacia la izquierda
    DB $01,$03,$01,$03,$03,$03,$03,$03
    DB $03,$03,$02,$02,$02,$02,$02,$07
    DB $80,$80,$80,$C0,$C0,$C0,$C0,$C0
    DB $C0,$80,$80,$80,$80,$80,$80,$80

    ; sprite 3
    ; patrón 3 del sprite_personaje, del #08 al # #0b, mirando hacia la derecha
    DB $03,$03,$03,$07,$07,$07,$07,$07
    DB $07,$03,$02,$02,$02,$02,$02,$03
    DB $00,$80,$00,$80,$80,$80,$80,$80
    DB $80,$80,$80,$80,$80,$80,$80,$C0

    ; sprite 3
    ; patrón 4 del sprite_personaje, del #0c al #0f, mirando abajo
    DB $03,$03,$03,$0F,$0F,$0F,$0F,$0F
    DB $0F,$07,$04,$04,$04,$04,$04,$0C
    DB $00,$00,$00,$C0,$C0,$C0,$C0,$C0
    DB $C0,$80,$80,$80,$80,$80,$80,$C0


;---Definición de stributos sprite, a esto se le llama plano y cada plano tiene 4 bytes, solo nos caben 32 planos en el espacio de la VRAM
;Plano 1
atributos_personaje_sprite:
atributos_personaje_sprite_posicion_y DB 100
atributos_personaje_sprite_posicion_x DB 100
atributos_personaje_sprite_numero_sprite DB $00
atributos_personaje_sprite_color DB $08 ; aqui se defien el color y el early clock (que es para desparecer el sprite)
;lo enaterior es lo m ismo que poner atributos_personaje: DB $64,$64,$00,$08   ,le estamos diciendo en el eje y la posición 0 se vaya al pixel 150 (#64), en el x la posición 0, el número de sprite es el 0 y el último byte el 1000 1000 (1000 para que aparezca) y 1000 (el color rojo)=1000+1000=88 en decimal
;otra forma de crear esta definición es atributos_personaje DS 4,0 que creará 4 bytes con valor 0


FINAL: