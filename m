Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2014 18:08:29 +0100 (CET)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35245 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012733AbaKFRI1a0yr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Nov 2014 18:08:27 +0100
Received: by mail-ie0-f180.google.com with SMTP id y20so3414489ier.11
        for <linux-mips@linux-mips.org>; Thu, 06 Nov 2014 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vvWWYJRnM1MBgvBJ9i2yEInQpJnZJW2U2jO7r4FchOE=;
        b=zUUTqkGPLw/6kI6R5D/GY6vHYeQoqq0aYhS6F7lgsTbxjBsLPw8nSr0Wt4HCKaaSte
         W7B8FhofnLIo6ZrIzxPbSUFtQ6gI+k7G1tW8qv4hbLswV+V/IHxXk+5mZElswAs4tJgO
         /FYVdMJnhqqf694r7KH0qohDA99GLm6bfXSt6b5HaFeFzakXGAPHlqtGYUPRp2zhRGkN
         2S9U2PMb7EUBm6doMAmqjgdI+VCXjAJknGXh8sSxW7rx1HK+wWr80o86XOkIWYVcRojV
         cjmQcxr4o2zEB8UbSjvJP/YjHM5XRmYsb3GeNLJBwrRQxN0CKem8nftCfqnLv8BbKd42
         YAug==
X-Received: by 10.107.166.78 with SMTP id p75mr6430326ioe.16.1415293701253;
        Thu, 06 Nov 2014 09:08:21 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id m63sm3129309ioe.40.2014.11.06.09.08.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Nov 2014 09:08:20 -0800 (PST)
Message-ID: <545BAB03.7050600@gmail.com>
Date:   Thu, 06 Nov 2014 09:08:19 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Mans Rullgard <mans@mansr.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH] MIPS: optimise 32-bit do_div() with constant divisor
References: <1415290998-10328-1-git-send-email-mans@mansr.com>
In-Reply-To: <1415290998-10328-1-git-send-email-mans@mansr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/06/2014 08:23 AM, Mans Rullgard wrote:
> This is an adaptation of the optimised do_div() for ARM by
> Nicolas Pitre implementing division by a constant using a
> multiplication by the inverse.  Ideally, the compiler would
> do this internally as it does for 32-bit operands, but it
> doesn't.
>
> This version of the code requires an assembler with support
> for the DSP ASE syntax since accessing the hi/lo registers
> sanely from inline asm is impossible without this.

It is easy to access hi/lo from inline asm.  It is true that it is 
difficult to use them as input/output registers.

You should use MFHI/MFLO and to move the results to some general purpose 
registers.  Then mention "hi", "lo" in the clobbers statement for the 
inline asm.

FWIW, it seems like you are missing the clobbers in your inline asm below.


>  Building
> for a CPU without this extension still works, however.
>
> It also does not protect against the WAR hazards for the
> hi/lo registers present on CPUs prior to MIPS IV.
>
> I have only tested it as far as booting and light use with
> the BUG_ON enabled wihtout encountering any issues.
>
> The inverse computation code is a straight copy from ARM,
> so this should probably be moved to a shared location.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>   arch/mips/include/asm/div64.h | 178 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 174 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/div64.h b/arch/mips/include/asm/div64.h
> index dc5ea57..bcebfb1 100644
> --- a/arch/mips/include/asm/div64.h
> +++ b/arch/mips/include/asm/div64.h
> @@ -9,12 +9,12 @@
>   #ifndef __ASM_DIV64_H
>   #define __ASM_DIV64_H
>
> -#include <asm-generic/div64.h>
> -
> -#if BITS_PER_LONG == 64
> -
>   #include <linux/types.h>
>
> +#if BITS_PER_LONG == 64
> +
> +#include <asm-generic/div64.h>
> +
>   /*
>    * No traps on overflows for any of these...
>    */
> @@ -63,6 +63,176 @@
>   	__mod32;							\
>   })
>
> +#elif __GNUC__ >= 4
> +
> +#include <asm/bug.h>
> +
> +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> +
> +/*
> + * If the divisor happens to be constant, we determine the appropriate
> + * inverse at compile time to turn the division into a few inline
> + * multiplications instead which is much faster.
> + * (It is unfortunate that gcc doesn't perform all this internally.)
> + */
> +#define do_div(n, base)							\
> +({									\
> +	unsigned int __r, __b = (base);					\
> +	if (likely(((n) >> 32) == 0)) {					\
> +		__r = (u32)(n) % __b;					\
> +		(n) = (u32)(n) / __b;					\
> +	} else if (!__builtin_constant_p(__b) || __b == 0) {		\
> +		/* non-constant divisor (or zero): slow path */		\
> +		__r = __div64_32(&(n), __b);				\
> +	} else if ((__b & (__b - 1)) == 0) {				\
> +		/* Trivial: __b is constant and a power of 2 */		\
> +		/* gcc does the right thing with this code.  */		\
> +		__r = n;						\
> +		__r &= (__b - 1);					\
> +		n /= __b;						\
> +	} else {							\
> +		/* Multiply by inverse of __b: n/b = n*(p/b)/p       */	\
> +		/* We rely on the fact that most of this code gets   */	\
> +		/* optimized away at compile time due to constant    */	\
> +		/* propagation and only a couple inline assembly     */	\
> +		/* instructions should remain. Better avoid any      */	\
> +		/* code construct that might prevent that.           */	\
> +		unsigned long long __res, __x, __t, __m, __n = n;	\
> +		unsigned int __c, __p, __z = 0;				\
> +		/* preserve low part of n for reminder computation */	\
> +		__r = __n;						\
> +		/* determine number of bits to represent __b */		\
> +		__p = 1 << __div64_fls(__b);				\
> +		/* compute __m = ((__p << 64) + __b - 1) / __b */	\
> +		__m = (~0ULL / __b) * __p;				\
> +		__m += (((~0ULL % __b + 1) * __p) + __b - 1) / __b;	\
> +		/* compute __res = __m*(~0ULL/__b*__b-1)/(__p << 64) */	\
> +		__x = ~0ULL / __b * __b - 1;				\
> +		__res = (__m & 0xffffffff) * (__x & 0xffffffff);	\
> +		__res >>= 32;						\
> +		__res += (__m & 0xffffffff) * (__x >> 32);		\
> +		__t = __res;						\
> +		__res += (__x & 0xffffffff) * (__m >> 32);		\
> +		__t = (__res < __t) ? (1ULL << 32) : 0;			\
> +		__res = (__res >> 32) + __t;				\
> +		__res += (__m >> 32) * (__x >> 32);			\
> +		__res /= __p;						\
> +		/* Now sanitize and optimize what we've got. */		\
> +		if (~0ULL % (__b / (__b & -__b)) == 0) {		\
> +			/* those cases can be simplified with: */	\
> +			__n /= (__b & -__b);				\
> +			__m = ~0ULL / (__b / (__b & -__b));		\
> +			__p = 1;					\
> +			__c = 1;					\
> +		} else if (__res != __x / __b) {			\
> +			/* We can't get away without a correction    */	\
> +			/* to compensate for bit truncation errors.  */	\
> +			/* To avoid it we'd need an additional bit   */	\
> +			/* to represent __m which would overflow it. */	\
> +			/* Instead we do m=p/b and n/b=(n*m+m)/p.    */	\
> +			__c = 1;					\
> +			/* Compute __m = (__p << 64) / __b */		\
> +			__m = (~0ULL / __b) * __p;			\
> +			__m += ((~0ULL % __b + 1) * __p) / __b;		\
> +		} else {						\
> +			/* Reduce __m/__p, and try to clear bit 31   */	\
> +			/* of __m when possible otherwise that'll    */	\
> +			/* need extra overflow handling later.       */	\
> +			unsigned int __bits = -(__m & -__m);		\
> +			__bits |= __m >> 32;				\
> +			__bits = (~__bits) << 1;			\
> +			/* If __bits == 0 then setting bit 31 is     */	\
> +			/* unavoidable.  Simply apply the maximum    */	\
> +			/* possible reduction in that case.          */	\
> +			/* Otherwise the MSB of __bits indicates the */	\
> +			/* best reduction we should apply.           */	\
> +			if (!__bits) {					\
> +				__p /= (__m & -__m);			\
> +				__m /= (__m & -__m);			\
> +			} else {					\
> +				__p >>= __div64_fls(__bits);		\
> +				__m >>= __div64_fls(__bits);		\
> +			}						\
> +			/* No correction needed. */			\
> +			__c = 0;					\
> +		}							\
> +		/* Now we have a combination of 2 conditions:        */	\
> +		/* 1) whether or not we need a correction (__c), and */	\
> +		/* 2) whether or not there might be an overflow in   */	\
> +		/*    the cross product (__m & ((1<<63) | (1<<31)))  */	\
> +		/* Select the best insn combination to perform the   */	\
> +		/* actual __m * __n / (__p << 64) operation.         */	\
> +		if (!__c) {						\
> +			__res = (u64)(u32)__m * (u32)__n >> 32;		\
> +		} else if (!(__m & ((1ULL << 63) | (1ULL << 31)))) {	\
> +			__res = (__m + (u64)(u32)__m * (u32)__n) >> 32;	\
> +		} else {						\
> +			__t = __m;					\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q2, %L3, %L4	\n"             \
> +                                "mflo	%L0, %q2	\n"             \
> +                                "mfhi	%M0, %q2	\n"             \
> +				"sltu	%1,  %L0, %L3	\n"		\
> +				"addu	%L0, %M0, %1	\n"		\
> +				"sltu	%M0, %L0, %M3	\n"		\
> +				".set	pop		\n"		\
> +				: "=&r"(__res), "=&r"(__c), "+&ka"(__t) \
> +				: "r"(__m), "r"(__n));			\
> +		}							\
> +		if (!(__m & ((1ULL << 63) | (1ULL << 31)))) {		\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q0, %M2, %L3	\n"		\
> +				"maddu	%q0, %L2, %M3	\n"		\
> +				"mfhi	%1,  %q0	\n"		\
> +				"mthi	$0,  %q0	\n"		\
> +				"mtlo	%1,  %q0	\n"		\
> +				"maddu	%q0, %M2, %M3	\n"		\
> +				".set	pop		\n"		\
> +				: "+&ka"(__res), "=&r"(__c)		\
> +				: "r"(__m), "r"(__n));			\
> +		} else {						\
> +			asm (	".set	push		\n"		\
> +				".set	dsp		\n"		\
> +				"maddu	%q0, %M3, %L4	\n"		\
> +				"mfhi	%2,  %q0	\n"		\
> +				"maddu	%q0, %L3, %M4	\n"		\
> +				"mfhi	%1,  %q0	\n"		\
> +				"sltu	%2,  %1,  %2	\n"		\
> +				"mtlo	%1,  %q0	\n"		\
> +				"mthi	%2,  %q0	\n"		\
> +				"maddu	%q0, %M3, %M4	\n"		\
> +				".set	pop		\n"		\
> +				: "+&ka"(__res), "=&r"(__z), "=&r"(__c) \
> +				: "r"(__m), "r"(__n));			\
> +		}							\
> +		__res /= __p;						\
> +		/* The reminder can be computed with 32-bit regs     */	\
> +		/* only, and gcc is good at that.                    */	\
> +		{							\
> +			unsigned int __res0 = __res;			\
> +			unsigned int __b0 = __b;			\
> +			__r -= __res0 * __b0;				\
> +		}							\
> +		/* BUG_ON(__r >= __b || __res * __b + __r != n); */	\
> +		n = __res;						\
> +	}								\
> +	__r;								\
> +})
> +
> +/* our own fls implementation to make sure constant propagation is fine */
> +#define __div64_fls(bits)						\
> +({									\
> +	unsigned int __left = (bits), __nr = 0;				\
> +	if (__left & 0xffff0000) __nr += 16, __left >>= 16;		\
> +	if (__left & 0x0000ff00) __nr +=  8, __left >>=  8;		\
> +	if (__left & 0x000000f0) __nr +=  4, __left >>=  4;		\
> +	if (__left & 0x0000000c) __nr +=  2, __left >>=  2;		\
> +	if (__left & 0x00000002) __nr +=  1;				\
> +	__nr;								\
> +})
> +
>   #endif /* BITS_PER_LONG == 64 */
>
>   #endif /* __ASM_DIV64_H */
>
