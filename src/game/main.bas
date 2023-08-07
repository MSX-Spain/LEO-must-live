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
240 goto 100



1 'Fase 1'
1'--------
300 'gosub 11000:'se pinta el mapa de tiles y se inicializa
310 'se inicializan os enemigos, se pintan los objetos y el marcador'
320 'se inicializan las variables del player'
330 if x> 240 then goto 500 else goto 100
340 'pintamos los enemigos'
350 'Actualizamos los enemigos'
390 return 100

1 'Fase 2'
1'--------
500 'lo mismo que en la fase 1'
530 if x>240 then goto 700 else goto 100
540 'lo mismo que en la fase 1'
590 return 100

1 'Fase 3'
1'--------
700 'lo mismo que en la fase 1'
730 if x>240 then goto 900 else goto 100
740 'lo mismo que en la fase 1'
790 return 100

1 'Fase 4'
1'--------
900 'lo mismo que en la fase 1'
930 if x>240 then goto 1100 else goto 100
940 'lo mismo que en la fase 1'
990 return 100

1 'Fase 5'
1'--------
1100 'lo mismo que en la fase 1'
1130 if x>240 then goto 1300
1140 'lo mismo que en la fase 1'
1190 return 100

1 'Fase 6'
1'--------
1300 'lo mismo que en la fase 1'
1330 if x>240 then goto 1500 else goto 100
1340 'lo mismo que en la fase 1'
1390 return 100

1 'Fase 7'
1'--------
1500 'lo mismo que en la fase 1'
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


