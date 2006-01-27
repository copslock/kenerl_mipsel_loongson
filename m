Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 03:36:07 +0000 (GMT)
Received: from bay20-f13.bay20.hotmail.com ([64.4.54.102]:27471 "EHLO
	hotmail.com") by ftp.linux-mips.org with ESMTP id S8133461AbWA0Dfu
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 03:35:50 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 26 Jan 2006 19:40:17 -0800
Message-ID: <BAY20-F13B86868EF8BF340B9B3CBEC140@phx.gbl>
Received: from 202.124.146.103 by by20fd.bay20.hotmail.msn.com with HTTP;
	Fri, 27 Jan 2006 03:40:17 GMT
X-Originating-IP: [202.124.146.103]
X-Originating-Email: [merlin002@hotmail.com]
X-Sender: merlin002@hotmail.com
From:	"Hal -" <merlin002@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: VR5701 GPIO trouble
Date:	Fri, 27 Jan 2006 03:40:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 27 Jan 2006 03:40:17.0895 (UTC) FILETIME=[64217770:01C622F3]
Return-Path: <merlin002@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: merlin002@hotmail.com
Precedence: bulk
X-list: linux-mips

What is the kernel interrupt number for the GPIO ports of the VR5701?

I am making a driver for a VR5701 board and am having trouble with 
interrupts. I've set up a pushbutton on GPIO pin 29. When I press a button, 
the CPU registers GIU_PIO0, nothing happens when it's supposed to call the 
interrupt handler and do a printk();

The initialization function first sets bit 4 of INT_MASK (not GIU_INTMASK), 
defined in asm/vr5701.h, to 1 because I want to enable interrupt 4.

It then sets INT_ROUTE0's bits 19:16 to 0100 to route device 4 (GPIO) to 
interrupt 4. It clears all gpio interrupts, all cpu interrupts, sets 
interrupt type to edge trigger, proper polarity, gpio interrupt mask, and 
gpio direction register (GIU_INTCLR, INT_CLR, GIU_INTTYPE, GIU_INTPOL, 
GIU_INTMASK, GIU_DIR0, respectively).

It then does a request_irq with IRQ 4, SA_INTERRUPT flag, and device ID of 
4.

Did I miss anything? What else should be done to get the pushbutton working 
properly?

Thank you.

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/
