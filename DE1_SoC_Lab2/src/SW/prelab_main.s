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
main: 	#load r2 and r3 with the addresses
  movia r2, display
  movia r3, Hex_0
  ldb r4, 0(r2)

loop: 	#read from r2 and store to r3
  stbio r4, 0(r3)
  br    loop

display:
  .word ZERO,ONE,TWO,THREE,FOUR
  .word FIVE,SIX,SEVEN,EIGHT,NINE
