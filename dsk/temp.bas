1 'Color caracteres, fondo, borde'
10 cls:color 1,15,15:key off
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E, inicializamos el psg &h90'
1 '&h41 y &h44 Enlazamos con las rutinas de apagar y encender la pantalla'
20 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
25 screen 2,2,0
1 'Todas las variables serán enteras'
30 defint a-z
1 'Definimos un canal necesario para poder mostrar texto, habrá que poner en el print o input #1'
35 open "grp:" as #1
40 print #1,"Loading sprites"
1 'cargamos los sprites en VRAM'
45 gosub 9000
50 print #1,"Loading tileset"
1 'Cargamos los tiles'
55 gosub 10000 
1 '' ******************************
1 '' Program:  SAM must live
1 '' autor:    MSX spain
1 '' ******************************
1 '***************
1 '****Variables**
1 '***************


1 '****************
1 '***Subrrutinas**
1 '****************
1 ' 9000 Rutina cargar sprites en VRAM con datas basic''


80 X=5:Y=80:G=1:P=0:P0=0:P1=1:P2=2:P3=3
90 goto 300

1 'Main-loop'
    100 S=STICK(0)ORSTICK(1)
    110 ON S GOTO 130,140,150,160,170,180,190,200
    120 goto 215

    1 'movimiento hacia arriba o salto
    130 Y=Y-4:IF Y<40 THEN Y=40
    132 GOTO 210
    1 'Pulsado 2 movimiento hacia arriba derecha o salto hacia arriba'
    140 Y=Y-4:X=X+4:IF Y<40 THEN Y=40
    1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    142 P=P0:SWAPP0,P1:GOTO 210
    1 '3 pulsado Movimiento hacia la derecha '
    150 X=X+4
    152 P=P0:SWAPP0,P1:GOTO 210
    1 '4 Movimiento abajo derecha'
    160 X=X+4:Y=Y+4
    161 IF Y>100 THEN Y=100
    162 P=P0:SWAPP0,P1:GOTO 210
    1 '5 Movimiento  abajo'
    170 Y=Y+4:IFY>100THENY=100
    172 P=P0:SWAPP0,P1:GOTO 210
    1 '6 Moviemiento abajo izquierda'
    180 Y=Y+4:X=X-4:IF Y>100 THEN Y=100
    181 IF X<4 THEN X=4
    182 P=P2:SWAPP2,P3:GOTO 210
    1 '7'
    190 X=X-4:IFX<4THENX=4
    192 P=P2:SWAPP2,P3:GOTO 210

    200 Y=Y-4:X=X-4:IFY<40THENY=40
    201 IFX<4THENX=4
    202 P=P2:SWAPP2,P3

    1 'Pintamos al player'
    210 PUTSPRITE0,(X,Y),4,P


    215 IF POINT(X+4,Y+14)=5 THEN GOSUB 5060
    216 IF POINT(X+12,Y+10)=5 THEN GOSUB 5060

    230 ON F GOSUB 330,530,730,930,1130,1330,1530




1 'Fase 1'
1'--------
300 'gosub 11000:'se pinta el mapa de tiles y se inicializa
310 'se inicializan os enemigos, se pintan los objetos y el marcador'
320 'se inicializan las variables del player'
330 if x> 240 then goto 500
340 'pintamos los enemigos'
350 'Actualizamos los enemigos'
390 goto 100

1 'Fase 2'
1'--------
500 'lo mismo que en la fase 1'
530 if x>240 then goto 700
540 'lo mismo que en la fase 1'
590 goto 100

1 'Fase 3'
1'--------
700 'lo mismo que en la fase 1'
730 if x>240 then goto 900
740 'lo mismo que en la fase 1'
790 goto 100

1 'Fase 4'
1'--------
900 'lo mismo que en la fase 1'
930 if x>240 then goto 1100
940 'lo mismo que en la fase 1'
990 goto 100

1 'Fase 5'
1'--------
1100 'lo mismo que en la fase 1'
1130 if x>240 then goto 1300
1140 'lo mismo que en la fase 1'
1190 goto 100

1 'Fase 6'
1'--------
1300 'lo mismo que en la fase 1'
1330 if x>240 then goto 1500
1340 'lo mismo que en la fase 1'
1390 goto 100

1 'Fase 7'
1'--------
1500 'lo mismo que en la fase 1'
1530 if x>240 then goto 80
1590 goto 100


1' Pantalla ganadora
    1700 print #1,"tu ganas"
    1710 ONSTRIGGOSUB1790:STRIG(0)ON
    1720 GOTO 1720
1790 STRIG(0)OFF:RETURN80

1 ' menu principal'
    1800 print #1,"menu pricipal, pulse una tecla"
    1810 ON STRIG GOSUB 1890:STRIG(0)ON
    1820 GOTO 1820
1890 STRIG(0)OFF:RETURN80

5060 'colisión con objeto'
5090 return

1 'Render map, pintar mapa
    1 'la pantalla en screen 2:
    1 'El mapa se encuentra en la dirección 6144 / &h1800 - 6912 /1b00'
    1 'Eliminamos los enemigos si quedan'
    11000 'gosub 6600
    11010 md=6144
    1 'Lectora de mapa con un dígito'
    1 '11020 for f=0 to 19
    1 '    11030 READ D$
    1 '    11040 for c=0 to 19
    1 '        11050 tn$=mid$(D$,c+1,1)
    1 '        11060 tn=val(tn$)
    1 '        11070 VPOKE md+c,tn
    1 '    11160 next c
    1 '    11170 md=md+32
    1 '11180 next f
    1 'Lectura de mapa con 2 dígitos'
    1 'El mapa lo he dibujado con tilemap con 20x20 tiles de 8 pixeles'
    11020 for f=0 to 19
        11030 READ mp$
        1 ' ahora leemos las columnas c
        11040 for c=0 to 39 step 2
            11050 tn$=mid$(mp$,c+1,2)
            11060 tn=val("&h"+tn$)
            11070 VPOKE md,tn:md=md+1
        11160 next c
        1 'Bajamos la fila'
        11170 md=md+12
    11180 next f
11190 return
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Mundo 1------------------------------------------'
1 '--------------------------------------------------------------------------------------'

1 'level 0'
12000 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12010 data 0e1404000d07070708000000090307070707080e
12020 data 0e0004000415000000000016000400000000000e
12030 data 0e00040004000d0707030800000a0707070c000e
12040 data 0e0004000400040000040000000000120004000e
12050 data 0e000a070b000a0707030707070c00130004000e
12060 data 0e0000000000000000040000000400000004000e
12070 data 0e0707070707070c00040000000400000004000e
12080 data 0e00000000000004000a070707030707070b000e
12090 data 0e0015000016000400000000000000000000000e
12100 data 0e00000000000004000d0707070707070708000e
12110 data 0e000d070800000400040000000000000000000e
12120 data 0e00040000000004000a070707070c000907070e
12130 data 0e0004000d07070b00000000180004000000000e
12140 data 0e000400041400000009070c000004000000000e
12150 data 0e0004000a07070c0000000400000a07070c000e
12160 data 0e0004000000000400000004000000000004000e
12170 data 0e000a07070707030707070b001600000004000e
12180 data 0e0000000000000000000000000000000004140e
12190 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
1 'level 1'
12200 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12210 data 0e0907070707070707070708000000000000000e
12220 data 0e140000000000000000150000000d070707160e
12230 data 0e090707070716070716070c000004000000000e
12240 data 0e0000000000000000000004000004000005000e
12250 data 0e00090307070707070c0006000004000004000e
12260 data 0e0000040000000000041500000004000004000e
12270 data 0e05000400001600000400000d070b000004000e
12280 data 0e0400040005000500040000041200000004000e
12290 data 0e0400040004000400040000041300000004000e
12300 data 0e04000400040004000400000a070716030b000e
12310 data 0e0400040004000400040000000000000400000e
12320 data 0e040004000400040004000d070708000400090e
12330 data 0e0400040004000400040004000000000400000e
12340 data 0e04000400060004000a0703070707070308000e
12350 data 0e0600041500000400000000000000000000000e
12360 data 0e0000060005000a07070707070707070c16000e
12370 data 0e0000000004000000000000000000000400000e
12380 data 0e000000000a070707070707070708140415140e
12390 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
1 'level 2'
12400 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00
12410 data 0e0000000000000000000000000000000000000e
12420 data 0e000d07070707070708160009070707070c000e
12430 data 0e0004000000000000000000000000000004000e
12440 data 0e0004150000000000000000000000001404000e
12450 data 0e000307070707070707070707070707070b000e
12460 data 0e0004000000000000000000000000000000000e
12470 data 0e000415000000140516000e0e0e0e0e0e0e0e0e
12480 data 0e000a07070707070300000e0e0e0e0e0e0e0e0e
12490 data 0e000000000000000400000e0e1200000000000e
12500 data 0e000000000000150400000e0e1300000000000e
12510 data 0e000d07070707070300000e0e0e0e0e0e0e000e
12520 data 0e0004000000000006000016000000000005000e
12530 data 0e000400000000000000000e000000000004000e
12540 data 0e0003070707070707070707070707080004000e
12550 data 0e070b000000000000000000000000000004000e
12560 data 0e0000000000000005000005140000000004000e
12570 data 0e000907070707070b00000a07070707070b000e
12580 data 0e1500000000001600000000000000000000000e
12590 data 000e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e0e00


 
1 'En este archivo se cargar los sprites y el tileset
1 'Rutina cargar sprites en VRAM con datas basic'
    9000 for i=0 to 5:sp$=""
        9220 for j=0 to 31
            9230 read a$
            9240 sp$=sp$+chr$(val(a$))
        9250 next J
        9260 sprite$(i)=sp$
    9270 next i
    9350 rem sprites data definitions
    9360 rem data definition sprite 0, name: Sprite-2
    9370 data 0,0,0,0,0,0,0,24
    9380 data 32,32,35,31,15,28,48,48
    9390 data 0,0,0,0,0,0,0,20
    9400 data 26,30,188,232,244,234,10,0
    9410 rem data definition sprite 1, name: Sprite-2
    9420 data 0,0,0,0,0,0,0,0
    9430 data 0,192,49,15,7,6,1,0
    9440 data 0,0,0,0,0,0,0,10
    9450 data 13,15,222,244,232,80,168,168
    9460 rem data definition sprite 2, name: Sprite-2
    9470 data 0,0,0,0,0,0,0,40
    9480 data 88,120,61,23,47,87,80,0
    9490 data 0,0,0,0,0,0,0,24
    9500 data 4,4,196,248,240,56,12,12
    9510 rem data definition sprite 3, name: Sprite-2
    9520 data 0,0,0,0,0,0,0,80
    9530 data 176,240,123,47,23,10,21,21
    9540 data 0,0,0,0,0,0,0,0
    9550 data 0,2,140,240,224,96,128,0
    9560 rem data definition sprite 4, name: Sprite-2
    9570 data 0,0,0,0,0,2,3,3
    9580 data 1,1,3,6,5,6,26,33
    9590 data 0,0,0,0,0,32,224,224
    9600 data 192,192,224,240,240,160,160,192
    9610 rem data definition sprite 5, name: Sprite-2
    9620 data 0,0,0,0,0,2,1,3
    9630 data 19,9,7,7,3,3,1,2
    9640 data 0,0,0,0,0,64,128,192
    9650 data 200,144,224,224,224,192,128,64
9990 return 

1 'En screen 2'
    1 'Ponemos que en la parte del mapa solo se vea el ultimo tile
    10000 FOR t=6144 TO 6912
        10010 vpoke t,255
    10020 next t

    1' Hay que recordar la estructura de la VRAM, el tilemap se divide en 3 zonas
    1 'Nuestro tileset son 24 tiles o de 0 hasta el 23'
    1 'Definiremos a partir de la posición 0 de la VRAM 18 tiles de 8 bytes'
        10030 FOR I=0 TO (26*8)-1
        10040 READ A$
        10050 VPOKE I,VAL("&H"+A$)
        10060 VPOKE 2048+I,VAL("&H"+A$)
        10070 VPOKE 4096+I,VAL("&H"+A$)
    10080 NEXT I


    10100 DATA FF,66,66,00,00,66,66,00
    10101 DATA FF,66,66,00,00,66,66,00
    10102 DATA FF,99,99,FF,FF,99,99,FF
    10103 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10104 DATA 7E,7E,7E,7E,7E,7E,7E,7E
    10105 DATA 00,7E,7E,7E,7E,7E,7E,7E
    10106 DATA 7E,7E,7E,7E,7E,7E,7E,00
    10107 DATA 00,FF,FF,FF,FF,FF,FF,00
    10108 DATA 00,FE,FE,FE,FE,FE,FE,00
    10109 DATA 00,7F,7F,7F,7F,7F,7F,00
    10110 DATA 7F,7F,7F,7F,7F,7F,7F,00
    10111 DATA FE,FE,FE,FE,FE,FE,FE,00
    10112 DATA 00,FE,FE,FE,FE,FE,FE,FE
    10113 DATA 00,7F,7F,7F,7F,7F,7F,7F
    10114 DATA 00,F7,F7,F7,00,7F,7F,7F
    10115 DATA 00,F7,F7,F7,00,7F,7F,7F
    10116 DATA 00,F7,F7,F7,00,7F,7F,7F
    10117 DATA FF,18,18,7E,7E,18,18,00
    10118 DATA 00,7E,7E,7E,7E,7E,7E,7E
    10119 DATA 5E,5E,7E,7E,7E,7E,7E,00
    10120 DATA 18,3C,C3,81,1C,C3,3C,18
    10121 DATA 14,3F,54,3E,15,15,7E,14
    10122 DATA FF,A5,FF,A5,A5,FF,A5,FF
    10123 DATA FF,5A,00,5A,5A,00,5A,00
    10124 DATA FF,C3,BD,5A,66,3C,81,D5
    10125 DATA 7E,BD,DB,E7,E7,DB,BD,7E





    1 'Definición de colores, los colores se definen a partir de la dirección 8192/&h2000'
    1 'Como la memoria se divide en 3 bancos, la parte de arriba en medio y la de abajo hay que ponerlos en 3 partes'
    10500 FOR I=0 TO (26*8)-1
        10520 READ A$
        10530 VPOKE 8192+I,VAL("&H"+A$): '&h2000'
        10540 VPOKE 10240+I,VAL("&H"+A$): '&h2800'
        10550 VPOKE 12288+I,VAL("&H"+A$): ' &h3000'
    10560 NEXT I


    10600 DATA E1,FE,FE,FE,FE,FE,FE,FE
    10601 DATA A1,EA,EA,EA,EA,EA,EA,EA
    10602 DATA F1,FE,FE,FE,FE,FE,FE,FE
    10603 DATA A1,A1,A1,A1,A1,A1,A1,A1
    10604 DATA A1,A1,A1,A1,A1,A1,A1,A1
    10605 DATA A1,E1,A1,A1,A1,A1,A1,A1
    10606 DATA A1,A1,A1,A1,A1,A1,E1,E1
    10607 DATA E1,E1,A1,A1,A1,A1,E1,E1
    10608 DATA E1,E1,A1,A1,A1,A1,E1,E1
    10609 DATA E1,E1,A1,A1,A1,A1,E1,E1
    10610 DATA A1,A1,A1,A1,A1,A1,E1,E1
    10611 DATA A1,A1,A1,A1,A1,A1,E1,E1
    10612 DATA E1,E1,A1,A1,A1,A1,A1,A1
    10613 DATA A1,E1,A1,A1,A1,A1,A1,A1
    10614 DATA A1,81,81,81,81,81,81,81
    10615 DATA 81,51,51,51,51,51,51,51
    10616 DATA 51,31,31,31,31,31,31,31
    10617 DATA F1,BF,BF,BF,BF,BF,BF,BF
    10618 DATA 11,91,71,71,71,71,91,91
    10619 DATA 91,91,91,91,91,91,91,91
    10620 DATA 7F,7F,75,75,85,75,7F,7F
    10621 DATA A1,A1,A1,A1,A1,A1,A1,A1
    10622 DATA D1,D9,D9,D9,D9,D9,D9,D9
    10623 DATA 61,D6,D6,D6,D6,D6,D6,D6
    10624 DATA A1,A6,A6,A6,A6,A6,A6,A6
    10625 DATA A6,A6,A6,A6,A6,A6,A6,A6

10690 return


1 '14336 / h3800 -> 16383 / 3fff
1 '(tamaño 2048 / h800)
1 'Tabla de patrones de sprites
    1 'En vasic base(14)
    1 'Aquí es donde se ponen los 8 bytes que componen tu sprite para definir su dibujo, con la
    1 'ayuda de la “tabla atributos de sprites” llamaremos a este bloque y le podremos su
    1 'posición en pantalla.


1 '12288 / h3000 -> 14335 / h37ff
1 'Tamaño: 2048 / h0800
1 'Tabla color tiles banco 2
    1 'Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
    1 '“tabla tiles banco 2” la tabla que representa a la parte superior de la pantalla
1 '10240 / h2800 -> 12287 / h2fff
1 'Tamaño: 2048 / h0800
1 'Tabla color tiles banco 1
    1 'Aquí se definen los bloques de 8 bytes que definen el color de lostiles definidos en la
    1 '“tabla tiles banco 1” la tabla que representa a la parte central de la pantalla
1 '8192 / h2000 ->10239 / h27ff
1 'Tamaño: 2048/ h0800
1 'Tabla color tiles banco 0
    1 'En basic base (11)
    1 'Aquí se definen los bloques de 8 bytes que definen el color de los tiles definidos en la
    1 '“tabla tiles banco 0” la tabla que representa a la parte inferior de la pantalla


1 'h1800 vacía
1 '6912 /h1b00 -> 7039 / h1b7f
1 'Tamaño 128 /h0080
1 'Tabla de atributos de Sprite (AOM)
    1 'En basic base(13)
    1 'Cada “atributo de Sprite” son 8 bytes que definen su bloque de 32 bits de la tabla
    1 '“patrones de sprite”,su posición x, y, color (los colores del sprite no tienen nada que ver
    1 'con los tiles)


1 '6144 / h1800 -> 6911 / h1aff
1 'Tamaño 768 / h0300
1 'Tabla mapa o nombres de tiles
    1 'En basic base(10)
    1 'Aquí es donde se pone el bloque de bytes que corresponde con el tile definido en la tabla
    1 '“tiles banco 0,1,2”


1 '4096 / h1000 -> 6148 /h17ff
1 'Tamaño: 2048 / h0800
1 'Tabla tiles banco 2
    1 'Lo mismo que banco 0 y banco 1 pero para el banco 2
1 '2048 / h0800 -> 4095 / h0fff
1 'Tamaño: 2048 /h0800
1 'Tabla tiles banco 1
    1 'Lo mismo que el tiles banco 0 pero para el banco 1
1 '0 / h0000 -> 2047 / h07ff
1 'Tamaño: 2048/h0800
1 'Tabla tiles banco 0
    1 'En basic base(12)
    1 'Aquíse definen los bloques de 8 bytes que definen 1 tile para la parte superior de la
    1 'pantalla de las 3 partes que tiene la pantalla (ejemplo 1) Este tile estará relacionado con
    1 'los 8 bytes del “Color tiles banco 0” y con la “tabla mapa” 







