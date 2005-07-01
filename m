Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 13:55:03 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:28934 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226142AbVGAMyr>; Fri, 1 Jul 2005 13:54:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7D4F3E1CA5; Fri,  1 Jul 2005 14:54:34 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11271-05; Fri,  1 Jul 2005 14:54:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 517A0E1C8B; Fri,  1 Jul 2005 14:54:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j61CsbrY019400;
	Fri, 1 Jul 2005 14:54:37 +0200
Date:	Fri, 1 Jul 2005 13:54:44 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: RFH:  What are the semantics of writeb() and friends?
In-Reply-To: <1120218385.12446.16.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507011303190.30138@blysk.ds.pg.gda.pl>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD2@avtrex-server2.hq2.avtrex.com>
  <Pine.LNX.4.61L.0507011002520.30138@blysk.ds.pg.gda.pl>
 <1120218385.12446.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Alan Cox wrote:

> >  No it's not.  You need to insert appropriate barriers, one of: wmb(), 
> > mb() or rmb().  In rare cases you may need to use iob(), which is 
> > currently non-portable (which reminds me I should really push it 
> > upstream).
> 
> Its even more complicated than that 8)
> 
> writeb/writel may be merged in some cases (but not re-ordered) for I/O

 Is that non-reordering specified anywhere for the API or does it just 
happen to be satisfied by most implementations?  Ours (for MIPS, that is) 
for example does nothing to ensure that.

> devices but a simple mb() will only synchronize them as viewed from
> cpu/memory interface. There are two other synchronization points. From

 That's true -- which is why I mentioned bridge-specific operations may be 
required.

> the bridge with the I/O device (typically the PCI root bridge) which is
> not enforced automatically across processors on some large numa boxes
> but is not usually a problem and on the PCI bus itself.

 What if the host I/O bus is not PCI?  For this kind of stuff I tend to 
think in the terms of TURBOchannel systems, just to be sure not to get 
influenced by the most common hardware. ;-)

 E.g. I have this R4400-based TURBOchannel system with aggressive 
buffering in the CPU's MB (memory buffer) ASIC which requires a read-back 
(RAM is OK for that) after a write and a memory barrier only to make 
writes propagate to the I/O bridge.  It may be worse yet with TURBOchannel 
Alpha and VAX systems.  With the latters TURBOchannel is behind two 
bridges, with two intermediate buses on the way.

> PCI permits posting (delaying writes) and some forms of merging (but not
> re-ordering). Thus if you need an I/O to hit a device on the PCI bus and
> know it arrived you must follow it by a read from the same device. So
> for example if you want to shut down a DMA transfer and free the buffer
> for a PCI device you
> need to do
> 
> 		writel(TURN_DMA_OFF, dev->control);
> 		readl(dev->something);
> 		/* Only now is the free safe */

 Again, the I/O bus your host is attached to need not be PCI and you may 
need a bridge specific operation to make your write be completed, possibly 
combined with your quoted sequence (if there is actually PCI somewhere in 
the system; think AlphaServer 8400).

  Maciej
