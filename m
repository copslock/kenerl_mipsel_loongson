Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 20:15:40 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47644 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010785AbbAPTPiDRLnt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 20:15:38 +0100
Received: by mail-ie0-f174.google.com with SMTP id at20so22405005iec.5
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eJTpu129kyPmbc2RMfXkp5AD0ogb/1Z1aJ2Pq+NNKo4=;
        b=RSyv4WS+RI+//i/9GQdEO185RSKv4qqFKeuZWLjWV0/qfUGZZDh6IXUSdQKs2EGcCd
         6P8kbBSOnvpndEMlST6q4S9aXApbcDc0smvVFEgePN3YpfSzJbhlUsWgn10ysQdktSrK
         uTLHJx9eLtZnN6U8Fnx54LIXT68Yn0aAZQpXKRqw7LzcFoRAKgWWXC/aSPlRZwXl0frM
         653MH/TM+FFBATegsSotlvbusFp1kljphz4hMuxXug0dkx8MswBhheDcJzPtebfKnKf9
         3eW1LTzdrudA7Kl1I1urwGTSzQQQW1IsKQ9jK806bjEpK2F3pucToH3va3jNEsKIwkf9
         H43g==
X-Received: by 10.107.131.133 with SMTP id n5mr18177519ioi.30.1421435732017;
        Fri, 16 Jan 2015 11:15:32 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id f9sm3237644iod.24.2015.01.16.11.15.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Jan 2015 11:15:31 -0800 (PST)
Message-ID: <54B96352.1040801@gmail.com>
Date:   Fri, 16 Jan 2015 11:15:30 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 06/70] MIPS: mm: Add MIPS R6 instruction encodings
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-7-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-7-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45235
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

On 01/16/2015 02:48 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> MIPS R6 defines new opcodes for ll, sc, cache and pref instructions
> so we need to take these into consideration in the micro-assembler.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/include/uapi/asm/inst.h |  9 ++++++---

We should probably split changes to uapi/asm/inst.h in to a separate 
patch from the patches to the kernel proper.

The fact that it changes (extends) a userspace ABI, makes it a candidate 
for being a standalone patch.

David Daney

>   arch/mips/mm/uasm-mips.c          | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
> index 89c22433b1c6..5c9e14a903af 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -83,9 +83,12 @@ enum spec3_op {
>   	swe_op    = 0x1f, bshfl_op  = 0x20,
>   	swle_op   = 0x21, swre_op   = 0x22,
>   	prefe_op  = 0x23, dbshfl_op = 0x24,
> -	lbue_op   = 0x28, lhue_op   = 0x29,
> -	lbe_op    = 0x2c, lhe_op    = 0x2d,
> -	lle_op    = 0x2e, lwe_op    = 0x2f,
> +	cache6_op = 0x25, sc6_op    = 0x26,
> +	scd6_op   = 0x27, lbue_op   = 0x28,
> +	lhue_op   = 0x29, lbe_op    = 0x2c,
> +	lhe_op    = 0x2d, lle_op    = 0x2e,
> +	lwe_op    = 0x2f, pref6_op  = 0x35,
> +	ll6_op    = 0x36, lld6_op   = 0x37,
>   	rdhwr_op  = 0x3b
>   };
>
> diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
> index 8e02291cfc0c..7bb0d4ce2de8 100644
> --- a/arch/mips/mm/uasm-mips.c
> +++ b/arch/mips/mm/uasm-mips.c
> @@ -38,6 +38,14 @@
>   	 | (e) << RE_SH						\
>   	 | (f) << FUNC_SH)
>
> +/* This macro sets the non-variable bits of an R6 instruction. */
> +#define M6(a, b, c, d, e)					\
> +	((a) << OP_SH						\
> +	 | (b) << RS_SH						\
> +	 | (c) << RT_SH						\
> +	 | (d) << SIMM9_SH					\
> +	 | (e) << FUNC_SH)
> +
>   /* Define these when we are not the ISA the kernel is being compiled with. */
>   #ifdef CONFIG_CPU_MICROMIPS
>   #define CL_uasm_i_b(buf, off) ISAOPC(_beq)(buf, 0, 0, off)
> @@ -62,7 +70,11 @@ static struct insn insn_table[] = {
>   	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
>   	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
>   	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
> +#ifndef CONFIG_MIPS_R6
>   	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
> +#else
> +	{ insn_cache,  M6(cache_op, 0, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
> +#endif
>   	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
>   	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
>   	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
> @@ -85,13 +97,22 @@ static struct insn insn_table[] = {
>   	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
>   	{ insn_jalr,  M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD },
>   	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
> +#ifndef CONFIG_CPU_MIPSR6
>   	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
> +#else
> +	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jalr_op),  RS },
> +#endif
>   	{ insn_lb, M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
>   	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>   	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
>   	{ insn_lh,  M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
> +#ifndef CONFIG_CPU_MIPSR6
>   	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
>   	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
> +#else
> +	{ insn_lld,  M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9 },
> +	{ insn_ll,  M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9 },
> +#endif
>   	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
>   	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>   	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
> @@ -104,11 +125,20 @@ static struct insn insn_table[] = {
>   	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
>   	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
>   	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
> +#ifndef CONFIG_CPU_MIPSR6
>   	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
> +#else
> +	{ insn_pref,  M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9 },
> +#endif
>   	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
>   	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
> +#ifndef CONFIG_CPU_MIPSR6
>   	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
>   	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
> +#else
> +	{ insn_scd,  M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9 },
> +	{ insn_sc,  M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9 },
> +#endif
>   	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
>   	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
>   	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
> @@ -198,6 +228,8 @@ static void build_insn(u32 **buf, enum opcode opc, ...)
>   		op |= build_set(va_arg(ap, u32));
>   	if (ip->fields & SCIMM)
>   		op |= build_scimm(va_arg(ap, u32));
> +	if (ip->fields & SIMM9)
> +		op |= build_scimm9(va_arg(ap, u32));
>   	va_end(ap);
>
>   	**buf = op;
>
