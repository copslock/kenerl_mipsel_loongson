Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 18:02:36 +0200 (CEST)
Received: from p508B4F39.dip.t-dialin.net ([80.139.79.57]:15072 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123926AbSJWQCf>; Wed, 23 Oct 2002 18:02:35 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9NG2Me32422;
	Wed, 23 Oct 2002 18:02:22 +0200
Date: Wed, 23 Oct 2002 18:02:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: KSeg0 coherency policy selection.
Message-ID: <20021023180222.B27187@linux-mips.org>
References: <AEC4671C8179D61194DE0002B328BDD2070C8C@ATLOPS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <AEC4671C8179D61194DE0002B328BDD2070C8C@ATLOPS>; from dinesh_nagpure@ivivity.com on Wed, Oct 23, 2002 at 06:47:27AM -0400
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 23, 2002 at 06:47:27AM -0400, Dinesh Nagpure wrote:

> I am almost done with my porting of kernel 2.4.16 to our platform using
> RM5231A. But I had to make a couple of very basic hacks and I am trying to
> understand if there is any way I can avoid them.
> First the memcpy wouldn't work for me properly, both the compiler generated
> and also the one under arch/mips/lib/memcpy.c, so I had to change the lib
> version to do byte copy. I know this is a very crude change but things
> worked.

Memcpy.c?  I assume that's a typo.  We retired the C version of memcopy like
5 years ago.  Memcpy.S recently received a few fixes but those were only
rather estotheric special cases; chances are these bugs are not what's
hitting you.

> Second, the Kseg0 coherency algorithm selection in the function
> ld_mmu_r4xx0( ) seems to be improper for RM5231A, This function sets the CP0
> config register K0 field to 3 which as per RM5231A user manual is Cacheable,
> noncoherent, write back policy Should this not be set to 0, which is
> cacheable, non-coherent, write-through, no write allocate? 

Caching algorithem 3 is should be right for every uniprocessor MIPS system.
The only cache coherency attributes that are standard accross all MIPS CPUs
are modes 2 and 3.

> Also from the knowledge base I understand there is a cache aliasing problem
> associated with RM5231A when page size is set to 4KB. The document
> recommends to invalidate the cache before retiring a virtual page OR
> coloring of the pages. Can someone tell me if this fix is already taken care
> of? For me when I enable caching under "Kernel hacking" my kernel crashes
> with page fault, when it tries to run bin/init, consistently.

There have been fixes in that are as well since 2.4.16 but nothing that
explains crashes as early as when booting init.

  Ralf
