Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 20:47:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007238AbbCRTrEQ1L02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 20:47:04 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 35A504D8CF361;
        Wed, 18 Mar 2015 19:46:55 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 18 Mar
 2015 19:46:58 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Wed, 18 Mar
 2015 19:46:58 +0000
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 18 Mar
 2015 12:46:51 -0700
Message-ID: <5509D62B.7030507@imgtec.com>
Date:   Wed, 18 Mar 2015 12:46:51 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <James.Hogan@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "wangr@lemote.com" <wangr@lemote.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] MIPS: MSA: misaligned support
References: <20150318011630.2702.28882.stgit@ubuntu-yegoshin> <5509611D.80404@imgtec.com>
In-Reply-To: <5509611D.80404@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 03/18/2015 04:27 AM, James Hogan wrote:
>
> +	.align  4
> doesn't this mean the first one & label might not be suitably aligned.
> Would it be better to put this before the ld_d (no need for it after
> $w31 case) and putting another .align 4 before the Lmsa_to and Lmsa_from
> labels (so the label itself is aligned)?

Good point! I will issue V2.

>
> +
> +	case 2: /* word */
> +		to->val32[0] = from->val32[1];
> +		to->val32[1] = from->val32[0];
> +		to->val32[2] = from->val32[3];
> +		to->val32[3] = from->val32[2];
> FWIW since the FP/MSA patches that Paul submitted, there are also
> working endian agnostic accessors created with BUILD_FPR_ACCESS, which
> use the FPR_IDX macro (see http://patchwork.linux-mips.org/patch/9169/),
> which should work for 8bit and 16bit sizes too.
>
> I wonder if the compiler would unroll/optimise this sort of thing:
> 	for (i = 0; i < (FPU_REG_WIDTH / 8); ++i)
> 		to_val8[i] = from->val[FPR_IDX(8, i)];
>
> No worries if not.

There is a simple logic behind it - any code rolling in macro/subroutine 
definitely
has sense if any of that is correct:

- code can't be observed by single look (more than half page or window)
- there is a chance to reuse some part of it
- some code vars/limits/bit/positions/etc can be changed in future
- some logical connection to macro/subroutine is desirable to take attn 
during code maintenance.

None of it besides last one is true here. Logical connection to union 
fpureg is done. Changing of MSA register size definitely causes a lot of 
other changes in logic and many assumptions may be broken in multiple 
places, including process signal conventions.

Rolling code in macro (FPR_IDX) and turning it into loop from pretty 
short assignment actually INCREASES a code complexity for future 
maintenance.


>
>> +		break;
>> +
>> +	case 3: /* doubleword, no conversion */
>> +		break;
> don't you still need to copy the value though?

Good point! Never test this subroutine yet, HW team still should produce 
BIG ENDIAN CPU+MSA variant.
I will issue V2.

>
>> +	}
>> +}
>> +#endif
>> +#endif
>> +
>>   static void emulate_load_store_insn(struct pt_regs *regs,
>>   	void __user *addr, unsigned int __user *pc)
>>   {
>> @@ -434,6 +497,10 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>>   #ifdef	CONFIG_EVA
>>   	mm_segment_t seg;
>>   #endif
>> +#ifdef CONFIG_CPU_HAS_MSA
>> +	union fpureg msadatabase[2], *msadata;
>> +	unsigned int func, df, rs, wd;
>> +#endif
>>   	origpc = (unsigned long)pc;
>>   	orig31 = regs->regs[31];
>>   
>> @@ -703,6 +770,82 @@ static void emulate_load_store_insn(struct pt_regs *regs,
>>   			break;
>>   		return;
>>   
>> +#ifdef CONFIG_CPU_HAS_MSA
>> +	case msa_op:
>> +		if (cpu_has_mdmx)
>> +			goto sigill;
>> +
>> +		func = insn.msa_mi10_format.func;
>> +		switch (func) {
>> +		default:
>> +			goto sigbus;
>> +
>> +		case msa_ld_op:
>> +		case msa_st_op:
>> +			;
>> +		}
>> +
>> +		if (!thread_msa_context_live())
>> +			goto sigbus;
> Will this ever happen? (I can't see AdE handler enabling interrupts).
>
> If the MSA context genuinely isn't live (i.e. it can be considered
> UNPREDICTABLE), then surely a load operation should still succeed?

thread_msa_context_live() == check of TIF_MSA_CTX_LIVE == existence of 
MSA context for thread.
It differs from MSA is owned by thread, it just says that thread has 
already initialized MSA.

Unfortunate choice of function name, I believe.

This is a guard against bad selection of exception priorities in HW... 
sometime it happens.

>
>> +
>> +		df = insn.msa_mi10_format.df;
>> +		rs = insn.msa_mi10_format.rs;
>> +		wd = insn.msa_mi10_format.wd;
>> +		addr = (unsigned long *)(regs->regs[rs] + (insn.msa_mi10_format.s10 * (1 << df)));
> "* (1 << df)"?
> why not just "<< df"?
>
>> +		/* align a working space in stack... */
>> +		msadata = (union fpureg *)(((unsigned long)msadatabase + 15) & ~(unsigned long)0xf);
> Maybe you could just use __aligned(16) on a single local union fpureg.

I am not sure that it works in stack. I don't trust toolchain here - 
they even are not able to align a frame in stack to 16bytes.

>
>> +			}
>> +		} else {
>> +			if (!access_ok(VERIFY_WRITE, addr, 16))
>> +				goto sigbus;
>> +			compute_return_epc(regs);
> forgot to preempt_disable()?

Yes.

>
>> +			if (test_thread_flag(TIF_USEDMSA)) {
>> +#ifdef __BIG_ENDIAN
>> +				msa_from_wd(wd, &current->thread.fpu.fpr[wd]);
>> +				msa_convert(msadata, &current->thread.fpu.fpr[wd], df);
>> +#else
>> +				msa_from_wd(wd, msadata);
>> +#endif
>> +				preempt_enable();
>> +			} else {
>> +				preempt_enable();
>> +#ifdef __BIG_ENDIAN
>> +				msa_convert(msadata, &current->thread.fpu.fpr[wd], df);
>> +#else
>> +				*msadata = current->thread.fpu.fpr[wd];
> hmm, you could cheat and change this to the following?:
> 				msadata = &current->thread.fpu.fpr[wd];
Yes. But has it sense? It is just 2 doublewords is replaced by single 
PTR assignment. However, if msadata is not changed it gives a compiler 
some room for optimization.

- Leonid.
