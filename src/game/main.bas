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



