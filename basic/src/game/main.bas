1 '' ******************************
1 '' Program:    Leo must live :mechanical_arm:
1 '' Autor:      MSX spain 2024
1 '' Repository: https://github.com/MSX-Spain/LEO-must-live :eyes:  
1 '' ******************************

1 'Sobre los mapas:
1 'En la última versión se ha escogido 120 patrones de 8px de ancho por 16 de alto, es decir 960 px de acho por 128 px de alto'
1 'Si suponemos que una pantalla son 32 patrones de ancho o 256 px diremos que en cada pantalla se crean 3,75 pantallas cada vez que se carga una.'
1 'En total son el menu + los 5*3.75 niveles=18.75 + el final= 20,75 pantallas'

1 '***************
1 '****Variables**
1 '***************

1 '****Variables del juego*****'
1 'm()=mapa, se utiliza como buffer para almacenar los datas y hacer un pintado y detector de colisión rápido'
1 'd=mapa direction, dirección en la memoria vram'
1 'mp$, r$, tn$, tn, re=variables solo utilizadas en imprimir pantalla para el manejo de strings '
1 'r, c=row and column for bucle help, solo utilizadas en imprimir pantalla'
1 'f=file, indica a la subrrutina pintar pantalla (20200) por que fila debe de empezar a pintar, terminará de pintar en f+8'
1 'sc=fase o screen'
1 'sl=screen limit, cuando lleguemos a screen lmit mostraremos el mensaje de juego completado y volveremos al principio'
1 'me$=mensaje'
1 'n=number,counter map, irá aumentando según vayamos avanzando en el mapa para pintar otros márgenes de la pantalla ayudándonos del array'
1 'w=width,limit map, el ancho del mapa, cuando lleguemos al final mapa no se repintará'
1 's$=puntuación en string, solo aparece en la subrrutina impimir HUD'
1 'ls=lengh score=para ver la cantidad de caractéres y así poder imprimir los tiles de la puntuación, solo parace en imprimir HUD'
1 'mu= músic'

1 'ts=solid tile, tile a partir que está el suelo'
1 'td()=dead tiles, tiles que te matan'
1 'tm=tile money, monedas que se pueden cocger para ganar puntos'
1 'tf=tile floor, camino por donde debe ir el player'
1 't0,t3,t5,t7=t0:tile sobre el que estamos,t3:tile derecha, t5:tile abajo y t7:tile izquierda'

1 'x, y=player coordinates
1 'v=velocidad horizontal'
1 'h=velocidad vertical
1 'l=lives, vidas
1 's=score, puntuación, irá aumentando según vayas cogiendo monedas'
1 'p,p0,p1,p2,p3=sprite asignado que irá cambiando con los valores de p0 a p3'
1 'px y py=solo aparece en las líneas 420 y 440 para hacer cálculos del tile que ocupa el player en la pantalla'

1 'x(n) posición x del enemigo'
1 'y(n) posición y del enemigo'
1 'v(n) velocidad horizontal enemigo'
1 'c(n) enemy counter, contador utilizado para mostrar el sprite en un rango de valores de la variable n'
1 'p(n) enmy sprite, utilizada para determinar cual es el sprite del enemigo, trabajo junto a las variables del e1 al e6'
1 'e1,e2,e3,e4,e5,e6 para hacer las animaciones del enemigo, trabaja con p(0)
1 '****************
1 '***Subrrutinas**
1 '****************

1 ' 9000-9990 Rutina cargar sprites en VRAM con datas basic''
1 ' 10000-18990 Rutina cargar la definición y colores de tiles en screen 2'
1 ' 19000-19090 Rutina borrar pantalla'
1 ' 200 -690 Main loop'
    1 'Captura de teclado y actualización player'
    1 'Chequeo de colisiones'
    1 'Render'
    1 'Chequeo del juego'
1 ' 2000-2090 Imprimir mensajes sin pausa''
1 ' 2100-2190 Imprimir mensajes con pausa (necesita que esté inicializada me$)''
1 ' 2200-2290 Imprimir HUD'
1 ' 3000-3090 Player muere''
1 ' 3500-3599 Inicializar música'
1 ' 4000-4199 Reproductor de música'
1 ' 20000-20090 Rutina cambio de nivel o pantalla'
1 ' 20200-20330 Cargar array con compresión RLE-16'
1 ' 21000-21090 Pintar pantalla, ponemos en la tabla nombres los tiles'

100 dim m(120,16):dim x(3):dim y(3):dim v(3):dim c(3):dim p(3)
1 'el ancho de cada nivel son 120 tiles-32=88, 88 son los que tiene que hacer el scroll'
110 f=0:sc=1:sl=6:td=48:tm=6:tf=32:n=0:w=88:t0=0
120 x=0:y=9*8:v=8:h=8:l=9:s=0:p=0:p0=0:p1=1:p2=2:p3=3:p4=4:p5=5
122 e1=8:e2=9:e3=10:e4=11:e5=12:e6=13
1 ' Inicializamos la música'
123 gosub 3500
1 'Cargamos los tiles del menu'
1 'Inicializamos el array con el menú, importante colocar el puntero de los datas al principio (rutina 20200)'
125 restore 21000: gosub 20200
1 'Pintamos toda la pantalla
130 gosub 20800
1 'reproducimos la música del intro'
132 co=0:me$="^Music playing, please wait":gosub 2000:mu=1: gosub 4000
1 'Mostramos la pantalla de bienvenida con pausa'
135 me$="^Main menu, press space key":gosub 2000
1 'Repetimos la música mientras no se pulse una tecla'
137 if inkey$="" then co=co+1:if co>800 then goto 132 else goto 137
1 'Almacenamos en el array el level 1'
140 gosub 20200
1 'Pintamos el fondo del HUD'
1 'Pintamos el marco'
1 'Para calcular el último tercio del mapa, 6144+256+256=6656
1 'la 2 fila sería 6656+32=6688'
1 'la 3 fila sería 6656+(32*2)=6720'
145 for i=0 to 31: vpoke 6656+i,39:next i 
150 VPOKE 6688,39:VPOKE 6719,39:VPOKE 6720,39:VPOKE 6751,39:VPOKE 6752,39:VPOKE 6783,39
1 'Pintamos el corazón de las vidas'
155 VPOKE 6690,0
1 'Pintamos la casa que indica la pantalla en la que estamos'
160 VPOKE 6696,1
1 'Pintamos el signo de puntuación para los puntos de las mnedas cogidas'
165 VPOKE 6702,2
170 for i=0 to 31: vpoke 6784+i,39:next i 
1 'Pintamos el marcador'
175 gosub 2200
1 'Pintamos al player'
190 put sprite 0,(x,y),15,p
195 mu=7:gosub 4000
1 'Pintamos toda la pantalla
196 gosub 20800
1 'Mostramos un mensaje sin pausa'
197 me$="^Press space key to start":gosub 2100
1 'Cuando haya una colisión de sprites el player muere'
198 ON SPRITE GOSUB 3000:sprite on
1 'Inicializamos los enemigos del 1 level '
199 gosub 6000
1 'Juego con el on interval
1 'on interval=40 gosub 700:interval on'

1 'Debug'
1 '199 strig(0) on:on strig gosub 5000:me$="^Press space to jump":gosub 2000

1 'Main loop :loop:'
    1 'time incrementa en 1 cada vez que el vdp genera una interrupción, es decir en 1 segundo hace 60 incrementos'
    1 'debug time'
        1 '200 time=0:j=STICK(0) OR STICK(1)
    200 j=STICK(0) OR STICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON j GOTO 230,250,270,290,310,330,350,370
    220 p=p0:if n<w then swap p0,p1:goto 400 else goto 400
    1 'movimiento hacia arriba 
    1 'Ponemos el sprite correspondiente que mira hacia arriba que irá alternando ente 2 sprites'
    230 y=y-h:o=o-8:p=p4:swap p4,p5:goto 400
    1 '2 Pulsado 2 movimiento hacia arriba derecha 
    1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    250 x=x+v:o=o-8:y=y-h:p=p0:swap p0,p1:goto 400
    1 '3 pulsado Movimiento hacia la derecha '
    270 x=x+v:p=p0:swap p0,p1:goto 400
    1 '4 Movimiento abajo derecha'
    290 x=x+v:o=o+8:y=y+h:p=p0:swap p0,p1:goto 400
    1 '5 Movimiento abajo'
    310 y=y+h:o=o+8:p=p4:swap p4,p5:goto 400 
    1 '6 Movimiento abajo izquierda'
    330 x=x-v-4:o=o+8:y=y+h:p=p2:swap p2,p3:goto 400
    1 '7 Movimiento izquierda'
    350 x=x-v-4:p=p2:swap p2,p3:goto 400
    1 '8 movimiento arriba izquierda'
    370 x=x-v-4:o=o-8:y=y-h:p=p2:swap p2,p3:goto 400

    1 'Locura salto :skull:
    1 ':stuck_out_tongue:Por favor, no intentes entender esto, te puede transtornar la cabeza
    400 if a=0 then goto 500
    410 if o>104 then o=104 else if o<48 then o=48:a=2:o=o-8
    420 if y>o then a=2 else if a=1 then y=y-8
    430 if y<o-16 then a=2
    440 if a=2 then y=y+8:if y>=o then a=0:PUTSPRITE 1,(0,212),1,7
    450 if a>0 then PUTSPRITE 1,(x,o),1,7
    1 'Fin de loscura salto :cold_sweat:'
  

    1 'Chekeo de límites'
    500 IF y<48 THEN y=48 else if y>112 then y=112
    510 if x<0 then x=0 else if x>250 then x=250

    1 'Render :framed_picture:'
    1 '520 vpoke 6912,y:vpoke 6913,x:vpoke 6914,p
    520 PUTSPRITE0,(X,Y),15,P


    1 'Colisiones con el mapa'
    530 px=x/8:py=y/8
    1 'Recuerda que trabajamos con sprites de 16x16, es decir 4 sprites de 8x8 pixeles'
    540 t0=m(px+1+n,py+1)

    1 'Se se tropieza con un tile de la muerte entonces:
    1 'llamamos a la subrrutina player muere (3000)'
    550 if t0>=td and a=0 then gosub 3000 
    1 'Debug, si lo descomentas, permite que no te maten si pisas un tile de la puerte'
    1 '550 if t0>=td and a=0 then mu=5:gosub 4000
    1 'Si no si el tile es un Tile Money(tm) entonces' 
        1 'Hacemos un sonido re=6:gosub 4000'
        1 'Pintamos el sprite del perro comiendo'
        1 ' Hacemos una pequeña pausa para que se vea el sprite'
        1 'actualizamos el array con los cambios'
        1 'aumentamos el s=score'
        1 'actualizmos el marcador (2200)'
    560 if t0=tm then mu=6:gosub 4000:PUT SPRITE0,(X,Y),8,6:for i=0 to 300:next i:m(px+1+n,py+1)=tf:s=s+10:gosub 2200



    
    1 'Si estamos en el final ralentizamos a LEO'
    570 if n=w then for i=0 to 50:next i
    1 ' si estamos en el final del scroll y la posición del player es mayor de 240 llamamos a la subrrutina de cambiar pantalla (20000)
    580 if n=w and x>240 then gosub 20000
    1 ' moviendo el tercio superior'
    590 if n mod 10=0 and n<w then gosub 20500
    1 ' Aumentando el contador de pantalla y moviendo el tercio central'
    600 if n<w then n=n+1:gosub 20600
    1 'Si son las pantallas de salto nos saltamos esta parte'
    610 if sc=2 or sc=4 or sc=6 then goto 690


    1 'Render y actualizar enemigos'
    1 '620 for i=0 to 2
    1 '   630 if n>c(i) and n<c(i)+25 then if n mod 2=0 then put sprite 2,(x(i),y(i)),1+i,8+i:x(i)=x(i)-v(i) else put sprite 2,(x(i),y(i)),1+i,8+i+1:x(i)=x(i)-v(i)
    1 '640 next i
    1 '620 if n>c(0) and n<c(0)+25 then if n mod 2=0 then put sprite 2,(x(0),y(0)),1,8:x(0)=x(0)-v(0) else put sprite 2,(x(0),y(0)),1,9:x(0)=x(0)-v(0)
    1 '630 if n>c(1) and n<c(1)+25 then if n mod 2=0 then put sprite 2,(x(1),y(1)),2,10:x(1)=x(1)-v(1) else put sprite 2,(x(1),y(1)),2,11:x(1)=x(1)-v(1)
    1 '640 if n>c(2) and n<c(2)+25 then if n mod 2=0 then put sprite 2,(x(2),y(2)),3,12:x(2)=x(2)-v(2) else put sprite 2,(x(2),y(2)),3,13:x(2)=x(2)-v(2)
    620 if n>c(0) and n<c(0)+25 then p(0)=e1:swap e1,e2:put sprite 2,(x(0),y(0)),1,p(0):x(0)=x(0)-v(0):goto 690
    630 if n>c(1) and n<c(1)+25 then p(1)=e3:swap e3,e4:put sprite 2,(x(1),y(1)),2,p(1):x(1)=x(1)-v(1):goto 690
    640 if n>c(2) and n<c(2)+25 then p(2)=e5:swap e5,e6:put sprite 2,(x(2),y(2)),3,p(2):x(2)=x(2)-v(2)
    
    1 'Debug'
    1 '680 me$=str$(time):gosub 2000
690 goto 200

1 'imprimir mensajes sin pausa (necesita que esté inicializada me$)''
    2000 line(0,170)-(255,180),6,bf
    2010 preset (0,170):? #1,me$
2090 return

1 'Imprimir mensajes con pausa (necesita que esté inicializada me$)'
    2100 line(0,170)-(255,180),6,bf
    2110 preset (0,170):? #1,me$
    2120 if strig(0)=-1 then 2180 else 2120
    2180 line(0,170)-(255,180),6,bf
2190 return

1 'Imprimir HUD'
    1 ' par acomprender los pokes mira las lines 140-160 y el final del archivo utils.bas'
    2200 vpoke 6722,48+l
    2230 vpoke 6728,48+sc
    2240 s$=str$(s)
    2250 ls=len(s$)
    2260 for i=1 to ls-1
        2270 vpoke 6733+i,48+val(mid$(s$,i+1,1))
    2280 next i
2290 return


3000 'player muere'
    3010 mu=5:gosub 4000:a=0:sprite off:strig(0) off
    1 'hacemos una pqueña pausa'
    3020 for i=0 to 1000:next i
    3030 x=0:y=9*8:PUT SPRITE 0,(X,Y),15,0
    3035 for i=0 to 2:put sprite 2+i,(x(i),y(i)),0,0
    1 'Restamos una vida'
    1 '2200: imprimir HUD'
    3040 l=l-1:gosub 2200
    1 'Si al player no le quedan vidas(l) entonces: 
        1 'sacamos a leo de la pantalla'
        1 '19000 borrar pantalla'
        1 '2100: mmostrar mensaje con pausa '
        1 'Reiniciamos el juego(goto 110)'
    3050 if l<=0 then put sprite 0,(0,212),15,p:gosub 19000:me$="^Game over":gosub 2100:goto 110
    1 'Las pantallas de salto son las 2, 4 y 6'
    3060 if sc=2 or sc=4 or sc=6 then strig(0) on:on strig gosub 5000:sprite off:me$="^Press space to jump":gosub 2000
    1 'Las pantallas de los sprites son las 1,3 y5'
    3070 if sc=1 or sc=3 or sc=5 then on sc gosub 6000, 3017,7000, 3017,8000:sprite on:strig(0) off
    1 'reseteamos el contador e imprimimos la parte central de la pantalla'
    3080 n=0:gosub 20600
    1 'Mostramos el mensaje con la pausa'
    3085 me$="^Ready press space":gosub 2100
3090 return

1 ' inicializar música
    3500 S1$="T250V13O4L4daO5ag#eV15L2gL4d#ef#gf#ed#"
    3510 S6$="T250V11O3L4gO4dO5dc#O4aO5cL2cL4g#abO6cO5bag#"
    3520 S2$="T250V12O2L2dL6ar64aL2dadL6ar64aL2da"
    3530 S3$="T250V11S14M500 L4cO6cO8cO4g#g"
    3540 S4$="T250V11O1L2aL6O2er64eL2O1aO2eO1cL6O2gr6gL2O1cO2g L2dL6ar64aL2dad L6ar64aL2da"
    3550 S5$="T250V13O4L4ed#ef#gf# r2L4gf#gaa#a r2L4a#aa#aL2O5c#L4O4aa#O5c#d"
3590 return

1 ' Reproductor de música
    1 'Llamamos a la rutina de inicializar psg que forma parte de las rutinas de la bios'
    4000 a=usr2(0)
    4010 if mu=1 then play S3$: play S2$: play S1$,S2$: play S1$,S2$,S6$: play S4$,S5$,S3$
    1 'player muere'
    4050 if mu=5 then play "t255 l10 o3 v8 g c"
    1 'Moneda cogida'
    1 '4060 if mu=6 then play"t255 o4 v12 d v9 e" 
    4060 if mu=6 then sound 1,0:sound 6,25:sound 8,16:sound 12,4:sound 13,9
    1 'Inicio level'
    4070 if mu=7 then play "t255 O3 L8 V8 M8000 A A D F G2 A A A A"
    1 'Cogidos puntos'
    4080 if mu=8 then sound 1,2:sound 8,16:sound 12,5:sound 13,9
4199 return

1 'Rutina de salto'
    1 'Si el salto no está activado
        1 ' hacemos el sonido 8
        1 ' conservamos la posición y en o
        1 ' y activamos el salto'
    5000 if a=0 then mu=8:gosub 4000:o=y:a=1
5090 return

1 'fase 1'
1 'inicializar enemigos'
    6000 x(0)=255:y(0)=72:v(0)=12:c(0)=1
    6010 x(1)=255:y(1)=80:v(1)=12:c(1)=34
    6020 x(2)=255:y(2)=64:v(2)=12:c(2)=62
6090 return
1 'fase 3'
1 'inicializar enemigos'
    7000 x(0)=255:y(0)=72:v(0)=12:c(0)=1
    7010 x(1)=255:y(1)=64:v(1)=12:c(1)=36
    7020 x(2)=255:y(2)=64:v(2)=12:c(2)=58
7090 return
1 'fase 5'
1 'inicializar enemigos'
    8000 x(0)=255:y(0)=64:v(0)=12:c(0)=1
    8010 x(1)=255:y(1)=96:v(1)=12:c(1)=38
    8020 x(2)=255:y(2)=64:v(2)=12:c(2)=60
8090 return




1 'Rutina cambio de nivel o pantalla'
    1 'hacemos un sonido'
    20000 mu=7:gosub 4000:strig(0) off
    1 'sc=screen'
    20005 sc=sc+1
    20010 PUT SPRITE 0,(0,212),15,0
    1 '19000: rutina borrar pantalla'
    1 'Si hemos llegado al final del juego 
        1 'Hacemos el efecto de borrar la pantalla'
        1 'Cargamos la pantalla de los créditos del final'
        1 'mostramos un mensaje que espere pulsación
        1 'Al pulsar reiniciamos'
    20020 if sc=sl then gosub 19000:gosub 20200:gosub 20800:me$="^Congratulations, final":gosub 2100:goto 110
    1 'Mostramos un mensaje sin pausa'
    20030 me$="^Loading next level...":gosub 2000
    1 'Volvemos a cargar el array con los nuevos datas'
    20040 gosub 20200
    1 'Pintamos toda la pantalla'
    20050 n=0:gosub 20800

    1 'Imprimimos el marcador'
    20070 gosub 2200
    1 'Reiniciamos y pintamos al player'
    20075 x=0:y=9*8:put sprite 0,(x,y),15,p
    1 'Mostramos un mensaje con pausa'
    20080 me$="^Press space key":gosub 2100
    1 'Si la pantalla es mayor de 3 podmos saltar'
    20085 if sc=2 or sc=4 or sc=6 then strig(0) on:on strig gosub 5000:me$="^Press space to jump":gosub 2000:sprite off
    20086 if sc=1 or sc=3 or sc=5 then on sc gosub 6000,20086,7000,20086,8000:sprite on
20090 return

1 'Cargar array con compresión RLE-16'
    20200 call turbo on (m())
    20205 for r=0 to 15
        20210 READ mp$:po=0
        20220 for c=0 to len(mp$) step 4
            1 'El 1 valor indica la cantidad de repeticiones, el 2 el valor en si'
            20230 r$=mid$(mp$,c+1,2)
            20240 tn$=mid$(mp$,c+3,2)
            20250 tn=val("&h"+tn$):tn=tn-1
            20260 re=val("&h"+r$)
            20270 for i=0 to re
                20280 m(po,r)=tn:po=po+1
            20300 next i
        20310 next c
    20320 next r
    20325 call turbo off
20390 return

1 ' Scroll tercio superior
    20500 _TURBO ON (m(),n)
    20510 d=6144
    20520 for r=0 to 7
        1 ' Ahora leemos las columnas c hasta 32, (recuerda que para en la 88 que es 120-32)
        20530 for c=n to 31+n
            20540 VPOKE d,m(c,r):d=d+1
        20550 next c
    20560 next r
    20570 _TURBO OFF
20590 return 


1 ' Scroll tercio central
    20600 _TURBO ON (m(),n)
    1 '6144+(32*7filas)'
    1 '20610 d=6368
    20610 d=6432
    20620 for r=9 to 14
        20630 for c=n to 31+n
            20640 VPOKE d,m(c,r):d=d+1
        20650 next c
    20660 next r
    20670 _TURBO OFF
20690 return 

1 ' Pintar toda la pantalla
    20800 _TURBO ON (m())
    20810 d=6144
    20820 for r=0 to 15
        1 ' Ahora leemos las columnas c hasta 32, (recuerda que para en la 88 que es 120-32)
        20830 for c=0 to 31
            20840 VPOKE d,m(c,r):d=d+1
        20850 next c
    20860 next r
    20870 _TURBO OFF
20890 return 
1'vamos por 1838 bytes libres
1 'Menu'
21000 data 1f23
21010 data 072300530059005e002300590056003b004f0054002300560058003f0059003f0054005a00590523
21020 data 1f23
21030 data 0a230052003f005500230053005b0059005a00230052004f005c003f0723
21040 data 0e23000b000c000d0d23
21050 data 0923000b000c000d0123002b002c002d0123000b000c000d0823
21060 data 0923002b002c002d0623002b002c002d0823
21070 data 1f23
21080 data 1f23
21090 data 0823000b000c000d0223000e000f00100223000b000c000d0723
21100 data 0823002b002c002d0223002e002f00300223002b002c002d0723
21110 data 1f23
21120 data 1f23
21130 data 0923000b000c000d0623000b000c000d0823
21140 data 0923002b002c002d0123000b000c000d0123002b002c002d0823
21150 data 0e23002b002c002d0d23


1 'Level 1 (sprites)
21200 data 202300251e23012500230625142303251323
21210 data 122301250a2301251e2309251423032500230125042301250923
21220 data 0d230125022301250a2301251c230b251423032500230125032302250923
21230 data 05230325032306250a2301251c230b251423032500230125022303250923
21240 data 05230e250a230a2513230b2513230425002308250923
21250 data 05230e250a230a2513230b2513230e250923
21260 data 7725
21270 data 7741
21280 data 7741
21290 data 06411c2100070a2101411321004102210007012102411c2100410421042a
21300 data 2921074113210241032102410b2105410a2100410921
21310 data 0b21114101210141022100410f2101410d210241032102410c210007022100410a2100410421042a
21320 data 06411d2100410f2101410321054103210241032102410221054107210041012109410921
21340 data 06411d21004105210b41032105411021014106210341002100411021042a
21350 data 7741
21360 data 7741

1 'Level 2 (jump)
21400 data 7723
21410 data 322304213f23
21420 data 31230521172307241f23
21430 data 09230e2411230c2117230724102305240823
21440 data 092302240023002400230024002300240023042411230c211723002400230b240a23012400230024002300240823
21450 data 09230e240423001800190a2300210023002100230021002300210023002100230021002300210123001800190e23001a001b02230424012306240a2305240823
21460 data 092302240623022400250024052300150a23002100250a21022300160f23001602230024002502240123002401230024012300240a230324002500240823
21470 data 7742
21480 data 7742
21490 data 134203221242032200420622014206220a4203220007012200420022004206220142032202420222004202220842022a
21500 data 09220142052201420322014201220342012201420a2200420322044206220a42062200420022054201220142032202420222004202220b42
21510 data 092201420522074202221642032200420222034202220042022200420222074200220a42022202420222004202220842022a
21520 data 092201420522014203220142052201420b220542032200420022000700220342022200420622014202220142022200420122004a004b04220242052203420b22
21540 data 134203220342032201420422014c042205420322004202220342022200420222004202220142022201420222004201220048004906220042022206420b22
21550 data 7742
21560 data 7742

1 'Level 3 (sprites)
21600 data 7723
21610 data 1623001800195e23
21620 data 172300161c23001a001b072300280023002800230028002300282423001800190123001a001b0523
21630 data 0123001800190f2306271b2300160723062806230b2712230016022300170523
21640 data 0223001705230327052306250423072706230125032305270423042800020028042310210c23072104230021
21650 data 7727
21660 data 7743
21670 data 7743
21680 data 7743
21690 data 10210f4308210007032100431421044313210043052107430621032a
21700 data 0521000700210443032100431021044306210043032104430621004302210543042108430521004305210043042100430821022a
21710 data 08210843102100430e21064305210043032104430f210043022100430521004304210043032100430421012a
21720 data 04430f21004303210943132102430421004303210007002102430f2100430521002505210343032101430521
21730 data 04430f21004310211a430a21014304210643052100250d2102430421
21740 data 7743
21750 data 7743


1 'Level 4 (jump)
22000 data 19230015172300180019172300171a2300160d23
22010 data 16230626112302260023001615230326172304260b23
22020 data 012610230d260b23072613230726032304260a2309260823
22030 data 002112260b210d26052114260621172604210a26
22040 data 0d210726092105260d2105260b2101260721052606210226012101261321
22050 data 7721
22060 data 09260a210326042103265521
22070 data 7726
22080 data 69420d25
22090 data 0a420125014201250f420b25004a004b022500420425014203250142022501420225014204250442032511420d25
22100 data 08250142012501420125014202250342032502420b2500480049022500420425014203250142022501420225014204250442032502420b2502420d25
22110 data 082501420125054202250342032502420125054202250e420125074202250b420325024203250046004705250d42022a
22120 data 0825014203250a4203250a420325034203250542012509420b25074203250044004505251042
22140 data 0a420e250e4210250042012509420b252142022a
22150 data 7742
22160 data 7742

1 'Level 5 (sprites)
22200 data 7723
22210 data 7723
22220 data 1e2301280d2301240c230128002301280023012807230128002301280a23012400230124002301240c2301280223
22230 data 02230024002301240023002411230228002301280d2301240c230728072304280a2307240c2301280223
22240 data 02230524102306280d2301240c230728072304280a2307240c2301280223
22250 data 02230524102306280d2301240c230728072304280a2307240c2301280223
22260 data 7726
22270 data 7742
22280 data 7742
22290 data 0d421a2102420521084202210007012101421121000700210042062103421421
22300 data 0a210242012100070321004204210e42152104421121004202210042022103420e21052a
22310 data 0a2103420521004204210e421621034205210242032105420221004203210242022108420821
22320 data 054204210342052101421021014205210a42062102420421034203210542022101420221024202210b42052a
22340 data 06420d2102421c210142152100420c21014213210642
22350 data 7742
22360 data 7742

1 'Final'
22400 data 1f23
22410 data 0323003e003f005c003f005200550056003f005800590b23001100120323
22420 data 1923001300140323
22430 data 07230056003f003e0058005500230055005a003b005200550058003b0a23
22440 data 1f23
22450 data 07230051004f0051003f00230053003b003e0058004f004d003b00520a23
22460 data 1f23
22470 data 0323004d0058003b0056004e004f003d00590d23001100120323
22480 data 1923001300140323
22490 data 072300530059005e002300590056003b004f00540023005a003f0052003f004d0058003b00530523
22500 data 1f23
22510 data 03230053005b0059004f003d00590f23001100120323
22520 data 1923001300140323
22530 data 0723003d0052003f0053003f0054005a003f0f23
22540 data 1523005a004e003b0054005100590023005f0055005b
22550 data 1f23



1 '' level 6 (jump)
1 '22400 data 3823001c001d0b23001c001d2e23
1 '22410 data 0223001c001d0923001c001d0b23002800230028202300223523
1 '22420 data 1c2302280323001c001d0b2300240c2302220d230b241a23
1 '22430 data 1c230228102302240b2302220c230c241a23
1 '22440 data 172300280023002801230228102302240623001c001d022302220b230922032409230a240523
1 '22450 data 07230028002300280023002800230028002300280623072808230828012409230022002302220b23092203240923012400430424004301240523
1 '22460 data 07230828062307280823002800430128004301280043002801240823052209230b22032409230a240523
1 '22470 data 072304280043022806230528004300280823082801240823032200430022092309220043002201240043002409230424004304240523
1 '22480 data 7743
1 '22490 data 0a43182400430224004302240043022400430224004302240343012401430c240043022400430224114304240243032400430324
1 '22500 data 232400430224004302240043022400430224004302240343012401430c2400430224004309240143072400430424004301240043022400430024022a
1 '22510 data 0c24324301240f430924014307240643012404430324
1 '22520 data 0c2405430c24000702240e43002400070c2406430124024302240c430124094304240043022400430024022a
1 '22540 data 0a430a24064306240e430e24064301240243002400070024004309240d4304240043022400430324
1 '22550 data 7743
1 '22560 data 7743




1 '22600 data 1f23
1 '22610 data 0323003e003f005c003f005200550056003f005800590b23001100120323
1 '22620 data 1923001300140323
1 '22630 data 07230056003f003e0058005500230055005a003b005200550058003b0a23
1 '22640 data 1f23
1 '22650 data 07230051004f0051003f00230053003b003e0058004f004d003b00520a23
1 '22660 data 1f23
1 '22670 data 0323004d0058003b0056004e004f003d00590d23001100120323
1 '22680 data 1923001300140323
1 '22690 data 07230056003f003e0058005500230055005a003b005200550058003b0a23
1 '22700 data 2023
1 '22710 data 2023
1 '22720 data 2023
1 '22730 data 2023
1 '22740 data 2023
1 '22750 data 2023



















