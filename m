Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:13:00 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:46464 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225800AbUERVM7>; Tue, 18 May 2004 22:12:59 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BQBtG-00033R-00; Tue, 18 May 2004 22:12:46 +0100
Date: Tue, 18 May 2004 22:12:46 +0100
To: Kieran Fulke <kieran@pawsoff.org>
Cc: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518211246.GA11722@skeleton-jack>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518205914.GA29574@getyour.pawsoff.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 09:59:14PM +0100, Kieran Fulke wrote:
> On Tue, May 18, 2004 at 08:34:39AM +0100, Peter Horton wrote:
> 
> > 
> > Not quite so esoteric :-)
> > 
> > Try changing COBALT_QUBE_SLOT_IRQ from 23 to 9 in
> > include/asm/cobalt/cobalt.h.
> > 
> 
> alas, no joy.
> 
> <snip-snip>
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:09.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
>     ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:pio, hdd:pio
> spurious 8259A interrupt: IRQ9.
> 

That's strange, it worked here.

Did you a clean build ?

P.
