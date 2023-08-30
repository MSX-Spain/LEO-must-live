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
    9020 for i=0 to (32*13)-1
        9030 read b:vpoke 14336+i,b
    9040 next i
    9050 call turbo off


    9060 data 0,0,33,195,192,192,192,63
    9070 data 63,62,96,160,240,240,0,0
    9080 data 0,224,208,252,108,112,240,240
    9090 data 240,240,248,102,54,48,0,0
    9100 data 0,0,0,0,240,112,48,15
    9110 data 15,15,15,5,6,6,0,0
    9120 data 240,120,116,31,27,28,60,252
    9130 data 252,188,48,176,176,248,0,0
    9140 data 0,7,11,63,54,14,15,15
    9150 data 15,15,31,102,108,12,0,0
    9160 data 0,0,132,194,2,2,2,252
    9170 data 252,124,6,4,14,14,0,0
    9180 data 15,30,46,248,216,56,60,63
    9190 data 63,61,12,13,13,31,0,0
    9200 data 0,0,0,0,14,14,12,240
    9210 data 240,240,240,160,96,96,0,0
    9220 data 3,7,15,1,3,3,11,15
    9230 data 7,7,3,7,13,1,0,0
    9240 data 192,224,240,128,192,192,208,240
    9250 data 224,224,192,224,176,128,0,0
    9260 data 1,7,7,7,1,3,3,3
    9270 data 7,15,11,7,9,1,0,0
    9280 data 128,224,224,224,128,192,192,192
    9290 data 224,240,208,224,144,128,0,0
    9300 data 0,0,0,0,0,0,127,255
    9310 data 255,190,99,163,243,243,0,0
    9320 data 0,0,0,0,0,56,190,223
    9330 data 253,55,159,70,102,96,0,0
    9340 data 0,0,0,0,0,0,0,0
    9350 data 0,0,31,255,255,127,0,0
    9360 data 0,0,0,0,0,0,0,112
    9370 data 248,240,248,255,255,252,0,0
    9380 data 3,11,7,1,3,18,19,31
    9390 data 7,3,3,3,7,6,14,14
    9400 data 192,192,192,64,192,194,198,248
    9410 data 224,192,192,192,224,96,96,224
    9420 data 0,0,3,11,7,1,3,3
    9430 data 2,3,7,31,2,9,7,7
    9440 data 0,0,192,192,192,64,192,64
    9450 data 64,224,224,64,192,192,224,120
    9460 data 3,3,3,17,19,18,55,63
    9470 data 19,19,19,19,7,6,14,14
    9480 data 224,240,192,64,192,192,192,224
    9490 data 224,224,224,192,224,96,96,224
    9500 data 0,11,11,11,17,51,59,38
    9510 data 39,35,35,67,67,71,6,7
    9520 data 0,224,240,192,64,196,72,80
    9530 data 224,192,192,192,192,224,96,112
    9540 data 0,0,1,3,6,9,1,3
    9550 data 7,9,1,3,7,14,1,3
    9560 data 0,0,192,224,176,200,64,224
    9570 data 240,200,192,224,240,56,64,96
9990 return 

1 'Rutina cargar la definición y colores de tiles en screen 2'
    10000 call turbo on
    1' Hay que recordar la estructura de la VRAM, el tilemap se divide en 3 zonas
    1 'Nuestro tileset son X tiles o de 0 hasta el X-1'
    1 'Definiremos a partir de la posición 0 de la VRAM 18 tiles de 8 bytes'
    10030 restore 10040:FOR I=0 TO (95*8)-1
        10035 READ A$
        10036 VPOKE I,VAL("&H"+A$)
        10037 VPOKE 2048+I,VAL("&H"+A$)
        10038 VPOKE 4096+I,VAL("&H"+A$)
    10039 NEXT I
    10040 DATA E7,40,20,7E,3C,18,00,00
    10050 DATA 00,18,3C,42,42,42,42,00
    10060 DATA 24,FE,A4,7E,25,25,7F,24
    10070 DATA 18,3C,3C,3C,3C,3C,3C,3C
    10080 DATA 00,00,00,00,00,00,00,00
    10090 DATA 00,00,00,00,00,00,00,00
    10100 DATA FF,FF,C3,81,C2,C3,C3,00
    10110 DATA 18,3C,3C,18,00,56,56,74
    10120 DATA 00,7C,44,7C,00,10,10,00
    10130 DATA 00,04,08,18,3C,3C,3C,3C
    10140 DATA 01,07,0F,0F,1F,3E,9C,3E
    10150 DATA C3,81,3C,18,18,3C,18,3C
    10160 DATA 80,E0,F0,F0,F8,7C,39,7C
    10170 DATA FF,07,1E,3C,3C,3C,20,08
    10180 DATA 00,00,00,00,00,C3,C3,00
    10190 DATA 00,E0,78,3C,3E,1C,18,10
    10200 DATA 18,D2,D6,1F,0F,0F,07,07
    10210 DATA 0C,4B,3B,27,8F,F0,E0,E0
    10220 DATA 01,01,01,03,07,07,07,07
    10230 DATA 80,80,C0,C0,E0,E0,F0,F0
    10240 DATA C0,E0,20,20,30,10,FF,34
    10250 DATA 60,60,60,78,FC,FE,10,6A
    10260 DATA 78,08,38,40,30,30,31,35
    10270 DATA 07,0F,0F,07,1F,1F,00,00
    10280 DATA F0,C0,E0,F0,FC,F8,E0,60
    10290 DATA E2,C1,D0,C0,C0,F8,FF,FF
    10300 DATA 0F,87,4F,07,07,0F,E0,60
    10310 DATA 00,03,3F,37,82,80,FC,FF
    10320 DATA FF,3C,00,18,00,0C,DF,FF
    10330 DATA FF,CF,07,47,07,1F,3F,FF
    10340 DATA FF,E7,C3,A3,B1,83,FF,FF
    10350 DATA FF,FF,F3,E4,C2,80,E5,FF
    10360 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10370 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10380 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10390 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10400 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10410 DATA FF,FF,52,00,10,24,00,00
    10420 DATA FF,FF,52,00,08,20,00,00
    10430 DATA 6D,DB,DB,6D,6D,DB,DB,6D
    10440 DATA 6D,DB,DB,6C,6C,DB,DB,6C
    10450 DATA FF,04,02,7D,02,04,00,00
    10460 DATA E2,E1,7E,C1,E0,F0,F8,FF
    10470 DATA 81,81,00,00,BD,FF,FF,FF
    10480 DATA C7,78,81,83,07,0F,3F,FF
    10490 DATA FF,FF,02,01,00,00,00,00
    10500 DATA 3C,3C,04,18,3C,3C,3C,00
    10510 DATA 00,20,00,00,00,00,00,00
    10520 DATA 00,38,44,4C,10,64,44,38
    10530 DATA 00,0C,04,04,00,04,04,04
    10540 DATA 00,38,04,04,38,40,40,78
    10550 DATA 00,38,04,04,38,04,04,38
    10560 DATA 00,44,44,44,38,04,04,04
    10570 DATA 00,38,40,40,38,04,04,38
    10580 DATA 00,38,40,40,38,44,44,38
    10590 DATA 00,38,04,04,00,04,04,04
    10600 DATA 00,38,44,44,38,44,44,38
    10610 DATA 00,38,44,44,38,04,04,38
    10620 DATA 00,1C,22,22,1C,22,22,22
    10630 DATA 00,3C,22,22,1C,22,22,3C
    10640 DATA 00,1C,20,20,00,20,20,1C
    10650 DATA 00,3C,22,22,00,22,22,3C
    10660 DATA 00,3C,20,20,1C,20,20,3C
    10670 DATA 00,3C,20,20,1C,20,20,20
    10680 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10690 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10700 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10710 DATA C0,F8,07,02,01,00,00,00
    10720 DATA 01,01,87,FA,FA,AD,79,01
    10730 DATA 00,00,00,00,00,03,C2,F5
    10740 DATA 00,00,A8,F8,86,7A,7D,85
    10750 DATA 00,04,02,01,77,F7,FF,80
    10760 DATA 58,28,0C,9C,02,FF,FE,FE
    10770 DATA 0F,07,0F,0F,0F,1F,1F,10
    10780 DATA 80,C0,E0,B0,60,70,78,B8
    10790 DATA 22,22,77,77,22,22,22,22
    10800 DATA 00,38,40,40,0C,44,44,38
    10810 DATA 00,44,44,44,38,44,44,44
    10820 DATA 00,10,10,10,00,10,10,10
    10830 DATA 00,04,04,04,00,44,44,38
    10840 DATA 00,44,48,50,38,44,44,44
    10850 DATA 00,40,40,40,00,40,40,3C
    10860 DATA 00,38,54,54,00,44,44,44
    10870 DATA 00,64,54,4C,00,44,44,44
    10880 DATA 00,38,44,44,00,44,44,38
    10890 DATA 00,78,44,44,38,40,40,40
    10900 DATA 00,38,44,44,00,44,48,34
    10910 DATA 00,78,44,44,38,50,48,44
    10920 DATA 00,3C,40,40,38,04,04,78
    10930 DATA 00,7C,10,10,00,10,10,10
    10940 DATA 00,44,44,44,00,44,44,38
    10950 DATA 00,44,44,44,08,50,60,40
    10960 DATA 00,44,44,44,00,54,54,38
    10970 DATA 00,44,44,28,10,28,44,44
    10980 DATA 00,44,44,44,38,04,04,38
    10990 DATA 00,3C,04,08,10,20,40,78




    1 'Definición de colores, los colores se definen a partir de la dirección 8192/&h2000'
    1 'Como la memoria se divide en 3 bancos, la parte de arriba en medio y la de abajo hay que ponerlos en 3 partes'
    13000 restore 17740:FOR I=0 TO (95*8)-1
        13010 READ A$
        13020 VPOKE 8192+I,VAL("&H"+A$): '&h2000'
        13030 VPOKE 10240+I,VAL("&H"+A$): '&h2800'
        13040 VPOKE 12288+I,VAL("&H"+A$): ' &h3000'
    13050 NEXT I
    13060 call turbo off


    17740 DATA 81,F8,F8,81,81,81,81,81
    17750 DATA 81,21,21,2C,2C,2C,2C,11
    17760 DATA A1,A1,A1,A1,A1,A1,A1,A1
    17770 DATA B1,61,61,61,61,61,61,61
    17780 DATA 61,61,61,61,61,61,61,61
    17790 DATA 61,61,61,61,61,61,61,61
    17800 DATA 91,91,A9,EA,EA,A9,E9,E9
    17810 DATA B1,B1,B1,B1,B1,81,81,81
    17820 DATA 81,B1,B1,B1,B1,A1,A1,A1
    17830 DATA A1,D1,D1,91,91,91,91,D1
    17840 DATA F7,F7,F7,B7,F7,F7,BF,BF
    17850 DATA F7,EF,EB,FB,FB,EB,BF,BF
    17860 DATA F7,F7,F7,B7,F7,F7,BF,BF
    17870 DATA 51,E5,F5,F5,F5,E5,45,E5
    17880 DATA E5,E5,E5,E5,E5,E5,E5,E5
    17890 DATA E5,E5,F5,F5,F5,F5,F5,E5
    17900 DATA EF,FB,AB,BF,BF,AF,AF,BF
    17910 DATA EF,EB,FB,FB,FA,BF,AF,BF
    17920 DATA BF,BF,AF,EF,AF,AF,AF,AF
    17930 DATA AF,AF,EF,BF,BF,AF,AF,AF
    17940 DATA 97,97,97,97,97,97,97,B9
    17950 DATA 97,97,97,97,97,97,B9,B9
    17960 DATA 97,97,97,97,97,97,B9,B9
    17970 DATA 27,27,27,27,27,27,27,27
    17980 DATA 27,27,27,27,27,27,97,97
    17990 DATA 72,72,72,72,72,72,72,72
    18000 DATA 72,72,72,72,72,72,97,97
    18010 DATA 97,F7,F7,F7,EF,7F,7F,7F
    18020 DATA 7F,7F,7F,EF,EF,7F,7F,7F
    18030 DATA 7F,7F,7F,7F,7F,7F,7F,7F
    18040 DATA 7F,7F,7F,7F,EF,7F,7F,7F
    18050 DATA 7F,7F,7F,7F,7F,7F,7F,7F
    18060 DATA 91,91,91,91,91,91,91,91
    18070 DATA 51,51,51,51,51,51,51,51
    18080 DATA 71,71,71,71,71,71,71,71
    18090 DATA 61,61,61,61,61,61,61,61
    18100 DATA E1,E1,E1,E1,E1,E1,E1,E1
    18110 DATA 21,21,23,23,23,23,23,23
    18120 DATA 91,91,9E,9E,9E,9E,9E,9E
    18130 DATA E1,51,E1,51,E1,51,E1,51
    18140 DATA E1,51,E1,51,E1,51,E1,51
    18150 DATA B1,8B,8B,8B,8B,8B,8B,8B
    18160 DATA FB,FB,FB,7F,7F,7F,7F,7F
    18170 DATA FB,EB,EB,EB,EB,F1,F1,F1
    18180 DATA EB,BF,BF,7F,7F,7F,7F,7F
    18190 DATA 51,51,E5,E5,E5,E5,E5,E5
    18200 DATA E5,E5,45,E5,E5,F5,E5,E5
    18210 DATA E5,E5,E5,E5,E5,E5,E5,E5
    18220 DATA 11,31,31,31,31,31,31,31
    18230 DATA 31,31,31,31,31,31,31,31
    18240 DATA 31,31,31,31,31,31,31,31
    18250 DATA 31,31,31,31,31,31,31,31
    18260 DATA 31,31,31,31,31,31,31,31
    18270 DATA 31,31,31,31,31,31,31,31
    18280 DATA 31,21,31,31,31,31,31,31
    18290 DATA 31,31,31,31,31,31,31,31
    18300 DATA 31,31,31,31,31,31,31,31
    18310 DATA 31,31,31,31,31,31,31,31
    18320 DATA 31,31,31,31,31,31,31,31
    18330 DATA 31,31,31,31,31,31,31,31
    18340 DATA 31,31,31,31,31,31,31,31
    18350 DATA 31,31,31,31,31,31,31,31
    18360 DATA 31,31,31,31,31,31,31,31
    18370 DATA 31,31,31,31,31,31,31,31
    18380 DATA B1,B1,B1,B1,B1,B1,B1,B1
    18390 DATA 31,31,31,31,31,31,31,31
    18400 DATA E1,E1,E1,E1,E1,E1,E1,E1
    18410 DATA E1,E1,E1,E1,E1,E1,E1,E1
    18420 DATA E1,E1,F1,E1,E1,E1,E1,E1
    18430 DATA E1,E1,E1,E1,E1,B1,E1,E1
    18440 DATA E1,E1,B1,E1,E1,E1,F1,F1
    18450 DATA F1,61,61,61,21,21,21,E2
    18460 DATA 61,61,A1,61,26,26,21,21
    18470 DATA A1,61,61,61,61,A1,61,61
    18480 DATA A1,A1,A1,A1,61,61,61,61
    18490 DATA B1,A1,A1,A1,81,81,81,81
    18500 DATA 81,31,31,31,31,31,31,31
    18510 DATA 31,31,31,31,31,31,31,31
    18520 DATA 31,31,31,31,31,31,31,31
    18530 DATA 31,31,31,31,31,31,31,31
    18540 DATA 31,31,31,31,31,31,31,31
    18550 DATA 31,21,31,31,31,31,31,31
    18560 DATA 31,31,31,31,31,31,31,31
    18570 DATA 31,31,31,31,31,31,31,31
    18580 DATA 31,31,31,31,31,31,31,31
    18590 DATA 31,31,31,31,31,31,31,31
    18600 DATA 31,31,31,31,31,31,31,31
    18610 DATA 31,31,31,31,31,31,31,31
    18620 DATA 31,31,31,31,31,31,31,31
    18630 DATA 31,31,31,31,31,31,31,31
    18640 DATA 31,31,31,31,31,31,31,31
    18650 DATA 31,31,31,31,31,31,31,31
    18660 DATA 31,31,31,31,31,31,31,31
    18670 DATA 31,31,31,31,31,31,31,31
    18680 DATA 31,31,31,31,31,31,31,31
    18690 DATA 31,31,31,31,31,31,31,31
18999 return

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







