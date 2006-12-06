Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 19:37:02 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:10136 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038616AbWLFTg5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 19:36:57 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 71DE415D4004;
	Wed,  6 Dec 2006 13:06:56 -0800 (PST)
Subject: Re: serial console: platform_device
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4576BEBA.6080702@ru.mvista.com>
References: <1165346639.6871.19.camel@sandbar.kenati.com>
	 <4575CBB6.8030804@ru.mvista.com>
	 <1165351710.6871.34.camel@sandbar.kenati.com>
	 <4575DABF.2000604@ru.mvista.com>
	 <1165365058.6871.54.camel@sandbar.kenati.com>
	 <4576BEBA.6080702@ru.mvista.com>
Content-Type: text/plain
Date:	Wed, 06 Dec 2006 11:49:37 -0800
Message-Id: <1165434577.6516.8.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

hi,

There is already an interrupt handler in place for the AU1000_GPIO_0
that takes care of the cascaded interrupts -- so I *can* say 
 .irq= AU1000_GPIO_0 ----right?

Also, how will I make sure my board specific encm3_platform_init is
called during the arch init calls?

I have put in an entry in the Makefile for the board specific
encm3_platform.c file -- so it is built - but when control goes to the 
static int __devinit serial8250_probe(struct device *dev) function in
the 8250.c it never executes the serial8250_register_port function.
I know this cus I m using the JTAG port on the board to look inside and
step through the code..

Here is my /arch/mips/au1000/encm3/encm3_platform.c file:

Thanks and Regards,
Ashlesha.

> /*
>  * Platform device support for Au1x00 SoCs.
>  *
>  * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
>  *
>  * This file is licensed under the terms of the GNU General Public
>  * License version 2.  This program is licensed "as is" without any
>  * warranty of any kind, whether express or implied.
>  */
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/init.h>
> #include <linux/resource.h>
> #include <linux/serial_8250.h>
> #include <linux/tty.h>
> 
> #include <asm/mach-au1x00/au1000.h>
> #include <asm/mach-encm3/encm3.h>
> static struct plat_serial8250_port encm3_via_uart_data[] = {
>                 {
>                         .mapbase        =
> 0x3f8,                        //resource base
> //                      .membase        = (char *)(0x50000000 +
> 0x3f8),         // is a pointer - ioremap cookie or NULL
>                         .irq            = AU1000_GPIO_0,
>                         .flags          = UPF_SHARE_IRQ, //|
> UPF_IOREMAP, //UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
>                         .iotype         = UPIO_PORT,
>                         .regshift       = 1,
>                         .uartclk        = 1843200,
> 
>                   },
>                         { },
> };
> 
> static struct resource encm3_via_uart_resource = {
>                 .start  = VIA_COM1_ADDR,
>                 .end    = VIA_COM1_ADDR + 0x7,
>                 .flags  = IORESOURCE_IO,
> };
> 
> 
> static struct platform_device encm3_via_uart = {
>                 .name           = "serial8250",
>                 .id             = 1,
>                 .dev                    = {
>                                 .platform_data  = encm3_via_uart_data,
>                  },
>                 .num_resources  = 1,
>                 .resource       = &encm3_via_uart_resource,
> };
> 
> static struct platform_device *encm3_platform_devices[] __initdata = {
>         &encm3_via_uart,
> };
> 
> int encm3_platform_init(void)
> {
>         printk("size of encm3 platform devices is %d
> \n",ARRAY_SIZE(encm3_platform_devices));
>         return platform_add_devices(encm3_platform_devices,
> ARRAY_SIZE(encm3_platform_devices));
> }
> 
> arch_initcall(encm3_platform_init);


On Wed, 2006-12-06 at 15:59 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Ashlesha Shintre wrote:
> 
> >>    Ah, I forgot to mention that if your UART is a part of the south bridge, 
> >>its IRQ number is _4_ on the integrated 8259 interrupt controller. I'm sure 
> >>that AU1000_GPIO_0 is the cascaded interrupt request from 8259, not the UART's 
> >>own IRQ...
> 
> >>>>static struct plat_serial8250_port encm3_via_uart_data[] = {
> >>>>               {
> >>>>                       .mapbase        = 0x3f8,
> >>>>                       .irq            = AU1000_GPIO_0,
> 
> >>    So, this is wrong. You need to specify to what platform IRQ 8259's IRQ4 
> >>gets routed here.
> 
> > I m not sure what you mean here -- the AU1000_GPIO_0 is the cascaded
> > interrupt request from the 8259 on the VIA Southbridge -- 
> 
>     I meant that the UART interrupts from the south bridge *cannot* be 
> delivered *directly* to the Alchemy's embedded interrupt controller), so 
> AU1000_GPIO_0 must be used to deliver all the interrupts from 8259 (the 
> interrupt controller integrated into the south bridge) to the embedded 
> interrupt controller. So, you need to setup some kind of the cascading 
> interrupt handler for AU1000_GPIO_0 to read the vector from 8259 I think...
> 
> > Best Regards,
> > Ashlesha.
> 
> WBR, Sergei
