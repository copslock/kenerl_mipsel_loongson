Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 19:20:41 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:28253
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225971AbUDXSUk>; Sat, 24 Apr 2004 19:20:40 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3OIKJxT022689
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 20:20:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3OIJxCs022683;
	Sat, 24 Apr 2004 20:19:59 +0200
Date: Sat, 24 Apr 2004 20:19:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: Xtalk bridge IRQs
Message-ID: <20040424181959.GB21153@linux-mips.org>
References: <Pine.GSO.4.10.10404241914160.10450-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404241914160.10450-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 07:14:32PM +0200, Stanislaw Skowronek wrote:

> I've got a problem with Xtalk-PCI bridge IRQs. The IOC3 should send an
> interrupt before transmitting a packet. I don't know if it sends it or
> not, but for sure it does not arrive to me. The power button interrupt,
> which is also routed via the bridge, works OK, so the IRQ router part of
> the bridge is correctly services. However, I can't get any PCI interrupts.

The way that PCI interrupts work on IP27 is: A device's INTA pin is
connected to the BRIDGE ASIC.  When a device's interrupt line is asserted,
the bridge ASIC will store a value which consists of 0x100 | intnum into
another register; the address of that other register can be configured per
device in the BRIDGE chip.  The value is usuall the xtalk address of another
register in the HUB ASIC.  For HUB the value 0x100 | intnum would mean to
set bit intnum in the interrupt pending register.  The BRIDGE chip
can also be configured to send an interrupt clear packet if the PCI
interrupt is deasserted again; it's a good idea to have this enabled since
otherwise writing race-free interrupt handlers is a PITA.  The HUB
chip then asserts one of the CPU interrupt lines if a bit is set in the
interrupt pending register and mask0/mask1 register for the CPU.

For a single node system this could be slightly simplified - no idea if
SGI did that for the HEART design.  Anyway, in case of an Origin you'd
have to chase the interrupt through the various stages of processing:

 - Interupt sent from the device?
 - Interrupt asserted at BRIDGE?
 - Interrupt bit set in HUB chip?
 - Interrupt enabled in HUB mask register?
 - Interrupt pending in the CPU's cause register?
 - Interrupt bit set and EXL and ERL both clear in CPU status register?

I hope that's somehow applicable to the IP30 ...

  Ralf
