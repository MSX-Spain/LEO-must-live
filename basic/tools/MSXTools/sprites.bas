10200 screen 5,2
10210 for i=0 to 11:sp$=""
	10220 for j=0 to 31
		10230 read a$
		10240 sp$=sp$+chr$(val(a$))
	10250 next J
	10260 sprite$(i)=sp$
10270 next i
10280 for i=0 to 11:sp$=""
	10290 for j=0 to 15
		10300 read a$
		10310 sp$=sp$+chr$(val(a$)) 
	10320 next J
	10330 color sprite$(i)=sp$
10340 next I
10350 rem sprites data definitions
10360 rem data definition sprite 0, name: Sprite-0
10370 data 0,0,33,195,192,192,192,63
10380 data 63,62,96,160,240,240,0,0
10390 data 0,224,208,252,108,112,240,240
10400 data 240,240,248,102,54,48,0,0
10410 rem data definition sprite 1, name: Sprite-1
10420 data 0,0,0,0,240,112,48,15
10430 data 15,15,15,5,6,6,0,0
10440 data 240,120,116,31,27,28,60,252
10450 data 252,188,48,176,176,248,0,0
10460 rem data definition sprite 2, name: Sprite-2
10470 data 0,7,11,63,54,14,15,15
10480 data 15,15,31,102,108,12,0,0
10490 data 0,0,132,194,2,2,2,252
10500 data 252,124,6,4,14,14,0,0
10510 rem data definition sprite 3, name: Sprite-3
10520 data 15,30,46,248,216,56,60,63
10530 data 63,61,12,13,13,31,0,0
10540 data 0,0,0,0,14,14,12,240
10550 data 240,240,240,160,96,96,0,0
10560 rem data definition sprite 4, name: Sprite-4
10570 data 3,7,15,1,3,3,11,15
10580 data 7,7,3,7,13,1,0,0
10590 data 192,224,240,128,192,192,208,240
10600 data 224,224,192,224,176,128,0,0
10610 rem data definition sprite 5, name: Sprite-4
10620 data 1,7,7,7,1,3,3,3
10630 data 7,15,11,7,9,1,0,0
10640 data 128,224,224,224,128,192,192,192
10650 data 224,240,208,224,144,128,0,0
10660 rem data definition sprite 6, name: Sprite-6
10670 data 0,0,0,0,0,0,127,255
10680 data 255,190,99,163,243,243,0,0
10690 data 0,0,0,0,0,56,190,223
10700 data 253,55,159,70,102,96,0,0
10710 rem data definition sprite 7, name: Sprite-6
10720 data 0,0,0,0,0,28,125,251
10730 data 191,236,249,98,102,6,0,0
10740 data 0,0,0,0,0,0,254,255
10750 data 255,125,198,196,206,206,0,0
10760 rem data definition sprite 8, name: Sprite-8
10770 data 0,0,0,0,0,0,0,0
10780 data 0,0,31,255,255,127,0,0
10790 data 0,0,0,0,0,0,0,112
10800 data 248,240,248,255,255,252,0,0
10810 rem data definition sprite 9, name: Sprite-9
10820 data 3,11,7,1,3,18,19,31
10830 data 7,3,3,3,7,6,14,14
10840 data 192,192,192,64,192,194,198,248
10850 data 224,192,192,192,224,96,96,224
10860 rem data definition sprite 10, name: Sprite-9
10870 data 3,3,3,17,19,18,55,63
10880 data 19,19,19,19,7,6,14,14
10890 data 224,240,192,64,192,192,192,224
10900 data 224,224,224,192,224,96,96,224
10910 rem data definition sprite 11, name: Sprite-9
10920 data 0,0,1,3,6,9,1,3
10930 data 7,9,1,3,7,14,1,3
10940 data 0,0,192,224,176,200,64,224
10950 data 240,200,192,224,240,56,64,96
10960 rem data colors definitions sprite 0, name: Sprite-0
10960 data 0,6,6,6,6,6,9,9,6,6,6,6,9,9,9,9
10970 rem data colors definitions sprite 1, name: Sprite-1
10970 data 6,6,6,6,6,6,9,9,6,6,6,6,9,9,9,9
10980 rem data colors definitions sprite 2, name: Sprite-2
10980 data 0,6,6,6,6,6,9,9,6,6,6,6,9,9,9,9
10990 rem data colors definitions sprite 3, name: Sprite-3
10990 data 6,6,6,6,6,6,9,9,6,6,6,6,9,9,9,9
11000 rem data colors definitions sprite 4, name: Sprite-4
11000 data 6,6,6,6,6,9,9,6,6,6,6,9,9,9,9,9
11010 rem data colors definitions sprite 5, name: Sprite-4
11010 data 6,6,6,6,6,9,9,6,6,6,6,9,9,9,9,9
11020 rem data colors definitions sprite 6, name: Sprite-6
11020 data 0,0,0,0,0,6,6,6,6,6,6,6,9,9,9,9
11030 rem data colors definitions sprite 7, name: Sprite-6
11030 data 0,0,0,0,0,6,6,6,6,6,6,6,9,9,9,9
11040 rem data colors definitions sprite 8, name: Sprite-8
11040 data 0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1
11050 rem data colors definitions sprite 9, name: Sprite-9
11050 data 8,8,8,11,11,11,8,8,4,4,4,4,4,4,4,4
11060 rem data colors definitions sprite 10, name: Sprite-9
11060 data 14,14,14,11,11,11,8,8,5,5,5,5,1,1,1,6
11070 rem data colors definitions sprite 11, name: Sprite-9
11070 data 0,0,14,11,11,11,11,9,5,5,5,5,1,1,1,6
11080 rem data atrubutes sprite 0, name: Sprite-0
11090 put sprite 0,(1,0),,0
11100 rem data atrubutes sprite 1, name: Sprite-1
11110 put sprite 1,(34,0),,1
11120 rem data atrubutes sprite 2, name: Sprite-2
11130 put sprite 2,(67,0),,2
11140 rem data atrubutes sprite 3, name: Sprite-3
11150 put sprite 3,(100,0),,3
11160 rem data atrubutes sprite 4, name: Sprite-4
11170 put sprite 4,(133,0),,4
11180 rem data atrubutes sprite 5, name: Sprite-4
11190 put sprite 5,(166,0),,5
11200 rem data atrubutes sprite 6, name: Sprite-6
11210 put sprite 6,(199,0),,6
11220 rem data atrubutes sprite 7, name: Sprite-6
11230 put sprite 7,(0,33),,7
11240 rem data atrubutes sprite 8, name: Sprite-8
11250 put sprite 8,(33,33),,8
11260 rem data atrubutes sprite 9, name: Sprite-9
11270 put sprite 9,(66,33),,9
11280 rem data atrubutes sprite 10, name: Sprite-9
11290 put sprite 10,(99,33),,10
11300 rem data atrubutes sprite 11, name: Sprite-9
11310 put sprite 11,(132,33),,11
11320 goto 11320
