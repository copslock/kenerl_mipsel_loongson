Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 13:10:52 +0100 (BST)
Received: from p508B7FA0.dip.t-dialin.net ([IPv6:::ffff:80.139.127.160]:32692
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTDKMKw>; Fri, 11 Apr 2003 13:10:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3BCAjA25350;
	Fri, 11 Apr 2003 14:10:45 +0200
Date: Fri, 11 Apr 2003 14:10:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@mips.com>, Mike Uhler <uhler@mips.com>,
	Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030411141045.A24953@linux-mips.org>
References: <20030410220906.B519@linux-mips.org><200304102028.h3AKSf211575@uhler-linux.mips.com><20030410225212.A3294@linux-mips.org> <16022.24992.314581.716649@gladsmuir.mips.com> <004a01c30002$b3b19480$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <004a01c30002$b3b19480$10eca8c0@grendel>; from kevink@mips.com on Fri, Apr 11, 2003 at 10:15:06AM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 11, 2003 at 10:15:06AM +0200, Kevin D. Kissell wrote:

> > > > I'm not sure what you mean by TLB translations required for hit
> > > > cacheops.  If you mean the Index Writeback or Index Invalidate
> > > > functions, note that you can (and should) use a kseg0 address to
> > > > do this.
> > 
> > Mike was proposing a kseg0 address translating to the right physical
> > address, and used with a hit-type cacheop.  I believe Ralf (and Linux)
> > are just assuming that's no good because it doesn't work if you have
> > cacheable memory above 512Mbytes physical address.
> 
> More importantly, it doesn't work in the case of virtually tagged caches,
> such as those in the SB-1 and MIPS 20K.

On SB1 we just switch to a new ASID which effectivly is a cheap way to
invalidate the entire I-cache.  Assuming the other process has at most
4k of code resident in the I-cache from it's previous timeslice this
even is the optimal solution.  But this optimization is a heuristic that
hasn't been verified to be optimal for performance.

> > I wonder whether anything really bad would happen if you temporarily
> > changed the (machine) ASID to that of the address space you wanted to
> > invalidate?
> 
> I looked at that when we were investigating the aforementioned
> issues with virtually-tagged I-caches.  It looked to me as if exceptions
> can occur during the invalidation, and that processing those exceptions
> can cause signals to be raised to the current process in a manner that 
> assumes that the TLB and ASID are coherent and in sync with 
> the scheduler.  It may be that just changing the ASID temporarily
> would work - most of the time.  It may even be that, with a bit
> of lashing down of state, disabling of interrupts, setting of flags
> to be read by traps.c/signal.c, etc, etc, it could be made bulletproof.
> But I don't think that the simple, obvious hack is safe.

Yep - it seems like a can of worms sufficiently large to be left closed
for 2.4 ...

  Ralf
