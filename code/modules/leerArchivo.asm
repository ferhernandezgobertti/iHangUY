.globl leerArchivo

.data

  nombreArchivo: .asciiz "/Users/ferhernandez/Desktop/palabras.txt"    # DIRECCION DEL ARCHIVO A LEER (por favor: respetar formato)
  palabrasLectura: .space 20000				          # Array Auxiliar de Palabras e Informacion (de codificacion del archivo) recien leidas del archivo  
.text


leerArchivo:

  # Abrir (para leer) un archivo que existe
  
  li $v0, 13                                                           # System Call para abrir el archivo
  la $a0, nombreArchivo                                                # Direccion del Archivo para Lectura
  li $a1, 0                                                            # Determina la Accion a Realizar: Leer ( $a1 = 0 ) o Escribir ( $a1 = 1 )
  li $a2, 0                                                            # Indica el "modo" del archivo. Con 0 se ignora el parametro y no se usa.
  syscall                                                              # Se abre el archivo. En $v0 devuelve un entero que describe el archivo abierto (necesario para lectura)
  move $t0, $v0                                                        
  
  
  # Lectura desde el Archivo recien Abierto
  
  li $v0, 14                                                          # System Call para leer el archivo
  move $a0, $t0                                                       # Se ingresa como parametro en $a0 el entero que describe el archivo
  la $a1, palabrasLectura                                             # Direccion de donde cargar lo leido. En este caso, en el Array Auxiliar
  li $a2, 20000                                                       # Cantidad maxima de caracteres a leer y cargar
  syscall                                                             # Se lee el archivo.  En $v0 devuelve un entero que corresponde a la cantidad de caracteres leidos
  move $t1, $v0
  
  # Cerrado del Archivo Leido
   
  li $v0, 16                                                          # System Call para cerrar el archivo leido
  move $a0, $t0                                                       # Se cierra el descriptor del archivo
  syscall                                                             # Se cierra el archivo. No hay devolucion
  
  nop                                                                 # Usado para BreakPoints en el testeo y debugeo. No realiza accion
  
  
  la $t0, palabrasLectura                                            # Direccion del Array Auxiliar
  addu $t1, $t0, $t1 
  la $t2,palabrasConCeros                                             # Direccion del Array Final
  
iteracion:
  
  lb $t3, ($t0)                                                      # Se carga byte del Array Auxiliar
  bne $t3,10,noQuitarEnter	# Si byte de Array Auxiliar es igual a un enter ('\n')
  li $t3, 48
noQuitarEnter:
  sb $t3, ($t2)                                                     # Se guarda byte en el Array Final
  addiu $t0,$t0,1                                                   # Se avanza de posicion en el Array Auxiliar
  addiu $t2,$t2,1                                                   # Se avanza de posicion en el Array Final
  
  bne $t0,$t1,iteracion                                             # Si se termino de recorrer el Array Auxiliar
  
  li $t3, 48                                                        # Se coloca un cero ('0')
  sb $t3, ($t2)

  jr $ra
