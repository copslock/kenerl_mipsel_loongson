Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARDppG17194
	for linux-mips-outgoing; Tue, 27 Nov 2001 05:51:51 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARDp9o17180
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 05:51:09 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA25626;
	Tue, 27 Nov 2001 04:51:00 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA04187;
	Tue, 27 Nov 2001 04:50:57 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fARCosA24238;
	Tue, 27 Nov 2001 13:50:54 +0100 (MET)
Message-ID: <3C038C30.951E9D8A@mips.com>
Date: Tue, 27 Nov 2001 13:50:56 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Serial Console on Malta broken?
References: <1006808755.7860.5.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------F975DC772608C03AAC78EB04"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------F975DC772608C03AAC78EB04
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Try replace arch/mips/mips-boards/malta/malta_int.c with the attached file
and apply
the following patch:

Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.145
diff -u -r1.145 config.in
--- arch/mips/config.in 2001/11/18 03:24:36     1.145
+++ arch/mips/config.in 2001/11/22 13:14:40
@@ -160,10 +160,10 @@
    define_bool CONFIG_SWAP_IO_SPACE y
 fi
 if [ "$CONFIG_MIPS_MALTA" = "y" ]; then
-   define_bool CONFIG_I8259 y
+#   define_bool CONFIG_I8259 y
    define_bool CONFIG_PCI y
    define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y
-   define_bool CONFIG_NEW_IRQ y
+#   define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_SWAP_IO_SPACE y
 fi
 if [ "$CONFIG_MOMENCO_OCELOT" = "y" ]; then


/Carsten


Marc Karasek wrote:

> I just got the latest source from the cvs server (2.4.14).  I am working
> on the MALTA eval board from MIPS.  I noticed that the serial console is
> very slow once it is initialized,  once it starts to print the "serial
> concole detected" it slows down to a crawl.  Prints around 10+ char and
> then pauses.  You can do a ls, etc...  but do not expect the output in
> your lifetime.
>
> In debugging I noticed that the mipsIRQ.S file is no longer used for
> interrupt handling.  Does anyone know why this was done?  I have
> compared it to source from 2.4.3-01.01 (from the MIPS site).  I checked
> the mailing list and there was some discussion about a similar bug that
> had to do with the serial port and the interrupt not working right.
>
> Any enlightenment would be greatly appreciated.  We are looking to put a
> stake in the ground as far as kernel version to start working with and
> we need something that is post 2.4.10.
>
> --
> /*************************
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc.
> marc_karasek@ivivity.com
> (770) 986-8925
> (770) 986-8926 Fax
> *************************/

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------F975DC772608C03AAC78EB04
Content-Type: text/plain; charset=iso-8859-15;
 name="malta_int.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta_int.c"

/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * Routines for generic manipulation of the interrupts found on the MIPS 
 * Malta board.
 * The interrupt controller is located in the South Bridge a PIIX4 device 
 * with two internal 82C95 interrupt controllers.
 */
#include <linux/config.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/interrupt.h>
#include <linux/kernel_stat.h>
#include <linux/random.h>

#include <asm/irq.h>
#include <asm/io.h>
#include <asm/mips-boards/malta.h>
#include <asm/mips-boards/maltaint.h>
#include <asm/mips-boards/piix4.h>
#include <asm/gt64120.h>
#include <asm/mips-boards/generic.h>

extern asmlinkage void mipsIRQ(void);

unsigned int local_bh_count[NR_CPUS];
unsigned int local_irq_count[NR_CPUS];
unsigned long spurious_count = 0;

static struct irqaction *hw0_irq_action[MALTAINT_END] = {
	NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, NULL
};

static struct irqaction r4ktimer_action = {
	NULL, 0, 0, "R4000 timer/counter", NULL, NULL,
};

static struct irqaction *irq_action[8] = {
	NULL, NULL, NULL, NULL,
	NULL, NULL, NULL, &r4ktimer_action
};

#if 0
#define DEBUG_INT(x...) printk(x)
#else
#define DEBUG_INT(x...)
#endif

/*
 * This contains the interrupt mask for both 82C59 interrupt controllers.
 */
static unsigned int cached_int_mask = 0xffff;

void disable_irq(unsigned int irq_nr)
{
        unsigned long flags;

	if(irq_nr >= MALTAINT_END) {
		printk("whee, invalid irq_nr %d\n", irq_nr);
		panic("IRQ, you lose...");
	}

	save_and_cli(flags);
	cached_int_mask |= (1 << irq_nr);
	if (irq_nr & 8) {
	        outb((cached_int_mask >> 8) & 0xff, PIIX4_ICTLR2_OCW1);
	} else {
		outb(cached_int_mask & 0xff, PIIX4_ICTLR1_OCW1);
	}
	restore_flags(flags);
}


void enable_irq(unsigned int irq_nr)
{
        unsigned long flags;

	if(irq_nr >= MALTAINT_END) {
		printk("whee, invalid irq_nr %d\n", irq_nr);
		panic("IRQ, you lose...");
	}

	save_and_cli(flags);
	cached_int_mask &= ~(1 << irq_nr);
	if (irq_nr & 8) {
		outb((cached_int_mask >> 8) & 0xff, PIIX4_ICTLR2_OCW1);

		/* Enable irq 2 (cascade interrupt). */
	        cached_int_mask &= ~(1 << 2); 
		outb(cached_int_mask & 0xff, PIIX4_ICTLR1_OCW1);
	} else {
		outb(cached_int_mask & 0xff, PIIX4_ICTLR1_OCW1);
	}	
	restore_flags(flags);
}


int get_irq_list(char *buf)
{
	int i, len = 0;
	int num = 0;
	struct irqaction *action;

	for (i = 0; i < 8; i++, num++) {
		action = irq_action[i];
		if (!action) 
			continue;
		len += sprintf(buf+len, "%2d: %8d %c %s",
			num, kstat.irqs[0][num],
			(action->flags & SA_INTERRUPT) ? '+' : ' ',
			action->name);
		for (action=action->next; action; action = action->next) {
			len += sprintf(buf+len, ",%s %s",
				(action->flags & SA_INTERRUPT) ? " +" : "",
				action->name);
		}
		len += sprintf(buf+len, " [on-chip]\n");
	}
	for (i = 0; i < MALTAINT_END; i++, num++) {
		action = hw0_irq_action[i];
		if (!action) 
			continue;
		len += sprintf(buf+len, "%2d: %8d %c %s",
			num, kstat.irqs[0][num],
			(action->flags & SA_INTERRUPT) ? '+' : ' ',
			action->name);
		for (action=action->next; action; action = action->next) {
			len += sprintf(buf+len, ",%s %s",
				(action->flags & SA_INTERRUPT) ? " +" : "",
				action->name);
		}
		len += sprintf(buf+len, " [hw0]\n");
	}
	return len;
}


static int setup_irq(unsigned int irq, struct irqaction * new)
{
	int shared = 0;
	struct irqaction *old, **p;

	p = &hw0_irq_action[irq];
	if ((old = *p) != NULL) {
		/* Can't share interrupts unless both agree to */
		if (!(old->flags & new->flags & SA_SHIRQ))
			return -EBUSY;

		/* Can't share interrupts unless both are same type */
		if ((old->flags ^ new->flags) & SA_INTERRUPT)
			return -EBUSY;

		/* add new interrupt at end of irq queue */
		do {
			p = &old->next;
			old = *p;
		} while (old);
		shared = 1;
	}

	if (new->flags & SA_SAMPLE_RANDOM)
		rand_initialize_irq(irq);

	*p = new;
	if (!shared)
		enable_irq(irq);

	return 0;
}

int request_irq(unsigned int irq, 
		void (*handler)(int, void *, struct pt_regs *),
		unsigned long irqflags, 
		const char * devname,
		void *dev_id)
{  
        struct irqaction *action;
	int retval;

	DEBUG_INT("request_irq: irq=%d, devname = %s\n", irq, devname);

        if (irq >= MALTAINT_END)
	        return -EINVAL;
	if (!handler)
	        return -EINVAL;

	action = (struct irqaction *)kmalloc(sizeof(struct irqaction), GFP_KERNEL);
	if(!action)
	        return -ENOMEM;

	action->handler = handler;
	action->flags = irqflags;
	action->mask = 0;
	action->name = devname;
	action->dev_id = dev_id;
	action->next = 0;

	retval = setup_irq(irq, action);
	if (retval)
		kfree(action);

	return retval;	
}


void free_irq(unsigned int irq, void *dev_id)
{
	struct irqaction *action, **p;

	if (irq >= MALTAINT_END) {
		printk("Trying to free IRQ%d\n",irq);
		return;
	}
	
	for (p = &hw0_irq_action[irq]; (action = *p) != NULL; 
	     p = &action->next) 
	{
		if (action->dev_id != dev_id)
			continue;

		/* Found it - now free it */
		*p = action->next;
		kfree(action);
		if (!hw0_irq_action[irq])
			disable_irq(irq);
		return;
	}
	printk("Trying to free IRQ%d\n",irq);
}

void __init init_IRQ(void)
{
	maltaint_init();
}

static inline int get_int(int *irq)
{
	/*  
	 * Determine highest priority pending interrupt by performing
	 * a PCI Interrupt Acknowledge cycle.
	 */
	GT_READ(GT_PCI0_IACK_OFS, *irq);
	*irq &= 0xFF;
	
	/*  
	 * IRQ7 is used to detect spurious interrupts.
	 * The interrupt acknowledge cycle returns IRQ7, if no 
	 * interrupts is requested.
	 * We can differentiate between this situation and a
	 * "Normal" IRQ7 by reading the ISR.
	 */
	if (*irq == 7) 
	{
		outb(PIIX4_OCW3_SEL | PIIX4_OCW3_ISR, 
		     PIIX4_ICTLR1_OCW3);
		if (!(inb(PIIX4_ICTLR1_OCW3) & (1 << 7))) {
			printk("We got a spurious interrupt from PIIX4.\n");
			return -1;    /* Spurious interrupt. */
		}
	}

	return 0;
}

static inline void ack_int(int irq)
{
	if (irq & 8) {
	        /* Specific EOI to cascade */
		outb(PIIX4_OCW2_SEL | PIIX4_OCW2_NSEOI | PIIX4_OCW2_ILS_2, 
		     PIIX4_ICTLR1_OCW2);

	        /* Non specific EOI to cascade */
		outb(PIIX4_OCW2_SEL | PIIX4_OCW2_NSEOI, PIIX4_ICTLR2_OCW2);
	} else {
	        /* Non specific EOI to cascade */
		outb(PIIX4_OCW2_SEL | PIIX4_OCW2_NSEOI, PIIX4_ICTLR1_OCW2);
	}
}

void malta_hw0_irqdispatch(struct pt_regs *regs)
{
        struct irqaction *action;
	int irq=0, cpu = smp_processor_id();

	DEBUG_INT("malta_hw0_irqdispatch\n");
	
	if (get_int(&irq))
	        return;  /* interrupt has already been cleared */

	disable_irq(irq);
	ack_int(irq);

	DEBUG_INT("malta_hw0_irqdispatch: irq=%d\n", irq);
	action = hw0_irq_action[irq];

	/* 
	 * if action == NULL, then we don't have a handler 
	 * for the irq 
	 */
	if ( action == NULL )
		return;

	irq_enter(cpu, irq);
	kstat.irqs[0][irq + 8]++;
	do {
	        action->handler(irq, action->dev_id, regs);
		action = action->next;
	} while (action);

	enable_irq(irq);
	irq_exit(cpu, irq);
}


unsigned long probe_irq_on (void)
{
	unsigned int i, irqs = 0;
	unsigned long delay;

	/* first, enable any unassigned irqs */
	for (i = MALTAINT_END-1; i > 0; i--) {
		if (!hw0_irq_action[i]) {
			enable_irq(i);
			irqs |= (1 << i);
		}
	}

	/* wait for spurious interrupts to mask themselves out again */
	for (delay = jiffies + HZ/10; time_before(jiffies, delay); )
		/* about 100ms delay */;

	/* now filter out any obviously spurious interrupts */
	return irqs & ~cached_int_mask;
}


int probe_irq_off (unsigned long irqs)
{
	unsigned int i;

	irqs &= cached_int_mask;
	if (!irqs)
		return 0;
	i = ffz(~irqs);
	if (irqs != (irqs & (1 << i)))
		i = -i;

	return i;
}


void __init maltaint_init(void)
{
        /* 
	 * Mask out all interrupt by writing "1" to all bit position in 
	 * the IMR register. 
	 */
	outb(cached_int_mask & 0xff, PIIX4_ICTLR1_OCW1);
	outb((cached_int_mask >> 8) & 0xff, PIIX4_ICTLR2_OCW1);

	/* Now safe to set the exception vector. */
	set_except_vector(0, mipsIRQ);

#ifdef CONFIG_REMOTE_DEBUG
	if (remote_debug) {
		set_debug_traps();
		breakpoint(); 
	}
#endif
}

--------------F975DC772608C03AAC78EB04--
