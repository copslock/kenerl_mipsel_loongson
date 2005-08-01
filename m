Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 09:18:08 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:33301 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225011AbVHAIRs>; Mon, 1 Aug 2005 09:17:48 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j718Kq4P001901;
	Mon, 1 Aug 2005 09:20:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j717pOMh002088;
	Mon, 1 Aug 2005 08:51:24 +0100
Date:	Mon, 1 Aug 2005 08:51:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: how to access structured registers correctly
Message-ID: <20050801075124.GA1972@linux-mips.org>
References: <20050726182531.6341586f.Hiroshi_DOYU@montavista.co.jp> <20050726190643.GD7088@linux-mips.org> <17127.14246.112209.239338@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17127.14246.112209.239338@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 27, 2005 at 08:28:38AM +0100, Dominic Sweetman wrote:

> > > In tx4938, every register access is done by using "volatile" like below.
> > 
> > Linus is right, volatile is a dangerous thing.  If you want to write
> > portable code there's a bunch of things that are not being taken care of
> > by plain C - even though in my opinion foo->somereg = 42 is more
> > readable than writel(somereg, 42).  Among the things the pointer to
> > volatile struct method doesn't catch are endianess conversion that might
> > be necessary on some systems, write merging, dealing with write buffers
> > or completly insane methods of attaching the bus such as the infamous
> > ISA / EISA cage that's attached to the host system through a USB
> > interface.
> 
> Yes, this is far outside the compiler's reach.
> 
> All of which suggests that it would make sense to define a standard function
> which:
> 
> o will produce just one fixed-width write cycle to the destination;
> 
> o will deliver the data ordered so that the MSB of the C value is on
>   the "most significant" bit of the device's data bus, usually the
>   highest numbered bit (this doesn't solve all device endianess
>   issues, but it gives you a well-defined place to start solving them);
> 
> o has a variant which returns only after some indication that the
>   data was delivered;
> 
> The implementation of this function can then conceal the details of
> the CPU and interconnect.
> 
> Such a function should probably not be called "writel()" because that
> sounds like "write long", and "long" is not a fixed-size data type,
> which undermines the promises above...  Tediously, you probably need
> "writei32()", "writei16()", "writei8()"...

Linux has a long tradition of grossly missnaming things, so readw reads
16-bit words, readl reads 32-bit words and readq 64-bit words, that is
each of them operates on just half the quantity a MIPS programmer would
expect. Same for writew, writel and writeq.  Blame the Intel guys for it ;-)

Ranting about grossly missnaming things, the DMA API calls coherent what
MIPS calls non-coherent and vice versa.  I'll stop now, birds are
whistling way to nice behind The Fruit Farm for me to write a good rant
today ;-)

There are ioread8, ioread16, ioread32, iowrite8, iowrite16, iowrite32
already except they're primarily used with I/O busses such as PCI but
that's not really an issue.

   Ralf
