# ---------------------------------------------------------------
# Assembly language program that reads data from the switches
# and displays it on the LEDs.
# ---------------------------------------------------------------

.text

# define a macro to move a 32 bit address to a register

.macro MOVIA reg, addr
  movhi \reg, %hi(\addr)
  ori \reg, \reg, %lo(\addr)
.endm

# define constants
.equ Switches, 0x11020    #find the base address of Switches in the system.h file
.equ Hex_0,    0x11010    #find the base address of Switches in the system.h file
.equ Keys,     0x11000    #find the base address of Switches in the system.h file
.equ Key_1,    0x02
.equ Switch_0, 0x01
.equ ZERO,     0x40
.equ ONE,      0x79
.equ TWO,      0x24
.equ THREE,    0x30
.equ FOUR,     0x19
.equ FIVE,     0x12
.equ SIX,      0x02
.equ SEVEN,    0x78
.equ EIGHT,    0x00
.equ NINE,     0x18

#Define the main program
.global main
main:
  movia r2, Hex_0        #move the pointer to the hex display in r2
  movia r3, Switches     #move the pointer to the switches in r3
  movia r4, Keys         #move the pointer to the keys into  R4
  movia r5, display      #move the pointer of array into r2
  mov   r7, r0           #load the first element of the area
top:
  ldb   r6, 0(r5)        #load the first element of the area
loop:
  stbio r6, 0(r2)           #store the element of the array into Hex_0
  ldbio r8, 0(r4)           #load the value of keys into r8
  xor   r9, r7, r8          #xor r7 and r8 store outcome in r9
  and   r9, r9, r8          #and r9 and r8 store outcome in r9
  andi  r9, r9, Key_1       #and with Key_1 to maskout other keys
  mov   r7, r8              #move data in r8 to r7
  bne   r0, r9 ,counter     #if r9 is not zero goto counter
  br loop

counter:
  movia r10, display        #
  ldbio r11,0(r3)           #load value of switches in r10
  andi  r11, r11, Switch_0  #and with switch_0 to maskout switches
  bne   r0, r11, increment  #if r11 is not 0 goto increment
  beq   r10, r5, loop
  subi  r5, r5, 4
  br top
increment:
  addi  r10, r10, 36
  beq   r10, r5, loop
  addi  r5, r5, 4
  br    top
display:
  .word ZERO,ONE,TWO,THREE,FOUR
  .word FIVE,SIX,SEVEN,EIGHT,NINE