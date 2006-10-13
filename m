Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 14:51:41 +0100 (BST)
Received: from ms-smtp-03.rdc-nyc.rr.com ([24.29.109.7]:19073 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20038752AbWJMNvi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 14:51:38 +0100
Received: from [192.168.0.5] (cpe-74-68-39-174.nj.res.rr.com [74.68.39.174])
	by ms-smtp-03.rdc-nyc.rr.com (8.13.6/8.13.6) with ESMTP id k9DDpVnY028556;
	Fri, 13 Oct 2006 09:51:35 -0400 (EDT)
Message-ID: <452F9A41.4020505@landofbile.com>
Date:	Fri, 13 Oct 2006 09:53:05 -0400
From:	Antonio SJ Musumeci <bile@landofbile.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: patch: include/asm-mips/system.h __cmpxchg64 bugfix and cleanup
References: <200610121802.k9CI26I5017308@ms-smtp-01.rdc-nyc.rr.com> <20061013104250.GA16820@linux-mips.org>
In-Reply-To: <20061013104250.GA16820@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <bile@landofbile.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bile@landofbile.com
Precedence: bulk
X-list: linux-mips

Should I apply my patch on top of this one?

Ralf Baechle wrote:
> On Thu, Oct 12, 2006 at 02:03:39PM -0400, bile@landofbile.com wrote:
> 
>> In include/asm-mips/system.h __cmpxchg_u64 is doing
>>
>> if(cpu_has_llsc) {
>> } else if(cpu_has_llsc) {
>>
>> the first should be (cpu_has_llsc && R10000_LLSC_WAR).
>>
>> While this probably gets cleaned up during optimization I took
>> the liberty of cleaning up the code along with the fix so it's
>> not doing the double check and only includes the R10000 workaround
>> at compile time.
> 
> Please include a Signed-off-by: line when submitting patches.
> 
>> diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
>> index dcb4701..bfae6ff 100644
>> --- a/include/asm-mips/system.h
>> +++ b/include/asm-mips/system.h
>> @@ -206,7 +206,7 @@ static inline unsigned long __xchg_u32(v
>>  {
>>  	__u32 retval;
>>  
>> -	if (cpu_has_llsc && R10000_LLSC_WAR) {
>> +	if (cpu_has_llsc) {
> 
> Thanks for spotting this one.
> 
>> @@ -216,25 +216,11 @@ static inline unsigned long __xchg_u32(v
>>  		"	move	%2, %z4					\n"
>>  		"	.set	mips3					\n"
>>  		"	sc	%2, %1					\n"
>> +#ifdef R10000_LLSC_WAR
> 
> This isn't quite right since R10000_LLSC_WAR is defined to 0 if the
> workaround is not enabled, so "#if R10000_LLSC_WAR" would be needed
> here.
> 
>>  		"	beqzl	%2, 1b					\n"
>> -#ifdef CONFIG_SMP
>> -		"	sync						\n"
>> -#endif
> 
> Now the real reason why I don't want to apply your patch is below patch
> which is playing fancy tricks with the branch prediction of modern
> processors.  The R10000 ll/sc workaround _relies_ on the missprediction
> of the branch likely branch to work correctly, so this optimization
> could not be applied to it that is we need two different versions.
> 
>   Ralf
> 
> commit 23d60625d8a383a7faf632a50c2298c9c65aa0b2
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Thu Sep 28 01:45:21 2006 +0100
> 
>     [MIPS] Improve branch prediction in ll/sc atomic operations.
>     
>     Now that finally all supported versions of binutils have functioning
>     support for .subsection use .subsection to tweak the branch prediction
>     
>     I did not modify the R10000 errata variants because it seems unclear if
>     this will invalidate the workaround which actually relies on the cheesy
>     prediction of branch likely to cause a misspredict if the sc was
>     successful.
>     
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/include/asm-mips/atomic.h b/include/asm-mips/atomic.h
> index e64abc0..91bf6a7 100644
> --- a/include/asm-mips/atomic.h
> +++ b/include/asm-mips/atomic.h
> @@ -9,7 +9,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 1996, 97, 99, 2000, 03, 04 by Ralf Baechle
> + * Copyright (C) 1996, 97, 99, 2000, 03, 04, 06 Ralf Baechle
>   */
>  
>  /*
> @@ -76,7 +76,10 @@ static __inline__ void atomic_add(int i,
>  		"1:	ll	%0, %1		# atomic_add		\n"
>  		"	addu	%0, %2					\n"
>  		"	sc	%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter));
> @@ -118,7 +121,10 @@ static __inline__ void atomic_sub(int i,
>  		"1:	ll	%0, %1		# atomic_sub		\n"
>  		"	subu	%0, %2					\n"
>  		"	sc	%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter));
> @@ -161,9 +167,12 @@ static __inline__ int atomic_add_return(
>  		"1:	ll	%1, %2		# atomic_add_return	\n"
>  		"	addu	%0, %1, %3				\n"
>  		"	sc	%0, %2					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	addu	%0, %1, %3				\n"
>  		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> @@ -208,9 +217,12 @@ static __inline__ int atomic_sub_return(
>  		"1:	ll	%1, %2		# atomic_sub_return	\n"
>  		"	subu	%0, %1, %3				\n"
>  		"	sc	%0, %2					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	subu	%0, %1, %3				\n"
>  		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> @@ -269,11 +281,14 @@ static __inline__ int atomic_sub_if_posi
>  		"	bltz	%0, 1f					\n"
>  		"	sc	%0, %2					\n"
>  		"	.set	noreorder				\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	 subu	%0, %1, %3				\n"
>  		"	.set	reorder					\n"
>  		"	sync						\n"
>  		"1:							\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> @@ -430,7 +445,10 @@ static __inline__ void atomic64_add(long
>  		"1:	lld	%0, %1		# atomic64_add		\n"
>  		"	addu	%0, %2					\n"
>  		"	scd	%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter));
> @@ -472,7 +490,10 @@ static __inline__ void atomic64_sub(long
>  		"1:	lld	%0, %1		# atomic64_sub		\n"
>  		"	subu	%0, %2					\n"
>  		"	scd	%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter));
> @@ -515,9 +536,12 @@ static __inline__ long atomic64_add_retu
>  		"1:	lld	%1, %2		# atomic64_add_return	\n"
>  		"	addu	%0, %1, %3				\n"
>  		"	scd	%0, %2					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	addu	%0, %1, %3				\n"
>  		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> @@ -562,9 +586,12 @@ static __inline__ long atomic64_sub_retu
>  		"1:	lld	%1, %2		# atomic64_sub_return	\n"
>  		"	subu	%0, %1, %3				\n"
>  		"	scd	%0, %2					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	subu	%0, %1, %3				\n"
>  		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> @@ -623,11 +650,14 @@ static __inline__ long atomic64_sub_if_p
>  		"	bltz	%0, 1f					\n"
>  		"	scd	%0, %2					\n"
>  		"	.set	noreorder				\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
>  		"	 dsubu	%0, %1, %3				\n"
>  		"	.set	reorder					\n"
>  		"	sync						\n"
>  		"1:							\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
>  		: "Ir" (i), "m" (v->counter)
> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
> index 1bb89c5..d10bd56 100644
> --- a/include/asm-mips/bitops.h
> +++ b/include/asm-mips/bitops.h
> @@ -3,7 +3,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (c) 1994 - 1997, 1999, 2000  Ralf Baechle (ralf@gnu.org)
> + * Copyright (c) 1994 - 1997, 1999, 2000, 06 Ralf Baechle (ralf@linux-mips.org)
>   * Copyright (c) 1999, 2000  Silicon Graphics, Inc.
>   */
>  #ifndef _ASM_BITOPS_H
> @@ -86,7 +86,10 @@ static inline void set_bit(unsigned long
>  		"1:	" __LL "%0, %1			# set_bit	\n"
>  		"	or	%0, %2					\n"
>  		"	" __SC	"%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (*m)
>  		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
> @@ -134,7 +137,10 @@ static inline void clear_bit(unsigned lo
>  		"1:	" __LL "%0, %1			# clear_bit	\n"
>  		"	and	%0, %2					\n"
>  		"	" __SC "%0, %1					\n"
> -		"	beqz	%0, 1b					\n"
> +		"	beqz	%0, 2f					\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (temp), "=m" (*m)
>  		: "ir" (~(1UL << (nr & SZLONG_MASK))), "m" (*m));
> @@ -184,7 +190,10 @@ static inline void change_bit(unsigned l
>  		"1:	" __LL "%0, %1		# change_bit	\n"
>  		"	xor	%0, %2				\n"
>  		"	" __SC	"%0, %1				\n"
> -		"	beqz	%0, 1b				\n"
> +		"	beqz	%0, 2f				\n"
> +		"	.subsection 2				\n"
> +		"2:	b	1b				\n"
> +		"	.previous				\n"
>  		"	.set	mips0				\n"
>  		: "=&r" (temp), "=m" (*m)
>  		: "ir" (1UL << (nr & SZLONG_MASK)), "m" (*m));
> @@ -243,11 +252,14 @@ #endif
>  		"1:	" __LL "%0, %1		# test_and_set_bit	\n"
>  		"	or	%2, %0, %3				\n"
>  		"	" __SC	"%2, %1					\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  		"	 and	%2, %0, %3				\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	pop					\n"
>  		: "=&r" (temp), "=m" (*m), "=&r" (res)
>  		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
> @@ -315,11 +327,14 @@ #endif
>  		"	or	%2, %0, %3				\n"
>  		"	xor	%2, %3					\n"
>  		"	" __SC 	"%2, %1					\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  		"	 and	%2, %0, %3				\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	pop					\n"
>  		: "=&r" (temp), "=m" (*m), "=&r" (res)
>  		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
> @@ -385,11 +400,14 @@ #endif
>  		"1:	" __LL	"%0, %1		# test_and_change_bit	\n"
>  		"	xor	%2, %0, %3				\n"
>  		"	" __SC	"\t%2, %1				\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  		"	 and	%2, %0, %3				\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	pop					\n"
>  		: "=&r" (temp), "=m" (*m), "=&r" (res)
>  		: "r" (1UL << (nr & SZLONG_MASK)), "m" (*m)
> diff --git a/include/asm-mips/spinlock.h b/include/asm-mips/spinlock.h
> index 4c1a1b5..3df6103 100644
> --- a/include/asm-mips/spinlock.h
> +++ b/include/asm-mips/spinlock.h
> @@ -3,7 +3,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 1999, 2000 by Ralf Baechle
> + * Copyright (C) 1999, 2000, 06 Ralf Baechle (ralf@linux-mips.org)
>   * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
>   */
>  #ifndef _ASM_SPINLOCK_H
> @@ -49,11 +49,18 @@ static inline void __raw_spin_lock(raw_s
>  		__asm__ __volatile__(
>  		"	.set	noreorder	# __raw_spin_lock	\n"
>  		"1:	ll	%1, %2					\n"
> -		"	bnez	%1, 1b					\n"
> +		"	bnez	%1, 2f					\n"
>  		"	 li	%1, 1					\n"
>  		"	sc	%1, %0					\n"
> -		"	beqz	%1, 1b					\n"
> +		"	beqz	%1, 2f					\n"
>  		"	 sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	ll	%1, %2					\n"
> +		"	bnez	%1, 2b					\n"
> +		"	 li	%1, 1					\n"
> +		"	b	1b					\n"
> +		"	 nop						\n"
> +		"	.previous					\n"
>  		"	.set	reorder					\n"
>  		: "=m" (lock->lock), "=&r" (tmp)
>  		: "m" (lock->lock)
> @@ -97,9 +104,12 @@ static inline unsigned int __raw_spin_tr
>  		"1:	ll	%0, %3					\n"
>  		"	ori	%2, %0, 1				\n"
>  		"	sc	%2, %1					\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  		"	 andi	%2, %0, 1				\n"
>  		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	reorder"
>  		: "=&r" (temp), "=m" (lock->lock), "=&r" (res)
>  		: "m" (lock->lock)
> @@ -152,11 +162,17 @@ static inline void __raw_read_lock(raw_r
>  		__asm__ __volatile__(
>  		"	.set	noreorder	# __raw_read_lock	\n"
>  		"1:	ll	%1, %2					\n"
> -		"	bltz	%1, 1b					\n"
> +		"	bltz	%1, 2f					\n"
>  		"	 addu	%1, 1					\n"
>  		"	sc	%1, %0					\n"
>  		"	beqz	%1, 1b					\n"
>  		"	 sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	ll	%1, %2					\n"
> +		"	bltz	%1, 2b					\n"
> +		"	 addu	%1, 1					\n"
> +		"	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	reorder					\n"
>  		: "=m" (rw->lock), "=&r" (tmp)
>  		: "m" (rw->lock)
> @@ -187,8 +203,10 @@ static inline void __raw_read_unlock(raw
>  		"1:	ll	%1, %2					\n"
>  		"	sub	%1, 1					\n"
>  		"	sc	%1, %0					\n"
> -		"	beqz	%1, 1b					\n"
> +		"	beqz	%1, 2f					\n"
>  		"	 sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
>  		"	.set	reorder					\n"
>  		: "=m" (rw->lock), "=&r" (tmp)
>  		: "m" (rw->lock)
> @@ -217,11 +235,17 @@ static inline void __raw_write_lock(raw_
>  		__asm__ __volatile__(
>  		"	.set	noreorder	# __raw_write_lock	\n"
>  		"1:	ll	%1, %2					\n"
> -		"	bnez	%1, 1b					\n"
> +		"	bnez	%1, 2f					\n"
>  		"	 lui	%1, 0x8000				\n"
>  		"	sc	%1, %0					\n"
> -		"	beqz	%1, 1b					\n"
> +		"	beqz	%1, 2f					\n"
>  		"	 sync						\n"
> +		"	.subsection 2					\n"
> +		"2:	ll	%1, %2					\n"
> +		"	bnez	%1, 1b					\n"
> +		"	 lui	%1, 0x8000				\n"
> +		"	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	reorder					\n"
>  		: "=m" (rw->lock), "=&r" (tmp)
>  		: "m" (rw->lock)
> @@ -314,11 +338,15 @@ static inline int __raw_write_trylock(ra
>  		"	bnez	%1, 2f					\n"
>  		"	lui	%1, 0x8000				\n"
>  		"	sc	%1, %0					\n"
> -		"	beqz	%1, 1b					\n"
> -		"	 sync						\n"
> -		"	li	%2, 1					\n"
> -		"	.set	reorder					\n"
> +		"	beqz	%1, 3f					\n"
> +		"	 li	%2, 1					\n"
>  		"2:							\n"
> +		"	sync						\n"
> +		"	.subsection 2					\n"
> +		"3:	b	1b					\n"
> +		"	li	%2, 0					\n"
> +		"	.previous					\n"
> +		"	.set	reorder					\n"
>  		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
>  		: "m" (rw->lock)
>  		: "memory");
> diff --git a/include/asm-mips/system.h b/include/asm-mips/system.h
> index dcb4701..fc35526 100644
> --- a/include/asm-mips/system.h
> +++ b/include/asm-mips/system.h
> @@ -3,7 +3,7 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 1994, 95, 96, 97, 98, 99, 2003 by Ralf Baechle
> + * Copyright (C) 1994, 95, 96, 97, 98, 99, 2003, 06 by Ralf Baechle
>   * Copyright (C) 1996 by Paul M. Antoine
>   * Copyright (C) 1999 Silicon Graphics
>   * Kevin D. Kissell, kevink@mips.org and Carsten Langgaard, carstenl@mips.com
> @@ -234,10 +234,13 @@ #endif
>  		"	move	%2, %z4					\n"
>  		"	.set	mips3					\n"
>  		"	sc	%2, %1					\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
>  		: "R" (*m), "Jr" (val)
> @@ -283,10 +286,13 @@ #endif
>  		"1:	lld	%0, %3			# xchg_u64	\n"
>  		"	move	%2, %z4					\n"
>  		"	scd	%2, %1					\n"
> -		"	beqz	%2, 1b					\n"
> +		"	beqz	%2, 2f					\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
> +		"	.subsection 2					\n"
> +		"2:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (retval), "=m" (*m), "=&r" (dummy)
>  		: "R" (*m), "Jr" (val)
> @@ -364,11 +370,14 @@ #endif
>  		"	move	$1, %z4					\n"
>  		"	.set	mips3					\n"
>  		"	sc	$1, %1					\n"
> -		"	beqz	$1, 1b					\n"
> +		"	beqz	$1, 3f					\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
>  		"2:							\n"
> +		"	.subsection 2					\n"
> +		"3:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	pop					\n"
>  		: "=&r" (retval), "=R" (*m)
>  		: "R" (*m), "Jr" (old), "Jr" (new)
> @@ -419,11 +428,14 @@ #endif
>  		"	bne	%0, %z3, 2f				\n"
>  		"	move	$1, %z4					\n"
>  		"	scd	$1, %1					\n"
> -		"	beqz	$1, 1b					\n"
> +		"	beqz	$1, 3f					\n"
>  #ifdef CONFIG_SMP
>  		"	sync						\n"
>  #endif
>  		"2:							\n"
> +		"	.subsection 2					\n"
> +		"3:	b	1b					\n"
> +		"	.previous					\n"
>  		"	.set	pop					\n"
>  		: "=&r" (retval), "=R" (*m)
>  		: "R" (*m), "Jr" (old), "Jr" (new)
> 
> 
> 
