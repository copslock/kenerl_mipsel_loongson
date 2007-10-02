Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:22:28 +0100 (BST)
Received: from mail.bawue.net ([193.7.176.63]:60909 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20023830AbXJBOWS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:22:18 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 86D80E0051;
	Tue,  2 Oct 2007 16:22:21 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IcidW-0003NT-Dg; Tue, 02 Oct 2007 15:22:10 +0100
Date:	Tue, 2 Oct 2007 15:22:10 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
Message-ID: <20071002142210.GD16772@networkno.de>
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47010E15.7060109@ict.ac.cn> <20071001152620.GB15820@linux-mips.org> <470210B4.8020902@ict.ac.cn> <20071002103551.GB5152@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002103551.GB5152@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Oct 02, 2007 at 05:34:44PM +0800, Fuxin Zhang wrote:
> 
> > The problem is here:
> > 
> > switch (sizeof(__ptr)) { // --> should be sizeof(*(__ptr))
> > case 4:
> > ...
> > Recompiling..
> 
> There was another small kink, cmpxchg_local() does not imply a memory
> barrier so I optimized that case.
> 
> And I don't complain about it being 151 lines shorter ;-)
> 
>   Ralf
> 
> From: Ralf Baechle <ralf@linux-mips.org>
> 
> [MIPS] Typeproof reimplementation of cmpxchg.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/asm-mips/cmpxchg.h b/include/asm-mips/cmpxchg.h
> new file mode 100644
> index 0000000..46bac47
> --- /dev/null
> +++ b/include/asm-mips/cmpxchg.h
> @@ -0,0 +1,107 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2003, 06, 07 by Ralf Baechle (ralf@linux-mips.org)
> + */
> +#ifndef __ASM_CMPXCHG_H
> +#define __ASM_CMPXCHG_H
> +
> +#include <linux/irqflags.h>
> +
> +#define __HAVE_ARCH_CMPXCHG 1
> +
> +#define __cmpxchg_asm(ld, st, m, old, new)				\
> +({									\
> +	__typeof(*(m)) __ret;						\
> +									\
> +	if (cpu_has_llsc && R10000_LLSC_WAR) {				\
> +		__asm__ __volatile__(					\
> +		"	.set	push				\n"	\
> +		"	.set	noat				\n"	\
> +		"	.set	mips3				\n"	\
> +		"1:	" ld "	%0, %2		# __cmpxchg_u32	\n"	\
> +		"	bne	%0, %z3, 2f			\n"	\
> +		"	.set	mips0				\n"	\
> +		"	move	$1, %z4				\n"	\
> +		"	.set	mips3				\n"	\
> +		"	" st "	$1, %1				\n"	\
> +		"	beqzl	$1, 1b				\n"	\
> +		"2:						\n"	\
> +		"	.set	pop				\n"	\
> +		: "=&r" (__ret), "=R" (*m)				\
> +		: "R" (*m), "Jr" (old), "Jr" (new)			\
> +		: "memory");						\
> +	} else if (cpu_has_llsc) {					\
> +		__asm__ __volatile__(					\
> +		"	.set	push				\n"	\
> +		"	.set	noat				\n"	\
> +		"	.set	mips3				\n"	\
> +		"1:	" ld "	%0, %2		# __cmpxchg_u32	\n"	\
> +		"	bne	%0, %z3, 2f			\n"	\
> +		"	.set	mips0				\n"	\
> +		"	move	$1, %z4				\n"	\
> +		"	.set	mips3				\n"	\
> +		"	" st "	$1, %1				\n"	\
> +		"	beqz	$1, 3f				\n"	\
> +		"2:						\n"	\
> +		"	.subsection 2				\n"	\
> +		"3:	b	1b				\n"	\
> +		"	.previous				\n"	\
> +		"	.set	pop				\n"	\
> +		: "=&r" (__ret), "=R" (*m)				\
> +		: "R" (*m), "Jr" (old), "Jr" (new)			\
> +		: "memory");						\
> +	} else {							\
> +		unsigned long __flags;					\
> +									\
> +		raw_local_irq_save(__flags);				\
> +		__ret = *m;						\
> +		if (__ret == old)					\
> +			*m = new;					\
> +		raw_local_irq_restore(__flags);				\
> +	}								\
> +									\
> +	smp_llsc_mb();							\

I think this line is surplus.

> +									\
> +	__ret;								\
> +})
> +
> +/*
> + * This function doesn't exist, so you'll get a linker error
> + * if something tries to do an invalid cmpxchg().
> + */
> +extern void __cmpxchg_called_with_bad_pointer(void);
> +
> +#define __cmpxchg(ptr,old,new,barrier)					\
> +({									\
> +	__typeof__(ptr) __ptr = (ptr);					\
> +	__typeof__(*(ptr)) __old = (old);				\
> +	__typeof__(*(ptr)) __new = (new);				\
> +	__typeof__(*(ptr)) __res = 0;					\

Maybe we need an acquire barrier here for some systems.

> +	switch (sizeof(*(__ptr))) {					\
> +	case 4:								\
> +		__res = __cmpxchg_asm("ll", "sc", __ptr, __old, __new);	\
> +		break;							\
> +	case 8:								\
> +		if (sizeof(long) == 8) {				\
> +			__res = __cmpxchg_asm("lld", "scd", __ptr,	\
> +					   __old, __new);		\
> +			break;						\
> +		}							\
> +	default:							\
> +		__cmpxchg_called_with_bad_pointer();			\
> +		break;							\
> +	}								\
> +									\
> +	barrier;							\
> +									\
> +	__res;								\
> +})
> +
> +#define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_llsc_mb())
> +#define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new,)
> +
> +#endif /* __ASM_CMPXCHG_H */


Thiemo
