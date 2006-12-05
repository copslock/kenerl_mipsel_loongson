Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 20:45:26 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:23108 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039071AbWLEUpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 20:45:21 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8D2FC3EC9; Tue,  5 Dec 2006 12:45:18 -0800 (PST)
Message-ID: <4575DABF.2000604@ru.mvista.com>
Date:	Tue, 05 Dec 2006 23:46:55 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	linux-mips@linux-mips.org
Subject: Re: serial console: platform_device
References: <1165346639.6871.19.camel@sandbar.kenati.com>	 <4575CBB6.8030804@ru.mvista.com> <1165351710.6871.34.camel@sandbar.kenati.com>
In-Reply-To: <1165351710.6871.34.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:

>>>3) control goes into the serial8250_probe function and assigns values
>>>from the plat_serial8250_port encm3_via_uart_data to the port..so what
>>>is the basic difference between registration of "probe device" versus

>>>"platform bus" devices in the 2.6 kernel?

>>    I'm not sure I follow you here.

> What I meant was, what was the basis for the implementation of
> platform_device and platform_init functions in 2.6?

    This is a convenient way to registers the various SoC and on-board devices 
residing on the busses that can't be scanned like ISA/LPC/whatever (and unlike 
PCI, for example).

> By my understanding the way it worked in 2.4 was by the device probing
> functions that would allocate memory, io ports etc..

    Basically, you don't need to probe for device which you *know* is there, 
you just need to tell the driver where it is.

> m working on making the changes you suggested --

> without the addition of the platform_device and other structures, the

    I meant that you *only* need struct plat_serial8250_port, and not 
platform_device.

> serial console is never detected -- I never get a msg at boot time that
> reads 

> serial8250: ttyS0 at I/O 0x3f8 (irq = whatever) is a 16550A

> so I think i might need these routines

> Also, the Southbridge interrupts are assigned interrupt number:
> AU1000_GPIO_0..and I have included this as below:

    Ah, I forgot to mention that if your UART is a part of the south bridge, 
its IRQ number is _4_ on the integrated 8259 interrupt controller. I'm sure 
that AU1000_GPIO_0 is the cascaded interrupt request from 8259, not the UART's 
own IRQ...

>>static struct plat_serial8250_port encm3_via_uart_data[] = {
>>                {
>>                        .mapbase        = 0x3f8,
>>                        .irq            = AU1000_GPIO_0,

    So, this is wrong. You need to specify to what platform IRQ 8259's IRQ4 
gets routed here.

> Thanks again!
> Ashlesha.

WBR, Sergei
