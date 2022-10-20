.globl dibujarModelos
.globl bienvenida
.globl instrucciones
.globl palabraSeleccionada
.globl mostrarPalabra
.globl mostrarOpciones
.globl errorPalabraSeleccionada
.globl finGanador
.globl finPerdedor
.globl stringLetraEsta
.globl stringLetraNoEsta
.globl stringLetraYaIngresada
.globl mostrarIngresoIncorrecto
.globl mostrarOpcionesTeclado


.data

stringPaloSuperior: .asciiz    "\n\n                                          _________________________"
stringSuperior: .asciiz      "\n                                         |                         |"
stringPaloModelo1: .asciiz   "\n                                         |"
stringCara1: .asciiz "                     -------- "
stringOjosModelo2: .asciiz "                    / o    o "
stringOjosModelo3: .asciiz "                    /(o    o)"
stringOjosModelo4: .asciiz "                    / O    O "
stringOjosModelo5: .asciiz "                    / X    X "
stringCara2: .asciiz "                    |   ||   | "
stringCara3: .asciiz "                    |  ____  |"
stringCara4: .asciiz "                    |________|"
stringCara5: .asciiz "                       |  |"
stringTorso1: .asciiz " ____________ "
stringTorso2: .asciiz "|            |"
stringTorso3: .asciiz "|____________|"
stringEspacio: .asciiz "                  "
stringBrazo1: .asciiz  "    O-------------"
stringBrazo2: .asciiz  "-------------O   "
stringPiernas: .asciiz "   |      |    "
stringPies: .asciiz    "___|      |___  "
stringBase1: .asciiz "\n                                         /"
stringBase2: .asciiz "\n                                        /  "
stringBase3: .asciiz "\n                                       /    "
stringBase4: .asciiz "\n                                      /      "
stringBase5: .asciiz "\n                                     /        "
.eqv ascii_barraInvertida, 92



#objeto a dibujar por consola
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# %        |   |  _        __          _              %
# %        |___| |_| |\ | | _  |\  /| |_| |\ |        %
# %        |   | | | | \| |__| | \/ | | | | \|        %
# %        |   |                                      %
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stringBienvenida: .asciiz "\n \n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \n %        |   |  _        __          _              % \n %        |___| |_| |\\ | | _  |\\  /| |_| |\\ |        % \n %        |   | | | | \\| |__| | \\/ | | | | \\|        % \n %        |   |                                      % \n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
stringInstrucciones: .asciiz "\n BIENVENIDO/A AL JUEGO DEL AHORCADO!!! \n Trata de adivinar la palabra! Pero ten cuidado: Cada error te costara una vida y tendras 4 vidas iniciales. QUE TE DIVIERTAS!\n\n Obteniendo palabra a adivinar...\n"
stringOpciones: .asciiz "\n\n\n Ingresa una letra para comenzar o ingresa '0' para SALIR DEL PROGRAMA :-( \n\n"
stringSeleccionada: .asciiz " Exito al cargar la palabra, comienza el juego\n"
stringErrorSeleccionada: .asciiz " Error al cargar la palabra, intentando nuevamente\n"
stringLetraEsta: .asciiz "\n Encontraste una letra!"
stringLetraNoEsta: .asciiz "\n La letra no se encuentra :("
stringLetraYaIngresada: .asciiz "\n Ya ingresaste esta letra!"
stringIngresoIncorrecto: .asciiz "\n te perdonamos la vida, por favor ingresa una letra"
stringOpcionesTeclado: .asciiz "Deseas usar el Keyboard MMIO?\n\nLea la pantalla antes de elegir opcion"

stringGameOver: .asciiz "\n  _____             _ _     _       _ \n |  __ \\           | (_)   | |     | |\n | |__) |__ _ __ __| |_ ___| |_ ___| |\n |  ___/ _ \\ '__/ _` | / __| __/ _ \\ |\n | |  |  __/ | | (_| | \\__ \\ ||  __/_|\n |_|   \\___|_|  \\__,_|_|___/\\__\\___(_)\n"
stringFelicitaciones: .asciiz "\n  ______          _   _          _   _                    _                                _ \n |  ____|        | | (_)        (_) | |                  (_)                              | |\n | |__      ___  | |  _    ___   _  | |_    __ _    ___   _    ___    _ __     ___   ___  | |\n |  __|    / _ \\ | | | |  / __| | | | __|  / _` |  / __| | |  / _ \\  | '_ \\   / _ \\ / __| | |\n | |      |  __/ | | | | | (__  | | | |_  | (_| | | (__  | | | (_) | | | | | |  __/ \\__ \\ |_|\n |_|       \\___| |_| |_|  \\___| |_|  \\__|  \\__,_|  \\___| |_|  \\___/  |_| |_|  \\___| |___/ (_)\n"


.eqv ascii_cero,48 #(0)
.eqv ascii_intro,10
.eqv ascii_espacio, 32


.text

###################################################################################################

dibujarModelos:
  sw $ra,-4($sp)
  
  move $t0,$a0  #Paso a $t0 (que ahora contiene la cantidad de vidas restantes) para no sobreescribir
  li $t1,0 # Contador para iteraciones
  li $v0,4 # Impresion de String
  la $a0,stringPaloSuperior #Impresion de la primera linea (la mas superior)
  syscall
  
iteracionGeneral: #iteracion para la creacion de todos los palos hasta la creacion de la cabeza del ahorcado
  la $a0, stringSuperior
  syscall
  addiu $t1,$t1,1
  bne $t1,3,iteracionGeneral
  li $t1,0 # Reinicializacion de las variables para reutilizar codigo
  
  beq $t0,4,dibujarModelo1 # Si el Usuario no perdio ninguna vida, se le muestra el Modelo 1 (solo la horca)
  
  jal dibujarPaloVertical # Si el usuario perdio alguna vida, comienza igualmente con la creacion del palo vertical de la horca
  la $a0, stringCara1 # Comienzo dibujo de cara del ahorcado (pelo y contorno del rostro)
  syscall
  jal dibujarPaloVertical
  beq $t0,3,ojosModelo2 # Diferentes modelos de ojos recreados (ojos chicos, grandes, desesperacion, muerte)
  beq $t0,2,ojosModelo3
  beq $t0,1,ojosModelo4
  beq $t0,0,ojosModelo5
  
  ojosModelo2:
  la $a0, stringOjosModelo2
  syscall
  j continuacion
  
  ojosModelo3:
  la $a0, stringOjosModelo3
  syscall
  j continuacion
  
  ojosModelo4:
  la $a0, stringOjosModelo4
  syscall
  j continuacion
  
  ojosModelo5:
  la $a0, stringOjosModelo5
  syscall
  j continuacion
  
continuacion:
  
  jal barraInvertida # Funcion que imprime la barra invertida '\' por una imposibilidad de hacerlo directamente 
  jal dibujarPaloVertical
  la $a0, stringCara2 #Continuacion del dibujo del rostro del ahorcado (nariz, boca, contorno de la cara, cuello)
  syscall
  jal dibujarPaloVertical
  la $a0, stringCara3
  syscall
  jal dibujarPaloVertical
  la $a0, stringCara4
  syscall
  jal dibujarPaloVertical
  la $a0, stringCara5
  syscall
  
  beq $t0,3,dibujarModelo2 # Si tiene 3 vidas restantes (es decir, si perdio 1 vida)
  beq $t0,2,dibujarModelo3 # Si tiene 2 vidas restantes (es deicr, si perdio 2 vidas)
  ble $t0,1,dibujarModelo4 # Si tiene 1 o menos vidas restantes (es decir, si perdio 3 o todas las vidas disponibles)

# Registro $t2 contiene la cantidad de iteraciones requeridas para, una vez terminado el modelo particular de cada caso, 
# dibujar el resto de la horca. De esta forma, cuanto menos vidas tenga, menor sera el valor registrado en $t2

dibujarModelo1: # Modelo 1 = Horca
  
  li $t2,24
  j continuarDibujo
  
dibujarModelo2: # Modelo 2 = Modelo 1 + Rostro
  
  li $t2,18
  j continuarDibujo
  
dibujarModelo3: # Modelo 3 = Modelo 2 + Torso
  
  jal dibujarPaloVertical
  jal espacio # Funcion que se encarga de imprimir un String de espacios en blanco (' ')
  la $a0, stringTorso1 # Comienzo del dibujo del Torso
  syscall
  
iteracionTorso: # Iteracion para la impersion del Torso, repitiendo para toda la longitud del torso considerada
  
  jal dibujarPaloVertical
  jal espacio
  la $a0, stringTorso2
  syscall
  addiu $t1,$t1,1
  bne $t1,8,iteracionTorso
  
  li $t1,0
  jal dibujarPaloVertical
  jal espacio
  la $a0, stringTorso3 # Termino de la impresion del Torso del ahorcado (base del Torso)
  syscall
  beq $t0,0,dibujarModelo5 # Caso particular: si ya no tiene vidas el usuario
  li $t2,9
  j continuarDibujo

dibujarModelo4: # Modelo 4 = Modelo 3 + Brazos

  jal dibujarPaloVertical
  la $a0, stringBrazo1 # Impresion del brazo derecho del ahorcado
  syscall
  la $a0, stringTorso1 # Impresion de la parte superior del Torso
  syscall
  la $a0, stringBrazo2 # Impresion del brazo izquierdo del ahorcado
  syscall
  j iteracionTorso # Continua la impresion del Torso
  
dibujarModelo5: # Modelo 5 = Modelo 4 + Piernas
  
  jal dibujarPaloVertical
  jal espacio
  la $a0, stringPiernas # Impresion de las piernas del ahorcado
  syscall
  addiu $t1,$t1,1
  bne $t1,6,dibujarModelo5 # Iteracion para la impresion de las piernas del ahorcado
  li $t1,0
  jal dibujarPaloVertical
  jal espacio
  la $a0, stringPies # Impresion de los pies del ahorcado (base de las piernas)
  syscall
  li $t2,2
  
continuarDibujo: # Comun a todos los modelos: Impresion del resto de la horca y base de la misma

# Impresion del Resto de la Horca (longitud variable para cada modelo, dada por $t2)  
  
  jal dibujarPaloVertical
  addiu $t1,$t1,1
  bne $t1,$t2,continuarDibujo

# Impresion de la base de la horca

  la $a0,stringBase1
  syscall
  jal barraInvertida
  la $a0,stringBase2
  syscall
  jal barraInvertida
  la $a0,stringBase3
  syscall
  jal barraInvertida
  la $a0,stringBase4
  syscall
  jal barraInvertida
  la $a0,stringBase5
  syscall
  jal barraInvertida
  
  
  li $v0,11
  li $a0,10
  syscall
  
  j finDibujo

###### Termina el dibujo!!! #####################


dibujarPaloVertical:

  la $a0,stringPaloModelo1
  syscall
  jr $ra

barraInvertida:

  li $v0,11
  li $a0,ascii_barraInvertida
  syscall
  li $v0,4
  jr $ra

espacio:
  la $a0, stringEspacio
  syscall
  jr $ra

finDibujo:  
  lw $ra,-4($sp)
  jr $ra


###################################################################################################

bienvenida:

  li $v0,4
  la $a0, stringBienvenida
  syscall
  
  jr $ra

###################################################################################################
  
instrucciones:

  li $v0,4
  la $a0, stringInstrucciones
  syscall
  
  jr $ra
  
###################################################################################################
  
mostrarOpciones:

  li $v0,4
  la $a0, stringOpciones
  syscall
  
  jr $ra
  
###################################################################################################
  
palabraSeleccionada:
  
  li $v0,4
  la $a0, stringSeleccionada
  syscall
  
  jr $ra
  
###################################################################################################
  
errorPalabraSeleccionada:
  
  li $v0,4
  la $a0, stringErrorSeleccionada
  syscall
  
  jr $ra
  
###################################################################################################
  
mostrarIngresoIncorrecto:

  li $v0,4
  la $a0, stringIngresoIncorrecto
  syscall
  
  jr $ra
  
###################################################################################################
  
mostrarPalabra:

  li $t0,0 #contador
  move $t1,$a0
  
  li $v0,11
  li $a0,ascii_intro
  syscall
  
whileMostrarNoCero:
  
  addu $t2,$t1,$t0
  
  li $v0,11
  lb $a0,($t2)
  beqz $a0,finWhileMostrarNoCero
  syscall
  
  li $v0,11
  li $a0,ascii_espacio
  syscall
  
  addiu $t0,$t0,1
  
  j whileMostrarNoCero
  
finWhileMostrarNoCero:

  li $v0,11
  li $a0,ascii_intro
  syscall
  
  li $v0,11
  li $a0,ascii_intro
  syscall

  jr $ra

###################################################################################################
            
finGanador:

  li $v0,4
  la $a0, stringFelicitaciones
  syscall
  
  jr $ra

###################################################################################################

finPerdedor:

  li $v0,4
  la $a0, stringGameOver
  syscall
  
  jr $ra
  
  ###################################################################################################
  
 
 
mostrarOpcionesTeclado:

  li $v0,50
  la $a0,stringOpcionesTeclado
  syscall
  
  move $v0,$a0
  
  jr $ra

