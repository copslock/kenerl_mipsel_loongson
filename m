Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FLC3Rw013310
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 14:12:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FLC3Ms013309
	for linux-mips-outgoing; Mon, 15 Jul 2002 14:12:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f97.dialo.tiscali.de [62.246.18.97])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FLBiS0013285
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 14:11:51 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6FChFq04985;
	Mon, 15 Jul 2002 14:43:15 +0200
Date: Mon, 15 Jul 2002 14:43:15 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: Brian Murphy <brian@murphy.dk>, linux-mips@oss.sgi.com
Subject: Re: [2.5 patch] R5K SC support
Message-ID: <20020715144315.A4837@dea.linux-mips.net>
References: <Pine.LNX.4.21.0207142301110.8659-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207142301110.8659-100000@melkor>; from vivien.chappelier@enst-bretagne.fr on Sun, Jul 14, 2002 at 11:12:34PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 14, 2002 at 11:12:34PM +0200, Vivien Chappelier wrote:

> 
> 	This patch adds support for the secondary cache controller in the
> R5000 processors. It's quite similar to Brian Murphy's patch
> (thanks BTW) except it's based on the current R4K code.
> 	There is code for variants with 16 bytes cache lines if they
> exist.. if they don't just remove :)

They don't exist.

> +static inline void r5k_flush_cache_all_sXXd16i16(void)
> +static void r5k_flush_cache_mm_sXXd16i16(struct mm_struct *mm)

Dead code.

> +static inline void r5k_flush_cache_all_sXXd32i32(void)

> +static void r5k_flush_cache_range_sXXd16i16(struct vm_area_struct *vma,
> +	unsigned long start, unsigned long end)

> +static void r5k_flush_cache_range_sXXd32i32(struct vm_area_struct *vma,
> +	unsigned long start, unsigned long end)
> +static void r5k_flush_cache_mm_sXXd32i32(struct mm_struct *mm)
> +static void r5k_flush_cache_page_sXXd16i16(struct vm_area_struct *vma,
> +					   unsigned long page)
> +static void r5k_flush_cache_page_sXXd32i32(struct vm_area_struct *vma,
> +					   unsigned long page)
> +static void r5k_flush_page_to_ram_sXXd16(struct page *page)
> +static void r5k_flush_page_to_ram_sXXd32(struct page *page)

Flushing the second level cache not required as it's physically indexed
so these are actually indentical to the R4000PC variant flushes.

The second level cache only has to be flushed by sysmips(FLUSH_CACHE, ...),
flushcache(2) and once on bootup on activation.

> +static void r5k_dma_cache_wback_inv_sc(unsigned long addr, unsigned long size)
> +static void r5k_dma_cache_inv_sc(unsigned long addr, unsigned long size)

You can hook the second level cache support into the bcache hook.  That's
working because unlike the R4000SC the R5000's second level cache does not
have the additional constraint of the primary caches always being a subset
of the second level caches.

Arch/mips/sgi-ip22/ip22-sc.c is an example how this can be done.

>  /* If you even _breathe_ on this function, look at the gcc output
>   * and make sure it does not pop things on and off the stack for
>   * the cache sizing loop that executes in KSEG1 space or else
>   * you will crash and burn badly.  You have been warned.
>   */

The R4000SC cache sizing code is bad enough as it is; can you keep it a
separate function from the code for other CPUs?

> +static void __init r5k_setup_scache_funcs(void)

With above changes this function will vaporize as well ...

An additional comment on the Page_Writeback_Inv_S and operations.  They
will only work, if the second level caches uses SRAM with the flash clean
column feature.  If cache SRAMs don't support that feature, things will
blowup.  That's not an uncommon R4k configuration, unfortunately, so we
have to support it and as there is no mechanism for probling provided one
simply has to know what type of memory is in used.  Not sure about
All_Writeback_Inv_S but similar constraints should apply.

  Ralf
