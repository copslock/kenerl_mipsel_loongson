Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 22:21:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55559 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993904AbdGCUUz4qeRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 22:20:55 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C728C41F8E08;
        Mon,  3 Jul 2017 22:31:07 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 03 Jul 2017 22:31:07 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 03 Jul 2017 22:31:07 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 72F37518139DE;
        Mon,  3 Jul 2017 21:20:45 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 3 Jul
 2017 21:20:50 +0100
Date:   Mon, 3 Jul 2017 21:20:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS16e2: Subdecode extended LWSP/SWSP instructions
Message-ID: <20170703202049.GL31455@jhogan-linux.le.imgtec.org>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705180146520.2590@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rVkomL2febZOZtGQ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1705180146520.2590@tp.orcam.me.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59008
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

--rVkomL2febZOZtGQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:38:19PM +0100, Maciej W. Rozycki wrote:
> Implement extended LWSP/SWSP instruction subdecoding for the purpose of=
=20
> unaligned GP-relative memory access emulation.
>=20
> With the introduction of the MIPS16e2 ASE[1] the previously must-be-zero=
=20
> 3-bit field at bits 7..5 of the extended encodings of the instructions=20
> selected with the LWSP and SWSP major opcodes has become a `sel' field,=
=20
> acting as an opcode extension for additional operations.  In both cases=
=20
> the `sel' value of 0 has retained the original operation, that is:
>=20
> 	LW	rx, offset(sp)
>=20
> and:
>=20
> 	SW	rx, offset(sp)
>=20
> for LWSP and SWSP respectively.  In hardware predating the MIPS16e2 ASE=
=20
> other values may or may not have been decoded, architecturally yielding=
=20
> unpredictable results, and in our unaligned memory access emulation we=20
> have treated the 3-bit field as a don't-care, that is effectively making=
=20
> all the possible encodings of the field alias to the architecturally=20
> defined encoding of 0.
>=20
> For the non-zero values of the `sel' field the MIPS16e2 ASE has in=20
> particular defined these GP-relative operations:
>=20
> 	LW	rx, offset(gp)		# sel =3D 1
> 	LH	rx, offset(gp)		# sel =3D 2
> 	LHU	rx, offset(gp)		# sel =3D 4
>=20
> and
>=20
> 	SW	rx, offset(gp)		# sel =3D 1
> 	SH	rx, offset(gp)		# sel =3D 2
>=20
> for LWSP and SWSP respectively, which will trap with an Address Error=20
> exception if the effective address calculated is not naturally-aligned=20
> for the operation requested.  These operations have been selected for=20
> unaligned access emulation, for consistency with the corresponding=20
> regular MIPS and microMIPS operations.
>=20
> For other non-zero values of the `sel' field the MIPS16e2 ASE has=20
> defined further operations, which however either never trap with an=20
> Address Error exception, such as LWL or GP-relative SB, or are not=20
> supposed to be emulated, such as LL or SC.  These operations have been=20
> selected to exclude from unaligned access emulation, should an Address=20
> Error exception ever happen with them.
>=20
> Subdecode the `sel' field in unaligned access emulation then for the=20
> extended encodings of the instructions selected with the LWSP and SWSP=20
> major opcodes, whenever support for the MIPS16e2 ASE has been detected=20
> in hardware, and either emulate the operation requested or send SIGBUS=20
> to the originating process, according to the selection described above. =
=20
> For hardware implementing the MIPS16 ASE, however lacking MIPS16e2 ASE=20
> support retain the original interpretation of the `sel' field.
>=20
> The effects of this change are illustrated with the following user=20
> program:

Very descriptive, but I must admit a got a bit bored of reading and
skipped to the code at this point, which looks correct, so

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

>=20
> $ cat mips16e2-test.c
> #include <inttypes.h>
> #include <stdio.h>
>=20
> int main(void)
> {
> 	int64_t scratch[16] =3D { 0 };
> 	int32_t *tmp0, *tmp1, *tmp2;
> 	int i;
>=20
> 	scratch[0] =3D 0xc8c7c6c5c4c3c2c1;
> 	scratch[1] =3D 0xd0cfcecdcccbcac9;
>=20
> 	asm volatile(
> 		"move	%0, $sp\n\t"
> 		"move	%1, $gp\n\t"
> 		"move	$sp, %4\n\t"
> 		"addiu	%2, %4, 8\n\t"
> 		"move	$gp, %2\n\t"
>=20
> 		"lw	%2, 2($sp)\n\t"
> 		"sw	%2, 16(%4)\n\t"
> 		"lw	%2, 2($gp)\n\t"
> 		"sw	%2, 24(%4)\n\t"
>=20
> 		"lw	%2, 1($sp)\n\t"
> 		"sw	%2, 32(%4)\n\t"
> 		"lh	%2, 1($gp)\n\t"
> 		"sw	%2, 40(%4)\n\t"
>=20
> 		"lw	%2, 3($sp)\n\t"
> 		"sw	%2, 48(%4)\n\t"
> 		"lhu	%2, 3($gp)\n\t"
> 		"sw	%2, 56(%4)\n\t"
>=20
> 		"lw	%2, 0(%4)\n\t"
> 		"sw	%2, 66($sp)\n\t"
> 		"lw	%2, 8(%4)\n\t"
> 		"sw	%2, 82($gp)\n\t"
>=20
> 		"lw	%2, 0(%4)\n\t"
> 		"sw	%2, 97($sp)\n\t"
> 		"lw	%2, 8(%4)\n\t"
> 		"sh	%2, 113($gp)\n\t"
>=20
> 		"move	$gp, %1\n\t"
> 		"move	$sp, %0"
> 		: "=3D&d" (tmp0), "=3D&d" (tmp1), "=3D&d" (tmp2), "=3Dm" (scratch)
> 		: "d" (scratch));
>=20
> 	for (i =3D 0; i < sizeof(scratch) / sizeof(*scratch); i +=3D 2)
> 		printf("%016" PRIx64 "\t%016" PRIx64 "\n",
> 		       scratch[i], scratch[i + 1]);
>=20
> 	return 0;
> }
> $
>=20
> to be compiled with:
>=20
> $ gcc -mips16 -mips32r2 -Wa,-mmips16e2 -o mips16e2-test mips16e2-test.c
> $
>=20
> With 74Kf hardware, which does not implement the MIPS16e2 ASE, this=20
> program produces the following output:
>=20
> $ ./mips16e2-test
> c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
> 00000000c6c5c4c3        00000000c6c5c4c3
> 00000000c5c4c3c2        00000000c5c4c3c2
> 00000000c7c6c5c4        00000000c7c6c5c4
> 0000c4c3c2c10000        0000000000000000
> 0000cccbcac90000        0000000000000000
> 000000c4c3c2c100        0000000000000000
> 000000cccbcac900        0000000000000000
> $=20
>=20
> regardless of whether the change has been applied or not.
>=20
> With the change not applied and interAptive MR2 hardware[2], which does=
=20
> implement the MIPS16e2 ASE, it produces the following output:
>=20
> $ ./mips16e2-test
> c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
> 00000000c6c5c4c3        00000000cecdcccb
> 00000000c5c4c3c2        00000000cdcccbca
> 00000000c7c6c5c4        00000000cfcecdcc
> 0000c4c3c2c10000        0000000000000000
> 0000000000000000        0000cccbcac90000
> 000000c4c3c2c100        0000000000000000
> 0000000000000000        000000cccbcac900
> $=20
>=20
> which shows that for GP-relative operations the correct trapping address=
=20
> calculated from $gp has been obtained from the CP0 BadVAddr register and=
=20
> so has data from the source operand, however masking and extension has=20
> not been applied for halfword operations.
>=20
> With the change applied and interAptive MR2 hardware the program=20
> produces the following output:
>=20
> $ ./mips16e2-test
> c8c7c6c5c4c3c2c1        d0cfcecdcccbcac9
> 00000000c6c5c4c3        00000000cecdcccb
> 00000000c5c4c3c2        00000000ffffcbca
> 00000000c7c6c5c4        000000000000cdcc
> 0000c4c3c2c10000        0000000000000000
> 0000000000000000        0000cccbcac90000
> 000000c4c3c2c100        0000000000000000
> 0000000000000000        0000000000cac900
> $=20
>=20
> as expected.
>=20
> References:
>=20
> [1] "MIPS32 Architecture for Programmers: MIPS16e2 Application-Specific
>     Extension Technical Reference Manual", Imagination Technologies
>     Ltd., Document Number: MD01172, Revision 01.00, April 26, 2016
>=20
> [2] "MIPS32 interAptiv Multiprocessing System Software User's Manual",
>     Imagination Technologies Ltd., Document Number: MD00904, Revision
>     02.01, June 15, 2016, Chapter 24 "MIPS16e Application-Specific=20
>     Extension to the MIPS32 Instruction Set", pp. 871-883
>=20
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  NB a recent binutils version, as from commit 25499ac7ee92 ("MIPS16e2:=20
> Add MIPS16e2 ASE support"), is required to build the test program.
>=20
>   Maciej
>=20
> linux-mips16e2-ase-emul.diff
> Index: linux-sfr-test/arch/mips/kernel/unaligned.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-sfr-test.orig/arch/mips/kernel/unaligned.c	2017-05-22 22:42:16.=
000000000 +0100
> +++ linux-sfr-test/arch/mips/kernel/unaligned.c	2017-05-22 22:54:28.68609=
6000 +0100
> @@ -1984,6 +1984,8 @@ static void emulate_load_store_MIPS16e(s
>  	u16 __user *pc16;
>  	unsigned long origpc;
>  	union mips16e_instruction mips16inst, oldinst;
> +	unsigned int opcode;
> +	int extended =3D 0;
> =20
>  	origpc =3D regs->cp0_epc;
>  	orig31 =3D regs->regs[31];
> @@ -1996,6 +1998,7 @@ static void emulate_load_store_MIPS16e(s
> =20
>  	/* skip EXTEND instruction */
>  	if (mips16inst.ri.opcode =3D=3D MIPS16e_extend_op) {
> +		extended =3D 1;
>  		pc16++;
>  		__get_user(mips16inst.full, pc16);
>  	} else if (delay_slot(regs)) {
> @@ -2008,7 +2011,8 @@ static void emulate_load_store_MIPS16e(s
>  			goto sigbus;
>  	}
> =20
> -	switch (mips16inst.ri.opcode) {
> +	opcode =3D mips16inst.ri.opcode;
> +	switch (opcode) {
>  	case MIPS16e_i64_op:	/* I64 or RI64 instruction */
>  		switch (mips16inst.i64.func) {	/* I64/RI64 func field check */
>  		case MIPS16e_ldpc_func:
> @@ -2028,9 +2032,40 @@ static void emulate_load_store_MIPS16e(s
>  		goto sigbus;
> =20
>  	case MIPS16e_swsp_op:
> +		reg =3D reg16to32[mips16inst.ri.rx];
> +		if (extended && cpu_has_mips16e2)
> +			switch (mips16inst.ri.imm >> 5) {
> +			case 0:		/* SWSP */
> +			case 1:		/* SWGP */
> +				break;
> +			case 2:		/* SHGP */
> +				opcode =3D MIPS16e_sh_op;
> +				break;
> +			default:
> +				goto sigbus;
> +			}
> +		break;
> +
>  	case MIPS16e_lwpc_op:
> +		reg =3D reg16to32[mips16inst.ri.rx];
> +		break;
> +
>  	case MIPS16e_lwsp_op:
>  		reg =3D reg16to32[mips16inst.ri.rx];
> +		if (extended && cpu_has_mips16e2)
> +			switch (mips16inst.ri.imm >> 5) {
> +			case 0:		/* LWSP */
> +			case 1:		/* LWGP */
> +				break;
> +			case 2:		/* LHGP */
> +				opcode =3D MIPS16e_lh_op;
> +				break;
> +			case 4:		/* LHUGP */
> +				opcode =3D MIPS16e_lhu_op;
> +				break;
> +			default:
> +				goto sigbus;
> +			}
>  		break;
> =20
>  	case MIPS16e_i8_op:
> @@ -2044,7 +2079,7 @@ static void emulate_load_store_MIPS16e(s
>  		break;
>  	}
> =20
> -	switch (mips16inst.ri.opcode) {
> +	switch (opcode) {
> =20
>  	case MIPS16e_lb_op:
>  	case MIPS16e_lbu_op:

--rVkomL2febZOZtGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllapxcACgkQbAtpk944
dnrb1Q/7BXwnpaF1pN8wCJFqD6pPM2/T5ruIgJ9WkiJishYwGrAJmqT6iyhI2Lt9
Wa3gy/ZJx59FM1c95gLBpVmnhvb8uuN8QZTGg2IwJmvRVnco9VDAECxzC3HQWkI1
SB82D4MmnfzlCZh/tqRt7PvddYvgQZN40ixnnUeZTZK+LLNRW9eZ0aWje20LF2wH
1U+3pxoPwi2LPcTE6JTZeET5l9LdQNlnt36KwAL51CUqaQKl0R8Bt0opUeFSL1GG
/4rkQa0n6jz1gFlYpMK7WctvkJ8P2h/uRuHLkprXShrF/yv3MdvzlbgHBy9PnqSx
XLyFm0SaiiXGy/TJR8wDDVBk6rgR4+JGb0iUOZF7tkG7j77u+wJkMEoJ+Ff+wnPA
HtpXxerkr/a8ogT1bThVnVTW29BFem8ijRVtOFM08uCYXovfl1TW1hti8QUCdC3w
AKWloXiJmRMq+Ksb/8Epa+hhFK91ulPhd3XpPanZET3MkIoxPFTFIE0T6cMMukUp
FEzkQx+iWpiIDQcM4uiDiiInW3IBnOOz3IXdywatIwnA1yhvFis9gODcHxPUA+bH
zl7UX142SSUIy3j46fSNHIef6nRfCU+x6oQh8WYy4euqefKTYJmF5DtivfCnVxey
Pd/FAqYx3BZFrrb+gJGH1lGDefOWmqmNnBvjn/ITnaf5bfxqvv4=
=Oh12
-----END PGP SIGNATURE-----

--rVkomL2febZOZtGQ--
