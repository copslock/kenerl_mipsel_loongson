Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2009 03:29:22 +0000 (GMT)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:15406 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21367257AbZCLD3Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Mar 2009 03:29:16 +0000
X-IronPort-AV: E=Sophos;i="4.38,347,1233532800"; 
   d="scan'208";a="140657381"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-2.cisco.com with ESMTP; 12 Mar 2009 03:28:56 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id n2C3Suqv014942;
	Wed, 11 Mar 2009 20:28:56 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n2C3SuSv018217;
	Thu, 12 Mar 2009 03:28:56 GMT
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id DAA00222; Thu, 12 Mar 2009 03:28:50 GMT
Date:	Wed, 11 Mar 2009 20:28:50 -0700
From:	VomLehn <dvomlehn@cisco.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH][MIPS] Use CP0 Count register to implement more granular
	ndelay
Message-ID: <20090312032850.GA9379@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=18348; t=1236828536; x=1237692536;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH][MIPS]=20Use=20CP0=20Count=20register=20
	to=20implement=20more=20granular=0A=09ndelay
	|Sender:=20;
	bh=GvPIih9vNdrxljmKWQ2m8kjyBdhwkbQCqWREMYt3xhE=;
	b=LCzt85djezSSVOZ6+hiKJiBw8L7phSu/JDG9Jyo90Z73UONz0MWcaphPG+
	SMxnToz+Cp332ruXoQVTci6wTnBWcIbLJ1wcOJIyvqlWHYxDQdzsyXTIds1a
	rgZthjmoaF;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

The default implementation of ndelay uses udelay, which will result in the
rounding up of any requested interval to the next highest number of
microseconds. This may be a much longer delay than was desired.  However,
if the tick rate of the CP0 Count register is known, it is possible to
implement an accurate ndelay that works on multiple MIPS processors.

To use this, enable CONFIG_CP0_COUNT_NDELAY and modify the platform startup
code to call init_ndelay as early as possible. A good place to call it
is probably the prom_init function. The argument to init_ndelay should be
the CP0 Count register tick rate, in kHz.  The tick rate is typically half
the processor clock rate so, if you have a 700 MHz processor, the CP0 Count
register would tick at 350 MHz and you would pass 3500000 to init_ndelay.

This is version 3. Changes from version 2 include:
o	Correct the BUG_ON comparison as it has a reversed sense from assert.
	Sorry, dumb mistake.
o	Remove unnecessary of comparison to see if an unsigned long variable
	is bigger than ULONG_MAX.
o	Created a "safe" version of ndelay that disables interrupts to avoid
	the possibility of a long interrupt processing interval turning a
	very short delay into a much longer delay. If you know interrupts are
	disabled, you can use no_interrupt_ndelay.

Changes from version 1 include:
o	Added definitions for MIPS1, MIPS2, MIPS3, and MIPS4 configurations
o	Restricted use of CP0 Count register-based ndelay to MIPS2, MIPS3,
	MIPS32, and MIPS64 configurations.
o	Replaced assert code with BUG_ON
o	Corrected name of preprocessor symbol avoid multiple inclusions of
	fast-ratio.h and delay.h
o	Used '/**' to mark comments intended to be automatically parsed.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/Kconfig                  |   30 +++++
 arch/mips/include/asm/delay.h      |  100 +++++++++++++++++++
 arch/mips/include/asm/fast-ratio.h |   53 ++++++++++
 arch/mips/lib/Makefile             |    6 -
 arch/mips/lib/delay.c              |   59 +++++++++++
 arch/mips/lib/fast-ratio.c         |  187 +++++++++++++++++++++++++++++++++++++
 6 files changed, 433 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/mips/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/Kconfig
+++ linux-2.6/arch/mips/Kconfig
@@ -1371,6 +1371,26 @@ config WEAK_REORDERING_BEYOND_LLSC
 endmenu
 
 #
+# Collect various processors by instruction family
+#
+config MIPS1
+	bool
+	default y if CPU_R3000 || CPU_TX39XX
+
+config MIPS2
+	bool
+	default y if CPU_R6000
+
+config MIPS3
+	bool
+	default y if CPU_LOONGSON2 || CPU_R4300 || CPU_R4X00 || CPU_TX49XX || \
+		CPU_VR41XX
+
+config MIPS4
+	bool
+	default y if CPU_R8000 || CPU_R10000
+
+#
 # These two indicate any level of the MIPS32 and MIPS64 architecture
 #
 config CPU_MIPS32
@@ -1876,6 +1896,16 @@ config NR_CPUS
 
 source "kernel/time/Kconfig"
 
+config CP0_COUNT_NDELAY
+	bool "Use coprocessor 0 Count register for ndelay functionality"
+	depends on CPU_MIPS3 || CPU_MIPS4 || CPU_MIPS32 || CPU_MIPS64
+	default n
+	help
+	  Implements the ndelay function using the coprocessor 0 Count
+	  register. Using this requires including a call to init_ndelay
+	  with the Count register increment frequency, in KHz, in one
+	  of the early initialization functions.
+
 #
 # Timer Interrupt Frequency Configuration
 #
Index: linux-2.6/arch/mips/include/asm/delay.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/delay.h
+++ linux-2.6/arch/mips/include/asm/delay.h
@@ -109,4 +109,104 @@ static inline void __udelay(unsigned lon
 #define MAX_UDELAY_MS	(1000 / HZ)
 #endif
 
+#ifdef CONFIG_CP0_COUNT_NDELAY
+/*
+ * Definitions for using MIPS CP0 Count register-based ndelay. If
+ * CONFIG_CP0_COUNT_NDELAY is not defined, ndelay will default to using
+ * udelay.
+ */
+
+#include <linux/kernel.h>
+#include <asm/fast-ratio.h>
+#include <asm/mipsregs.h>
+
+/* Maximum amount of time that will be handled with ndelay, in nanoseconds.
+ * Values bigger than this will be bounced up to udelay. */
+#define	_MAX_DIRECT_NDELAY		65535
+
+#define ndelay(n)	_safe_ndelay(n)
+
+extern struct fast_ratio _ndelay_param;
+
+/*
+ * Compute the number of CP0 Count ticks corresponding to the interval
+ * @nsecs:	Interval, expressed in nanoseconds
+ * Breaking this out as its own function makes it easier to test.
+ */
+static inline unsigned int _ndelay_ticks(unsigned int nsecs)
+{
+	return fast_ratio(nsecs, &_ndelay_param);
+}
+
+/**
+ * Delay for at least the given number of nanoseconds
+ * @nsecs:	Number of nanoseconds to delay
+ *
+ * This function uses the CP0 Count register to give a pretty accurate delay
+ * for very short delay periods. Very small delays will, unavoidably, be
+ * dominated by the instructions in this function but this should converge
+ * to the true delay reasonably quickly before nsecs gets very large.
+ *
+ * NOTE: Failure to call init_ndelay will result in *very* long delay times.
+ * This is done deliberately to ensure that, if you use ndelay and forget to
+ * call init_delay first, you will notice your mistake quickly.
+ *
+ * NOTE: If we are interrupted for so long that the Count register can
+ * by more than half of the total value, the test will wrap and you will wind
+ * up with a much longer delay than you expect. So, only call this if you:
+ * o	Have interrupts disabled, or
+ * o	Are sure this can never be interrupted for more than half the time
+ *	it takes for the Count register to wrap.
+ * Otherwise, use ndelay.
+ */
+static inline void no_interrupt_ndelay(unsigned long nsecs)
+{
+	int	start;
+
+	/* The expected thing would be to do the first read of the Count
+	 * register later, just before entering the delay loop. Reading here
+	 * ensures that very short intervals will exit the first time through
+	 * that loop. */
+	start = read_c0_count();
+
+	if (unlikely(nsecs > _MAX_DIRECT_NDELAY))
+		udelay(DIV_ROUND_UP(nsecs, 1000)); /* Would overflow counter */
+
+	else {
+		int	end;
+		int	now;
+
+		end = start + _ndelay_ticks(nsecs);
+
+		do {
+			now = read_c0_count();
+		} while (end - now > 0);
+	}
+}
+
+/**
+ * Delay for at least the given number of nanoseconds
+ * @nsecs:	Number of nanoseconds to delay
+ *
+ * This is the safe version that disables interrupts to avoid the possibility
+ * of very long interrupts causing the comparision to wrap. Don't use this
+ * directly; use ndelay.
+ */
+static inline void _safe_ndelay(unsigned long nsecs)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	no_interrupt_ndelay(nsecs);
+	local_irq_restore(flags);
+}
+
+extern int init_ndelay(unsigned int count_freq);
+#else
+static inline int init_ndelay(unsigned int count_freq)
+{
+	return 0;
+}
+#endif
+
 #endif /* _ASM_DELAY_H */
Index: linux-2.6/arch/mips/include/asm/fast-ratio.h
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/include/asm/fast-ratio.h
@@ -0,0 +1,53 @@
+/*
+ *				fast-ratio.h
+ *
+ * Definitions for using fast evaluator for expressions of the form:
+ *	    a
+ * 	x * -
+ * 	    b
+ *
+ * where x can be constrained to some maximum value and a and b are constants.
+ *
+ * Copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef _ASM_FAST_RATIO_H_
+#define _ASM_FAST_RATIO_H_
+
+/* Instances of this structure will normally be declared with the attribute
+ * __read_mostly since it only makes sense to use the fast-ratio code if
+ * you fill in the structure once for many calls to evalue the result. */
+struct fast_ratio {
+	unsigned long	k;
+	unsigned int	s;
+	unsigned long	r;
+};
+
+/**
+ * Evaluate x * (a / b), a and b constant, as transformed for speed.
+ * @x:	Value to multiply by a / b
+ * @fr:	Pointer to &struct fast_ratio with transformed values for a and b
+ * Returns x * (a / b), rounded up in an unsigned long value
+ */
+static inline unsigned long fast_ratio(unsigned long x, struct fast_ratio *fr)
+{
+	return (x * fr->k + fr->r) >> fr->s;
+}
+
+extern int init_fast_ratio(unsigned int max_x, unsigned long a,
+	unsigned long b, struct fast_ratio *fr);
+#endif
Index: linux-2.6/arch/mips/lib/Makefile
===================================================================
--- linux-2.6.orig/arch/mips/lib/Makefile
+++ linux-2.6/arch/mips/lib/Makefile
@@ -2,8 +2,8 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o uncached.o
+lib-y	+= csum_partial.o fast-ratio.o memcpy.o memcpy-inatomic.o memset.o \
+	   strlen_user.o strncpy_user.o strnlen_user.o uncached.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
@@ -29,5 +29,7 @@ obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
 
+obj-$(CONFIG_CP0_COUNT_NDELAY)	+= delay.o
+
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
Index: linux-2.6/arch/mips/lib/delay.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/lib/delay.c
@@ -0,0 +1,59 @@
+/*
+ *				delay.c
+ *
+ * Code implementing ndelay using the MIPS CP0 Count register.
+ *
+ * Copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/delay.h>
+
+/* This elements are initialized to a value that will cause huge delays to
+ * arise from use of ndelay before calling init_ndelay. This should make such
+ * mistakes obvious enough to easily find and correct. */
+struct fast_ratio _ndelay_param __read_mostly = {
+	.k = 0,
+	.s = 0,
+	.r = ULONG_MAX / 2,
+};
+EXPORT_SYMBOL(_ndelay_param);
+
+/**
+ * Called to initialize the values for the ndelay function
+ * @f: Frequency, in KHz, of the CP0 Count register increment rate
+ */
+int __init init_ndelay(unsigned int f)
+{
+	int	ret;
+
+	ret = init_fast_ratio(_MAX_DIRECT_NDELAY, f, 1000000, &_ndelay_param);
+
+	if (ret)
+		pr_err("Unable to initialize ndelay parameters, errno %d\n",
+			ret);
+	else
+		pr_info("Set ndelay fast_ratio parameters: k %lu s %d r %lu\n",
+			_ndelay_param.k, _ndelay_param.s, _ndelay_param.r);
+
+	return ret;
+}
Index: linux-2.6/arch/mips/lib/fast-ratio.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/mips/lib/fast-ratio.c
@@ -0,0 +1,187 @@
+/*
+ *				fast-ratio.c
+ *
+ * Code implementing fast ratio calculator.
+ *
+ * Copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/log2.h>
+#include <asm-generic/bug.h>
+#include <asm/fast-ratio.h>
+
+#ifdef DEBUG
+#define dbg(fmt, ...)	pr_crit(fmt, ## __VA_ARGS__)
+#else
+#define dbg(fmt, ...)	do { } while (0)
+#endif
+
+#ifndef BITS_PER_LLONG
+#define	BITS_PER_LLONG	((BITS_PER_LONG * sizeof(long long)) / sizeof(long))
+#endif
+
+/* Type for intermediate calculations, along with the number of bits and
+ * the maximum size. This should be the biggest unsigned type for which
+ * division and modulus by unsigned long are defined on this
+ * architecture. */
+#ifdef CONFIG_HAVE_ULLONG_DIV_AND_MOD
+typedef unsigned long long intermediate_t;
+#define	BITS_PER_ACC	BITS_PER_LLONG
+#define	ACC_MAX		ULLONG_MAX
+#else
+typedef unsigned long intermediate_t;
+#define	BITS_PER_ACC	BITS_PER_LONG
+#define	ACC_MAX		ULLONG_MAX
+#endif
+
+/**
+ * Compute transform of equation (x * a)/b for fast computation
+ * @max_x:	Maximum value of x
+ * @a:		Value of a
+ * @b:		value b
+ * @fr:		Pointer to a &struct fast_ratio to hold transformed parameters
+ * Returns a zero on success, otherwise a negative errno value. Errno values
+ * are:
+ *	-EDOM	Parameter b is zero
+ *	-EINVAL	Either max_x is too large or max_x is zero
+ *	-ERANGE	The rounded up intermediate value of x * a would not fit
+ *		in an unsigned long.
+ *
+ * Mathematically, as long as the ratios:
+ *	a    k
+ *	- = ---
+ *	b   2^s
+ *
+ * are equal, the specific values of k and s don't matter. There are
+ * two constraints, however:
+ *
+ * o	The value of s must be less than BIT_PER_LONG
+ * o	With a rounding constant of r = 2^s - 1, we must have
+ *		x * k + r <= ULONG_MAX
+ *
+ * We want k to be as large as possible so that
+ * it has the maximum precision. Getting the largest k means
+ * getting the smallest shift.
+ *
+ * Note that this is designed to work on both 32-bit systems and 64-bit systems
+ * using the LP64 model.
+ */
+int init_fast_ratio(unsigned int max_x, unsigned long a,
+	unsigned long b, struct fast_ratio *fr)
+{
+#define	SHIFT_ROUND_UP(_v, _n)	(((_n) < 0) ?			\
+		(((unsigned long long) (_v)) << -(_n)) :	\
+		(((_v) + ((1ull << (_n)) - 1)) >> (_n)))
+#define ROUNDING_CONST(_s)	(((_s) < 0) ? 0 : ((1ull << (_s)) - 1))
+	intermediate_t		scaled_a;
+	intermediate_t		k0;
+	int			s0;
+	int			min_s;
+	int			k_msb;
+	int			s;
+	int			si;
+	unsigned long long	k;
+	unsigned long long	r;
+	unsigned long long	dividend;
+
+	if (b == 0)
+		return -EDOM;		/* Divide by zero */
+
+	if (max_x == 0)
+		return -EINVAL;
+
+	if (a == 0) {
+		fr->k = 0;		/* Trivial, result is always zero */
+		fr->s = 0;
+		fr->r = 0;
+		return 0;
+	}
+
+	/* Calculate the rounded up value of a / b with the most precision we
+	 * can easily obtain by shifting the value a by n bits to the left.
+	 * This means that the value we get is (a / b) * 2^n.  We could get
+	 * an overflow if we used the usual (a + (b - 1))/ b, so we compute the
+	 * rounding value explicitly. If the scale value of a modulus b is
+	 * not zero, we need to increase the result by one. */
+	s0 = (BITS_PER_ACC - 1) - ilog2(a);
+	scaled_a = ((intermediate_t) a) << s0;
+
+	k0 = (scaled_a / b) + ((scaled_a % b == 0) ? 0 : 1);
+	k_msb = ilog2(k0) + 1;
+	dbg("scaled_a %llx scaled_a %% b %llx k0 %llx s0 %d k_msb %d\n",
+		(unsigned long long) scaled_a,
+		(unsigned long long) scaled_a % b,
+		(unsigned long long) k0, s0, k_msb);
+
+	/* Find a shift that yields the largest value of k that will avoid an
+	 * overflow on an unsigned long when multiplied by max_x, and rounded
+	 * up. */
+	min_s = k_msb;
+
+	for (;;) {
+		int			shft;
+		unsigned long long	ri;
+		unsigned long long	ki;
+		unsigned long long	p;
+
+		shft = min_s - 1;
+		si = s0 - shft;
+		ki = SHIFT_ROUND_UP(k0, shft);
+		ri = ROUNDING_CONST(si);
+
+		/* We must be sure that max_x is smaller than p or the
+		 * following calculation will eventually overflow */
+		BUG_ON(sizeof(max_x) > sizeof(p));
+		p = max_x * ki;
+		dividend = p + ri;
+		dbg("min_s %d shft %d si %d ri %llx ki %llx max_x %x p %llx "
+			"dividend %llx\n",
+			min_s, shft, si, ri, ki, max_x, p, dividend);
+		if ((si > BITS_PER_LONG || dividend > ULONG_MAX))
+			break;
+		min_s--;
+	}
+
+	s = s0 - min_s;
+	k = SHIFT_ROUND_UP(k0, min_s);
+	r = ROUNDING_CONST(s);
+	dbg("min_s %d s %d k %llx max_x * k %llx r %llx dividend %llx\n",
+		min_s, s, k, max_x * k, r, max_x * k + r);
+
+	/* If we have a negative shift, we couldn't find a k that would avoid
+	 * an overflow. If that's true, or we have an overflow at the current
+	 * shift, we return an error. */
+	if (s < 0 || max_x * k + r > ULONG_MAX)
+		return -ERANGE;
+
+	/* If the shift we came up with would shift the final result out
+	 * of the register, we've underflowed the result */
+	if (s >= BITS_PER_LONG)
+		return -ERANGE;
+
+	fr->s = s;
+	fr->k = k;
+	fr->r = r;
+
+	return 0;
+#undef SHIFT_ROUND_UP
+#undef ROUNDING_CONST
+}
