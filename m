Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 17:38:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57333 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225202AbUJUQiQ>; Thu, 21 Oct 2004 17:38:16 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id D1B03185D3; Thu, 21 Oct 2004 09:38:14 -0700 (PDT)
Message-ID: <4177E5F6.3010100@mvista.com>
Date: Thu, 21 Oct 2004 09:38:14 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: yosemite interrupt setup
References: <200410201952.29205.thomas.koeller@baslerweb.com> <4176A855.1000907@mvista.com> <4176AACA.3000206@mvista.com> <200410211149.35300.thomas.koeller@baslerweb.com>
In-Reply-To: <200410211149.35300.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Thomas Koeller wrote:
> On Wednesday 20 October 2004 20:13, Manish Lachwani wrote:
> 
> 
>>        TITAN_GE_WRITE(0x0024, 0x04000024);    /* IRQ vector */
>>        TITAN_GE_WRITE(0x0020, 0x000fb000);    /* INTMSG base */
> 
> 
> Hi Manish,
> 
> it was the location of these two lines that I was asking for. So they
> are in the ethernet driver. Wouldn't you agree that they should go
> into the platform instead? The interrrupt is shared with
> other devices, the DUART to name just one example, and if I want to
> write a driver for these, then that driver would depend on the
> ethernet driver, if that does the interrupt setup.
> 
> So this covers the message interrupts, but I also have not been
> able so far to spot the location where the corresponding setup
> is done for the external interrupt lines, that is, setting up
> the INTPINx registers. Any hints?
> 
> thank you,
> Thomas
> 

Hi Thomas

No, these should remain in the Ethernet driver. Thats because no other 
driver depends on these. Those registers are MAC subsystem registers 
only. The ethernet driver does not do any interrupt setup for other 
devices. Lets take these registers one by one:

TITAN_GE_WRITE(0x0024, 0x04000024);    /* IRQ vector */

This register is to tell the MAC subsystem what IRQ vectors to use. If 
you dont configure this register, only the MAC subsystem cannot send 
interrupts to the processor. But, thats abt it.

TITAN_GE_WRITE(0x0020, 0x000fb000);    /* INTMSG base */

This register tells the MAC subsystem only where the INTMSG base is. So, 
if the MAC subsystem needs to send an interrupt, it can write the IRQ 
vector to the INTMSG register and uses this register to find the base of 
the INTMSG register. Thats all. If you dont configure this register, 
then only the MAC subsystem cannot send interrupts.

As far as external interrupts go, I think include/asm-mips/serial.h 
should indicate the serial interrupt used and 
arch/mips/pmc-sierra/yosemite/pci-irq.c should indicate the IRQ line 
that PCI uses. HT and MAC are based off message interrupts. If you are 
using Titan native UART, it is also based off message interrupts. And 
the interrupt config is done in arch/mips/pmc-sierra/yosemite/irq.c.

Is this what you wanted to know abt setting up the external interrupt lines?

Thanks
Manish Lachwani
