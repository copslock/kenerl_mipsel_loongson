Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N2eQa09454
	for linux-mips-outgoing; Tue, 22 Jan 2002 18:40:26 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N2eCP09450
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 18:40:12 -0800
Received: (qmail 14560 invoked from network); 23 Jan 2002 01:40:09 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <jsun@mvista.com>; 23 Jan 2002 01:40:09 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16TCOX-0005ha-00; Tue, 22 Jan 2002 18:40:09 -0700
Date: Tue, 22 Jan 2002 18:40:09 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
To: Jun Sun <jsun@mvista.com>
cc: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>, linux-mips@oss.sgi.com
Subject: Re: Mips IRQ support
In-Reply-To: <3C4E1195.9996C16@mvista.com>
Message-ID: <Pine.LNX.3.96.1020122183647.21885A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tue, 22 Jan 2002, Jun Sun wrote:

> The best way is to provide hw_irq_controller structure for the extended CPU
> IRQ feature.  See arch/mips/kernel/irq_cpu.c file and its related config
> option.

Attached is such a file.

Jason

/* Copyright 2002 Jason Gunthorpe <jgg@debian.org>   
   Modified from arch/mips/kernel/irq_cpu.S:   
   Copyright 2001 MontaVista Software Inc.
   Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  
   This program is free software; you can redistribute  it and/or modify it
   under  the terms of  the GNU General  Public License as published by the
   Free Software Foundation;  either version 2 of the  License, or (at your
   option) any later version.

   This is an addendum to irq_cpu to support the additional RM7000 
   interrupt sources. irq_cpu handles the lower 8 interrupts, this does 
   the remaining 6.
 */

#include <linux/irq.h>
#include <linux/types.h>
#include <linux/kernel.h>

#include <asm/mipsregs.h>

/* Move me to asm-mips/mipsregs.h */
#define __BUILD_SET_CP0_SET1(name,register)                     \
extern __inline__ unsigned int                                  \
set_cp0_##name(unsigned int set)				\
{                                                               \
	unsigned int res;                                       \
                                                                \
	res = read_32bit_cp0_set1_register(register);           \
	res |= set;						\
	write_32bit_cp0_set1_register(register, res);        	\
                                                                \
	return res;                                             \
}								\
								\
extern __inline__ unsigned int                                  \
clear_cp0_##name(unsigned int clear)				\
{                                                               \
	unsigned int res;                                       \
                                                                \
	res = read_32bit_cp0_set1_register(register);           \
	res &= ~clear;						\
	write_32bit_cp0_set1_register(register, res);		\
                                                                \
	return res;                                             \
}								\
								\
extern __inline__ unsigned int                                  \
change_cp0_##name(unsigned int change, unsigned int new)	\
{                                                               \
	unsigned int res;                                       \
                                                                \
	res = read_32bit_cp0_set1_register(register);           \
	res &= ~change;                                         \
	res |= (new & change);                                  \
	if(change)                                              \
		write_32bit_cp0_set1_register(register, res);   \
                                                                \
	return res;                                             \
}

__BUILD_SET_CP0_SET1(s1_intcontrol,CP0_S1_INTCONTROL)
   
static int mips_rm7kcpu_irq_base;
   
static void 
mips_rm7kcpu_irq_enable(unsigned int irq)
{
	set_cp0_s1_intcontrol(1 << (irq - mips_rm7kcpu_irq_base + 8));
}

static void 
mips_rm7kcpu_irq_disable(unsigned int irq)
{
	clear_cp0_s1_intcontrol(1 << (irq - mips_rm7kcpu_irq_base + 8));
}

static unsigned int mips_rm7kcpu_irq_startup(unsigned int irq)
{
	mips_rm7kcpu_irq_enable(irq);
	return 0;
}

#define	mips_rm7kcpu_irq_shutdown	mips_rm7kcpu_irq_disable

static void
mips_rm7kcpu_irq_ack(unsigned int irq)
{
	/* disable this interrupt - so that we safe proceed to the handler */
	mips_rm7kcpu_irq_disable(irq);
}

static void
mips_rm7kcpu_irq_end(unsigned int irq)
{
	mips_rm7kcpu_irq_enable(irq);
}

static hw_irq_controller mips_rm7kcpu_irq_controller = {
	"RM7KCPU_irq",
	mips_rm7kcpu_irq_startup,
	mips_rm7kcpu_irq_shutdown,
	mips_rm7kcpu_irq_enable,
	mips_rm7kcpu_irq_disable,
	mips_rm7kcpu_irq_ack,
	mips_rm7kcpu_irq_end,
	NULL			/* no affinity stuff for UP */
};


void 
mips_rm7kcpu_irq_init(u32 irq_base)
{
	extern irq_desc_t irq_desc[];
	u32 i;

	for (i= irq_base; i< irq_base+6; i++) {
		irq_desc[i].status = IRQ_DISABLED;
		irq_desc[i].action = NULL;
		irq_desc[i].depth = 1;
		irq_desc[i].handler = &mips_rm7kcpu_irq_controller;
	}
        mips_rm7kcpu_irq_base = irq_base;
   
        // Enable TE, the dedicated timer IRQ. It shows up as irq_base + 4
	set_cp0_s1_intcontrol(1 << 7);
}
