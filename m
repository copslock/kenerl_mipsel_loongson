Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 19:34:19 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:14518
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225971AbUDXSeS>; Sat, 24 Apr 2004 19:34:18 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3OIYCN18048
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 20:34:12 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 20:34:11 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3OIYAc14095
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 20:34:10 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 20:34:10 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: Xtalk bridge IRQs
In-Reply-To: <20040424181959.GB21153@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404242028250.13768-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> The way that PCI interrupts work on IP27 is: A device's INTA pin is
> connected to the BRIDGE ASIC.

Only INTAs? Does each INTA of a device have a dedicated pin on the bridge
(I am not sure, but it seems so)?

> When a device's interrupt line is asserted, the bridge ASIC will store
> a value which consists of 0x100 | intnum into another register; the
> address of that other register can be configured per device in the
> BRIDGE chip.  The value is usuall the xtalk address of another
> register in the HUB ASIC.  For HUB the value 0x100 | intnum would mean
> to set bit intnum in the interrupt pending register.

OK, I figured that out from the IRIX headers. Apparently, HEART does it
the same way, only the register is at 0x80 and not 0x90.

> The BRIDGE chip can also be configured to send an interrupt clear
> packet if the PCI interrupt is deasserted again; it's a good idea to
> have this enabled since otherwise writing race-free interrupt handlers
> is a PITA.  The HUB chip then asserts one of the CPU interrupt lines
> if a bit is set in the interrupt pending register and mask0/mask1
> register for the CPU.

It is very similar to the HEART, then. But I didn't know about clear
packets.

> For a single node system this could be slightly simplified - no idea if
> SGI did that for the HEART design.  Anyway, in case of an Origin you'd
> have to chase the interrupt through the various stages of processing:
>  - Interupt sent from the device?

Well, I don't know... Should I take out my logic analyzer?

>  - Interrupt asserted at BRIDGE?

I don't know this, either.

>  - Interrupt bit set in HUB chip?

Well, if anything is asserted at the bridge, all the following steps are
correctly executed. It's a problem around the IOC. Could you please tell
me, how are IOC packets transmitted? What is the relation of this to the
interrupts?

I have tried to run NFSRoot, but the machine sends no packets, even though
it believes firmly that it sends (i.e. no error messages).

> I hope that's somehow applicable to the IP30 ...

So do I :)

Stanislaw Skowronek
