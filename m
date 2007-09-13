Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 14:46:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:6367 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021901AbXIMNqW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 14:46:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DDkLDW018578;
	Thu, 13 Sep 2007 14:46:21 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DDkLrK018577;
	Thu, 13 Sep 2007 14:46:21 +0100
Date:	Thu, 13 Sep 2007 14:46:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: pci-to-pci bridges on ip32
Message-ID: <20070913134621.GB9125@linux-mips.org>
References: <1189536946.7988.62.camel@scarafaggio> <20070912232015.GJ4571@linux-mips.org> <1189687699.7506.18.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1189687699.7506.18.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 02:48:19PM +0200, Giuseppe Sacco wrote:

> Il giorno gio, 13/09/2007 alle 00.20 +0100, Ralf Baechle ha scritto:
> [...]
> > Can you give a few more details on the sympthom with this card on IP32?
> > 
> >   Ralf
> 
> I have an SGI O2 with an R5000 CPU, 1 SCSI CD-ROM, 2 SCSI disks, 128Mb
> of RAM and a PCI ethernet card. I replaced the PCI card with this new
> board, but it seems the board is listed but otherwise ignored. The only
> trace is in lspci output. There isn't a list of devices in the other
> side of this PCI-to-PCI chip.
> 
> # lspci
> 00:01.0 SCSI storage controller: Adaptec AIC-7880U
> 00:02.0 SCSI storage controller: Adaptec AIC-7880U
> 00:03.0 PCI Bridge: Netmos technology Unknown device 9250
> (The card vendor and product are IDs 9710:9250.)
> 
> When I plug the card on an i386 machine, it is recognised since lspci
> display the card and all three devices present on the same card (devices
> accessible via the PCI-to-PCI bridge). All these devices are available
> to udev, so udev start all relevant drivers.
> 
> I started checking my kernel config. Do I have to activate any specific
> CONFIG_?? option in order to use such a card (beside the driver for all
> devices).

I got a quad Tulip card on my Malta here and that works fine:

# lspci
00:0a.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:0a.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:0a.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:0a.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 43)
00:0c.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)
00:11.0 Host bridge: Unknown device df53:0001 (rev 97)
00:12.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
00:13.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 23)
01:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
01:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
01:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
01:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
#


> I am using kernel 2.6.18 on both machines, as shipped with Debian
> stable.

I wonder if somebody hacked that kernel to just scan the PCI bus.  That
means it would trust whatever the ARCS firmware has setup and ARCS is
definately broken, doesn't know how to handle PCI-to-PCI bridges and will
just skip over them.  Exactly what you observe.

  Ralf
