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


80 X=5:Y=12*8:G=1:P=0:P0=0:P1=1:P2=2:P3=3:PUTSPRITE0,(X,Y),4,P
81 me$=""
85 f=1
90 goto 300

1 'Main-loop'
    100 S=STICK(0)ORSTICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    110 ON S GOTO 130,140,150,160,170,180,190,200
    120 goto 210

    1 'movimiento hacia arriba o salto
    1 '130 Y=Y-4:IF Y<40 THEN Y=40
    1 'Pulsado la tecla 1 Saltamos y reproducimos un sonido'
    130 if pa<>1 then po=py:pa=1
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
    1 '8'
    200 Y=Y-4:X=X-4:IFY<40THENY=40
    201 IFX<4THENX=4
    202 P=P2:SWAPP2,P3

    1 'Pintamos al player'
    210 PUTSPRITE0,(X,Y),4,P
    211 'line(0,50)-(50,60),15,bf
    212 'preset (0,160):print #1,"holaaaaaa"X
  
    1 '213 gosub 5060
    214 'gosub 2000
    215 'IF POINT(X+4,Y+14)=5 THEN GOSUB 5060
    216 'IF POINT(X+12,Y+10)=5 THEN GOSUB 5060

    230 ON f GOSUB 330,530,730,930,1130,1330,1530
    240 'preset (0,60):print #1,f
250 goto 100




1 'Fase 1'
1'--------
300 gosub 21000:'se pinta el mapa de tiles y se inicializa
310 'se inicializan os enemigos, se pintan los objetos y el marcador
320 goto 100
330 if X> 240 then f=2:goto 500
340 'pintamos los enemigos
350 'Actualizamos los enemigos
390 return 100

1 'Fase 2'
1'--------
500 preset(0,70):print #1,"level 2"
510 goto 100
530 if x>240 then f=3:goto 700
540 'lo mismo que en la fase 1
590 return 100

1 'Fase 3'
1'--------
700 preset(0,70):print #1,"level 3"
730 if x>240 then f=4:goto 900
740 'lo mismo que en la fase 1
790 return 100

1 'Fase 4'
1'--------
900 'lo mismo que en la fase 1
930 if x>240 then goto 1100 else goto 100
940 'lo mismo que en la fase 1
990 return 100

1 'Fase 5'
1'--------
1100 'lo mismo que en la fase 1
1130 if x>240 then goto 1300
1140 'lo mismo que en la fase 1
1190 return 100

1 'Fase 6'
1'--------
1300 'lo mismo que en la fase 1
1330 if x>240 then goto 1500 else goto 100
1340 'lo mismo que en la fase 1
1390 return 100

1 'Fase 7'
1'--------
1500 'lo mismo que en la fase 1
1530 if x>240 then goto 80 else goto 100
1590 return 100


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


2000 'line(0,0)-(200,8),15,bf
2010 preset (0,140):print #1,a

1 'Colisiones del player con el mapa'
    1 'Para detectar la colisión vemos el valor que hay en la tabla de nombres de la VRAM
    1 'En la posición x e y de nuestro player con la formula: '
    1 'Si hay una colision le dejamos la posicion que guardamos antes de cambiarla por pulsar una tecla'
    5060 hl=base(10)+((y/8)+1)*32+((x/8)+1):a=vpeek(hl)
    5065 'preset (0,0):print #1,a
    1 'Si el valor es igual a 244 (nuestro ladrillo) ponemos los valores que tenía antes de pulsar el cursor'
    5070 if a=25 then beep
    5080 'if a<>20 then y=y+1
5090 return
1 'Vamos a crear nuestro mapa con una pantalla de 20 tiles de alto x 32 de ancho dehjando los 4 de abajo para el marcador'
1 'Render map, pintar mapa
    1 'la pantalla en screen 2:


    1 'Lectora de mapa con un dígito'
    1 '11020 for f=0 to 19
    1 '    11030 READ D$
    1 '    11040 for c=0 to 31
    1 '        11050 tn$=mid$(D$,c+1,1)
    1 '        11060 tn=val(tn$)
    1 '        11070 VPOKE md+c,tn
    1 '    11160 next c
    1 '    11170 md=md+32
    1 '11180 next f
    1 'Lectura de mapa con 2 dígitos'
    1 'El mapa lo he dibujado con tilemap con 20x20 tiles de 8 pixeles'
    21000 'gosub 6600
    1 'El mapa se encuentra en la dirección 6144 / &h1800 - 6912 /1b00'
    21010 md=6144
    21020 restore 22000:for f=0 to 15
        21030 READ mp$
        1 ' ahora leemos las columnas c
        21040 for c=0 to 63 step 2
            21050 tn$=mid$(mp$,c+1,2)
            21060 tn=val("&h"+tn$):tn=tn-1
            21070 if tn<>0 and tn<>-1 then VPOKE md,tn
            21080 md=md+1
        21160 next c
        1 'Bajamos la fila'
        21170 'md=md+12
    21180 next f
21190 return
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Mundo 1------------------------------------------'
1 '--------------------------------------------------------------------------------------'

22000 data 2323232323232323232323232323232323232323232323232323232323232323
22010 data 2323232323232323232323232323232323232323232323232323232323232323
22020 data 2323232323232323232323232323232323232323232323232323232323232323
22030 data 2323232323232323232323232323232323232323232323232323232323232323
22040 data 2323232323232323232323232323232323232323232323232323232323232323
22050 data 2323232323232323232323232323232323232323232323232323232323232323
22060 data 2323232323232323232323232323232323232323232323232323232323232323
22070 data 2323232323232323232323232323232323232323232323232323232323232323
22080 data 2222222222222222222222222222222222222222222222222222222222222222
22090 data 2222222222222222222222222222222222222222222222222222222222222222
22100 data 2222222222222222222222222222222222222222222222222222222222222222
22110 data 2222222222222222222222222222222222222222222222222222222222222222
22120 data 2222222222222222222222222222222222222222222222222222222222222222
22130 data 2222222222222222222222222222222222222222222222222222222222222207
22140 data 1414141414141414141414141414141400001414141400001414141414141414
22150 data 1414141414141414141414141414141400001414141400001414141414141414
