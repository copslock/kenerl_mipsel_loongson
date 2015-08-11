Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 16:41:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39676 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011906AbbHKOlImUg8g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 16:41:08 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3B9E1661E6669;
        Tue, 11 Aug 2015 15:41:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 11 Aug 2015 15:41:02 +0100
Received: from localhost (192.168.154.168) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 11 Aug
 2015 15:41:01 +0100
Date:   Tue, 11 Aug 2015 15:41:01 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <Steven.Hill@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: R6: emulation of PC-relative instructions
Message-ID: <20150811144101.GA25145@mchandras-linux.le.imgtec.org>
References: <20150805235343.21126.29589.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150805235343.21126.29589.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

On Wed, Aug 05, 2015 at 04:53:43PM -0700, Leonid Yegoshin wrote:
> MIPS R6 has 6 new PC-relative instructions: LWUPC, LWPC, LDPC, ADDIUPC, ALUIPC
> and AUIPC. These instructions can be placed in BD-slot of BC1* branch
> instruction and FPU may be not available, which requires emulation of these
> instructions.
> 
> However, the traditional way to emulate that is via filling some emulation block
> in stack or special area and jump to it. This is not suitable for PC-relative
> instructions.
> 
> So, this patch introduces a universal emulation of that instructions directly by
> kernel emulator.
> 
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/include/uapi/asm/inst.h     |   42 ++++++++++++++-
>  arch/mips/kernel/mips-r2-to-r6-emul.c |    3 +
>  arch/mips/math-emu/dsemul.c           |   94 +++++++++++++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index 3dce80e67948..6253197d4908 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -33,7 +33,7 @@ enum major_op {
>  	sdl_op, sdr_op, swr_op, cache_op,
>  	ll_op, lwc1_op, lwc2_op, bc6_op = lwc2_op, pref_op,
>  	lld_op, ldc1_op, ldc2_op, beqzcjic_op = ldc2_op, ld_op,
> -	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, major_3b_op,
> +	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, pcrel_op,
>  	scd_op, sdc1_op, sdc2_op, bnezcjialc_op = sdc2_op, sd_op
>  };
>  
>  			if (nir) {
>  				err = mipsr6_emul(regs, nir);
>  				if (err > 0) {
> +					regs->cp0_epc = nepc;

Does this change belog to this patch? If so why? Maybe a comment would help?
It does feel like it fixes a different problem but I haven't read your patch in depth.

>  					err = mips_dsemul(regs, nir, cpc, epc, r31);
>  					if (err == SIGILL)
>  						err = SIGEMT;
> @@ -1082,6 +1083,7 @@ repeat:
>  			if (nir) {
>  				err = mipsr6_emul(regs, nir);
>  				if (err > 0) {
> +					regs->cp0_epc = nepc;
likewise

>  					err = mips_dsemul(regs, nir, cpc, epc, r31);
>  					if (err == SIGILL)
>  						err = SIGEMT;
> @@ -1149,6 +1151,7 @@ repeat:
>  		if (nir) {
>  			err = mipsr6_emul(regs, nir);
>  			if (err > 0) {
> +				regs->cp0_epc = nepc;
likewise

>  				err = mips_dsemul(regs, nir, cpc, epc, r31);
>  				if (err == SIGILL)
>  					err = SIGEMT;
> diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
> index eac76a09d822..9b388aaf594f 100644
> --- a/arch/mips/math-emu/dsemul.c
> +++ b/arch/mips/math-emu/dsemul.c
> @@ -8,6 +8,95 @@
>  
>  #include "ieee754.h"
>  
> +#ifdef CONFIG_CPU_MIPSR6

Can we simply avoid the if/def for R6 please? Just leave this function as is and
use if(cpu_has_mips_r6) when calling it. If you can't do that, please explain
why.

> +
> +static int mipsr6_pc(struct pt_regs *regs, mips_instruction inst, unsigned long cpc,
> +		    unsigned long bpc, unsigned long r31)
> +{
> +	union mips_instruction ir = (union mips_instruction)inst;
> +	register unsigned long vaddr;
> +	unsigned int val;
> +	int err = SIGILL;
> +
> +	if (ir.rel_format.opcode != pcrel_op)
> +		return SIGILL;
> +
> +	switch (ir.rel_format.op) {
> +	case addiupc_op:
> +		vaddr = regs->cp0_epc + (ir.rel_format.simmediate << 2);
> +		if (config_enabled(CONFIG_64BIT) && !(regs->cp0_status & ST0_UX))
> +			__asm__ __volatile__("sll %0, %0, 0":"+&r"(vaddr)::);
> +		regs->regs[ir.rel_format.rs] = vaddr;
> +		return 0;
> +#ifdef CONFIG_CPU_MIPS64

Could you use cpu_has_mips64 and avoid the if/def and return SIGILL if it is not
true?

Same thing for the rest of this patch.

-- 
markos
