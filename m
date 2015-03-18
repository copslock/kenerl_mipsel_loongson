Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 12:27:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18897 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007238AbbCRL1bvXNPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 12:27:31 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B84A641F8E05;
        Wed, 18 Mar 2015 11:27:26 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 18 Mar 2015 11:27:26 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 18 Mar 2015 11:27:26 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4923B29A46E70;
        Wed, 18 Mar 2015 11:27:24 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 18 Mar 2015 11:27:26 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 18 Mar
 2015 11:27:25 +0000
Message-ID: <5509611D.80404@imgtec.com>
Date:   Wed, 18 Mar 2015 11:27:25 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <wangr@lemote.com>,
        <peterz@infradead.org>, <qais.yousef@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <ralf@linux-mips.org>,
        <davidlohr@hp.com>, <chenhc@lemote.com>, <manuel.lauss@gmail.com>,
        <mingo@kernel.org>
Subject: Re: [PATCH] MIPS: MSA: misaligned support
References: <20150318011630.2702.28882.stgit@ubuntu-yegoshin>
In-Reply-To: <20150318011630.2702.28882.stgit@ubuntu-yegoshin>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="N9MUPvAdMBqGwn8JdSxRxMc7ChkvoMnSa"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46439
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

--N9MUPvAdMBqGwn8JdSxRxMc7ChkvoMnSa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On 18/03/15 01:16, Leonid Yegoshin wrote:
> MIPS R5, MIPS R6 and MSA HW specs allow a broad range of address except=
ion
> on unalaigned MSA load/store operations - from none unaligned up to

unaligned

> full support in HW. In practice, it is expected that HW can occasionall=
y
> triggers AdE for non-aligned data access (misalignment). It is usually
> expected on page boundaries because HW handling of two TLBs in single
> data access operation may be complicated and expensive.
>=20
> So, this patch handles MSA LD.df and ST.df Address Error exceptions.
>=20
> It handles separately two cases - MSA owned by thread and MSA registers=

> saved in current->thread.fpu. If thread still ownes MSA unit then it

owns

> loads and stores directly with MSA unit and only one MSA register. Savi=
ng
> and restoring the full MSA context (512bytes) on each misalign exceptio=
n
> is expensive! Preemption is disabled, of course.
>=20
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/include/asm/processor.h |    2 +
>  arch/mips/include/uapi/asm/inst.h |   21 +++++
>  arch/mips/kernel/r4k_fpu.S        |  107 ++++++++++++++++++++++++++++
>  arch/mips/kernel/unaligned.c      |  143 +++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 273 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/=
processor.h
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
> diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi=
/asm/inst.h
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

Most other opcode enumerations in this file are specified in hexadecimal.=


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
> index 6c160c67984c..5f48f45f81e7 100644
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
> @@ -268,6 +269,112 @@ LEAF(_restore_fp_context32)
>  	END(_restore_fp_context32)
>  #endif
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +
> +	.macro  msa_ld_d    wd, base
> +	ld_d    \wd, 0, \base
> +	jalr    $0, $31

Why not just:
	jr	ra

like every other function in that file? I hope jr would be encoded
correctly on r6 automatically?

> +	  nop

I think a single extra space of indentation for delay slots is the
convention, rather than 2. Same below.

> +	.align  4

doesn't this mean the first one & label might not be suitably aligned.
Would it be better to put this before the ld_d (no need for it after
$w31 case) and putting another .align 4 before the Lmsa_to and Lmsa_from
labels (so the label itself is aligned)?

> +	.endm
> +
> +	.macro  msa_st_d    wd, base
> +	st_d    \wd, 0, \base
> +	jalr    $0, $31
> +	  nop
> +	.align  4

same comments as above.

> +	.endm
> +
> +LEAF(msa_to_wd)
> +	.set    push
> +	.set    noreorder
> +	sll         t0, a0, 4
> +	PTR_LA      t1, Lmsa_to
> +	PTR_ADDU    t0, t0, t1
> +	jalr        $0, t0

Likewise here, "jr t0"? and same for msa_from_wd

> +	  nop
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
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.=
c
> index e11906dff885..558f41fa93c5 100644
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
> @@ -422,6 +427,64 @@ extern void show_registers(struct pt_regs *regs);
>  		: "r" (value), "r" (addr), "i" (-EFAULT));
>  #endif
> =20
> +#ifdef CONFIG_CPU_HAS_MSA
> +#ifdef __BIG_ENDIAN
> +/*
> + * MSA data format conversion.
> + * Only for BIG ENDIAN - LITTLE ENDIAN has register format which match=
es memory
> + * layout contiguosly.

contiguously

> + *
> + * Conversion is done between two Double words and other formats (W/H/=
B)
> + * because kernel uses LD.D and ST.D to load/store MSA registers and k=
eeps
> + * MSA registers in this format in current->thread.fpu.fpr
> + */
> +static void msa_convert(union fpureg *to, union fpureg *from, int fmt)=

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

FWIW since the FP/MSA patches that Paul submitted, there are also
working endian agnostic accessors created with BUILD_FPR_ACCESS, which
use the FPR_IDX macro (see http://patchwork.linux-mips.org/patch/9169/),
which should work for 8bit and 16bit sizes too.

I wonder if the compiler would unroll/optimise this sort of thing:
	for (i =3D 0; i < (FPU_REG_WIDTH / 8); ++i)
		to_val8[i] =3D from->val[FPR_IDX(8, i)];

No worries if not.

> +		break;
> +
> +	case 3: /* doubleword, no conversion */
> +		break;

don't you still need to copy the value though?

> +	}
> +}
> +#endif
> +#endif
> +
>  static void emulate_load_store_insn(struct pt_regs *regs,
>  	void __user *addr, unsigned int __user *pc)
>  {
> @@ -434,6 +497,10 @@ static void emulate_load_store_insn(struct pt_regs=
 *regs,
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
> @@ -703,6 +770,82 @@ static void emulate_load_store_insn(struct pt_regs=
 *regs,
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

Will this ever happen? (I can't see AdE handler enabling interrupts).

If the MSA context genuinely isn't live (i.e. it can be considered
UNPREDICTABLE), then surely a load operation should still succeed?

> +
> +		df =3D insn.msa_mi10_format.df;
> +		rs =3D insn.msa_mi10_format.rs;
> +		wd =3D insn.msa_mi10_format.wd;
> +		addr =3D (unsigned long *)(regs->regs[rs] + (insn.msa_mi10_format.s1=
0 * (1 << df)));

"* (1 << df)"?
why not just "<< df"?

> +		/* align a working space in stack... */
> +		msadata =3D (union fpureg *)(((unsigned long)msadatabase + 15) & ~(u=
nsigned long)0xf);

Maybe you could just use __aligned(16) on a single local union fpureg.

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

I'm not a fan of the ifdefs, but i can see its awkward to abstract
msa_convert without causing extra copies (although I don't think its a
critical code path).

> +			}
> +		} else {
> +			if (!access_ok(VERIFY_WRITE, addr, 16))
> +				goto sigbus;
> +			compute_return_epc(regs);

forgot to preempt_disable()?

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

hmm, you could cheat and change this to the following?:
				msadata =3D &current->thread.fpu.fpr[wd];

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

Cheers
James


--N9MUPvAdMBqGwn8JdSxRxMc7ChkvoMnSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVCWEdAAoJEGwLaZPeOHZ6NUEP/0HLu9pth0kVZKrCsXwqQyaa
O7JdZd6vrvcdf+9Ym86HPINQxgWdzZ/QhCthwjVgYkxX8SCKqq6wieotxX/yKcNq
zRJCwz/z0SQmGY5sBtDunpHcUtJ8w4EnvId70mAsWzvVgS1vmssCqhYIkkAiyKOT
nqQALFiaEj2irzaKGEbR9DokpHLfXldOkQ1SKeBGRiDHziPucXv1FrWCX1eyYB4n
SlJkaE+h9PRT1YbxHtHSPqnF8hCem74z64q1CW2tKOO8iKejmK49GYBjlRPwOTA1
gfemiyKINN1CEBo3f3uwSdtG1ehZTDpZZB3qx6nI/PlJ485Mn3Nq65DceoEpka50
wLKy+lsAkdtZZKzpwCtStkiJEtlQXuPYIOda38OOOsZ9t2fMD6XQm/KYBCGMz+BC
vqmfGfusHoAoquKkui9QzrDWOgojfFziMqLz2GCg4gBfNRdoLcLgDg0nQ4I6HAa4
BhJhS6PzKxjxE4tknlk3NTY2jodwEribv//LA0m+V96FRqH6eXUsy84lxipI5YUL
6U9eyboCglVPQe57Y46UbGPN2bgoumyUp/fTqZDhhC74BVrt0S7ZtW8NKHqfUkOA
MWSQXRqwHWnCKYebBOxsfUX9RS6ZctGq5qci1jwWHYqowRvkOMZhffVE/l7Rk+Y7
2xPOIeKkYmhI32Ou9iyK
=QLCt
-----END PGP SIGNATURE-----

--N9MUPvAdMBqGwn8JdSxRxMc7ChkvoMnSa--
