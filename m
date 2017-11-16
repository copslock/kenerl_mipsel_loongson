Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 01:05:32 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:43416 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992780AbdKPAFY7Z0hP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 01:05:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 16 Nov 2017 00:04:51 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 15 Nov
 2017 16:04:50 -0800
Date:   Thu, 16 Nov 2017 00:04:48 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2] MIPS: crypto: Add crc32 and crc32c hw accelerated
 module
Message-ID: <20171116000448.GC27409@jhogan-linux.mipstec.com>
References: <1507114133-9129-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1507114133-9129-3-git-send-email-marcin.nowakowski@imgtec.com>
 <20171004153600.GB31821@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20171004153600.GB31821@linux-mips.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510790690-321458-20069-25960-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186975
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(trim cc)

On Wed, Oct 04, 2017 at 05:36:00PM +0200, Ralf Baechle wrote:
> On Wed, Oct 04, 2017 at 12:48:53PM +0200, Marcin Nowakowski wrote:
> > +#define _CRC32(crc, value, size, type)						\
> > +do {										\
> > +	__asm__ __volatile__(							\
> > +	".set	push\n\t"							\
> > +	".set	noat\n\t"							\
> > +	"move	$at, %1\n\t"							\
> > +	"# " #type #size "	%0, $at, %0\n\t"				\
> > +	_ASM_INSN_IF_MIPS(0x7c00000f | (2 << 16) | (1 << 21) | (%2 << 6) | (%=
3 << 8))	\
> > +	_ASM_INSN32_IF_MM(0x00000030 | (1 << 16) | (2 << 21) | (%2 << 14) | (=
%3 << 3))	\
> > +	".set	pop"							\
> > +	: "+r" (crc)								\
> > +	: "r" (value), "i" (size), "i" (type)					\
> > +);										\
> > +} while(0)
> > +
> > +#define CRC_REGISTER __asm__("$2")
> > +#endif	/* !TOOLCHAIN_SUPPORTS_CRC */
>=20
> Over there years we've added so many inlines for instructions not yet
> supported by gas and the simply approach always requires extra move
> instructions.  So I finally cooked up something better which only relies
> on things that are in gas for as long as I can remember.  This illustrates
> it:
>=20
> 	.macro	parse var r
> 	.ifc	\r, $0
> \var	=3D	0
> 	.endif
> 	.ifc	\r, $1
> \var	=3D	1
> 	.endif
> 	.ifc	\r, $2
> \var	=3D	2
> 	.endif
> 	.ifc	\r, $3
> \var	=3D	3
> 	.endif
> 	.endm
>=20
> 	.macro	definsn opcode r1 r2 r3
> 	parse	__definsn_r1 \r1
> 	parse	__definsn_r2 \r2
> 	parse	__definsn_r3 \r3
> 	.word	\opcode | (__definsn_r1 << 16) | (__definsn_r2 << 20) | (__definsn=
_r3 << 24)
> 	.endm
>=20
> 	.macro	foo r1, r2, r3
> 	definsn	42, \r1, \r2, \r3
> 	.endm
>=20
> 	foo	$1, $2, $3
> 	foo	$3, $0, $1
>=20
> The advantages are obvious, the hypothetical instruction foo can be used
> just like it was actually supported by gas and no bloat by move
> instructions to shuffle operands in and results out.  Which for some
> very convoluted cases may also save you from an ICE.
>=20
> Above skeleton still needs a little polish, either by extending the
> parsing of register numbers to all 32 registers or by implementing that
> using another loop which probably would be implemented using a recursive
> gas macro.

Very nice, e.g.

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsr=
egs.h
index 6b1f1ad0542c..3a16fad43efb 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1180,6 +1180,31 @@ static inline int mm_insn_16bit(u16 insn)
 #define _ASM_INSN_IF_MIPS(_enc)
 #endif
=20
+/*
+ * Helper assembly macro for decoding a register name.
+ */
+#define _IFC_REG(n)			\
+	".ifc	\\r, $"#n"\n\t"		\
+	"\\var	=3D"#n"\n\t"		\
+	".endif\n\t"
+
+__asm__(".macro	parse var r\n\t"
+	"\\var	=3D -1\n\t"
+	_IFC_REG( 0) _IFC_REG( 1) _IFC_REG( 2) _IFC_REG( 3)
+	_IFC_REG( 4) _IFC_REG( 5) _IFC_REG( 6) _IFC_REG( 7)
+	_IFC_REG( 8) _IFC_REG( 9) _IFC_REG(10) _IFC_REG(11)
+	_IFC_REG(12) _IFC_REG(13) _IFC_REG(14) _IFC_REG(15)
+	_IFC_REG(16) _IFC_REG(17) _IFC_REG(18) _IFC_REG(19)
+	_IFC_REG(20) _IFC_REG(21) _IFC_REG(22) _IFC_REG(23)
+	_IFC_REG(24) _IFC_REG(25) _IFC_REG(26) _IFC_REG(27)
+	_IFC_REG(28) _IFC_REG(29) _IFC_REG(30) _IFC_REG(31)
+	".iflt	\\var\n\t"
+	".error \"Unable to parse register name \\r\"\n\t"
+	".endif\n\t"
+	".endm");
+
+#undef _IFC_REG
+
 /*
  * TLB Invalidate Flush
  */
@@ -1412,10 +1437,10 @@ do {									\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	.set	mips32r2				\n"	\
-	"	# mfhc0 $1, %1					\n"	\
-	_ASM_INSN_IF_MIPS(0x40410000 | ((%1 & 0x1f) << 11))		\
-	_ASM_INSN32_IF_MM(0x002000f4 | ((%1 & 0x1f) << 16))		\
-	"	move	%0, $1					\n"	\
+	"	# mfhc0 %0, %1					\n"	\
+	"	parse	__dst, %0				\n"	\
+	_ASM_INSN_IF_MIPS(0x40400000 | (__dst << 16) | ((%1 & 0x1f) << 11)) \
+	_ASM_INSN32_IF_MM(0x000000f4 | (__dst << 21) | ((%1 & 0x1f) << 16)) \
 	"	.set	pop					\n"	\
 	: "=3Dr" (__res)							\
 	: "i" (source));						\

gives us this in arch/mips/lib/dump_tlb.o:

- 430:	40411000 	mfhc0	at,c0_entrylo0
- 434:	00203825 	move	a3,at
+ 430:	40471000 	mfhc0	a3,c0_entrylo0

And we can easily enough simplify a lot of mostly duplicated code by
doing something like this (can't do it with mfhc0 as we don't yet have a
case that uses the assembler):

@@ -1855,14 +1855,25 @@ do {									\
  * Macros to access the guest system control coprocessor
  */
=20
-#ifdef TOOLCHAIN_SUPPORTS_VIRT
+#ifndef TOOLCHAIN_SUPPORTS_VIRT
+__asm__(".macro	mfgc0 rt, rs, sel\n\t"
+	"parse __rt, \\rt\n\t"
+	"parse __rs, \\rs\n\t"
+	"# mfgc0\t\\rt, \\rs, %2\n\t"
+	_ASM_INSN_IF_MIPS(0x40600000 | __rt << 16 | __rs << 11 | \\sel)
+	_ASM_INSN32_IF_MM(0x000004fc | __rt << 21 | __rs << 16 | \\sel << 11)
+	".endm");
+#define _ASM_SET_VIRT ""
+#else
+#define _ASM_SET_VIRT ".set\tvirt\n\t"
+#endif
=20
 #define __read_32bit_gc0_register(source, sel)				\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
-		".set\tvirt\n\t"					\
+		_ASM_SET_VIRT						\
 		"mfgc0\t%0, $%1, %2\n\t"				\
 		".set\tpop"						\
 		: "=3Dr" (__res)						\
@@ -1870,6 +1881,8 @@ do {									\
 	__res;								\
 })
=20
+#ifdef TOOLCHAIN_SUPPORTS_VIRT
+
 #define __read_64bit_gc0_register(source, sel)				\
 ({ unsigned long long __res;						\
 	__asm__ __volatile__(						\
@@ -1909,21 +1922,6 @@ do {									\
=20
 #else	/* TOOLCHAIN_SUPPORTS_VIRT */
=20
-#define __read_32bit_gc0_register(source, sel)				\
-({ int __res;								\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		"# mfgc0\t$1, $%1, %2\n\t"				\
-		_ASM_INSN_IF_MIPS(0x40610000 | %1 << 11 | %2)		\
-		_ASM_INSN32_IF_MM(0x002004fc | %1 << 16 | %2 << 11)	\
-		"move\t%0, $1\n\t"					\
-		".set\tpop"						\
-		: "=3Dr" (__res)						\
-		: "i" (source), "i" (sel));				\
-	__res;								\
-})
-
 #define __read_64bit_gc0_register(source, sel)				\
 ({ unsigned long long __res;						\
 	__asm__ __volatile__(						\

A worthwhile cleanup IMO to fix all cases like this to use that parsing
macro, though it'll take a bit of care.

The use of __asm__ in global scope to define the macros to be accessible
=66rom inline asm is slightly hacky.

Any comments / objections?

Cheers
James

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloM1hcACgkQbAtpk944
dnpq+Q//TI/vutfssbTuaDSE1qHcEvrQiUBW5FR95SB/1FcJS2CjUZamHTRLeO2j
goCL16zMnUcIN6JjoRE1OZKXQ0araaeU+qevruXMqVYPP4FqRYwvkDjJs8k4Q66t
J9FmhfzLaWAVIYFdFIcLxwix47ihnYXk78E42zXrk8dltlTZrFIC5eoZeNAlLrY3
aXhb8J7Wmlzr3TtVaQviMd4s3huPiSWNdKW2vE2gmQiDC/eQ6LNNw3NFu2qs6LG+
UcnqOmbiNiprlxT/c7/O6ifaMdU2lOx39whdH2VwJBxatVz3SLNKusa/GOlzU09o
q4baJrXIGwbl9/dJ3nFh9kPt2xb7pR/F1Hpx2u3r5d9ZkFcYNZKrA1h3zPH5an92
rlQ0uPjUAC0qli7m6bwJMyuVcmSvYGf6q+/UuawWE/ah90dEHh2KZ3XBkDsGcrbQ
1fI3DkuzufHrtdxyaOnQQsSMsmAFBVnWUH99c5Yka7WYAktJD8eLgMV4Ori6UbiP
9dIMfZW24q1DKTx3TLpkn1khA0fgHW0a6yrIA2suNV5L9/bV/BQxy0dBLCvLJd07
ysb3eW1blBdYpoo+RxNnA2coQW1wiZxw+K4GFcxkbTqlmcQ2fg2cvAs0wqXNmDKM
sUaElZ4vs471pRe5BthAM0nLQkxI8JNwKj1H99M/vA7jGmziAio=
=kRlf
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
