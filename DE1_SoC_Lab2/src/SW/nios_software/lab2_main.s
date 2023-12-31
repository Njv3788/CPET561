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

# define registers
.equ Switches, 0x11020
.equ Hex_0,    0x11010
.equ Keys,     0x11000
# define pins of registers
.equ Key_1,    0x02
.equ Switch_0, 0x01
# define constants
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
  movia r2, Hex_0           #move the pointer to the hex display in r2
  movia r3, Switches        #move the pointer to the switches in r3
  movia r4, Keys            #move the pointer to the keys into  R4
  movia r5, display_start   #move the pointer of array into r2
  mov   r7, r0              #load the first element of the area
top:
  ldb   r6, 0(r5)           #load the first element of the area
loop:
  stbio r6, 0(r2)           #store the element of the array into Hex_0
  ldbio r8, 0(r4)           #load the value of keys into r8
  xor   r9, r7, r8          #xor r7 and r8 store outcome in r9
  and   r9, r9, r8          #and r9 and r8 store outcome in r9
  andi  r9, r9, Key_1       #and with Key_1 to maskout other keys
  mov   r7, r8              #move data in r8 to r7
  beq   r0, r9, loop        #if r9 is zero goto loop
  ldbio r8,0(r3)            #load value of switches in r8
  andi  r8, r8, Switch_0    #and with switch_0 to maskout switches
  bne   r0, r8, inc_ptr     #if r11 is not 0 goto increment
  br    dec_ptr
dec_ptr:
  movia r8, display_start   #move the start of the array into r8
  movia r9, display_end     #move the end of the array into r9
  movi  r10, -4
  br    move_ptr            #branch to move_ptr
inc_ptr:
  movia r8, display_end     #move the end of the array into r8
  movia r9, display_start   #move the start of the array into r9
  movi  r10, 4
  br    move_ptr            #branch to move_ptr
move_ptr:
  beq   r8, r5, wrap_around #if the pointer is at the end of array go to overflow
  add   r5, r5,  r10        #do pointer math to move pointer forward one element
  br    top                 #branch to top
wrap_around:
  mov   r5, r9              #move pointer in r8 into r5
  br    top                 #branch to top
display_start:
  .word ZERO,ONE,TWO,THREE,FOUR
  .word FIVE,SIX,SEVEN,EIGHT
display_end:
  .word NINE
