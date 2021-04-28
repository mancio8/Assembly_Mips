# Dovete scrivere un programma che conta il numero di vocali all'interno di una stringa ricevuta in
# input e lo stampa in output.
# Il main legge da tastiera una stringa e ne verifica la lunghezza. Se la lunghezza della stringa �
# al pi� 40 caratteri, richiama una funzione conta_vocali, fornendole come parametro il puntatore 
# alla stringa. La funzione ritorna il numero di vocali presenti nella stringa, che verr� stampato 
# dal main. Qualora la lunghezza della stringa ecced i 40 caratteri, verr� emesso un messaggio di 
# errore e l'input sar� ripetuto.

######### DATA SEGMENT ###########
.data
prompt1: .asciiz "Dammi una stringa (max 40 caratteri): \n"
prompt2: .asciiz "\nNumero di vocali presenti nella stringa: "
prompt3: .asciiz "\nLa stringa e' lunga: "
prompt4_errore: .asciiz "\nLunghezza stringa superata. Dammi una nuova stringa: "
str: .space 41
######### CODE SEGMENT ###########

.text
.globl main
main:
  la   $a0, prompt1
  li   $v0, 4
  syscall
  
  rollback:
   la      $a0, str
   li      $a1, 41         # Non serve definire uno spazio eccessivamente grande, se inserisce 41 caratteri gi� ha ecceduto la stringa.
   li      $v0, 8
   syscall
  
   la      $a0,   str
   jal      strlen         # Precondizione: richiede in a0 l'idnirizzo della stringa. Postcondizione: restituisce in v0 la lunghezza della stringa.
   move   $v1, $v0         # Poich� sporcher� v0, il valore ritornato lo sposto in v1
   
  bgt      $v1, 40, error
  
  la      $a0, prompt2
  li      $v0, 4
  syscall
  
  la      $a0, str
  jal      conta_vocali      # Precondizione: richiede in a0 l'indirizzo della stringa. Postcondizione: restituisce in v0 il numero totale di vocali presenti nella stringa.

  move   $a0, $v0  
  li      $v0, 1
  syscall
  
  la      $a0, prompt3
  li      $v0, 4
  syscall
  
  move   $a0, $v1
  li      $v0, 1
  syscall
  
  li      $v0, 10         # Exit program
  syscall
  
error:
 la   $a0, prompt4_errore
 li   $v0, 4
 syscall
 
 j   rollback


strlen:               # Precondizione: richiede in a0 l'idnirizzo della stringa. Postcondizione: restituisce in v0 la lunghezza della stringa.
 addu   $v0, $zero, $zero   # Contatore (invece di adoperare un registro temporaneo, adopero direttamente v0)
 strlen_loop:
  lbu      $t0, 0($a0)
  beq      $t0, '\n', strlen_exit
  addiu   $v0, $v0, 1      # Incremento contatore
  addiu   $a0, $a0, 1
  j      strlen_loop
  
  strlen_exit:
   jr      $ra
   

conta_vocali:            # Non discrimina maiuscolo e minuscolo
 addu   $v0, $zero, $zero   # Inizializzo contatore. Adopero direttamente v0 essendo il valore ritornato, anzich� sprecare un registro temporaneo.
 contavoc_loop:
  lbu      $t0, 0($a0)
  beq      $t0, 'a', vocale
  beq      $t0, 'e', vocale
  beq      $t0, 'i', vocale
  beq      $t0, 'o', vocale
  beq      $t0, 'u', vocale
  beq      $t0, 'A', vocale
  beq      $t0, 'E', vocale
  beq      $t0, 'I', vocale
  beq      $t0, 'O', vocale
  beq      $t0, 'U', vocale
  

  next:
     addiu  $a0, $a0, 1
     bne   $t0, '\0', contavoc_loop
     jr      $ra
  
  vocale:
   addiu   $v0, $v0, 1
   j      next
