Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 02:26:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47506 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2EAA0c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 02:26:32 +0200
Date:   Tue, 1 May 2012 01:26:32 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 04/10] MIPS: Add micro-assembler support for 'ins' and
 'ext' instructions.
In-Reply-To: <1333817315-30091-5-git-send-email-sjhill@mips.com>
Message-ID: <alpine.LFD.2.00.1204300459120.19691@eddie.linux-mips.org>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com> <1333817315-30091-5-git-send-email-sjhill@mips.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, 7 Apr 2012, Steven J. Hill wrote:

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 5fa1851..fb6d8e27 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -63,6 +63,7 @@ enum opcode {
>  	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
>  	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
>  	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
> +	insn_ins, insn_ext,
>  	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
>  	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
>  	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
> @@ -113,6 +114,8 @@ static struct insn insn_table[] __uasminitdata = {
>  	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
>  	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
>  	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
> +	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
> +	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
>  	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
>  	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
>  	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },

 Not an extensive review -- just noticed this issue while browsing...

 These two data definitions are clearly alphabetically ordered, so please 
keep them as such.  It seems rather a trivial update in this case -- just 
swap the new entries.  Thanks.

  Maciej
