Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2003 21:09:26 +0100 (BST)
Received: from snowman.net ([IPv6:::ffff:66.93.83.236]:21768 "EHLO
	relay.snowman.net") by linux-mips.org with ESMTP
	id <S8225396AbTJSUJW>; Sun, 19 Oct 2003 21:09:22 +0100
Received: from ns.snowman.net (ns.snowman.net [10.10.0.2])
	by relay.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id h9JK9Dtg001329;
	Sun, 19 Oct 2003 16:09:13 -0400
Received: from ns.snowman.net (localhost [127.0.0.1])
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id h9JK9DOu011556;
	Sun, 19 Oct 2003 16:09:13 -0400
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id h9JK99ra011552;
	Sun, 19 Oct 2003 16:09:10 -0400
X-Authentication-Warning: ns.snowman.net: nick owned process doing -bs
Date: Sun, 19 Oct 2003 16:09:09 -0400 (EDT)
From: Nick <nick@snowman.net>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: MIPS addressing limits, Was: Re: CVS Update@-mips.org: linux
In-Reply-To: <20031015145948.GB23514@linux-mips.org>
Message-ID: <Pine.LNX.4.21.0310191608450.11837-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <nick@snowman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nick@snowman.net
Precedence: bulk
X-list: linux-mips

If anyone wants to poke said folks into handing in the OK I'll ship
someone an R8k I2 to work on.
	Nick

On Wed, 15 Oct 2003, Ralf Baechle wrote:

> On Wed, Oct 15, 2003 at 04:23:06PM +0200, Maciej W. Rozycki wrote:
> 
> > > Still want more?  A 3 level tree would then cover 128TB of virtual
> > > address space already exceedin the hardware limits of all processors but
> > > the R8000.
> > 
> >  Well, the MIPS64 ISA spec allows up to 8EB of user memory to be supported
> > by an implementation, IIRC; probably nothing supports that much yet,
> > though. ;-)  BTW, is an R8000 spec available online anywhere?
> 
> There used to be a few papers published by SGI online and various other
> bits of information I found through google.
> 
> (I happen to have a paper copy of the R8000 manual but since the responsible
> people still haven't informed me if I can legally use it, this book is
> closed and will stay closed until this happens - if ever ...  Pitty, I
> still receive mails from various R8000 users ...)
> 
> > > 64k pagesize stretches the limits even further.   Here a two level
> > > pagetable tree would cover 4TB, 3-level could cover 32PB exceeding
> > > the capacity of every MIPS processor ever made - and probably sufficient
> > > for the coming decade :-)
> > 
> >  Further increasing of the page size should result in better performance
> > due to fewer TLB misses and reduce the memory footprint of page tables,
> > but the drawback is more memory is wasted for maps.  Whether the end
> > result is a gain or a loss depends on the actual application of a system,
> > so I guess we should either leave the size configurable (with a sane
> > default for those who might have troubles judging what would suit them
> > best) or only decide on a given size after lots of benchmarking.
> 
> Unless somebody yells I almost feel like ditching 3-level pagetable
> support; 2-levels with a decent pagesize should suffice for a few years
> to come ...
> 
>   Ralf
> 
