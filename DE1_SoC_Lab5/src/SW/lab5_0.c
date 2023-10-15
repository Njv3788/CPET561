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
#define BLANK    0x7F

#define KEY_1    0x02
#define KEY_2    0x04

#define SERVO_MIN_D  45
#define SERVO_MAX_D 135

#define SERVO_MIN_M 0x0000C350
#define SERVO_MAX_M 0x000186A0

#define SERVO_STEP  500

typedef struct{
	uint32 min_angle;
	uint32 max_angle;
}angle_t;

typedef struct{
	uint32 ones;
	uint32 tens;
	uint32 hundreds;
}bcd_t;

//set up pointers to peripherals

uint32 * Hex_0_Ptr              = (uint32*)HEX_0_BASE;
uint32 * Hex_1_Ptr              = (uint32*)HEX_1_BASE;
uint32 * Hex_2_Ptr              = (uint32*)HEX_2_BASE;
uint32 * Hex_3_Ptr              = (uint32*)HEX_3_BASE;
uint32 * Hex_4_Ptr              = (uint32*)HEX_4_BASE;
uint32 * Hex_5_Ptr              = (uint32*)HEX_5_BASE;
uint32 * Key_0_Ptr              = (uint32*)KEY_0_BASE;
uint32 * Key_0_Mask_Ptr         = (uint32*)IOADDR_ALTERA_AVALON_PIO_IRQ_MASK(KEY_0_BASE);
uint32 * Key_0_Egde_Ptr	        = (uint32*)IOADDR_ALTERA_AVALON_PIO_EDGE_CAP(KEY_0_BASE);
uint32 * servo_controller_min   = (uint32*)SERVO_CONTROLLER_0_BASE;
uint32 * servo_controller_max   = (uint32*)SERVO_CONTROLLER_0_BASE + 1;

void key_0_isr(void *context);
void servo_controller_0_isr(void *context);
uint32 degree2machine (uint32 angle_degree);
uint32 in2degree (uint32 angle_in);
uint32 bcd2hex(uint32 bcd);
bcd_t in2bcd (uint32 angle_in);

int main(void)
/*****************************************************************************/
/* Main Program                                                              */
/* Enables interrupts then loops infinitely                                */
/*****************************************************************************/
{
	angle_t angle_degree    = {45,135};
	angle_t angle_in        = angle_degree;
	angle_t angle_machine;

	bcd_t bcd_min;
	bcd_t bcd_max;

	angle_machine.min_angle = degree2machine(angle_degree.min_angle);
	angle_machine.max_angle = degree2machine(angle_degree.max_angle);
	bcd_min = in2bcd(angle_in.min_angle);
	bcd_max = in2bcd(angle_in.max_angle);

    alt_ic_isr_register(KEY_0_IRQ_INTERRUPT_CONTROLLER_ID,
                        KEY_0_IRQ,
                        key_0_isr,
                        0,
                        0);
    alt_ic_isr_register(SERVO_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID,
                        SERVO_CONTROLLER_0_IRQ,
                        servo_controller_0_isr,
						(void*)&angle_machine,
                        0);

    while(1)
    {
        angle_degree.min_angle = degree2machine(angle_in.min_angle);
        angle_degree.max_angle = degree2machine(angle_in.max_angle);
        bcd_min = in2bcd(angle_in.min_angle);
        bcd_max = in2bcd(angle_in.max_angle);
        *Hex_0_Ptr = bcd2hex(bcd_max.ones);
        *Hex_1_Ptr = bcd2hex(bcd_max.tens);
        *Hex_2_Ptr = bcd2hex(bcd_max.hundreds);
        *Hex_3_Ptr = bcd2hex(bcd_min.ones);
        *Hex_4_Ptr = bcd2hex(bcd_min.tens);
        *Hex_5_Ptr = bcd2hex(bcd_min.hundreds);
    };
      
    return 0;
}
uint32 bcd2hex(uint32 bcd)
{
	uint32 hex;
	switch(bcd)
	{
	    case 0: hex  = ZERO;  break;
	    case 1:	hex  = ONE;   break;
	    case 2:	hex  = TWO;   break;
	    case 3:	hex  = THREE; break;
	    case 4: hex  = FOUR;  break;
	    case 5: hex  = FIVE;  break;
	    case 6: hex  = SIX;   break;
	    case 7:	hex  = SEVEN; break;
	    case 8: hex  = EIGHT; break;
        case 9:	hex  = NINE;  break;
        default: hex = BLANK; break;
    }

	return hex;

};
bcd_t in2bcd (uint32 angle_in)
{
	bcd_t angle_bcd;
	angle_bcd.ones = angle_in % 10;
	angle_bcd.tens = (angle_in % 100 - angle_bcd.ones)/10;
	angle_bcd.hundreds = (angle_in - angle_bcd.tens - angle_bcd.ones)/100;
	return angle_bcd;
};

uint32 in2degree (uint32 angle_in)
{
	if(angle_in < 45)
	{
		return 45;
	}

	if(angle_in > 135)
    {
        return 135;
    }

	return angle_in;
}

uint32 degree2machine (uint32 angle_degree)
{
	uint32 angle_machine;
	uint32 angle_error;

	angle_machine = angle_degree  - SERVO_MIN_D;
	angle_machine = angle_machine * (SERVO_MAX_M-SERVO_MIN_M)/(SERVO_MAX_D-SERVO_MIN_D);
    angle_error   = angle_machine % SERVO_STEP;
    angle_machine = angle_machine - angle_error;
    angle_machine = angle_machine + SERVO_MIN_M;

    return angle_machine;
}

void key_0_isr(void *context)
{

};

void servo_controller_0_isr(void *context)
{
	angle_t * angle_machine = (angle_t*)context;
    *servo_controller_min   = (uint32)angle_machine->min_angle;
    *servo_controller_max   = (uint32)angle_machine->max_angle;
};

