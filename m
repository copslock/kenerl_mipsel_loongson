Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 21:52:18 +0100 (BST)
Received: from p508B62A5.dip.t-dialin.net ([IPv6:::ffff:80.139.98.165]:21672
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTDJUwS>; Thu, 10 Apr 2003 21:52:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3AKqCU03734;
	Thu, 10 Apr 2003 22:52:12 +0200
Date: Thu, 10 Apr 2003 22:52:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Uhler <uhler@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: way selection bit for multi-way cache
Message-ID: <20030410225212.A3294@linux-mips.org>
References: <20030410220906.B519@linux-mips.org> <200304102028.h3AKSf211575@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304102028.h3AKSf211575@uhler-linux.mips.com>; from uhler@mips.com on Thu, Apr 10, 2003 at 01:28:41PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 10, 2003 at 01:28:41PM -0700, Mike Uhler wrote:

> > Yep, of the existing variations that was certainly the nicest.  Only a
> > single function had to be taught about multi-way caches and that only
> > because it's a bit hard to flush caches for another process due to the
> > TLB translation required for the hit cacheops.  Alternative schemes need
> > more support by the code.
> 
> I'm not sure what you mean by TLB translations required for hit cacheops.
> If you mean the Index Writeback or Index Invalidate functions, note that
> you can (and should) use a kseg0 address to do this.  This bypasses
> the TLB, while still giving you the index that you want.  We simply
> OR the kseg0 base address into the index that we've calculated and
> use that as the argument to the CACHE instruction.  There's actually
> words to this effect in the MIPS32/MIPS64 spec, but it is, perhaps,
> not clear enough.

Linux has a flush_cache_page() cache operation which is used to invalidate
a page given by a virtual user-space address.  That page might be the
page of a current processor which is the easy case - it might also belong
to another process.  In the later case the TLB would miss-translate
the virtual address because the translation in the TLB is actually for
the current process.  So this is what we're doing then:

[...]
        /*
         * Do indexed flush, too much work to get the (possible) TLB refills
         * to work correctly.
	 *
	 * Note: page is the physical address of the page to invalidate.
         */
        page = (KSEG0 + (page & (dcache_size - 1)));
	/*
	 * The following two flush operations have to flush the page from
	 * all cache ways!
	 */
        blast_dcache_page_indexed(page);
        if (exec)
                blast_icache_page_indexed(page);
[...]

This can be a rather expensive operation in particular for caches with
a high degree of associativity.  The worst case would be something like
a page containing code for a processor with a 32k 8-way associative
caches where we'd have to flush the entire cache - costly overkill and
the refills might be even slower ...

  Ralf
