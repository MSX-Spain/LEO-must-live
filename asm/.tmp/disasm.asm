L00A2:       equ  00A2h


             org 6CF0h


6CF0 L6CF0:
6CF0 CD F5 6C     CALL L6CF5  
6CF3 E1           POP  HL     
6CF4 C9           RET         


6CF5 L6CF5:
6CF5 AF           XOR  A      
6CF6 L6CF6:
6CF6 77           LD   (HL),A 
6CF7 23           INC  HL     
6CF8 10 FC        DJNZ L6CF6  
6CFA C9           RET         


6CFB 2A           defb 2Ah    
6CFC 64           defb 64h    
6CFD F8           defb F8h    
6CFE 11           defb 11h    
6CFF 09           defb 09h    
6D00 00           defb 00h    
6D01 19           defb 19h    
6D02 C9           defb C9h    
6D03 CD           defb CDh    
6D04 94           defb 94h    
6D05 FE           defb FEh    
6D06 CD           defb CDh    
6D07 6A           defb 6Ah    
6D08 6A           defb 6Ah    
6D09 28           defb 28h    
6D0A 20           defb 20h    
6D0B 3E           defb 3Eh    
6D0C 0A           defb 0Ah    
6D0D 38           defb 38h    
6D0E 21           defb 21h    
6D0F CD           defb CDh    
6D10 99           defb 99h    
6D11 FE           defb FEh    
6D12 18           defb 18h    
6D13 22           defb 22h    
6D14 CD           defb CDh    
6D15 94           defb 94h    
6D16 FE           defb FEh    
6D17 CD           defb CDh    
6D18 6A           defb 6Ah    
6D19 6A           defb 6Ah    
6D1A 28           defb 28h    
6D1B 0F           defb 0Fh    
6D1C 3E           defb 3Eh    
6D1D 0C           defb 0Ch    
6D1E 38           defb 38h    
6D1F 10           defb 10h    
6D20 CD           defb CDh    
6D21 9E           defb 9Eh    
6D22 FE           defb FEh    
6D23 18           defb 18h    
6D24 11           defb 11h    
6D25 CD           defb CDh    
6D26 94           defb 94h    
6D27 FE           defb FEh    
6D28 CD           defb CDh    
6D29 6A           defb 6Ah    
6D2A 6A           defb 6Ah    
6D2B CA           defb CAh    
6D2C 77           defb 77h    
6D2D 6E           defb 6Eh    
6D2E 3E           defb 3Eh    
6D2F 0E           defb 0Eh    
6D30 DA           defb DAh    
6D31 8F           defb 8Fh    
6D32 6F           defb 6Fh    
6D33 CD           defb CDh    
6D34 A3           defb A3h    
6D35 FE           defb FEh    
6D36 C3           defb C3h    
6D37 80           defb 80h    
6D38 6E           defb 6Eh    
6D39 CD           defb CDh    
6D3A 94           defb 94h    
6D3B FE           defb FEh    
6D3C CD           defb CDh    
6D3D 6A           defb 6Ah    
6D3E 6A           defb 6Ah    
6D3F 3E           defb 3Eh    
6D40 10           defb 10h    
6D41 38           defb 38h    
6D42 ED           defb EDh    
6D43 CD           defb CDh    
6D44 A8           defb A8h    
6D45 FE           defb FEh    
6D46 18           defb 18h    
6D47 EE           defb EEh    
6D48 CD           defb CDh    
6D49 4A           defb 4Ah    
6D4A 01           defb 01h    
6D4B CA           defb CAh    
6D4C 40           defb 40h    
6D4D 46           defb 46h    
6D4E AF           defb AFh    
6D4F CD           defb CDh    
6D50 24           defb 24h    
6D51 6B           defb 6Bh    
6D52 C3           defb C3h    
6D53 71           defb 71h    


             org 8212h


8212 L8212:
8212 CD 1D 82     CALL L821D  
8215 CD 1D 82     CALL L821D  
8218 CD 26 82     CALL L8226  
821B L821B:
821B 18 FE        JR   L821B  


821D L821D:
821D 3A 38 82     LD   A,(L8238) 
8220 C6 01        ADD  A,01h  
8222 32 38 82     LD   (L8238),A 
8225 C9           RET         


8226 L8226:
8226 3A 38 82     LD   A,(L8238) 
8229 C6 30        ADD  A,30h  
822B CD A2 00     CALL L00A2  
822E C9           RET         


822F 7E           defb 7Eh    
8230 A7           defb A7h    
8231 C8           defb C8h    
8232 CD           defb CDh    
8233 A2           defb A2h    
8234 00           defb 00h    
8235 23           defb 23h    
8236 18           defb 18h    
8237 F7           defb F7h    


8238 L8238:
8238 03           defb 03h    