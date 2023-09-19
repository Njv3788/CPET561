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

uint32* TimerPtr    = (uint32*)TIMER_0_BASE;

unsigned char * LedPtr        = (unsigned char*)LEDS_BASE;
unsigned char * Hex0Ptr       = (unsigned char*)HEX_0_BASE;
unsigned char * SwPtr         = (unsigned char*)SWITCHES_BASE;
unsigned char * KeyPtr        = (unsigned char*)KEYS_BASE;

int main(void)
/*****************************************************************************/
/* Main Program                                                              */
/* Enables interrupts then loops infinitely                                */
/*****************************************************************************/
{
    char keys;
	char keys_d = 0;
    char FED = 0;
    char display[10] = {ZERO,ONE,TWO,THREE,FOUR,
    		            FIVE,SIX,SEVEN,EIGHT,NINE};
    char * it_display = display;

    *LedPtr = 0;                /* initial value to leds */
    *Hex0Ptr = *it_display;      /* initial value to hex_0 */

    while(1)
    {
    	keys = *KeyPtr;
        FED  = (keys_d ^ keys) & keys;
        FED &= KEY_1;
        keys_d = keys;

        if(KEY_1 == FED)
        {
            FED = *SwPtr & SW_0;
            switch(FED)
            {
                case SW_0:
                	if(it_display == display+9)
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
                		it_display = display+9;
                	}
                	else
                	{
                		it_display--;
                	}
                	break;
            }
            *Hex0Ptr = *it_display;
        }
    };
    return 0;
}
