Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 17:10:11 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:64287 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491917Ab0KSQJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 17:09:57 +0100
Received: by ewy19 with SMTP id 19so2732846ewy.36
        for <linux-mips@linux-mips.org>; Fri, 19 Nov 2010 08:09:56 -0800 (PST)
Received: by 10.213.35.72 with SMTP id o8mr4892761ebd.62.1290182996408;
        Fri, 19 Nov 2010 08:09:56 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id x54sm1595087eeh.5.2010.11.19.08.09.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 08:09:54 -0800 (PST)
Message-ID: <4CE6A103.8030009@mvista.com>
Date:   Fri, 19 Nov 2010 19:08:35 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
CC:     Ricardo Mendoza <ricmm@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: The new "real" console doesn't display printk() messages like
 "early" console!
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com><4CE57C92.6030705@mvista.com><AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com> <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com> <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

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

    This is never defined for MIPS. And there shouldn't be such dependencies.

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
You are not obliged to pass 'membase', unless you have pre-existing mapping but 
in this case you also need to pass UPF_IOREMAP in 'flags'.

> 		p->irq = MIPSCPU_INT_UART;
> 		p++;
> 	}

> 	return platform_device_register(&gd_uart8250_device);
> }
> 
> device_initcall(gd_serial_init);


> ------------------------------------------------------------------------
> -----------------------
> 
> Thanks,
> Andrei

WBR, Sergei
