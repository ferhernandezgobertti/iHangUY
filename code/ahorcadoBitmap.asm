
### PSEUDOCODIGO ####

# Parametro: Cantidad de Vidas Restantes (Maximo es 4)
# Retorno: Impresion del Ahorcado
# La impresion se realiza de arriba hacia abajo. Hay dibujos adjuntos en las carpetas anexas al codigo
# 
# Impresion del techo de la horca y palos hasta donde comenzaria la cabeza del ahorcado. Alli se verifica el modelo a dibujar, los
# cuales dependen de la cantidad de vidas que el usuario tiene. El modelo 1 es si el usuario no perdio ninguna vida (unicamente la
# horca), el modelo 2 es si el usuario perdio 1 vida (horca y rostro del ahorcado), el modelo 3 es si el usuario perdio 2 vidas (horca,
# rostro y torso del ahorcado), el modelo 4 es si el usuario perdio 3 vidas (horca, rostro, torso y brazos del ahorcado) y el modelo 5
# es si el usuario perdio todas sus 4 vidas (horca y cuerpo completo). Para una correcta y eficaz elaboracion del codigo, se prosiguio 
# a reutilizar el codigo utilizado para un modelo anterior, y usarlo (junto a una actualizacion de lo que adicionar a imprimir) en la
# impresion del modelo actual. De esta forma, al imprimir el modelo 2 se utilizo en la medida de lo posible lo mas que se pudo del codigo
# de la impresion de la horca del modelo 1. Lo mismo del modelo 3 respecto del modelo 2 y analogamente, del modelo 4 al 3 y del modelo 5
# al modelo 4, usando a su vez la menor cantidad posible de variaciones de Strings.


##### CODIGO #####

.eqv BASE, 0x10010000

.data

#stringEspacio: .word 0x00
stringPaloHorizontal: .word 0xFF
stringPaloVertical: .word 0x02

stringSuperior: .word 0x42

stringCara1: .word 0x1C
stringCara2: .word 0x36
stringCara3: .word 0x63

stringPierna1: .word 0x40
stringPierna2: .word 0x20
stringPierna3: .word 0x10
stringPierna4: .word 0x08
stringPierna5: .word 0x04
stringPierna6: .word 0x02
stringPierna7: .word 0x01

.text

ahorcadoBitmap:
  
  li $s0, 0 # contador FILA
  li $s1, 0 # contador COLUMNA
  li $s2, 0x0000FF00 # COLOR
  li $s4, 2
  li $s6, 1 # CONTADOR VECES IMPRESION
  li $a0,4  ##CANTIDAD DE VIDAS RESTANTES (PARAMETRO)

  beq $a0, 4, cuatroVidas
  beq $a0, 3, tresVidas
  beq $a0, 2, dosVidas
  beq $a0, 1, unaVida
  beq $a0, 0, ceroVidas

##########################################

dibujarPixel:
  
  li $t2, BASE
  addu $s7, $s7, $s0  
  sll   $t3, $s1, 9        #y = y * 512
  addu  $t3, $t3, $s7      # (xy) t0 = x + y
  sll   $t3, $t3, 2        # (xy) t0 = xy * 4
  addu  $t3, $t2, $t3      # adds xy to the first pixel
  sw    $s2, ($t3)         # put the color in $t0
  addiu $s0, $s0, 1
  bne $s0, 8, dibujarFila
  jr $ra

dibujarFila:

  move $a1, $s0
  
  addiu $sp, $sp, -4
  sw $ra, ($sp)
  jal potencia
  lw $ra, ($sp)
  addiu $sp, $sp, 4
  
  move $t0, $v0
  
  and $t1, $t0, $s3
  move $a0, $s0
  move $a1, $s1
  bgtz $t1, dibujarPixel
  
  addiu $s0,$s0,1
  bne $s0, 8, dibujarFila
  jr $ra

###########################################

cuatroVidas:        
  
  la $s5, stringPaloHorizontal
  lw $s3, ($s5)
  jal dibujarFila
  addiu $s6, $s6, 1
  addiu $s7, $s7, 8
  bne $s6, 4, cuatroVidas
  addiu $s1, $s1, 1
  la $s5, stringSuperior
  lw $s3, ($s5)
  li $s6, 0
  li $s7, 0
  
dibujarPaloSuperior:
  li $s0, 0
  jal dibujarFila
  addiu $s1, $s1, 1
  addiu $s6, $s6, 1
  bne $s6, 5, dibujarPaloSuperior
  addiu $s1, $s1, 1
  la $s5, stringPaloVertical
  lw $s3, ($s5)
  li $s6, 0
  
dibujarPaloVertical:
  li $s0, 0
  jal dibujarFila
  addiu $s1, $s1, 1
  addiu $s6, $s6, 1
  bne $s6, 10, dibujarPaloVertical
  
  j finDibujo
  
  
tresVidas:
  
  
  
dosVidas:      
 
 
 
unaVida:
  
 
  
ceroVidas:
  
  
        
        
potencia:
  
  li $t4, 0
  move $t5, $s4
  beq $a1,$0,exponente0
  beq $a1,1,exponente1
 
iteracionPot:

  beq $t4, $a1, end
  mult $t5, $s4
  mflo $t5
  addiu $t4,$t4,1
  j iteracionPot
  
exponente0:

  li $v0,1
  j end

exponente1:

  move $v0, $s4
  j end
  
end:
  move $v0, $t5
  jr $ra        
        
finDibujo:  

  li $v0,10
  syscall
