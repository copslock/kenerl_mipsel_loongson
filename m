Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2003 21:05:39 +0100 (BST)
Received: from p508B5B2E.dip.t-dialin.net ([IPv6:::ffff:80.139.91.46]:61406
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbTDBUFi>; Wed, 2 Apr 2003 21:05:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h32K5Zv15211;
	Wed, 2 Apr 2003 22:05:35 +0200
Date: Wed, 2 Apr 2003 22:05:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Cache flush statistics patch to c-mips32.c
Message-ID: <20030402220535.A14112@linux-mips.org>
References: <3E8B3703.3D9B09D5@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E8B3703.3D9B09D5@ekner.info>; from hartvig@ekner.info on Wed, Apr 02, 2003 at 09:16:20PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 02, 2003 at 09:16:20PM +0200, Hartvig Ekner wrote:

> Below is a patch with some cache statistics counters added to c-mips32.c.
> They are turned on by the local define DEBUG_COUNTERS in case somebody wants to
> play with them.
> 
> A sample output:
> 
> [root@au01 root]# more /proc/cmips32_cache_stats
> 
> Cache statistics from c-mips32.c:
> 
> mips32_flush_cache_all_pc:      83384    mips32_flush_cache_all_sc:          0
> mips32_flush_cache_range_pc:    37276    mips32_flush_cache_range_sc:        0
> mips32_flush_cache_mm_pc:        2121    mips32_flush_cache_mm_sc:           0
> mips32_flush_cache_page_pc:     36282    mips32_flush_cache_page_sc:         0
> 
> mips32_flush_icache_all:            0    mips32_flush_icache_page_s:         0
> mips32_flush_icache_range:          4    mips32_flush_icache_page:       93545
> mips32_flush_data_cache_page:   31905    mips32_flush_cache_sigtramp:     2467
> 
> dma_cache_wback_inv_pc:          7029    dma_cache_wback_inv_sc:             0
> dma_cache_inv_pc:                   0    dma_cache_inv_sc:                   0

As already mentioned, c-mips32.c is a pretty lousy piece of code.  It's
basically a cut'n'paste from an ancient, rotten version of r4xx0.c.  So
it also includes wrecked support for R4000SC-style second level caches,
that's all the _sc functions above which aren't called ever.  As of like
an hour ago I've removed all this dead code.

Similarly flush_icache_all, it's only used for processors that have a
virtually indexed virtually tagged I-cache.  Currently there only two of
these processors do exist, the one is Sibyte's SB1 core which is used in
the BCM1250 SOC and the other is MIPS's upcoming 20kc core.

> These counts are from a system which has just booted, nothing else. While
> running some programs, the flush_cache_all is called up to 400 times pr.
> second (!).

Flush_cache_all is invoked by the overkill implementation of sys_cacheflush.
These calls are usually done only by certain code constructs and the only
common user is glibc.  The part of glibc using cacheflush(2) is the
dynamic linker so the penalty for longer running processes is getting
lower.

Anyway, c-mips32.c is frightening for processors with alias-free caches
such as the virtually indexed 16kb 4-way caches of your Au1500.  For
example flush_cache_all() and flush_dcache_page() should be empty and
flush_cache_page() only needs to do something at all for pages that do
contain code etc.  There's a major speedup hidden there.

  Ralf
