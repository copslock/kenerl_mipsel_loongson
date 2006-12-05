Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 20:35:58 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:29886 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039071AbWLEUfw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 20:35:52 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 3DBAF15D4004;
	Tue,  5 Dec 2006 14:05:44 -0800 (PST)
Subject: Re: serial console: platform_device
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4575CBB6.8030804@ru.mvista.com>
References: <1165346639.6871.19.camel@sandbar.kenati.com>
	 <4575CBB6.8030804@ru.mvista.com>
Content-Type: text/plain
Date:	Tue, 05 Dec 2006 12:48:30 -0800
Message-Id: <1165351710.6871.34.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

Hi,

Thank you for your prompt response -- I really appreciate it.


On Tue, 2006-12-05 at 22:42 +0300, Sergei Shtylyov wrote:
> > 3) control goes into the serial8250_probe function and assigns
> values
> > from the plat_serial8250_port encm3_via_uart_data to the port..so
> what
> > is the basic difference between registration of "probe device"
> versus
> > "platform bus" devices in the 2.6 kernel?
> 

>     I'm not sure I follow you here.
What I meant was, what was the basis for the implementation of
platform_device and platform_init functions in 2.6?

By my understanding the way it worked in 2.4 was by the device probing
functions that would allocate memory, io ports etc..

m working on making the changes you suggested --

without the addition of the platform_device and other structures, the
serial console is never detected -- I never get a msg at boot time that
reads 

serial8250: ttyS0 at I/O 0x3f8 (irq = whatever) is a 16550A

so I think i might need these routines

Also, the Southbridge interrupts are assigned interrupt number:
AU1000_GPIO_0..and I have included this as below:


> static struct plat_serial8250_port encm3_via_uart_data[] = {
>                 {
>                         .mapbase        = 0x3f8,
>                         .irq            = AU1000_GPIO_0,
>                         .flags          = UPF_SHARE_IRQ, 
>                         .iotype         = UPIO_PORT,
>                         .regshift       = 1,
>                         .uartclk        = 1843200,
> 
>                   },
>                         { },
> };

Thanks again!
Ashlesha.
