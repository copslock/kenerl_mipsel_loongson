Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 17:48:41 +0100 (BST)
Received: from p508B632F.dip.t-dialin.net ([IPv6:::ffff:80.139.99.47]:25160
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225780AbUEIQsk>; Sun, 9 May 2004 17:48:40 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i49GmbxT028270;
	Sun, 9 May 2004 18:48:37 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i49GmZRe028269;
	Sun, 9 May 2004 18:48:35 +0200
Date: Sun, 9 May 2004 18:48:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040509164835.GA28011@linux-mips.org>
References: <20040508224806.A24682@mvista.com> <Pine.GSO.4.58.0405091108150.26985@waterleaf.sonytel.be> <20040509125750.GA19225@linux-mips.org> <20040509.225637.92590265.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040509.225637.92590265.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 09, 2004 at 10:56:37PM +0900, Atsushi Nemoto wrote:

> ralf> We got tripped by a change in 2.6.6-rc2.  Before that change the
> ralf> kmalloc slab caches were being created with SLAB_HWCACHE_ALIGN
> ralf> which results in L1_CACHE_SHIFT alignment for allocations of
> ralf> L1_CACHE_SHIFT for slab caches that are at least that size.  For
> ralf> the sake of S390 this behaviour was changed; new it defaults to
> ralf> BYTES_PER_WORD alignment which is four bytes.
> 
> ralf> Fixed by defining ARCH_KMALLOC_MINALIGN as 8.
> 
> Hmm, many drivers use kmalloc and pci_map_single for DMA buffer.  So
> ARCH_KMALLOC_MINALIGN should be L1_CACHE_BYTES for non-coherent
> system?

No, those drivers are simply broken.  dma_get_cache_alignment() gives the
mimimum alignment and width for DMA mappings and that value is larger
than kmalloc alignment in almost all cases.

  Ralf
