Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 19:41:36 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:62274 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037733AbWLETlb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 19:41:31 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 158E93EC9; Tue,  5 Dec 2006 11:41:09 -0800 (PST)
Message-ID: <4575CBB6.8030804@ru.mvista.com>
Date:	Tue, 05 Dec 2006 22:42:46 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: serial console: platform_device
References: <1165346639.6871.19.camel@sandbar.kenati.com>
In-Reply-To: <1165346639.6871.19.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:

> I m working on porting the 2.6.14.6 kernel to the Encore M3 (AU1500)
> board --

> The kernel mounts the NFS root and executes the init=/bin/sh program --
> however I dont see it on the console (standard 8250 UART)

> The reason is that there was no platform_device structure defined for
> the serial console in the platform.c file.

> I therefore added the following to the
> arch/mips/au1000/common/platform.c file,

    I doubt this is fitting place, since it only registers SoC devices. Move 
this to the *board* specific code instead.

>>#ifdef CONFIG_MIPS_AMPRO_M3
>>static struct plat_serial8250_port encm3_via_uart_data[] = {
>>          {
>>             .mapbase        = 0x50000000 + 0x3f8, 

    I highly doubt this is correct -- the address 0x3f8 is in I/O space. And 
since 0x50000000 is mips_io_port_base, you do *not* need to add it here.

>>             .membase        = (char *)(0x50000000 +0x3f8),

    This needs a kernel address, i.e. in KSEG1. As the UARTs are in the I/O 
space, you just don't need to set this.

>>static struct resource encm3_via_uart_resource = {
>>                .start  = VIA_COM1_ADDR, // this is 0x3f8
>>                .end    = VIA_COM1_ADDR + 0x7,
>>                .flags  = IORESOURCE_IO,
>>};
>>
>>
>>static struct platform_device encm3_via_uart = {        
>>                .name           = "serial8250",
>>                .id             = 1,
>>                .dev                    = {
>>                                .platform_data  = encm3_via_uart_data,
>>                 },
>>                .num_resources  = 1,

    Where the IRQ is declared?

>>                .resource       = &encm3_via_uart_resource,
>>};
>>#endif

    Well, I doubt that you need to also decalre the UART as platform_device in 
addition to registering it with 8250.x -- it'll do everything for you.

> I have a these queries about the above entries:

> 1) The serial console is on a VIA 686B southbridge which is on the PCI
> bus -- however, because of the way the VIA is designed, any references
> from the processor to port 0x3f8 are routed to the console -- 
> - the  0x50000000 is the mips_io_port_base address for the Southbridge
> so should the resource.flags be IORESOURCE_IO or IORESOURCE_MEM -- what
> does this signify exactly?

    On x86 the hardware on the busses is accessible via both memory and I/O 
address space (the 2nd method was historically preferred) -- so, all archs 
that want to reuse the standard x86 h/w have to adapt to its ways, 
implementing I/O address space accesses by some means, usually by dedicating 
the certain range of the physical addresses to it....

> I tried both and neither makes a difference
> to the output from the log buffer which I have pasted below.  Does this
> have to do with whether the ports are i/o or memory mapped -- cus in

    This has to do with improper UART addresses you were passing.

> that case it should be IORESOURCE_MEM as all io ports on MIPS processors
> are memory mapped -- right?

    No, it should be IORESOURCE_IO.

> 2) in the platform_device structure, does the name of the device have to
> be coherent with a name given to it elsewhere, if yes, where? 

    You just don't need it in this case.

> 3) control goes into the serial8250_probe function and assigns values
> from the plat_serial8250_port encm3_via_uart_data to the port..so what
> is the basic difference between registration of "probe device" versus
> "platform bus" devices in the 2.6 kernel?

    I'm not sure I follow you here.

WBR, Sergei
