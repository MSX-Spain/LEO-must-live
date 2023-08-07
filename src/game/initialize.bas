1 'Color caracteres, fondo, borde'
10 cls:color 1,15,15:key off
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E, inicializamos el psg &h90'
1 '&h41 y &h44 Enlazamos con las rutinas de apagar y encender la pantalla'
20 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0):defusr3=&h41:defusr4=&h44
25 screen 2,2,0
1 'Todas las variables serán enteras'
30 defint a-z
1 'Definimos un canal necesario para poder mostrar texto, habrá que poner en el print o input #1'
35 open "grp:" as #1
40 print #1,"Loading sprites"
1 'cargamos los sprites en VRAM'
45 gosub 9000
50 print #1,"Loading tileset"
1 'Cargamos los tiles'
55 gosub 10000