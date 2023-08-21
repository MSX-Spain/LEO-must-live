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
1 '2000 es la subrrutina para pintar un mensaje'
60 me$="^Loading sprites":gosub 2000
1 'cargamos los sprites en VRAM'
70 gosub 9000
75 gosub 19000
80 me$="^Loading tileset":gosub 2000
1 'Cargamos los tiles'
90 gosub 10000



1 'Vamos a pintar algo'
1 'b=desplazamos el lapiz de forma absoluta y sin dibujar la trayectoria 40 pixeles eje x y 160 eje y  '
1 'c= le ponemos el valor negro=1'
1 'u= arriBa,d= abajo,l izquierda,r= derecha,e= diagonal arriba derecha, f= diagonal abajo derecha,g= diagonal abajo izquierda,h=diagonal arriba izquierda'
1 'u=up,le decimos que dibuje 100 pixeles hacia arriba'
1 'Dibujamos el cielo y la tierra'
1 '140 draw("bm0,50 c9 r14 d11 r219 u11 r23 d20 l256 u20 c7 u50 r260 d27 l260")

 
1 '' ******************************
1 '' Program:    Leo must live
1 '' Autor:      MSX spain
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
1 'ml=limit map, el ancho del mapa, cuando lleguemos al final mapa no se repintará'
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

100 dim m(120,16):dim td(2)
110 f=0:sc=1:sl=4:td(0)=35:td(1)=33:tm=6:tf=32:n=0:ml=88:t0=0
120 x=0:y=9*8:v=8:h=8:l=9:s=0:p=0:p0=0:p1=1:p2=2:p3=3:p4=4:p5=5
1 'Cargamos los tiles del menu'
1 'Inicializamos el array con el menú, importante colocar el puntero de los datas al principio'
130 restore 22000: gosub 20200:gosub 20500
1 'Mostramos la pantalla de bienvenida'
140 me$="^Main menu, press space key":gosub 2100
1 'Almacenamos en el array el level 1'
150 gosub 20200
1 'Pintamos el fondo del HUD'
1 'Pintamos el marco'
1 'Para calcular el último tercio del mapa, 6144+256+256=6656
1 'la 2 fila sería 6656+32=6688'
1 'la 3 fila sería 6656+(32*2)=6720'
160 for i=0 to 31: vpoke 6656+i,64:next i 
161 VPOKE 6688,64:VPOKE 6719,64:VPOKE 6720,64:VPOKE 6751,64:VPOKE 6752,64:VPOKE 6783,64
1 'Pintamos el corazón de las vidas'
163 VPOKE 6690,0
1 'Pintamos la casa que indica la pantalla en la que estamos'
164 VPOKE 6696,5
1 'Pintamos el signo de puntuación para los puntos de las mnedas cogidas'
165 VPOKE 6702,7
166 for i=0 to 31: vpoke 6784+i,64:next i 
1 'Pintamos el marcador'
167 gosub 2200
1 'Pintamos al player'
168 put sprite 0,(x,y),4,p
169 mu=7:gosub 4000

1 'Main loop'
    200 j=STICK(0) OR STICK(1)
    1 ' on variable goto numero_linea1, numero_linea2,etc salta a la linea 1,2,etc o si es cero continua la ejecución '
    210 ON j GOTO 230,250,270,290,310,330,350,370
    220 p=p0:if n<ml then swap p0,p1:goto 400 else goto 400
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
    400 IF y<40 THEN y=40 else if y>112 then y=112
    410 if x<0 then x=0 else if x>250 then x=250

    1 'Colisiones con el mapa'
    420 px=x/8:py=y/8
    1 'Recuerda que trabajamos con sprites de 16x16, es decir 4 sprites de 8x8 pixeles'
    430 t0=m(px+1+n,py+1)
    1 'Se se tropieza con un tile de la muerte entonces:
        1 'llamamos a la subrrutina player muere (3000)'
    440 if t0=td(0) or t0=td(1) then gosub 3000 
    1 'Debug'
    1 '440 if t0=td(0) or t0=td(1) then mu=6:gosub 4000
    1 'Si no si el tile es un Tile Money(tm) entonces'
        1 'Hacemos un sonido re=6:gosub 4000'
        1 'actualizamos el array con los cabios'
        1 'aumentamos el sc=score'
        1 'actualizmos el marcador (2200)'
    445 if t0=tm then mu=8:gosub 4000:m(px+1+n,py+1)=tf:s=s+10:gosub 2200

    1 'Render'
    450 PUTSPRITE0,(X,Y),4,P
    1 '450 vpoke 6912,y:vpoke 6913,x:vpoke 6914,p
     
    1 'Si estamos en el final ralentizamos a LEO'
    460 if n=ml then for i=0 to 100:next i
    1 ' si estamos en el final del scroll y la posición del player es mayor de 240 llamamos a la subrrutina de cambiar pantalla (20000)
    470 if n=ml and x>240 then gosub 20000
   
    1 'moviendo el tercio superior'
    480 if n mod 10=0 and n<ml then f=0:gosub 21000
    1 'moviendo el tercio central'
    485 if n<ml then f=7:gosub 21000
    1 'Debug'
    1 '486 me$=str$(n):gosub 2000
500 goto 200

1 'imprimir mensajes sin pausa (necesita que esté inicializada me$)''
    2000 line(0,170)-(255,180),6,bf
    2010 preset (0,170):print #1,me$
2090 return

1 'Imprimir mensajes con pausa (necesita que esté inicializada me$)'
    2100 line(0,170)-(255,180),6,bf
    2110 preset (0,170):print #1,me$
    2120 if strig(0)=-1 then 2180 else 2120
    2180 line(0,170)-(255,180),6,bf
2190 return

1 'Imprimir HUD'
    1 ' par acomprender los pokes mira las lines 140-160 y el final del archivo utils.bas'
    2200 vpoke 6722,22+l
    2230 vpoke 6728,22+sc
    2240 s$=str$(s)
    2250 ls=len(s$)
    2260 for i=1 to ls-1
        2270 vpoke 6733+i,22+val(mid$(s$,i+1,1))
    2280 next i
2290 return


3000 'player muere'
    3010 mu=5:gosub 4000
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
    3040 n=0:f=7:gosub 21000
    3050 x=0:y=9*8:PUT SPRITE0,(X,Y),4,0
    1 'Mostramos el mensaje con la pausa'
    3060 me$="^Ready press space":gosub 2100
3090 return


1 '1 'Inicializar música'
1 '    3500 s1$="V13O1L4aaaV10aV13bbbV10bV13L2O2cdeg+"
1 '    3520 s2$="V14O4L8aV15O6cO5bO6cO4V14L8aaaV12aV14g+V15O6dcdO4V14L8g+g+g+V12g+V15O5aO6cO5babO6dcO5bO6cedcO5bebe"
1 '    3530 s3$="V13O4L2ecdeL8 aO5cO4bO5cO3L8aaaV10aV13g+O5dcdO3L8g+g+g+v10g+"
1 '    3540 s4$="V13L8O1aaaaV12bbbbV11ccccV10bbbbV8aaaaV5aaaaV4aaaaV1aaaa"
1 '    3550 s5$="V13L8O2aaaaV12bbbbV11ccccV10eeeeV8aaaaV5aaaaV4aaaaV1aaaa"
1 '    3560 s6$="V13L8O3eeeeV12eeeeV11eeeeV10eeeeV8eeeeV5eeeeV4eeeeV1eeee"
1 '    3570 s7$="V15O2L8cccV11cV15cccV11cV13cccV9cV11cccV7cV9cccV5cV7cccV3cV5cccV2c"
1 '    3580 S8$="V15O4L8cgegV12cgegV10cgegV7cgegV5cgegV3cgeg"
1 '    3590 S9$="R8R8R8V10O5L8cgegV12cgegV10cgegV7cgegV5cgegV3cgeg"
1 '3599 return
1 ' Reproductor de música
    4000 a=usr2(0)
    1 '4010 PLAY"T150","T150","T150"
    1  '1 ' Intro'
    1  '4020 if mu=1 then play s1$,s1$,s6$:play s1$,s2$,s6$:play s1$,s2$,s3$:play s2$,s3$,S6$:play s1$,s1$,s6$:play s4$,s5$,s6$
    1  '1 ' Nivel terminado'
    1  '4030 if mu=2 then PLAY s7$,s8$,s9$
    1  '1 ' Game over
    1  '4040 if mu=3 then PLAY s4$,s5$,s6$
    4050 if mu=5 then play "l10 o3 v4 g c"
    1 'Moneda cogida'
    4060 if mu=6 then play"t250 o4 v12 d v9 e" 
    1 'Inicio level'
    4070 if mu=7 then play "O3 L8 V4 M8000 A A D F G2 A A A A"
    1 'Cogidos puntos'
    4080 if mu=8 then sound 1,2:sound 8,16:sound 12,5:sound 13,9
    1 'Pasos'
    4090 if mu=9 then PLAY"o3 l64 t255 v4 m6500 c"
    1 'Pasos'
    4100 if mu=10 then sound 1,2:sound 6,25:sound 8,16:sound 12,1:sound 13,9
    4110 if mu=11 then sound 1,0:sound 6,25:sound 8,16:sound 12,4:sound 13,9
4199 return

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
    20050 n=0:f=0:gosub 21000
    1 'Pintamos la parte central de la pantalla'
    20060 f=7:gosub 21000
    1 'Imprimimos el marcador'
    20070 gosub 2200
    1 'Reiniciamos y pintamos al player'
    20075 x=0:y=9*8:put sprite 0,(x,y),4,p
    1 'Mostramos un mensaje con pausa'
    20080 me$="^Press space key":gosub 2100
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
                1 '20280 if tn<>0 and tn<>-1 then m(po,r)=tn:po=po+1
                20280 m(po,r)=tn:po=po+1
            20300 next i
        20310 next c
    20320 next r
    20325 call turbo off
20330 return
1 ' Pintar pantalla estática
    20500 _TURBO ON(m())
    20510 d=6144
    20520 for r=0 to 15
        1 ' ahora leemos las columnas c, 63 son 32 tiles
        20530 for c=0 to 31
            20550 VPOKE d,m(c,r)
            20560 d=d+1
        20570 next c
    20580 next r
    20590 _TURBO OFF
20599 return 
1 ' Pintar pantalla, ponemos en la tabla nombres los tiles
    21000 _TURBO ON (m(),n,f)
    21002 n=n+1
    21005 d=6144+(32*f)
    21010 for r=f to 15
        1 ' ahora leemos las columnas c, 63 son 32 tiles
        21020 for c=n to 31+n
            21040 VPOKE d,m(c,r)
            21050 d=d+1
        21060 next c
    21070 next r
    21080 _TURBO OFF
21090 return 


1 'Menu'
22000 data 1f23
22010 data 0e230010001100120d23
22020 data 0923001000110012012300300031003201230010001100120823
22030 data 092300300031003206230030003100320823
22040 data 1f23
22050 data 1f23
22060 data 0823001000110012022300130014001502230010001100120723
22070 data 0823003000310032022300330034003502230030003100320723
22080 data 1f23
22090 data 1f23
22100 data 092300100011001206230010001100120823
22110 data 0923003000310032012300100011001201230030003100320823
22120 data 0e230030003100320d23
22130 data 1f23
22140 data 1f23
22150 data 1f23



1 'Level 1
22200 data 1b230125022300250623012515230125002306250e23002500230125012303251323
22210 data 1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
22220 data 002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
22230 data 00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
22240 data 0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
22250 data 00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
22260 data 7725
22270 data 1f240f2101240f2104240d21022406210e240921
22280 data 06240d210024032105240f2101240f2104240d21022406210e240921
22290 data 06240d21002403210524032100070a2101240321012403210a24022100070121022404210224062100240c21002404210424
22300 data 0b2109240321072404210a24032101240d210224032102240b2103240c2100240421040a
22310 data 0b2103240921002411210024072101240d210224032102240b2103240c21002404210424
22320 data 062404210324092100241121002407210124032105240321022403210b240221032402210a240421040a
22340 data 062404210324092100240c2105240321052403210524102101240621032412210424
22350 data 06240c210124072104240e21052408210024102101241d21040a
22360 data 06240621000704210124072104240e21052408210024102101240d211424

1 'Level 2
22400 data 7723
22410 data 7723
22420 data 1e2301480d2301480c230148002301480023014807230148002301480a23014800230148002301480c2301480223
22430 data 02230048002301480023004811230248002301480d2301480c230748072304480a2307480c2301480223
22440 data 02230548102306480d2301480c230748072304480a2307480c2301480223
22450 data 02230548102306480d2301480c230748072304480a2307480c2301480223
22460 data 6d260922
22470 data 0d221a2102221421012211210007082106221121
22480 data 0d221a2102221421012209210d22032103221421
22490 data 0d22062100220421102205210822022100070121012213210322032103220a210922
22500 data 0a2102220121000703210022112101220e2101220421042211210322032103220a210322050a
22510 data 0a21032205210022112101220e2101220521032205210222032108220421022202211122
22520 data 052204210322052101221021012205210a22062102220421032203210a220221022202210b22050a
22540 data 06220d21022206210a220a210122152100220c21012213210622
22550 data 07220c2103221b210122152100220c21012213210022050a
22560 data 07220c2104221a210122152100220c21012213210622

1 'Level 3
22600 data 7748
22610 data 034801230848022311480023084802230648002303480123154802210a480323094802230348
22620 data 084801230a48032101480223034802231b48022103480123084803210b48012305480221024800230448
22630 data 0b48002106480621004802230048022113480021084804210748022100480721104804210748
22640 data 0148012105480321054806210448072101480123024801210348052104480621044810210c48072104480021
22650 data 7721
22660 data 7724
22670 data 04240b210024092103240d210124142104240d2107240b21002404210124030a
22680 data 04240b21002409210324082100070321012414210424132101240b21002405210424
22690 data 10210024092103240421052403210024042100240e210424052103240a2100240421072406210024020a
22700 data 052100070021042403210024032100240b210424062100240321012405210124042106240221000700210b24092100240421002408210224
22710 data 08210824032100240b210024022100240a21052402210124092101240f21002408210124042100240321002404210024000a
22720 data 04240f21012402210924022100240f21002402210124092101240f21002408210124002104240321012403210124
22730 data 04240f21012402210924022104240b210024022105240421022402210124042106240d2102240321022402210124
22740 data 04240a210624132100240b210024022101240e2101240a210024142100240621
22750 data 04240a21062413210d24022101240e2101240a210024022102240e2100240621

1 'Level 4
22800 data 1b230125022300250623012515230125002306250e23002500230125012303251323
22810 data 1223012506230125012301250623012503230125002301250c23092501230025062301250123012500230125012303250023012504230125002301250623
22820 data 002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b250123012502230125002301250123012500230125012303250023012503230225002301250623
22830 data 00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325002301250223032500230125022302250023
22840 data 0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b250123012502230125002301250123012500230125002304250023082500230125022302250023
22850 data 00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500231125022302250023
22860 data 7725
22870 data 1f240f2101240f2104240d21022406210e240921
22880 data 06240d210024032105240f2101240f2104240d21022406210e240921
22890 data 06240d210024032105240f2101240321012403210a240321042404210224062100240c2100240421040a
22900 data 0b2109240321072404210a24032101240d210024052102240b2103240c21002404210424
22910 data 0b2103240921002411210024072101240d210024052102240b2103240c2100240421040a
22920 data 062404210324092100241121002407210124032105240321032402210b240221032402210a2404210424
22940 data 062404210324092100240c210524032105240321052410210124062103241221040a
22950 data 06240c210124072104240e21052408210024102101241d210424
22960 data 06240c210124072104240e21052408210024102101240d211424

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

 
1 'En este archivo se cargar los sprites y el tileset
    9000 call turbo on
    1'Ponemos todos los sprites en la posición y 212 (abajo)
    9005 for i=0 to 31: put sprite i,(0,212),0,0:next i
    1 'Rutina cargar sprites en VRAM con datas basic'
    1 '9000 for i=0 to 5:sp$=""
    1 '    9220 for j=0 to 31
    1 '        9230 read a$
    1 '        9240 sp$=sp$+chr$(val(a$))
    1 '    9250 next J
    1 '    9260 sprite$(i)=sp$
    1 '9270 next i
    9010 'call turbo on
    9020 for i=0 to (32*6)-1
        9030 read b:vpoke 14336+i,b
    9040 next i
    9050 call turbo off

    9360 data 0,0,33,195,192,192,192,63
    9370 data 63,62,96,160,240,240,0,0
    9380 data 0,224,208,252,108,112,240,240
    9390 data 240,240,248,102,54,48,0,0
    9410 data 0,0,0,0,240,112,48,15
    9420 data 15,15,15,5,6,6,0,0
    9430 data 240,120,116,31,27,28,60,252
    9440 data 252,188,48,176,176,248,0,0
    9445 data 0,7,11,63,54,14,15,15
    9450 data 15,15,31,102,108,12,0,0
    9460 data 0,0,132,194,2,2,2,252
    9470 data 252,124,6,4,14,14,0,0
    9490 data 15,30,46,248,216,56,60,63
    9500 data 63,61,12,13,13,31,0,0
    9510 data 0,0,0,0,14,14,12,240
    9520 data 240,240,240,160,96,96,0,0
    9540 data 3,7,15,3,1,3,3,11
    9550 data 15,7,7,3,3,6,0,0
    9560 data 192,224,240,192,128,192,192,208
    9570 data 240,224,224,192,192,96,0,0
    9590 data 3,7,7,7,1,3,3,3
    9600 data 3,7,15,11,7,8,0,0
    9610 data 192,224,224,224,128,192,192,192
    9620 data 192,224,240,208,224,16,0,0
  
9990 return 

1 'Rutina cargar la definición y colores de tiles en screen 2'
    10000 call turbo on
    1' Hay que recordar la estructura de la VRAM, el tilemap se divide en 3 zonas
    1 'Nuestro tileset son X tiles o de 0 hasta el X-1'
    1 'Definiremos a partir de la posición 0 de la VRAM 18 tiles de 8 bytes'
    10030 restore 10040:FOR I=0 TO (79*8)-1
        10035 READ A$
        10036 VPOKE I,VAL("&H"+A$)
        10037 VPOKE 2048+I,VAL("&H"+A$)
        10038 VPOKE 4096+I,VAL("&H"+A$)
    10039 NEXT I



    10040 DATA E7,40,20,7E,3C,18,00,00
    10050 DATA 18,3C,3C,18,00,56,56,74
    10060 DATA 00,06,0A,14,20,30,48,00
    10070 DATA 00,00,00,08,10,20,40,00
    10080 DATA 00,00,00,18,2C,2C,18,00
    10090 DATA 00,18,3C,42,42,42,42,00
    10100 DATA FF,FF,C3,81,C2,C3,C3,00
    10110 DATA 24,FE,A4,7E,25,25,7F,24
    10120 DATA 00,7C,44,7C,00,10,10,00
    10130 DATA FF,04,02,7D,02,04,00,00
    10140 DATA 00,20,40,BE,40,20,00,00
    10150 DATA 00,08,14,2A,08,08,08,08
    10160 DATA 00,10,10,10,54,28,10,00
    10170 DATA 22,22,77,77,22,22,22,22
    10180 DATA 00,04,08,18,3C,3C,3C,3C
    10190 DATA 01,07,0F,0F,1F,3E,9C,3E
    10200 DATA C3,81,3C,18,18,3C,18,3C
    10210 DATA 80,E0,F0,F0,F8,7C,39,7C
    10220 DATA FF,07,1E,3C,3C,3C,20,08
    10230 DATA 00,00,00,00,00,C3,C3,00
    10240 DATA 00,E0,78,3C,3E,1C,18,10
    10250 DATA 00,00,00,00,00,00,00,00
    10260 DATA 00,38,44,4C,10,64,44,38
    10270 DATA 00,0C,04,04,00,04,04,04
    10280 DATA 00,38,04,04,38,40,40,78
    10290 DATA 00,38,04,04,38,04,04,38
    10300 DATA 00,44,44,44,38,04,04,04
    10310 DATA 00,38,40,40,38,04,04,38
    10320 DATA 00,38,40,40,38,44,44,38
    10330 DATA 00,38,04,04,00,04,04,04
    10340 DATA 00,38,44,44,38,44,44,38
    10350 DATA 00,38,44,44,38,04,04,38
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
    10480 DATA 00,00,00,00,00,00,00,00
    10490 DATA 00,00,00,00,00,00,00,00
    10500 DATA 00,00,00,00,00,00,00,00
    10510 DATA E2,E1,7E,C1,E0,F0,F8,FF
    10520 DATA 81,81,00,00,BD,FF,FF,FF
    10530 DATA C7,78,81,83,07,0F,3F,FF
    10540 DATA FF,FF,02,01,00,00,00,00
    10550 DATA 3C,3C,04,18,3C,3C,3C,00
    10560 DATA 00,20,00,00,00,00,00,00
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
    10740 DATA 00,F7,F7,F7,00,7F,7F,7F
    10750 DATA 6D,DB,DB,6D,6D,DB,DB,6D
    10760 DATA 6D,DB,DB,6C,6C,DB,DB,6C
    10770 DATA FF,66,66,00,00,66,66,00
    10780 DATA FF,66,66,00,00,66,66,00
    10790 DATA FF,99,99,FF,FF,99,99,FF
    10800 DATA 12,8A,A8,A0,A0,80,80,00




    1 'Definición de colores, los colores se definen a partir de la dirección 8192/&h2000'
    1 'Como la memoria se divide en 3 bancos, la parte de arriba en medio y la de abajo hay que ponerlos en 3 partes'
    13000 restore 17740:FOR I=0 TO (79*8)-1
        13010 READ A$
        13020 VPOKE 8192+I,VAL("&H"+A$): '&h2000'
        13030 VPOKE 10240+I,VAL("&H"+A$): '&h2800'
        13040 VPOKE 12288+I,VAL("&H"+A$): ' &h3000'
    13050 NEXT I
    13060 call turbo off

    17740 DATA 81,F8,F8,81,81,81,81,81
    17750 DATA B1,B1,B1,B1,B1,81,81,81
    17760 DATA 81,E1,E1,E1,61,61,61,61
    17770 DATA 61,61,61,61,61,61,61,61
    17780 DATA 61,61,61,21,21,21,21,21
    17790 DATA 21,21,21,2C,2C,2C,2C,11
    17800 DATA 91,91,A9,EA,EA,A9,E9,E9
    17810 DATA A1,A1,A1,A1,A1,A1,A1,A1
    17820 DATA A1,B1,B1,B1,B1,A1,A1,A1
    17830 DATA B1,8B,8B,8B,8B,8B,8B,8B
    17840 DATA 11,81,81,81,81,81,81,81
    17850 DATA 81,81,81,81,81,81,81,81
    17860 DATA 81,81,81,81,81,81,81,81
    17870 DATA B1,A1,A1,A1,81,81,81,81
    17880 DATA 81,D1,D1,91,91,91,91,D1
    17890 DATA F7,F7,F7,B7,F7,F7,BF,BF
    17900 DATA F7,EF,EB,FB,FB,EB,BF,BF
    17910 DATA F7,F7,F7,B7,F7,F7,BF,BF
    17920 DATA 51,E5,F5,F5,F5,E5,45,E5
    17930 DATA E5,E5,E5,E5,E5,E5,E5,E5
    17940 DATA E5,E5,F5,F5,F5,F5,F5,E5
    17950 DATA 11,11,11,11,11,11,11,11
    17960 DATA 11,31,31,31,31,31,31,31
    17970 DATA 31,31,31,31,31,31,31,31
    17980 DATA 31,31,31,31,31,31,31,31
    17990 DATA 31,31,31,31,31,31,31,31
    18000 DATA 31,31,31,31,31,31,31,31
    18010 DATA 31,31,31,31,31,31,31,31
    18020 DATA 31,21,31,31,31,31,31,31
    18030 DATA 31,31,31,31,31,31,31,31
    18040 DATA 31,31,31,31,31,31,31,31
    18050 DATA 31,31,31,31,31,31,31,31
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
    18180 DATA 91,91,91,91,91,91,91,91
    18190 DATA 91,91,91,91,91,91,91,91
    18200 DATA 91,91,91,91,91,91,91,91
    18210 DATA FB,FB,FB,7F,7F,7F,7F,7F
    18220 DATA FB,EB,EB,EB,EB,F1,F1,F1
    18230 DATA EB,BF,BF,7F,7F,7F,7F,7F
    18240 DATA 51,51,E5,E5,E5,E5,E5,E5
    18250 DATA E5,E5,45,E5,E5,F5,E5,E5
    18260 DATA E5,E5,E5,E5,E5,E5,E5,E5
    18270 DATA 11,11,11,11,11,11,11,11
    18280 DATA 11,11,11,11,11,11,11,11
    18290 DATA 11,11,11,11,11,11,11,11
    18300 DATA 11,11,11,11,11,11,11,11
    18310 DATA 11,11,11,11,11,11,11,11
    18320 DATA 11,11,11,11,11,11,11,11
    18330 DATA 11,11,11,11,11,11,11,11
    18340 DATA 11,11,11,11,11,11,11,11
    18350 DATA 11,11,11,11,11,11,11,11
    18360 DATA 11,11,11,11,11,11,11,11
    18370 DATA 11,11,11,11,11,11,11,11
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
    18500 DATA 75,51,51,51,51,51,51,51
    18510 DATA 75,11,11,11,11,11,11,11
18990 return

1 'Rutina borrar pantalla'
1 'Ponemos que en la parte del mapa solo se vea el ultimo tile, dejamos el 3 tercio sin tocar para el marcador
1 'en realidad la tabla de nombres son 768 bytes'
    19000 FOR t=6144 TO (6144+768)-97
        19010 vpoke t,255
    19020 next t
19090 return


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







