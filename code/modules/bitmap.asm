.globl dibujarPalabra
.globl dibujarAdivinandoPalabra
.globl dibujarLetrasIngresadas
.globl dibujarStringLetrasIngresadas
.globl dibujarStringPalabraAAdivinar
.globl dibujarPalabraAAdivinar
.globl limpiarPantalla
.globl dibujarGameOver
.globl dibujarFelicitaciones
.globl dibujarHeart
.globl dibujarBienvenida
.globl dibujarInstrucciones
.globl dibujarDead

.eqv BASE, 0x10040000

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
guionBajo: .word 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xFF
vertical: .word 0x0C 0x0C 0x0C 0x0C 0x0C 0x0C 0x0C 0x0C
invertida: .word 0x01 0x02 0x04 0x08 0x10 0x20 0x40 0x80
barra: .word 0x80 0x40 0x20 0x10 0x08 0x04 0x02 0x01
guion: .word 0x00 0x00 0x00 0x7E 0x7E 0x00 0x00 0x00
parDer: .word 0x10 0x20 0x40 0x40 0x40 0x40 0x20 0x10
parIzq: .word 0x08 0x04 0x02 0x02 0x02 0x02 0x04 0x08
tildeInverso: .word 0x0C 0x0C 0x18 0x00 0x00 0x00 0x00 0x00
coma: .word 0x00 0x00 0x00 0x00 0x00 0x0C 0x0C 0x06
apostrofe: .word 0x06 0x06 0x03 0x00 0x00 0x00 0x00 0x00
asterisco: .word 0x00 0x66 0x3C 0xFF 0x3C 0x66 0x00 0x00
dosPuntos: .word 0x00 0x0C 0x0C 0x00 0x00 0x0C 0x0C 0x00
porcentaje: .word 0x00 0x63 0x33 0x18 0x0C 0x66 0x63 0x00
punto: .word 0x00 0x00 0x00 0x00 0x00 0x0C 0x0C 0x00
exclamacion: .word 0x18 0x3C 0x3C 0x18 0x18 0x00 0x18 0x00
igual: .word 0x00 0x00 0x3F 0x00 0x00 0x3F 0x00 0x00
numero4: .word 0x38 0x3C 0x36 0x33 0x7F 0x30 0x78 0x00



stringBienvenidaBitmap1: .asciiz "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
stringBienvenidaBitmap2: .asciiz "%        |   |  _        __          _              %"
stringBienvenidaBitmap3: .asciiz "%        |___| |_| |\\ | | _  |\\  /| |_| |\\ |        %"
stringBienvenidaBitmap4: .asciiz "%        |   | | | | \\| |__| | \\/ | | | | \\|        %"
stringBienvenidaBitmap5: .asciiz "%        |   |                                      %"
stringBienvenidaBitmap6: .asciiz "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"



stringInstruccionesBitmap1: .asciiz "BIENVENIDO/A AL JUEGO DEL AHORCADO!!!"
stringInstruccionesBitmap2: .asciiz "TRATA DE ADIVINAR LA PALABRA!"
stringInstruccionesBitmap3: .asciiz "CUIDADO: CADA ERROR TE COSTARA UNA VIDA"
stringInstruccionesBitmap4: .asciiz "TENDRAS 4 VIDAS INICIALES."
stringInstruccionesBitmap5: .asciiz "QUE TE DIVIERTAS!"
stringInstruccionesBitmap6: .asciiz "OBTENIENDO PALABRA A ADIVINAR..."



stringGameOverBitmap1: .asciiz "  _____             _ _     _       _ "
stringGameOverBitmap2: .asciiz " |  __ \\           | (_)   | |     | |"
stringGameOverBitmap3: .asciiz " | |__) |__ _ __ __| |_ ___| |_ ___| |"
stringGameOverBitmap4: .asciiz " |  ___/ _ \\ '__/ _` | / __| __/ _ \\ |"
stringGameOverBitmap5: .asciiz " | |   | __/ |  |(_| | \\__ \\ | | __/_|"
stringGameOverBitmap6: .asciiz " |_|   \\___|_|  \\__,_|_|___/\\__\\___(_)"



stringFelicitacionesBitmap1: .asciiz "  ______   _ _      _ _             _                       _ "
stringFelicitacionesBitmap2: .asciiz " |  ____| | (_)    (_) |           (_)                     | |"
stringFelicitacionesBitmap3: .asciiz " | |__ ___| |_  ___ _| |_ __ _  ___ _  ___  _ __   ___  ___| |"
stringFelicitacionesBitmap4: .asciiz " |  __/ _ \\ | |/ __| | __/ _` |/ __| |/ _ \\| '_ \\ / _ \\/ __| |"
stringFelicitacionesBitmap5: .asciiz " | |  | __/ | | (__| | | |(_| ||(__| ||(_)|| | | |  __/\\__ \\_|"
stringFelicitacionesBitmap6: .asciiz " |_|  \\___|_|_|\\___|_|\\__\\__,_|\\___|_|\\___/|_| |_|\\___||___(_)"
                   
                       
stringHeartBitmap1: .asciiz "     ******       ******"
stringHeartBitmap2: .asciiz "   **********   **********"
stringHeartBitmap3: .asciiz " ************* *************"
stringHeartBitmap4: .asciiz "*****************************"
stringHeartBitmap5: .asciiz "*****************************"
stringHeartBitmap6: .asciiz "*****************************"
stringHeartBitmap7: .asciiz " ***************************"
stringHeartBitmap8: .asciiz "   ***********************"
stringHeartBitmap9: .asciiz "     *******************"
stringHeartBitmap10: .asciiz "       ***************"
stringHeartBitmap11: .asciiz "         ***********"
stringHeartBitmap12: .asciiz "           *******"
stringHeartBitmap13: .asciiz "             ***"
stringHeartBitmap14: .asciiz "              *"


stringDeadBitmap1: .asciiz  "      ================="
stringDeadBitmap2: .asciiz  "     ||               ||"
stringDeadBitmap3: .asciiz  "    ||                 ||"
stringDeadBitmap4: .asciiz  "   ||  \\   /     \\   /  ||"
stringDeadBitmap5: .asciiz  " ||     \\ /       \\ /    ||"
stringDeadBitmap6: .asciiz  " ||     / \\       / \\    ||"
stringDeadBitmap7: .asciiz  " ||    /   \\     /   \\   ||"
stringDeadBitmap8: .asciiz "||                        ||"
stringDeadBitmap9: .asciiz "||           /\\           ||"
stringDeadBitmap10: .asciiz "||          /  \\          ||"
stringDeadBitmap11: .asciiz "||          ----         ||"
stringDeadBitmap12: .asciiz " ||                      ||"
stringDeadBitmap13: .asciiz " ||                      ||"
stringDeadBitmap14: .asciiz " ||   ________________   ||"
stringDeadBitmap15: .asciiz "  || |________________| ||"
stringDeadBitmap16: .asciiz "   ||                  ||"
stringDeadBitmap17: .asciiz "    ===================="



.text

  # Metodo dibujarLetra $a0=letra, $a1=pos X, $a2=pos Y, $a3=color
  
dibujarLetra:

  addiu $sp,$sp,-36
  sw $t0,($sp)
  sw $t1,4($sp)
  sw $t2,8($sp)
  sw $t3,12($sp)
  sw $t4,16($sp)
  sw $t5,20($sp)
  sw $t6,24($sp)
  sw $t7,28($sp)
  sw $t8,32($sp)

  
  li $t0,0 # contador fila
  li $t1,0 # contador columna
  li $t6,1 # bit comparador fila
  
  
iteracionFila:

  lw $t2, ($a0)

  #calculo posicion letra en pantalla
  li $t5, BASE  # posicion inicio display
  addu $t7,$a1,$t0
  sll $t7, $t7, 12  # * 4096
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
  lw $t7,28($sp)
  lw $t8,32($sp)
  addiu $sp,$sp,36
  jr $ra
  
  
  
###################################################################################################
  
  
  
 dibujarPalabra:
 
  addiu $sp,$sp,-36
  sw $ra,($sp)
  sw $t0,4($sp)
  sw $t1,8($sp)
  sw $t2,12($sp)
  sw $t3,16($sp)
  sw $t4,20($sp)
  sw $t5,24($sp)
  sw $t6,28($sp)
  sw $t7,32($sp)
  

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
  bne $t2,90,noZ
  la $a0,letraZ
  j dibujar
noZ:
  bne $t2,32,noEspacio
  la $a0,espacio
  j dibujar
noEspacio:
  bne $t2,95,noGuionBajo
  la $a0,guionBajo
  j dibujar
noGuionBajo:
  bne $t2,124,noVertical
  la $a0,vertical
  j dibujar
noVertical:
  bne $t2,92,noInvertida
  la $a0,invertida
  j dibujar
noInvertida:
  bne $t2,47,noBarra
  la $a0,barra
  j dibujar
noBarra:
  bne $t2,45,noGuion
  la $a0,guion
  j dibujar
noGuion:
  bne $t2,40,noParIzq
  la $a0,parIzq
  j dibujar
noParIzq:
  bne $t2,41,noParDer
  la $a0,parDer
  j dibujar
noParDer:
  bne $t2,96,noTildeInverso
  la $a0,tildeInverso
  j dibujar
noTildeInverso:
  bne $t2,44,noComa
  la $a0,coma
  j dibujar
noComa:
  bne $t2,39,noApostrofe
  la $a0,apostrofe
  j dibujar
noApostrofe:
  bne $t2,42,noAsterisco
  la $a0,asterisco
  j dibujar
noAsterisco:
  bne $t2,58,noDosPuntos
  la $a0,dosPuntos
  j dibujar
noDosPuntos:
  bne $t2,37,noPorcentaje
  la $a0,porcentaje
  j dibujar
noPorcentaje:
  bne $t2,46,noPunto
  la $a0,punto
  j dibujar
noPunto:
  bne $t2,33,noExclamacion
  la $a0,exclamacion
  j dibujar
noExclamacion:
  bne $t2,61,noIgual
  la $a0,igual
  j dibujar
noIgual:  
  bne $t2,52,noNumero4
  la $a0,numero4
  
  
dibujar:
  
  jal dibujarLetra
  addiu $a2,$a2,15 #separacion entre letras (cantidad de columnas)
  
  
  addiu $t0,$t0,1
  
  j whileMostrarNoCero

noNumero4:# si no se encuentra el caracter en el diccionario no se imprime nada  

finWhileMostrarNoCero:

  
  lw $ra,($sp)
  lw $t0,4($sp)
  lw $t1,8($sp)
  lw $t2,12($sp)
  lw $t3,16($sp)
  lw $t4,20($sp)
  lw $t5,24($sp)
  lw $t6,28($sp)
  lw $t7,32($sp)
  addiu $sp,$sp,36
  
  jr $ra
  
  
  
###################################################################################################
  
  
  
dibujarAdivinandoPalabra:
  
  addiu $sp,$sp,-4
  sw $ra,($sp)

  la $a0,adivinandoPalabra
  li $a1, 50 # FILA
  li $a2, 650 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  jr $ra



###################################################################################################



dibujarLetrasIngresadas:

  addiu $sp,$sp,-4
  sw $ra,($sp)

  la $a0,letrasIngresadas
  li $a1, 120 # FILA
  li $a2, 650 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
  

###################################################################################################



dibujarStringLetrasIngresadas:

  addiu $sp,$sp,-4
  sw $ra,($sp)

  la $a0,stringLetras
  li $a1, 100 # FILA
  li $a2, 650 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
  
  
###################################################################################################
  
  

dibujarStringPalabraAAdivinar:

  addiu $sp,$sp,-4
  sw $ra,($sp)

  la $a0,stringPalabraAAdivinar
  li $a1, 200 # FILA
  li $a2, 650 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra



###################################################################################################



dibujarPalabraAAdivinar:

  addiu $sp,$sp,-4
  sw $ra,($sp)

  la $a0,palabraAAdivinar
  li $a1, 220 # FILA
  li $a2, 650 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra



###################################################################################################



limpiarPantalla: # $a0 = color

  li $t0,2097152 #cantidad de direcciones de memoria de la pantalla (1024 x 512)
  li $t1,0 #contador
  la $t2,BASE #direccion base pantalla
whilePintarFondo:
  addu $t3,$t2,$t1
  sw $a0,($t3)
  addiu $t1,$t1,4
  ble $t1,$t0,whilePintarFondo
    
  jr $ra
  


###################################################################################################



dibujarGameOver:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringGameOverBitmap1
  li $a1, 20 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringGameOverBitmap2
  li $a1, 35 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringGameOverBitmap3
  li $a1, 50 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringGameOverBitmap4
  li $a1, 65 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringGameOverBitmap5
  li $a1, 80 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringGameOverBitmap6
  li $a1, 95 # FILA
  li $a2, 200 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
  
  
###################################################################################################
  
  
  
dibujarFelicitaciones:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringFelicitacionesBitmap1
  li $a1, 20 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringFelicitacionesBitmap2
  li $a1, 30 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringFelicitacionesBitmap3
  li $a1, 40 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringFelicitacionesBitmap4
  li $a1, 50 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringFelicitacionesBitmap5
  li $a1, 60 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringFelicitacionesBitmap6
  li $a1, 70 # FILA
  li $a2, 40 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
  
  
###################################################################################################
    
    
    
dibujarHeart:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringHeartBitmap1
  li $a1, 200 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringHeartBitmap2
  li $a1, 220 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringHeartBitmap3
  li $a1, 240 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringHeartBitmap4
  li $a1, 260 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringHeartBitmap5
  li $a1, 280 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringHeartBitmap6
  li $a1, 300 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap7
  li $a1, 320 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap8
  li $a1, 340 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap9
  li $a1, 360 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap10
  li $a1, 380 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap11
  li $a1, 400 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap12
  li $a1, 420 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap13
  li $a1, 440 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringHeartBitmap14
  li $a1, 460 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0xFF0000 # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra    



###################################################################################################



dibujarBienvenida:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringBienvenidaBitmap1
  li $a1, 20 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringBienvenidaBitmap2
  li $a1, 40 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringBienvenidaBitmap3
  li $a1, 60 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringBienvenidaBitmap4
  li $a1, 80 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringBienvenidaBitmap5
  li $a1, 100 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringBienvenidaBitmap6
  li $a1, 120 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra
  
  
  
###################################################################################################  



dibujarInstrucciones:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringInstruccionesBitmap1
  li $a1, 250 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringInstruccionesBitmap2
  li $a1, 270 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringInstruccionesBitmap3
  li $a1, 290 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringInstruccionesBitmap4
  li $a1, 310 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringInstruccionesBitmap5
  li $a1, 330 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringInstruccionesBitmap6
  li $a1, 350 # FILA
  li $a2, 100 # COLUMNA
  li $a3, 0x1F6CDF # COLOR

  jal dibujarPalabra
  
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra



###################################################################################################  



dibujarDead:

  addiu $sp,$sp,-4
  sw $ra,($sp)


  la $a0,stringDeadBitmap1
  li $a1, 150 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap2
  li $a1, 170 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap3
  li $a1, 190 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap4
  li $a1, 210 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap5
  li $a1, 230 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap6
  li $a1, 250 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap7
  li $a1, 270 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap8
  li $a1, 290 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap9
  li $a1, 310 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap10
  li $a1, 330 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap11
  li $a1, 350 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap12
  li $a1, 370 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap13
  li $a1, 390 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
    
  
  la $a0,stringDeadBitmap14
  li $a1, 410 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap15
  li $a1, 430 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap16
  li $a1, 450 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
  
  la $a0,stringDeadBitmap17
  li $a1, 470 # FILA
  li $a2, 300 # COLUMNA
  li $a3, 0x686767 # COLOR

  jal dibujarPalabra
  
    
  lw $ra,($sp)
  addiu $sp,$sp,4
  
  jr $ra    
