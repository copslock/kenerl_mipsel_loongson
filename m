Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 10:31:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20164 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991232AbcKAJbgfGa8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 10:31:36 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id B188341F8E8E;
        Tue,  1 Nov 2016 09:30:38 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 01 Nov 2016 09:30:38 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 01 Nov 2016 09:30:38 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1743C8F31A39A;
        Tue,  1 Nov 2016 09:31:28 +0000 (GMT)
Received: from np-p-burton.localnet (10.100.200.179) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 1 Nov
 2016 09:31:30 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] MIPS: Fix ISA I/II FP signal context offsets
Date:   Tue, 1 Nov 2016 09:31:29 +0000
Message-ID: <1814661.4I5xJD6gaP@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1610310407150.31859@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1610310319010.31859@tp.orcam.me.uk> <alpine.DEB.2.00.1610310407150.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6355547.4sVSYX5R1t";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.179]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55634
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

--nextPart6355547.4sVSYX5R1t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 31 October 2016 16:27:01 GMT Maciej W. Rozycki wrote:
> Fix a regression introduced with commit 2db9ca0a3551 ("MIPS: Use struct
> mips_abi offsets to save FP context") for MIPS I/I FP signal contexts,
> by converting save/restore code to the updated internal API.  Start FGR
> offsets from 0 rather than SC_FPREGS from $a0 and use $a1 rather than
> the offset of SC_FPC_CSR from $a0 for the Floating Point Control/Status
> Register (FCSR).
> 
> Document the new internal API and adjust assembly code formatting for
> consistency.
> 
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
> linux-mips-isa12-sig-fp-context-offsets.patch
> Index: linux-sfr-test/arch/mips/kernel/r2300_fpu.S
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/kernel/r2300_fpu.S	2016-10-22
> 02:28:09.266462000 +0100 +++
> linux-sfr-test/arch/mips/kernel/r2300_fpu.S	2016-10-22 02:29:01.523906000
> +0100 @@ -26,97 +26,104 @@
> 
>  	.set	noreorder
>  	.set	mips1
> -	/* Save floating point context */
> +
> +/**
> + * _save_fp_context() - save FP context from the FPU
> + * @a0 - pointer to fpregs field of sigcontext
> + * @a1 - pointer to fpc_csr field of sigcontext
> + *
> + * Save FP context, including the 32 FP data registers and the FP
> + * control & status register, from the FPU to signal context.
> + */
>  LEAF(_save_fp_context)
>  	.set	push
>  	SET_HARDFLOAT
>  	li	v0, 0					# assume success
> -	cfc1	t1,fcr31
> -	EX(swc1 $f0,(SC_FPREGS+0)(a0))
> -	EX(swc1 $f1,(SC_FPREGS+8)(a0))
> -	EX(swc1 $f2,(SC_FPREGS+16)(a0))
> -	EX(swc1 $f3,(SC_FPREGS+24)(a0))
> -	EX(swc1 $f4,(SC_FPREGS+32)(a0))
> -	EX(swc1 $f5,(SC_FPREGS+40)(a0))
> -	EX(swc1 $f6,(SC_FPREGS+48)(a0))
> -	EX(swc1 $f7,(SC_FPREGS+56)(a0))
> -	EX(swc1 $f8,(SC_FPREGS+64)(a0))
> -	EX(swc1 $f9,(SC_FPREGS+72)(a0))
> -	EX(swc1 $f10,(SC_FPREGS+80)(a0))
> -	EX(swc1 $f11,(SC_FPREGS+88)(a0))
> -	EX(swc1 $f12,(SC_FPREGS+96)(a0))
> -	EX(swc1 $f13,(SC_FPREGS+104)(a0))
> -	EX(swc1 $f14,(SC_FPREGS+112)(a0))
> -	EX(swc1 $f15,(SC_FPREGS+120)(a0))
> -	EX(swc1 $f16,(SC_FPREGS+128)(a0))
> -	EX(swc1 $f17,(SC_FPREGS+136)(a0))
> -	EX(swc1 $f18,(SC_FPREGS+144)(a0))
> -	EX(swc1 $f19,(SC_FPREGS+152)(a0))
> -	EX(swc1 $f20,(SC_FPREGS+160)(a0))
> -	EX(swc1 $f21,(SC_FPREGS+168)(a0))
> -	EX(swc1 $f22,(SC_FPREGS+176)(a0))
> -	EX(swc1 $f23,(SC_FPREGS+184)(a0))
> -	EX(swc1 $f24,(SC_FPREGS+192)(a0))
> -	EX(swc1 $f25,(SC_FPREGS+200)(a0))
> -	EX(swc1 $f26,(SC_FPREGS+208)(a0))
> -	EX(swc1 $f27,(SC_FPREGS+216)(a0))
> -	EX(swc1 $f28,(SC_FPREGS+224)(a0))
> -	EX(swc1 $f29,(SC_FPREGS+232)(a0))
> -	EX(swc1 $f30,(SC_FPREGS+240)(a0))
> -	EX(swc1 $f31,(SC_FPREGS+248)(a0))
> +	cfc1	t1, fcr31
> +	EX(swc1 $f0, 0(a0))
> +	EX(swc1 $f1, 8(a0))
> +	EX(swc1 $f2, 16(a0))
> +	EX(swc1 $f3, 24(a0))
> +	EX(swc1 $f4, 32(a0))
> +	EX(swc1 $f5, 40(a0))
> +	EX(swc1 $f6, 48(a0))
> +	EX(swc1 $f7, 56(a0))
> +	EX(swc1 $f8, 64(a0))
> +	EX(swc1 $f9, 72(a0))
> +	EX(swc1 $f10, 80(a0))
> +	EX(swc1 $f11, 88(a0))
> +	EX(swc1 $f12, 96(a0))
> +	EX(swc1 $f13, 104(a0))
> +	EX(swc1 $f14, 112(a0))
> +	EX(swc1 $f15, 120(a0))
> +	EX(swc1 $f16, 128(a0))
> +	EX(swc1 $f17, 136(a0))
> +	EX(swc1 $f18, 144(a0))
> +	EX(swc1 $f19, 152(a0))
> +	EX(swc1 $f20, 160(a0))
> +	EX(swc1 $f21, 168(a0))
> +	EX(swc1 $f22, 176(a0))
> +	EX(swc1 $f23, 184(a0))
> +	EX(swc1 $f24, 192(a0))
> +	EX(swc1 $f25, 200(a0))
> +	EX(swc1 $f26, 208(a0))
> +	EX(swc1 $f27, 216(a0))
> +	EX(swc1 $f28, 224(a0))
> +	EX(swc1 $f29, 232(a0))
> +	EX(swc1 $f30, 240(a0))
> +	EX(swc1 $f31, 248(a0))
>  	jr	ra
> -	 EX(sw	t1,(SC_FPC_CSR)(a0))
> +	 EX(sw	t1, (a1))
>  	.set	pop
>  	END(_save_fp_context)
> 
> -/*
> - * Restore FPU state:
> - *  - fp gp registers
> - *  - cp1 status/control register
> +/**
> + * _restore_fp_context() - restore FP context to the FPU
> + * @a0 - pointer to fpregs field of sigcontext
> + * @a1 - pointer to fpc_csr field of sigcontext
>   *
> - * We base the decision which registers to restore from the signal stack
> - * frame on the current content of c0_status, not on the content of the
> - * stack frame which might have been changed by the user.
> + * Restore FP context, including the 32 FP data registers and the FP
> + * control & status register, from signal context to the FPU.
>   */
>  LEAF(_restore_fp_context)
>  	.set	push
>  	SET_HARDFLOAT
>  	li	v0, 0					# assume success
> -	EX(lw t0,(SC_FPC_CSR)(a0))
> -	EX(lwc1 $f0,(SC_FPREGS+0)(a0))
> -	EX(lwc1 $f1,(SC_FPREGS+8)(a0))
> -	EX(lwc1 $f2,(SC_FPREGS+16)(a0))
> -	EX(lwc1 $f3,(SC_FPREGS+24)(a0))
> -	EX(lwc1 $f4,(SC_FPREGS+32)(a0))
> -	EX(lwc1 $f5,(SC_FPREGS+40)(a0))
> -	EX(lwc1 $f6,(SC_FPREGS+48)(a0))
> -	EX(lwc1 $f7,(SC_FPREGS+56)(a0))
> -	EX(lwc1 $f8,(SC_FPREGS+64)(a0))
> -	EX(lwc1 $f9,(SC_FPREGS+72)(a0))
> -	EX(lwc1 $f10,(SC_FPREGS+80)(a0))
> -	EX(lwc1 $f11,(SC_FPREGS+88)(a0))
> -	EX(lwc1 $f12,(SC_FPREGS+96)(a0))
> -	EX(lwc1 $f13,(SC_FPREGS+104)(a0))
> -	EX(lwc1 $f14,(SC_FPREGS+112)(a0))
> -	EX(lwc1 $f15,(SC_FPREGS+120)(a0))
> -	EX(lwc1 $f16,(SC_FPREGS+128)(a0))
> -	EX(lwc1 $f17,(SC_FPREGS+136)(a0))
> -	EX(lwc1 $f18,(SC_FPREGS+144)(a0))
> -	EX(lwc1 $f19,(SC_FPREGS+152)(a0))
> -	EX(lwc1 $f20,(SC_FPREGS+160)(a0))
> -	EX(lwc1 $f21,(SC_FPREGS+168)(a0))
> -	EX(lwc1 $f22,(SC_FPREGS+176)(a0))
> -	EX(lwc1 $f23,(SC_FPREGS+184)(a0))
> -	EX(lwc1 $f24,(SC_FPREGS+192)(a0))
> -	EX(lwc1 $f25,(SC_FPREGS+200)(a0))
> -	EX(lwc1 $f26,(SC_FPREGS+208)(a0))
> -	EX(lwc1 $f27,(SC_FPREGS+216)(a0))
> -	EX(lwc1 $f28,(SC_FPREGS+224)(a0))
> -	EX(lwc1 $f29,(SC_FPREGS+232)(a0))
> -	EX(lwc1 $f30,(SC_FPREGS+240)(a0))
> -	EX(lwc1 $f31,(SC_FPREGS+248)(a0))
> +	EX(lw t0, (a1))
> +	EX(lwc1 $f0, 0(a0))
> +	EX(lwc1 $f1, 8(a0))
> +	EX(lwc1 $f2, 16(a0))
> +	EX(lwc1 $f3, 24(a0))
> +	EX(lwc1 $f4, 32(a0))
> +	EX(lwc1 $f5, 40(a0))
> +	EX(lwc1 $f6, 48(a0))
> +	EX(lwc1 $f7, 56(a0))
> +	EX(lwc1 $f8, 64(a0))
> +	EX(lwc1 $f9, 72(a0))
> +	EX(lwc1 $f10, 80(a0))
> +	EX(lwc1 $f11, 88(a0))
> +	EX(lwc1 $f12, 96(a0))
> +	EX(lwc1 $f13, 104(a0))
> +	EX(lwc1 $f14, 112(a0))
> +	EX(lwc1 $f15, 120(a0))
> +	EX(lwc1 $f16, 128(a0))
> +	EX(lwc1 $f17, 136(a0))
> +	EX(lwc1 $f18, 144(a0))
> +	EX(lwc1 $f19, 152(a0))
> +	EX(lwc1 $f20, 160(a0))
> +	EX(lwc1 $f21, 168(a0))
> +	EX(lwc1 $f22, 176(a0))
> +	EX(lwc1 $f23, 184(a0))
> +	EX(lwc1 $f24, 192(a0))
> +	EX(lwc1 $f25, 200(a0))
> +	EX(lwc1 $f26, 208(a0))
> +	EX(lwc1 $f27, 216(a0))
> +	EX(lwc1 $f28, 224(a0))
> +	EX(lwc1 $f29, 232(a0))
> +	EX(lwc1 $f30, 240(a0))
> +	EX(lwc1 $f31, 248(a0))
>  	jr	ra
> -	 ctc1	t0,fcr31
> +	 ctc1	t0, fcr31
>  	.set	pop
>  	END(_restore_fp_context)
>  	.set	reorder
> Index: linux-sfr-test/arch/mips/kernel/r6000_fpu.S
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/kernel/r6000_fpu.S	2016-10-22
> 02:28:57.927876000 +0100 +++
> linux-sfr-test/arch/mips/kernel/r6000_fpu.S	2016-10-22 02:29:12.415002000
> +0100 @@ -21,7 +21,14 @@
>  	.set	push
>  	SET_HARDFLOAT
> 
> -	/* Save floating point context */
> +/**
> + * _save_fp_context() - save FP context from the FPU
> + * @a0 - pointer to fpregs field of sigcontext
> + * @a1 - pointer to fpc_csr field of sigcontext
> + *
> + * Save FP context, including the 32 FP data registers and the FP
> + * control & status register, from the FPU to signal context.
> + */
>  	LEAF(_save_fp_context)
>  	mfc0	t0,CP0_STATUS
>  	sll	t0,t0,2
> @@ -30,59 +37,59 @@
> 
>  	cfc1	t1,fcr31
>  	/* Store the 16 double precision registers */
> -	sdc1	$f0,(SC_FPREGS+0)(a0)
> -	sdc1	$f2,(SC_FPREGS+16)(a0)
> -	sdc1	$f4,(SC_FPREGS+32)(a0)
> -	sdc1	$f6,(SC_FPREGS+48)(a0)
> -	sdc1	$f8,(SC_FPREGS+64)(a0)
> -	sdc1	$f10,(SC_FPREGS+80)(a0)
> -	sdc1	$f12,(SC_FPREGS+96)(a0)
> -	sdc1	$f14,(SC_FPREGS+112)(a0)
> -	sdc1	$f16,(SC_FPREGS+128)(a0)
> -	sdc1	$f18,(SC_FPREGS+144)(a0)
> -	sdc1	$f20,(SC_FPREGS+160)(a0)
> -	sdc1	$f22,(SC_FPREGS+176)(a0)
> -	sdc1	$f24,(SC_FPREGS+192)(a0)
> -	sdc1	$f26,(SC_FPREGS+208)(a0)
> -	sdc1	$f28,(SC_FPREGS+224)(a0)
> -	sdc1	$f30,(SC_FPREGS+240)(a0)
> +	sdc1	$f0,0(a0)
> +	sdc1	$f2,16(a0)
> +	sdc1	$f4,32(a0)
> +	sdc1	$f6,48(a0)
> +	sdc1	$f8,64(a0)
> +	sdc1	$f10,80(a0)
> +	sdc1	$f12,96(a0)
> +	sdc1	$f14,112(a0)
> +	sdc1	$f16,128(a0)
> +	sdc1	$f18,144(a0)
> +	sdc1	$f20,160(a0)
> +	sdc1	$f22,176(a0)
> +	sdc1	$f24,192(a0)
> +	sdc1	$f26,208(a0)
> +	sdc1	$f28,224(a0)
> +	sdc1	$f30,240(a0)
>  	jr	ra
> -	 sw	t0,SC_FPC_CSR(a0)
> +	 sw	t0,(a1)
>  1:	jr	ra
>  	 nop
>  	END(_save_fp_context)
> 
> -/* Restore FPU state:
> - *  - fp gp registers
> - *  - cp1 status/control register
> +/**
> + * _restore_fp_context() - restore FP context to the FPU
> + * @a0 - pointer to fpregs field of sigcontext
> + * @a1 - pointer to fpc_csr field of sigcontext
>   *
> - * We base the decision which registers to restore from the signal stack
> - * frame on the current content of c0_status, not on the content of the
> - * stack frame which might have been changed by the user.
> + * Restore FP context, including the 32 FP data registers and the FP
> + * control & status register, from signal context to the FPU.
>   */
>  	LEAF(_restore_fp_context)
>  	mfc0	t0,CP0_STATUS
>  	sll	t0,t0,2
> 
>  	bgez	t0,1f
> -	 lw	t0,SC_FPC_CSR(a0)
> +	 lw	t0,(a1)
>  	/* Restore the 16 double precision registers */
> -	ldc1	$f0,(SC_FPREGS+0)(a0)
> -	ldc1	$f2,(SC_FPREGS+16)(a0)
> -	ldc1	$f4,(SC_FPREGS+32)(a0)
> -	ldc1	$f6,(SC_FPREGS+48)(a0)
> -	ldc1	$f8,(SC_FPREGS+64)(a0)
> -	ldc1	$f10,(SC_FPREGS+80)(a0)
> -	ldc1	$f12,(SC_FPREGS+96)(a0)
> -	ldc1	$f14,(SC_FPREGS+112)(a0)
> -	ldc1	$f16,(SC_FPREGS+128)(a0)
> -	ldc1	$f18,(SC_FPREGS+144)(a0)
> -	ldc1	$f20,(SC_FPREGS+160)(a0)
> -	ldc1	$f22,(SC_FPREGS+176)(a0)
> -	ldc1	$f24,(SC_FPREGS+192)(a0)
> -	ldc1	$f26,(SC_FPREGS+208)(a0)
> -	ldc1	$f28,(SC_FPREGS+224)(a0)
> -	ldc1	$f30,(SC_FPREGS+240)(a0)
> +	ldc1	$f0,0(a0)
> +	ldc1	$f2,16(a0)
> +	ldc1	$f4,32(a0)
> +	ldc1	$f6,48(a0)
> +	ldc1	$f8,64(a0)
> +	ldc1	$f10,80(a0)
> +	ldc1	$f12,96(a0)
> +	ldc1	$f14,112(a0)
> +	ldc1	$f16,128(a0)
> +	ldc1	$f18,144(a0)
> +	ldc1	$f20,160(a0)
> +	ldc1	$f22,176(a0)
> +	ldc1	$f24,192(a0)
> +	ldc1	$f26,208(a0)
> +	ldc1	$f28,224(a0)
> +	ldc1	$f30,240(a0)
>  	jr	ra
>  	 ctc1	t0,fcr31
>  1:	jr	ra

Hi Maciej,

Thanks for fixing that up:

    Reviewed-by: Paul Burton <paul.burton@imgtec.com>

BTW, do you have a feel for whether there's a good r2k/r3k platform (ideal 
would be some software emulator if any are good enough) that we could hook up 
to our continuous integration system? That would help us to catch any 
regressions like this in future before they hit mainline.

Thanks,
    Paul
--nextPart6355547.4sVSYX5R1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYGGDxAAoJEIIg2fppPBxlS/AP/1STLGtbxB4R32jLEiOdXWWm
He+B7/clYp416jl018jAZRQtO3Be/wX4nyxYuIfNEuzYXumXd6WCjVvfI9vpG7ek
Dt/069XCrqHFHcw7EcrgAsBsm5lHQNgTbU8M6wnWEVzqs14ODAhD9yKMIbgT7Gvw
AfrigdR2JbuGuO+03L15LBzCfzrHippyTCy35n9Eww+aUs/AD9rszjDwf9PliUj4
dncWSU4ZBH/rbkFu+OnP3Pnvlwp1mT+VpjfmJYhoocNtOy195kXpkhhLEYQQ70+O
bBWgwyA66d60XPM/Yalnzvk00JuI+SIj3S9BMlBaUDzM3Ntx4yKuvFPCpJwx6Ui3
JODYKgzWIpJPAPXi+3N6IelXJWRKlREeIb1ZgU9KfAQwrrBrgqWrHPgLvEBYtTpF
SFZvf+Ge+xCU09q3rSH9jc587MbZRAZPDwzPH+mGK/7tOOnZAZ9FHKw37lGmQid1
x14qQKh1Sa7UQ0ZB2/3/qbsDyuO18tUlqPesM0JbNZAkLeKuCN61FJvMxtOzJ/Ch
2N8ZRoQX+T5RmVnWaLGiZB5ABJyE0y4x4saCV9+bsb3YpRhbvkt7ckpfqHGmLax7
DMXIi/D+PNm+dgMv4/UnX46PQJInQDn0W2dur8FXOXVuKiWNt54UFfenlmh1ZRqT
KOvF4tiXHZiNZo/b7jDw
=c55I
-----END PGP SIGNATURE-----

--nextPart6355547.4sVSYX5R1t--
