Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 19:11:27 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:21669 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038975AbWLETLV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 19:11:21 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 6D04B15D4004
	for <linux-mips@linux-mips.org>; Tue,  5 Dec 2006 12:41:13 -0800 (PST)
Subject: serial console: platform_device
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 05 Dec 2006 11:23:59 -0800
Message-Id: <1165346639.6871.19.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

I m working on porting the 2.6.14.6 kernel to the Encore M3 (AU1500)
board --

The kernel mounts the NFS root and executes the init=/bin/sh program --
however I dont see it on the console (standard 8250 UART)

The reason is that there was no platform_device structure defined for
the serial console in the platform.c file.

I therefore added the following to the
arch/mips/au1000/common/platform.c file,


> 
> #ifdef CONFIG_MIPS_AMPRO_M3
> static struct plat_serial8250_port encm3_via_uart_data[] = {
>           {
>              .mapbase        = 0x50000000 + 0x3f8, 
>              .membase        = (char *)(0x50000000 +0x3f8),         
>              .irq            = AU1000_GPIO_0,
>              .flags          = UPF_SHARE_IRQ, 
>              .iotype         = UPIO_PORT,
>              .regshift       = 1,
>              .uartclk        = 1843200,
> 
>              },
>                         { },
> };
> 
> static struct resource encm3_via_uart_resource = {
>                 .start  = VIA_COM1_ADDR, // this is 0x3f8
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
> #endif
> 

I have a these queries about the above entries:

1) The serial console is on a VIA 686B southbridge which is on the PCI
bus -- however, because of the way the VIA is designed, any references
from the processor to port 0x3f8 are routed to the console -- 
- the  0x50000000 is the mips_io_port_base address for the Southbridge
so should the resource.flags be IORESOURCE_IO or IORESOURCE_MEM -- what
does this signify exactly? I tried both and neither makes a difference
to the output from the log buffer which I have pasted below.  Does this
have to do with whether the ports are i/o or memory mapped -- cus in
that case it should be IORESOURCE_MEM as all io ports on MIPS processors
are memory mapped -- right?

2) in the platform_device structure, does the name of the device have to
be coherent with a name given to it elsewhere, if yes, where? 

3) control goes into the serial8250_probe function and assigns values
from the plat_serial8250_port encm3_via_uart_data to the port..so what
is the basic difference between registration of "probe device" versus
"platform bus" devices in the 2.6 kernel?

When I build the kernel with this platform.c file and run it, I see an
error in the pci_register_driver function executed to register the usb
port which is on the AU1500 chip, which is the other platform device -- 
I did not get such an error before the above entries were added to the
file!  I have pasted the contents of the entire file below.

Sorry about the length of this email and Thank you,
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
> 
> static struct resource au1xxx_usb_ohci_resources[] = {
>         [0] = {
>                 .start          = USB_OHCI_BASE,
>                 .end            = USB_OHCI_BASE + USB_OHCI_LEN,
>                 .flags          = IORESOURCE_MEM,
>         },
>         [1] = {
>                 .start          = AU1000_USB_HOST_INT,
>                 .end            = AU1000_USB_HOST_INT,
>                 .flags          = IORESOURCE_IRQ,
>         },
> };
> 
> /* The dmamask must be set for OHCI to work */
> static u64 ohci_dmamask = ~(u32)0;
> 
> static struct platform_device au1xxx_usb_ohci_device = {
>         .name           = "au1xxx-ohci",
>         .id             = 0,
>         .dev = {
>                 .dma_mask               = &ohci_dmamask,
>                 .coherent_dma_mask      = 0xffffffff,
>         },
>         .num_resources  = ARRAY_SIZE(au1xxx_usb_ohci_resources),
>         .resource       = au1xxx_usb_ohci_resources,
>                                                                                                             44,2-9        Top
> 
> };
> 
> 
> 
> #ifdef CONFIG_MIPS_AMPRO_M3
> static struct plat_serial8250_port encm3_via_uart_data[] = {
>                 {
> //                      .mapbase        = 0x50000000 + 0x3f8,                   //resource base
>                         .membase        = (char *)(0x50000000 + 0x3f8),         // is a pointer - ioremap cookie or NULL
>                         .irq            = AU1000_GPIO_0,
>                         .flags          = UPF_SHARE_IRQ, //| UPF_IOREMAP, //UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
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
> static struct platform_device encm3_via_uart = {        // coyote_uart arm/mach-ixp4xx/coyote-setup.c
>                 .name           = "serial8250",
>                 .id             = 1,
>                 .dev                    = {
>                                 .platform_data  = encm3_via_uart_data,
>                  },
>                 .num_resources  = 1,
>                 .resource       = &encm3_via_uart_resource,
> };
> #endif
> 
> static struct platform_device *au1xxx_platform_devices[] __initdata = {
>         &au1xxx_usb_ohci_device,
>         &encm3_via_uart,
> };
> int au1xxx_platform_init(void)
> {
>         printk("size of au1xxx platform devices is %d\n",ARRAY_SIZE(au1xxx_platform_devices));
>         return platform_add_devices(au1xxx_platform_devices, ARRAY_SIZE(au1xxx_platform_devices));
> }
> 
> arch_initcall(au1xxx_platform_init);
> 
