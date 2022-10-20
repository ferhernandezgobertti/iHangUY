.data

pez: .asciiz "POLLO"


.text

main:
  la $a0,pez # direccion string
  li $a1, 50 # FILA
  li $a2, 20 # COLUMNA
  li $a3, 0x0000FF00 # COLOR

jal dibujarPalabra

li $v0,10
syscall
