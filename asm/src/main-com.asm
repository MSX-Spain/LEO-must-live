
		; la cabecera de los archivos com siempre es la misma, por favor ver https://www.faq.msxnet.org/suffix.html
		org		#100 
		
		;imprime Hola MSX claro pio desde com
		ld		c,9 ; le metemos el 9 en el registro c
		ld		de,texto ; le metemos el texto en los registros de
		call	#0005 ;llamamos a la turina 0005

		ret
		
texto:		
		db	" Hola MSX Murcia!!!"
enter:
		db	#0d,#0a,'$' ;forma utilizada simpre para decirle que ha terminado el string
