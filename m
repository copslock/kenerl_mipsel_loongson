Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 17:59:22 +0100 (BST)
Received: from p508B7611.dip.t-dialin.net ([IPv6:::ffff:80.139.118.17]:38692
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224909AbUJSQ7R>; Tue, 19 Oct 2004 17:59:17 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9JGxBMU020369;
	Tue, 19 Oct 2004 18:59:11 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9JGx1c7020368;
	Tue, 19 Oct 2004 18:59:01 +0200
Date: Tue, 19 Oct 2004 18:59:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: kmalloc alignment
Message-ID: <20041019165901.GA18385@linux-mips.org>
References: <20041019.235129.25480859.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019.235129.25480859.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2004 at 11:51:29PM +0900, Atsushi Nemoto wrote:

> In include/asm-mips/cache.h:
> 
> #define ARCH_KMALLOC_MINALIGN	8
> 
> Is this line really needed?
> 
> If it was not defined (and ARCH_KMALLOC_FLAGS was also not defined),
> default alignment (cache_line_size()) will be used for kmalloc.  It is
> enough, isn't it?

The alignment needs to be large enough to store an arbitrary fundamental
data type including the 64-bit types such as long long or double.

cache_line_size() is only used if a slab has SLAB_HWCACHE_ALIGN set.

The effect of not guaranteeing 8 byte alignment are subtle at times because
the kernel unaligned handling is going to hide the problem.  So just
performance will suffer.  It used to show up clearly only in the
floating point context switch because we don't support software emulation
of missaligned floating point loads and stores.

> Also, with current 8 byte alignment, many PCI drivers which are using
> kmalloc and dma_map_single are broken on non-coherent system.  I was
> told that those drivers should use dma_get_cache_alignment() API, but
> currently nobody do it anyway.  Removing ARCH_KMALLOC_MINALIGN will
> help those (broken?) drivers.

The alignment requirements are documented in Documentation/DMA-API.txt
and they are specified the way they are for good reason.

  Ralf
