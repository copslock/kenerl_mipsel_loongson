Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:12:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42208 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831986AbaGWOMsQWPyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:12:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1E02BC927777A;
        Wed, 23 Jul 2014 15:12:38 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 23 Jul 2014 15:12:40 +0100
Received: from localhost (192.168.79.47) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 23 Jul
 2014 15:12:10 +0100
Date:   Wed, 23 Jul 2014 15:12:03 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Alex Smith <alex@alex-smith.me.uk>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 05/11] MIPS: ptrace: Always copy FCSR in FP regset
Message-ID: <20140723141203.GM30558@pburton-laptop>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
 <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.47]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Jul 23, 2014 at 02:40:10PM +0100, Alex Smith wrote:
> Copy FCSR in the FP regset to match the original pre-regset core dumper.
> The code paths for where sizeof(union fpureg) == sizeof(elf_fpreg_t)
> already do so, but they actually copy 4 bytes more than they should do
> as FCSR is only 32 bits. The not equal code paths do not copy it at all.
> Therefore change the copy to be done explicitly (with the correct size)
> for both paths.

Ah, I hadn't realised that ELF_NFPREG == 33, sneaky! That together with
the "XXX fcr31" comment led me to believe the FP regset didn't include
FCSR which is why I hadn't fixed the oops there or taken it into account
for the case where FPR size != sizeof(elf_fpreg_t) (ie. when MSA support
is enabled).

> Additionally, clear the cause bits from FCSR when setting the FP regset
> to avoid the possibility of causing an FP exception (and an oops) in the
> kernel.
> 
> Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: <stable@vger.kernel.org> # v3.13+
> ---
> This patch incorporates a fix for another instance of the bug fixed by
> Paul Burton's patch "MIPS: prevent user from setting FCSR cause bits" -
> the code path in fpr_set for sizeof(fpureg) == sizeof(elf_fpreg_t)
> copied fcr31 without clearing cause bits. I've incorporated a fix for
> it into this patch to so that it's easier to apply both patches without
> conflicts.
> ---
>  arch/mips/kernel/ptrace.c | 61 +++++++++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 8bd13ed..ffc2e37 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -409,23 +409,28 @@ static int fpr_get(struct task_struct *target,
>  	int err;
>  	u64 fpr_val;
>  
> -	/* XXX fcr31  */
> -
> -	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
> -		return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					   &target->thread.fpu,
> -					   0, sizeof(elf_fpregset_t));
> -
> -	for (i = 0; i < NUM_FPU_REGS; i++) {
> -		fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
> +	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
>  		err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> -					  &fpr_val, i * sizeof(elf_fpreg_t),
> -					  (i + 1) * sizeof(elf_fpreg_t));
> +					  &target->thread.fpu.fpr,
> +					  0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
>  		if (err)
>  			return err;
> +	} else {
> +		for (i = 0; i < NUM_FPU_REGS; i++) {
> +			fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
> +			err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +						  &fpr_val,
> +						  i * sizeof(elf_fpreg_t),
> +						  (i + 1) * sizeof(elf_fpreg_t));
> +			if (err)
> +				return err;
> +		}
>  	}
>  
> -	return 0;
> +	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +			    &target->thread.fpu.fcr31,
> +			    NUM_FPU_REGS * sizeof(elf_fpreg_t),
> +			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));

The only problem I can think of is that the final register in the regset
will still be treated as 64b (regset->size) as far as ptrace is
concerned, so I'm not sure how best to handle this. I presume the pre
regset core dump format placed the 32b FCSR value immediately after
the 64b $f31, as you have here? In which case we should probably at
least zero out the other 4 bytes of this final "register", assuming
the extra 4 bytes compared to the pre-regset version isn't a problem?

Thanks,
    Paul

>  }
>  
>  static int fpr_set(struct task_struct *target,
> @@ -436,23 +441,33 @@ static int fpr_set(struct task_struct *target,
>  	unsigned i;
>  	int err;
>  	u64 fpr_val;
> +	u32 fcr31;
>  
> -	/* XXX fcr31  */
> -
> -	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
> -		return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -					  &target->thread.fpu,
> -					  0, sizeof(elf_fpregset_t));
> -
> -	for (i = 0; i < NUM_FPU_REGS; i++) {
> +	if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
>  		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -					 &fpr_val, i * sizeof(elf_fpreg_t),
> -					 (i + 1) * sizeof(elf_fpreg_t));
> +					 &target->thread.fpu.fpr,
> +					 0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
>  		if (err)
>  			return err;
> -		set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> +	} else {
> +		for (i = 0; i < NUM_FPU_REGS; i++) {
> +			err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> +						 &fpr_val,
> +						 i * sizeof(elf_fpreg_t),
> +						 (i + 1) * sizeof(elf_fpreg_t));
> +			if (err)
> +				return err;
> +			set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
> +		}
>  	}
>  
> +	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fcr31,
> +			    NUM_FPU_REGS * sizeof(elf_fpreg_t),
> +			    (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
> +	if (err)
> +		return err;
> +
> +	target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
