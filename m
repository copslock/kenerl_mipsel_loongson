Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 02:50:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17844 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2EAAuD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 02:50:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f9f33a50000>; Mon, 30 Apr 2012 17:51:49 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 17:49:59 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 30 Apr 2012 17:49:59 -0700
Message-ID: <4F9F3337.6040604@cavium.com>
Date:   Mon, 30 Apr 2012 17:49:59 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 04/10] MIPS: Add micro-assembler support for 'ins' and
 'ext' instructions.
References: <1333817315-30091-1-git-send-email-sjhill@mips.com> <1333817315-30091-5-git-send-email-sjhill@mips.com>
In-Reply-To: <1333817315-30091-5-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2012 00:49:59.0419 (UTC) FILETIME=[55C244B0:01CD2734]
X-archive-position: 33105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/07/2012 09:48 AM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> Add the MIPS32R2 'ins' and 'ext' instructions for use by the
> kernel's micro-assembler.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/include/asm/uasm.h |   15 +++++++++++++++
>   arch/mips/mm/tlbex.c         |   17 +++++++++++++++++

I would split the tlbex.c changes into a separate patch.  The changelog 
doesn't even mention the changes you are making to this file.

>   arch/mips/mm/uasm.c          |   15 +++++++++++++++
>   3 files changed, 47 insertions(+)
>
[...]
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -921,6 +921,13 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
>   #endif
>   	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
>   	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
> +#ifdef CONFIG_32BIT
> +	if (cpu_has_mips32r2) {
> +		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
> +		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
> +		return;
> +	}
> +#endif

Can we somehow get rid of the #ifdef?  You are already doing 
if(condition) around the same code.

>   	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
>   	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
>   	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
> @@ -956,6 +963,16 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
>
>   static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
>   {
> +#ifdef CONFIG_32BIT
> +	if (cpu_has_mips32r2) {
> +		/* For MIPS32R2, PTE ptr offset is obtained from BadVAddr */
> +		UASM_i_MFC0(p, tmp, C0_BADVADDR);
> +		UASM_i_LW(p, ptr, 0, ptr);
> +		UASM_i_EXT(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> +		UASM_i_INS(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> +		return;
> +	}
> +#endif

Same here.

>   	/*
>   	 * Bug workaround for the Nevada. It seems as if under certain
>   	 * circumstances the move from cp0_context might produce a
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 5fa1851..fb6d8e27 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -63,6 +63,7 @@ enum opcode {
>   	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
>   	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
>   	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
> +	insn_ins, insn_ext,
>   	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
>   	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
>   	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
> @@ -113,6 +114,8 @@ static struct insn insn_table[] __uasminitdata = {
>   	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
>   	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
>   	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
> +	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
> +	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
>   	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
>   	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
>   	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
> @@ -287,6 +290,16 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
>   	(*buf)++;
>   }
>
> +#define I_bit_extract(op)				\
> +Ip_bit_extract(op)					\

The names don't match the pattern, look at the dins for example.

> +{							\
> +	build_insn(buf, insn##op, b, a, d-1, c);	\
> +}
> +#define I_bit_insert(op)				\
> +Ip_bit_insert(op)					\
> +{							\
> +	build_insn(buf, insn##op, b, a, c+d-1, c);	\
> +}
>   #define I_u1u2u3(op)					\
>   Ip_u1u2u3(op)						\
>   {							\
> @@ -396,6 +409,8 @@ I_u2u1u3(_drotr)
>   I_u2u1u3(_drotr32)
>   I_u3u1u2(_dsubu)
>   I_0(_eret)
> +I_bit_insert(_ins)
> +I_bit_extract(_ext)
>   I_u1(_j)
>   I_u1(_jal)
>   I_u1(_jr)
