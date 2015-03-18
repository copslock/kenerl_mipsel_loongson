Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 23:22:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37985 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008130AbbCRWWKv0fzH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 23:22:10 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 294FC41F8E19;
        Wed, 18 Mar 2015 22:22:06 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 18 Mar 2015 22:22:06 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 18 Mar 2015 22:22:06 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CF10CE887DE02;
        Wed, 18 Mar 2015 22:22:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 18 Mar 2015 22:22:05 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 18 Mar
 2015 22:22:05 +0000
Date:   Wed, 18 Mar 2015 22:22:05 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <wangr@lemote.com>,
        <peterz@infradead.org>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <chenhc@lemote.com>, <manuel.lauss@gmail.com>, <mingo@kernel.org>
Subject: Re: [PATCH v2] MIPS: MSA: misaligned support
Message-ID: <20150318222204.GA22574@jhogan-linux.le.imgtec.org>
References: <20150318192331.14806.63145.stgit@ubuntu-yegoshin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20150318192331.14806.63145.stgit@ubuntu-yegoshin>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On Wed, Mar 18, 2015 at 12:23:32PM -0700, Leonid Yegoshin wrote:
> MIPS R5, MIPS R6 and MSA HW specs allow a broad range of address exception
> on unaligned MSA load/store operations - from none unaligned up to
> full support in HW. In practice, it is expected that HW can occasionally
> triggers AdE for non-aligned data access (misalignment). It is usually
> expected on page boundaries because HW handling of two TLBs in single
> data access operation may be complicated and expensive.
>=20
> So, this patch handles MSA LD.df and ST.df Address Error exceptions.
>=20
> It handles separately two cases - MSA owned by thread and MSA registers
> saved in current->thread.fpu. If thread still owns MSA unit then it
> loads and stores directly with MSA unit and only one MSA register. Saving
> and restoring the full MSA context (512bytes) on each misalign exception
> is expensive! Preemption is disabled, of course.
>=20
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
> V2:
>     - added a missed assignment in double-word case of BIG ENDIAN convers=
ion
>     - added a missed initial allignment in block of assembler mini-functi=
ons
>       to get/put MSA register.
>     - added a missed preempt_disable() in ST.D unalignment processing

I think you forgot to either answer or address some of my smaller
comments.

Cheers
James

> ---
>  arch/mips/include/asm/processor.h |    2 +
>  arch/mips/include/uapi/asm/inst.h |   21 +++++
>  arch/mips/kernel/r4k_fpu.S        |  109 ++++++++++++++++++++++++++++
>  arch/mips/kernel/unaligned.c      |  146 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 278 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/pr=
ocessor.h
> index f1df4cb4a286..af2675060244 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -104,6 +104,8 @@ extern unsigned int vced_count, vcei_count;
>  #endif
> =20
>  union fpureg {
> +	__u8    val8[FPU_REG_WIDTH / 8];
> +	__u16   val16[FPU_REG_WIDTH / 16];
>  	__u32	val32[FPU_REG_WIDTH / 32];
>  	__u64	val64[FPU_REG_WIDTH / 64];
>  };
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/a=
sm/inst.h
> index 89c22433b1c6..7ab6987cb7d5 100644
> --- a/arch/mips/include/uapi/asm/inst.h
> +++ b/arch/mips/include/uapi/asm/inst.h
> @@ -58,6 +58,7 @@ enum spec_op {
>  	dsll_op, spec7_unused_op, dsrl_op, dsra_op,
>  	dsll32_op, spec8_unused_op, dsrl32_op, dsra32_op
>  };
> +#define msa_op  mdmx_op
> =20
>  /*
>   * func field of spec2 opcode.
> @@ -217,6 +218,14 @@ enum bshfl_func {
>  };
> =20
>  /*
> + * func field for MSA MI10 format
> + */
> +enum msa_mi10_func {
> +	msa_ld_op =3D 8,
> +	msa_st_op =3D 9,
> +};
> +
> +/*
>   * (microMIPS) Major opcodes.
>   */
>  enum mm_major_op {
> @@ -616,6 +625,17 @@ struct spec3_format {   /* SPEC3 */
>  	;)))))
>  };
> =20
> +struct msa_mi10_format {        /* MSA */
> +	__BITFIELD_FIELD(unsigned int opcode : 6,
> +	__BITFIELD_FIELD(signed int s10 : 10,
> +	__BITFIELD_FIELD(unsigned int rs : 5,
> +	__BITFIELD_FIELD(unsigned int wd : 5,
> +	__BITFIELD_FIELD(unsigned int func : 4,
> +	__BITFIELD_FIELD(unsigned int df : 2,
> +	;))))))
> +};
> +
> +
>  /*
>   * microMIPS instruction formats (32-bit length)
>   *
> @@ -884,6 +904,7 @@ union mips_instruction {
>  	struct p_format p_format;
>  	struct f_format f_format;
>  	struct ma_format ma_format;
> +	struct msa_mi10_format msa_mi10_format;
>  	struct b_format b_format;
>  	struct ps_format ps_format;
>  	struct v_format v_format;
> diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
> index 6c160c67984c..a2f9a0420f54 100644
> --- a/arch/mips/kernel/r4k_fpu.S
> +++ b/arch/mips/kernel/r4k_fpu.S
> @@ -13,6 +13,7 @@
>   * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
>   */
>  #include <asm/asm.h>
> +#include <asm/asmmacro.h>
>  #include <asm/errno.h>
>  #include <asm/fpregdef.h>
>  #include <asm/mipsregs.h>
> @@ -268,6 +269,114 @@ LEAF(_restore_fp_context32)
>  	END(_restore_fp_context32)
>  #endif
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +
> +	.macro  msa_ld_d    wd, base
> +	ld_d    \wd, 0, \base
> +	jalr    $0, $31
> +	  nop
> +	.align  4
> +	.endm
> +
> +	.macro  msa_st_d    wd, base
> +	st_d    \wd, 0, \base
> +	jalr    $0, $31
> +	  nop
> +	.align  4
> +	.endm
> +
> +LEAF(msa_to_wd)
> +	.set    push
> +	.set    noreorder
> +	sll         t0, a0, 4
> +	PTR_LA      t1, Lmsa_to
> +	PTR_ADDU    t0, t0, t1
> +	jalr        $0, t0
> +	  nop
> +	.align  4
> +Lmsa_to:
> +	msa_ld_d    0, a1
> +	msa_ld_d    1, a1
> +	msa_ld_d    2, a1
> +	msa_ld_d    3, a1
> +	msa_ld_d    4, a1
> +	msa_ld_d    5, a1
> +	msa_ld_d    6, a1
> +	msa_ld_d    7, a1
> +	msa_ld_d    8, a1
> +	msa_ld_d    9, a1
> +	msa_ld_d    10, a1
> +	msa_ld_d    11, a1
> +	msa_ld_d    12, a1
> +	msa_ld_d    13, a1
> +	msa_ld_d    14, a1
> +	msa_ld_d    15, a1
> +	msa_ld_d    16, a1
> +	msa_ld_d    17, a1
> +	msa_ld_d    18, a1
> +	msa_ld_d    19, a1
> +	msa_ld_d    20, a1
> +	msa_ld_d    21, a1
> +	msa_ld_d    22, a1
> +	msa_ld_d    23, a1
> +	msa_ld_d    24, a1
> +	msa_ld_d    25, a1
> +	msa_ld_d    26, a1
> +	msa_ld_d    27, a1
> +	msa_ld_d    28, a1
> +	msa_ld_d    29, a1
> +	msa_ld_d    30, a1
> +	msa_ld_d    31, a1
> +	.set    pop
> +	END(msa_to_wd)
> +
> +LEAF(msa_from_wd)
> +	.set    push
> +	.set    noreorder
> +	sll         t0, a0, 4
> +	PTR_LA      t1, Lmsa_from
> +	PTR_ADDU    t0, t0, t1
> +	jalr        $0, t0
> +	  nop
> +	.align  4
> +Lmsa_from:
> +	msa_st_d    0, a1
> +	msa_st_d    1, a1
> +	msa_st_d    2, a1
> +	msa_st_d    3, a1
> +	msa_st_d    4, a1
> +	msa_st_d    5, a1
> +	msa_st_d    6, a1
> +	msa_st_d    7, a1
> +	msa_st_d    8, a1
> +	msa_st_d    9, a1
> +	msa_st_d    10, a1
> +	msa_st_d    11, a1
> +	msa_st_d    12, a1
> +	msa_st_d    13, a1
> +	msa_st_d    14, a1
> +	msa_st_d    15, a1
> +	msa_st_d    16, a1
> +	msa_st_d    17, a1
> +	msa_st_d    18, a1
> +	msa_st_d    19, a1
> +	msa_st_d    20, a1
> +	msa_st_d    21, a1
> +	msa_st_d    22, a1
> +	msa_st_d    23, a1
> +	msa_st_d    24, a1
> +	msa_st_d    25, a1
> +	msa_st_d    26, a1
> +	msa_st_d    27, a1
> +	msa_st_d    28, a1
> +	msa_st_d    29, a1
> +	msa_st_d    30, a1
> +	msa_st_d    31, a1
> +	.set    pop
> +	END(msa_from_wd)
> +
> +#endif /* CONFIG_CPU_HAS_MSA */
> +
>  	.set	reorder
> =20
>  	.type	fault@function
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index e11906dff885..bf6a0c63d3de 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -108,6 +108,11 @@ static u32 unaligned_action;
>  #endif
>  extern void show_registers(struct pt_regs *regs);
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +void msa_to_wd(unsigned int wd, union fpureg *from);
> +void msa_from_wd(unsigned int wd, union fpureg *to);
> +#endif
> +
>  #ifdef __BIG_ENDIAN
>  #define     LoadHW(addr, value, res)  \
>  		__asm__ __volatile__ (".set\tnoat\n"        \
> @@ -422,6 +427,66 @@ extern void show_registers(struct pt_regs *regs);
>  		: "r" (value), "r" (addr), "i" (-EFAULT));
>  #endif
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +#ifdef __BIG_ENDIAN
> +/*
> + * MSA data format conversion.
> + * Only for BIG ENDIAN - LITTLE ENDIAN has register format which matches=
 memory
> + * layout contiguously.
> + *
> + * Conversion is done between two Double words and other formats (W/H/B)
> + * because kernel uses LD.D and ST.D to load/store MSA registers and kee=
ps
> + * MSA registers in this format in current->thread.fpu.fpr
> + */
> +static void msa_convert(union fpureg *to, union fpureg *from, int fmt)
> +{
> +	switch (fmt) {
> +	case 0: /* byte */
> +		to->val8[0] =3D from->val8[7];
> +		to->val8[1] =3D from->val8[6];
> +		to->val8[2] =3D from->val8[5];
> +		to->val8[3] =3D from->val8[4];
> +		to->val8[4] =3D from->val8[3];
> +		to->val8[5] =3D from->val8[2];
> +		to->val8[6] =3D from->val8[1];
> +		to->val8[7] =3D from->val8[0];
> +		to->val8[8] =3D from->val8[15];
> +		to->val8[9] =3D from->val8[14];
> +		to->val8[10] =3D from->val8[13];
> +		to->val8[11] =3D from->val8[12];
> +		to->val8[12] =3D from->val8[11];
> +		to->val8[13] =3D from->val8[10];
> +		to->val8[14] =3D from->val8[9];
> +		to->val8[15] =3D from->val8[8];
> +		break;
> +
> +	case 1: /* halfword */
> +		to->val16[0] =3D from->val16[3];
> +		to->val16[1] =3D from->val16[2];
> +		to->val16[2] =3D from->val16[1];
> +		to->val16[3] =3D from->val16[0];
> +		to->val16[4] =3D from->val16[7];
> +		to->val16[5] =3D from->val16[6];
> +		to->val16[6] =3D from->val16[5];
> +		to->val16[7] =3D from->val16[4];
> +		break;
> +
> +	case 2: /* word */
> +		to->val32[0] =3D from->val32[1];
> +		to->val32[1] =3D from->val32[0];
> +		to->val32[2] =3D from->val32[3];
> +		to->val32[3] =3D from->val32[2];
> +		break;
> +
> +	case 3: /* doubleword, no conversion */
> +		to->val64[0] =3D from->val64[0];
> +		to->val64[1] =3D from->val64[1];
> +		break;
> +	}
> +}
> +#endif
> +#endif
> +
>  static void emulate_load_store_insn(struct pt_regs *regs,
>  	void __user *addr, unsigned int __user *pc)
>  {
> @@ -434,6 +499,10 @@ static void emulate_load_store_insn(struct pt_regs *=
regs,
>  #ifdef	CONFIG_EVA
>  	mm_segment_t seg;
>  #endif
> +#ifdef CONFIG_CPU_HAS_MSA
> +	union fpureg msadatabase[2], *msadata;
> +	unsigned int func, df, rs, wd;
> +#endif
>  	origpc =3D (unsigned long)pc;
>  	orig31 =3D regs->regs[31];
> =20
> @@ -703,6 +772,83 @@ static void emulate_load_store_insn(struct pt_regs *=
regs,
>  			break;
>  		return;
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +	case msa_op:
> +		if (cpu_has_mdmx)
> +			goto sigill;
> +
> +		func =3D insn.msa_mi10_format.func;
> +		switch (func) {
> +		default:
> +			goto sigbus;
> +
> +		case msa_ld_op:
> +		case msa_st_op:
> +			;
> +		}
> +
> +		if (!thread_msa_context_live())
> +			goto sigbus;
> +
> +		df =3D insn.msa_mi10_format.df;
> +		rs =3D insn.msa_mi10_format.rs;
> +		wd =3D insn.msa_mi10_format.wd;
> +		addr =3D (unsigned long *)(regs->regs[rs] + (insn.msa_mi10_format.s10 =
<< df));
> +		/* align a working space in stack... */
> +		msadata =3D (union fpureg *)(((unsigned long)msadatabase + 15) & ~(uns=
igned long)0xf);
> +		if (func =3D=3D msa_ld_op) {
> +			if (!access_ok(VERIFY_READ, addr, 16))
> +				goto sigbus;
> +			compute_return_epc(regs);
> +			res =3D __copy_from_user_inatomic(msadata, addr, 16);
> +			if (res)
> +				goto fault;
> +			preempt_disable();
> +			if (test_thread_flag(TIF_USEDMSA)) {
> +#ifdef __BIG_ENDIAN
> +				msa_convert(&current->thread.fpu.fpr[wd], msadata, df);
> +				msa_to_wd(wd, &current->thread.fpu.fpr[wd]);
> +#else
> +				msa_to_wd(wd, msadata);
> +#endif
> +				preempt_enable();
> +			} else {
> +				preempt_enable();
> +#ifdef __BIG_ENDIAN
> +				msa_convert(&current->thread.fpu.fpr[wd], msadata, df);
> +#else
> +				current->thread.fpu.fpr[wd] =3D *msadata;
> +#endif
> +			}
> +		} else {
> +			if (!access_ok(VERIFY_WRITE, addr, 16))
> +				goto sigbus;
> +			compute_return_epc(regs);
> +			preempt_disable();
> +			if (test_thread_flag(TIF_USEDMSA)) {
> +#ifdef __BIG_ENDIAN
> +				msa_from_wd(wd, &current->thread.fpu.fpr[wd]);
> +				msa_convert(msadata, &current->thread.fpu.fpr[wd], df);
> +#else
> +				msa_from_wd(wd, msadata);
> +#endif
> +				preempt_enable();
> +			} else {
> +				preempt_enable();
> +#ifdef __BIG_ENDIAN
> +				msa_convert(msadata, &current->thread.fpu.fpr[wd], df);
> +#else
> +				*msadata =3D current->thread.fpu.fpr[wd];
> +#endif
> +			}
> +			res =3D __copy_to_user_inatomic(addr, msadata, 16);
> +			if (res)
> +				goto fault;
> +		}
> +
> +		break;
> +#endif /* CONFIG_CPU_HAS_MSA */
> +
>  	/*
>  	 * COP2 is available to implementor for application specific use.
>  	 * It's up to applications to register a notifier chain and do
>=20
>=20

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVCfqMAAoJEGwLaZPeOHZ6pu4P/i+ZpKNeVwTRh3qXNJNrqT0I
/lBek7KO//S9VoUsJgWoFzYmeVf5GY/MkxiBW5ovHxwz2w0vhqNElmvgvVcut3h9
mSnfdeETLzYdknjScPrY8cnlgtWEWnwdP5xgXJ5CLeBgpvsziEU4g01DMTLLDJde
We5rIAAfncrlbkW05FeqWondIwsztgHPk2/8vZa0TYCG2oR6vWafznJDEo+rIm2n
5+NBj4KZZi7NpVpDFp0kH2nnzUQhdLufAVaf+lZU7rTaY2eAdq7EMATsTwRshA2u
Bqx/py+7FUxUL6Xr18C0OXx4T7pvLiw5axfOyHg9NFaeuNV7nOqazn4FvA4GG8Om
rl7H1XwtBkgqySwONGi9fE1a1aebIAMPYJ6yEbK+kgl9tNxKgZk2XwtYdOX2WdAc
MAhjHR/FssJjbz7SWzDLJqHb2/KhG1XpZUt4RFjC2S7XXp5sxDR4xiZ0RMAaPEgY
UQyW8s0df4HF2b5Ja2ztIQXK+5xZhPjb0byHFNlVcg8XlfiXBtnDsan2i6lYraRq
iTL6tz/uJca5kcqwfivRvkH/oukL3O4fYTitwcxt6saiAXOnhd0eAWdxWAJ6VSCO
I3HwdKB/oU18svIwrAWFZdz3A2+BPW2OC+5l9a5LIqkYu0qHqg9ZX6hvK4FpPRY9
NEk+S/N/2G3QPumSGeD9
=6IEK
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
