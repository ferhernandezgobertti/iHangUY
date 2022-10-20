.globl dibujarModelosBitmap

.data

stringPaloSuperiorBtmp: .asciiz  "         ========================"
stringSuperiorBtmp: .asciiz      "         ||                    ||"
stringPaloModelo1Btmp: .asciiz   "         ||"
stringCara1Btmp: .asciiz                   "                     ------ "
stringOjosModelo2Btmp: .asciiz             "                    / O  O \\"
stringOjosModelo3Btmp: .asciiz             "                    /(O  O)\\"
stringOjosModelo4Btmp: .asciiz             "                    /|O  O|\\"
stringOjosModelo5Btmp: .asciiz             "                    / X  X \\"
stringCara2Btmp: .asciiz                   "                    |  ||  | "
stringCara3Btmp: .asciiz                   "                    | ____ |"
stringCara4Btmp: .asciiz                   "                    |______|"
stringCara5Btmp: .asciiz                   "                      |  |"
stringCara6Btmp: .asciiz                   "                    |      |"
stringTorso1ParaBrazosBtmp: .asciiz "_________"
stringTorso1Btmp: .asciiz                  "                   _________ "
stringTorso2Btmp: .asciiz                  "                   |        |"
stringTorso3Btmp: .asciiz                  "                   |________|"
stringBrazo1Btmp: .asciiz                  "         O--------"
stringBrazo2Btmp: .asciiz                                                "--------O"
stringPiernasBtmp: .asciiz                 "                   |   |"
stringPiesBtmp: .asciiz                    "                ___|   |___  "
stringBase1Btmp: .asciiz "         / \\"
stringBase2Btmp: .asciiz "        /   \\"
stringBase3Btmp: .asciiz "       /     \\"
stringBase4Btmp: .asciiz "      /       \\"
stringBase5Btmp: .asciiz "     /         \\"

.text

dibujarModelosBitmap:

  addiu $sp, $sp, -4
  sw $ra,($sp)
  
  move $t0,$a0  #Paso a $t0 (que ahora contiene la cantidad de vidas restantes) para no sobreescribir
  li $t1,0 # Contador para iteraciones
  li $t3,0
  la $a0,stringPaloSuperiorBtmp #Impresion de la primera linea (la mas superior)
  li $a1, 1
  li $a2, 1
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
iteracionGeneral: #iteracion para la creacion de todos los palos hasta la creacion de la cabeza del ahorcado

  la $a0, stringSuperiorBtmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,1
  jal dibujarPalabra
  addiu $t1, $t1, 1
  bne $t1,3,iteracionGeneral
  li $t1, 0 # Reinicializacion de las variables para reutilizar codigo
  li $a2, 1
  beq $t0,4,dibujarModelo1 # Si el Usuario no perdio ninguna vida, se le muestra el Modelo 1 (solo la horca)
  
  jal parametrosModelo1
  jal dibujarPalabra # Si el usuario perdio alguna vida, comienza igualmente con la creacion del palo vertical de la horca
  
  la $a0, stringCara1Btmp # Comienzo dibujo de cara del ahorcado (pelo y contorno del rostro)
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra # Si el usuario perdio alguna vida, comienza igualmente con la creacion del palo vertical de la horca
  
  beq $t0,3,ojosModelo2 # Diferentes modelos de ojos recreados (ojos chicos, grandes, desesperacion, muerte)
  beq $t0,2,ojosModelo3
  beq $t0,1,ojosModelo4
  beq $t0,0,ojosModelo5
  
  ojosModelo2:
  la $a0, stringOjosModelo2Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  j continuacion
  
  ojosModelo3:
  la $a0, stringOjosModelo3Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  j continuacion
  
  ojosModelo4:
  la $a0, stringOjosModelo4Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  j continuacion
  
  ojosModelo5:
  la $a0, stringOjosModelo5Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  j continuacion
  
  continuacion:
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara6Btmp #Continuacion del dibujo del rostro del ahorcado (nariz, boca, contorno de la cara, cuello)
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara2Btmp #Continuacion del dibujo del rostro del ahorcado (nariz, boca, contorno de la cara, cuello)
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara6Btmp #Continuacion del dibujo del rostro del ahorcado (nariz, boca, contorno de la cara, cuello)
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara3Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara6Btmp #Continuacion del dibujo del rostro del ahorcado (nariz, boca, contorno de la cara, cuello)
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara4Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringCara5Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  beq $t0,3,dibujarModelo2 # Si tiene 3 vidas restantes (es decir, si perdio 1 vida)
  beq $t0,2,dibujarModelo3 # Si tiene 2 vidas restantes (es decir, si perdio 2 vidas)
  ble $t0,1,dibujarModelo4 # Si tiene 1 o menos vidas restantes (es decir, si perdio 3 o todas las vidas disponibles)
  
  dibujarModelo1: # Modelo 1 = Horca
  
  li $t2, 40
  li $t1, 0
  j continuarDibujo
  
  dibujarModelo2: # Modelo 2 = Modelo 1 + Rostro
  
  li $t2, 31
  li $t1, 0
  j continuarDibujo
  
  dibujarModelo3: # Modelo 3 = Modelo 2 + Torso
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringTorso1Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  li $t1, 0
  
iteracionTorso: # Iteracion para la impersion del Torso, repitiendo para toda la longitud del torso considerada
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringTorso2Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  addiu $t1,$t1,1
  bne $t1,12,iteracionTorso
  
  li $t1,0
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringTorso3Btmp
  move $a1, $t3
  li $a2, 130
  jal elegirColor
  jal dibujarPalabra
  
  li $t1, 0
  beq $t0,0,dibujarModelo5 # Caso particular: si ya no tiene vidas el usuario
  li $t2, 17
  j continuarDibujo
  
  dibujarModelo4: # Modelo 4 = Modelo 3 + Brazos

  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringBrazo1Btmp
  move $a1, $t3
  jal elegirColor
  jal dibujarPalabra
  
  la $a0, stringTorso1ParaBrazosBtmp
  move $a1, $t3
  jal elegirColor
  jal dibujarPalabra
  
  la $a0, stringBrazo2Btmp
  move $a1, $t3
  jal elegirColor
  jal dibujarPalabra
  
  li $t1, 0
  
  j iteracionTorso # Continua la impresion del Torso
  
dibujarModelo5: # Modelo 5 = Modelo 4 + Piernas
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringPiernasBtmp
  move $a1, $t3
  jal elegirColor
  jal dibujarPalabra
  
  addiu $t1,$t1,1
  bne $t1,6,dibujarModelo5 # Iteracion para la impresion de las piernas del ahorcado
  li $t1,0
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  la $a0, stringPiesBtmp
  move $a1, $t3
  jal elegirColor
  jal dibujarPalabra
  
  li $t2,10
  
  continuarDibujo: # Comun a todos los modelos: Impresion del resto de la horca y base de la misma

# Impresion del Resto de la Horca (longitud variable para cada modelo, dada por $t2)  
  
  jal parametrosModelo1
  jal dibujarPalabra
  
  addiu $t1, $t1, 1
  bne $t1,$t2,continuarDibujo

# Impresion de la base de la horca

  la $a0,stringBase1Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,0
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
  la $a0,stringBase2Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,0
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
  la $a0,stringBase3Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,0
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
  la $a0,stringBase4Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,0
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
  la $a0,stringBase5Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2,0
  li $a3, 0x331900 # COLOR
  jal dibujarPalabra
  
  j finDibujo


finDibujo:  
  lw $ra,($sp)
  addiu $sp, $sp, 4
  jr $ra

elegirColor:

  bne $t0, 3, noColor1 
  li $a3, 0xBF5555
  j finElegirColor
  
noColor1:
  bne $t0, 2, noColor2
  li $a3, 0x6C43A2
  j finElegirColor
  
noColor2:
  beq $t0, 1, noColor3
  li $a3, 0x3B339F
  j finElegirColor
 
noColor3:
  li $a3, 0x4700B0
  
finElegirColor:

  jr $ra

parametrosModelo1:

  la $a0, stringPaloModelo1Btmp
  addiu $t3,$t3,10
  move $a1, $t3
  li $a2, 1
  li $a3, 0x331900 # COLOR
  jr $ra

###################################################################################################
