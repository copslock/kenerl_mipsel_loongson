Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 14:03:55 +0000 (GMT)
Received: from p508B6FDE.dip.t-dialin.net ([IPv6:::ffff:80.139.111.222]:48851
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225206AbTBEODz>; Wed, 5 Feb 2003 14:03:55 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h15E3eR13181;
	Wed, 5 Feb 2003 15:03:40 +0100
Date: Wed, 5 Feb 2003 15:03:40 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Tibor Polgar <tpolgar@freehandsystems.com>,
	Jason Ormes <jormes@wideopenwest.com>,
	linux-mips@linux-mips.org
Subject: Re: kernel boot error.
Message-ID: <20030205150339.A13033@linux-mips.org>
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com> <3E406ABC.A9D0D6F@freehandsystems.com> <20030205030625.GM27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205030625.GM27302@pureza.melbourne.sgi.com>; from clausen@melbourne.sgi.com on Wed, Feb 05, 2003 at 02:06:25PM +1100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 02:06:25PM +1100, Andrew Clausen wrote:

> >   If so, i do
> > recall we had to do some special casing to get the card to work correctly. 
> 
> Yeah, that would be right.  Have you had a look at pci_fixup_ioc3()?
> (That's the network card that seems to come with the Origin 200).  I
> bet it's something similar.

Pci_fixup_ioc3() is only necessary for the IOC3 nic.  It's a PCI board
that's about as broken are it only can be.  The board runs on in PCI busses
clocked at 33MHz.  It only partially decodes the PCI config address space.
Attempted access to one of the nimplemented registers of the IOC3 will
result in access to another register.  That's too buggy for any OS to cope
with without that special kludge pci_fixup_ioc3.

> Just, the base address the card (PCI bus?) is spitting out is very odd:
> 
> 	eth0: SGI AceNIC Gigabit Ethernet at 0xfe7fc000, irq 8
> 
> The card is in slot 6, so I'd expect the base address to be 0x8900000.
> Anyway, it dies on this:

Query the address using the usual Linux PCI bus stuff from <linux/pci.h>.
Anything else is doomed, especially guessing ...

  Ralf
