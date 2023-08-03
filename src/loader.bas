<<<<<<< HEAD
1 ' ------------------------------------'
1 '     Loader - inicializador          '
1 ' ------------------------------------'




1 ' Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0)
20 COLOR15,0,0:SCREEN2,2


1 ' Mostramos la pantalla de carga'
30 bload "loader.sc2", s
40 OPEN"grp:"AS#1:COLOR15:PRESET(0,10):PRINT#1,"Cargando..."


1 ' Definicimos la estructura de nuestras entidades'


1 ' Definimos nuestro mapa o niveles'




1 ' Cargamos nuestros gráficos'
1000 'gosub 9700


1 ' Cargamos nuestros sprites'



1 ' Cargamos el main'
3000 load "game.bas",r
















=======
1 'CHEQUEO DE MAQUINA Y REQUISITOS NECESIARIOS

1 ' Inicialización del sistema

1 'Cargamos la pantalla de carga

1 'Cargamos los sprites

1 'Cargamos el main.bas
10 run"game.bas"
>>>>>>> refs/remotes/origin/main
