Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 21:25:48 +0100 (BST)
Received: from p508B7E12.dip.t-dialin.net ([IPv6:::ffff:80.139.126.18]:40561
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225074AbUGWUZo>; Fri, 23 Jul 2004 21:25:44 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6NKOePD004232;
	Fri, 23 Jul 2004 22:24:40 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6NKOdtO004231;
	Fri, 23 Jul 2004 22:24:39 +0200
Date: Fri, 23 Jul 2004 22:24:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Srinivas Kommu <kommu@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: mips32 kernel memory mapping
Message-ID: <20040723202439.GA3711@linux-mips.org>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com> <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 23, 2004 at 01:51:34PM +0200, Maciej W. Rozycki wrote:

> > Can a 32-bit mips kernel access beyond KSEG0 contiguously? I have a Sibyte 
> > 1250 with 1 Gig RAM, but only 256 MB is located at phyical 0x0. The rest is 
> > all located at 0x8000_0000. Does that mean the kernel can access only 256 
> > meg contiguously? Do I need to enabled CONFIG_HIGHMEM to even reach the 
> > remaining RAM? It appears Highmem gives me only a 4 meg window at a time. 
> 
>  The BCM1250A is a 64-bit processor.  What's the problem with using 64-bit
> Linux avoiding the hassle altogether?

There is a general perception among Linux users that 64-bit is new an
not really needed which in part I blame on the bs Intel is spreading to
hide the fact that for a long time they simply had no 64-bit roadmap at
all.

> > Can't I set up a page mapping into KSEG2 for the rest of the memory? KSEG2 
> > seems to be unused from what I read.
> 
>  KSEG2 is used for modules.

There are still improvments to be made for BCM1250 support.  Somebody
thought scattering the first 1GB of memory through the lowest 4GB of
physical address space like a three year old his toys over the floor
was a good thing ...  The resulting holes in the memory map are wasting
significant amounts of memory for unused memory; the worst case number
that is reached for 64-bit kernel on a system with > 1GB of RAM is 96MB!
                                                                                
> > Can't I set up a page mapping into KSEG2 for the rest of the memory? KSEG2
> > seems to be unused from what I read.
>
>  KSEG2 is used for modules.
                                                                                
Right.  A part of KSEG2 could be used for mapping more low-memory but
that's only really an interesting option for 32-bit processors and would
only raise the theoretical limit from 512MB (256 on BCM1250) to somewhat
less than 1.5GB (BCM1250: 1.25GB) at the cost of address space for
vmalloc & ioremap.  It's a pretty pointless exercise when there are
still terabytes of unmapped 64-bit address space available.
                                                                                
  Ralf
