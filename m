Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jun 2017 01:26:08 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:36]:58164
        "EHLO resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdFJX0AEyeLD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jun 2017 01:26:00 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-04v.sys.comcast.net with SMTP
        id JplCd0nmnscBPJplWd33cm; Sat, 10 Jun 2017 23:25:58 +0000
Received: from [192.168.1.13] ([76.106.92.144])
        by resomta-ch2-16v.sys.comcast.net with SMTP
        id JplUd2f2X9isyJplVd5iiJ; Sat, 10 Jun 2017 23:25:58 +0000
Subject: Re: [PATCH 01/11] MIPS: cmpxchg: Unify R10000_LLSC_WAR &
 non-R10000_LLSC_WAR cases
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170610002644.8434-1-paul.burton@imgtec.com>
 <20170610002644.8434-2-paul.burton@imgtec.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <66c7456a-0ae6-5442-2b12-a442055f36d1@gentoo.org>
Date:   Sat, 10 Jun 2017 19:25:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170610002644.8434-2-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLop5oXs1JpoXUOWH8YvbOybPhCF1yjYP9X3BQsAYN896BSbPXfupUOUA+ISLOJtfUPHNxCccq28njfNd/LyFtFuqsozg43sgPmlGD89jixrbwJB+2Tl
 NdfJQbXGOHufeduso9xfCYKf26Mpm25mU398+wjCnwIP0aawsVzpJnjwXYPdLe6wEgtx//FqB2LeuoBApZa4QA/I0qDKBlaWPM1rS9tKCIOOGE7raydJRuEK
 7Bff4uhfqoS4WsOx1X4+gA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 06/09/2017 20:26, Paul Burton wrote:
> Prior to this patch the xchg & cmpxchg functions have duplicated code
> which is for all intents & purposes identical apart from use of a
> branch-likely instruction in the R10000_LLSC_WAR case & a regular branch
> instruction in the non-R10000_LLSC_WAR case.
> 
> This patch removes the duplication, declaring a __scbeqz macro to select
> the branch instruction suitable for use when checking the result of an
> sc instruction & making use of it to unify the 2 cases.
> 
> In __xchg_u{32,64}() this means writing the branch in asm, where it was
> previously being done in C as a do...while loop for the
> non-R10000_LLSC_WAR case. As this is a single instruction, and adds
> consistency with the R10000_LLSC_WAR cases & the cmpxchg() code, this
> seems worthwhile.

IMHO, a good cleanup.  I'll test shortly on my Octane once I get some things
moved around and a new kernel tree set up.  That said, there are a number of
locations where R10000_LLSC_WAR is used in this manner, and I think this change
should be broken out into its own patch series, with the macro that selects
normal branch over branch-likely, placed into a main MIPS header file
somewhere, and the same change made to all locations at once.  That'll give
some consistency to everything.

I don't think any of my SGI systems have the specific R10K revision that's
affected.  I've been building kernels for a while now with a patch that splits
the R10K CPU selection up into vanilla R10K, and then R12K/R14K/R16K, and using
the non-R10000_LLSC_WAR path for R12K and up, as many of my SGI systems have at
least R12K processors.  My IP28 might have the older, affected R10K, but I
haven't tested that out since 4.4 (it didn't survive for very long, either).

I also wonder if "__scbeqz" is a descriptive-enough name.  It works in this
case because the macro definition is at the top, but if moved to a different
header file, perhaps something more like "__r10k_b_insn" or such may clue
casual readers in some more?

--J


> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> 
>  arch/mips/include/asm/cmpxchg.h | 80 ++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
> index b71ab4a5fd50..0582c01d229d 100644
> --- a/arch/mips/include/asm/cmpxchg.h
> +++ b/arch/mips/include/asm/cmpxchg.h
> @@ -13,44 +13,38 @@
>  #include <asm/compiler.h>
>  #include <asm/war.h>
>  
> +/*
> + * Using a branch-likely instruction to check the result of an sc instruction
> + * works around a bug present in R10000 CPUs prior to revision 3.0 that could
> + * cause ll-sc sequences to execute non-atomically.
> + */
> +#if R10000_LLSC_WAR
> +# define __scbeqz "beqzl"
> +#else
> +# define __scbeqz "beqz"
> +#endif
> +
>  static inline unsigned long __xchg_u32(volatile int * m, unsigned int val)
>  {
>  	__u32 retval;
>  
>  	smp_mb__before_llsc();
>  
> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> +	if (kernel_uses_llsc) {
>  		unsigned long dummy;
>  
>  		__asm__ __volatile__(
> -		"	.set	arch=r4000				\n"
> +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
>  		"1:	ll	%0, %3			# xchg_u32	\n"
>  		"	.set	mips0					\n"
>  		"	move	%2, %z4					\n"
> -		"	.set	arch=r4000				\n"
> +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
>  		"	sc	%2, %1					\n"
> -		"	beqzl	%2, 1b					\n"
> +		"\t" __scbeqz "	%2, 1b					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
>  		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
>  		: "memory");
> -	} else if (kernel_uses_llsc) {
> -		unsigned long dummy;
> -
> -		do {
> -			__asm__ __volatile__(
> -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> -			"	ll	%0, %3		# xchg_u32	\n"
> -			"	.set	mips0				\n"
> -			"	move	%2, %z4				\n"
> -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> -			"	sc	%2, %1				\n"
> -			"	.set	mips0				\n"
> -			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
> -			  "=&r" (dummy)
> -			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> -			: "memory");
> -		} while (unlikely(!dummy));
>  	} else {
>  		unsigned long flags;
>  
> @@ -72,34 +66,19 @@ static inline __u64 __xchg_u64(volatile __u64 * m, __u64 val)
>  
>  	smp_mb__before_llsc();
>  
> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> +	if (kernel_uses_llsc) {
>  		unsigned long dummy;
>  
>  		__asm__ __volatile__(
> -		"	.set	arch=r4000				\n"
> +		"	.set	" MIPS_ISA_ARCH_LEVEL "			\n"
>  		"1:	lld	%0, %3			# xchg_u64	\n"
>  		"	move	%2, %z4					\n"
>  		"	scd	%2, %1					\n"
> -		"	beqzl	%2, 1b					\n"
> +		"\t" __scbeqz "	%2, 1b					\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m), "=&r" (dummy)
>  		: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
>  		: "memory");
> -	} else if (kernel_uses_llsc) {
> -		unsigned long dummy;
> -
> -		do {
> -			__asm__ __volatile__(
> -			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
> -			"	lld	%0, %3		# xchg_u64	\n"
> -			"	move	%2, %z4				\n"
> -			"	scd	%2, %1				\n"
> -			"	.set	mips0				\n"
> -			: "=&r" (retval), "=" GCC_OFF_SMALL_ASM() (*m),
> -			  "=&r" (dummy)
> -			: GCC_OFF_SMALL_ASM() (*m), "Jr" (val)
> -			: "memory");
> -		} while (unlikely(!dummy));
>  	} else {
>  		unsigned long flags;
>  
> @@ -142,24 +121,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
>  ({									\
>  	__typeof(*(m)) __ret;						\
>  									\
> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {			\
> -		__asm__ __volatile__(					\
> -		"	.set	push				\n"	\
> -		"	.set	noat				\n"	\
> -		"	.set	arch=r4000			\n"	\
> -		"1:	" ld "	%0, %2		# __cmpxchg_asm \n"	\
> -		"	bne	%0, %z3, 2f			\n"	\
> -		"	.set	mips0				\n"	\
> -		"	move	$1, %z4				\n"	\
> -		"	.set	arch=r4000			\n"	\
> -		"	" st "	$1, %1				\n"	\
> -		"	beqzl	$1, 1b				\n"	\
> -		"2:						\n"	\
> -		"	.set	pop				\n"	\
> -		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
> -		: GCC_OFF_SMALL_ASM() (*m), "Jr" (old), "Jr" (new)		\
> -		: "memory");						\
> -	} else if (kernel_uses_llsc) {					\
> +	if (kernel_uses_llsc) {						\
>  		__asm__ __volatile__(					\
>  		"	.set	push				\n"	\
>  		"	.set	noat				\n"	\
> @@ -170,7 +132,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
>  		"	move	$1, %z4				\n"	\
>  		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
>  		"	" st "	$1, %1				\n"	\
> -		"	beqz	$1, 1b				\n"	\
> +		"\t" __scbeqz "	$1, 1b				\n"	\
>  		"	.set	pop				\n"	\
>  		"2:						\n"	\
>  		: "=&r" (__ret), "=" GCC_OFF_SMALL_ASM() (*m)		\
> @@ -245,4 +207,6 @@ extern void __cmpxchg_called_with_bad_pointer(void);
>  #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
>  #endif
>  
> +#undef __scbeqz
> +
>  #endif /* __ASM_CMPXCHG_H */
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
