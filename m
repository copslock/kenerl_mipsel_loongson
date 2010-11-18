Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 23:01:38 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:40939 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490955Ab0KRWBf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 23:01:35 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAIM1JjU001105;
        Thu, 18 Nov 2010 14:01:19 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAIM1IDj013242;
        Thu, 18 Nov 2010 14:01:18 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAIM1Hf18075;
        Thu, 18 Nov 2010 14:01:17 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The new "real" console doesn't display printk() messages like "early" console!
Date:   Thu, 18 Nov 2010 14:01:06 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The new "real" console doesn't display printk() messages like "early" console!
Thread-Index: AcuHag9+u82cHfU/Q72jKCa6Mm+O3AAAXMcQ
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com><4CE57C92.6030705@mvista.com><AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com> <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Ricardo Mendoza" <ricmm@gentoo.org>
Cc:     <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Ricardo,

I implemented serial platform driver taking as model serial.c from
cavium-octeon.

Here is my code:


/*
 * This file is subject to the terms and conditions of the GNU General
Public
 * License.  See the file "COPYING" in the main directory of this
archive
 * for more details.
 *
 * Copyright (C) 2004-2007 Cavium Networks
 */
 
#include <linux/console.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/serial.h>
#include <linux/serial_8250.h>
#include <linux/serial_reg.h>
#include <linux/tty.h>
#include <asm/time.h>
#include <sys_defs.h>


#ifdef CONFIG_GDB_CONSOLE
#define DEBUG_UART 0
#else
#define DEBUG_UART 1
#endif

unsigned int gd_serial_in(struct uart_port *up, int offset)
{
	int rv = inl((unsigned int)(up->membase + (offset << 2)));
	if (offset == UART_IIR && (rv & 0xf) == 7) {
		/* Busy interrupt, read the USR (39) and try again. */
		inl((unsigned int)(up->membase + (39 << 2)));
		rv = inl((unsigned int)(up->membase + (offset << 2)));
	}
	return rv;
}

void gd_serial_out(struct uart_port *up, int offset, int value)
{
	outl( value & 0xff, (unsigned int)(up->membase + (offset <<
2)));
}

/*
 * Allocated in .bss, so it is all zeroed.
 */
#define GD_MAX_UARTS 1
static struct plat_serial8250_port gd_uart8250_data[GD_MAX_UARTS + 1];
static struct platform_device gd_uart8250_device = {
	.name			= "serial8250",
	.id			= PLAT8250_DEV_PLATFORM,
	.dev			= {
		.platform_data	= gd_uart8250_data,
	},
};

static void __init gd_uart_set_common(struct plat_serial8250_port *p)
{
	p->flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
	p->type = PORT_GD;
	p->iotype = UPIO_MEM;
	p->regshift = 2;	/* I/O addresses are every 4 bytes */
	p->uartclk = UART_CLK;  
	p->serial_in = gd_serial_in;
	p->serial_out = gd_serial_out;
}

static int __init gd_serial_init(void)
{
	int enable_uart0;
	struct plat_serial8250_port *p;

	enable_uart0 = 1;

	p = gd_uart8250_data;
	if (enable_uart0) {
		/* Add a ttyS device for hardware uart 0 */
		gd_uart_set_common(p);
		p->membase = (void *) offMCU_UART_THR_OR_RBR_OR_DLL;
		p->mapbase = offMCU_UART_THR_OR_RBR_OR_DLL;
		p->irq = MIPSCPU_INT_UART;
		p++;
	}

	return platform_device_register(&gd_uart8250_device);
}

device_initcall(gd_serial_init);


------------------------------------------------------------------------
-----------------------

Thanks,
Andrei














-----Original Message-----
From: mendoza.ricardo@gmail.com [mailto:mendoza.ricardo@gmail.com] On
Behalf Of Ricardo Mendoza
Sent: Thursday, November 18, 2010 4:21 PM
To: Ardelean, Andrei
Cc: linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages
like "early" console!

On Thu, Nov 18, 2010 at 8:04 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:

> I specified that when the bootloader calls the kernel and I did see
that
> the baudrate is correct and I have some messages but when the system
is
> crashing I cannot see printk messages. For instance, I step with JTAG
> and I can see that printk(KERNEL_WARNING "unable to open initial
> console") is called but on the terminal I cannot see the message. The
> same, die() is called but there is no messages on UART terminal.

You say you are porting to a new system, perhaps you didn't set up
your 8250 platform device. Most boards will have an example for you in
the tree.


     Ricardo
