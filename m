Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 20:13:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4694 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903659Ab2EKSNN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 20:13:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fad57260000>; Fri, 11 May 2012 11:15:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 May 2012 11:13:11 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 11 May 2012 11:13:11 -0700
Message-ID: <4FAD56B7.2060004@cavium.com>
Date:   Fri, 11 May 2012 11:13:11 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2,04/10] MIPS: Add micro-assembler support for 'ins'
 and 'ext' instructions.
References: <1336709766-29082-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1336709766-29082-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 May 2012 18:13:11.0544 (UTC) FILETIME=[B9B41780:01CD2FA1]
X-archive-position: 33268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/10/2012 09:16 PM, Steven J. Hill wrote:
> From: "Steven J. Hill"<sjhill@mips.com>
>
> Add the MIPS32R2 'ins' and 'ext' instructions for use by the
> kernel's micro-assembler.
>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/include/asm/uasm.h |    2 ++
>   arch/mips/mm/tlbex.c         |   17 +++++++++++++++++

Really I think the tlbex.c patch should be broken out into a separate 
patch.  It has nothing to do with adding instructions to uasm.


>   arch/mips/mm/uasm.c          |   13 +++++++++++++
>   3 files changed, 32 insertions(+)
>
> diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
> index 504d40a..814bc9f 100644
> --- a/arch/mips/include/asm/uasm.h
> +++ b/arch/mips/include/asm/uasm.h
> @@ -114,6 +114,8 @@ Ip_0(_tlbwi);
>   Ip_0(_tlbwr);
>   Ip_u3u1u2(_xor);
>   Ip_u2u1u3(_xori);
> +Ip_u2u1msbu3(_ext);
> +Ip_u2u1msbu3(_ins);
>   Ip_u2u1msbu3(_dins);
>   Ip_u2u1msbu3(_dinsm);
>   Ip_u1(_syscall);
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 897b727..7b12f27 100644
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
> +		uasm_i_ext(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> +		uasm_i_ins(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> +		return;
> +	}
> +#endif
>   	/*
>   	 * Bug workaround for the Nevada. It seems as if under certain
>   	 * circumstances the move from cp0_context might produce a
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 5fa1851..d3d0218 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -10,6 +10,7 @@
>    * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
>    * Copyright (C) 2005, 2007  Maciej W. Rozycki
>    * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
> + * Copyright (C) 2011, 2012  MIPS Technologies, Inc.
>    */
>
>   #include<linux/kernel.h>
> @@ -63,6 +64,7 @@ enum opcode {
>   	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
>   	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
>   	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
> +	insn_ins, insn_ext,

Should we re-flow this block?  I think so.  But that could be done at 
the time of re-alphabetization too.

[...]

David Daney
