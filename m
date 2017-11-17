Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 18:46:58 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:46757 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKQRqvJZexR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 18:46:51 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 17 Nov 2017 17:46:43 +0000
Received: from [10.20.78.89] (10.20.78.89) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Fri, 17 Nov 2017 09:46:43 -0800
Date:   Fri, 17 Nov 2017 17:45:29 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
In-Reply-To: <23fb0d7b-347a-195d-38f3-383ac59cc69d@gentoo.org>
Message-ID: <alpine.DEB.2.00.1711171715020.3888@tp.orcam.me.uk>
References: <23fb0d7b-347a-195d-38f3-383ac59cc69d@gentoo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510940803-637138-21350-155560-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187049
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 17 Nov 2017, Joshua Kinard wrote:

> This patch reduces down the conditionals in MIPS atomic code that deal
> with a silicon bug in early R10000 cpus that required a workaround of
> a branch-likely instruction following a store-conditional in order to
> to guarantee the whole ll/sc sequence is atomic.  As the only real
> difference is a branch-likely instruction (beqzl) over a standard
> branch (beqz), the conditional is reduced down to down to a single

 s/down to down to/down to/

> preprocessor check at the top to pick the required instruction.
> 
> This requires writing the uses in assembler, thus we discard the
> non-R10000 case that uses a mixture of a C do...while loop with
> embedded assembler that was added back in commit 7837314d141c.  A note
> found in the git log for empty commit 5999eca25c1f is also addressed

 Please use `commit 7837314d141c ("MIPS: Get rid of branches to 
.subsections.")', `commit 5999eca25c1f ("[MIPS] Improve branch prediction 
in ll/sc atomic operations.")' style in commit descriptions.  Please also 
pass your changes through `scripts/checkpatch.pl', which would have 
pointed it out.

 Also why do you think commit 5999eca25c1f was empty?  It certainly does 
not show up as empty for me.  Did you quote the correct commit ID?  I 
think it would be good too if you clarified which note in that commit you 
have specifically referred to.

> ---
> Changes in v3:
> - Make the result of subu/dsubu available to sc/scd in
>   atomic_sub_if_positive and atomic64_sub_if_positive while still
>   avoiding the use of 'noreorder'.
> 
> Changes in v2:
> - Incorporate suggestions from upstream to atomic_sub_if_positive
>   and atomic64_sub_if_positive to avoid memory barriers, as those
>   are already implied and to eliminate the '.noreorder' directive
>   and corner case of subu/dsubu's output not getting used in the
>   branch-likely case due to being in the branch delay slot.

 I think the BEQZL delay slot bug fixes to `atomic_sub_if_positive' and 
`atomic64_sub_if_positive' should be split off and submitted separately as 
a preparatory patch, so that they can be backported to stable branches; 
please do so.  It'll also make your original clean up that follows 
clearer.

> @@ -563,42 +461,21 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
>  
>  	smp_mb__before_llsc();
>  
> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> -		long temp;
> -
> -		__asm__ __volatile__(
> -		"	.set	arch=r4000				\n"
> -		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> -		"	dsubu	%0, %1, %3				\n"
> -		"	bltz	%0, 1f					\n"
> -		"	scd	%0, %2					\n"
> -		"	.set	noreorder				\n"
> -		"	beqzl	%0, 1b					\n"
> -		"	 dsubu	%0, %1, %3				\n"
> -		"	.set	reorder					\n"
> -		"1:							\n"
> -		"	.set	mips0					\n"
> -		: "=&r" (result), "=&r" (temp),
> -		  "=" GCC_OFF_SMALL_ASM() (v->counter)
> -		: "Ir" (i), GCC_OFF_SMALL_ASM() (v->counter)
> -		: "memory");
> -	} else if (kernel_uses_llsc) {
> +	if (kernel_uses_llsc) {
>  		long temp;
>  
>  		__asm__ __volatile__(
>  		"	.set	"MIPS_ISA_LEVEL"			\n"
>  		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>  		"	dsubu	%0, %1, %3				\n"
> +		"	move	%1, %0					\n"
>  		"	bltz	%0, 1f					\n"
> -		"	scd	%0, %2					\n"
> -		"	.set	noreorder				\n"
> -		"	beqz	%0, 1b					\n"
> -		"	 dsubu	%0, %1, %3				\n"
> -		"	.set	reorder					\n"
> +		"	scd	%1, %2					\n"
> +		"\t" __scbeqz "	%1, 1b					\n"
>  		"1:							\n"
>  		"	.set	mips0					\n"
>  		: "=&r" (result), "=&r" (temp),
> -		  "+" GCC_OFF_SMALL_ASM() (v->counter)
> +		  "=" GCC_OFF_SMALL_ASM() (v->counter)

 This is wrong, `v->counter' is both read and written, so `+' has to stay.

 Otherwise OK, I think.  Perhaps you can split off another patch, just to 
fix up the mess with constraints, which should be either:

		: "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)
                : "Ir" (i));

if there is no result or:

		: "=&r" (result), "=&r" (temp),
		  "+" GCC_OFF_SMALL_ASM() (v->counter)
		: "Ir" (i));

if there is one.  This would be patch #2 in the series then and would make 
the final review easier I believe.

  Maciej
