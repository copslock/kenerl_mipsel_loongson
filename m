Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 19:30:00 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6158 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225272AbULOT3v>; Wed, 15 Dec 2004 19:29:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AED26F5985; Wed, 15 Dec 2004 20:29:31 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31483-07; Wed, 15 Dec 2004 20:29:31 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6E731F5982; Wed, 15 Dec 2004 20:29:31 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBFJTj0m016838;
	Wed, 15 Dec 2004 20:29:45 +0100
Date: Wed, 15 Dec 2004 19:29:34 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
In-Reply-To: <20041215184213.GB32491@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412151846190.2706@blysk.ds.pg.gda.pl>
References: <20041211134305.22769.qmail@server212.com> <20041215135656.GA28665@linux-mips.org>
 <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl>
 <20041215164036.GC30130@linux-mips.org> <Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl>
 <20041215184213.GB32491@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/617/Sun Dec  5 16:25:39 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Dec 2004, Ralf Baechle wrote:

> >  I know and I consider it a bug.  The correct way would be setting the 
> > start at 0 and if avoiding the first kB of space was necessary, setting 
> > PCIBIOS_MIN_IO to 0x1000.
> 
> PCIBIOS_MIN_IO is the same value for all busses.  That can turn out a bit

 ???  It's a variable and the IP32 port already modifies it.

> kludgy so I'm not much of a friend of it.

 Probably the best way of dealing with an incomplete resource setup.  
There is nothing wrong with setting BARs in the first kB of I/O space, but
this way you may overlay an unregistered ISA-bridge device with another
one.  Of course it's PCI-ISA bridges that should have BARs for their
resources, but I guess it's not going to happen.  Though perhaps they
could be created artificially in our PCI layer...

> >  I think it's going to matter if a PCI-ISA bridge is behind one or more
> > PCI-PCI bridges.  I have an idea of a fix, but my initial approach haven't
> > worked particularly well and I've had no time to dig into it further.  
> > Actually, on systems with PCI I think reserving legacy resources should
> > happen only after they have been discovered (you don't need any PC/AT or
> > ISA devices for a PCI configuration space scan), but that may be tough, so
> > I've thought of an alternative.
> 
> The evil about legacy devices is "they're just there".  That is you have
> to know about their existence and in some case can't even do real probing
> or the device will react in really nasty ways.

 No need to probe.  The PCI-ISA bridge should reserve the entire
motherboard I/O range of 0x00 - 0xff plus any other non-ISA one that it 
knows it uses.  ISA I/O ranges (with bits 8 or 9 non-zero) are already 
excluded implicitly.

> The existence of an ELCR register is not documented for this machine.

 What kind of PCI-ISA bridge is it?  You need ELCR whenever you want to
route PCI interrupts to some of i8259A inputs to set the trigger mode
correctly.  It's an EISA invention -- with the original i8259A you could 
only set up the trigger mode globally per chip (using ICW1).

> Anyway, the approach I've choosen is safe even we it exists.

 Have you tried with a PCI-PCI bridge in the middle?  Or do you have a
theoretical proof our code handles it right? ;-)

> >  There is one more problem with the PCI resource manager -- it messes with
> > BARs of host bridges without asking for permission (which is often a
> > no-no, as any messing with host bridges in general).  I have a patch for
> > it I'm currently trying to push to the PCI maintainer.  See the thread at
> > "http://www.uwsg.iu.edu/hypermail/linux/kernel/0412.1/0484.html" if
> > interested.  It's already being done correctly for i386 (some would
> > probably argue that's what's most important) and ppc which use their own
> > resource managers instead of the generic one.
> 
> That's a problem on many system controllers such as the GT-64120, all the
> other Galileo / Marvell stuff and more.  The hackish solution of doing it
> in the pci_ops we're currently isn't a good one.

 Sure -- I have a couple of reverts for these hacks ready.

> A comment on your patch.  For most configurations it's ok and certainly
> better than hacking the pci_ops.  At least on the GT-64120 it's possible
> to configure the device as a memory device and that will make your patch

 That's intended.  If it's not a host bridge (implying it's an option
device/card) it should not be treated as such.

> fail.  Also there is the case where the GT-64120 or similar system
> controllers are used on a PCI card.  For the CPU on the card it'll be
> the host bridge; for the host system just yet another PCI device.

 Well in case of PCI cards they really should have their class codes set
to something different from a host bridge.  AFAIK PCI is not meant as a
star interconnect between hosts -- it's meant to have a tree topology
rooted at a host bridge (that may be a bit different with the introduction
of HyperTransport and its dual-hosted chains, but it's probably too early
to worry about it).  Of course you may have multiple host bridge devices
in a system with peer host bridges, but then you just have multiple PCI
buses with no path connecting them.

 Anyway if a setup with host bridges as option devices really existed, it
should probably be handled by the CPU and the associated firmware running
behind such bridges and if that was impossible, then by the driver for the
device.  Do you think such a setup is probable?  How about putting such an
option into an i386-based system?  It would skip BARs on host bridges
anyway. ;-)

  Maciej
