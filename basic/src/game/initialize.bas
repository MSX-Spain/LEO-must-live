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

