Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 13:28:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27806 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039318AbXB1N2J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 13:28:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1SDRwbF012723;
	Wed, 28 Feb 2007 13:27:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1SDRvKm012722;
	Wed, 28 Feb 2007 13:27:57 GMT
Date:	Wed, 28 Feb 2007 13:27:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] mips: PMC MSP71xx core platform
Message-ID: <20070228132757.GA23373@linux-mips.org>
References: <200702231955.l1NJtRGa032342@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702231955.l1NJtRGa032342@pasqua.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 23, 2007 at 01:55:27PM -0600, Marc St-Jean wrote:

> diff --git a/arch/mips/pmc-sierra/msp71xx/Makefile b/arch/mips/pmc-sierra/msp71xx/Makefile
> new file mode 100644
> index 0000000..f2648ec
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for the PMC-Sierra MSP SOCs
> +#
> +obj-y    += msp_prom.o msp_setup.o msp_irq.o a5000.o \
> +		msp_time.o msp_serial.o msp_elb.o
> +obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o
> +obj-$(CONFIG_IRQ_MSP_SLP) += msp_irq_slp.o
> +obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
> +obj-$(CONFIG_PCI) += msp_pci.o
> +obj-$(CONFIG_PMC_MSP_ETH) += msp_eth.o
> +obj-$(CONFIG_MSP_USB) += msp_usb.o
> diff --git a/arch/mips/pmc-sierra/msp71xx/a5000.S b/arch/mips/pmc-sierra/msp71xx/a5000.S
> new file mode 100644
> index 0000000..b7c4e78
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/a5000.S
> @@ -0,0 +1,89 @@
> +/*************************************************************

Comment style:

The preferred style for long (multi-line) comments is:

        /*
         * This is the preferred style for multi-line
         * comments in the Linux kernel source code.
         * Please use it consistently.
         *
         * Description:  A column of asterisks on the left side,
         * with beginning and ending almost-blank lines.
         */

See also Documentation/CodingStyle.

> + * File: lib/a5000.s

The path in the diff claims something else.  Just delete this sort of
comments.

> + * Purpose: Part of C runtime library

I doubt it.

> + * Author: Phil Bunce (pjb@carmel.com)
> + * Revision History:
> + *	970304	Start of revision history
> + */
> +
> +/* 
> + * Remove most of the code from this file.
> + *
> + * The code from this file had initialization code for the chip and evm board.
> + * One of the things initialized was SDRAM.
> + * Code in this file runs from SDRAM....
> + * 
> + * pmon has already initialized the chip and evm board.
> + */
> +
> +#include <linux/sys.h>

Useless include.

> +#include <asm/asm.h>
> +#include <asm/mipsregs.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +
> +#define UART_BASE	0xBC000100	/* Base address to UART            */
> +#define NSREG(x) ((x)*4)
> +#define DATA (NSREG(0))	/* data register (R/W)             */
> +#define IER  (NSREG(1))	/* interrupt enable (W)            */
> +#define IIR  (NSREG(2))	/* interrupt identification (R)    */
> +#define	FIFO (NSREG(2))	/* 16550 fifo control (W)          */
> +#define CFCR (NSREG(3))	/* line control register (R/W)     */
> +#define MCR  (NSREG(4))	/* modem control register (R/W)    */
> +#define LSR  (NSREG(5))	/* line status register (R/W)      */
> +#define MSR  (NSREG(6))	/* modem status register (R/W)     */
> +#define SCR  (NSREG(7))	/* scratch register (R/W)          */
> +
> +#define LSR_RXRDY       0x01    /* receiver ready */
> +#define LSR_TXRDY       0x20    /* transmitter ready */
> +#define LSR_ERRBRK      0x9e    /* Read UART error, or break */
> +
> +/*
> + * Routine to output a character
> + */
> +
> +NESTED(a5000PrintChar, 0, sp)
> +	.set	at
> +	.set	mips32
> +	.set	noreorder
> +	mfc0	t0, CP0_STATUS
> +	mtc0	zero, CP0_STATUS	# disable all interrupts
> +	nop
> +	nop
> +	nop
> +	.set	reorder
> +	li	t3,UART_BASE
> +1:
> +	lw	t4,LSR(t3)
> +#	and	t3,t4,LSR_ERRBRK
> +#	bnez	t3,1b
> +	and	t4,LSR_TXRDY
> +	beqz	t4,1b
> +	sw	a0,DATA(t3)
> +2:
> +	lw	t4,LSR(t3)
> +#	and	t3,t4,LSR_ERRBRK
> +#	bnez	t3,2b
> +	and	t4,LSR_TXRDY
> +	beqz	t4,2b
> +	nop
> +	.set	noreorder
> +	j	ra
> +	mtc0	t0, CP0_STATUS	# put all interrupts back.
> +	.set	reorder
> +END(a5000PrintChar)
> +
> +
> +NESTED(a5000GetChar, 0, sp)
> +	.set	at
> +	.set	mips32
> +	.set	reorder
> +	li	t3,UART_BASE
> +1:
> +	lw	t4,LSR(t3)
> +	and	t4,LSR_RXRDY
> +	beqz	t4,1b
> +	lw	v0,DATA(t3)
> +	j	ra
> +END(a5000GetChar)
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_elb.c b/arch/mips/pmc-sierra/msp71xx/msp_elb.c
> new file mode 100644
> index 0000000..b88a6a9
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_elb.c
> @@ -0,0 +1,47 @@
> +/*
> + * $Id: msp_elb.c,v 1.3 2006/04/28 22:57:37 stjeanma Exp $

Please remove all RCS $Id, $Log etc. strings.  Linux lives in a non-CVS
world where this is just wrong information.

> + *
> + * Sets up the proper Chip Select configuration registers.  It is assumed that
> + * PMON sets up the ADDR and MASK registers properly.
> + *
> + * Copyright 2005 PMC-Sierra, Inc.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <msp_regs.h>
> +
> +static int __init msp_elb_setup(void)
> +{
> +#if defined(CONFIG_PMC_MSP7120_GW) \
> + || defined(CONFIG_PMC_MSP7120_EVAL)
> +	/*
> +	 * Force all CNFG to be identical and equal to CS0,
> +	 * according to OPS doc
> +	 */
> +	*CS1_CNFG_REG = *CS2_CNFG_REG = *CS3_CNFG_REG = *CS0_CNFG_REG;
> +#endif
> +	return 0;
> +}
> +
> +subsys_initcall(msp_elb_setup);
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> new file mode 100644
> index 0000000..9c6f2fa
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> @@ -0,0 +1,186 @@
> +/*
> + * $Id: msp_hwbutton.c,v 1.3 2006/06/07 16:03:42 ramsayji Exp $

Ditto.

> + *
> + * Sets up interrupt handlers for various hardware switches which are connected
> + * to interrupt lines.
> + *
> + * Copyright 2005 PMC-Sierra, Inc.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <msp_int.h>
> +#include <msp_regs.h>
> +#ifdef CONFIG_SENSORS_PMCTWILED
> +#include <msp_led_macros.h>
> +#endif
> +
> +/* For hwbutton_interrupt->initial_state */
> +#define HWBUTTON_HI 0x1
> +#define HWBUTTON_LO 0x2
> +
> +/*
> + * This struct describes a hardware button
> + */
> +struct hwbutton_interrupt {
> +	char *name;			/* Name of button */
> +	int irq;			/* Actual LINUX IRQ */
> +	int eirq;			/* Extended IRQ number (0-7) */
> +	int initial_state;		/* The "normal" state of the switch */
> +	void (*handle_hi)(void*);	/* Handler: switch input has gone HI */
> +	void (*handle_lo)(void*);	/* Handler: switch input has gone LO */
> +	void *data;			/* Optional data to pass to handler */
> +};
> +
> +#ifdef CONFIG_PMC_MSP7120_GW
> +extern void msp_restart(char *);
> +
> +static void softreset_push(void *data )
> +{
> +	printk( "SOFTRESET switch was pushed\n" );

               ^                               ^
Whitespace formatting.

Also please add a suitable KERN_* severity level.

> +
> +	/*
> +	 * In the future you could move this to the release handler,
> +	 * timing the difference between the 'push' and 'release', and only
> +	 * doing this ungraceful restart if the button has been down for
> +	 * a certain amount of time; otherwise doing a graceful restart.
> +	 */
> +
> +	msp_restart(NULL);
> +}
> +
> +static void softreset_release(void *data)
> +{
> +	printk( "SOFTRESET switch was released\n" );

Ditto.

> +
> +	/* Do nothing */
> +}
> +
> +static void standby_on(void *data)
> +{
> +	printk( "STANDBY switch was set to ON (not implemented)\n" );

Ditto.

> +	/* TODO: Put board in standby mode */
> +#ifdef CONFIG_SENSORS_PMCTWILED
> +	msp_led_turn_off( MSP_LED_PWRSTANDBY_GREEN ); 

Again whitespace:        ^                        ^

> +	msp_led_turn_on( MSP_LED_PWRSTANDBY_RED ); 

Ditto.

> +#endif
> +}
> +
> +static void standby_off(void *data)
> +{
> +	printk( "STANDBY switch was set to OFF (not implemented)\n" );

(I guess you know by now ;-)

> +	/* TODO: Take out of standby mode */
> +#ifdef CONFIG_SENSORS_PMCTWILED
> +	msp_led_turn_on( MSP_LED_PWRSTANDBY_GREEN ); 
> +	msp_led_turn_off( MSP_LED_PWRSTANDBY_RED ); 

thesameagainthesameagain ;-)

> +#endif
> +}
> +
> +static struct hwbutton_interrupt softreset_sw = {
> +	.name = "Softreset button",
> +	.irq = MSP_INT_EXT0,
> +	.eirq = 0,
> +	.initial_state = HWBUTTON_HI,
> +	.handle_hi = softreset_release,
> +	.handle_lo = softreset_push,
> +	.data = NULL,
> +};
> +
> +static struct hwbutton_interrupt standby_sw = {
> +	.name = "Standby switch",
> +	.irq = MSP_INT_EXT1,
> +	.eirq = 1,
> +	.initial_state = HWBUTTON_HI,
> +	.handle_hi = standby_off,
> +	.handle_lo = standby_on,
> +	.data = NULL,
> +};
> +#endif // CONFIG_PMC_MSP7120_GW

/*  blah ...  */ comment style is prefered in Linux.

> +
> +static irqreturn_t hwbutton_handler(int irq, void* data )
                                                          ^
whitespace.

> +{
> +	struct hwbutton_interrupt *hirq = (struct hwbutton_interrupt*)data;
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
data is void * so this cast is not needed.

> +	unsigned long cic_ext = *CIC_EXT_CFG_REG;
> +
> +	if( irq != hirq->irq )

Space between C keywords if, for, while.  Non between ( and following
expression, as usual.

> +		return IRQ_NONE;
> +
> +	if( CIC_EXT_IS_ACTIVE_HI(cic_ext, hirq->eirq) )

ditto.

> +	{
> +		/* Interrupt: pin is now HI */
> +		CIC_EXT_SET_ACTIVE_LO(cic_ext, hirq->eirq);
> +		hirq->handle_hi(hirq->data);
> +	}
> +	else
> +	{

} else {

> +		/* Interrupt: pin is now LO */
> +		CIC_EXT_SET_ACTIVE_HI(cic_ext, hirq->eirq);
> +		hirq->handle_lo(hirq->data);
> +	}
> +
> +	/* 
> +	 * Invert the POLARITY of this level interrupt to ack the interrupt
> +	 * Thus next state change will invoke the opposite message
> +	 */
> +	*CIC_EXT_CFG_REG = cic_ext;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int msp_hwbutton_register( struct hwbutton_interrupt *hirq )
> +{
> +	unsigned long cic_ext;
> +
> +	if( hirq->handle_hi == NULL || hirq->handle_lo == NULL )
> +		return -EINVAL;
> +       
> +	cic_ext = *CIC_EXT_CFG_REG;
> +	CIC_EXT_SET_TRIGGER_LEVEL(cic_ext, hirq->eirq);
> +	if( hirq->initial_state == HWBUTTON_HI )
> +		CIC_EXT_SET_ACTIVE_LO(cic_ext, hirq->eirq);
> +	else
> +		CIC_EXT_SET_ACTIVE_HI(cic_ext, hirq->eirq);
> +	*CIC_EXT_CFG_REG = cic_ext;
> +
> +	return request_irq( hirq->irq, hwbutton_handler, SA_INTERRUPT,
> +				hirq->name, (void*)hirq );
> +}
> +
> +/* This may never be needed
> +static void msp_hwbutton_deregister( struct hwbutton_interrupt *hirq )
> +{
> +	free_irq( hirq->irq, (void*)hirq );
> +}
> +*/

This function has no caller, so it should probably be deleted?

> +
> +static int __init msp_hwbutton_setup(void)
> +{
> +#ifdef CONFIG_PMC_MSP7120_GW
> +	msp_hwbutton_register( &softreset_sw );
> +	msp_hwbutton_register( &standby_sw );
> +#endif
> +	return 0;
> +}
> +
> +subsys_initcall(msp_hwbutton_setup);
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq.c b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
> new file mode 100644
> index 0000000..aaf6d06
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
> @@ -0,0 +1,121 @@
> +/*
> + * IRQ vector handles
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 1995, 1996, 1997, 2003 by Ralf Baechle
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#include <asm/irq_cpu.h>
> +#include <asm/ptrace.h>
> +#include <asm/time.h>
> +
> +#include <msp_int.h>
> +
> +extern void msp_int_handle(void);
> +
> +/* SLP bases systems */
> +extern void msp_slp_irq_init(void);
> +extern void msp_slp_irq_dispatch(void);
> +
> +/* CIC based systems */
> +extern void msp_cic_irq_init(void);
> +extern void msp_cic_irq_dispatch(void);
> +
> +/* The PMC-Sierra MSP interrupts are arranged in a 3 level cascaded hierarchical
> +** system.  The first level are the direct MIPS interrupts and are assigned the
> +** interrupt range 0-7.  The second level is the SLM interrupt controller and is
> +** assigned the range 8-39.  The third level comprises the Peripherial block, the
> +** PCI block, the PCI MSI block and the SLP.  The PCI interrupts and the SLP errors
> +** are handled by the relevant subsystems so the core interrupt code needs only concern
> +** itself with the Peripheral block.  These are assigned interrupts in the range 40-71.
> +*/

Brownie points for actually explaining how the hardware works.  Hell of
useful for people like me who might need to change this years later.

> +
> +asmlinkage void plat_irq_dispatch(struct pt_regs *regs)
> +{
> +	u32 pending;
> +
> +	pending = read_c0_status() & read_c0_cause();
> +	
> +	/* jump to the correct interrupt routine
> +	 * These are arranged in priority order and the timer
> +	 * comes first!
> +	 */
> +
> +#ifdef CONFIG_IRQ_MSP_CIC	   /* break out the CIC stuff for now */
> +	if (pending & C_IRQ4)   /* gotta do the peripherals first, cause thats the timer */
> +		msp_cic_irq_dispatch();
> +		
> +	else if (pending & C_IRQ0)
> +		do_IRQ(MSP_INT_MAC0);
> +		
> +	else if (pending & C_IRQ1)
> +		do_IRQ(MSP_INT_MAC1);
> +
> +	else if (pending & C_IRQ2)
> +		do_IRQ(MSP_INT_USB);
> +	
> +	else if (pending & C_IRQ3)
> +		do_IRQ(MSP_INT_SAR);
> +
> +	else if (pending & C_IRQ5)
> +		do_IRQ(MSP_INT_SEC);
> +
> +#else
> +	if (pending & C_IRQ5)
> +		do_IRQ(MSP_INT_TIMER);
> +	
> +	else if (pending & C_IRQ0)
> +		do_IRQ(MSP_INT_MAC0);
> +
> +	else if (pending & C_IRQ1)
> +		do_IRQ(MSP_INT_MAC1);
> +	
> +	else if (pending & C_IRQ3)
> +		do_IRQ(MSP_INT_VE);
> +
> +	else if (pending & C_IRQ4)
> +		msp_slp_irq_dispatch();
> +#endif
> +
> +	else if (pending & C_SW0)	/* Do software after hardware interrupts */
> +		do_IRQ(MSP_INT_SW0);
> +
> +	else if (pending & C_SW1)
> +		do_IRQ(MSP_INT_SW1);
> +}
> +
> +static struct irqaction cascade_msp = {
> +	.handler = no_action,
> +	.name	 = "MSP cascade"
> +};
> +
> +
> +void __init arch_init_irq(void)
> +{
> +	int retval;
> +
> +	/* initialize the 1st-level CPU based interrupt controller */
> +	mips_cpu_irq_init();
> +
> +#ifdef CONFIG_IRQ_MSP_CIC
> +	msp_cic_irq_init();
> +
> +	/* setup the cascaded interrupts */
> +	retval = setup_irq(MSP_INT_CIC, &cascade_msp);

Assigning return value without checking or ever using it.

> +	retval = setup_irq(MSP_INT_PER, &cascade_msp);

Assigning return value without checking or ever using it.

> +#else
> +	/* setup the 2nd-level SLP register based interrupt controller */
> +	msp_slp_irq_init();
> +
> +	/* setup the cascaded SLP/PER interrupts */
> +	retval = setup_irq(MSP_INT_SLP, &cascade_msp);

Assigning return value without checking or ever using it.

> +	retval = setup_irq(MSP_INT_PER, &cascade_msp);

Assigning return value without checking or ever using it.

> +#endif
> +}
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
> new file mode 100644
> index 0000000..ae6d16b
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright 2005-6 PMC-Sierra, Inc, derived from irq_cpu.c
> + * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
> + *
> + *
> + * This file define the irq handler for MSP SLM subsystem interrupts.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/system.h>
> +#include <asm/bitops.h>
> +
> +#include <msp_cic_int.h>
> +#include <msp_regs.h>
> +
> +/*
> + * NOTE: We are only enabling support for VPE0 right now.
> + */
> +
> +static inline void unmask_cic_irq(unsigned int irq)
> +{
> +
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE)
> +		*CIC_VPE0_MSK_REG |= (1 << (irq - MSP_CIC_INTBASE));
> +	else
> +		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
> +}
> +
> +static inline void mask_cic_irq(unsigned int irq)
> +{
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE)
> +		*CIC_VPE0_MSK_REG &= ~(1 << (irq - MSP_CIC_INTBASE));
> +	else
> +		*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
> +}
> +
> +static inline void msp_cic_irq_enable(unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	unmask_cic_irq(irq);
> +	local_irq_restore(flags);
> +}
> +
> +static inline void msp_cic_irq_disable(unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	mask_cic_irq(irq);
> +	local_irq_restore(flags);
> +}
> +
> +static unsigned int msp_cic_irq_startup(unsigned int irq)
> +{
> +	msp_cic_irq_enable(irq);
> +	
> +	return 0;
> +}
> +
> +#define	msp_cic_irq_shutdown	msp_cic_irq_disable
> +
> +/*
> + * While we ack the interrupt interrupts are disabled and thus we don't need
> + * to deal with concurrency issues.  Same for msp_cic_irq_end.
> + */
> +static inline void msp_cic_irq_ack(unsigned int irq)
> +{
> +	mask_cic_irq(irq);
> +
> +	/* only really necessary for 18, 16-14 and sometimes 3:0 (since these can be
> +	 * edge sensitive) but it doesn't hurt for the others
> +	 */ 
> +
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE) {
> +		*CIC_STS_REG = (1 << (irq - MSP_CIC_INTBASE));
> +	} else {
> +		*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
> +	}
> +}
> +
> +static void msp_cic_irq_end(unsigned int irq)
> +{
> +	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> +		unmask_cic_irq(irq);
> +}
> +
> +static struct irq_chip msp_cic_irq_controller = {
> +	.typename = "MSP_CIC",
> +	.startup = msp_cic_irq_startup,
> +	.shutdown = msp_cic_irq_shutdown,
> +	.enable = msp_cic_irq_enable,
> +	.disable = msp_cic_irq_disable,
> +	.ack = msp_cic_irq_ack,
> +	.end = msp_cic_irq_end,
> +};
> +
> +
> +void __init msp_cic_irq_init(void)
> +{
> + 	int i;
> +
> +	/* Mask/clear interrupts. */
> +	*CIC_VPE0_MSK_REG = 0x00000000;
> +	*PER_INT_MSK_REG  = 0x00000000;	
> +	*CIC_STS_REG      = 0xFFFFFFFF;
> +	*PER_INT_STS_REG  = 0xFFFFFFFF;
> + 
> +#if defined(CONFIG_PMC_MSP7120_GW) \
> + || defined(CONFIG_PMC_MSP7120_EVAL)
> +	/* 
> +	 * The MSP7120 RG and EVBD boards use IRQ[6:4] for PCI.
> +	 * These inputs map to EXT_INT_POL[6:4] inside the CIC.
> +	 * They are to be active low, level sensitive.
> +	 */
> +	*CIC_EXT_CFG_REG &= 0xFFFF8F8F;
> +#endif
> +
> +	/* initialize all the IRQ descriptors */
> +	for (i = MSP_CIC_INTBASE; i < MSP_PER_INTBASE + 32; i++) {
> +		irq_desc[i].status = IRQ_DISABLED;
> +		irq_desc[i].action = NULL;
> +		irq_desc[i].depth = 1;
> +		irq_desc[i].chip = &msp_cic_irq_controller;
> +	}

Interrupt handling has been rewritten since this code was written.  I
suggest you take a look at changesets 1603b5aca4f15b34848fb5594d0c7b6333b99144
and 1417836e81c0ab8f5a0bfeafa90d3eaa41b2a067 which should illustrate
the required changes well enough to make this straight forward.

> +}
> +
> +void msp_cic_irq_dispatch(void)
> +{
> +	u32 pending;
> +	int intbase;
> +
> +	intbase = MSP_CIC_INTBASE;
> +	pending = *CIC_STS_REG & *CIC_VPE0_MSK_REG;
> +
> +	/* check for PER interrupt */
> +	if (pending == (1 << (MSP_INT_PER - MSP_CIC_INTBASE))) {
> +		intbase = MSP_PER_INTBASE;
> +		pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
> +	}
> +
> +	/* check for spurious interrupt */
> +	if (pending == 0x00000000) {
> +		printk("Spurious %s interrupt? status %08x, mask %08x\n",

Again a KERN_* severity string please.

(Spurious interrupts may happen in many systems so I wonder if the printk
is a good idea at all?)

> +			(intbase == MSP_CIC_INTBASE)?"CIC":"PER",
> +			(intbase == MSP_CIC_INTBASE)?*CIC_STS_REG:*PER_INT_STS_REG,
> +			(intbase == MSP_CIC_INTBASE)?*CIC_VPE0_MSK_REG:*PER_INT_MSK_REG);
> +		return;
> +	}
> +
> +	/* check for for the timer and dispatch it first */
> +	if ((intbase == MSP_CIC_INTBASE) && (pending & (1 << (MSP_INT_VPE0_TIMER - MSP_CIC_INTBASE))))
> +		do_IRQ(MSP_INT_VPE0_TIMER);
> +	else
> +		do_IRQ(ffs(pending) + intbase - 1);
> +}
> +
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> new file mode 100644
> index 0000000..72fc73b
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq_slp.c
> @@ -0,0 +1,148 @@
> +/*
> + * Copyright 2005-6 PMC-Sierra, Inc, derived from irq_cpu.c
> + * Author: Andrew Hughes, Andrew_Hughes@pmc-sierra.com
> + *
> + *
> + * This file define the irq handler for MSP SLM subsystem interrupts.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> + 
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/system.h>
> +#include <asm/bitops.h>
> +
> +#include <msp_slp_int.h>
> +#include <msp_regs.h>
> +
> +static inline void unmask_slp_irq(unsigned int irq)
> +{
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE)
> +		*SLP_INT_MSK_REG |= (1 << (irq - MSP_SLP_INTBASE));
> +	else
> +		*PER_INT_MSK_REG |= (1 << (irq - MSP_PER_INTBASE));
> +}
> +
> +static inline void mask_slp_irq(unsigned int irq)
> +{
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE)
> +		*SLP_INT_MSK_REG &= ~(1 << (irq - MSP_SLP_INTBASE));
> +	else
> +		*PER_INT_MSK_REG &= ~(1 << (irq - MSP_PER_INTBASE));
> +}
> +
> +static inline void msp_slp_irq_enable(unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	unmask_slp_irq(irq);
> +	local_irq_restore(flags);
> +}
> +
> +static inline void msp_slp_irq_disable(unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	mask_slp_irq(irq);
> +	local_irq_restore(flags);
> +}
> +
> +
> +static unsigned int msp_slp_irq_startup(unsigned int irq)
> +{
> +	msp_slp_irq_enable(irq);
> +	
> +	return 0;
> +}
> +
> +#define	msp_slp_irq_shutdown	msp_slp_irq_disable
> +
> +/*
> + * While we ack the interrupt interrupts are disabled and thus we don't need
> + * to deal with concurrency issues.  Same for msp_slp_irq_end.
> + */
> +static inline void msp_slp_irq_ack(unsigned int irq)
> +{
> +	mask_slp_irq(irq);
> +
> +	/* only really necessary for 18, 16-14 and sometimes 3:0 (since these can be
> +	 * edge sensitive) but it doesn't hurt for the others.  Fix for efficiency
> +	 * someday.
> +	 */
> +	/* check for PER interrupt range */
> +	if (irq < MSP_PER_INTBASE) {
> +		*SLP_INT_STS_REG = (1 << (irq - MSP_SLP_INTBASE));
> +	} else {
> +		*PER_INT_STS_REG = (1 << (irq - MSP_PER_INTBASE));
> +	}
> +}
> +
> +static void msp_slp_irq_end(unsigned int irq)
> +{
> +	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> +		unmask_slp_irq(irq);
> +}
> +
> +static struct irq_chip msp_slp_irq_controller = {
> +	.typename = "MSP_SLP",
> +	.startup = msp_slp_irq_startup,
> +	.shutdown = msp_slp_irq_shutdown,
> +	.enable = msp_slp_irq_enable,
> +	.disable = msp_slp_irq_disable,
> +	.ack = msp_slp_irq_ack,
> +	.end = msp_slp_irq_end,
> +};
> +
> +void __init msp_slp_irq_init(void)
> +{
> +	int i;
> +
> +	/* Mask/clear interrupts. */
> +	*SLP_INT_MSK_REG = 0x00000000;
> +	*PER_INT_MSK_REG = 0x00000000;	
> +	*SLP_INT_STS_REG = 0xFFFFFFFF;
> +	*PER_INT_STS_REG = 0xFFFFFFFF;
> +
> +	/* initialize all the IRQ descriptors */
> +	for (i = MSP_SLP_INTBASE; i < MSP_PER_INTBASE + 32; i++) {
> +		irq_desc[i].status = IRQ_DISABLED;
> +		irq_desc[i].action = NULL;
> +		irq_desc[i].depth = 1;
> +		irq_desc[i].chip = &msp_slp_irq_controller;
> +	}
> +}

Same rewrite as above for the CIC.

> +
> +void msp_slp_irq_dispatch(struct pt_regs *regs)
> +{
> +	u32 pending;
> +	int intbase;
> +
> +	intbase = MSP_SLP_INTBASE;
> +	pending = *SLP_INT_STS_REG & *SLP_INT_MSK_REG;
> +
> +	/* check for PER interrupt */
> +	if (pending == (1 << (MSP_INT_PER - MSP_SLP_INTBASE))) {
> +		intbase = MSP_PER_INTBASE;
> +		pending = *PER_INT_STS_REG & *PER_INT_MSK_REG;
> +	}
> +
> +	/* check for spurious interrupt */
> +	if (pending == 0x00000000) {
> +		printk("Spurious %s interrupt?\n",(intbase == MSP_SLP_INTBASE)?"SLP":"PER");
> +		return;
> +	}
> +
> +	/* dispatch the irq */
> +	do_IRQ(ffs(pending) + intbase - 1,regs);
> +}
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> new file mode 100644
> index 0000000..2fbc7b5
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
> @@ -0,0 +1,626 @@
> +/*
> + *
> + * BRIEF MODULE DESCRIPTION
> + *    PROM library initialisation code, assuming a version of
> + *    pmon is the boot code.
> + *
> + * Copyright 2000,2001 MontaVista Software Inc.
> + * Author: MontaVista Software, Inc.
> + *         	ppopov@mvista.com or source@mvista.com
> + *
> + * This file was derived from Carsten Langgaard's
> + * arch/mips/mips-boards/xx files.
> + *
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/interrupt.h>
> +#include <linux/mm.h>
> +#ifdef CONFIG_CRAMFS
> +#include <linux/cramfs_fs.h>
> +#endif
> +#ifdef CONFIG_SQUASHFS
> +#include <linux/squashfs_fs.h>
> +#endif

Please remove the squashfs hook until it has not become part of the standard
kernel.

> +
> +#include <asm/addrspace.h>
> +#include <asm/bootinfo.h>
> +#include <asm-generic/sections.h>
> +#include <asm/page.h>
> +
> +#include <msp_prom.h>
> +#include <msp_regs.h>
> +
> +
> +/* global PROM environment variables and pointers */
> +int prom_argc;
> +char **prom_argv, **prom_envp;
> +int *prom_vec;
> +
> +/* debug flag */
> +int init_debug = 1;
> +
> +/* memory blocks */
> +struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
> +
> +/* default feature sets */
> +static char MSPDefaultFeatures[] = 
> +#if defined(CONFIG_PMC_MSP4200_EVAL) \
> + || defined(CONFIG_PMC_MSP4200_GW)
> +	"ERER";
> +#elif defined(CONFIG_PMC_MSP7120_EVAL) \
> + || defined(CONFIG_PMC_MSP7120_GW)
> +	"EMEMSP";
> +#elif defined(CONFIG_PMC_MSP7120_FPGA)
> +	"EMEM";
> +#endif
> +
> +/*
> + * Hooks to fake "prom" console I/O before devices 
> + * are fully initialized. 
> + */
> +extern void a5000PrintChar(char);
> +extern int a5000GetChar(void);
> +static char buf[1024] __initdata = "";
> +
> +/* conversion functions */
> +static inline unsigned char str2hexnum(unsigned char c)
> +{
> +	if(c >= '0' && c <= '9')
> +		return c - '0';
> +	if(c >= 'a' && c <= 'f')
> +		return c - 'a' + 10;
> +	return 0; /* foo */
> +}
> +
> +static inline int str2eaddr(unsigned char *ea, unsigned char *str)
> +{
> +	int index = 0;
> +	unsigned char num = 0;
> +
> +	while (*str != '\0') {
> +		if((*str == '.') || (*str == ':')) {
> +			ea[index++] = num;
> +			num = 0;
> +			str++;
> +		} else {
> +			num = num << 4;
> +			num |= str2hexnum(*str++);
> +		}
> +	}
> +
> +	if (index == 5)	{
> +		ea[index++] = num;
> +		return 0;
> +	} else {
> +		return -1;
> +	}
> +}
> +
> +static inline unsigned long str2hex(unsigned char *str)
> +{
> +	int value = 0;
> +
> +	while (*str) {
> +		value = value << 4;
> +		value |= str2hexnum(*str++);
> +	}
> +
> +	return value;
> +}
> +
> +/* function to query the system information */
> + 
> +const char *get_system_type(void)
> +{
> +#if defined(CONFIG_PMC_MSP4200_EVAL)
> +	return "PMC-Sierra MSP4200 Eval Board";
> +#elif defined(CONFIG_PMC_MSP4200_GW)
> +	return "PMC-Sierra MSP4200 VoIP Gateway";
> +#elif defined(CONFIG_PMC_MSP7120_EVAL)
> +	return "PMC-Sierra MSP7120 Eval Board";
> +#elif defined(CONFIG_PMC_MSP7120_GW)
> +	return "PMC-Sierra MSP7120 Residential Gateway";
> +#elif defined(CONFIG_PMC_MSP7120_FPGA)
> +	return "PMC-Sierra MSP7120 FPGA";
> +#else
> +	#error "What is the type of *your* MSP?"
> +#endif
> +}
> +
> +int get_ethernet_addr(char * ethaddr_name, char *ethernet_addr)
> +{
> +	char *ethaddr_str;
> +
> +	ethaddr_str = prom_getenv(ethaddr_name);
> +	if (!ethaddr_str) {
> +		printk("%s not set in boot prom\n", ethaddr_name);
> +		return -1;
> +	}
> +		
> +	if (str2eaddr(ethernet_addr, ethaddr_str) == -1) {
> +		printk("%s badly formatted-<%s>\n", ethaddr_name, ethaddr_str);
> +		return -1;
> +	}
> +
> +	if (init_debug > 1) {
> +		int i;
> +		printk("get_ethernet_addr: for %s ", ethaddr_name);
> +		for (i=0; i<5; i++)
> +			printk("%02x:", (unsigned char)*(ethernet_addr+i));
> +		printk("%02x\n", *(ethernet_addr+i));
> +	}
> +
> +	return 0;
> +}
> +
> +static char *getFeatures(void)
> +{
> +	char *feature = prom_getenv(FEATURES);
> +
> +	if (feature == NULL) {
> +		/* add code here based on MACHINE_TYPE to get default features */
> +		feature = MSPDefaultFeatures;
> +	}
> +
> +	return feature;
> +}
> +
> +static char testFeature(char c)
> +{
> +	char *feature = getFeatures();
> +
> +	while (*feature) {
> +		if (*feature++ == c)
> +			return *feature;
> +		feature++;
> +	}
> +
> +	return FEATURE_NOEXIST;
> +}
> +
> +unsigned long getdeviceid(void)
> +{
> +	char *deviceid = prom_getenv(DEVICEID);
> +
> +	if (deviceid == NULL)
> +		return *DEV_ID_REG;
> +	else
> +		return str2hex(deviceid);
> +}
> +
> +char identify_pci(void)
> +{
> +	return testFeature(PCI_KEY);
> +}
> +
> +char identify_pcimux(void)
> +{
> +	return testFeature(PCIMUX_KEY);
> +}
> +
> +char identify_sec(void)
> +{
> +	return testFeature(SEC_KEY);
> +}
> +
> +char identify_spad(void)
> +{
> +	return testFeature(SPAD_KEY);
> +}
> +
> +char identify_tdm(void)
> +{
> +	return testFeature(TDM_KEY);
> +}
> +
> +char identify_zsp(void)
> +{
> +	return testFeature(ZSP_KEY);
> +}
> +
> +static char identify_enetfeature(char key, unsigned long interfaceNum)
                                                            ^^^^^^^^^^^^
No camale case please.

> +{
> +	char *feature = getFeatures();
> +
> +	while (*feature) {
> +		if (*feature++ == key && interfaceNum-- == 0)
> +			return *feature;
> +		feature++;
> +	}
> +
> +	return FEATURE_NOEXIST;
> +}
> +
> +char identify_enet(unsigned long interfaceNum)
> +{
> +	return identify_enetfeature(ENET_KEY, interfaceNum);
> +}
> +
> +char identify_enetTxD(unsigned long interfaceNum)
> +{
> +	return identify_enetfeature(ENETTXD_KEY, interfaceNum);
> +}
> +
> +unsigned long identify_family()
                                ^^
void

> +{
> +	unsigned long deviceid;
> +
> +	deviceid = getdeviceid();
> +
> +	return deviceid & CPU_DEVID_FAMILY;
> +}
> +
> +unsigned long identify_revision()
                                  ^^
void

> +{
> +	unsigned long deviceid;
> +
> +	deviceid = getdeviceid();
> +
> +	return deviceid & CPU_DEVID_REVISION;
> +}
> +
> +
> +/* PROM environment functions */
> +char *prom_getenv(char *envname)
> +{
> +	/*
> +	 * Return a pointer to the given environment variable.  prom_envp points
> +	 * to a null terminated array of pointers to variables.
> +	 * Environment variables are stored in the form of "memsize=64"
> +	 */
> +
> +	char **var = prom_envp;
> +	int i = strlen(envname);
> +
> +	while(*var) {
            ^^
Whitespace

> +		if(strncmp(envname, *var, i) == 0) {
                 ^^
Whitespace

> +			return (*var + strlen(envname) + 1);
> +		}
> +		var++;
> +	}
> +	
> +	return NULL;
> +}
> +
> +/* PROM commandline functions */
> +char * prom_getcmdline(void)
> +{
> +	return &(arcs_cmdline[0]);
> +}
> +
> +
> +void  __init prom_init_cmdline(void)
> +{
> +	char *cp;
> +	int actr;
> +
> +	actr = 1; /* Always ignore argv[0] */
> +
> +	cp = &(arcs_cmdline[0]);
> +	while(actr < prom_argc) {
> +		strcpy(cp, prom_argv[actr]);
> +		cp += strlen(prom_argv[actr]);
> +		*cp++ = ' ';
> +		actr++;
> +	}
> +	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
> +		--cp;
> +	*cp = '\0';
> +}
> +
> +/* PROM printing functions */
> +void __init prom_printf_setup(int tty_no)
> +{
> +	/* No setup of UART - assume PMON left in sane state */
> +}

So I wonder why this function exists at all ...

> +
> +void __init prom_printf(char *fmt, ...)
> +{

Two issues:

 o there is a generic prom_printf function in arch/mips/lib.  Just delete
   your own version of it and supply  a prom_putchar() function.

 o prom_printf in turn is being obsoleted by early_printk.  There is a
   reasonable example of an early_printk implementation in arch/mips/cobalt;
   just grep for "early".  prom_printf has the disadvantage that it reimplements
   part of printk in a way where the two instances don't really know much of
   each other, so for example prom_printf output isn't visible in dmesg or
   syslog.

> +	va_list args;
> +	int l;
> +	char *p, *buf_end;
> +	long flags = 0;

The flags argument of local_irq_save, spinlocking etc. functions is unsigned
long.

> +
> +	/* Low level, brute force, not SMP safe... */
> +	local_irq_save(flags);
> +	va_start(args, fmt);
> +	l = vsnprintf(buf, sizeof(buf), fmt, args); /* hopefully i < sizeof(buf) */
> +	va_end(args);
> +
> +	buf_end = buf + l;
> +
> +	for (p = buf; p < buf_end; p++)
> +	{   /* Crude cr/nl handling is better than none */
> +		if (*p == '\n')
> +			a5000PrintChar('\r');
> +		a5000PrintChar(*p);
> +	}
> +	local_irq_restore(flags);
> +}
> +
> +/* memory allocation functions */
> +static int __init prom_memtype_classify(unsigned int type)
> +{
> +	switch (type) {
> +		case yamon_free:
> +			return BOOT_MEM_RAM;
> +		case yamon_prom:
> +			return BOOT_MEM_ROM_DATA;
> +		default:
> +			return BOOT_MEM_RESERVED;
> +	}
> +}
> +
> +void __init prom_meminit(void)
> +{
> +	struct prom_pmemblock	*p;
> +
> +	p = prom_getmdesc();
> +
> +	while (p->size) {
> +		long	type;
> +		unsigned long	base, size;
> +
> +		type = prom_memtype_classify(p->type);
> +		base = p->base;
> +		size = p->size;
> +
> +		add_memory_region(base, size, type);
> +				p++; 
> +	}
> +}
> +
> +#ifdef CONFIG_CHECKOVERLAP	 /* slab.c -- no overlapping kmalloc stuff */
> +extern void check_overlap_remove(void *, int, void *);
> +#endif	/* CONFIG_CHECKOVERLAP */

CONFIG_CHECKOVERLAP is not defined anywhere -> dead code.

> +
> +void __init prom_free_prom_memory(void)
> +{
> +	int	i;
> +	unsigned long	freed = 0;
> +	unsigned long	addr;
> +	int	argc;
> +	char	**argv;
> +	char	**envp;
> +	char	*ptr;
> +	int	len = 0;
> +
> +	/* preserve environment variables and command line from pmon/bbload */
> +	/* first preserve the command line */
> +	for (argc = 0; argc < prom_argc; argc++)
> +	{
> +		len += sizeof(char *);			/* length of pointer */
> +		len += strlen(prom_argv[argc]) + 1;	/* length of string */
> +	}
> +	len += sizeof(char *);		/* plus length of null pointer */
> +
> +	argv = kmalloc(len, GFP_KERNEL);
> +	ptr = (char *) &argv[prom_argc + 1];	/* strings follow array */
> +
> +	for (argc = 0; argc < prom_argc; argc++)
> +	{
> +		argv[argc] = ptr;
> +		strcpy(ptr, prom_argv[argc]);
> +		ptr += strlen(prom_argv[argc]) + 1;
> +	}
> +	argv[prom_argc] = NULL;		/* end array with null pointer */
> +	prom_argv = argv;
> +
> +	/* next preserve the environment variables */
> +	len = 0;
> +	i = 0;
> +	for (envp = prom_envp; *envp != NULL; envp++)
> +	{
> +		i++;		/* count number of environment variables */
> +		len += sizeof(char *);		/* length of pointer */
> +		len += strlen(*envp) + 1;	/* length of string */
> +	}
> +	len += sizeof(char *);		/* plus length of null pointer */
> +
> +	envp = kmalloc(len, GFP_KERNEL);
> +	ptr = (char *) &envp[i+1];
> +
> +	for (argc = 0; argc < i; argc++)
> +	{
> +		envp[argc] = ptr;
> +		strcpy(ptr, prom_envp[argc]);
> +		ptr += strlen(prom_envp[argc]) + 1;
> +	}
> +	envp[i] = NULL;			/* end array with null pointer */
> +	prom_envp = envp;
> +
> +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> +		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
> +			continue;
> +
> +#ifdef CONFIG_CHECKOVERLAP

CONFIG_CHECKOVERLAP is not defined anywhere -> dead code.

> +		/* Remove section added in mipsnommu/kernel/setup.c */
> +		check_overlap_remove((void *)__va(boot_mem_map.map[i].addr),
> +				boot_mem_map.map[i].size, (void *)&prom_free_prom_memory);

> +#endif	/* CONFIG_CHECKOVERLAP */
> +
> +		addr = boot_mem_map.map[i].addr;
> +		while (addr < boot_mem_map.map[i].addr
> +				  + boot_mem_map.map[i].size) {
> +			ClearPageReserved(virt_to_page(__va(addr)));
> +			init_page_count(virt_to_page(__va(addr)));
> +			free_page((unsigned long) __va(addr));
> +			addr += PAGE_SIZE;
> +			freed += PAGE_SIZE;
> +		}

Please use free_init_pages() to free __init memory.  See prom_free_prom_memory
in arch/mips/mips-boards/generic/memory.c for a simple example.

> +	}
> +}
> +
> +struct prom_pmemblock * __init prom_getmdesc(void)
> +{
> +	static char	 memsz_env[] __initdata = "memsize";
> +	static char	 heaptop_env[] __initdata = "heaptop";
> +	char	*str;
> +	unsigned int	memsize;
> +	unsigned int	heaptop;
> +#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
> +	void		*ramroot_start;
> +	unsigned long	ramroot_size;
> +#endif
> +	int i;
> +
> +	str = prom_getenv(memsz_env);
> +	if (!str) {
> +		ppfinit("memsize not set in boot prom, set to default (32Mb)\n");
> +		memsize = 0x02000000;
> +	} else {
> +		memsize = simple_strtol(str, NULL, 0);
> +
> +		if (memsize == 0) {
> +			/* if memsize is a bad size, use reasonable default */
> +			memsize = 0x02000000;
> +		}
> +
> +		/* convert to physical address (removing caching bits, etc) */
> +		memsize = CPHYSADDR((u32)memsize);

A cast from memsize to unsigned int is fairly pointless.

Anyway, keep in mind that Linux uses unsigned int as the integer type
equivalent to a pointer.

> +	}
> +
> +	str = prom_getenv(heaptop_env);
> +	if (!str) {
> +		heaptop = CPHYSADDR((u32)&_text);
> +		ppfinit("heaptop not set in boot prom, set to default 0x%08x\n",heaptop);
> +	} else {
> +		heaptop = simple_strtol(str, NULL, 16);
> +		if (heaptop == 0) {
> +			/* heaptop conversion bad, might have 0xValue */
> +			heaptop = simple_strtol(str, NULL, 0);
> +
> +			if (heaptop == 0) {
> +				/* heaptop still bad, use reasonable default */
> +				heaptop = CPHYSADDR((u32)&_text);
> +			}
> +		}
> +
> +		/* convert to physical address (removing caching bits, etc) */
> +		heaptop = CPHYSADDR((u32)heaptop);
> +	}
> +
> +	memset(mdesc, 0, sizeof(mdesc));

memset is in .bss so cleared on bootup by the loader.

> +
> +	/* the base region */
> +	i = 0;
> +	mdesc[i].type = BOOT_MEM_RESERVED;
> +	mdesc[i].base = 0x00000000;
> +	mdesc[i].size = PAGE_ALIGN(0x300 + 0x80); /* jtag interrupt vector + sizeof vector */
> +
> +	/* PMON data */
> +	if (heaptop > mdesc[i].base + mdesc[i].size) {
> +		i++;			/* 1 */
> +		mdesc[i].type = BOOT_MEM_ROM_DATA;
> +		mdesc[i].base = mdesc[i-1].base + mdesc[i-1].size;
> +		mdesc[i].size = heaptop - mdesc[i].base;
> +	}
> +
> +	/* end of PMON data to start of kernel -- probably zero .. */
> +	if (heaptop != CPHYSADDR((u32)_text)) {
> +		i++;	/* 2 */
> +		mdesc[i].type = BOOT_MEM_RAM;
> +		mdesc[i].base = heaptop;
> +		mdesc[i].size = CPHYSADDR((u32)_text) - mdesc[i].base;
> +	}
> +
> +	/*  kernel proper */
> +	i++;			/* 3 */
> +	mdesc[i].type = BOOT_MEM_RESERVED;
> +	mdesc[i].base = CPHYSADDR((u32)_text);
> +#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
> +	if (get_ramroot(&ramroot_start, &ramroot_size)) {
> +		/* Rootfs in RAM -- follows kernel
> +		 * Combine rootfs image with kernel block so a
> +		 * page (4k) isn't wasted between memory blocks */
> +		mdesc[i].size = CPHYSADDR(PAGE_ALIGN(
> +			(u32)ramroot_start + ramroot_size)) - mdesc[i].base;
> +	} else
> +#endif
> +		mdesc[i].size = CPHYSADDR(PAGE_ALIGN((u32)_end)) - mdesc[i].base;
> +
> +	/* Remainder of RAM -- under memsize */
> +	i++;			/* 5 */				
> +	mdesc[i].type = yamon_free;
> +	mdesc[i].base = mdesc[i-1].base + mdesc[i-1].size;
> +	mdesc[i].size = memsize - mdesc[i].base;
> +
> +	return &mdesc[0];
> +}
> +
> +/* rootfs functions */
> +#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
> +bool get_ramroot(void **start, unsigned long *size)
> +{
> +	extern char _end[];
> +	
> +	/* Check for start following the end of the kernel */
> +	void *check_start = (void *)_end;
> +
> +	/* Check for supported rootfs types */
> +#ifdef CONFIG_CRAMFS
> +	if (*(__u32 *)check_start == CRAMFS_MAGIC) {
> +		/* Get CRAMFS size */
> +		*start = check_start;
> +		*size = PAGE_ALIGN(
> +			((struct cramfs_super *)check_start)->size);
> +		
> +		return true;
> +	}
> +#endif
> +#ifdef CONFIG_SQUASHFS

Please remove the squashfs hook until it has not become part of the standard
kernel.

> +	if (*((unsigned int *)check_start) == SQUASHFS_MAGIC) {
> +		/* Get SQUASHFS size */
> +		*start = check_start;
> +		*size = PAGE_ALIGN(
> +			((struct squashfs_super_block *)check_start)->bytes_used);
> +		
> +		return true;
> +	}
> +#endif
> +
> +	return false;
> +}
> +
> +EXPORT_SYMBOL(get_ramroot);
> +#endif
> +
> +EXPORT_SYMBOL(get_ethernet_addr) ;
> +EXPORT_SYMBOL(identify_pci) ;
> +EXPORT_SYMBOL(identify_sec) ;
> +EXPORT_SYMBOL(identify_spad) ;
> +EXPORT_SYMBOL(identify_tdm) ;
> +EXPORT_SYMBOL(identify_zsp) ;
> +EXPORT_SYMBOL(identify_enet) ;
> +EXPORT_SYMBOL(identify_enetTxD) ;
> +EXPORT_SYMBOL(identify_family) ;
> +EXPORT_SYMBOL(identify_revision) ;
> +
> +EXPORT_SYMBOL(prom_getcmdline);
> +EXPORT_SYMBOL(str2eaddr);
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
> new file mode 100644
> index 0000000..2e835cc
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
> @@ -0,0 +1,288 @@
> +/*
> + * Copyright 2005 PMC-Sierra, Inc,
> + * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
> + * Modified for PMC by Andrew Hughes (hughesan@pmc-sierra.com)
> + *
> + * arch/mips/msp/setup.c
> + *     The generic setup file for PMC-Sierra MSP processors
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/bootmem.h>
> +#include <linux/swap.h>
> +#include <linux/ioport.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/timex.h>
> +#include <linux/termios.h>
> +#include <linux/tty.h>
> +#include <linux/console.h>
> +#include <linux/pm.h>
> +
> +#include <asm/time.h>
> +#include <asm/bootinfo.h>
> +#include <asm/page.h>
> +#include <asm/irq.h>
> +#include <asm/processor.h>
> +#include <asm/ptrace.h>
> +#include <asm/reboot.h>
> +#include <asm/cacheflush.h>
> +#include <asm/pmon.h>
> +#include <asm/mipsmtregs.h>
> +#include <asm/r4kcache.h>
> +#include <asm/war.h>
> +
> +#include <msp_prom.h>
> +#include <msp_int.h>
> +#include <msp_regs.h>
> +
> +#if defined(CONFIG_PMC_MSP7120_GW)
> +#include <msp_gpio_macros.h>
> +#endif
> +
> +extern void msp_timer_init(void);
> +extern void msp_timer_setup(struct irqaction *irq);
> +extern void msp_serial_setup(void);
> +extern void pmctwiled_setup(void);
> +
> +/* Actually performs the reset for 7120-based boards */
> +void msp7120_reset( void )
> +{
> +	int i;
> +	unsigned char *iptr, *start, *end;
> +
> +	local_irq_disable();
> +
> +#ifdef CONFIG_CPU_MIPS32_R2

Bare MIPS32R2 does not support multithreading.  So this #ifdef should be
CONFIG_MIPS_MT instead.

> +	dvpe();
> +#endif
> +
> +	/*
> +	 * Cache the rest of this function, since we put the DDRC into
> +	 * self-refresh mode, and must ensure we do not touch RAM after that
> +	 */
> +	start = (unsigned char*)&&startpoint;
> +	end = (unsigned char*)&&endpoint;

You're relying on the assumption that gcc will actually compile the code
between these two two labels.  This may work for this particular code
and compiler version but has become very fragile with modern gcc which
frequently moves code out of line for sake of improved branch prediction.

This is basically something that cannot be done in plain C.  To make this
actually work reliable I think you will need to implement the part between
the two labels in assembler - even inline assumbler would be ok.

> +
> +	if( (unsigned int)start % (unsigned int)(L1_CACHE_BYTES) )
> +		start -= ((unsigned int)start % (unsigned int)(L1_CACHE_BYTES));
> +
> +	for( iptr = start; iptr < end; iptr += L1_CACHE_BYTES )
> +		cache_op( Fill, iptr );
> +		
> +startpoint:
> +	/* Put the DDRC into self-refresh mode */
> +	DDRC_INDIRECT_WRITE( DDRC_CTL(10), 0xb, (1<<16) );
> +
> +	/*
> +	 * IMPORTANT!  DO NOT do anything from here on out that might even think
> +	 * about fetching from RAM - IE, don't call any not-inline functions,
> +	 * and be VERY sure that any unline functions you do call do NOT access
> +	 * any sort of RAM anywhere!
> +	 */
> +
> +	/* Wait a bit for the DDRC to settle */
> +	for( i = 0; i < 100000000; i++);
> +
> +#if defined(CONFIG_PMC_MSP7120_GW)
> +	/*
> +	 * Throw GPIO 9 HI, (tied to board reset logic)
> +	 * GPIO 9 is the 4th GPIO of register 3
> +	 *
> +	 * Note, we cannot use the higher-level 'msp_gpio_pin_...' functions
> +	 * as they look up data in a static table somewhere else in RAM!
> +	 */
> +	set_value_reg32( GPIO_CFG3_REG,
> +			BASIC_MODE_REG_MASK(3),
> +			BASIC_MODE_REG_VALUE(MSP_GPIO_OUTPUT, 3) );
> +	set_reg32( GPIO_DATA3_REG, 
> +			BASIC_DATA_REG_MASK(3) );
> +
> +	/*
> +	 * In case GPIO9 doesn't *really* reset the board (jumper configurable!)
> +	 * fallback to generic 7120 reset register below to ensure SoC reset.
> +	 */
> +#endif
> +
> +	/*
> +	 * There is a reset bit you can write to at 0xBC00_0014.
> +	 * Writing a 1 to bit 0 will do a reset
> +	 */
> +	*RST_SET_REG = 0x00000001;
> +
> +endpoint:
> +	return;
> +}
> +
> +void msp_restart(char *command)
> +{
> +	printk("Now rebooting .......\n");
> +
> +#if defined(CONFIG_PMC_MSP7120_EVAL) \
> + || defined(CONFIG_PMC_MSP7120_GW) \
> + || defined(CONFIG_PMC_MSP7120_FPGA)
> +	msp7120_reset();
> +#else
> +	/* No chip-specific reset code, just jump to the ROM reset vector */
> +	set_c0_status(ST0_BEV | ST0_ERL);
> +	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
> +	flush_cache_all();
> +	write_c0_wired(0);
> +
> +	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
> +#endif
> +}
> +
> +void msp_halt(void)
> +{
> +	printk(KERN_NOTICE "\n** You can safely turn off the power\n");

This message is soooo Windows 95 ;-)

> +	while (1)
> +		/* If possible call official function to get CPU WARs */
> +		if (cpu_wait)
> +			(*cpu_wait)();
> +		else
> +			__asm__(".set\tmips3\n\t" "wait\n\t" ".set\tmips0");
> +}
> +
> +void msp_power_off(void)
> +{
> +	msp_halt();
> +}
> +
> +void __init plat_mem_setup(void)
> +{
> +	_machine_restart = msp_restart;
> +	_machine_halt = msp_halt;
> +	pm_power_off = msp_power_off;
> +
> +	board_time_init   = msp_timer_init;
> +}
> +
> +void __init prom_init(void)
> +{
> +	unsigned long family;
> +	unsigned long revision;
> +
> +	prom_argc = fw_arg0;
> +	prom_argv = (char **) fw_arg1;
> +	prom_envp = (char **) fw_arg2;
> +
> +	/* 
> +	 * someday we can use this with PMON2000 to get a
> +	 * platform call prom routines for output etc withou

A 't' missing.

> +	 * having to use grody hacks.  For now it's unused.
> +	 */
> +	/*struct callvectors *cv = (struct callvectors *) fw_arg3;*/
> +
> +	family = identify_family();
> +	revision = identify_revision();
> +
> +	switch (family)	{
> +		case FAMILY_FPGA:

Indentation - please keep the case and default labels on the same level as
the switch keyword.

> +			if (FPGA_IS_MSP4200(revision)) {
> +				/* Old-style revision ID */
> +				mips_machgroup = MACH_GROUP_MSP;
> +				mips_machtype = MACH_MSP4200_FPGA;
> +			} else { 
> +				mips_machgroup = MACH_GROUP_MSP;
> +				mips_machtype = MACH_MSP_OTHER;
> +			}
> +			break;
> +
> +		case FAMILY_MSP4200:
> +			mips_machgroup = MACH_GROUP_MSP;
> +#if defined(CONFIG_PMC_MSP4200_EVAL)
> +			mips_machtype  = MACH_MSP4200_EVAL;
> +#elif defined(CONFIG_PMC_MSP4200_GW)
> +			mips_machtype  = MACH_MSP4200_GW;
> +#else
> +			mips_machtype = MACH_MSP_OTHER;
> +#endif
> +			break;
> +
> +		case FAMILY_MSP4200_FPGA:
> +			mips_machgroup = MACH_GROUP_MSP;
> +			mips_machtype  = MACH_MSP4200_FPGA;
> +			break;
> +
> +		case FAMILY_MSP7100:
> +			mips_machgroup = MACH_GROUP_MSP;
> +#if defined(CONFIG_PMC_MSP7120_EVAL)
> +			mips_machtype = MACH_MSP7120_EVAL;
> +#elif defined(CONFIG_PMC_MSP7120_GW)
> +			mips_machtype = MACH_MSP7120_GW;
> +#else
> +			mips_machtype = MACH_MSP_OTHER;
> +#endif
> +			break;
> +
> +		case FAMILY_MSP7100_FPGA:
> +			mips_machgroup = MACH_GROUP_MSP;
> +			mips_machtype  = MACH_MSP7120_FPGA;
> +			break;
> +
> +		default:
> +			/* we don't recognize the machine */
> +			mips_machgroup = MACH_GROUP_UNKNOWN;
> +			mips_machtype  = MACH_UNKNOWN;
> +			break;
> +	}
> +
> +	/*
> +	 * Processor Core Errata workarounds:
> +	 * NOTE: cpu_probe is called just before prom_init so it safe to use
> +	 * current_cpu_data.
> +	 */
> +	if(current_cpu_data.cputype == CPU_34K) {
> +		/*
> +		 * Erratum "RPS May Cause Incorrect Instruction Execution"
> +		 * This code only handles VPE0, any SMP/SMTC/RTOS code making use of
> +		 * VPE1 will be responsable for that VPE.
> +		 */
> +		if((current_cpu_data.processor_id & PRID_BITMSK_REV)
> +	  	   <= PRID_REV_RTL_1_0_2)
> +			write_c0_config7(read_c0_config7() | CONFIG7_BITMSK_RPS);
> +	}

This 34K erratum affects all systems not just MSPs, so the workaround should
be in generic MIPS code.  arch/mips/kernel/cpu-probe.c:check_bugs32() seems
the best place.

> +
> +	prom_printf_setup(0);
> +	prom_printf("\nLINUX started...\n");
> +
> +	/* make sure we have the right initialization routine - sanity */
> +	if(mips_machgroup != MACH_GROUP_MSP) {
> +		prom_printf("Unknown machine group in a MSP initialization routine\n");
> +		panic("***Bogosity factor five***, exiting\n");
> +	}
> +
> +	/* setup the serial console */
> +	msp_serial_setup();
> +	prom_init_cmdline();
> +	
> +	/* setup memory regions */
> +	prom_meminit();
> +
> +	/*
> +	 * Sub-system setup follows.
> +	 * Setup functions can  either be called here or using the
> +	 * subsys_initcall mechanism (i.e. see msp_pci). The order
> +	 * in which they are called can be changed by using the link
> +	 * order in arch/mips/pmc-sierra/msp71xx/Makefile.
> +	 * 
> +	 * NOTE: Please keep sub-system specific initialization code
> +	 * in separate specific files.
> +	 */
> +	 
> +#ifdef CONFIG_SENSORS_PMCTWILED
> +	/* setup twi led interface */
> +	pmctwiled_setup();

SENSORS_PMCTWILED is a tristate.  So if configured as a module this call to
pmctwiled_setup() will result in a link failure.  Aside, inserting these
hooks should really be part of the "PMC MSP71xx LED driver" patch.

I think the preferable solution is to invoke PMC MSP71xx LED driver through
something like subsys_initcall() - at least I didn't notice any ordering
problems that could result.

> +#endif
> +}
> +
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> new file mode 100644
> index 0000000..57dab9b
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> @@ -0,0 +1,92 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + * Setting up the clock on MSP SOCs.  No RTC typically.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/sched.h>
> +#include <linux/spinlock.h>
> +#include <linux/module.h>
> +
> +#include <asm/mipsregs.h>
> +#include <asm/ptrace.h>
> +#include <asm/time.h>
> +
> +#include <msp_prom.h>
> +#include <msp_int.h>
> +#include <msp_regs.h>
> +
> +void __init msp_timer_init(void)
> +{
> +	char    *endp,*s;
> +	unsigned long cpu_rate = 0;
> +    
> +	if (cpu_rate == 0) {
> +		s = prom_getenv("clkfreqhz");
> +		cpu_rate = simple_strtoul(s,&endp,10);
> +		if(endp != NULL && *endp != 0) {
> +			printk("Clock rate in Hz parse error: %s\n", s);
> +			cpu_rate = 0;
> +		}
> +	}
> +	
> +	if (cpu_rate == 0) {
> +		s = prom_getenv("clkfreq");
> +		cpu_rate = 1000*simple_strtoul(s,&endp,10);        
> +		if(endp != NULL && *endp != 0) {
> +			printk("Clock rate in MHz parse error: %s\n", s);
> +			cpu_rate = 0;
> +		}
> +	}
> +	
> +	if (cpu_rate == 0) {
> +#if defined(CONFIG_PMC_MSP7120_EVAL) \
> + || defined(CONFIG_PMC_MSP7120_GW)
> +		cpu_rate = 400000000;
> +#elif defined(CONFIG_PMC_MSP7120_FPGA)
> +		cpu_rate = 25000000;
> +#else                
> +		cpu_rate = 150000000;
> +#endif
> +		printk("Failed to determine CPU clock rate, assuming %ld hz ...\n",
> +			cpu_rate);
> +	}
> +	
> +	printk("Clock rate set to %ld\n",cpu_rate);
> +	
> +	/* timer frequency is 1/2 clock rate */
> +	mips_hpt_frequency = cpu_rate/2;
> +}
> +
> +
> +void __init plat_timer_setup(struct irqaction *irq)
> +{
> +#ifdef CONFIG_IRQ_MSP_CIC
> +	/* we are using the vpe0 counter for timer interrupts */
> +	setup_irq(MSP_INT_VPE0_TIMER, irq);
> +#else
> +	/* we are using the mips counter for timer interrupts */
> +	setup_irq(MSP_INT_TIMER, irq);
> +#endif
> +}
> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_usb.c b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
> new file mode 100644
> index 0000000..96d8128
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_usb.c
> @@ -0,0 +1,145 @@
> +/*
> + * The setup file for USB related hardware on PMC-Sierra MSP processors.
> + *
> + * Copyright 2006 PMC-Sierra, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mipsregs.h>
> +
> +#include <msp_regs.h>
> +#include <msp_int.h>
> +#include <msp_prom.h>
> +
> +#if defined (CONFIG_USB_EHCI_HCD)
> +static struct resource msp_usbhost_resources [] = {
> +	[0] = {
> +		.start  = MSP_USB_BASE_START,
> +		.end    = MSP_USB_BASE_END,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = MSP_INT_USB,
> +		.end    = MSP_INT_USB,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 msp_usbhost_dma_mask = 0xffffffffUL;

Use DMA_32BIT_MASK instead of open coded magic constants.

> +
> +static struct platform_device msp_usbhost_device = {
> +	.name	 = "pmcmsp-ehci",
> +	.id		 = 0,
> +	.dev	 = {
> +		.dma_mask = &msp_usbhost_dma_mask,
> +		.coherent_dma_mask = 0xffffffffUL,

ditto.

> +	},
> +	.num_resources  = ARRAY_SIZE (msp_usbhost_resources),
> +	.resource       = msp_usbhost_resources,
> +};
> +#endif /* CONFIG_USB_EHCI_HCD */
> +
> +#if defined (CONFIG_USB_GADGET)
> +static struct resource msp_usbdev_resources [] = {
> +	[0] = {
> +		.start  = MSP_USB_BASE,
> +		.end    = MSP_USB_BASE_END,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = MSP_INT_USB,
> +		.end    = MSP_INT_USB,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 msp_usbdev_dma_mask = 0xffffffffUL;

ditto.

> +
> +static struct platform_device msp_usbdev_device = {
> +	.name	 = "msp71xx_udc",
> +	.id	     = 0,
> +	.dev	 = {
> +		.dma_mask = &msp_usbdev_dma_mask,
> +		.coherent_dma_mask = 0xffffffffUL,
> +	},
> +	.num_resources  = ARRAY_SIZE (msp_usbdev_resources),
> +	.resource       = msp_usbdev_resources,
> +};
> +#endif /* CONFIG_USB_GADGET */
> +
> +#if defined (CONFIG_USB_EHCI_HCD) || defined (CONFIG_USB_GADGET)
> +static struct platform_device *msp_devs[1];
> +#endif
> +
> +
> +static int __init msp_usb_setup(void)
> +{
> +#if defined (CONFIG_USB_EHCI_HCD) || defined (CONFIG_USB_GADGET)
> +	char		*strp;
> +	char		envstr[32];
> +	unsigned int val;
> +	
> +	/* construct environment name usbmode */
> +	/* set usbmode <host/device> as pmon environment var */
> +	snprintf((char *)&envstr[0], sizeof(envstr), "usbmode");
> +
> +	/* set default host mode */
> +	val = 1;
> +
> +	/* get environment string */
> +	strp = prom_getenv((char *)&envstr[0]);
> +	if (strp) {
> +		/* compare string */
> +		if (!strcmp(strp, "device"))
> +			val = 0;
> +	}
> +
> +	if (val) {
> +#if defined (CONFIG_USB_EHCI_HCD)
> +		/* get host mode device */
> +		msp_devs[0] = &msp_usbhost_device;
> +		prom_printf("platform add USB HOST done %s.\n", msp_devs[0]->name);
> +
> +		/* add device */
                ^^^^^^^^^^^^^^^^
Nobody who sees the next line of code would have guessed.  Honest.

> +		platform_add_devices (msp_devs, ARRAY_SIZE (msp_devs));
> +#endif  /* CONFIG_USB_EHCI_HCD */
> +	}
> +#if defined (CONFIG_USB_GADGET)
> +	else {
> +		/* get device mode structure */
> +		msp_devs[0] = &msp_usbdev_device;
> +		prom_printf("platform add USB DEVICE done %s.\n", msp_devs[0]->name);
> +
> +		/* add device */
                ^^^^^^^^^^^^^^^^
Nobody who sees the next line of code would have guessed.  Honest.

> +		platform_add_devices (msp_devs, ARRAY_SIZE (msp_devs));
> +	}
> +#endif  /* CONFIG_USB_GADGET */
> +#endif  /* CONFIG_USB_EHCI_HCD || CONFIG_USB_GADGET */
> +
> +	return 0;
> +}
> +
> +subsys_initcall(msp_usb_setup);
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h
> new file mode 100644
> index 0000000..a75dff6
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_cic_int.h
> @@ -0,0 +1,110 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999 MIPS Technologies, Inc.  All rights reserved.
> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + * Defines for the MSP interrupt controller.
> + *
> + */
> +#ifndef _MSP_CIC_INT_H
> +#define _MSP_CIC_INT_H
> +
> +
> +/* The PMC-Sierra CIC interrupts are all centrally managed by the CIC sub-system.
> +** We attempt to keep the interrupt numbers as consistent as possible across all
> +** of the MSP devices, but some differences will creep in ....
> +** The interrupts which are directly forwarded to the MIPS core interrupts
> +** are assigned interrupts in the range 0-7, interrupts cascaded through
> +** the CIC are assigned interrupts 8-39.  The cascade occurs on C_IRQ4
> +** (MSP_INT_CIC).  Currently we don't really distinguish between VPE1 
> +** and VPE0 (or thread contexts for that matter).  Will have to fix.
> +** The PER interrupts are assigned interrupts in the range 40-71.
> +*/

Again Documentation/CodingStyle:

The preferred style for long (multi-line) comments is:

        /*
         * This is the preferred style for multi-line
         * comments in the Linux kernel source code.
         * Please use it consistently.
         *
         * Description:  A column of asterisks on the left side,
         * with beginning and ending almost-blank lines.
         */

> +
> +
> +/*
> +** IRQs directly forwarded to the CPU
> +*/
> +#define MSP_MIPS_INTBASE        (0)
> +#define MSP_INT_SW0             (0)  /* IRQ for swint0,         C_SW0     */
> +#define MSP_INT_SW1             (1)  /* IRQ for swint1,         C_SW1     */
> +#define MSP_INT_MAC0            (2)  /* IRQ for MAC 0,          C_IRQ0    */
> +#define MSP_INT_MAC1            (3)  /* IRQ for MAC 1,          C_IRQ1    */
> +#define MSP_INT_USB             (4)  /* IRQ for USB,            C_IRQ2    */
> +#define MSP_INT_SAR             (5)  /* IRQ for ADSL2+ SAR,     C_IRQ3    */
> +#define MSP_INT_CIC             (6)  /* IRQ for CIC block,      C_IRQ4    */
> +#define MSP_INT_SEC             (7)  /* IRQ for Sec engine,     C_IRQ5    */
                                   ^^^
No need to put parenthesis around plain constants.

> +
> +/*
> +** IRQs cascaded on CPU interrupt 4 (CAUSE bit 12, C_IRQ4)
> +** These defines should be tied to the register definitions for the CIC
> +** interrupt routine.  For now, just use hard-coded values.
> +*/
> +#define MSP_CIC_INTBASE         (MSP_MIPS_INTBASE + 8) 
> +#define MSP_INT_EXT0            (MSP_CIC_INTBASE + 0)   /* External interrupt 0         */
> +#define MSP_INT_EXT1            (MSP_CIC_INTBASE + 1)   /* External interrupt 1         */
> +#define MSP_INT_EXT2            (MSP_CIC_INTBASE + 2)   /* External interrupt 2         */
> +#define MSP_INT_EXT3            (MSP_CIC_INTBASE + 3)   /* External interrupt 3         */
> +#define MSP_INT_CPUIF           (MSP_CIC_INTBASE + 4)   /* CPU interface interrupt      */
> +#define MSP_INT_EXT4            (MSP_CIC_INTBASE + 5)   /* External interrupt 4         */
> +#define MSP_INT_CIC_USB         (MSP_CIC_INTBASE + 6)   /* Cascaded IRQ for USB         */
> +#define MSP_INT_MBOX		(MSP_CIC_INTBASE + 7)	/* Sec engine mailbox IRQ       */
> +#define MSP_INT_EXT5		(MSP_CIC_INTBASE + 8)	/* External interrupt 5         */
> +#define MSP_INT_TDM		(MSP_CIC_INTBASE + 9)	/* TDM interrupt                */
> +#define MSP_INT_CIC_MAC0        (MSP_CIC_INTBASE + 10)	/* Cascaded IRQ for MAC 0       */
> +#define MSP_INT_CIC_MAC1	(MSP_CIC_INTBASE + 11)	/* Cascaded IRQ for MAC 1       */
> +#define MSP_INT_CIC_SEC		(MSP_CIC_INTBASE + 12)	/* Cascaded IRQ for sec engine  */
> +#define	MSP_INT_PER 		(MSP_CIC_INTBASE + 13)	/* Peripheral interrupt         */
> +#define	MSP_INT_TIMER0	        (MSP_CIC_INTBASE + 14)	/* SLP timer 0                  */
> +#define	MSP_INT_TIMER1	        (MSP_CIC_INTBASE + 15)	/* SLP timer 1                  */
> +#define	MSP_INT_TIMER2	        (MSP_CIC_INTBASE + 16)	/* SLP timer 2                  */
> +#define	MSP_INT_VPE0_TIMER	(MSP_CIC_INTBASE + 17) 	/* VPE0 MIPS timer              */
> +#define MSP_INT_BLKCP 		(MSP_CIC_INTBASE + 18)  /* Block Copy                   */
> +#define MSP_INT_UART0		(MSP_CIC_INTBASE + 19)  /* UART 0                       */
> +#define MSP_INT_PCI		(MSP_CIC_INTBASE + 20)  /* PCI subsystem                */
> +#define MSP_INT_EXT6            (MSP_CIC_INTBASE + 21)  /* External interrupt 5         */
> +#define MSP_INT_PCI_MSI		(MSP_CIC_INTBASE + 22)  /* PCI Message Signal           */
> +#define MSP_INT_CIC_SAR		(MSP_CIC_INTBASE + 23)  /* Cascaded ADSL2+ SAR IRQ      */
> +#define MSP_INT_DSL		(MSP_CIC_INTBASE + 24)  /* ADSL2+ IRQ                   */
> +#define MSP_INT_CIC_ERR  	(MSP_CIC_INTBASE + 25)  /* SLP error condition          */
> +#define MSP_INT_VPE1_TIMER      (MSP_CIC_INTBASE + 26)  /* VPE1 MIPS timer              */
> +#define MSP_INT_VPE0_PC         (MSP_CIC_INTBASE + 27)  /* VPE0 Performance counter     */
> +#define MSP_INT_VPE1_PC         (MSP_CIC_INTBASE + 28)  /* VPE1 Performance counter     */
> +#define MSP_INT_EXT7		(MSP_CIC_INTBASE + 29)	/* External interrupt 5         */
> +#define MSP_INT_VPE0_SW         (MSP_CIC_INTBASE + 30)  /* VPE0 Software interrupt      */
> +#define MSP_INT_VPE1_SW         (MSP_CIC_INTBASE + 31)  /* VPE0 Software interrupt      */
> +
> +/* 
> +** IRQs cascaded on CIC PER interrupt (MSP_INT_PER)
> +*/
> +#define MSP_PER_INTBASE        (MSP_CIC_INTBASE + 32)
> +/* Reserved                                        0-1                                  */
> +#define MSP_INT_UART1		(MSP_PER_INTBASE + 2)  /* UART 1                       */
> +/* Reserved                                        3-5                                  */
> +#define MSP_INT_2WIRE		(MSP_PER_INTBASE + 6)  /* 2-wire                       */
> +#define MSP_INT_TM0		(MSP_PER_INTBASE + 7)  /* Peripheral timer block out 0 */
> +#define MSP_INT_TM1		(MSP_PER_INTBASE + 8)  /* Peripheral timer block out 1 */
> +/* Reserved                                         9                                   */
> +#define MSP_INT_SPRX		(MSP_PER_INTBASE + 10) /* SPI RX complete              */
> +#define MSP_INT_SPTX		(MSP_PER_INTBASE + 11) /* SPI TX complete              */
> +#define MSP_INT_GPIO		(MSP_PER_INTBASE + 12) /* GPIO                         */
> +#define MSP_INT_PER_ERR         (MSP_PER_INTBASE + 13) /* Peripheral error             */
> +/* Reserved                                       14-31                                 */
> +
> +#endif /* !(_MSP_CIC_INT_H) */
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_gpio_macros.h b/include/asm-mips/pmc-sierra/msp71xx/msp_gpio_macros.h
> new file mode 100644
> index 0000000..c188b50
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_gpio_macros.h
> @@ -0,0 +1,295 @@
> +/*
> + * $Id: msp_gpio_macros.h,v 1.4 2006/10/19 22:08:16 stjeanma Exp $

Another RCS string.

> + *
> + * Macros for external SMP-safe access to the PMC Athena (MSP7120) reference
> + * board GPIO pins
> + *
> + * Copyright 2005 PMC-Sierra, Inc.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __MSP_GPIO_MACROS_H__
> +#define __MSP_GPIO_MACROS_H__
> +
> +#include <asm/regops.h>
> +
> +#include <msp_regs.h>
> +
> +/* -- GPIO Enumerations -- */
> +typedef enum {
> +	MSP_GPIO_LO = 0,
> +	MSP_GPIO_HI = 1,
> +	MSP_GPIO_NONE,		/* Special - Means pin is out of range */
> +	MSP_GPIO_TOGGLE,	/* Special - Sets pin to opposite */
> +} msp_gpio_data_t;
> +
> +typedef enum {
> +	MSP_GPIO_INPUT		= 0x0,
> +	/* MSP_GPIO_ INTERRUPT	= 0x1,	Not supported yet */
> +	MSP_GPIO_UART_INPUT	= 0x2,	/* Only GPIO 4 or 5 */
> +	MSP_GPIO_OUTPUT		= 0x8,
> +	MSP_GPIO_UART_OUTPUT	= 0x9,	/* Only GPIO 2 or 3 */
> +	MSP_GPIO_PERIF_TIMERA	= 0x9,	/* Only GPIO 0 or 1 */
> +	MSP_GPIO_PERIF_TIMERB	= 0xa,	/* Only GPIO 0 or 1 */
> +	MSP_GPIO_UNKNOWN	= 0xb,  /* No such GPIO or mode */
> +} msp_gpio_mode_t;
> +
> +/* -- Static Tables -- */
> +
> +/* Maps pins to data register */
> +static volatile u32 * const MSP_GPIO_DATA_REGISTER[] = {
> +	/* GPIO 0 and 1 on the first register */
> +GPIO_DATA1_REG, GPIO_DATA1_REG,
> +	/* GPIO 2, 3, 4, and 5 on the second register */
> +	GPIO_DATA2_REG, GPIO_DATA2_REG, GPIO_DATA2_REG, GPIO_DATA2_REG,
> +	/* GPIO 6, 7, 8, and 9 on the third register */
> +	GPIO_DATA3_REG, GPIO_DATA3_REG, GPIO_DATA3_REG, GPIO_DATA3_REG,
> +	/* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
> +	GPIO_DATA4_REG, GPIO_DATA4_REG, GPIO_DATA4_REG, GPIO_DATA4_REG,
> +	GPIO_DATA4_REG, GPIO_DATA4_REG,
> +	/* GPIO 16, 17, 18, and 19 on the strange EXTENDED register */
> +	EXTENDED_GPIO_REG, EXTENDED_GPIO_REG,
> +	EXTENDED_GPIO_REG, EXTENDED_GPIO_REG,
> +};
> +
> +/* Maps pins to mode register */
> +static volatile u32 * const MSP_GPIO_MODE_REGISTER[] = {
> +	/* GPIO 0 and 1 on the first register */
> +	GPIO_CFG1_REG, GPIO_CFG1_REG,
> +	/* GPIO 2, 3, 4, and 5 on the second register */
> +	GPIO_CFG2_REG, GPIO_CFG2_REG, GPIO_CFG2_REG, GPIO_CFG2_REG,
> +	/* GPIO 6, 7, 8, and 9 on the third register */
> +	GPIO_CFG3_REG, GPIO_CFG3_REG, GPIO_CFG3_REG, GPIO_CFG3_REG,
> +	/* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
> +	GPIO_CFG4_REG, GPIO_CFG4_REG, GPIO_CFG4_REG, GPIO_CFG4_REG,
> +	GPIO_CFG4_REG, GPIO_CFG4_REG,
> +	/* GPIO 16, 17, 18, and 19 on the strange EXTENDED register */
> +	EXTENDED_GPIO_REG, EXTENDED_GPIO_REG,
> +	EXTENDED_GPIO_REG, EXTENDED_GPIO_REG,
> +};
> +
> +/* Maps 'basic' pins to relative offset from 0 per register */
> +static int MSP_GPIO_OFFSET[] = {
> +	/* GPIO 0 and 1 on the first register */
> +	0, 0,
> +	/* GPIO 2, 3, 4, and 5 on the second register */
> +	2, 2, 2, 2,
> +	/* GPIO 6, 7, 8, and 9 on the third register */
> +	6, 6, 6, 6,
> +	/* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
> +	10, 10, 10, 10, 10, 10,
> +};
> +
> +/* Maps MODE to allowed pin mask */
> +static unsigned int MSP_GPIO_MODE_ALLOWED[] = {
> +	0xfffff,	/* Mode 0 - INPUT */
> +	0x00000,	/* Mode 1 - INTERRUPT */
> +	0x00030,	/* Mode 2 - UART_INPUT (GPIO 4, 5)*/
> +	0, 0, 0, 0, 0,	/* Modes 3, 4, 5, 6, and 7 are reserved */
> +	0xfffff,	/* Mode 8 - OUTPUT */
> +	0x0000f,	/* Mode 9 - UART_OUTPUT/PERF_TIMERA (GPIO 0, 1, 2, 3) */
> +	0x00003,	/* Mode a - PERF_TIMERB (GPIO 0, 1) */
> +	0x00000,	/* Mode b - Not really a mode! */
> +};
> +
> +/* -- Bit masks -- */
> +
> +/* This gives you the 'register relative offlet gpio' number */
> +#define OFFSET_GPIO_NUMBER(gpio)	(gpio - MSP_GPIO_OFFSET[gpio])
> +
> +/* These take the 'register relative offset gpio' number */
> +#define BASIC_DATA_REG_MASK(ogpio)		(1 << ogpio)
> +#define BASIC_MODE_REG_VALUE(mode, ogpio)	(mode << BASIC_MODE_REG_SHIFT(ogpio))
> +#define BASIC_MODE_REG_MASK(ogpio)		BASIC_MODE_REG_VALUE(0xf, ogpio)
> +#define BASIC_MODE_REG_SHIFT(ogpio)		(ogpio * 4)
> +#define BASIC_MODE_REG_FROM_REG(data, ogpio)	((data & BASIC_MODE_REG_MASK(ogpio)) >> BASIC_MODE_REG_SHIFT(ogpio))
> +
> +/* These take the actual GPIO number (0 through 15) */
> +#define BASIC_DATA_MASK(gpio)	BASIC_DATA_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_MASK(gpio)	BASIC_MODE_REG_MASK(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE(mode, gpio)	BASIC_MODE_REG_VALUE(mode, OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_SHIFT(gpio)	BASIC_MODE_REG_SHIFT(OFFSET_GPIO_NUMBER(gpio))
> +#define BASIC_MODE_FROM_REG(data, gpio)	BASIC_MODE_REG_FROM_REG(data,OFFSET_GPIO_NUMBER(gpio))
> +
> +/* This gives you the 'register relative offset gpio' number */
> +#define EXTENDED_OFFSET_GPIO(gpio)	(gpio - 16)
> +
> +/* These take the 'register relative offset gpio' number */
> +#define EXTENDED_REG_DISABLE(ogpio)	(0x2 << ((ogpio * 2) + 16))
> +#define EXTENDED_REG_ENABLE(ogpio)	(0x1 << ((ogpio * 2) + 16))
> +#define EXTENDED_REG_SET(ogpio)		(0x2 << (ogpio * 2))
> +#define EXTENDED_REG_CLR(ogpio)		(0x1 << (ogpio * 2))
> +
> +/* These take the actual GPIO number (16 through 19) */
> +#define EXTENDED_DISABLE(gpio)	EXTENDED_REG_DISABLE( EXTENDED_OFFSET_GPIO(gpio) )
> +#define EXTENDED_ENABLE(gpio)	EXTENDED_REG_ENABLE( EXTENDED_OFFSET_GPIO(gpio) )
> +#define EXTENDED_SET(gpio)	EXTENDED_REG_SET( EXTENDED_OFFSET_GPIO(gpio) )
> +#define EXTENDED_CLR(gpio)	EXTENDED_REG_CLR( EXTENDED_OFFSET_GPIO(gpio) )
> +
> +#define EXTENDED_FULL_MASK		(0xffffffff)
> +
> +/* -- API inline-functions -- */
> +
> +/*
> + * Gets the current value of the specified pin
> + */
> +static inline msp_gpio_data_t msp_gpio_pin_get( unsigned int gpio )
> +{
> +	u32 pinhi_mask = 0, pinhi_mask2 = 0;
> +
> +	if( gpio >= 20 )
> +		return MSP_GPIO_NONE;
> +
> +	if( gpio < 16 ) {
> +		pinhi_mask = BASIC_DATA_MASK(gpio);
> +	} else {
> +		/*
> +		 * Two cases are possible with the EXTENDED register:
> +		 *  - In output mode (ENABLED flag set), check the CLR bit
> +		 *  - In input mode (ENABLED flag not set), check the SET bit
> +		 */
> +		pinhi_mask = EXTENDED_ENABLE(gpio) |
> +				EXTENDED_CLR(gpio);
> +		pinhi_mask2 = EXTENDED_SET(gpio);
> +	}
> +	if( (*MSP_GPIO_DATA_REGISTER[gpio] & pinhi_mask) ||
> +		(*MSP_GPIO_DATA_REGISTER[gpio] & pinhi_mask2) )
> +		return MSP_GPIO_HI;
> +	else
> +		return MSP_GPIO_LO;
> +}
> +
> +/* Sets the specified pin to the specified value */
> +static inline void msp_gpio_pin_set( msp_gpio_data_t data, unsigned int gpio )
> +{
> +	if( gpio >= 20 )
> +		return;
> +
> +	if( gpio < 16 ) {
> +		if( data == MSP_GPIO_TOGGLE )
> +			toggle_reg32( MSP_GPIO_DATA_REGISTER[gpio],
> +					BASIC_DATA_MASK(gpio) );
> +		else if( data == MSP_GPIO_HI )
> +			set_reg32( MSP_GPIO_DATA_REGISTER[gpio],
> +					BASIC_DATA_MASK(gpio) );
> +		else
> +			clear_reg32( MSP_GPIO_DATA_REGISTER[gpio],
> +					BASIC_DATA_MASK(gpio) );
> +	} else {
> +		if( data == MSP_GPIO_TOGGLE ) {
> +			/* Special ugly case:
> +			 *   We have to read the CLR bit.
> +			 *   If set, we write the CLR bit.
> +			 *   If not, we write the SET bit.
> +			 */
> +			u32 tmpdata;
> +			custom_reg32_read( MSP_GPIO_DATA_REGISTER[gpio], tmpdata );
> +			if( tmpdata & EXTENDED_CLR(gpio) )
> +				tmpdata = EXTENDED_CLR(gpio);
> +			else
> +				tmpdata = EXTENDED_SET(gpio);
> +			custom_reg32_write( MSP_GPIO_DATA_REGISTER[gpio], tmpdata );
> +		} else {
> +			u32 newdata;
> +			if( data == MSP_GPIO_HI )
> +				newdata = EXTENDED_SET(gpio);
> +			else
> +				newdata = EXTENDED_CLR(gpio);
> +			set_value_reg32( MSP_GPIO_DATA_REGISTER[gpio], EXTENDED_FULL_MASK, newdata );
> +		}
> +	}
> +}
> +
> +/* Sets the specified pin to the specified value */
> +static inline void msp_gpio_pin_hi( unsigned int gpio )
> +{
> +	msp_gpio_pin_set( MSP_GPIO_HI, gpio );
> +}
> +
> +/* Sets the specified pin to the specified value */
> +static inline void msp_gpio_pin_lo( unsigned int gpio )
> +{
> +	msp_gpio_pin_set( MSP_GPIO_LO, gpio );
> +}
> +
> +/* Sets the specified pin to the opposite value */
> +static inline void msp_gpio_pin_toggle( unsigned int gpio )
> +{
> +	msp_gpio_pin_set( MSP_GPIO_TOGGLE, gpio );
> +}
> +
> +/* Gets the mode of the specified pin */
> +static inline msp_gpio_mode_t msp_gpio_pin_get_mode( unsigned int gpio )
> +{
> +	msp_gpio_mode_t retval = MSP_GPIO_UNKNOWN;
> +	uint32_t data;
> +
> +	if( gpio >= 20 )
> +		return retval;
> +
> +	data = *MSP_GPIO_MODE_REGISTER[gpio];
> +
> +	if( gpio < 16 ) {
> +		retval = BASIC_MODE_FROM_REG(data, gpio);
> +	} else {
> +		/* Extended pins can only be either INPUT or OUTPUT */
> +		if( data & EXTENDED_ENABLE(gpio) )
> +			retval = MSP_GPIO_OUTPUT;
> +		else
> +			retval = MSP_GPIO_INPUT;
> +	}
> +
> +	return retval;
> +}
> +
> +/*
> + * Sets the specified mode on the requested pin
> + * Returns 0 on success, or -1 if that mode is not allowed on this pin
> + */
> +static inline int msp_gpio_pin_mode( msp_gpio_mode_t mode, unsigned int gpio )
> +{
> +	u32 modemask, newmode;
> +
> +	if( (1 << gpio) & ~MSP_GPIO_MODE_ALLOWED[mode] )
> +		return -1;
> +
> +	if( gpio >= 20 )
> +		return -1;
> +
> +	if( gpio < 16 ) {
> +		modemask = BASIC_MODE_MASK(gpio);
> +		newmode =  BASIC_MODE(mode, gpio);
> +	} else {
> +		modemask = EXTENDED_FULL_MASK;
> +		if( mode == MSP_GPIO_INPUT )
> +			newmode = EXTENDED_DISABLE(gpio);
> +		else
> +			newmode = EXTENDED_ENABLE(gpio);
> +	}
> +	
> +	/* Do the set atomically */
> +	set_value_reg32( MSP_GPIO_MODE_REGISTER[gpio], modemask, newmode );
> +
> +	return 0;
> +}
> +
> +#endif /* __MSP_GPIO_MACROS_H__ */
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_int.h
> new file mode 100644
> index 0000000..e5a64d3
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_int.h
> @@ -0,0 +1,44 @@
> +/*
> + * Andrew Hughes, Andrew_Hughes@pmc-sierra.com
> + * Copyright (C) 2005, PMC-Sierra, Inc.  All rights reserved.
> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + * Defines for the MSP interrupt handlers.
> + *
> + */
> +#ifndef _MSP_INT_H
> +#define _MSP_INT_H
> +
> +/* The PMC-Sierra MSP product line has at least two different interrupt
> +** controllers, the SLP register based scheme and the CIC interrupt
> +** controller block mechanism.  This file distinguishes between them
> +** so that devices see a uniform interface.
> +*/
> +
> +#if defined(CONFIG_IRQ_MSP_SLP)
> +        #include "msp_slp_int.h"
> +
> +#elif defined(CONFIG_IRQ_MSP_CIC)
> +        #include "msp_cic_int.h"
> +
> +#else
> +        #error "What sort of interrupt controller does *your* MSP have?"
> +#endif
> +
> +#endif /* !(_MSP_INT_H) */
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h b/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h
> new file mode 100644
> index 0000000..931fee9
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_prom.h
> @@ -0,0 +1,185 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + * MIPS boards bootprom interface for the Linux kernel.
> + *
> + */
> +
> +#ifndef _ASM_MSP_PROM_H
> +#define _ASM_MSP_PROM_H
> +
> +#include <linux/types.h>
> +
> +#define DEVICEID			"deviceid"
> +#define FEATURES			"features"
> +#define PROM_ENV			"prom_env"
> +#define PROM_ENV_FILE		"/proc/"PROM_ENV
> +#define PROM_ENV_SIZE		256
> +
> +#define CPU_DEVID_FAMILY		(0x0000ff00)
> +#define CPU_DEVID_REVISION		(0x000000ff)
> +
> +#define FPGA_IS_POLO(revision)		(((revision >= 0xb0) && (revision < 0xd0)))
> +#define FPGA_IS_5000(revision)		((revision >= 0x80) && (revision <= 0x90))
> +#define	FPGA_IS_ZEUS(revision)		((revision < 0x7f))
> +#define FPGA_IS_DUET(revision)		(((revision >= 0xa0) && (revision < 0xb0)))
> +#define FPGA_IS_MSP4200(revision)	((revision >= 0xd0))
> +#define FPGA_IS_MSP7100(revision)	((revision >= 0xd0))
> +
> +#define MACHINE_TYPE_POLO			"POLO"
> +#define MACHINE_TYPE_DUET			"DUET"
> +#define	MACHINE_TYPE_ZEUS			"ZEUS"
> +#define MACHINE_TYPE_MSP2000REVB	"MSP2000REVB"
> +#define MACHINE_TYPE_MSP5000		"MSP5000"
> +#define MACHINE_TYPE_MSP4200		"MSP4200"
> +#define MACHINE_TYPE_MSP7120		"MSP7120"
> +#define MACHINE_TYPE_MSP7130		"MSP7130"
> +#define MACHINE_TYPE_OTHER			"OTHER"
> +
> +#define MACHINE_TYPE_POLO_FPGA			"POLO-FPGA"
> +#define MACHINE_TYPE_DUET_FPGA			"DUET-FPGA"
> +#define	MACHINE_TYPE_ZEUS_FPGA			"ZEUS_FPGA"
> +#define MACHINE_TYPE_MSP2000REVB_FPGA	"MSP2000REVB-FPGA"
> +#define MACHINE_TYPE_MSP5000_FPGA		"MSP5000-FPGA"
> +#define MACHINE_TYPE_MSP4200_FPGA		"MSP4200-FPGA"
> +#define MACHINE_TYPE_MSP7100_FPGA		"MSP7100-FPGA"
> +#define MACHINE_TYPE_OTHER_FPGA			"OTHER-FPGA"
> +
> +/* Device Family definitions */
> +#define FAMILY_FPGA				0x0000
> +#define FAMILY_ZEUS				0x1000
> +#define FAMILY_POLO				0x2000
> +#define FAMILY_DUET				0x4000
> +#define FAMILY_TRIAD			0x5000
> +#define FAMILY_MSP4200			0x4200
> +#define FAMILY_MSP4200_FPGA		0x4f00
> +#define FAMILY_MSP7100			0x7100
> +#define FAMILY_MSP7100_FPGA		0x7f00
> +
> +/* Device Type definitions */
> +#define TYPE_MSP7120			0x7120
> +#define TYPE_MSP7130			0x7130
> +
> +#define ENET_KEY		'E'
> +#define ENETTXD_KEY		'e'
> +#define PCI_KEY			'P'
> +#define PCIMUX_KEY		'p'
> +#define SEC_KEY			'S'
> +#define SPAD_KEY		'D'
> +#define TDM_KEY			'T'
> +#define ZSP_KEY			'Z'
> +
> +#define FEATURE_NOEXIST		'-'
> +#define FEATURE_EXIST		'+'
> +
> +#define ENET_MII		'M'
> +#define ENET_RMII		'R'
> +
> +#define	ENETTXD_FALLING		'F'
> +#define ENETTXD_RISING		'R'
> +
> +#define PCI_HOST		'H'
> +#define PCI_PERIPHERAL		'P'
> +
> +#define PCIMUX_FULL		'F'
> +#define PCIMUX_SINGLE		'S'
> +
> +#define SEC_DUET		'D'
> +#define SEC_POLO		'P'
> +#define SEC_SLOW		'S'
> +#define SEC_TRIAD		'T'
> +
> +#define SPAD_POLO		'P'
> +
> +#define TDM_DUET		'D'		/* DUET TDMs might exist */
> +#define TDM_POLO		'P'		/* POLO TDMs might exist */
> +#define TDM_TRIAD		'T'		/* TRIAD TDMs might exist */
> +
> +#define ZSP_DUET		'D'		/* one DUET zsp engine */
> +#define ZSP_TRIAD		'T'		/* two TRIAD zsp engines */
> +
> +extern char *prom_getcmdline(void);
> +extern char *prom_getenv(char *name);
> +extern void prom_printf_setup(int tty_no);
> +extern void prom_printf(char *fmt, ...);
> +extern void prom_init_cmdline(void);
> +extern void prom_meminit(void);
> +extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
> +
> +extern unsigned long identify_family(void);
> +extern unsigned long identify_revision(void);
> +
> +extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
> +extern unsigned long getdeviceid(void);
> +extern char identify_enet(unsigned long interfaceNum);
> +extern char identify_enetTxD(unsigned long interfaceNum);
> +extern char identify_pci(void);
> +extern char identify_sec(void);
> +extern char identify_spad(void);
> +extern char identify_sec(void);
> +extern char identify_tdm(void);
> +extern char identify_zsp(void);
> +
> +#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
> +extern bool get_ramroot(void **start, unsigned long *size);
> +#endif
> +
> +/*
> + * The following macro calls prom_printf and puts the format string
> + * into an init section so it can be reclaimed.
> + */
> +#define ppfinit(f, x...) do { static char _f[] __initdata = f; \
> +        prom_printf(_f, ## x); } while (0)
> +
> +#ifdef __KERNEL__

This is a a non-exported kernel header file, so there is no sense in
protecting things with __KERNEL__ as this symbol will always be defined.

> +/* Memory descriptor management. */
> +#define PROM_MAX_PMEMBLOCKS    7	/* 6 used */
> +
> +
> +enum yamon_memtypes {
> +        yamon_dontuse,
> +        yamon_prom,
> +        yamon_free,
> +};

Eh..  I thought you're using PMON?

> +
> +struct prom_pmemblock {
> +        unsigned long base; /* Within KSEG0. */
> +        unsigned int size;  /* In bytes. */
> +        unsigned int type;  /* free or prom memory */
> +};
> +
> +extern int prom_argc;
> +extern char **prom_argv;
> +extern char **prom_envp;
> +extern int *prom_vec;
> +extern struct prom_pmemblock	*prom_getmdesc(void);
> +#endif
> +
> +/* PRId bit mask for Major/Minor/Patch level */
> +#define PRID_BITMSK_REV   0xff
> +
> +/* PRId register's Revision value for 34K RTL rev. 1.0.2 */
> +#define PRID_REV_RTL_1_0_2 0x22
> +
> +/* Config 7 register field definitions */
> +#define CONFIG7_BITMSK_RPS 0x00000004
> +
> +#endif /* _ASM_MSP_PROM_H) */
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
> new file mode 100644
> index 0000000..ded1098
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_regs.h
> @@ -0,0 +1,481 @@
> +/*
> +** Andrew Hughes, Andrew_Hughes@pmc-sierra.com
> +** Copyright (C) 2005 PMC-Sierra, Inc.  All rights reserved.
> +**
> +** ########################################################################
> +**
> +**  This program is free software; you can distribute it and/or modify it
> +**  under the terms of the GNU General Public License (Version 2) as
> +**  published by the Free Software Foundation.
> +**
> +**  This program is distributed in the hope it will be useful, but WITHOUT
> +**  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +**  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +**  for more details.
> +**
> +**  You should have received a copy of the GNU General Public License along
> +**  with this program; if not, write to the Free Software Foundation, Inc.,
> +**  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> +**
> +** ########################################################################
> +**
> +**
> +** Defines for the address space, registers and register configuration
> +** (bit masks, access macros etc) for the PMC-Sierra line of MSP products.
> +** This file contains addess maps for all the devices in the line of products
> +** but only has register definitions and configuration masks for registers
> +** which aren't definitely associated with any device.  Things like clock
> +** settings, reset access, the ELB etc.  Individual device drivers will
> +** reference the appropriate XXX_BASE value defined here and have individual
> +** registers offset from that.
> +**
> +*/
> +
> +#include <asm/addrspace.h>
> +#include <linux/types.h>
> +
> +#ifndef _ASM_MSP_REGS_H
> +#define _ASM_MSP_REGS_H
> +
> +
> +/*
> +**
> +** ########################################################################
> +** #  Address space and device base definitions                           #
> +** ########################################################################
> +**
> +*/
> +
> +/***************************************************************************/
> +/* System Logic and Peripherals (ELB, UART0, etc) device address space     */
> +/***************************************************************************/
> +#define MSP_SLP_BASE            (0x1c000000)            /* System Logic and Peripherals */
> +
> +#define MSP_WTIMER_BASE         (MSP_SLP_BASE + 0x04C) /* watchdog timer base    */
> +#define MSP_ITIMER_BASE         (MSP_SLP_BASE + 0x054) /* internal timer base    */
> +#define MSP_UART0_BASE          (MSP_SLP_BASE + 0x100) /* UART0 controller base         */
> +#define MSP_BCPY_CTRL_BASE      (MSP_SLP_BASE + 0x120) /* Block Copy controller base    */
> +#define MSP_BCPY_DESC_BASE      (MSP_SLP_BASE + 0x160) /* Block Copy descriptor base    */
> +
> +/***************************************************************************/
> +/* PCI address space                                                       */
> +/***************************************************************************/
> +#define MSP_PCI_BASE    (0x19000000)
> +
> +/***************************************************************************/
> +/* MSbus device address space                                              */
> +/***************************************************************************/
> +#define MSP_MSB_BASE            (0x18000000)                  /* MSbus address start            */
> +
> +#define MSP_PER_BASE            (MSP_MSB_BASE + 0x400000)     /* Peripheral device registers    */
> +#define MSP_MAC0_BASE           (MSP_MSB_BASE + 0x600000)     /* MAC A device registers         */
> +#define MSP_MAC1_BASE           (MSP_MSB_BASE + 0x700000)     /* MAC B device registers         */
> +#define MSP_SEC_BASE            (MSP_MSB_BASE + 0x800000)     /* Security Engine registers      */
> +#define MSP_MAC2_BASE           (MSP_MSB_BASE + 0x900000)     /* MAC C device registers         */
> +#define MSP_ADSL2_BASE          (MSP_MSB_BASE + 0xA80000)     /* ADSL2 device registers */
> +#define MSP_USB_BASE            (MSP_MSB_BASE + 0xB40000)     /* USB device registers */
> +#define MSP_USB_BASE_START      (MSP_MSB_BASE + 0xB40100)     /* USB device registers */
> +#define MSP_USB_BASE_END        (MSP_MSB_BASE + 0xB401FF)     /* USB device registers */
> +#define MSP_CPUIF_BASE          (MSP_MSB_BASE + 0xC00000)     /* CPU interface registers        */
> +
> +/* Devices within the MSbus peripheral block */
> +#define MSP_UART1_BASE          (MSP_PER_BASE + 0x030)        /* UART1 controller base          */
> +#define MSP_SPI_BASE            (MSP_PER_BASE + 0x058)        /* SPI/MPI control registers      */
> +#define MSP_TWI_BASE            (MSP_PER_BASE + 0x090)        /* Two-wire control registers     */
> +#define MSP_PTIMER_BASE         (MSP_PER_BASE + 0x0F0)        /* Programmable timer control     */
> +
> +/***************************************************************************/
> +/* Physical Memory configuration address space                             */
> +/***************************************************************************/
> +#define MSP_MEM_CFG_BASE (0x17f00000)
> +
> +#define MSP_MEM_INDIRECT_CTL_10	(0x10)
> +
> +/*
> + * Notes:
> + *  1) The SPI registers are split into two blocks, one offset from the
> + *     MSP_SPI_BASE by 0x00 and the other offset from the MSP_SPI_BASE by
> + *     0x68.  The SPI driver definitions for the register must be aware
> + *     of this.
> + *  2) The block copy engine register are divided into two regions, one
> + *     for the control/configuration of the engine proper and one for the
> + *     values of the descriptors used in the copy process.  These have
> + *     different base defines (CTRL_BASE vs DESC_BASE)
> + *  3) These constants are for physical addresses which means that they
> + *     work correctly with "ioremap" and friends.  This means that device
> + *     drivers will need to remap these addresses using ioremap and perhaps
> + *     the readw/writew macros.  Or they could use the regptr() macro defined
> + *     below, but the readw/writew calls are the correct thing.
> + *  4) The UARTs have an additional status register offset from the base
> + *     address.  This register isn't used in the standard 8250 driver but
> + *     may be used in other software.  Consult the hardware datasheet for
> + *     offset details.
> + *  5) For some unknown reason the security engine (MSP_SEC_BASE) registers
> + *     start at an offset of 0x84 from the base address but the block of
> + *     registers before this is reserved for the security engine.  The driver
> + *     will have to be aware of this but it makes the register definitions
> + *     line up better with the documentation.
> + */
> +
> +/*
> +** 
> +** ########################################################################
> +** #  System register definitions.  Not associated with a specific device #
> +** ########################################################################
> +**
> +*/
> +
> +/* This macro maps the physical register number into uncached space
> + * and (for C code) casts it into a u32 pointer so it can be dereferenced
> + * Normally these would be accessed with ioremap and readX/writeX, but these
> + * are convenient for a lot of internal kernel code.
> + */
> +#ifdef __ASSEMBLER__
> +        #define regptr(addr) (KSEG1ADDR(addr))
> +#else
> +        #define regptr(addr) ((volatile u32 * const)(KSEG1ADDR(addr)))
> +#endif
> +
> +/***************************************************************************/
> +/* System Logic and Peripherals (RESET, ELB, etc) registers                */
> +/***************************************************************************/
> +
> +/* System Control register definitions */
> +#define	DEV_ID_REG	regptr(MSP_SLP_BASE + 0x00)   /* Device-ID Register     RO */
> +#define	FWR_ID_REG	regptr(MSP_SLP_BASE + 0x04)   /* Firmware-ID Register   RW */
> +#define	SYS_ID_REG0	regptr(MSP_SLP_BASE + 0x08)   /* System-ID Register-0   RW */
> +#define	SYS_ID_REG1	regptr(MSP_SLP_BASE + 0x0C)   /* System-ID Register-1   RW */
> +
> +/* System Reset register definitions */
> +#define	RST_STS_REG	regptr(MSP_SLP_BASE + 0x10)   /* System Reset Status Register   RO */
> +#define	RST_SET_REG	regptr(MSP_SLP_BASE + 0x14)   /* System Set Reset Register      WO */
> +#define	RST_CLR_REG	regptr(MSP_SLP_BASE + 0x18)   /* System Clear Reset Register    WO */
> +
> +/* System Clock Registers */
> +#define PCI_SLP_REG     regptr(MSP_SLP_BASE + 0x1C)   /* PCI clock generator Register R/W */
> +#define URT_SLP_REG     regptr(MSP_SLP_BASE + 0x20)   /* UART clock generator Register            R/W */
> +/* reserved                   (MSP_SLP_BASE + 0x24)                                                   */
> +/* reserved                   (MSP_SLP_BASE + 0x28)                                                   */
> +#define PLL1_SLP_REG    regptr(MSP_SLP_BASE + 0x2C)   /* PLL1 clock generator Register            R/W */
> +#define PLL0_SLP_REG    regptr(MSP_SLP_BASE + 0x30)   /* PLL0 clock generator Register            R/W */
> +#define MIPS_SLP_REG    regptr(MSP_SLP_BASE + 0x34)   /* MIPS clock generator Register            R/W */
> +#define	VE_SLP_REG	regptr(MSP_SLP_BASE + 0x38)   /* Voice Engine clock generator Register    R/W */
> +/* reserved                   (MSP_SLP_BASE + 0x3C)                                                   */
> +#define MSB_SLP_REG     regptr(MSP_SLP_BASE + 0x40)   /* MS-Bus clock generator                   R/W */
> +#define SMAC_SLP_REG    regptr(MSP_SLP_BASE + 0x44)   /* Sec & MAC clock generator                R/W */
> +#define PERF_SLP_REG    regptr(MSP_SLP_BASE + 0x48)   /* Peripheral & TDM clock generator         R/W */
> +
> +/* Interrupt Controller Registers */
> +#define SLP_INT_STS_REG regptr(MSP_SLP_BASE + 0x70)   /* Interrupt status register    R/W */
> +#define SLP_INT_MSK_REG regptr(MSP_SLP_BASE + 0x74)   /* Interrupt enable/mask register    R/W */
> +#define SE_MBOX_REG     regptr(MSP_SLP_BASE + 0x78)   /* Security Engine mailbox register R/W */
> +#define VE_MBOX_REG     regptr(MSP_SLP_BASE + 0x7C)   /* Voice Engine mailbox register    R/W */
> +
> +/* ELB Controller Registers */
> +#define CS0_CNFG_REG    regptr(MSP_SLP_BASE + 0x80)  /* ELB CS0 Configuration Reg    */
> +#define CS0_ADDR_REG    regptr(MSP_SLP_BASE + 0x84)  /* ELB CS0 Base Address Reg     */
> +#define CS0_MASK_REG    regptr(MSP_SLP_BASE + 0x88)  /* ELB CS0 Mask Register        */
> +#define CS0_ACCESS_REG  regptr(MSP_SLP_BASE + 0x8C)  /* ELB CS0 access register      */
> +
> +#define CS1_CNFG_REG    regptr(MSP_SLP_BASE + 0x90)  /* ELB CS1 Configuration Reg    */
> +#define CS1_ADDR_REG    regptr(MSP_SLP_BASE + 0x94)  /* ELB CS1 Base Address Reg     */
> +#define CS1_MASK_REG    regptr(MSP_SLP_BASE + 0x98)  /* ELB CS1 Mask Register        */
> +#define CS1_ACCESS_REG  regptr(MSP_SLP_BASE + 0x9C)  /* ELB CS1 access register      */
> +
> +#define CS2_CNFG_REG    regptr(MSP_SLP_BASE + 0xA0)  /* ELB CS2 Configuration Reg    */
> +#define CS2_ADDR_REG    regptr(MSP_SLP_BASE + 0xA4)  /* ELB CS2 Base Address Reg     */
> +#define CS2_MASK_REG    regptr(MSP_SLP_BASE + 0xA8)  /* ELB CS2 Mask Register        */
> +#define CS2_ACCESS_REG  regptr(MSP_SLP_BASE + 0xAC)  /* ELB CS2 access register      */
> +
> +#define CS3_CNFG_REG    regptr(MSP_SLP_BASE + 0xB0)  /* ELB CS3 Configuration Reg    */
> +#define CS3_ADDR_REG    regptr(MSP_SLP_BASE + 0xB4)  /* ELB CS3 Base Address Reg     */
> +#define CS3_MASK_REG    regptr(MSP_SLP_BASE + 0xB8)  /* ELB CS3 Mask Register        */
> +#define CS3_ACCESS_REG  regptr(MSP_SLP_BASE + 0xBC)  /* ELB CS3 access register      */
> +
> +#define CS4_CNFG_REG    regptr(MSP_SLP_BASE + 0xC0)  /* ELB CS4 Configuration Reg    */
> +#define CS4_ADDR_REG    regptr(MSP_SLP_BASE + 0xC4)  /* ELB CS4 Base Address Reg     */
> +#define CS4_MASK_REG    regptr(MSP_SLP_BASE + 0xC8)  /* ELB CS4 Mask Register        */
> +#define CS4_ACCESS_REG  regptr(MSP_SLP_BASE + 0xCC)  /* ELB CS4 access register      */
> +
> +#define CS5_CNFG_REG    regptr(MSP_SLP_BASE + 0xD0)  /* ELB CS5 Configuration Reg    */
> +#define CS5_ADDR_REG    regptr(MSP_SLP_BASE + 0xD4)  /* ELB CS5 Base Address Reg     */
> +#define CS5_MASK_REG    regptr(MSP_SLP_BASE + 0xD8)  /* ELB CS5 Mask Register        */
> +#define CS5_ACCESS_REG  regptr(MSP_SLP_BASE + 0xDC)  /* ELB CS5 access register      */
> +
> +/* reserved                            0xE0 - 0xE8                                   */
> +#define ELB_1PC_EN_REG  regptr(MSP_SLP_BASE + 0xEC)  /* ELB single PC card detect    */
> +
> +/* reserved                            0xF0 - 0xF8                                   */
> +#define ELB_CLK_CFG_REG regptr(MSP_SLP_BASE + 0xFC)  /* SDRAM read/ELB timing Reg    */
> +
> +/* Extended UART status registers */
> +#define UART0_STATUS_REG regptr(MSP_UART0_BASE + 0x0c0)
> +#define UART1_STATUS_REG regptr(MSP_UART1_BASE + 0x170)
> +
> +/* Performance monitoring registers */
> +#define PERF_MON_CTRL_REG       regptr(MSP_SLP_BASE + 0x140)    /* Performance monitor control reg */
> +#define PERF_MON_CLR_REG        regptr(MSP_SLP_BASE + 0x144)    /* Performance monitor clear reg */
> +#define PERF_MON_CNTH_REG       regptr(MSP_SLP_BASE + 0x148)    /* Performance monitor counter high */
> +#define PERF_MON_CNTL_REG       regptr(MSP_SLP_BASE + 0x14C)    /* Performance monitor counter low */
> +
> +/* System control registers */
> +#define SYS_CTRL_REG       regptr(MSP_SLP_BASE + 0x150)    /* System control register */
> +#define SYS_ERR1_REG       regptr(MSP_SLP_BASE + 0x154)    /* System Error status 1 */
> +#define SYS_ERR2_REG       regptr(MSP_SLP_BASE + 0x158)    /* System Error status 2 */
> +#define SYS_INT_CFG_REG    regptr(MSP_SLP_BASE + 0x15C)    /* System Interrupt configuration */
> +
> +/* Voice Engine Memory configuration */
> +#define VE_MEM_REG      regptr(MSP_SLP_BASE + 0x17C) /* Voice engine memory configuration */
> +
> +/* CPU/SLP Error Status registers */
> +#define CPU_ERR1_REG      regptr(MSP_SLP_BASE + 0x180) /* CPU/SLP Error status 1 */
> +#define CPU_ERR2_REG      regptr(MSP_SLP_BASE + 0x184) /* CPU/SLP Error status 1 */
> +
> +#define EXTENDED_GPIO_REG	regptr(MSP_SLP_BASE + 0x188)	/* Extended GPIO
> +								   register */
> +
> +/* System Error registers */
> +#define SLP_ERR_STS_REG      regptr(MSP_SLP_BASE + 0x190) /* Interrupt status for SLP errors */
> +#define SLP_ERR_MSK_REG      regptr(MSP_SLP_BASE + 0x194) /* Interrupt mask for SLP errors */
> +#define SLP_ELB_ERST_REG     regptr(MSP_SLP_BASE + 0x198) /* External ELB reset */
> +#define SLP_BOOT_STS_REG     regptr(MSP_SLP_BASE + 0x19C) /* Boot Status */
> +
> +/* Extended ELB addressing */
> +#define CS0_EXT_ADDR_REG     regptr(MSP_SLP_BASE + 0x1A0) /* CS0 Extended address */
> +#define CS1_EXT_ADDR_REG     regptr(MSP_SLP_BASE + 0x1A4) /* CS1 Extended address */
> +#define CS2_EXT_ADDR_REG     regptr(MSP_SLP_BASE + 0x1A8) /* CS2 Extended address */
> +#define CS3_EXT_ADDR_REG     regptr(MSP_SLP_BASE + 0x1AC) /* CS3 Extended address */
> +/* reserved                                        0x1B0                          */  
> +#define CS5_EXT_ADDR_REG     regptr(MSP_SLP_BASE + 0x1B4) /* CS5 Extended address */
> +
> +
> +/* PLL Adjustment registers */
> +#define PLL_LOCK_REG      regptr(MSP_SLP_BASE + 0x200) /* PLL0 lock status */
> +#define PLL_ARST_REG      regptr(MSP_SLP_BASE + 0x204) /* PLL Analog reset status */
> +#define PLL0_ADJ_REG      regptr(MSP_SLP_BASE + 0x208) /* PLL0 Adjustment value */
> +#define PLL1_ADJ_REG      regptr(MSP_SLP_BASE + 0x20C) /* PLL1 Adjustment value */
> +
> +/***************************************************************************/
> +/* Peripheral Register definitions                                         */
> +/***************************************************************************/
> +
> +/* Peripheral status */
> +#define PER_CTRL_REG           regptr(MSP_PER_BASE + 0x50)   /* Peripheral control register */
> +#define PER_STS_REG            regptr(MSP_PER_BASE + 0x54)   /* Peripheral status register */
> +
> +/* SPI/MPI Registers */
> +#define SMPI_TX_SZ_REG         regptr(MSP_PER_BASE + 0x58)   /* SPI/MPI Tx Size register */
> +#define SMPI_RX_SZ_REG         regptr(MSP_PER_BASE + 0x5C)   /* SPI/MPI Rx Size register */
> +#define SMPI_CTL_REG           regptr(MSP_PER_BASE + 0x60)   /* SPI/MPI Control register */
> +#define SMPI_MS_REG            regptr(MSP_PER_BASE + 0x64)   /* SPI/MPI Chip Select reg */
> +#define SMPI_CORE_DATA_REG     regptr(MSP_PER_BASE + 0xC0)   /* SPI/MPI Core Data reg */
> +#define SMPI_CORE_CTRL_REG     regptr(MSP_PER_BASE + 0xC4)   /* SPI/MPI Core Control reg */
> +#define SMPI_CORE_STAT_REG     regptr(MSP_PER_BASE + 0xC8)   /* SPI/MPI Core Status reg */
> +#define SMPI_CORE_SSEL_REG     regptr(MSP_PER_BASE + 0xCC)   /* SPI/MPI Core Ssel reg */
> +#define SMPI_FIFO_REG          regptr(MSP_PER_BASE + 0xD0)   /* SPI/MPI Data FIFO reg */
> +
> +/* Peripheral Block Error Registers           */
> +#define PER_ERR_STS_REG        regptr(MSP_PER_BASE + 0x70)   /* Error Bit Status Register */
> +#define PER_ERR_MSK_REG        regptr(MSP_PER_BASE + 0x74)   /* Error Bit Mask Register */
> +#define PER_HDR1_REG           regptr(MSP_PER_BASE + 0x78)   /* Error Header 1 Register */
> +#define PER_HDR2_REG           regptr(MSP_PER_BASE + 0x7C)   /* Error Header 2 Register */
> +
> +/* Peripheral Block Interrupt Registers       */
> +#define PER_INT_STS_REG        regptr(MSP_PER_BASE + 0x80)   /* Interrupt status register */
> +#define PER_INT_MSK_REG        regptr(MSP_PER_BASE + 0x84)   /* Interrupt Mask Register */
> +#define GPIO_INT_STS_REG       regptr(MSP_PER_BASE + 0x88)   /* GPIO interrupt status reg */
> +#define GPIO_INT_MSK_REG       regptr(MSP_PER_BASE + 0x8C)   /* GPIO interrupt MASK Reg */
> +
> +/* POLO GPIO registers                                         */
> +#define POLO_GPIO_DAT1_REG      regptr(MSP_PER_BASE + 0x0E0)   /* Polo GPIO[8:0]  data register   */
> +#define POLO_GPIO_CFG1_REG      regptr(MSP_PER_BASE + 0x0E4)   /* Polo GPIO[7:0]  config register */
> +#define POLO_GPIO_CFG2_REG      regptr(MSP_PER_BASE + 0x0E8)   /* Polo GPIO[15:8] config register */
> +#define POLO_GPIO_OD1_REG       regptr(MSP_PER_BASE + 0x0EC)   /* Polo GPIO[31:0] output drive register */
> +#define POLO_GPIO_CFG3_REG      regptr(MSP_PER_BASE + 0x170)   /* Polo GPIO[23:16] config register */
> +#define POLO_GPIO_DAT2_REG      regptr(MSP_PER_BASE + 0x174)   /* Polo GPIO[15:9]  data register   */
> +#define POLO_GPIO_DAT3_REG      regptr(MSP_PER_BASE + 0x178)   /* Polo GPIO[23:16]  data register   */
> +#define POLO_GPIO_DAT4_REG      regptr(MSP_PER_BASE + 0x17C)   /* Polo GPIO[31:24]  data register   */
> +#define POLO_GPIO_DAT5_REG      regptr(MSP_PER_BASE + 0x180)   /* Polo GPIO[39:32]  data register   */
> +#define POLO_GPIO_DAT6_REG      regptr(MSP_PER_BASE + 0x184)   /* Polo GPIO[47:40]  data register   */
> +#define POLO_GPIO_DAT7_REG      regptr(MSP_PER_BASE + 0x188)   /* Polo GPIO[54:48]  data register   */
> +#define POLO_GPIO_CFG4_REG      regptr(MSP_PER_BASE + 0x18C)   /* Polo GPIO[31:24] config register */
> +#define POLO_GPIO_CFG5_REG      regptr(MSP_PER_BASE + 0x190)   /* Polo GPIO[39:32] config register */
> +#define POLO_GPIO_CFG6_REG      regptr(MSP_PER_BASE + 0x194)   /* Polo GPIO[47:40] config register */
> +#define POLO_GPIO_CFG7_REG      regptr(MSP_PER_BASE + 0x198)   /* Polo GPIO[54:48] config register */
> +#define POLO_GPIO_OD2_REG       regptr(MSP_PER_BASE + 0x19C)   /* Polo GPIO[54:32] output drive register */
> +
> +/* Generic GPIO registers                                         */
> +#define GPIO_DATA1_REG          regptr(MSP_PER_BASE + 0x170)   /* GPIO[1:0] data register */
> +#define GPIO_DATA2_REG          regptr(MSP_PER_BASE + 0x174)   /* GPIO[5:2] data register */
> +#define GPIO_DATA3_REG          regptr(MSP_PER_BASE + 0x178)   /* GPIO[9:6] data register */
> +#define GPIO_DATA4_REG          regptr(MSP_PER_BASE + 0x17C)   /* GPIO[15:10] data register */
> +#define GPIO_CFG1_REG           regptr(MSP_PER_BASE + 0x180)   /* GPIO[1:0] config reg */
> +#define GPIO_CFG2_REG           regptr(MSP_PER_BASE + 0x184)   /* GPIO[5:2] config reg */
> +#define GPIO_CFG3_REG           regptr(MSP_PER_BASE + 0x188)   /* GPIO[9:6] config reg */
> +#define GPIO_CFG4_REG           regptr(MSP_PER_BASE + 0x18C)   /* GPIO[15:10] config reg */
> +#define GPIO_OD_REG             regptr(MSP_PER_BASE + 0x190)   /* GPIO[15:0] output drive register */
> +
> +/***************************************************************************/
> +/* CPU Interface register definitions                                      */
> +/***************************************************************************/
> +#define PCI_FLUSH_REG           regptr(MSP_CPUIF_BASE + 0x00)   /* PCI-SDRAM queue flush trigger */
> +#define OCP_ERR1_REG            regptr(MSP_CPUIF_BASE + 0x04)   /* OCP Error Attribute 1 */
> +#define OCP_ERR2_REG            regptr(MSP_CPUIF_BASE + 0x08)   /* OCP Error Attribute 2 */
> +#define OCP_STS_REG             regptr(MSP_CPUIF_BASE + 0x0C)   /* OCP Error Status */
> +#define CPUIF_PM_REG            regptr(MSP_CPUIF_BASE + 0x10)   /* CPU policy configuration */
> +#define CPUIF_CFG_REG           regptr(MSP_CPUIF_BASE + 0x10)   /* Misc configuration options */
> +
> +/* Central Interrupt Controller Registers */
> +#define MSP_CIC_BASE            (MSP_CPUIF_BASE + 0x8000)     /* Central Interrupt registers */
> +#define CIC_EXT_CFG_REG         regptr(MSP_CIC_BASE + 0x00)   /* External interrupt configuration */
> +#define CIC_STS_REG             regptr(MSP_CIC_BASE + 0x04)   /* CIC Interrupt Status */
> +#define CIC_VPE0_MSK_REG        regptr(MSP_CIC_BASE + 0x08)   /* VPE0 Interrupt Mask */
> +#define CIC_VPE1_MSK_REG        regptr(MSP_CIC_BASE + 0x0C)   /* VPE1 Interrupt Mask */
> +#define CIC_TC0_MSK_REG         regptr(MSP_CIC_BASE + 0x10)   /* Thread Context 0 Interrupt Mask */
> +#define CIC_TC1_MSK_REG         regptr(MSP_CIC_BASE + 0x14)   /* Thread Context 1 Interrupt Mask */
> +#define CIC_TC2_MSK_REG         regptr(MSP_CIC_BASE + 0x18)   /* Thread Context 2 Interrupt Mask */
> +#define CIC_TC3_MSK_REG         regptr(MSP_CIC_BASE + 0x18)   /* Thread Context 3 Interrupt Mask */
> +#define CIC_TC4_MSK_REG         regptr(MSP_CIC_BASE + 0x18)   /* Thread Context 4 Interrupt Mask */
> +#define CIC_PCIMSI_STS_REG      regptr(MSP_CIC_BASE + 0x18)   /*  */
> +#define CIC_PCIMSI_MSK_REG      regptr(MSP_CIC_BASE + 0x18)   /*  */
> +#define CIC_PCIFLSH_REG         regptr(MSP_CIC_BASE + 0x18)   /*  */
> +#define CIC_VPE0_SWINT_REG      regptr(MSP_CIC_BASE + 0x08)   /*  */
> +
> +
> +/***************************************************************************/
> +/* Memory controller registers                                             */
> +/***************************************************************************/
> +#define MEM_CFG1_REG		regptr(MSP_MEM_CFG_BASE + 0x00)
> +#define MEM_SS_ADDR			regptr(MSP_MEM_CFG_BASE + 0x00)
> +#define MEM_SS_DATA			regptr(MSP_MEM_CFG_BASE + 0x04)
> +#define MEM_SS_WRITE		regptr(MSP_MEM_CFG_BASE + 0x08)
> +
> +/***************************************************************************/
> +/* PCI controller registers                                             */
> +/***************************************************************************/
> +#define PCI_BASE_REG			regptr(MSP_PCI_BASE + 0x00)
> +#define PCI_CONFIG_SPACE_REG	regptr(MSP_PCI_BASE + 0x800)
> +#define PCI_JTAG_DEVID_REG		regptr(MSP_SLP_BASE + 0x13c)
> +
> +/* 
> +** ########################################################################
> +** #  Register content & macro definitions                                #
> +** ########################################################################
> +*/
> +
> +/***************************************************************************/
> +/* DEV_ID defines                                                            */
> +/***************************************************************************/
> +#define DEV_ID_PCI_DIS          (1 << 26)       /* Set if PCI disabled */
> +#define DEV_ID_PCI_HOST         (1 << 20)       /* Set if PCI host */
> +#define DEV_ID_SINGLE_PC        (1 << 19)       /* Set if single PC Card mode */
> +#define DEV_ID_FAMILY           (0xff << 8)     /* family ID code */
> +#define POLO_ZEUS_SUB_FAMILY    (0x7  << 16)    /* sub family code for Polo/Zeus */
> +
> +#define MSPFPGA_ID              (0x00  << 8)    /* you are on your own here */
> +#define MSP5000_ID              (0x50  << 8)
> +#define MSP4F00_ID              (0x4f  << 8)    /* FPGA version of MSP4200 */
> +#define MSP4E00_ID              (0x4f  << 8)    /* FPGA version of MSP7120 */
> +#define MSP4200_ID              (0x42  << 8)
> +#define MSP4000_ID              (0x40  << 8)
> +#define MSP2XXX_ID              (0x20  << 8)
> +#define MSPZEUS_ID              (0x10  << 8)
> +
> +#define MSP2004_SUB_ID          (0x0   << 16)
> +#define MSP2005_SUB_ID          (0x1   << 16)
> +#define MSP2006_SUB_ID          (0x1   << 16)
> +#define MSP2007_SUB_ID          (0x2   << 16)
> +#define MSP2010_SUB_ID          (0x3   << 16)
> +#define MSP2015_SUB_ID          (0x4   << 16)
> +#define MSP2020_SUB_ID          (0x5   << 16)
> +#define MSP2100_SUB_ID          (0x6   << 16)
> +
> +/***************************************************************************/
> +/* RESET defines                                                           */
> +/***************************************************************************/
> +#define MSP_GR_RST              (0x01 << 0)     /* Global reset bit             */
> +#define MSP_MR_RST              (0x01 << 1)     /* MIPS reset bit               */
> +#define MSP_PD_RST              (0x01 << 2)     /* PVC DMA reset bit            */
> +#define MSP_PP_RST              (0x01 << 3)     /* PVC reset bit                */
> +/* reserved                                                                     */
> +#define MSP_EA_RST              (0x01 << 6)     /* Mac A reset bit              */
> +#define MSP_EB_RST              (0x01 << 7)     /* Mac B reset bit              */
> +#define MSP_SE_RST              (0x01 << 8)     /* Security Engine reset bit    */
> +#define MSP_PB_RST              (0x01 << 9)     /* Peripheral block reset bit   */
> +#define MSP_EC_RST              (0x01 << 10)    /* Mac C reset bit              */
> +#define MSP_TW_RST              (0x01 << 11)    /* TWI reset bit                */
> +#define MSP_SPI_RST             (0x01 << 12)    /* SPI/MPI reset bit            */
> +#define MSP_U1_RST              (0x01 << 13)    /* UART1 reset bit              */
> +#define MSP_U0_RST              (0x01 << 14)    /* UART0 reset bit              */
> +
> +
> +/***************************************************************************/
> +/* UART defines                                                            */
> +/***************************************************************************/
> +#ifndef CONFIG_MSP_FPGA
> +#define MSP_BASE_BAUD (25000000) 
> +#else
> +#define MSP_BASE_BAUD (6000000)
> +#endif
> +#define MSP_UART_REG_LEN 0x20
> +
> +/***************************************************************************/
> +/* ELB defines                                                            */
> +/***************************************************************************/
> +#define PCCARD_32       0x02    /* Set if card is PCCARD 32 (Cardbus) */
> +#define SINGLE_PCCARD   0x01    /* Set to enable single PC card mode */
> +
> +/***************************************************************************/
> +/* CIC defines                                                            */
> +/***************************************************************************/
> +
> +/* CIC_EXT_CFG_REG */
> +#define EXT_INT_POL(eirq)			(1 << (eirq + 8))
> +#define EXT_INT_EDGE(eirq)			(1 << eirq)
> +
> +#define CIC_EXT_SET_TRIGGER_LEVEL(reg, eirq)	reg &= ~EXT_INT_EDGE(eirq)
> +#define CIC_EXT_SET_TRIGGER_EDGE(reg, eirq)	reg |= EXT_INT_EDGE(eirq)
> +#define CIC_EXT_SET_ACTIVE_HI(reg, eirq)	reg |= EXT_INT_POL(eirq)
> +#define CIC_EXT_SET_ACTIVE_LO(reg, eirq)	reg &= ~EXT_INT_POL(eirq)
> +#define CIC_EXT_SET_ACTIVE_RISING		CIC_EXT_SET_ACTIVE_HI
> +#define CIC_EXT_SET_ACTIVE_FALLING		CIC_EXT_SET_ACTIVE_LO
> +
> +#define CIC_EXT_IS_TRIGGER_LEVEL(reg, eirq)	((reg & EXT_INT_EDGE(eirq)) == 0)
> +#define CIC_EXT_IS_TRIGGER_EDGE(reg, eirq)	(reg & EXT_INT_EDGE(eirq))
> +#define CIC_EXT_IS_ACTIVE_HI(reg, eirq)		(reg & EXT_INT_POL(eirq))
> +#define CIC_EXT_IS_ACTIVE_LO(reg, eirq)		((reg & EXT_INT_POL(eirq)) == 0)
> +#define CIC_EXT_IS_ACTIVE_RISING		CIC_EXT_IS_ACTIVE_HI
> +#define CIC_EXT_IS_ACTIVE_FALLING		CIC_EXT_IS_ACTIVE_LO
> +
> +/***************************************************************************/
> +/* Memory Controller defines                                               */
> +/***************************************************************************/
> +
> +/* Indirect memory controller registers */
> +#define DDRC_CFG(n)		(n)
> +#define DDRC_DEBUG(n)		(0x04 + n)
> +#define DDRC_CTL(n)		(0x40 + n)
> +
> +/* Macro to perform DDRC indirect write */
> +#define DDRC_INDIRECT_WRITE( reg, mask, value ) {\
> +	*MEM_SS_ADDR = ((mask & 0xf) << 8) | (reg & 0xff); \
> +	*MEM_SS_DATA = value; \
> +	*MEM_SS_WRITE = 1; \
> +}

Enclosing the macro in a { } is a good idea for macros with multiple
statements but will fail for a construct like:

	if (condition)
		DDRC_INDIRECT_WRITE(...);
	else
		something_else();

To make this really bulletproof, enclose the macro in a do { } while (0)
block instead.  See also http://kernelnewbies.org/FAQ/DoWhile0.

> +
> +/****************************/
> +/* SPI/MPI Mode				*/
> +/****************************/
> +#define SPI_MPI_RX_BUSY		0x00008000	/* SPI/MPI Receive Busy */
> +#define SPI_MPI_FIFO_EMPTY	0x00004000	/* SPI/MPI Fifo Empty */
> +#define SPI_MPI_TX_BUSY		0x00002000	/* SPI/MPI Transmit Busy */
> +#define SPI_MPI_FIFO_FULL	0x00001000	/* SPI/MPU FIFO full */
> +
> +/****************************************************************/
> +/* SPI/MPI Control Register										*/
> +/****************************************************************/
> +#define SPI_MPI_RX_START	0x00000004	/* Start receive command */
> +#define SPI_MPI_FLUSH_Q		0x00000002	/* Flush SPI/MPI Queue */
> +#define SPI_MPI_TX_START	0x00000001	/* Start Transmit Command */
> +
> +#endif /* _ASM_MSP_REGS_H */
> diff --git a/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h b/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h
> new file mode 100644
> index 0000000..5d2e58c
> --- /dev/null
> +++ b/include/asm-mips/pmc-sierra/msp71xx/msp_slp_int.h
> @@ -0,0 +1,108 @@
> +/*
> + * Carsten Langgaard, carstenl@mips.com
> + * Copyright (C) 1999 MIPS Technologies, Inc.  All rights reserved.
> + *
> + * ########################################################################
> + *
> + *  This program is free software; you can distribute it and/or modify it
> + *  under the terms of the GNU General Public License (Version 2) as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope it will be useful, but WITHOUT
> + *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + *  for more details.
> + *
> + *  You should have received a copy of the GNU General Public License along
> + *  with this program; if not, write to the Free Software Foundation, Inc.,
> + *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> + *
> + * ########################################################################
> + *
> + * Defines for the MSP interrupt controller.
> + *
> + */
> +#ifndef _MSP_SLP_INT_H
> +#define _MSP_SLP_INT_H
> +
> +/* 
> +** The PMC-Sierra SLP interrupts are arranged in a 3 level cascaded hierarchical
> +** system.  The first level are the direct MIPS interrupts and are assigned the
> +** interrupt range 0-7.  The second level is the SLM interrupt controller and is
> +** assigned the range 8-39.  The third level comprises the Peripherial block,
> +** the PCI block, the PCI MSI block and the SLP.  The PCI interrupts and the SLP
> +** errors are handled by the relevant subsystems so the core interrupt code
> +** needs only concern itself with the Peripheral block.  These are assigned
> +** interrupts in the range 40-71. 
> +*/
> +
> +
> +/*
> +** IRQs directly connected to CPU
> +*/
> +#define MSP_MIPS_INTBASE        (0)
> +#define MSP_INT_SW0             (0)  /* IRQ for swint0,         C_SW0     */
> +#define MSP_INT_SW1             (1)  /* IRQ for swint1,         C_SW1     */
> +#define MSP_INT_MAC0            (2)  /* IRQ for MAC 0,          C_IRQ0    */
> +#define MSP_INT_MAC1            (3)  /* IRQ for MAC 1,          C_IRQ1    */
> +#define MSP_INT_C_IRQ2          (4)  /* Wired off,              C_IRQ2    */
> +#define MSP_INT_VE              (5)  /* IRQ for Voice Engine,   C_IRQ3    */
> +#define MSP_INT_SLP             (6)  /* IRQ for SLM block,      C_IRQ4    */
> +#define MSP_INT_TIMER           (7)  /* IRQ for the MIPS timer, C_IRQ5    */
> +
> +/*
> +** IRQs cascaded on CPU interrupt 4 (CAUSE bit 12, C_IRQ4)
> +** These defines should be tied to the register definition for the SLM
> +** interrupt routine.  For now, just use hard-coded values.
> +*/
> +#define MSP_SLP_INTBASE         (MSP_MIPS_INTBASE + 8) 
> +#define MSP_INT_EXT0            (MSP_SLP_INTBASE + 0)   /* External interrupt 0                 */
> +#define MSP_INT_EXT1            (MSP_SLP_INTBASE + 1)   /* External interrupt 1                 */
> +#define MSP_INT_EXT2            (MSP_SLP_INTBASE + 2)   /* External interrupt 2                 */
> +#define MSP_INT_EXT3            (MSP_SLP_INTBASE + 3)   /* External interrupt 3                 */
> +/* Reserved                                       4-7                                           */

Please reformat to 80 columns.  See Documentation/CodingStyle for details and
the rationale.

> +
> +/***************************************************************************************/
> +/* DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER/DANGER */
> +/* Some MSP produces have this interrupt labelled as Voice and some are SEC mbox ....  */
> +/***************************************************************************************/
> +#define MSP_INT_SLP_VE		(MSP_SLP_INTBASE + 8)	/* Cascaded IRQ for Voice Engine        */
> +
> +#define MSP_INT_SLP_TDM		(MSP_SLP_INTBASE + 9)	/* TDM interrupt                        */
> +#define MSP_INT_SLP_MAC0        (MSP_SLP_INTBASE + 10)	/* Cascaded IRQ for MAC 0               */
> +#define MSP_INT_SLP_MAC1	(MSP_SLP_INTBASE + 11)	/* Cascaded IRQ for MAC 1               */
> +#define MSP_INT_SEC		(MSP_SLP_INTBASE + 12)	/* IRQ for security engine              */
> +#define	MSP_INT_PER 		(MSP_SLP_INTBASE + 13)	/* Peripheral interrupt                 */
> +#define	MSP_INT_TIMER0	        (MSP_SLP_INTBASE + 14)	/* SLP timer 0                          */
> +#define	MSP_INT_TIMER1	        (MSP_SLP_INTBASE + 15)	/* SLP timer 1                          */
> +#define	MSP_INT_TIMER2	        (MSP_SLP_INTBASE + 16)	/* SLP timer 2                          */
> +#define	MSP_INT_SLP_TIMER	(MSP_SLP_INTBASE + 17)	/* Cascaded MIPS timer                  */
> +#define MSP_INT_BLKCP 		(MSP_SLP_INTBASE + 18)   /* Block Copy                          */
> +#define MSP_INT_UART0		(MSP_SLP_INTBASE + 19)   /* UART 0                              */
> +#define MSP_INT_PCI		(MSP_SLP_INTBASE + 20)   /* PCI subsystem                       */
> +#define MSP_INT_PCI_DBELL       (MSP_SLP_INTBASE + 21)   /* PCI doorbell                        */
> +#define MSP_INT_PCI_MSI		(MSP_SLP_INTBASE + 22)   /* PCI Message Signal                  */
> +#define MSP_INT_PCI_BC0		(MSP_SLP_INTBASE + 23)   /* PCI Block Copy 0                    */
> +#define MSP_INT_PCI_BC1		(MSP_SLP_INTBASE + 24)   /* PCI Block Copy 1                    */
> +#define MSP_INT_SLP_ERR  	(MSP_SLP_INTBASE + 25)   /* SLP error condition                 */
> +#define MSP_INT_MAC2            (MSP_SLP_INTBASE + 26)   /* IRQ for MAC2                        */
> +/* Reserved                                      26-31                                          */
> +
> +/* 
> +** IRQs cascaded on SLP PER interrupt (MSP_INT_PER)
> +*/
> +#define MSP_PER_INTBASE        (MSP_SLP_INTBASE + 32)
> +/* Reserved                                        0-1                                  */
> +#define MSP_INT_UART1		(MSP_PER_INTBASE + 2)  /* UART 1                       */
> +/* Reserved                                        3-5                                  */
> +#define MSP_INT_2WIRE		(MSP_PER_INTBASE + 6)  /* 2-wire                       */
> +#define MSP_INT_TM0		(MSP_PER_INTBASE + 7)  /* Peripheral timer block out 0 */
> +#define MSP_INT_TM1		(MSP_PER_INTBASE + 8)  /* Peripheral timer block out 1 */
> +/* Reserved                                         9                                   */
> +#define MSP_INT_SPRX		(MSP_PER_INTBASE + 10) /* SPI RX complete              */
> +#define MSP_INT_SPTX		(MSP_PER_INTBASE + 11) /* SPI TX complete              */
> +#define MSP_INT_GPIO		(MSP_PER_INTBASE + 12) /* GPIO                         */
> +#define MSP_INT_PER_ERR         (MSP_PER_INTBASE + 13) /* Peripheral error             */
> +/* Reserved                                       14-31                                 */
> +
> +#endif /* !(_MSP_SLP_INT_H) */

  Ralf
