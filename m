Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 19:55:43 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:52317
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225971AbUDXSzk>; Sat, 24 Apr 2004 19:55:40 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3OItJxT023463
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 20:55:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3OIsx78023456;
	Sat, 24 Apr 2004 20:54:59 +0200
Date: Sat, 24 Apr 2004 20:54:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: Xtalk bridge IRQs
Message-ID: <20040424185459.GA23008@linux-mips.org>
References: <20040424181959.GB21153@linux-mips.org> <Pine.GSO.4.10.10404242028250.13768-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404242028250.13768-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 08:34:10PM +0200, Stanislaw Skowronek wrote:

> > The way that PCI interrupts work on IP27 is: A device's INTA pin is
> > connected to the BRIDGE ASIC.
> 
> Only INTAs? Does each INTA of a device have a dedicated pin on the bridge
> (I am not sure, but it seems so)?

If I recall right the INTA-INTD pins of each devices are logically or'ed
together.  Since IOC3 only uses INTA this simple fact doesn't really matter
to us anyway ...

> > The BRIDGE chip can also be configured to send an interrupt clear
> > packet if the PCI interrupt is deasserted again; it's a good idea to
> > have this enabled since otherwise writing race-free interrupt handlers
> > is a PITA.  The HUB chip then asserts one of the CPU interrupt lines
> > if a bit is set in the interrupt pending register and mask0/mask1
> > register for the CPU.
> 
> It is very similar to the HEART, then. But I didn't know about clear
> packets.

If BRIDGE isn't configured to send clear packets the interrupt needs to be
clear manually by a processor write to the HUB's register.  Leaving that
to the hardware is just simpler.

> > For a single node system this could be slightly simplified - no idea if
> > SGI did that for the HEART design.  Anyway, in case of an Origin you'd
> > have to chase the interrupt through the various stages of processing:
> >  - Interupt sent from the device?
> 
> Well, I don't know... Should I take out my logic analyzer?

Let's wait with the big guns :)

> >  - Interrupt asserted at BRIDGE?
> 
> I don't know this, either.

You can verify by reading the pending register.

> >  - Interrupt bit set in HUB chip?
> 
> Well, if anything is asserted at the bridge, all the following steps are
> correctly executed. It's a problem around the IOC. Could you please tell
> me, how are IOC packets transmitted? What is the relation of this to the
> interrupts?
> 
> I have tried to run NFSRoot, but the machine sends no packets, even though
> it believes firmly that it sends (i.e. no error messages).

IOC3 is basically your average mid-90s 100BaseT NIC.  If you know some other
NIC like for example a PCnet32, they're basically similar in their
fundamental concepts such as RX/TX rings.

An IOC3 TX ring consists of entries which each are 128 bytes long.  Each
contains a few status etc. bits, a few bytes that could be used to store a
small packet (ioc3-eth.c uses this) and two 64-bit pointers to actual
packet data.  IOC3 has the ugly constraint of not supporting transmit of
packets that cross a 16kB page boundary.  In that case of such a packet we
use the pointer to the second fragment, otherwise only the first.

IP27 support 32-bit mapped DMA which Linux doesn't support yet, so only
64-bit PCI devices will work atm.  For those the upper 16 bit specify extra
attributes which you'll find in include/asm-mips/pci/bridge.h which again
is just a copy of the IRIX <PCI/bridge.h>.

I think the way we use those bits should also be aplicable to IP30 but I'm
not sure never having seen any material on the machine.  You may want to
try to figure out what value the firmware uses when configuring the IOC3
for netbooting.

Does link negotiation and reading the MAC address from the NIC (Number In
a Can, that coin battery like Dallas chip near the IOC3) work?  At least
link negotiation would have to work before you'd have any chance to see
any packets.

  Ralf
