Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 15:26:18 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:46390 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab0HRN0M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 15:26:12 +0200
Received: by eye22 with SMTP id 22so327879eye.36
        for <multiple recipients>; Wed, 18 Aug 2010 06:26:09 -0700 (PDT)
Received: by 10.213.3.83 with SMTP id 19mr292615ebm.49.1282137969445;
        Wed, 18 Aug 2010 06:26:09 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id u9sm474737eeh.5.2010.08.18.06.26.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:26:08 -0700 (PDT)
Message-ID: <4C6BDF40.9050804@mvista.com>
Date:   Wed, 18 Aug 2010 17:25:20 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: MIPS: Get rid of branches to .subsections.
References: <20100818124310.GA23744@linux-mips.org>
In-Reply-To: <20100818124310.GA23744@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

> It was a nice optimization - on paper at least.  In practice it results in
> branches that may exceed the maximum legal range for a branch.  We can
> fight that problem with -ffunction-sections but -ffunction-sections again
> is incompatible with -pg used by the function tracer.

> By rewriting the loop around all simple LL/SC blocks to C we reduce reduce
> the amount of inline assembler and at the same time allow GCC to often
> fill the branch delay slots with something sensible or whever else clever
                                                          ^^^^^^
    Whichever?

> optimization it may have up in its sleeve.

> With this optimization gone we also no longer need -ffunction-sections,
> so drop it.

> This optimization was originall introduced in 2.6.21, commit
                         ^^^^^^^^^
     Originally.

> 5999eca25c1fd4b9b9aca7833b04d10fe4bc877d (linux-mips.org) rsp.
> f65e4fa8e0c6022ad58dc88d1b11b12589ed7f9f (kernel.org).

> Original fix for the issues which caused me to pull this optimization by
> Paul Gortmaker <paul.gortmaker@windriver.com>.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

> Index: linux-queue/arch/mips/include/asm/atomic.h
> ===================================================================
> --- linux-queue.orig/arch/mips/include/asm/atomic.h
> +++ linux-queue/arch/mips/include/asm/atomic.h

[...]

> @@ -443,18 +436,16 @@ static __inline__ void atomic64_add(long
>  	} else if (kernel_uses_llsc) {
>  		long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	mips3					\n"
> -		"1:	lld	%0, %1		# atomic64_add		\n"
> -		"	daddu	%0, %2					\n"
> -		"	scd	%0, %1					\n"
> -		"	beqz	%0, 2f					\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	.previous					\n"
> -		"	.set	mips0					\n"
> -		: "=&r" (temp), "=m" (v->counter)
> -		: "Ir" (i), "m" (v->counter));
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	lld	%0, %1		# atomic64_add	\n"

    You've kept the label here but it seems unused...

> +			"	daddu	%0, %2				\n"
> +			"	scd	%0, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "=m" (v->counter)
> +			: "Ir" (i), "m" (v->counter));
> +		} while (unlikely(!temp));
>  	} else {
>  		unsigned long flags;
>  
> @@ -488,18 +479,16 @@ static __inline__ void atomic64_sub(long
>  	} else if (kernel_uses_llsc) {
>  		long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	mips3					\n"
> -		"1:	lld	%0, %1		# atomic64_sub		\n"
> -		"	dsubu	%0, %2					\n"
> -		"	scd	%0, %1					\n"
> -		"	beqz	%0, 2f					\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	.previous					\n"
> -		"	.set	mips0					\n"
> -		: "=&r" (temp), "=m" (v->counter)
> -		: "Ir" (i), "m" (v->counter));
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	lld	%0, %1		# atomic64_sub	\n"

    Same here...

> +			"	dsubu	%0, %2				\n"
> +			"	scd	%0, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "=m" (v->counter)
> +			: "Ir" (i), "m" (v->counter));
> +		} while (unlikely(!temp));
>  	} else {
>  		unsigned long flags;
>  
> @@ -535,20 +524,19 @@ static __inline__ long atomic64_add_retu
>  	} else if (kernel_uses_llsc) {
>  		long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	mips3					\n"
> -		"1:	lld	%1, %2		# atomic64_add_return	\n"
> -		"	daddu	%0, %1, %3				\n"
> -		"	scd	%0, %2					\n"
> -		"	beqz	%0, 2f					\n"
> -		"	daddu	%0, %1, %3				\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	.previous					\n"
> -		"	.set	mips0					\n"
> -		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
> -		: "Ir" (i), "m" (v->counter)
> -		: "memory");
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	lld	%1, %2	# atomic64_add_return	\n"

    ... and here.

> +			"	daddu	%0, %1, %3			\n"
> +			"	scd	%0, %2				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
> +			: "Ir" (i), "m" (v->counter)
> +			: "memory");
> +		} while (unlikely(!result));
> +
> +		result = temp + i;
>  	} else {
>  		unsigned long flags;
>  
> @@ -587,20 +575,19 @@ static __inline__ long atomic64_sub_retu
>  	} else if (kernel_uses_llsc) {
>  		long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	mips3					\n"
> -		"1:	lld	%1, %2		# atomic64_sub_return	\n"
> -		"	dsubu	%0, %1, %3				\n"
> -		"	scd	%0, %2					\n"
> -		"	beqz	%0, 2f					\n"
> -		"	dsubu	%0, %1, %3				\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	.previous					\n"
> -		"	.set	mips0					\n"
> -		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
> -		: "Ir" (i), "m" (v->counter)
> -		: "memory");
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	lld	%1, %2	# atomic64_sub_return	\n"

    ... and here.

> +			"	dsubu	%0, %1, %3			\n"
> +			"	scd	%0, %2				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (result), "=&r" (temp), "=m" (v->counter)
> +			: "Ir" (i), "m" (v->counter)
> +			: "memory");
> +		} while (unlikely(!result));
> +
> +		result = temp - i;
>  	} else {
>  		unsigned long flags;
>  

> Index: linux-queue/arch/mips/include/asm/bitops.h
> ===================================================================
> --- linux-queue.orig/arch/mips/include/asm/bitops.h
> +++ linux-queue/arch/mips/include/asm/bitops.h
> @@ -213,24 +205,22 @@ static inline void change_bit(unsigned l
>  		"	" __SC	"%0, %1				\n"
>  		"	beqzl	%0, 1b				\n"
>  		"	.set	mips0				\n"
> -		: "=&r" (temp), "=m" (*m)
> -		: "ir" (1UL << bit), "m" (*m));
> +		: "=&r" (temp), "+m" (*m)
> +		: "ir" (1UL << bit));
>  	} else if (kernel_uses_llsc) {
>  		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
>  		unsigned long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	mips3				\n"
> -		"1:	" __LL "%0, %1		# change_bit	\n"
> -		"	xor	%0, %2				\n"
> -		"	" __SC	"%0, %1				\n"
> -		"	beqz	%0, 2f				\n"
> -		"	.subsection 2				\n"
> -		"2:	b	1b				\n"
> -		"	.previous				\n"
> -		"	.set	mips0				\n"
> -		: "=&r" (temp), "=m" (*m)
> -		: "ir" (1UL << bit), "m" (*m));
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	" __LL "%0, %1		# change_bit	\n"

    ... and here too.

> +			"	xor	%0, %2				\n"
> +			"	" __SC	"%0, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "+m" (*m)
> +			: "ir" (1UL << bit));
> +		} while (unlikely(!temp));
>  	} else {
>  		volatile unsigned long *a = addr;
>  		unsigned long mask;
> @@ -272,30 +262,26 @@ static inline int test_and_set_bit(unsig
>  		"	beqzl	%2, 1b					\n"
>  		"	and	%2, %0, %3				\n"
>  		"	.set	mips0					\n"
> -		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "r" (1UL << bit), "m" (*m)
> +		: "=&r" (temp), "+m" (*m), "=&r" (res)
> +		: "r" (1UL << bit)
>  		: "memory");
>  	} else if (kernel_uses_llsc) {
>  		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
>  		unsigned long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	push					\n"
> -		"	.set	noreorder				\n"
> -		"	.set	mips3					\n"
> -		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
> -		"	or	%2, %0, %3				\n"
> -		"	" __SC	"%2, %1					\n"
> -		"	beqz	%2, 2f					\n"
> -		"	 and	%2, %0, %3				\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	 nop						\n"
> -		"	.previous					\n"
> -		"	.set	pop					\n"
> -		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "r" (1UL << bit), "m" (*m)
> -		: "memory");
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	" __LL "%0, %1	# test_and_set_bit	\n"

    ... and here as well.

> +			"	or	%2, %0, %3			\n"
> +			"	" __SC	"%2, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "+m" (*m), "=&r" (res)
> +			: "r" (1UL << bit)
> +			: "memory");
> +		} while (unlikely(!res));
> +
> +		res = temp & (1UL << bit);
>  	} else {
>  		volatile unsigned long *a = addr;
>  		unsigned long mask;
> @@ -340,30 +326,26 @@ static inline int test_and_set_bit_lock(
>  		"	beqzl	%2, 1b					\n"
>  		"	and	%2, %0, %3				\n"
>  		"	.set	mips0					\n"
> -		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "r" (1UL << bit), "m" (*m)
> +		: "=&r" (temp), "+m" (*m), "=&r" (res)
> +		: "r" (1UL << bit)
>  		: "memory");
>  	} else if (kernel_uses_llsc) {
>  		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
>  		unsigned long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	push					\n"
> -		"	.set	noreorder				\n"
> -		"	.set	mips3					\n"
> -		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
> -		"	or	%2, %0, %3				\n"
> -		"	" __SC	"%2, %1					\n"
> -		"	beqz	%2, 2f					\n"
> -		"	 and	%2, %0, %3				\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	 nop						\n"
> -		"	.previous					\n"
> -		"	.set	pop					\n"
> -		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "r" (1UL << bit), "m" (*m)
> -		: "memory");
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	" __LL "%0, %1	# test_and_set_bit	\n"

    ... and here.

> +			"	or	%2, %0, %3			\n"
> +			"	" __SC	"%2, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "+m" (*m), "=&r" (res)
> +			: "r" (1UL << bit)
> +			: "memory");
> +		} while(unlikely(!res));
> +
> +		res = temp & (1UL << bit);
>  	} else {
>  		volatile unsigned long *a = addr;
>  		unsigned long mask;
> @@ -410,49 +392,43 @@ static inline int test_and_clear_bit(uns
[...]
>  	} else if (kernel_uses_llsc) {
>  		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
>  		unsigned long temp;
>  
> -		__asm__ __volatile__(
> -		"	.set	push					\n"
> -		"	.set	noreorder				\n"
> -		"	.set	mips3					\n"
> -		"1:	" __LL	"%0, %1		# test_and_clear_bit	\n"
> -		"	or	%2, %0, %3				\n"
> -		"	xor	%2, %3					\n"
> -		"	" __SC 	"%2, %1					\n"
> -		"	beqz	%2, 2f					\n"
> -		"	 and	%2, %0, %3				\n"
> -		"	.subsection 2					\n"
> -		"2:	b	1b					\n"
> -		"	 nop						\n"
> -		"	.previous					\n"
> -		"	.set	pop					\n"
> -		: "=&r" (temp), "=m" (*m), "=&r" (res)
> -		: "r" (1UL << bit), "m" (*m)
> -		: "memory");
> +		do {
> +			__asm__ __volatile__(
> +			"	.set	mips3				\n"
> +			"1:	" __LL	"%0, %1	# test_and_clear_bit	\n"

    ... and here.

> +			"	or	%2, %0, %3			\n"
> +			"	xor	%2, %3				\n"
> +			"	" __SC 	"%2, %1				\n"
> +			"	.set	mips0				\n"
> +			: "=&r" (temp), "+m" (*m), "=&r" (res)
> +			: "r" (1UL << bit)
> +			: "memory");
> +		} while (unlikely(!res));
> +
> +		res = temp & (1UL << bit);
>  	} else {
>  		volatile unsigned long *a = addr;
>  		unsigned long mask;

WBR, Sergei
