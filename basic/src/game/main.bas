1 '' ******************************
1 '' Program:    Leo must live
1 '' Autor:      MSX spain 2023
1 '' Repository: https://github.com/MSX-Spain/LEO-must-live
1 '' ******************************

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

1 '****************
1 '***Subrrutinas**
1 '****************

1 ' 9000-9990 Rutina cargar sprites en VRAM con datas basic''
1 ' 10000-18990 Rutina cargar la definición y colores de tiles en screen 2'
1 ' 19000-19090 Rutina borrar pantalla'
1 ' 200 -500 Main loop'
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

100 dim m(120,16)
1 'el ancho de cada nivel son 120 tiles-32=88, 88 son los que tiene que hacer el scroll'
110 f=0:sc=1:sl=4:td=64:tm=6:tf=32:n=0:w=88:t0=0
120 x=0:y=9*8:v=8:h=8:l=9:s=0:p=0:p0=0:p1=1:p2=2:p3=3:p4=4:p5=5
1 'Cargamos los tiles del menu'
1 'Inicializamos el array con el menú, importante colocar el puntero de los datas al principio (rutina 20200)'
130 restore 22000: gosub 20200
1 'Pintamos la parte superior (20500) y la parte central del menu (rutina 20600)'
135 gosub 20500:gosub 20600
1 'Mostramos la pantalla de bienvenida'
140 me$="^Main menu, press space key":gosub 2100
1 'Almacenamos en el array el level 1'
150 gosub 20200
1 'Pintamos el fondo del HUD'
1 'Pintamos el marco'
1 'Para calcular el último tercio del mapa, 6144+256+256=6656
1 'la 2 fila sería 6656+32=6688'
1 'la 3 fila sería 6656+(32*2)=6720'
160 for i=0 to 31: vpoke 6656+i,39:next i 
161 VPOKE 6688,39:VPOKE 6719,39:VPOKE 6720,39:VPOKE 6751,39:VPOKE 6752,39:VPOKE 6783,39
1 'Pintamos el corazón de las vidas'
163 VPOKE 6690,0
1 'Pintamos la casa que indica la pantalla en la que estamos'
164 VPOKE 6696,1
1 'Pintamos el signo de puntuación para los puntos de las mnedas cogidas'
165 VPOKE 6702,2
166 for i=0 to 31: vpoke 6784+i,39:next i 
1 'Pintamos el marcador'
167 gosub 2200
1 'Pintamos al player'
168 put sprite 0,(x,y),4,p
169 mu=7:gosub 4000
1 'Pintamos la parte de arriba de la pantalla'
170 gosub 20500
1 'Pintamos la parte central de la pantalla'
180 gosub 20600
1 'Mostramos un mensaje con pausa'
190 me$="^Press space key to start":gosub 2100
1 '195 strig(0) on:on strig gosub 5000

1 'Main loop'
    200 j=STICK(0) OR STICK(1)

    1 '205 if a>0 then PUT SPRITE 1,(x,o),1,8:goto 400
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON j GOTO 230,250,270,290,310,330,350,370
 
    220 p=p0:if n<w then swap p0,p1:goto 400 else goto 400
    1 'movimiento hacia arriba 
    1 'Ponemos el sprite correspondiente que mira hacia arriba que irá alternando ente 2 sprites'
    230 y=y-h:p=p4:swap p4,p5:goto 400
    1 '2 Pulsado 2 movimiento hacia arriba derecha 
    1 ' ponemos el sprite 0 o 1 que corresponde a los de la derecha'
    250 x=x+v:y=y-h:p=p0:swap p0,p1:goto 400
    1 '3 pulsado Movimiento hacia la derecha '
    270 x=x+v:p=p0:swap p0,p1:goto 400
    1 '4 Movimiento abajo derecha'
    290 x=x+v:y=y+h:p=p0:swap p0,p1:goto 400
    1 '5 Movimiento abajo'
    310 y=y+h:p=p4:swap p4,p5:goto 400
    1 '6 Movimiento abajo izquierda'
    330 x=x-v-4:y=y+h:p=p2:swap p2,p3:goto 400
    1 '7 Movimiento izquierd'
    350 x=x-v-4:p=p2:swap p2,p3:goto 400
    1 '8 movimiento arriba izquierda'
    370 x=x-v-4:y=y-h:p=p2:swap p2,p3


    
    1 'Chekeo de límites'
    400 IF y<48 THEN y=48 else if y>112 then y=112
    410 if x<0 then x=0 else if x>250 then x=250


 

     1 'Render'
    415 PUTSPRITE0,(X,Y),4,P

    1 '1 'Rutina de salto'
    1 '1 'Si la pantalla es menor de 3 no habrá salto'
    1 '416 if sc<3 then goto 415
    1 '1 'Si el player está saltando, irá hacia arrina hasta -8'
    1 '417 if a=1 then y=y-4:if y<o-8 then a=2
    1 '1 'Si el player está cayendo
    1 '418 if a=2  then y=y+4:if t0=34 then a=0:PUTSPRITE 1,(0,212),1,8

    1 'Colisiones con el mapa'
    420 px=x/8:py=y/8
    1 'Recuerda que trabajamos con sprites de 16x16, es decir 4 sprites de 8x8 pixeles'
    430 t0=m(px+1+n,py+1)
    1 'Se se tropieza con un tile de la muerte entonces:
        1 'llamamos a la subrrutina player muere (3000)'
    440 if t0>=td and a=0 then gosub 3000 
    1 'Debug'
    1 '440 if t0>=td and a=0 then mu=6:gosub 4000
    1 'Si no si el tile es un Tile Money(tm) entonces' 
        1 'Hacemos un sonido re=6:gosub 4000'
        1 'Pintamos el sprite del perro comiendo'
        1 ' Hacemos una pequeña pausa para que se vea el sprite'
        1 'actualizamos el array con los cambios'
        1 'aumentamos el s=score'
        1 'actualizmos el marcador (2200)'
    445 if t0=tm then mu=8:gosub 4000:PUT SPRITE0,(X,Y),4,6:for i=0 to 300:next i:m(px+1+n,py+1)=tf:s=s+10:gosub 2200


    1 '450 vpoke 6912,y:vpoke 6913,x:vpoke 6914,p
    
    1 'Si estamos en el final ralentizamos a LEO'
    460 if n=w then for i=0 to 100:next i
    1 ' si estamos en el final del scroll y la posición del player es mayor de 240 llamamos a la subrrutina de cambiar pantalla (20000)
    470 if n=w and x>240 then gosub 20000
    1 ' moviendo el tercio superior'
    480 if n mod 10=0 and n<w then gosub 20500
    1 ' Aumentando el contador de pantalla y moviendo el tercio central'
    490 if n<w then n=n+1:gosub 20600
    1 'Debug'
     1'486 me$=str$(a):gosub 2000
500 goto 200

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
    3010 mu=5:gosub 4000
    1 'hacemos una pqueña pausa'
    3015 for i=0 to 1000:next i
    1 'Restamos una vida'
    1 '2200: imprimir HUD'
    3020 l=l-1:gosub 2200
    1 'Si al player no le quedan vidas(l) entonces: 
        1 'sacamos a leo de la pantalla'
        1 '19000 borrar pantalla'
        1 '2100: mmostrar mensaje con pausa '
        1 'Reiniciamos el juego(goto 110)'
    3030 if l<=0 then put sprite 0,(0,212),4,p:gosub 19000:me$="^Game over":gosub 2100:goto 110
    1 'reseteamos el contador e imprimimos la parte central de la pantalla'
    3040 n=0:gosub 20600
    3050 x=0:y=9*8:PUT SPRITE0,(X,Y),4,0
    3055 strig(0) off
    1 'Mostramos el mensaje con la pausa'
    3060 me$="^Ready press space":gosub 2100
    3070 strig(0) on
3090 return



1 ' Reproductor de música
    4000 a=usr2(0)
    1 'player muere'
    4050 if mu=5 then play "t255 l10 o3 v8 g c"
    1 'Moneda cogida'
    4060 if mu=6 then play"t255 o4 v12 d v9 e" 
    1 'Inicio level'
    4070 if mu=7 then play "t255 O3 L8 V8 M8000 A A D F G2 A A A A"
    1 'Cogidos puntos'
    4080 if mu=8 then sound 1,2:sound 8,16:sound 12,5:sound 13,9
4199 return

1 'Rutina de salto'
    5000 if a=0 then mu=8:gosub 4000:o=y:a=1
5090 return

1 'Rutina cambio de nivel o pantalla'
    1 'hacemos un sonido'
    20000 mu=7:gosub 4000
    1 'sc=screen'
    20005 sc=sc+1
    20010 PUT SPRITE0,(0,212),4,0
    1 '19000: rutina borrar pantalla'
    1 'Si hemos llegado al final del juego mostramos un mensaje y reiniciamos'
    20020 if sc=sl then gosub 19000:me$="^Congratulations, final":gosub 2100:goto 110
    1 'Mostramos un mensaje sin pausa'
    20030 me$="^Loading next level...":gosub 2000
    1 'Volvemos a cargar el array con los nuevos datas'
    20040 gosub 20200
    1 'Pintamos la parte de arriba de la pantalla'
    20050 n=0:gosub 20500
    1 'Pintamos la parte central de la pantalla'
    20060 gosub 20600
    1 'Imprimimos el marcador'
    20070 gosub 2200
    1 'Reiniciamos y pintamos al player'
    20075 x=0:y=9*8:put sprite 0,(x,y),4,p
    1 'Mostramos un mensaje con pausa'
    20080 me$="^Press space key":gosub 2100
    1 'Si la pantalla es mayor de 3 podmos saltar'
    1 '20085 strig(0) on:on strig gosub 5000
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
    20610 d=6368
    20620 for r=7 to 15
        20630 for c=n to 31+n
            20640 VPOKE d,m(c,r):d=d+1
        20650 next c
    20660 next r
    20670 _TURBO OFF
20690 return 

1 'Menu'
22000 data 1f23
22010 data 082300530059005e002300590056003b004f0054002300560058003f0059003f0054005a00590423
22020 data 1f23
22030 data 0a230052003f005500230053005b0059005a00230052004f005c003f0723
22040 data 0e23000b000c000d0d23
22050 data 0923000b000c000d0123002b002c002d0123000b000c000d0823
22060 data 0923002b002c002d0623002b002c002d0823
22070 data 1f23
22080 data 1f23
22090 data 0823000b000c000d0223000e000f00100223000b000c000d0723
22100 data 0823002b002c002d0223002e002f00300223002b002c002d0723
22110 data 1f23
22120 data 1f23
22130 data 0923000b000c000d0623000b000c000d0823
22140 data 0923002b002c002d0123000b000c000d0123002b002c002d0823
22150 data 0e23002b002c002d0d23


1 'Level 1
22200 data 1b230125022300250623012515230125002306250e23002500230125012303251323
22210 data 1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
22220 data 002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
22230 data 00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
22240 data 0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
22250 data 00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
22260 data 7725
22270 data 1f410f2101410f2104410d21024106210e410921
22280 data 0641282101410f2104410d21024106210e410921
22290 data 06411c2100070a2101410321014103210a41022100070121024104210241062100410c2100410421042a
22300 data 0b21154104210a41032101410d210241032102410b2103410c21004104210441
22310 data 0b2103410921004111210041072101410d210241032102410b2103410c2100410421042a
22320 data 064104210341092100411121004107210141032105410321024103210b410221034102210a4104210441
22340 data 064104210341092100410c210541032105410321054110210141062103411221042a
22350 data 06410c21014103210041022104410e21054108210041102101411d210441
22360 data 0641062100070421014103210041022104410e21054108210041102101410d211441


1 'Level 2
22400 data 7722
22410 data 7722
22420 data 1e2201280d2201240c220128002201280022012807220128002201280a22012400220124002201240c2201280222
22430 data 02220024002201240022002411220228002201280d2201240c220728072204280a2207240c2201280222
22440 data 02220524102206280d2201240c220728072204280a2207240c2201280222
22450 data 02220524102206280d2201240c220728072204280a2207240c2201280222
22460 data 7726
22470 data 0d421a2102421421014211210007082106421121
22480 data 0d421a2102421421014209210d42032103421421
22490 data 0d42062100420421104205210842022100070121014213210342032103420a210942
22500 data 0a2102420121000703210042112101420e2101420421044211210342032103420a210342052a
22510 data 0a21034205210042112101420e2101420521034205210242032108420421024202211142
22520 data 054204210342052101421021014205210a42062102420421034203210a420221024202210b42052a
22540 data 06420d21024206210a420a210142152100420c21014213210642
22550 data 07420c2103421b210142152100420c21014213210042052a
22560 data 07420c2104421a210142152100420c21014213210642


1 'Level 3
22600 data 7723
22610 data 1623001800195e23
22620 data 172300161c23001a001b072300280023002800230028002300282423001800190123001a001b0523
22630 data 0123001800190f2306271b2300160723062806230b2712230016022300170523
22640 data 0223001705230327052306250423072706230125032305270423042800020028042310210c23072104230021
22650 data 7727
22660 data 7743
22670 data 04430b210043092103430d210143142104430d2107430b21004304210143032a
22680 data 04430b21004309210343082100070321014314210443132101430b21004305210443
22690 data 10210043092103430421054303210043042100430e210443052103430a2100430421074306210043022a
22700 data 052100070021044303210043032100430b210443062100430321014305210143042106430221000700210b43092100430421004308210225
22710 data 08210843032100430b210043022100430a21054302210143092101430f21004308210143042100430321004304210025002a
22720 data 04430f21014302210943022100430f21004302210143092101430f21004308210143002104430321014303210125
22730 data 04430f21014302210943022104430b210043022105430421024302210143042106430d2102430321024302210125
22740 data 04430a210643132100430b210043022101430e2101430a210043142100430621
22750 data 04430a21064313210d43022101430e2101430a210043022102430e2100430621

1 'Level 4
22800 data 0922032503220a25022207250b2205250222052504220625022208250122012512220525
22810 data 05220d250422072504221325022211250222012503220225012203250f220625
22820 data 132504220725042201432b2503220e2507220825
22830 data 242502434f25
22840 data 12250843022503431a2501433725
22850 data 0525104301250843092505430b250143072510431e25
22860 data 7725
22870 data 404209222942022a
22880 data 344201220542012201420422000703220d420222034201221542
22890 data 3442012205420122094201220d4202220342012203420122014201220842022a
22900 data 09230142012301420123064201232d42022219420122014201220b42
22910 data 09220142012201420122064201221d4202220c420322184201220c42022a
22920 data 09220142012201420122064201220242012202420122064201220a420022000700220c420e220942012207420b22
22940 data 0122004201221842012202420122064201220a4202220c420e220942012207420b22
22950 data 0122004201224a420622004a004b07221642
22960 data 0122004201224a4206220048004907221642


1 'Level 5
23000 data 7723
23010 data 7723
23020 data 1e2301480d2301480c230148002301480023014807230148002301480a23014800230148002301480c2301480223
23030 data 02230048002301480023004811230248002301480d2301480c230748072304480a2307480c2301480223
23040 data 02230548102306480d2301480c230748072304480a2307480c2301480223
23050 data 02230548102306480d2301480c230748072304480a2307480c2301480223
23060 data 242603214e26
23070 data 0b221c210222142101221b2106221121
23080 data 0022000609221c2102221421012203211322032103221421
23090 data 0b22052103220321112202210b220521012213210322032103220a210922
23100 data 0a21002207210122032101220b2101220e2101220321052211210322032103220a21012205210122
23110 data 0a21032204210122032101220b2101220e210122032105220221052203210822042102220221092205210122
23120 data 072202210522022101221121012203210c22032105220221052203210a22022102220221092205210122
23140 data 07220b21012208210a220a210122152100220c21012216210322
23150 data 07220b2101221e210122152100220c21012216210322
23160 data 07220b2101221e210122152100220c21012216210322

1 'Level 6
23200 data 7748
23210 data 034801230848022311480023084802230648002303480123154802210a480323094802230348
23220 data 084801230a48032101480223034802231b48022103480123084803210b48012305480221024800230448
23230 data 0b48002106480621004802230048022113480021084804210748022100480721104804210748
23240 data 0148012105480321054806210448072101480123024801210348052104480621044810210c48072104480021
23250 data 7721
23260 data 7724
23270 data 04240a210124092103240d210124142104240d2107240b21002409210024
23280 data 04240a210124092103240d21012414210424132101240b21002409210024
23290 data 072104240221012402210124042103240421052403210024022102240e2104240221062409210224022108240221022403210024
23300 data 0721042402210124022101240b2104240621002402210224052101240221082402210d240221022402210124042100240221032402210124
23310 data 07210924022101240b21002402210024052101240221052402210124092101240f2100240221022402210124042100240221032402210124
23320 data 0424022104240721012402210924022100240f21002402210124092101240f21002408210124002104240221032402210124
23340 data 0424022104240721012402210924022104240b210024022105240321032402210124042106240d2102240321022402210124
23350 data 04240a210624132100240b210024022101240e2101240a210024142100240621
23360 data 04240a21062413210d24022101240e2101240a210024022102240e2100240621

