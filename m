Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 17:38:14 +0100 (CET)
Received: from mxout1.idt.com ([157.165.5.25]:56179 "EHLO mxout1.idt.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491981Ab0KVQiH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Nov 2010 17:38:07 +0100
Received: from mail.idt.com (localhost [127.0.0.1])
        by mxout1.idt.com (8.13.1/8.13.1) with ESMTP id oAMGbuPM031895;
        Mon, 22 Nov 2010 08:37:58 -0800
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
        by mail.idt.com (8.13.8/8.13.8) with ESMTP id oAMGbtLd029838;
        Mon, 22 Nov 2010 08:37:56 -0800 (PST)
Received: from CORPEXCH1.na.ads.idt.com (localhost [127.0.0.1])
        by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id oAMGbs213378;
        Mon, 22 Nov 2010 08:37:54 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The new "real" console doesn't display printk() messages like "early" console!
Date:   Mon, 22 Nov 2010 08:37:53 -0800
Message-ID: <AEA634773855ED4CAD999FBB1A66D0760136A7D3@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CE6A103.8030009@mvista.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The new "real" console doesn't display printk() messages like "early" console!
Thread-Index: AcuIBEWDEyxDvHP6TbaTKBiFLvofTACXasVA
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com><4CE57C92.6030705@mvista.com><AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com> <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com> <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com> <4CE6A103.8030009@mvista.com>
From:   "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
To:     "Sergei Shtylyov" <sshtylyov@mvista.com>
Cc:     "Ricardo Mendoza" <ricmm@gentoo.org>, <linux-mips@linux-mips.org>
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Andrei.Ardelean@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Andrei.Ardelean@idt.com
Precedence: bulk
X-list: linux-mips

Hi Sergei,

- I will clean up the things you highlighted in the code, they come from
octeon code.
- Regarding PORT_GD, I added it in driver/serial/8250.c like octeon
model:

	[PORT_OCTEON] = {
		.name		= "OCTEON",
		.fifo_size	= 64,
		.tx_loadsz	= 64,
		.fcr		= UART_FCR_ENABLE_FIFO |
UART_FCR_R_TRIG_10,
		.flags		= UART_CAP_FIFO,
	},
	[PORT_GD] = {
		.name		= "GD",
		.fifo_size	= 16,
		.tx_loadsz	= 16,
		.fcr		= UART_FCR_ENABLE_FIFO |
UART_FCR_R_TRIG_10,
		.flags		= UART_CAP_FIFO,
	},


Thanks,
Andrei


-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@mvista.com] 
Sent: Friday, November 19, 2010 11:09 AM
To: Ardelean, Andrei
Cc: Ricardo Mendoza; linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages
like "early" console!

Ardelean, Andrei wrote:

> Hi Ricardo,

> I implemented serial platform driver taking as model serial.c from
> cavium-octeon.

    I think you should really have used something simpler as an example.

> Here is my code:


> /*
>  * This file is subject to the terms and conditions of the GNU General
> Public
>  * License.  See the file "COPYING" in the main directory of this
> archive
>  * for more details.
>  *
>  * Copyright (C) 2004-2007 Cavium Networks
>  */
>  
> #include <linux/console.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/platform_device.h>
> #include <linux/serial.h>
> #include <linux/serial_8250.h>
> #include <linux/serial_reg.h>
> #include <linux/tty.h>
> #include <asm/time.h>
> #include <sys_defs.h>
> 
> 
> #ifdef CONFIG_GDB_CONSOLE

    This is never defined for MIPS. And there shouldn't be such
dependencies.

> #define DEBUG_UART 0
> #else
> #define DEBUG_UART 1
> #endif
> 
> unsigned int gd_serial_in(struct uart_port *up, int offset)
> {
> 	int rv = inl((unsigned int)(up->membase + (offset << 2)));

    Should be an empty line here.

> 	if (offset == UART_IIR && (rv & 0xf) == 7) {

    Are you sure this Octeon specific quirk also allpies to your UART?

> 		/* Busy interrupt, read the USR (39) and try again. */
> 		inl((unsigned int)(up->membase + (39 << 2)));
> 		rv = inl((unsigned int)(up->membase + (offset << 2)));
> 	}
> 	return rv;
> }
> 
> void gd_serial_out(struct uart_port *up, int offset, int value)
> {
> 	outl( value & 0xff, (unsigned int)(up->membase + (offset <<

    No spaces allowed after (.

> 2)));
> }
> 
> /*
>  * Allocated in .bss, so it is all zeroed.
>  */
> #define GD_MAX_UARTS 1

    Then how DEBUG_UART can be 1?

> static struct plat_serial8250_port gd_uart8250_data[GD_MAX_UARTS + 1];
> static struct platform_device gd_uart8250_device = {
> 	.name			= "serial8250",
> 	.id			= PLAT8250_DEV_PLATFORM,
> 	.dev			= {
> 		.platform_data	= gd_uart8250_data,

    Where is 'gd_uart8250_data'?

> 	},
> };

> static void __init gd_uart_set_common(struct plat_serial8250_port *p)
> {
> 	p->flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
> 	p->type = PORT_GD;

    What is PORT_GD?

> 	p->iotype = UPIO_MEM;

    Judging from your code, it should be UPIO_MEM32.

> 	p->regshift = 2;	/* I/O addresses are every 4 bytes */
> 	p->uartclk = UART_CLK;  
> 	p->serial_in = gd_serial_in;
> 	p->serial_out = gd_serial_out;
> }
> 
> static int __init gd_serial_init(void)
> {
> 	int enable_uart0;
> 	struct plat_serial8250_port *p;
> 
> 	enable_uart0 = 1;

    What's the point in existence of this variable?

> 	p = gd_uart8250_data;
> 	if (enable_uart0) {
> 		/* Add a ttyS device for hardware uart 0 */
> 		gd_uart_set_common(p);
> 		p->membase = (void *) offMCU_UART_THR_OR_RBR_OR_DLL;
> 		p->mapbase = offMCU_UART_THR_OR_RBR_OR_DLL;

     Are your UART registers identity mapped to virtual address space?
You are not obliged to pass 'membase', unless you have pre-existing
mapping but 
in this case you also need to pass UPF_IOREMAP in 'flags'.

> 		p->irq = MIPSCPU_INT_UART;
> 		p++;
> 	}

> 	return platform_device_register(&gd_uart8250_device);
> }
> 
> device_initcall(gd_serial_init);


>
------------------------------------------------------------------------
> -----------------------
> 
> Thanks,
> Andrei

WBR, Sergei
