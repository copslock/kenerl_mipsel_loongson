Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2004 02:53:38 +0100 (BST)
Received: from p508B68D1.dip.t-dialin.net ([IPv6:::ffff:80.139.104.209]:24180
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225766AbUGOBxe>; Thu, 15 Jul 2004 02:53:34 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6F1rUg8027469;
	Thu, 15 Jul 2004 03:53:30 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6F1rSst027468;
	Thu, 15 Jul 2004 03:53:28 +0200
Date: Thu, 15 Jul 2004 03:53:28 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: "Kevin D. Kissell" <KevinK@mips.com>,
	S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040715015328.GA26425@linux-mips.org>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <16629.24775.778491.754688@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16629.24775.778491.754688@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2004 at 05:35:19PM +0100, Dominic Sweetman wrote:

> If you use hit-type cache operations in a kernel routine, then you're
> safe.  I can't envisage any circumstance in which Linux would try to
> invalidate kernel mainline code locations from the I-cache (well, you
> might be doing something fabulous with debugging the kernel, but
> that's not normal and you'd hardly expect to be able to support such
> an activity with standard cache management calls).
> 
> So this problem can only arise on index-type I-cache invalidation.  I
> claim that a running kernel on a MIPS CPU should only use index-type
> invalidation when it is necessary to invalidate the entire I-cache.
> (If you use index-type operations for a range which doesn't resolve to
> "the whole cache" then that should be fixed).
> 
> That implies that a MIPS32-paranoid "invalidate-whole-I-cache" routine
> should:
> 
> 1. Identify which indexes might alias to cache lines 
>    containing the routines's own 'cache invalidate' instruction(s),
>    and thus hit the problem.  There won't be that many of them.
> 
> 2. Arrange to skip those indexes when zapping the cache, then do
>    something weird to invalidate that handful of lines.  You could 
>    do that by running uncached, but you could also do it just by using
>    some auxiliary routine which is known to be more than a cache line
>    but much less than a whole I-cache span distant, so can't possibly
>    alias to the same thing...
> 
> This is fiddly, but not terribly difficult and should have a
> negligible performance impact.
> 
> Does that make sense?  Am I now, having named the solution,
> responsible for figuring out a patch (yeuch, I never wanted to be a
> kernel programmer again...).

You don't have to :-)  What became a architectural restriction for MIPS32
did already show up earlier as an erratum for the TX49/H2 core.  This is
the solution which we currently have in the kernel code:

#define JUMP_TO_ALIGN(order) \
	__asm__ __volatile__( \
		"b\t1f\n\t" \
		".align\t" #order "\n\t" \
		"1:\n\t" \
		)
#define CACHE32_UNROLL32_ALIGN	JUMP_TO_ALIGN(10) /* 32 * 32 = 1024 */
#define CACHE32_UNROLL32_ALIGN2	JUMP_TO_ALIGN(11)

static inline void mips32_blast_icache32(void)
{
	unsigned long start = INDEX_BASE;
	unsigned long end = start + current_cpu_data.icache.waysize;
	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
	unsigned long ws_end = current_cpu_data.icache.ways <<
	                       current_cpu_data.icache.waybit;
	unsigned long ws, addr;

	CACHE32_UNROLL32_ALIGN2;
	/* I'm in even chunk.  blast odd chunks */
	for (ws = 0; ws < ws_end; ws += ws_inc) 
		for (addr = start + 0x400; addr < end; addr += 0x400 * 2) 
			cache32_unroll32(addr|ws,Index_Invalidate_I);
	CACHE32_UNROLL32_ALIGN;
	/* I'm in odd chunk.  blast even chunks */
	for (ws = 0; ws < ws_end; ws += ws_inc) 
		for (addr = start; addr < end; addr += 0x400 * 2) 
			cache32_unroll32(addr|ws,Index_Invalidate_I);
}

All it takes is using this for all MIPS32 / MIPS64 or maybe even all
processors and some tuning of constants to make this suitable for
all possible I-cache configurations.

  Ralf
