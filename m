Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 17:19:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25334 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTGPQTT>;
	Wed, 16 Jul 2003 17:19:19 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA14794;
	Wed, 16 Jul 2003 09:19:16 -0700
Subject: Re: [PATCH] [2.60-test1] Alchemy UART build problems
From: Pete Popov <ppopov@mvista.com>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1058359177.10765.1568.camel@caernarfon>
References: <1058359177.10765.1568.camel@caernarfon>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1058372380.27085.12.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jul 2003 09:19:40 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-07-16 at 05:39, Liam Girdwood wrote:
> Hi,
> 
> I've found some function/type naming errors within the Alchemy serial
> driver. Patch below.
> 
> 
> Index: drivers/serial/au1x00_uart.c
> ===================================================================
> RCS file: /home/cvs/linux/drivers/serial/au1x00_uart.c,v
> retrieving revision 1.1
> diff -r1.1 au1x00_uart.c
> 1079c1079
> < 		up->port.irq      = irq_cannonicalize(old_serial_port[i].irq);
> ---
> > 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
> 1307c1307
> < int __init early_serial_setup(struct serial_struct *req)
> ---
> > int __init early_serial_setup(struct uart_port *req)
> 
> 
> There is also a reference to a non existant member called change_speed
> of struct uart_ops on line 1055 i.e. 
> 
> 	.change_speed	= serial_au1x00_change_speed,
> 
> This builds if it is commented out, however serial_au1x00_change_speed()
> is not called anywhere in the driver and the change_speed member is not
> used anywhere else in the kernel!
> 
> It looks like this file is still in transition between 2.4 and 2.6 as
> the 2.4 driver works fine. Does anyone have a working 2.5/2.6 Alchemy
> uart driver ?

The serial driver worked fine for me about a month or more ago. Then
there was a large update with the latest 2.5.x bits and it's very
possible that the driver got broken. There are other Au1x problems in
2.5 as well. The 36 bit address patch is not there yet. The last time I
played with 2.5 the kernel mounted the root fs and then hung trying to
start a userland process ... and I haven't had any time since then.  I
think you're in new territory here but, hey, someone needs to clean up
everything :)

Pete
