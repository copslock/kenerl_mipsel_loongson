Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 01:14:10 +0100 (BST)
Received: from p508B59C7.dip.t-dialin.net ([IPv6:::ffff:80.139.89.199]:6520
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225462AbUEMAOI>; Thu, 13 May 2004 01:14:08 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4D0E5xT020385;
	Thu, 13 May 2004 02:14:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4D0E5fT020384;
	Thu, 13 May 2004 02:14:05 +0200
Date: Thu, 13 May 2004 02:14:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: IOC3 interrupt management
Message-ID: <20040513001405.GC18513@linux-mips.org>
References: <Pine.GSO.4.10.10405111949550.8069-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10405111949550.8069-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 11, 2004 at 07:56:40PM +0200, Stanislaw Skowronek wrote:

> Well, there is a problem _again_. This time it's a purely conceptual one.
> 
> The IOC3 on Octanes (maybe on Onyx2es, too) controls the Ethernet, 
> keyboard, mouse, serial and parallel ports and SGI alone knows what else.
> 
> It is also tied to (at least) two bridge interrupts. One is used solely
> for Ethernet, and the other one is used for all the SuperIO stuff.
> 
> Well, I'm an educated man (when it comes to Octane internals, that is)
> and I know that the first interrupt is 2 and the other is 4, and that they
> map to IRQ10 and IRQ12, respectively. But how should the poor kernel know
> about such arcanes? There is not a word in the IOC3 registers about this
> weird connection so the PCI drivers don't know about it at all.
> 
> Now this is not a problem - I could simply assume that all IOC3s will have
> another IRQ at irq_num+2. But, MENET of course is build of four IOC3s and
> is definitely arranged in some other way. And what about the single IOC3
> cards? Do they have the other IRQ at all, or don't they allow using
> SuperIO?

PCI only permits INTA that is a single interrupt for normal devices.  In
good old tradition of violating the PCI spec the IOC3 has two interrupt
pins.  IP27 and IOC3 cards INTA and INTB are wired together, so we're back
to PCI compliance, no problem ...

So, Octane is different ...  I suggest you treat ethernet as a normal PCI
device - the Linux PCI code doesn't know how to handle anything else.  Then
in ioc3-eth.c itself you can register the serial interface with 8250.c
and using the appropriate interrupt number.  Everything along the lines of
MENET - but of course different ;-)

  Ralf
