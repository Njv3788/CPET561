/* This is a C program written for the timer interrupt demo.  The 
 program assumes a nios_system with a periodic interrupt timer
 and an 8-bit output PIO named leds. */


/* alt_types.h and sys/alt_irq.h need to be included for the interrupt
  functions
  system.h is necessary for the system constants
  io.h has read and write functions */
#include "io.h"
#include <stdio.h>
#include "system.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"
#include "altera_avalon_pio_regs.h"

// create standard embedded type definitions
typedef   signed char   sint8;              // signed 8 bit values
typedef unsigned char   uint8;              // unsigned 8 bit values
typedef   signed short  sint16;             // signed 16 bit values
typedef unsigned short  uint16;             // unsigned 16 bit values
typedef   signed long   sint32;             // signed 32 bit values
typedef unsigned long   uint32;             // unsigned 32 bit values
typedef         float   real32;             // 32 bit real values

#define ZERO     0x40
#define ONE      0x79
#define TWO      0x24
#define THREE    0x30
#define FOUR     0x19
#define FIVE     0x12
#define SIX      0x02
#define SEVEN    0x78
#define EIGHT    0x00
#define NINE     0x18

#define KEY_1    0x02
#define SW_0     0x01

//set up pointers to peripherals

uint32* TimerPtr      = (uint32*)TIMER_0_BASE;
uint8 * LedPtr        = (uint8*)LEDS_BASE;
uint8 * Hex0Ptr       = (uint8*)HEX_0_BASE;
uint8 * SwPtr         = (uint8*)SWITCHES_BASE;
uint8 * KeyPtr        = (uint8*)KEYS_BASE;
uint32 * KeyMaskPtr   = (uint32*)IOADDR_ALTERA_AVALON_PIO_IRQ_MASK(KEYS_BASE);
uint32 * KeyEgdePtr	  = (uint32*)IOADDR_ALTERA_AVALON_PIO_EDGE_CAP(KEYS_BASE);

void key_isr(void *context);
void timer_isr(void *context);

int main(void)
/*****************************************************************************/
/* Main Program                                                              */
/* Enables interrupts then loops infinitely                                */
/*****************************************************************************/
{
    *KeyMaskPtr |=  KEY_1;

    *LedPtr = 0;                /* initial value to leds */
    *Hex0Ptr = ZERO;            /* initial value to hex_0 */
    alt_ic_isr_register(KEYS_IRQ_INTERRUPT_CONTROLLER_ID,KEYS_IRQ,key_isr,0,0);
    alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,TIMER_0_IRQ,timer_isr,0,0);

    while(1);
      
    return 0;
}


void key_isr(void *context)
{
    static uint8 display[10] = {ZERO,ONE,TWO,THREE,FOUR,
                                FIVE,SIX,SEVEN,EIGHT,NINE};
    static uint8 * it_display = display;
    uint8 current_value = *KeyEgdePtr;

    *KeyEgdePtr = 0;

    if(KEY_1!= (KEY_1 & current_value))
    {
         return;
    }
    
    current_value = *SwPtr & SW_0;
    switch(current_value)
    {
        case SW_0:
            if(it_display == &display[9])
            {
                it_display = display;
            }
            else
            {
                it_display++;
            }
            break;
        default:
            if(it_display == display)
            {
                it_display = &display[9];
            }
            else
            {
                it_display--;
            }
            break;
    }
    *Hex0Ptr = *it_display;
};

void timer_isr(void *context)
/*****************************************************************************/
/* Interrupt Service Routine                                                 */
/*   Determines what caused the interrupt and calls the appropriate          */
/*  subroutine.                                                              */
/*                                                                           */
/*****************************************************************************/
{
    //clear timer interrupt
    *TimerPtr = 0;
    *LedPtr ^= 0xFF;  /* change the display */

    return;
}
