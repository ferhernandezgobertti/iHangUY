#sustituciones direcciones teclado MMIO

.eqv receive_control 0xffff0000		# si distinto cero, ready
.eqv receive_data 0xffff0004		# letra a leer


.eqv blanco 0xFFFFFF			# color blanco para bitmap


.globl main
.globl palabrasConCeros
.globl palabraAAdivinar
.globl adivinandoPalabra
.globl letrasIngresadas
.globl letraActual
.globl stringLetras

.data


palabrasConCeros: .space 20000		# array de palabras leidas desde el archivo
palabraAAdivinar: .space 64		# palabra a adivinar elegida aleatoriamente
adivinandoPalabra: .space 64
letrasIngresadas: .space 32		#letras ingresadas
letraActual: .space 1			#ultima letra ingresada
stringLetras: .asciiz "LETRAS YA INGRESADAS: "



.text


# variables globales utilizadas
# $s0 = cantidad de vidas (entre 0 y 4)
# $s1 = largo de la palabra a adivinar (cantidad caracteres)
# $s2 = resultado cuadro de dialogo teclado MMIO si es 1 uso MMIO


main:

  li $a0,blanco
  jal limpiarPantalla
  
  jal bienvenida			# muestra bienvenida consola
  jal instrucciones			# muestra instrucciones consola
  jal dibujarBienvenida			# muestra bienvenida bitmap
  jal dibujarInstrucciones		# muestra instrucciones bitmap
reintentar:				# reintenta hasta obtener una palabra valida (solo contenga letras)
  jal leerArchivo			# lee el archivo en la direccion indicada y carga las palabras en "palabrasConCeros"
  jal eleccionPalabraArray		# elige una palabra aleatoriamente del array. retorno: $v0 = 0 error (palabra invalida), 1 OK. $v1 = largo de la palabra a adivinar
  move $s1,$v1
  beqz $v0,errorEleccion
  move $a0,$s1
  jal palabraGuiones			# carga guiones en "adivinandoPalabra", los cuales se iran sustituyendo por las letras ingresadas. parametro: $a0 = largo de la palabra a adivinar 
  jal palabraSeleccionada		# muestra que se obtuvo una palabra satisfactoriamente consola
  li $s0,4 				# contador vidas
  
  jal mostrarOpcionesTeclado		# muestra cuadro de dialogo para usar o no el teclado MMIO. retorno: $v0 = 0 utiliza teclado MMIO, en otro caso no se usa
  bnez $v0,noUsarMMIO
  li $s2,1				# $s2 = 1 uso MMIO
  j jugando
  
noUsarMMIO:
  li $s2,0
  
  j jugando
errorEleccion:
  jal errorPalabraSeleccionada		# muestra por consola si hubo un error al elegir la palabra y elige otra
  j reintentar

jugando:
  li $a0,blanco
  jal limpiarPantalla
  
  move $a0,$s0
  jal dibujarModelos			# dibuja ahorcado consola. parametro: $a0 = cantidad de vidas
  
  move $a0,$s0
  jal dibujarModelosBitmap		# dibuja ahorcado bitmap. parametro: $a0 = cantidad de vidas
  
  la $a0,adivinandoPalabra
  jal mostrarPalabra			# muestra palabra con direccion en $a0 en consola seperando caracteres con espacios
  
  jal dibujarAdivinandoPalabra		# muestra adivinandoPalabra en bitmap
  
  li $v0,4
  la $a0,stringLetras			# imprime string para indicar letras ingresadas por consola
  syscall
  
  la $a0,letrasIngresadas
  jal mostrarPalabra			# muestra palabra con direccion en $a0 en consola seperando caracteres con espacios
  
  jal dibujarStringLetrasIngresadas	# muestra string para indicar letras ingresadas en bitmap
  
  jal dibujarLetrasIngresadas		# muestra letras ingresadas en bitmap
  
  jal mostrarOpciones			# muestra opciones jugadas por consola
  
  beq $s2,1,pedirTeclado
  
  li $v0,12 				# pido letra por consola
  syscall
  move $a0,$v0
  j yaPedido
  
pedirTeclado:				# pido letra por teclado MMIO
  
  polling_lectura:			# hago polling hasta el ingreso de la letra
  lw $t0,receive_control
  andi $t0,$t0, 1
  beqz $t0,polling_lectura
  lw $a0,receive_data
  
yaPedido:
  jal estudioLetra 			# analiza letra ingresada. parametro: $a0 = letra. retorno: $v0 = 0 fin juego, $v0 = 1 mostrar palabra a adivinar, $v0 = 2 caracter ingresado invalido, $v0=3 todo correcto
  beqz $v0,fin
  beq $v0,1,seguir
  beq $v0,2,ingresoIncorrecto
  
  jal letraEnPalabra			# busca si la letra ya fue ingresada previamente o si se encuentra en la palabra a adivinar. retorno: $v0 = 0 no se encuentra, $v0 = 1 se encuentra, $v0 = 2 ya fue ingresada
  beqz $v0,noEsta
  beq $v0,1,esta
  beq $v0,2,yaIngresada
  
  noEsta:
  subiu $s0,$s0,1 			# resta una vida
  li $v0,4
  la $a0, stringLetraNoEsta		# imprime string en consola indicando que la letra no se encuentra
  syscall
  j seguir
  
  esta:
  li $v0,4
  la $a0, stringLetraEsta		# imprime string en consola indicando que la letra se encuentra
  syscall
  j seguir
  
  yaIngresada:
  li $v0,4
  la $a0, stringLetraYaIngresada	# imprime string en consola indicando que la letra ya fue ingresada
  syscall
  j seguir
  
ingresoIncorrecto:
  jal mostrarIngresoIncorrecto		# imprime string en consola indicando que el ingreso es incorrecto
  j seguir
  
seguir:
  move $a0,$s1
  jal verificarSiGana 			# verifica si el jugador gana contando la cantidad de guiones restantes. parametro: $a0 = largo de la palabra a adivinar. retorno: $v0 = 0 no gana, $v0 = 1 si gana
  beq $v0,1,winner
  
  bgtz $s0,jugando
  
  li $a0,blanco
  jal limpiarPantalla
  
  move $a0,$s0
  jal dibujarModelos			# dibuja ahorcado consola. parametro: $a0 = cantidad de vidas
  
  move $a0,$s0
  jal dibujarModelosBitmap		# dibuja ahorcado bitmap. parametro: $a0 = cantidad de vidas
  
  jal mostrarPalabraAAdivinarFinal	# imprime en consola cual era la palabra a adivinar
  
  li $v0,32
  li $a0,3000				# mantiene el dibujo del ahorcado un momento (3 segundos) antes de mostrar el final
  syscall
  
  jal finPerdedor			# dibuja en consola el final perdedor
  
  li $a0,blanco
  jal limpiarPantalla
  
  jal dibujarGameOver			# dibuja en bitmap el final perdedor
  jal dibujarDead
  
  j fin

winner:

  jal mostrarPalabraAAdivinarFinal	# imprime en consola cual era la palabra a adivinar
  
  jal finGanador			# dibuja en consola el final gaandor
  
  li $a0,blanco
  jal limpiarPantalla
  
  jal dibujarFelicitaciones		# dibuja en bitmap el final ganador
  jal dibujarHeart

fin:

  li $v0,32
  li $a0,4000				# mantiene el dibujo final (4 segundos) antes de mostrar gracias
  syscall
  
  li $a0,blanco
  jal limpiarPantalla
  
  jal finGracias			# dibuja gracias final en consola
  jal dibujarGracias			# dibuja gracias final en bitmap

  li $v0,10
  syscall
  
