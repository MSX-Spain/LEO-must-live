10cls:color15,1,1:keyoff
30screen2,2,0
40definta-z
50open"grp:"as#1
60 me$="Loading sprites":gosub 2000
70gosub9000
80 me$="Loading tileset":gosub 2000
90gosub10000
120f=1:ts=37:td=30:mc=0:ml=60:dimm(100,16)
125gosub20200
130gosub1800
140x=0:y=9*8:v=8:P=0:P0=0:P1=1:P2=2:P3=3:P4=4:P5=5:PUTSPRITE0,(x,y),4,p
150time=0:tw=0
160goto500
200'Mainloop'
200s=STICK(0)ORSTICK(1)
210ONsGOTO230,250,270,290,310,330,350,370
220goto400
230Y=Y-4
240GOTO400
250X=X+4:ifa=0andt5>=tstheno=y:a=1
260P=P0:SWAPP0,P1:GOTO400
270X=X+v
280P=P0:SWAPP0,P1:GOTO400
290X=X+v
300P=P0:SWAPP0,P1:GOTO400
310Y=Y+4
320P=P0:SWAPP0,P1:GOTO400
330'Y=Y+4:X=X-4
340P=P2:SWAPP2,P3:GOTO400
350X=X-v
360P=P2:SWAPP2,P3:GOTO400
370X=X-v:ifa=0andt5>=tstheno=y:a=1
380P=P2:SWAPP2,P3
400PUTSPRITE0,(X,Y),4,P
420gosub21000
430ifmc=mlthenprint#1,"fasecompletada":goto1800
500goto200
    1800 me$="menu pricipal, pulse una tecla":gosub 2000
1810ONSTRIGgosub1890:STRIG(0)ON
1820GOTO1820
1890STRIG(0)OFF:RETURN140
2000line(0,140)-(255,150),1,bf
2010preset(0,140):print#1,me$
2090return
20200restore22000
20205forr=0to15
20210READmp$:po=0
20220forc=0tolen(mp$)step4
20230r$=mid$(mp$,c+1,2)
20240tn$=mid$(mp$,c+3,2)
20250tn=val("&h"+tn$):tn=tn-1
20260re=val("&h"+r$)
20270fori=0tore
20280iftn<>0andtn<>-1thenm(po,r)=tn:po=po+1
20300nexti
20310nextc
20320nextr
20330return
21000_TURBOON(m(),mc)
21001restore22000
21002mc=mc+1
21005md=6144
21010forf=0to15
21020forc=mcto31+mc
21030tn=m(c,f)
21040VPOKEmd,tn
21050md=md+1
21060nextc
21070nextf
21080_TURBOOFF
22000data1b230125022300250623012515230125002306250e2300250023012501230325
22010data1223012506230125012301250623012503230125002301250c2309250123002506230125012301250023012501230325
22020data002301250a230125022301250423032501230125042303250323012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
22030data00230125012301250623012500230325042303250123012504230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012501230325
22040data0023012501230125062301250023032502230525012301250023012501230325002301250023012500230125012300250223012502230b25012301250223012500230125012301250023012500230425
22050data00230125012302250323032500230325022305250123012500230125012303250023012500230125002304250223012502230b25012301250223012500230125012301250023012500230425
22060data6325
22070data6321
22080data41210045142100470a21
22090data1d21234800450221114800470a21
22100data1d2100480d210048132100450221004810210047072101480021
22110data02211b480d210e4809211c480021
22120data1d2100480b2100460e2100480921004805210047122101480021
22130data1d2100480821024800460e21114800471521
22140data1d210a4801210046202100471521
22150data4c2100471521
23190return
9000fori=0to31:putspritei,(0,212),0,0:nexti
9010'callturboon
9020fori=0to(32*6)-1
9030readb:vpoke14336+i,b
9040nexti
9050'callturbooff
9360data0,0,0,0,33,195,192,192
9370data192,63,63,62,96,160,240,240
9380data0,0,0,224,208,252,108,112
9390data240,240,240,240,248,102,54,48
9400remdatadefinitionsprite1,name:Sprite-1
9410data0,0,0,0,0,0,240,112
9420data48,15,15,15,15,5,6,6
9430data0,0,240,120,116,31,27,28
9440data60,252,252,188,48,176,176,248
9445data0,0,0,7,11,63,54,14
9450data15,15,15,15,31,102,108,12
9460data0,0,0,0,132,194,2,2
9470data2,252,252,124,6,4,14,14
9480remdatadefinitionsprite3,name:Sprite-3
9490data0,0,15,30,46,248,216,56
9500data60,63,63,61,12,13,13,31
9510data0,0,0,0,0,0,14,14
9520data12,240,240,240,240,160,96,96
9530remdatadefinitionsprite4,name:Sprite-3
9540data0,0,7,15,31,7,3,3
9550data3,7,15,15,15,6,6,15
9560data0,0,192,224,240,192,128,128
9570data128,192,224,224,224,192,192,224
9580remdatadefinitionsprite5,name:Sprite-3
9590data0,0,7,15,31,7,3,3
9600data19,15,15,15,15,12,16,0
9610data0,0,192,224,240,192,128,128
9620data144,224,224,224,224,192,32,0
9990return
10000'callturboon
10005FORt=6144TO(6144+768)-256
10010vpoket,255
10020nextt
10030restore10040:FORI=0TO(79*8)-1
10035READA$
10036VPOKEI,VAL("&H"+A$)
10037VPOKE2048+I,VAL("&H"+A$)
10038NEXTI
10040DATAE7,40,20,7E,3C,18,00,00
10050DATA18,3C,3C,18,00,56,56,74
10060DATA00,06,0A,14,20,30,48,00
10070DATA00,00,00,08,10,20,40,00
10080DATA00,00,00,18,2C,2C,18,00
10090DATA00,18,3C,42,42,42,42,00
10100DATA04,08,18,3C,3C,3C,3C,00
10110DATA00,3E,22,3E,00,08,08,00
10120DATA08,14,2A,08,08,08,08,00
10130DATA00,04,02,7D,02,04,00,00
10140DATA00,20,40,BE,40,20,00,00
10150DATA10,10,10,54,28,10,00,00
10160DATA00,00,00,00,00,00,00,00
10170DATA00,00,00,00,00,00,00,00
10180DATA00,00,00,00,00,00,00,00
10190DATA00,00,00,00,00,00,00,00
10200DATA00,00,00,00,00,00,00,00
10210DATA00,00,00,00,00,00,00,00
10220DATA00,00,00,00,00,00,00,00
10230DATA00,00,00,00,00,00,00,00
10240DATA00,00,00,00,00,00,00,00
10250DATA00,00,00,00,00,00,00,00
10260DATA00,00,00,00,00,00,00,00
10270DATA00,00,00,00,00,00,00,00
10280DATA00,00,00,00,00,00,00,00
10290DATA00,00,00,00,00,00,00,00
10300DATA00,00,00,00,00,00,00,00
10310DATA00,00,00,00,00,00,00,00
10320DATA00,00,00,00,00,00,00,00
10330DATA00,00,00,00,00,00,00,00
10340DATA44,44,EE,EE,44,44,44,44
10350DATA00,00,00,00,00,00,00,00
10360DATAFF,FF,FF,FF,FF,FF,FF,FF
10370DATAFF,FF,FF,FF,FF,FF,FF,FF
10380DATAFF,FF,FF,FF,FF,FF,FF,FF
10390DATAFF,FF,FF,FF,FF,FF,FF,FF
10400DATAFF,FF,FF,FF,FF,FF,FF,FF
10410DATAFF,FF,52,00,10,24,00,00
10420DATAFF,FF,52,00,08,20,00,00
10430DATA54,38,10,10,10,10,10,10
10440DATAFF,00,7E,00,24,00,24,00
10450DATA7E,24,24,24,24,24,24,24
10460DATA7E,00,24,00,24,18,00,00
10470DATA24,81,FF,00,00,00,00,00
10480DATA12,8A,A8,A0,A0,80,80,00
10490DATA51,00,00,00,00,00,00,00
10500DATA51,00,00,00,00,00,00,00
10510DATA54,55,15,05,05,01,01,00
10520DATA00,00,00,00,00,00,00,00
10530DATAFF,00,3F,00,1F,00,07,00
10540DATAFF,00,FF,00,FF,00,FF,00
10550DATAFF,00,FC,00,F8,00,E0,00
10560DATA00,00,00,00,00,00,00,00
10570DATA00,00,00,00,00,00,00,00
10580DATA00,00,00,00,00,00,00,00
10590DATA00,00,00,00,00,00,00,00
10600DATA00,00,00,00,00,00,00,00
10610DATA00,00,00,00,00,00,00,00
10620DATA00,00,00,00,00,00,00,00
10630DATA00,00,00,00,00,00,00,00
10640DATA00,00,00,00,00,00,00,00
10650DATA00,00,00,00,00,00,00,00
10660DATA00,00,00,00,00,00,00,00
10670DATA00,00,00,00,00,00,00,00
10680DATAFB,FB,00,DF,DF,00,FB,FB
10690DATADF,DF,00,FB,FB,00,00,FB
10700DATA00,DF,DF,00,FB,FB,00,DF
10710DATAFB,00,DF,DF,00,FB,FB,FB
10720DATA00,F7,F7,F7,00,7F,7F,7F
10730DATA00,F7,F7,F7,00,7F,7F,7F
13000restore17740:FORI=0TO(79*8)-1
13010READA$
13020VPOKE8192+I,VAL("&H"+A$):'&h2000'
13030VPOKE10240+I,VAL("&H"+A$):'&h2800'
13050NEXTI
17740DATA81,F8,F8,81,81,81,81,81
17750DATAB1,B1,B1,B1,B1,81,81,81
17760DATA81,E1,E1,E1,61,61,61,61
17770DATA61,61,61,61,61,61,61,61
17780DATA61,61,61,21,21,21,21,21
17790DATA21,21,21,2C,2C,2C,2C,11
17800DATAD1,D1,91,91,91,91,D1,D1
17810DATAD1,B1,B1,B1,B1,A1,A1,A1
17820DATA81,81,81,81,81,81,81,81
17830DATA81,81,81,81,81,81,81,81
17840DATA81,81,81,81,81,81,81,81
17850DATA81,81,81,81,81,81,81,81
17860DATA81,81,81,81,81,81,81,81
17870DATA81,81,81,81,81,81,81,81
17880DATA81,81,81,81,81,81,81,81
17890DATA81,81,81,81,81,81,81,81
17900DATA81,81,81,81,81,81,81,81
17910DATA81,81,81,81,81,81,81,81
17920DATA81,81,81,81,81,81,81,81
17930DATA81,81,81,81,81,81,81,81
17940DATA81,81,81,81,81,81,81,81
17950DATA81,81,81,81,81,81,81,81
17960DATA81,81,81,81,81,81,81,81
17970DATA81,81,81,81,81,81,81,81
17980DATA81,81,81,81,81,81,81,81
17990DATA81,81,81,81,81,81,81,81
18000DATA81,81,81,81,81,81,81,81
18010DATA81,81,81,81,81,81,81,81
18020DATA81,81,81,81,81,81,81,81
18030DATA81,81,81,81,81,81,81,81
18040DATAB1,A1,A1,A1,81,81,81,81
18050DATA81,81,81,81,81,81,81,81
18060DATA91,91,91,91,91,91,91,91
18070DATA31,31,31,31,31,31,31,31
18080DATA71,71,71,71,71,71,71,71
18090DATAB1,B1,B1,B1,B1,B1,B1,B1
18100DATAE1,E1,E1,E1,E1,E1,E1,E1
18110DATA21,21,23,23,23,23,23,23
18120DATA91,91,9E,9E,9E,9E,9E,9E
18130DATA91,61,61,61,61,61,61,61
18140DATA91,91,61,61,61,61,61,61
18150DATA91,61,61,61,61,61,61,61
18160DATA91,91,61,61,61,61,61,61
18170DATA79,91,91,91,91,91,91,91
18180DATA75,51,51,51,51,51,51,51
18190DATA75,11,11,11,11,11,11,11
18200DATA35,11,11,11,11,11,11,11
18210DATA75,51,51,51,51,51,51,51
18220DATA51,51,51,51,51,51,51,51
18230DATA51,51,51,51,51,51,51,51
18240DATA51,51,51,51,51,51,51,51
18250DATA51,51,51,51,51,51,51,51
18260DATA51,51,51,51,51,51,51,51
18270DATA51,51,51,51,51,51,51,51
18280DATA51,51,51,51,51,51,51,51
18290DATA51,51,51,51,51,51,51,51
18300DATA51,51,51,51,51,51,51,51
18310DATA51,51,51,51,51,51,51,51
18320DATA51,51,51,51,51,51,51,51
18330DATA51,51,51,51,51,51,51,51
18340DATA51,51,51,51,51,51,51,51
18350DATA51,51,51,51,51,51,51,51
18360DATA51,51,51,51,51,51,51,51
18370DATA51,51,51,51,51,51,51,51
18380DATAE1,E1,E1,A1,A1,A1,E1,E1
18390DATAE1,E1,E1,A1,A1,A1,A1,A1
18400DATAA1,81,81,81,51,51,51,81
18410DATA81,81,51,51,51,81,81,81
18420DATA81,81,81,81,81,81,81,81
18430DATA81,51,51,51,51,51,51,51
18440DATA51,31,31,31,31,31,31,31
18450DATAE1,51,E1,51,E1,51,E1,51
18460DATAE1,51,E1,51,E1,51,E1,51
18470DATAE1,FE,FE,FE,FE,FE,FE,FE
18480DATAA1,EA,EA,EA,EA,EA,EA,EA
18490DATAF1,FE,FE,FE,FE,FE,FE,FE
18500DATA11,11,11,11,11,11,11,11
18510DATA11,11,11,11,11,11,11,11
18520DATA11,11,11,11,11,11,11,11
18530DATA11,11,11,11,11,11,11,11
19000'callturbooff
19990return