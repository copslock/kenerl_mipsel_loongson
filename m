Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 19:53:48 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:56679 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038616AbWLFTxo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 19:53:44 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 07D343EC9; Wed,  6 Dec 2006 11:53:22 -0800 (PST)
Message-ID: <45772013.70907@ru.mvista.com>
Date:	Wed, 06 Dec 2006 22:54:59 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: serial console: platform_device
References: <1165346639.6871.19.camel@sandbar.kenati.com>	 <4575CBB6.8030804@ru.mvista.com>	 <1165351710.6871.34.camel@sandbar.kenati.com>	 <4575DABF.2000604@ru.mvista.com>	 <1165365058.6871.54.camel@sandbar.kenati.com>	 <4576BEBA.6080702@ru.mvista.com> <1165434577.6516.8.camel@sandbar.kenati.com>
In-Reply-To: <1165434577.6516.8.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:

> There is already an interrupt handler in place for the AU1000_GPIO_0
> that takes care of the cascaded interrupts -- so I *can* say 
>  .irq= AU1000_GPIO_0 ----right?

    No, you can't. You'll have to specify to what 8259's IRQ4 maps to on your 
platform.

> Also, how will I make sure my board specific encm3_platform_init is
> called during the arch init calls?

    Mentioning it in arch_initcall() arranges for that. :-/

> I have put in an entry in the Makefile for the board specific
> encm3_platform.c file -- so it is built - but when control goes to the 
> static int __devinit serial8250_probe(struct device *dev) function in
> the 8250.c it never executes the serial8250_register_port function.
> I know this cus I m using the JTAG port on the board to look inside and
> step through the code..

    That's strange. Although the UART declaration has a grave defect....

> Here is my /arch/mips/au1000/encm3/encm3_platform.c file:

>>/*
>> * Platform device support for Au1x00 SoCs.
>> *
>> * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
>> *
>> * This file is licensed under the terms of the GNU General Public
>> * License version 2.  This program is licensed "as is" without any
>> * warranty of any kind, whether express or implied.
>> */

    That boilerplate is no longer applicable. :-)

>>#include <linux/device.h>
>>#include <linux/kernel.h>
>>#include <linux/init.h>
>>#include <linux/resource.h>
>>#include <linux/serial_8250.h>
>>#include <linux/tty.h>
>>
>>#include <asm/mach-au1x00/au1000.h>
>>#include <asm/mach-encm3/encm3.h>
>>static struct plat_serial8250_port encm3_via_uart_data[] = {
>>                {
>>                        .mapbase        =
>>0x3f8,                        //resource base

    Damn, I didn't notice: .mapbase should be changed to .iobase!

>>//                      .membase        = (char *)(0x50000000 +
>>0x3f8),         // is a pointer - ioremap cookie or NULL
>>                        .irq            = AU1000_GPIO_0,
>>                        .flags          = UPF_SHARE_IRQ, //|
>>UPF_IOREMAP, //UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
>>                        .iotype         = UPIO_PORT,
>>                        .regshift       = 1,
>>                        .uartclk        = 1843200,
>>
>>                  },
>>                        { },
>>};

>>static struct resource encm3_via_uart_resource = {
>>                .start  = VIA_COM1_ADDR,
>>                .end    = VIA_COM1_ADDR + 0x7,
>>                .flags  = IORESOURCE_IO,
>>};

    Still, you don't need to declare the resources for the 8250 devices -- the 
driver should handle requesting them for you -- as they're alredy specified by 
struct plat_serial8250_port.

>>static struct platform_device encm3_via_uart = {
>>                .name           = "serial8250",
>>                .id             = 1,

    I guess it should be PLAT8250_DEV_LEGACY...

>>                .dev                    = {
>>                                .platform_data  = encm3_via_uart_data,
>>                 },

    So, you also don't need the following 2 lines:

>>                .num_resources  = 1,
>>                .resource       = &encm3_via_uart_resource,
>>};

>>static struct platform_device *encm3_platform_devices[] __initdata = {
>>        &encm3_via_uart,
>>};

>>int encm3_platform_init(void)
>>{
>>        printk("size of encm3 platform devices is %d
>>\n",ARRAY_SIZE(encm3_platform_devices));
>>        return platform_add_devices(encm3_platform_devices,
>>ARRAY_SIZE(encm3_platform_devices));

    I think it's better to call platform_device_register() for a single device...

WBR, Sergei
