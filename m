Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 12:16:02 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:20376 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225072AbTLMMQB>;
	Sat, 13 Dec 2003 12:16:01 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBDCFRQG011009;
	Sat, 13 Dec 2003 13:15:27 +0100 (MET)
Date: Sat, 13 Dec 2003 13:15:28 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Vivien Chappelier <vivienc@nerim.net>,
	"Ilya A. Volynets-Evenbakh" <ilya@theIlya.com>, jsun@mvista.com,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6] PCI I/O region starting from zero is valid
In-Reply-To: <20031213032459.GE22448@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0312131312440.16545@waterleaf.sonytel.be>
References: <Pine.LNX.4.21.0312130147150.24966-100000@melkor>
 <20031213032459.GE22448@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 13 Dec 2003, Ralf Baechle wrote:
> On Sat, Dec 13, 2003 at 01:54:27AM +0100, Vivien Chappelier wrote:
> > 	PCI devices can have I/O mapped at a region starting from
> > 0x0000. The O2 actually has one of its onboard SCSI controller here...
> > This code looks like a incorrect copy/paste from the x86 code where this
> > I/O range is used by legacy ISA.
> >
> > --- arch/mips/pci/pci.c	2003-11-12 16:51:09.000000000 +0100
> > +++ arch/mips/pci/pci.c	2003-12-13 00:57:56.000000000 +0100
> > @@ -173,10 +173,6 @@
> >  			continue;
> >
> >  		r = &dev->resource[idx];
> > -		if (!r->start && r->end) {
> > -			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> > -			return -EINVAL;
> > -		}
> >  		if (r->flags & IORESOURCE_IO)
> >  			cmd |= PCI_COMMAND_IO;
> >  		if (r->flags & IORESOURCE_MEM)
>
> I tend to agree with Vivien.  There's another unsolved problem with
> pcibios_enable_device - how many resources should it enable?  Jun once
> changed it to PCI_NUM_RESOURCES but that broke other systems though it
> seems the logic thing to do ...

IMHO it should enable all resources, and you should add quirks for devices that
can't live with it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
