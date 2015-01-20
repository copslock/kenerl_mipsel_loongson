Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 02:04:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42505 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbbATBEj2I0dD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 02:04:39 +0100
Date:   Tue, 20 Jan 2015 01:04:39 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub instruction
 with addiu
In-Reply-To: <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45344
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> sub $reg, imm is not a real MIPS instruction. The assembler replaces
> that with 'addi $reg, -imm'. However, addi has been removed from R6,
> so we replace the 'sub' instruction with 'addiu' instead.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/spinlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/spinlock.h b/arch/mips/include/asm/spinlock.h
> index c6d06d383ef9..500050d3bda6 100644
> --- a/arch/mips/include/asm/spinlock.h
> +++ b/arch/mips/include/asm/spinlock.h
> @@ -276,7 +276,7 @@ static inline void arch_read_unlock(arch_rwlock_t *rw)
>  		do {
>  			__asm__ __volatile__(
>  			"1:	ll	%1, %2	# arch_read_unlock	\n"
> -			"	sub	%1, 1				\n"
> +			"	addiu	%1, -1				\n"
>  			"	sc	%1, %0				\n"
>  			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
>  			: GCC_OFF12_ASM() (rw->lock)

 This integer overflow trap is deliberate here -- have you seen the note 
just above:

/* Note the use of sub, not subu which will make the kernel die with an
   overflow exception if we ever try to unlock an rwlock that is already
   unlocked or is being held by a writer.  */

?

 What this shows really is a GAS bug fix for the SUB macro is needed 
similar to what I suggested in 12/70 for ADDI (from the situation I infer 
there is some real work to do in GAS in this area; adding Matthew as a 
recipient to raise his awareness) so that it does not expand to ADDI where 
the architecture or processor selected do not support it.  Instead a 
longer sequence involving SUB has to be produced.

 However, regardless, I suggest code like:

/* There's no R6 ADDI instruction so use the ADD register version instead. */
#ifdef CONFIG_CPU_MIPSR6
#define GCC_ADDI_ASM() "r"
#else
#define GCC_ADDI_ASM() "I"
#endif

			__asm__ __volatile__(
			"1:	ll	%1, %2	# arch_read_unlock	\n"
			"	sub	%1, %3				\n"
			"	sc	%1, %0				\n"
			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
			: GCC_OFF12_ASM() (rw->lock), GCC_ADDI_ASM() (1)
			: "memory");

(untested, but should work) so that there's still a single instruction 
only in the LL/SC loop and consequently no increased lock contention risk.

 As a side note, this could be cleaned up to use a "+" input/output 
constraint; such a clean-up will be welcome -- although to be complete, a 
review of all the asms will be required (this may bump up the GCC version 
requirement though, ISTR bugs in this area).

  Maciej
