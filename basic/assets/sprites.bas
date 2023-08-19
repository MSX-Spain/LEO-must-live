10200 screen 5,2
10210 for i=0 to 5:sp$=""
	10220 for j=0 to 31
		10230 read a$
		10240 sp$=sp$+chr$(val(a$))
	10250 next J
	10260 sprite$(i)=sp$
10270 next i

10350 rem sprites data definitions
10360 rem data definition sprite 0, name: Sprite-2
10370 data 0,0,0,0,0,0,0,24
10380 data 32,32,35,31,15,28,48,48
10390 data 0,0,0,0,0,0,0,20
10400 data 26,30,188,232,244,234,10,0
10410 rem data definition sprite 1, name: Sprite-2
10420 data 0,0,0,0,0,0,0,0
10430 data 0,192,49,15,7,6,1,0
10440 data 0,0,0,0,0,0,0,10
10450 data 13,15,222,244,232,80,168,168
10460 rem data definition sprite 2, name: Sprite-2
10470 data 0,0,0,0,0,0,0,40
10480 data 88,120,61,23,47,87,80,0
10490 data 0,0,0,0,0,0,0,24
10500 data 4,4,196,248,240,56,12,12
10510 rem data definition sprite 3, name: Sprite-2
10520 data 0,0,0,0,0,0,0,80
10530 data 176,240,123,47,23,10,21,21
10540 data 0,0,0,0,0,0,0,0
10550 data 0,2,140,240,224,96,128,0
10560 rem data definition sprite 4, name: Sprite-2
10570 data 0,0,0,0,0,2,3,3
10580 data 1,1,3,6,5,6,26,33
10590 data 0,0,0,0,0,32,224,224
10600 data 192,192,224,240,240,160,160,192
10610 rem data definition sprite 5, name: Sprite-2
10620 data 0,0,0,0,0,2,1,3
10630 data 19,9,7,7,3,3,1,2
10640 data 0,0,0,0,0,64,128,192
10650 data 200,144,224,224,224,192,128,64

10840 goto 10840
