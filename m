Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 21:10:52 +0000 (GMT)
Received: from wf-out-1314.google.com ([209.85.200.171]:17556 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20119730AbZB1VKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2009 21:10:49 +0000
Received: by wf-out-1314.google.com with SMTP id 25so1891612wfc.21
        for <multiple recipients>; Sat, 28 Feb 2009 13:10:46 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cIqEqgna31/xbmKivPOaD3mvBXVT5AxZ2UwBMrnHlFI=;
        b=oIjnZOW/YHRIuDYOfkHE3pKKB4qystmGhuLBSSYAHVAN/NUvs+dgyXNHTG4er3oASd
         jcmQsh58vpIXUOcRnIH3EU5yIf/mElFEoLIQqXJJNk82pumuGm3FCsxKQqTKGjHYH0VZ
         XxDdZA8ESQRd/9yQJmmr+k51oM/uIB/v+qszc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gQmDEfo2xy1UH06KA3O1QNtCD3fXgD5Llp1Q1ePTG+sNgtCEeVAyuwT0Z4sdGHwvxv
         LkNv3176NYY2un7zyleTK35TMhO6RdqqROsqk4nErasy6nD3eJM36cQT4Fit/7j+PoTm
         8jh/Aw2GA+U/N8T+hpGzXpkhvAAcvLnfMT1YU=
MIME-Version: 1.0
Received: by 10.142.141.21 with SMTP id o21mr2043980wfd.126.1235855446803; 
	Sat, 28 Feb 2009 13:10:46 -0800 (PST)
In-Reply-To: <20090227230950.GA29546@cuplxvomd02.corp.sa.net>
References: <20090227230950.GA29546@cuplxvomd02.corp.sa.net>
Date:	Sat, 28 Feb 2009 16:10:46 -0500
X-Google-Sender-Auth: 28ac8438c26bc4e5
Message-ID: <7d1d9c250902281310o7c03da24jcb8760fdfef4d46b@mail.gmail.com>
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more granular 
	ndelay
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 27, 2009 at 6:09 PM, VomLehn <dvomlehn@cisco.com> wrote:
> The default implementation of ndelay uses udelay, which will result in the
> rounding up of any requested interval to the next highest number of
> microseconds. This may be a much longer delay than was desired.  However,
> if the tick rate of the CP0 Count register is known, it is possible to
> implement an accurate ndelay that works on multiple MIPS processors.

Presumably the only case where this would ever matter is for delays
that needed to be much less than udelay(1) -- is there a lot of these
out there?  According to git grep, the only user of ndelay in
arch/mips is lasat.  And, if what is there is working now, then one
could argue that the calls for the short delays are not explicitly
required to be less than udelay(1).

>
> To use this, enable CONFIG_CP0_COUNT_NDELAY and modify the platform startup
> code to call init_ndelay as early as possible. A good place to call it
> is probably the prom_init function. The argument to init_ndelay should be
> the CP0 Count register tick rate, in kHz.  The tick rate is typically half
> the processor clock rate so, if you have a 700 MHz processor, the CP0 Count
> register would tick at 350 MHz and you would pass 3500000 to init_ndelay.
>
> At the risk of being obvious, you will need to ensure that ndelay isn't used
> until after the call to init_ndelay. There are no checks to enforce this as
> it would increase the latency in ndelay, but, in order to make it obvious
> that init_ndelay hasn't been called early enough, the initial ndelay
> parameters are set to cause a really large delay.

I didn't see the arch_initcall for the init_ndelay placed anywhere in
this patch.

>
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/Kconfig                  |    9 ++
>  arch/mips/include/asm/delay.h      |   75 ++++++++++++++
>  arch/mips/include/asm/fast-ratio.h |   53 ++++++++++
>  arch/mips/lib/Makefile             |    6 +-
>  arch/mips/lib/delay.c              |   59 +++++++++++
>  arch/mips/lib/fast-ratio.c         |  196 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 396 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 0b5f16b..1568b91 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1807,6 +1807,15 @@ config NR_CPUS
>
>  source "kernel/time/Kconfig"
>
> +config CP0_COUNT_NDELAY
> +       bool "Use coprocessor 0 Count register for ndelay functionality"
> +       default n

Does there need to be some sort of depends here to cover off any
limitations where it is known that it won't work?

> +       help
> +         Implements the ndelay function using the coprocessor 0 Count
> +         register. Using this requires including a call to init_ndelay
> +         with the Count register increment frequency, in KHz, in one
> +         of the early initialization functions.
> +
>  #
>  # Timer Interrupt Frequency Configuration
>  #
> diff --git a/arch/mips/include/asm/delay.h b/arch/mips/include/asm/delay.h
> index b0bccd2..fc41c46 100644
> --- a/arch/mips/include/asm/delay.h
> +++ b/arch/mips/include/asm/delay.h
> @@ -109,4 +109,79 @@ static inline void __udelay(unsigned long usecs, unsigned long lpj)
>  #define MAX_UDELAY_MS  (1000 / HZ)
>  #endif
>
> +#ifdef CONFIG_CP0_COUNT_NDELAY
> +/*
> + * Definitions for using MIPS CP0 Count register-based ndelay. If
> + * CONFIG_CP0_COUNT_NDELAY is not defined, ndelay will default to using
> + * udelay.
> + */
> +
> +#include <linux/kernel.h>
> +#include <asm/fast-ratio.h>
> +#include <asm/mipsregs.h>
> +
> +/* Maximum amount of time that will be handled with ndelay, in nanoseconds.
> + * Values bigger than this will be bounced up to udelay. */
> +#define        _MAX_DIRECT_NDELAY              65535

Why the leading underscore here?  Maybe MAX_CP0_NDELAY would be a
better choice if it has to be changed anyway?

> +
> +#define ndelay(n)      _ndelay(n)
> +
> +extern struct fast_ratio _ndelay_param;


...and here ; not sure why the leading underscore.

> +
> +/*
> + * Compute the number of CP0 Count ticks corresponding to the interval
> + * @nsecs:     Interval, expressed in nanoseconds
> + * Breaking this out as its own function makes it easier to test.
> + */
> +static inline unsigned int _ndelay_ticks(unsigned int nsecs)
> +{
> +       return fast_ratio(nsecs, &_ndelay_param);
> +}
> +
> +/*
> + * Delay for at least the given number of nanoseconds
> + * @nsecs:     Number of nanoseconds to delay
> + *
> + * This function uses the CP0 Count register to give a pretty accurate delay
> + * for very short delay periods. Very small delays will, unavoidably, be
> + * dominated by the instructions in this function but this should converge
> + * to the true delay reasonably quickly before nsecs gets very large.
> + *
> + * NOTE: Failure to call init_ndelay will result in *very* long delay times.
> + * This is done deliberately to ensure that, if you use ndelay and forget to
> + * call init_delay first, you will notice your mistake quickly.
> + */
> +static inline void _ndelay(unsigned long nsecs)
> +{
> +       int     start;
> +
> +       /* The expected thing would be to do the first read of the Count
> +        * register later, just before entering the delay loop. Reading here
> +        * ensures that very short intervals will exit the first time through
> +        * that loop. */
> +       start = read_c0_count();

Is this really going to all work on mips64?  I've spent hours
debugging silent boot death on mips64 due to bad variable choices used
for stuff playing with read_c0_count when mips went to generic
clockevents on r4k, and it wasn't fun.

> +
> +       if (unlikely(nsecs > _MAX_DIRECT_NDELAY))
> +               udelay(DIV_ROUND_UP(nsecs, 1000)); /* Would overflow counter */
> +
> +       else {
> +               int     end;
> +               int     now;
> +
> +               end = start + _ndelay_ticks(nsecs);
> +
> +               do {
> +                       now = read_c0_count();
> +               } while (end - now > 0);
> +       }
> +}
> +
> +extern int init_ndelay(unsigned int count_freq);
> +#else
> +static inline int init_ndelay(unsigned int count_freq)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _ASM_DELAY_H */
> diff --git a/arch/mips/include/asm/fast-ratio.h b/arch/mips/include/asm/fast-ratio.h
> new file mode 100644
> index 0000000..84ac286
> --- /dev/null
> +++ b/arch/mips/include/asm/fast-ratio.h
> @@ -0,0 +1,53 @@
> +/*
> + *                             fast-ratio.h
> + *
> + * Definitions for using fast evaluator for expressions of the form:
> + *         a
> + *     x * -
> + *         b
> + *
> + * where x can be constrained to some maximum value and a and b are constants.
> + *
> + * Copyright (C) 2009 Cisco Systems, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#ifndef _ASM_MACH_POWERTV_FAST_RATIO_H_
> +#define _ASM_MACH_POWERTV_FAST_RATIO_H_

s/MACH_POWERTV_//  is probably what you wanted to do here.

> +
> +/* Instances of this structure will normally be declared with the attribute
> + * __read_mostly since it only makes sense to use the fast-ratio code if
> + * you fill in the structure once for many calls to evalue the result. */
> +struct fast_ratio {
> +       unsigned long   k;
> +       unsigned int    s;
> +       unsigned long   r;
> +};

Use of "int" again tends to make me nervous.

> +
> +/*
> + * Evaluate x * (a / b), a and b constant, as transformed for speed.
> + * @x: Value to multiply by a / b
> + * @fr:        Pointer to &struct fast_ratio with transformed values for a and b
> + * Returns x * (a / b), rounded up in an unsigned long value
> + */
> +static inline unsigned long fast_ratio(unsigned long x, struct fast_ratio *fr)
> +{
> +       return (x * fr->k + fr->r) >> fr->s;
> +}
> +
> +extern int init_fast_ratio(unsigned int max_x, unsigned long a,
> +       unsigned long b, struct fast_ratio *fr);
> +#endif
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index dbcf651..e5c4ee5 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -2,8 +2,8 @@
>  # Makefile for MIPS-specific library files..
>  #
>
> -lib-y  += csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
> -          strncpy_user.o strnlen_user.o uncached.o
> +lib-y  += csum_partial.o fast-ratio.o memcpy.o memcpy-inatomic.o memset.o \
> +          strlen_user.o strncpy_user.o strnlen_user.o uncached.o
>
>  obj-y                  += iomap.o
>  obj-$(CONFIG_PCI)      += iomap-pci.o
> @@ -28,5 +28,7 @@ obj-$(CONFIG_CPU_TX39XX)      += r3k_dump_tlb.o
>  obj-$(CONFIG_CPU_TX49XX)       += dump_tlb.o
>  obj-$(CONFIG_CPU_VR41XX)       += dump_tlb.o
>
> +obj-$(CONFIG_CP0_COUNT_NDELAY) += delay.o
> +
>  # libgcc-style stuff needed in the kernel
>  obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
> new file mode 100644
> index 0000000..0d74543
> --- /dev/null
> +++ b/arch/mips/lib/delay.c
> @@ -0,0 +1,59 @@
> +/*
> + *                             delay.c
> + *
> + * Code implementing ndelay using the MIPS CP0 Count register.
> + *
> + * Copyright (C) 2009 Cisco Systems, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/cache.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <asm/delay.h>
> +
> +/* This elements are initialized to a value that will cause huge delays to
> + * arise from use of ndelay before calling init_ndelay. This should make such
> + * mistakes obvious enough to easily find and correct. */

I think it would be better to have something like:

if (unlikely(not_calibrated))
     WARN_ON_ONCE(...)

> +struct fast_ratio _ndelay_param __read_mostly = {
> +       .k = 0,
> +       .s = 0,
> +       .r = ULONG_MAX / 2,
> +};
> +EXPORT_SYMBOL(_ndelay_param);

Not sure why the leading underscore here either.

> +
> +/*
> + * Called to initialize the values for the ndelay function
> + * @f: Frequency, in KHz, of the CP0 Count register increment rate
> + */
> +int __init init_ndelay(unsigned int f)
> +{
> +       int     ret;
> +
> +       ret = init_fast_ratio(_MAX_DIRECT_NDELAY, f, 1000000, &_ndelay_param);
> +
> +       if (ret)
> +               pr_err("Unable to initialize ndelay parameters, errno %d\n",
> +                       ret);
> +       else
> +               pr_info("Set ndelay fast_ratio parameters: k %u s %u r %u\n",
> +                       _ndelay_param.k, _ndelay_param.s, _ndelay_param.r);
> +
> +       return ret;
> +}
> diff --git a/arch/mips/lib/fast-ratio.c b/arch/mips/lib/fast-ratio.c
> new file mode 100644
> index 0000000..c630adf
> --- /dev/null
> +++ b/arch/mips/lib/fast-ratio.c
> @@ -0,0 +1,196 @@
> +/*
> + *                             fast-ratio.c
> + *
> + * Code implementing fast ratio calculator.
> + *
> + * Copyright (C) 2009 Cisco Systems, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/cache.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/log2.h>
> +#include <asm/fast-ratio.h>
> +
> +#ifndef __KERNEL__
> +#include <assert.h>
> +#else
> +#include <asm-generic/bug.h>
> +
> +#ifndef assert
> +#define assert(x)      BUG_ON(!(x))
> +#endif
> +#endif

I suspect the thing you will be asked to do here is dump the whole
__KERNEL__ test and assert usage and simply just use BUG_ON right in
the code.

> +
> +#ifdef DEBUG
> +#define dbg(fmt, ...)  pr_crit(fmt, ## __VA_ARGS__)
> +#else
> +#define dbg(fmt, ...)  do { } while (0)
> +#endif
> +
> +#ifndef BITS_PER_LLONG
> +#define        BITS_PER_LLONG  ((BITS_PER_LONG * sizeof(long long)) / sizeof(long))
> +#endif

Is BITS_PER_LLONG really defined anywhere for anything?

> +
> +/* Type for intermediate calculations, along with the number of bits and
> + * the maximum size. This should be the biggest unsigned type for which
> + * division and modulus by unsigned long are defined on this
> + * architecture. */
> +#ifdef CONFIG_HAVE_ULLONG_DIV_AND_MOD

I've not seen any instances of this CONFIG option either.

> +typedef unsigned long long intermediate_t;
> +#define        BITS_PER_ACC    BITS_PER_LLONG
> +#define        ACC_MAX         ULLONG_MAX
> +#else
> +typedef unsigned long intermediate_t;
> +#define        BITS_PER_ACC    BITS_PER_LONG
> +#define        ACC_MAX         ULLONG_MAX
> +#endif

This might fall into the loophole of  Documentation/CodingStyle  --
chapter 5; i.e:

    ...but if there is a clear reason for why it under certain circumstances
     might be an "unsigned int" and under other configurations might be
     "unsigned long", then by all means go ahead and use a typedef.

> +
> +/*

Don't these need to start with /** if you want to have them
automagically parsed?

> + * Compute transform of equation (x * a)/b for fast computation
> + * @max_x:     Maximum value of x
> + * @a:         Value of a
> + * @b:         value b
> + * @fr:                Pointer to a &struct fast_ratio to hold transformed parameters
> + * Returns a zero on success, otherwise a negative errno value. Errno values
> + * are:
> + *     -EDOM   Parameter b is zero
> + *     -EINVAL Either max_x is too large or max_x is zero
> + *     -ERANGE The rounded up intermediate value of x * a would not fit
> + *             in an unsigned long.
> + *
> + * Mathematically, as long as the ratios:
> + *     a    k
> + *     - = ---
> + *     b   2^s
> + *
> + * are equal, the specific values of k and s don't matter. There are
> + * two constraints, however:
> + *
> + * o   The value of s must be less than BIT_PER_LONG
> + * o   With a rounding constant of r = 2^s - 1, we must have
> + *             x * k + r <= ULONG_MAX
> + *
> + * We want k to be as large as possible so that
> + * it has the maximum precision. Getting the largest k means
> + * getting the smallest shift.
> + *
> + * Note that this is designed to work on both 32-bit systems and 64-bit systems
> + * using the LP64 model.
> + */
> +int init_fast_ratio(unsigned int max_x, unsigned long a,
> +       unsigned long b, struct fast_ratio *fr)
> +{
> +#define        SHIFT_ROUND_UP(_v, _n)  (((_n) < 0) ?                   \
> +               (((unsigned long long) (_v)) << -(_n)) :        \
> +               (((_v) + ((1ull << (_n)) - 1)) >> (_n)))
> +#define ROUNDING_CONST(_s)     (((_s) < 0) ? 0 : ((1ull << (_s)) - 1))

You've created a fast_ratio.h ; any reason why these #defines don't
live there rather than in the middle of this function?   And if there
is any implicit trickery being used that might not be obvious to Joe
Average, then a comment or two wouldn't go amiss.  I know that it is
over my head to parse on the fly, but that doesn't say much.  :-)

> +       intermediate_t          scaled_a;
> +       intermediate_t          k0;
> +       int                     s0;
> +       int                     min_s;
> +       int                     k_msb;
> +       int                     s;
> +       int                     si;
> +       unsigned long long      k;
> +       unsigned long long      r;
> +       unsigned long long      dividend;
> +
> +       if (b == 0)
> +               return -EDOM;           /* Divide by zero */
> +
> +       if (max_x > ULONG_MAX || max_x == 0)
> +               return -EINVAL;
> +
> +       if (a == 0) {
> +               fr->k = 0;              /* Trivial, result is always zero */
> +               fr->s = 0;
> +               fr->r = 0;
> +               return 0;
> +       }
> +
> +       /* Calculate the rounded up value of a / b with the most precision we
> +        * can easily obtain by shifting the value a by n bits to the left.
> +        * This means that the value we get is (a / b) * 2^n.  We could get
> +        * an overflow if we used the usual (a + (b - 1))/ b, so we compute the
> +        * rounding value explicitly. If the scale value of a modulus b is
> +        * not zero, we need to increase the result by one. */
> +       s0 = (BITS_PER_ACC - 1) - ilog2(a);
> +       scaled_a = ((intermediate_t) a) << s0;
> +
> +       k0 = (scaled_a / b) + ((scaled_a % b == 0) ? 0 : 1);
> +       k_msb = ilog2(k0) + 1;
> +       dbg("scaled_a %llx scaled_a %% b %llx k0 %llx s0 %d k_msb %d\n",
> +               (unsigned long long) scaled_a,
> +               (unsigned long long) scaled_a % b,
> +               (unsigned long long) k0, s0, k_msb);
> +
> +       /* Find a shift that yields the largest value of k that will avoid an
> +        * overflow on an unsigned long when multiplied by max_x, and rounded
> +        * up. */
> +       min_s = k_msb;
> +
> +       for (;;) {
> +               int                     shft;
> +               unsigned long long      ri;
> +               unsigned long long      ki;
> +               unsigned long long      p;
> +
> +               shft = min_s - 1;
> +               si = s0 - shft;
> +               ki = SHIFT_ROUND_UP(k0, shft);
> +               ri = ROUNDING_CONST(si);
> +
> +               /* We must be sure that max_x is smaller than p or the
> +                * following calculation will eventually overflow */
> +               assert(sizeof(max_x) < sizeof(p));
> +               p = max_x * ki;
> +               dividend = p + ri;
> +               dbg("min_s %d shft %d si %d ri %llx ki %llx max_x %x p %llx "
> +                       "dividend %llx\n",
> +                       min_s, shft, si, ri, ki, max_x, p, dividend);
> +               if ((si > BITS_PER_LONG || dividend > ULONG_MAX))
> +                       break;
> +               min_s--;
> +       }
> +
> +       s = s0 - min_s;
> +       k = SHIFT_ROUND_UP(k0, min_s);
> +       r = ROUNDING_CONST(s);
> +       dbg("min_s %d s %d k %llx max_x * k %llx r %llx dividend %llx\n",
> +               min_s, s, k, max_x * k, r, max_x * k + r);
> +
> +       /* If we have a negative shift, we couldn't find a k that would avoid
> +        * an overflow. If that's true, or we have an overflow at the current
> +        * shift, we return an error. */
> +       if (s < 0 || max_x * k + r > ULONG_MAX)
> +               return -ERANGE;
> +
> +       /* If the shift we came up with would shift the final result out
> +        * of the register, we've underflowed the result */
> +       if (s >= BITS_PER_LONG)
> +               return -ERANGE;
> +
> +       fr->s = s;
> +       fr->k = k;
> +       fr->r = r;
> +
> +       return 0;
> +#undef SHIFT_ROUND_UP
> +#undef ROUNDING_CONST

This is a .c file, so I don't see the need to undef anything at the end.

Generally speaking, I think this could be two separate commits -- one
that implements the basic ndelay uses read_c0_count() concept (if
really required), and then an add-on commit that does the uber
optimization of the whole ratio thing?  Then if it turns out that one
hunk gets the green light, and the other doesn't, well then at least
you get to see that one part of your work goes forward.

Paul.

> +}
>
>
