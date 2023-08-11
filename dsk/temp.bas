1 'Color caracteres, fondo, borde'
10 cls:color 15,1,1:key off
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E, inicializamos el psg &h90'
1 '&h41 y &h44 Enlazamos con las rutinas de apagar y encender la pantalla'
20 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
30 screen 2,2,0
1 'Todas las variables serán enteras'
40 defint a-z
1 'Definimos un canal necesario para poder mostrar texto, habrá que poner en el print o input #1'
50 open "grp:" as #1
60 'bload"xbasic.bin",r
1 '2000 es la subrrutina para pintar un mensaje'
70 me$="^Loading sprites":gosub 2000
1 'cargamos los sprites en VRAM'
80 gosub 9000
90 me$="^Loading tileset":gosub 2000
1 'Cargamos los tiles'
100 gosub 10000 
1 '' ******************************
1 '' Program:  SAM must live
1 '' autor:    MSX spain
1 '' ******************************
1 '***************
1 '****Variables**
1 '***************
1 'f=fase'
1 'me$=mensaje'

1 'ts=solid tile, tile a partir que está el suelo'
1 'td=dead tile, tile que te matan'
1 't3,t5,t7=tile derecha, tile abajo y tile izquierda'

1 'x, y=player coordinates
1 'v=velocidad horizontal'
1 'o=old y position'
1 'a=player está saltando'
1 'p,p0,p1,p2,p3=sprite asignado que irá cambiando con los valores de p0 a p3'

1 'mp=mapa direction'
1 'dat=datos, usada para el restore de los datas'
1 'r, c=row and column for bucle'

1 '****************
1 '***Subrrutinas**
1 '****************
1 ' 9000 Rutina cargar sprites en VRAM con datas basic''


 
110 me$=""
120 f=1:ts=37:td=30
130 gosub 1800
140 x=0:y=9*8:v=4:P=0:P0=0:P1=1:P2=2:P3=3:PUTSPRITE0,(x,y),4,p
150 goto 500

1 'Main-loop'
    200 s=STICK(0)ORSTICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON s GOTO 230,250,270,290,310,330,350,370
    220 goto 400

    1 'movimiento hacia arriba o salto
    1 '130 Y=Y-4:IF Y<40 THEN Y=40
    1 '1 Pulsado la tecla 1 Saltamos y reproducimos un sonido'
    230 if a=0 and t5>=ts then o=y:a=1:GOTO 210
    240 GOTO 400
    1 '2 Pulsado 2 movimiento hacia arriba derecha o salto hacia arriba'
    250 X=X+4:if a=0 and t5>=ts then o=y:a=1
    1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    260 P=P0:SWAPP0,P1:GOTO 400
    1 '3 pulsado Movimiento hacia la derecha '
    270 X=X+v
    280 P=P0:SWAPP0,P1:GOTO 400
    1 '4 Movimiento abajo derecha'
    290 X=X+v
    300 P=P0:SWAPP0,P1:GOTO 400
    1 '5 Movimiento  abajo'
    310 'Y=Y+4:IFY>180THENY=180
    320 P=P0:SWAPP0,P1:GOTO 400
    1 '6 Moviemiento abajo izquierda'
    330 'Y=Y+4:X=X-4
    340 P=P2:SWAPP2,P3:GOTO 400
    1 '7 Movimiento izquierd'
    350 X=X-v
    360 P=P2:SWAPP2,P3:GOTO 400
    1 '8 movimiento arriba izquierda'
    370 X=X-v:if a=0 and t5>=ts then o=y:a=1
    380 P=P2:SWAPP2,P3


    1 'Chequeo colisiones pantalla'
    400 'IF Y<0 THEN Y=0 
    410 if x<0 then x=0 
    1 'Si el player está saltando, irá hacia arrina hasta -16'
    420 if a=1 then y=y-8:if y<o-16 then a=0
    1 'Si el player está cayendo
    430 if a=0 and t5<ts or t5=255 then y=y+8 
    1 'Actualizamos las variables con los tiles t1,t3,t5,t7'
    1 '     ^ t1  '
    1 '     |     '
    1 't7 <- -> t3'
    1 '     |     '
    1 '     v t5  '
    440 hl=base(10)+(((y/8)+1)*32)+((x/8)+1):t3=vpeek(hl)
    450 hl=base(10)+(((y/8)+2)*32)+((x/8)+1):t5=vpeek(hl)
    460 hl=base(10)+(((y/8)+1)*32)+((x/8)):t7=vpeek(hl)
    1 'Si t5 es el tile de la muerte td=dead tile, matamos al player
    470 if t5=td or t3=td or t7=td then gosub 4000
    475 if t3>=ts then x=x-v else if t7>=ts then x=x+v
    480 PUTSPRITE0,(X,Y),4,P
    1 '3000= debug'
    485 'gosub 3000
    490 ON f GOSUB 530,630,730,930,1130,1330,1530
495 goto 200




1 'Fase 1'
1'--------
1 'se pinta el mapa de tiles y se inicializa'
500 gosub 21000
510 'se inicializan os enemigos, se pintan los objetos y el marcador
520 goto 200
530 if X>=232 then goto 600
540 'pintamos los enemigos
550 'Actualizamos los enemigos
590 return 200

1 'Fase 2'
1'--------
600 f=2:x=0:y=9*8:gosub 21000
610 goto 200
630 if x>232 then goto 700
640 'lo mismo que en la fase 1
690 return 200

1 'Fase 3'
1'--------
700 f=3:x=0:y=9*8:gosub 21000
710 goto 200
730 if x>232 then goto 1700
740 'lo mismo que en la fase 1
790 return 200

1 'Fase 4'
1'--------
900 f=4:x=0:y=9*8:gosub 21000
910 goto 200
930 if x>240 then goto 1100 
940 'lo mismo que en la fase 1
990 return 200

1 'Fase 5'
1'--------
1100 f=5:x=0:y=9*8:gosub 21000
1110 goto 200
1130 if x>240 then goto 1300
1140 'lo mismo que en la fase 1
1190 return 200

1 'Fase 6'
1'--------
1300 f=6:x=0:y=9*8:gosub 21000
1310 goto 200
1330 if x>240 then goto 1500 
1340 'lo mismo que en la fase 1
1390 return 200

1 'Fase 7'
1'--------
1500 f=7:x=0:y=9*8:gosub 21000
1510 goto 200
1530 if x>240 then goto 1700
1590 return 200


1' Pantalla ganadora
    1700 me$="^Tu ganas":gosub 2000
    1710 ON STRIG GOSUB 1790:STRIG(0)ON
    1720 GOTO 1720
1790 STRIG(0)OFF:RETURN 110

1 ' menu principal'
    1800 me$="^menu pricipal, pulse una tecla":gosub 2000
    1810 ON STRIG gosub 1890:STRIG(0)ON
    1820 GOTO 1820
1890 STRIG(0)OFF:RETURN 140

1 'HUD'
    2000 line(0,140)-(255,150),1,bf
    2010 preset (0,140):print #1,me$
2020 return

1 'debug'
    3000 line(0,160)-(200,180),1,bf
    3010 preset (0,160):print #1,t3
    1 '3010 preset (0,160):print #1,"t0: "t0", t3:"t3", t5:"t5
    1 '3020 preset (0,170):print #1," x: "x" ,y: "y
    1 '3010 preset (0,160):print #1,"a: "a" ,o: "o" y: "y", -: "o-16
3090 return

1 'Player muere'
4000 x=0:y=9*8
4090 return


1 'Vamos a crear nuestro mapa con una pantalla de 20 tiles de alto x 32 de ancho dehjando los 4 de abajo para el marcador'
1 'Render map, pintar mapa
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
    1 'El mapa se encuentra en la dirección 6144 / &h1800 - 6912 /1b00'
    21000 md=6144
    21010 on f goto 21020,21030,21040
    21020 restore 22000:goto 21050
    21030 restore 22200:goto 21050
    21040 restore 22400
    1 '21050 for r=0 to 15
    1 '    21060 READ mp$
    1 '    1 ' ahora leemos las columnas c
    1 '    21070 for c=0 to 63 step 2
    1 '        21080 tn$=mid$(mp$,c+1,2)
    1 '        21090 tn=val("&h"+tn$):tn=tn-1
    1 '        21100 if tn<>0 and tn<>-1 then VPOKE md,tn
    1 '        21110 md=md+1
    1 '    21160 next c
    1 '21180 next r


    1 'Compresión RLE-16'
    21050 for r=0 to 15
        21060 READ mp$
        21070 for c=0 to len(mp$)-1 step 4
            1 'El 1 valor indica la cantidad de repeticiones, el 2 el valor en si'
            21080 r$=mid$(mp$,c+1,2)
            21090 tn$=mid$(mp$,c+3,2)
            21100 tn=val("&h"+tn$):tn=tn-1
            21110 re=val("&h"+r$)
            21120 for i=0 to re
                21130 if tn<>0 and tn<>-1 then VPOKE md,tn
                21140 md=md+1
            21150 next i
        21160 next c
    21180 next r

        

    21185 me$=str$(f):gosub 2000
21190 return
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Level 1------------------------------------------'
1 '--------------------------------------------------------------------------------------'

1 'Compresión RLE16'
22000 data 1f23
22010 data 1f23
22020 data 1f23
22030 data 1f23
22040 data 1f23
22050 data 1f23
22060 data 1f23
22070 data 1f23
22080 data 1f23
22090 data 142301480823
22100 data 112301480b23
22110 data 0e230148062301480523
22120 data 1f23
22130 data 112707000527
22140 data 112507000525
22150 data 1125071f0525
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Level 2------------------------------------------'
1 '--------------------------------------------------------------------------------------'

22200 data 1f24
22210 data 1f24
22220 data 1f24
22230 data 1f24
22240 data 1f24
22250 data 132401450924
22260 data 10240145002401450924
22270 data 0d24014500240145002401450924
22280 data 0a2401450024014500240145002401450924
22290 data 07240145002401450024014500240145002401450924
22300 data 05240345001f0145001f0145001f0145001f0145011f0724
22310 data 032413450724
22320 data 1f41
22330 data 1f4a
22340 data 1f4a
22350 data 1f4a
1 '--------------------------------------------------------------------------------------'
1 '-------------------------------------Level 3------------------------------------------'
1 '--------------------------------------------------------------------------------------'

22400 data 1f23
22410 data 1f23
22420 data 1f23
22430 data 0d230248002303480923
22440 data 1f23
22450 data 0a2302481123
22460 data 0e2302480d23
22470 data 122302480923
22480 data 1f23
22490 data 11230148021f0823
22500 data 10230348011f0823
22510 data 0b230248001f0448011f0823
22520 data 1f26
22530 data 1f22
22540 data 1f22
22550 data 1f22



 
1 'En este archivo se cargar los sprites y el tileset
    1'Ponemos todos los sprites en la posición y 212 (abajo)
    9000 for i=0 to 31: put sprite i,(0,212),0,0:next i
    1 'Rutina cargar sprites en VRAM con datas basic'
    1 '9000 for i=0 to 5:sp$=""
    1 '    9220 for j=0 to 31
    1 '        9230 read a$
    1 '        9240 sp$=sp$+chr$(val(a$))
    1 '    9250 next J
    1 '    9260 sprite$(i)=sp$
    1 '9270 next i
    9010 'call turbo on
    9020 for i=0 to (32*5)-1
        9030 read b:vpoke 14336+i,b
    9040 next i
    9050 'call turbo off
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
    10000 'call turbo on
    1 'Ponemos que en la parte del mapa solo se vea el ultimo tile, dejamos el 3 tercio sin tocar para el marcador
    1 'en realidad la tabla de nombres son 768 bytes'
    10005 FOR t=6144 TO (6144+768)-256
        10010 vpoke t,255
    10020 next t


    1' Hay que recordar la estructura de la VRAM, el tilemap se divide en 3 zonas
    1 'Nuestro tileset son X tiles o de 0 hasta el X-1'
    1 'Definiremos a partir de la posición 0 de la VRAM 18 tiles de 8 bytes'
    10030 restore 10040:FOR I=0 TO (79*8)-1
        10035 READ A$
        10036 VPOKE I,VAL("&H"+A$)
        10037 VPOKE 2048+I,VAL("&H"+A$)
        1 '10042 VPOKE 4096+I,VAL("&H"+A$)
    10038 NEXT I




    10040 DATA E7,40,20,7E,3C,18,00,00
    10050 DATA 18,3C,3C,18,00,56,56,74
    10060 DATA 00,06,0A,14,20,30,48,00
    10070 DATA 00,00,00,08,10,20,40,00
    10080 DATA 00,00,00,18,2C,2C,18,00
    10090 DATA 00,18,3C,42,42,42,42,00
    10100 DATA 04,08,18,3C,3C,3C,3C,00
    10110 DATA 00,3E,22,3E,00,08,08,00
    10120 DATA 08,14,2A,08,08,08,08,00
    10130 DATA 00,04,02,7D,02,04,00,00
    10140 DATA 00,20,40,BE,40,20,00,00
    10150 DATA 10,10,10,54,28,10,00,00
    10160 DATA 00,00,00,00,00,00,00,00
    10170 DATA 00,00,00,00,00,00,00,00
    10180 DATA 00,00,00,00,00,00,00,00
    10190 DATA 00,00,00,00,00,00,00,00
    10200 DATA 00,00,00,00,00,00,00,00
    10210 DATA 00,00,00,00,00,00,00,00
    10220 DATA 00,00,00,00,00,00,00,00
    10230 DATA 00,00,00,00,00,00,00,00
    10240 DATA 00,00,00,00,00,00,00,00
    10250 DATA 00,00,00,00,00,00,00,00
    10260 DATA 00,00,00,00,00,00,00,00
    10270 DATA 00,00,00,00,00,00,00,00
    10280 DATA 00,00,00,00,00,00,00,00
    10290 DATA 00,00,00,00,00,00,00,00
    10300 DATA 00,00,00,00,00,00,00,00
    10310 DATA 00,00,00,00,00,00,00,00
    10320 DATA 00,00,00,00,00,00,00,00
    10330 DATA 00,00,00,00,00,00,00,00
    10340 DATA 44,44,EE,EE,44,44,44,44
    10350 DATA 00,00,00,00,00,00,00,00
    10360 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10370 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10380 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10390 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10400 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10410 DATA FF,FF,52,00,10,24,00,00
    10420 DATA FF,FF,52,00,08,20,00,00
    10430 DATA 54,38,10,10,10,10,10,10
    10440 DATA FF,00,7E,00,24,00,24,00
    10450 DATA 7E,24,24,24,24,24,24,24
    10460 DATA 7E,00,24,00,24,18,00,00
    10470 DATA 24,81,FF,00,00,00,00,00
    10480 DATA 12,8A,A8,A0,A0,80,80,00
    10490 DATA 51,00,00,00,00,00,00,00
    10500 DATA 51,00,00,00,00,00,00,00
    10510 DATA 54,55,15,05,05,01,01,00
    10520 DATA 00,00,00,00,00,00,00,00
    10530 DATA FF,00,3F,00,1F,00,07,00
    10540 DATA FF,00,FF,00,FF,00,FF,00
    10550 DATA FF,00,FC,00,F8,00,E0,00
    10560 DATA 00,00,00,00,00,00,00,00
    10570 DATA 00,00,00,00,00,00,00,00
    10580 DATA 00,00,00,00,00,00,00,00
    10590 DATA 00,00,00,00,00,00,00,00
    10600 DATA 00,00,00,00,00,00,00,00
    10610 DATA 00,00,00,00,00,00,00,00
    10620 DATA 00,00,00,00,00,00,00,00
    10630 DATA 00,00,00,00,00,00,00,00
    10640 DATA 00,00,00,00,00,00,00,00
    10650 DATA 00,00,00,00,00,00,00,00
    10660 DATA 00,00,00,00,00,00,00,00
    10670 DATA 00,00,00,00,00,00,00,00
    10680 DATA FB,FB,00,DF,DF,00,FB,FB
    10690 DATA DF,DF,00,FB,FB,00,00,FB
    10700 DATA 00,DF,DF,00,FB,FB,00,DF
    10710 DATA FB,00,DF,DF,00,FB,FB,FB
    10720 DATA 00,F7,F7,F7,00,7F,7F,7F
    10730 DATA 00,F7,F7,F7,00,7F,7F,7F







    1 'Definición de colores, los colores se definen a partir de la dirección 8192/&h2000'
    1 'Como la memoria se divide en 3 bancos, la parte de arriba en medio y la de abajo hay que ponerlos en 3 partes'
    13000 restore 17740:FOR I=0 TO (79*8)-1
        13010 READ A$
        13020 VPOKE 8192+I,VAL("&H"+A$): '&h2000'
        13030 VPOKE 10240+I,VAL("&H"+A$): '&h2800'
        1 'rem 13040 VPOKE 12288+I,VAL("&H"+A$): ' &h3000'
    13050 NEXT I


    
   
    17740 DATA 81,F8,F8,81,81,81,81,81
    17750 DATA B1,B1,B1,B1,B1,81,81,81
    17760 DATA 81,E1,E1,E1,61,61,61,61
    17770 DATA 61,61,61,61,61,61,61,61
    17780 DATA 61,61,61,21,21,21,21,21
    17790 DATA 21,21,21,2C,2C,2C,2C,11
    17800 DATA D1,D1,91,91,91,91,D1,D1
    17810 DATA D1,B1,B1,B1,B1,A1,A1,A1
    17820 DATA 81,81,81,81,81,81,81,81
    17830 DATA 81,81,81,81,81,81,81,81
    17840 DATA 81,81,81,81,81,81,81,81
    17850 DATA 81,81,81,81,81,81,81,81
    17860 DATA 81,81,81,81,81,81,81,81
    17870 DATA 81,81,81,81,81,81,81,81
    17880 DATA 81,81,81,81,81,81,81,81
    17890 DATA 81,81,81,81,81,81,81,81
    17900 DATA 81,81,81,81,81,81,81,81
    17910 DATA 81,81,81,81,81,81,81,81
    17920 DATA 81,81,81,81,81,81,81,81
    17930 DATA 81,81,81,81,81,81,81,81
    17940 DATA 81,81,81,81,81,81,81,81
    17950 DATA 81,81,81,81,81,81,81,81
    17960 DATA 81,81,81,81,81,81,81,81
    17970 DATA 81,81,81,81,81,81,81,81
    17980 DATA 81,81,81,81,81,81,81,81
    17990 DATA 81,81,81,81,81,81,81,81
    18000 DATA 81,81,81,81,81,81,81,81
    18010 DATA 81,81,81,81,81,81,81,81
    18020 DATA 81,81,81,81,81,81,81,81
    18030 DATA 81,81,81,81,81,81,81,81
    18040 DATA B1,A1,A1,A1,81,81,81,81
    18050 DATA 81,81,81,81,81,81,81,81
    18060 DATA 91,91,91,91,91,91,91,91
    18070 DATA 31,31,31,31,31,31,31,31
    18080 DATA 71,71,71,71,71,71,71,71
    18090 DATA B1,B1,B1,B1,B1,B1,B1,B1
    18100 DATA E1,E1,E1,E1,E1,E1,E1,E1
    18110 DATA 21,21,23,23,23,23,23,23
    18120 DATA 91,91,9E,9E,9E,9E,9E,9E
    18130 DATA 91,61,61,61,61,61,61,61
    18140 DATA 91,91,61,61,61,61,61,61
    18150 DATA 91,61,61,61,61,61,61,61
    18160 DATA 91,91,61,61,61,61,61,61
    18170 DATA 79,91,91,91,91,91,91,91
    18180 DATA 75,51,51,51,51,51,51,51
    18190 DATA 75,11,11,11,11,11,11,11
    18200 DATA 35,11,11,11,11,11,11,11
    18210 DATA 75,51,51,51,51,51,51,51
    18220 DATA 51,51,51,51,51,51,51,51
    18230 DATA 51,51,51,51,51,51,51,51
    18240 DATA 51,51,51,51,51,51,51,51
    18250 DATA 51,51,51,51,51,51,51,51
    18260 DATA 51,51,51,51,51,51,51,51
    18270 DATA 51,51,51,51,51,51,51,51
    18280 DATA 51,51,51,51,51,51,51,51
    18290 DATA 51,51,51,51,51,51,51,51
    18300 DATA 51,51,51,51,51,51,51,51
    18310 DATA 51,51,51,51,51,51,51,51
    18320 DATA 51,51,51,51,51,51,51,51
    18330 DATA 51,51,51,51,51,51,51,51
    18340 DATA 51,51,51,51,51,51,51,51
    18350 DATA 51,51,51,51,51,51,51,51
    18360 DATA 51,51,51,51,51,51,51,51
    18370 DATA 51,51,51,51,51,51,51,51
    18380 DATA E1,E1,E1,A1,A1,A1,E1,E1
    18390 DATA E1,E1,E1,A1,A1,A1,A1,A1
    18400 DATA A1,81,81,81,51,51,51,81
    18410 DATA 81,81,51,51,51,81,81,81
    18420 DATA 81,81,81,81,81,81,81,81
    18430 DATA 81,51,51,51,51,51,51,51
    18440 DATA 51,31,31,31,31,31,31,31
    18450 DATA E1,51,E1,51,E1,51,E1,51
    18460 DATA E1,51,E1,51,E1,51,E1,51
    18470 DATA E1,FE,FE,FE,FE,FE,FE,FE
    18480 DATA A1,EA,EA,EA,EA,EA,EA,EA
    18490 DATA F1,FE,FE,FE,FE,FE,FE,FE
    18500 DATA 11,11,11,11,11,11,11,11
    18510 DATA 11,11,11,11,11,11,11,11
    18520 DATA 11,11,11,11,11,11,11,11
    18530 DATA 11,11,11,11,11,11,11,11



    20170 'call turbo off
20190 return


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







