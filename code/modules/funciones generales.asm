.globl estudioLetra
.globl letraEnPalabra
.globl eleccionPalabraArray
.globl palabraGuiones
.globl verificarSiGana
.globl stringPalabraAAdivinar


.data

stringPalabraAAdivinar: .asciiz "LA PALABRA A ADIVINAR ES:"

.eqv ascii_cero,48 #(0)
.eqv ascii_a,97 #(a)
.eqv ascii_z,122 #(z)
.eqv ascii_A,65 #(A)
.eqv ascii_Z,90 #(Z)
.eqv ascii_guion_bajo, 95
.eqv ascii_espacio, 32

.text

###################################################################################################

letraEnPalabra:

li $t0,0 # contador
la $t1,palabraAAdivinar
la $t6,adivinandoPalabra
addu $t2,$t1,$t0
lb $t3,($t2) # caracter actual
lb $t4,letraActual # ultima letra ingresada
li $v0,0 # inicializo retorno


whileBuscar: beqz $t3,finWhileBuscar

  addu $t2,$t1,$t0
  addu $t5,$t6,$t0
  lb $t3,($t2) # caracter actual
  bne $t3,$t4,letraNoEsta
  li $v0,1
  sb $t3,($t5) # reemplazo guiones (_) por la letra correspondiente
  letraNoEsta:
  addiu $t0,$t0,1
  j whileBuscar


finWhileBuscar:

  li $t0,0 # contador
  la $t1,letrasIngresadas
  addu $t2,$t1,$t0 # direccion letra ya ingresada actual
  lb $t3,($t2) # letra ya ingresada actual
  
whileYaIngresada: beqz $t3,finWhileYaIngresada

  addu $t2,$t1,$t0 # direccion letra ya ingresada actual
  lb $t3,($t2) # letra ya ingresada actual
  
  bne $t3,$t4,letraNoFueIngresada
  li $v0,2
  letraNoFueIngresada:
  addiu $t0,$t0,1
  j whileYaIngresada

##########

finWhileYaIngresada:


  li $t0,0 #contador
  lb $t5,letraActual  
#agrego letraActual a letras ingresadas
whileNoHayEspacio:
  la $t1,letrasIngresadas
  addu $t2,$t1,$t0
  lb $t3,($t2)
  beq $t3,$t5,noGuardar #si ya fue ingresada no se vuelve a ingresar
  beqz $t3,guardarAca
  addiu $t0,$t0,1
  j whileNoHayEspacio
  
guardarAca:
  sb $t5,($t2)
noGuardar:
  jr $ra




###################################################################################################



eleccionPalabraArray:

li $t0,0 # contador
li $t1,0 # contador de ceros
li $t2,0 # caracter anterior
la $t3,palabrasConCeros # direccion array palabras

whileLeer:
  addu $t5,$t3,$t0 # direccion siguiente = direccion array + contador
  lb $t4,($t5) # caracter siguiente
  bne $t2,ascii_cero,caracterAnteriorNoEsCero
  addiu $t1,$t1,1
  caracterAnteriorNoEsCero:
  beqz $t4,finWhileLeer
  move $t2,$t4
  addiu $t0,$t0,1
j whileLeer

finWhileLeer:

  subiu $a1,$t1,1 # valor mas alto para numero generado aleatoriamente		
  li $v0, 42
  syscall
  move $t6,$a0 # numero de palabra seleccionada - 1
  addiu $t2,$a0,1 # valor generado aleatoriamente - numero de palabra seleccionada
  
  
  li $t0,0 # contador
  li $t1,0 # contador de ceros
  li $t8,0 #contador en palabra

whileEncontrarPalabra: beq $t1,$t2,finWhileEncontrarPalabra #mientras no se encuentre la palabra elegida
  addu $t4,$t3,$t0 # direccion actual = direccion array + contador
  lb $t5,($t4) #caracter actual
  bne $t5,ascii_cero,caracterActualNoEsCero
  addiu $t1,$t1,1
  j finCaracterActualEsCero
  caracterActualNoEsCero:
  bne $t1,$t6,finNoLeer
  blt $t5,ascii_a,noEsMinuscula
  bgt,$t5,ascii_z,noEsMinuscula
  subiu $t5,$t5,32 # paso a mayusculas
  noEsMinuscula:
  blt $t5,ascii_A,errorPalabra
  bgt $t5,ascii_Z,errorPalabra
  la $t7,palabraAAdivinar
  addu $t7,$t7,$t8
  sb $t5,($t7)
  addiu $t8,$t8,1
  finCaracterActualEsCero:
  finNoLeer:
  addiu $t0,$t0,1
  j whileEncontrarPalabra
  
finWhileEncontrarPalabra:
  move $v1,$t8 #largo de la palabra a adivinar = contador en palabra
  li $v0,1
  j finEncontrarPalabraArray

errorPalabra:
  li $v0,0
 
finEncontrarPalabraArray:
  jr $ra

###################################################################################################

estudioLetra:

  addiu $sp,$sp,-4
  sw $ra,($sp)
  
  
  blt $a0,ascii_a,noCambiar
  bgt,$a0,ascii_z,noCambiar
  subiu $a0,$a0,32 # paso a mayusculas
noCambiar:
  
  beq $a0,48,finalizarJuego # si ingreso cero
  beq $a0,49,imprimirPalabra # si ingreso uno
  
  blt $a0,ascii_A,caracterErroneo
  bgt,$a0,ascii_Z,caracterErroneo
  
  sb $a0,letraActual # guardo caracter ingresado si es una letra

  li $v0,3
  j finPedido
  
finalizarJuego:
  li $v0,0
  j finPedido

imprimirPalabra:
  
  li $v0,11
  li $a0,10
  syscall
  
  li $v0,4
  la $a0, stringPalabraAAdivinar
  syscall
  
  li $v0,11
  li $a0,10
  syscall

  la $a0,palabraAAdivinar
  jal mostrarPalabra
  
  jal dibujarStringPalabraAAdivinar
  jal dibujarPalabraAAdivinar
  
  li $v0,1
  j finPedido
  
  
caracterErroneo:
  li $v0,2

finPedido:
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
###################################################################################################
  
palabraGuiones:

  move $t1,$a0 #largo palabra
  li $t0,0 #contador
  la $t2,adivinandoPalabra
  li $t4,ascii_guion_bajo
  
whilePalabra:
  
  addu $t3,$t2,$t0 #direccion guion a guardar = direccion adivinandoPalabra + contador
  sb $t4,($t3)
  addiu $t0,$t0,1
  blt $t0,$t1,whilePalabra
  
  jr $ra

###################################################################################################
  
verificarSiGana:
  
  la $t1,adivinandoPalabra
  addu $t4,$t1,$a0 # direccion mas alta de palabra
  li $t0,0 # contador
  li $v0,1 # inicializo retorno
  
whileNoHayGuiones:
  
  addu $t2,$t1,$t0 # direccion a verificar = direccion adivinandoPalabra + contador
  bgt $t2,$t4,noHayGuiones
  lb $t3,($t2)
  beq $t3,ascii_guion_bajo,hayGuiones
  addiu $t0,$t0,1
  j whileNoHayGuiones

hayGuiones:
  li $v0,0

noHayGuiones:
  jr $ra
