Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 18:42:35 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:34583
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225272AbULOSm3>; Wed, 15 Dec 2004 18:42:29 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFIgDFj001469;
	Wed, 15 Dec 2004 19:42:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFIgDXx001468;
	Wed, 15 Dec 2004 19:42:13 +0100
Date: Wed, 15 Dec 2004 19:42:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: wlacey <wlacey@goldenhindresearch.com>, linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
Message-ID: <20041215184213.GB32491@linux-mips.org>
References: <20041211134305.22769.qmail@server212.com> <20041215135656.GA28665@linux-mips.org> <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl> <20041215164036.GC30130@linux-mips.org> <Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 15, 2004 at 05:17:14PM +0000, Maciej W. Rozycki wrote:

>  I know and I consider it a bug.  The correct way would be setting the 
> start at 0 and if avoiding the first kB of space was necessary, setting 
> PCIBIOS_MIN_IO to 0x1000.

PCIBIOS_MIN_IO is the same value for all busses.  That can turn out a bit
kludgy so I'm not much of a friend of it.

> > This makes it look like the legacy ports are not behind the PCI bus
> > which actually they are but that's a minor nit, it gets the address
> > space allocation to work right.
> 
>  I think it's going to matter if a PCI-ISA bridge is behind one or more
> PCI-PCI bridges.  I have an idea of a fix, but my initial approach haven't
> worked particularly well and I've had no time to dig into it further.  
> Actually, on systems with PCI I think reserving legacy resources should
> happen only after they have been discovered (you don't need any PC/AT or
> ISA devices for a PCI configuration space scan), but that may be tough, so
> I've thought of an alternative.

The evil about legacy devices is "they're just there".  That is you have
to know about their existence and in some case can't even do real probing
or the device will react in really nasty ways.

The existence of an ELCR register is not documented for this machine.
Anyway, the approach I've choosen is safe even we it exists.

>  Also the map of legacy resources reserved is actually incomplete -- PIC's
> ELCR is missing for example.
> 
> > >  Things start being tricky once you have to use such an offset for DMA
> > > transfers as well...
> > 
> > True, but that's dealt with elsewhere.  And I never claimed the mess that
> > PCI used to be in 2.4 has yet been fully cleaned up yet, more work to do.
> 
>  Sure, I'm more or less happy about the new code.  I'm just warning about 
> possible pitfalls.
> 
>  There is one more problem with the PCI resource manager -- it messes with
> BARs of host bridges without asking for permission (which is often a
> no-no, as any messing with host bridges in general).  I have a patch for
> it I'm currently trying to push to the PCI maintainer.  See the thread at
> "http://www.uwsg.iu.edu/hypermail/linux/kernel/0412.1/0484.html" if
> interested.  It's already being done correctly for i386 (some would
> probably argue that's what's most important) and ppc which use their own
> resource managers instead of the generic one.

That's a problem on many system controllers such as the GT-64120, all the
other Galileo / Marvell stuff and more.  The hackish solution of doing it
in the pci_ops we're currently isn't a good one.

A comment on your patch.  For most configurations it's ok and certainly
better than hacking the pci_ops.  At least on the GT-64120 it's possible
to configure the device as a memory device and that will make your patch
fail.  Also there is the case where the GT-64120 or similar system
controllers are used on a PCI card.  For the CPU on the card it'll be
the host bridge; for the host system just yet another PCI device.

  Ralf
