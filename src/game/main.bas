80  X=5:Y=80:G=1:P=0:P0=0:P1=1:P2=2:P3=3



100 S=STICK(0)ORSTICK(1)
110 ON S GOTO 130,140,150,160,170,180,190,200
120 goto 215

1'1 movimiento hacia arriba o salto
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
1 '6Moviemiento abajo izquierda'
    180 Y=Y+4:X=X-4:IF Y>100 THEN Y=100
    181 IF X<4 THEN X=4
    182 P=P2:SWAPP2,P3:GOTO 210

    190 X=X-4:IFX<4THENX=4
    192 P=P2:SWAPP2,P3:GOTO 210

    200 Y=Y-4:X=X-4:IFY<40THENY=40
    201 IFX<4THENX=4
    202 P=P2:SWAPP2,P3

    210 PUTSPRITE0,(X,Y),4,P


    215 IF POINT(X+4,Y+14)=5 THEN GOSUB 5060
    216 IF POINT(X+12,Y+10)=5 THEN GOSUB 5060
    217 GOTO 230
    230 ON F GOSUB 330,530,730,930,1130,1330,1530



5060 'Sistema de colisiones
5066 RETURN


330 goto 100
530 goto 100
730 goto 100
930 goto 100
1130 goto 100
1330 return 100
1530 return 100