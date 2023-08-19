1 '' ******************************
1 '' Program:  SAM must live
1 '' autor:    MSX spain
1 '' ******************************
1 '***************
1 '****Variables**
1 '***************
1 'f=fase'
1 'me$=mensaje'
1 'mc=counter map, para ir pintando el mapa con los tiles'
1 'ml=limit map, el ancho del mapa'
1 'ig=in game, nos permite saber si el juego está corriendo'

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


120 f=1:ts=37:td=30:mc=0:ml=60:dim m(100,16)
1 'inicializamos el array con el mapa de tiles'
125 gosub 20200
1 'Mostramos la pantalla de bienvenida'
130 gosub 1800
140 x=0:y=9*8:v=8:P=0:P0=0:P1=1:P2=2:P3=3:P4=4:P5=5:PUTSPRITE0,(x,y),4,p
150 time=0:tw=0
160 goto 500

200 'Main loop'
    200 s=STICK(0)ORSTICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON s GOTO 230,250,270,290,310,330,350,370
    220 goto 400
    1 'movimiento hacia arriba o salto
    230 Y=Y-4
    1 '1 Pulsado la tecla 1 Saltamos y reproducimos un sonido'
    1 '230 if a=0 and t5>=ts then o=y:a=1:GOTO 210
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
    310 Y=Y+4
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
    400 PUTSPRITE0,(X,Y),4,P

    420 gosub 21000
    430 if mc=ml then print #1, "fase completada": goto 1800
500 goto 200




















1 ' menu principal'
    1800 me$="^menu pricipal, pulse una tecla":gosub 2000
    1810 ON STRIG gosub 1890:STRIG(0)ON
    1820 GOTO 1820
1890 STRIG(0)OFF:RETURN 140


1 'HUD'
    2000 line(0,140)-(255,150),1,bf
    2010 preset (0,140):print #1,me$
2090 return







1 'Compresión RLE-16'
    20200 restore 22000
    20205 for r=0 to 15
        20210 READ mp$:po=0
        20220 for c=0 to len(mp$) step 4
            1 'El 1 valor indica la cantidad de repeticiones, el 2 el valor en si'
            20230 r$=mid$(mp$,c+1,2)
            20240 tn$=mid$(mp$,c+3,2)
            20250 tn=val("&h"+tn$):tn=tn-1
            20260 re=val("&h"+r$)
            20270 for i=0 to re
                20280 if tn<>0 and tn<>-1 then m(po,r)=tn:po=po+1
            20300 next i
        20310 next c
    20320 next r
20330 return

1 'ponemos en la tabla nombres los tiles
    21000 _TURBO ON (m(),mc)
    21001 restore 22000
    21002 mc=mc+1
    21005 md=6144
    21010 for f=0 to 15
        1 ' ahora leemos las columnas c, 63 son 32 tiles
        21020 for c=mc to 31+mc
            21030 tn=m(c,f)
            21040 VPOKE md,tn
            21050 md=md+1
        21060 next c
    21070 next f
    21080 _TURBO OFF


    22000 data 1b230125022300250623012515230125002306250e2300250023012501230325
    22010 data 1223012506230125012301250623012503230125002301250c2309250123002506230125012301250023012501230325
    22020 data 002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
    22030 data 00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
    22040 data 0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012500230425
    22050 data 00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500230425
    22060 data 6325
    22070 data 6321
    22080 data 41210045142100470a21
    22090 data 1d21234800450221114800470a21
    22100 data 1d2100480d210048132100450221004810210047072101480021
    22110 data 02211b480d210e4809211c480021
    22120 data 1d2100480b2100460e2100480921004805210047122101480021
    22130 data 1d2100480821024800460e21114800471521
    22140 data 1d210a4801210046202100471521
    22150 data 4c2100471521

23190 return 