Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2011 02:06:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54039 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491094Ab1FQAGC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2011 02:06:02 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5H05xnB001169;
        Fri, 17 Jun 2011 01:05:59 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5H05wWq001166;
        Fri, 17 Jun 2011 01:05:58 +0100
Date:   Fri, 17 Jun 2011 01:05:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
Message-ID: <20110617000558.GA23883@linux-mips.org>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
 <20110325172709.GC8483@linux-mips.org>
 <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTimo6BEgDnTh+sPVR+MELyxiwJoFGw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14160

On Wed, Jun 15, 2011 at 11:58:24AM +0530, naveen yadav wrote:

> diff -Nrup clean/linux-2.6.35.9/arch/mips/include/asm/cacheflush.h linux-2.6.35.9/arch/mips/include/asm/cacheflush.h
> --- clean/linux-2.6.35.9/arch/mips/include/asm/cacheflush.h	2010-11-23 04:01:26.000000000 +0900
> +++ linux-2.6.35.9/arch/mips/include/asm/cacheflush.h	2011-06-14 11:08:16.000000000 +0900
> @@ -114,4 +114,31 @@ unsigned long run_uncached(void *func);
>  extern void *kmap_coherent(struct page *page, unsigned long addr);
>  extern void kunmap_coherent(void);
>  
> +/* New function added which are missed in  MIPS */
> +#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
> +static inline void flush_kernel_vmap_range(void *addr, int size)
> +{
> +/*	if ((cache_is_vivt() || cache_is_vipt_aliasing()))*/
> +	if ((c->icache.flags & MIPS_CACHE_VTAG) ||	\
> +			(c->dcache.flags & MIPS_CACHE_ALIASES)) {

Don't access the flags fields directly but use the feature test macros
like cpu_has_vtag_icache or cpu_has_dc_aliases.  These macros allow the
compiler to optimize unused parts of the cache code.

cache_is_vivt is an ARM CPU feature test macro.  I guess you ported it but
don't quite understand what it meant.  The good news is there are no such
VIVT data caches on MIPS.  And the Icache we just don't care about.

You're accessing c->icache.flags - but I see nothing like "struct
cpuinfo_mips *c;" anywhere.  This doesn't even compile.

> +			unsigned long start = (unsigned long)addr;
> +			dma_cache_wback_inv(start, (size_t)size);

This is a function used for DMA I/O.  On a system that has DMA coherence
in hardware it will do nothing at all!

> +	}
> +}
> +static inline void invalidate_kernel_vmap_range(void *addr, int size)
> +{
> +/*	if ((cache_is_vivt() || cache_is_vipt_aliasing()))*/
> +	if ((c->icache.flags & MIPS_CACHE_VTAG) ||	\
> +		(c->dcache.flags & MIPS_CACHE_ALIASES)) {
> +			unsigned long start = (unsigned long)addr;
> +			dma_cache_inv(start, (size_t)size);
> +}
> +}

Same problems.

> +static inline void flush_kernel_dcache_page(struct page *page)
> +{
> +
> +}

This function should also be implemented if your target has highmem.

  Ralf
