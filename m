Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 11:25:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56732 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20022455AbZD0KZ1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Apr 2009 11:25:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3RAPP6M002869;
	Mon, 27 Apr 2009 12:25:25 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3RAPOOr002867;
	Mon, 27 Apr 2009 12:25:24 +0200
Date:	Mon, 27 Apr 2009 12:25:24 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: IP32: Enable L3 Cache on RM7000 Processor
Message-ID: <20090427102524.GA19143@linux-mips.org>
References: <49EAA3AF.3030409@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49EAA3AF.3030409@gentoo.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 19, 2009 at 12:08:15AM -0400, Kumba wrote:

> diff -Naurp a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
> --- a/arch/mips/mm/sc-rm7k.c	2009-04-18 23:23:49.000000000 -0400
> +++ b/arch/mips/mm/sc-rm7k.c	2009-04-18 23:52:09.690656791 -0400
> @@ -25,11 +25,23 @@
>  /* Secondary cache parameters. */
>  #define scache_size	(256*1024)	/* Fixed to 256KiB on RM7000 */
>
> +/* Tertiary cache parameters */
> +#define tc_lsize      32
> +#ifdef CONFIG_SGI_IP32
> +#define tcache_size   (1024*1024)	/* IP32's RM7000 has 1MB L3 */
> +#else
> +#define tcache_size   (8*1024*1024)	/* 8MB (max) for all others */
> +#endif

No platform-specific #ifdefs into generic code.  More on that see below.

> +
>  extern unsigned long icache_way_size, dcache_way_size;
>
>  #include <asm/r4kcache.h>
>
> -static int rm7k_tcache_enabled;
> +static int rm7k_tcache_enabled = 0;
> +
> +static char *way_string[] __initdata = { NULL, "direct mapped", "2-way",
> +	"3-way", "4-way", "5-way", "6-way", "7-way", "8-way"
> +};
>
>  /*
>   * Writeback and invalidate the primary cache dcache before DMA.
> @@ -105,6 +117,26 @@ static __cpuinit void __rm7k_sc_enable(v
>  		      :
>  		      : "r" (CKSEG0ADDR(i)), "i" (Index_Store_Tag_SD));
>  	}
> +
> +
> +	/* tertiary cache */
> +	set_c0_config(RM7K_CONF_TE);
> +
> +	write_c0_taglo(0);
> +	write_c0_taghi(0);
> +
> +	for (i = 0; i < tcache_size; i += tc_lsize) {
> +		__asm__ __volatile__ (
> +		      ".set noreorder\n\t"
> +		      ".set mips3\n\t"
> +		      "cache %1, (%0)\n\t"
> +		      ".set mips0\n\t"
> +		      ".set reorder"
> +		      :
> +		      : "r" (CKSEG0ADDR(i)), "i" (Page_Invalidate_T));

Use cache_op() from <asm/r4kcache.h> instead of more inline assembler.

> +	}
> +
> +	rm7k_tcache_enabled = 1;
>  }
>
>  static __cpuinit void rm7k_sc_enable(void)
> @@ -119,6 +151,12 @@ static __cpuinit void rm7k_sc_enable(voi
>  static void rm7k_sc_disable(void)
>  {
>  	clear_c0_config(RM7K_CONF_SE);
> +
> +	/* tertiary cache */
> +	if (!rm7k_tcache_enabled)
> +		return;
> +
> +	clear_c0_config(RM7K_CONF_TE);
>  }

I wonder if it is safe to just disable the cache without flushing it before or
after.

>  static struct bcache_ops rm7k_sc_ops = {
> @@ -153,20 +191,20 @@ void __cpuinit rm7k_sc_init(void)
>  	if (!(config & RM7K_CONF_TC)) {
>
>  		/*
> -		 * We can't enable the L3 cache yet. There may be board-specific
> -		 * magic necessary to turn it on, and blindly asking the CPU to
> -		 * start using it would may give cache errors.
> -		 *
> -		 * Also, board-specific knowledge may allow us to use the
> +		 * Board-specific knowledge may allow us to use the
>  		 * CACHE Flash_Invalidate_T instruction if the tag RAM supports
>  		 * it, and may specify the size of the L3 cache so we don't have
> -		 * to probe it.
> +		 * to probe it.  For now, we set the size to 8MB, except on IP32
> +		 * where we know the size is fixed at 1MB.
>  		 */
> -		printk(KERN_INFO "Tertiary cache present, %s enabled\n",
> -		       (config & RM7K_CONF_TE) ? "already" : "not (yet)");
> +		c->tcache.linesz = tc_lsize;
> +		c->tcache.ways = 1;
> +		c->tcache.waybit= __ffs(tcache_size / c->tcache.ways);
> +		c->tcache.waysize = tcache_size / c->tcache.ways;
> +		c->tcache.sets = tcache_size / (c->tcache.linesz * c->tcache.ways);
> +		printk(KERN_INFO "Tertiary cache size %dK, %s, linesize %d bytes.\n",
> +		       (tcache_size >> 10), way_string[c->tcache.ways], tc_lsize);

Initializing c->tcache here is nice but it all depends on the tcache_size which
depends on the platform and isn't (I call it a design flaw) easily accessible.  The
solution is a R4000SC-style probe for the cache size.  See c-r4.c probe_scache()
for how this works and emjoy the scary comments.  It should easier to do this with
just banging the cache tags on the RM7000 while the T-cache is disabled.

> -		if ((config & RM7K_CONF_TE))
> -			rm7k_tcache_enabled = 1;
>  	}
>
>  	bcops = &rm7k_sc_ops;
>
>

  Ralf
