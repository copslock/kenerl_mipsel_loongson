Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Nov 2017 15:40:56 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990429AbdKDOktGcBqm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Nov 2017 15:40:49 +0100
Date:   Sat, 4 Nov 2017 14:40:49 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
In-Reply-To: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
Message-ID: <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 17 Oct 2017, Joshua Kinard wrote:

> @@ -563,17 +464,17 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
>  
>  	smp_mb__before_llsc();
>  
> -	if (kernel_uses_llsc && R10000_LLSC_WAR) {
> +	if (kernel_uses_llsc) {
>  		long temp;
>  
>  		__asm__ __volatile__(
> -		"	.set	arch=r4000				\n"
> +		"	.set	"MIPS_ISA_LEVEL"			\n"
>  		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
>  		"	dsubu	%0, %1, %3				\n"
>  		"	bltz	%0, 1f					\n"
>  		"	scd	%0, %2					\n"
>  		"	.set	noreorder				\n"
> -		"	beqzl	%0, 1b					\n"
> +		"\t" __scbeqz "	%0, 1b					\n"
>  		"	 dsubu	%0, %1, %3				\n"
>  		"	.set	reorder					\n"
>  		"1:							\n"

 This is obviously a preexisting bug, which has only been made more 
obvious with your merge of this code, but this can't be right, because the 
final DSUBU instruction which calculates `result', later returned, in %0 
will not be executed with BEQZL in the fall-through case, however it will 
be in the BEQZ case.

 It may make sense to split the temporary set by SCD from the result and 
then the final DSUBU won't be needed at all as the result will have 
already been calculated by the first DSUBU.  In fact ISTM %1 can simply be 
used, i.e.:

		__asm__ __volatile__(
		"	.set	"MIPS_ISA_LEVEL"			\n"
		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
		"	dsubu	%0, %1, %3				\n"
		"	bltz	%0, 1f					\n"
		"	scd	%1, %2					\n"
		"\t" __scbeqz "	%1, 1b					\n"
		"1:							\n"
		"	.set	mips0					\n"
		: "=&r" (result), "=&r" (temp),
		  "+" GCC_OFF_SMALL_ASM() (v->counter)
		: "Ir" (i));

making this short and sweet, also avoiding the nasty `noreorder' piece and 
therefore making it one place less to concern about with porting Linux to 
the microMIPSr6 ISA.

 I haven't gone through the remaining updates; it's just this piece that 
has caught my eye as I glanced over your change.

  Maciej
