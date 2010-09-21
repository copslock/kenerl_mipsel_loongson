Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Sep 2010 12:11:10 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490976Ab0IUKLG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Sep 2010 12:11:06 +0200
Date:   Tue, 21 Sep 2010 11:11:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        alex@digriz.org.uk, manuel.lauss@googlemail.com, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix vmlinuz to flush the caches after kernel
 decompression
Message-ID: <20100921101105.GA32343@linux-mips.org>
References: <4c7e1a3a.c83ddf0a.5918.ffffcf6a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7e1a3a.c83ddf0a.5918.ffffcf6a@mx.google.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16183

On Wed, Sep 01, 2010 at 12:17:43PM +0300, Shmulik Ladkani wrote:

> Flush caches after kernel decompression.
> 
> When writing instructions, the D-cache should be written-back, and I-cache
> should be invalidated.

Correct - but it's also a can of worms which is why I intentionally
ignored the issue so far.  An I-cache is refilled from L2/L3 (if available)
or memory.  The large amounts of data written by the CPU during
decompression of the kernel virtually guarantee that all code will be
written back to L2/L3 or memory and the I-cache has been flushed by
firmware before the decompressor was entered.

Does this assumption fail for you?

The real can of worms is SMP - none of the other processors have been
detected etc.  At this early stage we just don't know if and how to flush
caches of other processors.  The only good news is that we know they
don't have any not written back kernel code in their D-caches.

> The patch implements L1 cache flushing, for r4k style caches - suitable for
> all MIPS32 CPUs (and probably for other CPUs too).

No - you only compile the code for MIPS32 CPUs and check for MIPS_CONF_M
which - at least with this meaning - only exists on MIPS32 and MIPS64 CPUs.

> +#define INDEX_BASE CKSEG0
> +
> +extern void puts(const char *s);
> +extern void puthex(unsigned long long val);
> +
> +#define cache_op(op, addr)			\
> +	__asm__ __volatile__(			\
> +	"	.set push		\n"	\
> +	"	.set noreorder		\n"	\
> +	"	.set mips3		\n"	\
> +	"	cache %1, 0(%0)		\n"	\
> +	"	.set pop		\n"	\
> +	:					\
> +	: "r" (addr), "i" (op))

This duplicates the definition of arch/mips/include/asm/r4kcache.h.  Why?

> +#define cache_all_index_op(cachesz, linesz, op) do {			\
> +	unsigned long addr = INDEX_BASE;				\
> +	for (; addr < INDEX_BASE + (cachesz); addr += (linesz))		\
> +		cache_op(op, addr);					\
> +} while (0)

For consistence in formatting please move the "do {" to the beginning of
the next line.

> +void cache_flush(void)
> +{
> +	volatile unsigned long config1;

I don't know why you're using volatile here - but it won't work as you
intended.  Just drop the keyword.

> +	unsigned long tmp;
> +	unsigned long line_size;
> +	unsigned long ways;
> +	unsigned long sets;
> +	unsigned long cache_size;

Make these int variables.  The code here is fine for MIPS64 as well but
there is no point in having 64-bit variables and multiplies.

> +	if (!(read_c0_config() & MIPS_CONF_M)) {
> +		puts("cache_flush error: Config1 unavailable\n");
> +		return;
> +	}
> +	config1 = read_c0_config1();
> +
> +	/* calculate D-cache line-size and cache-size, then writeback */
> +	tmp = (config1 >> 10) & 7;
> +	if (tmp) {
> +		line_size = 2 << tmp;
> +		sets = 64 << ((config1 >> 13) & 7);
> +		ways = 1 + ((config1 >> 7) & 7);
> +		cache_size = sets * ways * line_size;
> +		dcache_writeback(cache_size, line_size);
> +	}
> +
> +	/* calculate I-cache line-size and cache-size, then invalidate */
> +	tmp = (config1 >> 19) & 7;
> +	if (tmp) {
> +		line_size = 2 << tmp;
> +		sets = 64 << ((config1 >> 22) & 7);
> +		ways = 1 + ((config1 >> 16) & 7);
> +		cache_size = sets * ways * line_size;
> +		icache_invalidate(cache_size, line_size);
> +	}

Eww...  You copied (my ...) old sin from c-r4k.c and use all the magic
numbers.

Anyway, does this actually fix a bug for you or is it more a theoretical
convern?

  Ralf
