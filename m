Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2003 18:19:27 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:15869 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225509AbTJORTP>;
	Wed, 15 Oct 2003 18:19:15 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h9FHJ2C08898;
	Wed, 15 Oct 2003 10:19:02 -0700
Date: Wed, 15 Oct 2003 10:19:02 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: MIPS addressing limits, Was: Re: CVS Update@-mips.org: linux
Message-ID: <20031015101902.C8761@mvista.com>
References: <20031014132850.GA12938@linux-mips.org> <Pine.GSO.3.96.1031015161040.9299D-100000@delta.ds2.pg.gda.pl> <20031015145948.GB23514@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031015145948.GB23514@linux-mips.org>; from ralf@linux-mips.org on Wed, Oct 15, 2003 at 04:59:48PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 15, 2003 at 04:59:48PM +0200, Ralf Baechle wrote:
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

Isn't ia64 still using 3-level page tables?  Any performance data we
can infer from theirs?

I feel a little uneasy about ditching 3-level pagetable altogether.
Leaving all the parameters configurable, including the possiblity of
nullifying the second level and changing page size, seems to be a more 
comforting thought.

Jun
