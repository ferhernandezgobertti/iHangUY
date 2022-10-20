.globl dibujarPalabra

.eqv BASE, 0x10010000

.data
letraA: .word  0x0C 0x1E 0x33 0x33 0x3F 0x33 0x33 0x00
letraB: .word  0x3F 0x66 0x66 0x3E 0x66 0x66 0x3F 0x00
letraC: .word  0x3C 0x66 0x03 0x03 0x03 0x66 0x3C 0x00
letraD: .word  0x1F 0x36 0x66 0x66 0x66 0x36 0x1F 0x00
letraE: .word  0x7F 0x46 0x16 0x1E 0x16 0x46 0x7F 0x00
letraF: .word  0x7F 0x46 0x16 0x1E 0x16 0x06 0x0F 0x00
letraG: .word  0x3C 0x66 0x03 0x03 0x73 0x66 0x7C 0x00
letraH: .word  0x33 0x33 0x33 0x3F 0x33 0x33 0x33 0x00
letraI: .word  0x1E 0x0C 0x0C 0x0C 0x0C 0x0C 0x1E 0x00
letraJ: .word  0x78 0x30 0x30 0x30 0x33 0x33 0x1E 0x00
letraK: .word  0x67 0x66 0x36 0x1E 0x36 0x66 0x67 0x00
letraL: .word  0x0F 0x06 0x06 0x06 0x46 0x66 0x7F 0x00
letraM: .word  0x63 0x77 0x7F 0x7F 0x6B 0x63 0x63 0x00
letraN: .word  0x63 0x67 0x6F 0x7B 0x73 0x63 0x63 0x00
letraO: .word  0x1C 0x36 0x63 0x63 0x63 0x36 0x1C 0x00
letraP: .word  0x3F 0x66 0x66 0x3E 0x06 0x06 0x0F 0x00
letraQ: .word  0x1E 0x33 0x33 0x33 0x3B 0x1E 0x38 0x00
letraR: .word  0x3F 0x66 0x66 0x3E 0x36 0x66 0x67 0x00
letraS: .word  0x1E 0x33 0x07 0x0E 0x38 0x33 0x1E 0x00
letraT: .word  0x3F 0x2D 0x0C 0x0C 0x0C 0x0C 0x1E 0x00
letraU: .word  0x33 0x33 0x33 0x33 0x33 0x33 0x3F 0x00
letraV: .word  0x33 0x33 0x33 0x33 0x33 0x1E 0x0C 0x00
letraW: .word  0x63 0x63 0x63 0x6B 0x7F 0x77 0x63 0x00
letraX: .word  0x63 0x63 0x36 0x1C 0x1C 0x36 0x63 0x00
letraY: .word  0x33 0x33 0x33 0x1E 0x0C 0x0C 0x1E 0x00
letraZ: .word  0x7F 0x63 0x31 0x18 0x4C 0x66 0x7F 0x00
espacio: .word 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

.text

  # Metodo dibujarLetra $a0=letra, $a1=pos X, $a2=pos Y, $a3=color
  
dibujarLetra:

  addiu $sp,$sp,-28
  sw $t0,($sp)
  sw $t1,4($sp)
  sw $t2,8($sp)
  sw $t3,12($sp)
  sw $t4,16($sp)
  sw $t5,20($sp)
  sw $t6,24($sp)

  
  li $t0,0 # contador fila
  li $t1,0 # contador columna
  li $t6,1 # bit comparador fila
  
  #inicializo calculo posición letra en pantalla
  li $t5, BASE  # posicion inicio display
  addu $t7,$a1,$t0
  sll $t7, $t7, 11  # * 2048
  addu $t5, $t5, $t7
  addu $t8,$a2,$t1
  sll $t8, $t8, 2  # * 4
  addu $t5, $t5, $t8
  
  
iteracionFila:


  #calculo posición letra en pantalla
  li $t5, BASE  # posicion inicio display
  addu $t7,$a1,$t0
  sll $t7, $t7, 11  # * 2048
  addu $t5, $t5, $t7
  addu $t8,$a2,$t1
  sll $t8, $t8, 2  # * 4
  addu $t5, $t5, $t8


  and $t4, $t6, $t2 # verifico si debo dibujar cada pixel de la fila actual
  sll $t6,$t6,1 # preparo siguiente pixel a comparar y verificar
  beqz $t4, noDibujar
  

  sw    $a3, ($t5)         # pone el color en $t5
  
noDibujar:
  
  addiu $t1,$t1,1 # columna
  bne $t1, 8, iteracionFila # mientras no finalice la fila
  
finFila:
  
  
  li $t1,0 # reset contador columnas
  li $t6,1 # reset bit comparador
  addiu $a0,$a0,4 #cargo siguiente fila de la letra
  lw $t2, ($a0)
  addiu $t0,$t0,1
  bne $t0, 8, iteracionFila #mientras no finalice el dibujo de la letra (8 filas)
  
fin:
  
  lw $t0,($sp)
  lw $t1,4($sp)
  lw $t2,8($sp)
  lw $t3,12($sp)
  lw $t4,16($sp)
  lw $t5,20($sp)
  lw $t6,24($sp)
  addiu $sp,$sp,28
  jr $ra
  
  
  
###################################################################################################
  
  
  
 dibujarPalabra:
 
  sw $ra,($sp)

 # METODO: $a0:direccion de la palabra, $a1: posicion x, $a2: posicion y, $a3: color
 
  li $t0,0 #contador
  move $t1,$a0
  
whileMostrarNoCero:
  
  addu $t7,$t1,$t0
  lb $t2,($t7)
  
  beqz $t2,finWhileMostrarNoCero

  bne $t2,65,noA
  la $a0,letraA
  j dibujar
noA:
  bne $t2,66,noB
  la $a0,letraB
  j dibujar
noB:
  bne $t2,67,noC
  la $a0,letraC
  j dibujar
noC:
  bne $t2,68,noD
  la $a0,letraD
  j dibujar
noD:
  bne $t2,69,noE
  la $a0,letraE
  j dibujar
noE:
  bne $t2,70,noF
  la $a0,letraF
  j dibujar
noF:
  bne $t2,71,noG
  la $a0,letraG
  j dibujar
noG:
  bne $t2,72,noH
  la $a0,letraH
  j dibujar
noH:
  bne $t2,73,noI
  la $a0,letraI
  j dibujar
noI:
  bne $t2,74,noJ
  la $a0,letraJ
  j dibujar
noJ:
  bne $t2,75,noK
  la $a0,letraK
  j dibujar
noK:
  bne $t2,76,noL
  la $a0,letraL
  j dibujar
noL:
  bne $t2,77,noM
  la $a0,letraM
  j dibujar
noM:
  bne $t2,78,noN
  la $a0,letraN
  j dibujar
noN:
  bne $t2,79,noO
  la $a0,letraO
  j dibujar
noO:
  bne $t2,80,noP
  la $a0,letraP
  j dibujar
noP:
  bne $t2,81,noQ
  la $a0,letraQ
  j dibujar
noQ:
  bne $t2,82,noR
  la $a0,letraR
  j dibujar
noR:
  bne $t2,83,noS
  la $a0,letraS
  j dibujar
noS:
  bne $t2,84,noT
  la $a0,letraT
  j dibujar
noT:
  bne $t2,85,noU
  la $a0,letraU
  j dibujar
noU:
  bne $t2,86,noV
  la $a0,letraV
  j dibujar
noV:
  bne $t2,87,noW
  la $a0,letraW
  j dibujar
noW:
  bne $t2,88,noX
  la $a0,letraX
  j dibujar
noX:
  bne $t2,89,noY
  la $a0,letraY
  j dibujar
noY:
  bne $t2,89,noZ
  la $a0,letraZ
  j dibujar
noZ:
  la $a0,espacio
  
dibujar:
  
  jal dibujarLetra
  addiu $a2,$a2,32
  
  
  addiu $t0,$t0,1
  
  j whileMostrarNoCero
  
finWhileMostrarNoCero:

  lw $ra,($sp)
  jr $ra
