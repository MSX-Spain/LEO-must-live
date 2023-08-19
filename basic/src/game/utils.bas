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
    9020 for i=0 to (32*6)-1
        9030 read b:vpoke 14336+i,b
    9040 next i
    9050 'call turbo off

    9360 data 0,0,0,0,33,195,192,192
    9370 data 192,63,63,62,96,160,240,240
    9380 data 0,0,0,224,208,252,108,112
    9390 data 240,240,240,240,248,102,54,48
    9400 rem data definition sprite 1, name: Sprite-1
    9410 data 0,0,0,0,0,0,240,112
    9420 data 48,15,15,15,15,5,6,6
    9430 data 0,0,240,120,116,31,27,28
    9440 data 60,252,252,188,48,176,176,248

    9445 data 0,0,0,7,11,63,54,14
    9450 data 15,15,15,15,31,102,108,12
    9460 data 0,0,0,0,132,194,2,2
    9470 data 2,252,252,124,6,4,14,14
    9480 rem data definition sprite 3, name: Sprite-3
    9490 data 0,0,15,30,46,248,216,56
    9500 data 60,63,63,61,12,13,13,31
    9510 data 0,0,0,0,0,0,14,14
    9520 data 12,240,240,240,240,160,96,96
    9530 rem data definition sprite 4, name: Sprite-3
    9540 data 0,0,7,15,31,7,3,3
    9550 data 3,7,15,15,15,6,6,15
    9560 data 0,0,192,224,240,192,128,128
    9570 data 128,192,224,224,224,192,192,224
    9580 rem data definition sprite 5, name: Sprite-3
    9590 data 0,0,7,15,31,7,3,3
    9600 data 19,15,15,15,15,12,16,0
    9610 data 0,0,192,224,240,192,128,128
    9620 data 144,224,224,224,224,192,32,0
   
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



    19000 'call turbo off
19990 return




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







