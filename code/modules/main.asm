.eqv receive_control 0xffff0000 # si distinto cero, ready
.eqv receive_data 0xffff0004


.globl main
.globl palabrasConCeros
.globl palabraAAdivinar
.globl adivinandoPalabra
.globl letrasIngresadas
.globl letraActual
.globl stringLetras

.data


palabrasConCeros: .space 20000
palabraAAdivinar: .space 64
adivinandoPalabra: .space 64
letrasIngresadas: .space 32    #letras ingresadas
letraActual: .space 1 #ultima letra ingresada
stringPalabraFinal: .asciiz "\n\n La palabra a adivinar era:\n"
stringLetras: .asciiz "LETRAS YA INGRESADAS: "



.text

main:
  jal bienvenida
  jal instrucciones
  jal dibujarBienvenida
  jal dibujarInstrucciones
reintentar:
  jal leerArchivo
  jal eleccionPalabraArray
  move $s1,$v1 # guardo largo de la palabra a adivinar
  beqz $v0,errorEleccion
  move $a0,$s1
  jal palabraGuiones
  jal palabraSeleccionada
  li $s0,4 # contador vidas
  
  jal mostrarOpcionesTeclado
  bne $v0,0,noUsarMMIO
  li $s2,1 # #s2=1 uso MMIO
  j jugando
  
noUsarMMIO:
  li $s2,0
  
  j jugando
errorEleccion:
  jal errorPalabraSeleccionada
  j reintentar

jugando:
  li $a0,0xFFFFFF # fondo blanco
  jal limpiarPantalla
  move $a0,$s0
  jal dibujarModelos # dibuja ahorcado segun cantidad de vidas
  move $a0,$s0
  jal dibujarModelosBitmap
  la $a0,adivinandoPalabra # dibuja palabra a adivinar en guiones y los va reemplazando con letras adivinadas
  jal mostrarPalabra # muestra palabra con direccion en $a0 seperando caracteres con espacios
  jal dibujarAdivinandoPalabra
  li $v0,4
  la $a0,stringLetras
  syscall
  la $a0,letrasIngresadas # dibuja letras ingresadas
  jal mostrarPalabra # muestra palabra con direccion en $a0 seperando caracteres con espacios
  jal dibujarStringLetrasIngresadas
  jal dibujarLetrasIngresadas
  jal mostrarOpciones
  
  beq $s2,1,pedirTeclado
  
  li $v0,12 # pido letra por consola
  syscall
  move $a0,$v0
  j yaPedido
  
pedirTeclado:
  jal pedidoLetraTecladoMMIO # retorno $v0=letra
  move $a0,$v0
  
yaPedido:
  jal estudioLetra # parametro $a0=letra  -  retorno $v0=0 fin juego, $v0=1, mostro palabra, no hacer nada, $v0=2, caracter erroneo, $v3=3 correcto
  beqz $v0,fin
  beq $v0,1,seguir
  beq $v0,2,ingresoIncorrecto
  
  jal letraEnPalabra
  beqz $v0,noEsta
  beq $v0,1,esta
  beq $v0,2,yaIngresada
  
  noEsta:
  subiu $s0,$s0,1 # saca una vida
  li $v0,4
  la $a0, stringLetraNoEsta
  syscall
  j seguir
  
  esta:
  li $v0,4
  la $a0, stringLetraEsta
  syscall
  j seguir
  
  yaIngresada:
  li $v0,4
  la $a0, stringLetraYaIngresada
  syscall
  j seguir
  
ingresoIncorrecto:
  jal mostrarIngresoIncorrecto
  j seguir
  
seguir:
  move $a0,$s1
  jal verificarSiGana # $a0=largopalabra - $v0=0 no, $v0=1 si
  beq $v0,1,winner
  
  bgtz $s0,jugando
  move $a0,$s0
  jal dibujarModelos
  
  li $v0,4
  la $a0,stringPalabraFinal
  syscall

  la $a0,palabraAAdivinar
  jal mostrarPalabra
  
  jal finPerdedor
  li $a0,0xFFFFFF
  jal limpiarPantalla
  jal dibujarGameOver
  jal dibujarDead
  
  j fin

winner:

  li $v0,4
  la $a0,stringPalabraFinal
  syscall

  la $a0,palabraAAdivinar
  jal mostrarPalabra
  
  jal finGanador
  li $a0,0xFFFFFF
  jal limpiarPantalla
  jal dibujarFelicitaciones
  jal dibujarHeart

fin:
  li $v0,10
  syscall
  
  
  
  
pedidoLetraTecladoMMIO:

polling_lectura:
  lw $t0,receive_control
  andi $t0,$t0, 1
  beqz $t0,polling_lectura
  #LISTO!
  lw $v0,receive_data
  
  jr $ra

