Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 01:40:00 +0100 (CET)
Received: from mailout-de.gmx.net ([213.165.64.23]:42096 "HELO
        mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1904095Ab1KRAjx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 01:39:53 +0100
Received: (qmail invoked by alias); 18 Nov 2011 00:39:47 -0000
Received: from g225041035.adsl.alicedsl.de (EHLO snail.gmx.de) [92.225.41.35]
  by mail.gmx.net (mp045) with SMTP; 18 Nov 2011 01:39:47 +0100
X-Authenticated: #4121607
X-Provags-ID: V01U2FsdGVkX1+kQi1PjtOkrtACTNK8Ls2E1TrFoX2b8pdMavxK4u
        va8y6CwjLaf+K2
From:   David Kuehling <dvdkhlng@gmx.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH v2] Add MIPS-assembler version of twofish crypto algorithm
CC:     Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 18 Nov 2011 01:39:42 +0100
Message-ID: <8762iiclgx.fsf@snail.Pool>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
X-Y-GMX-Trusted: 0
X-archive-position: 31780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvdkhlng@gmx.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15017

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Second version of the patch, cleaned up as discussed a few weeks back:
use register defines from asm/regdef.h, removed most of the #ifdef'ery.
Did not yet add MIPS32r2 instructions for rotation,
endianess-conversion, I'll leave that for a later time when I have
access to such hardware and the time to test the additional code.

For N64-ABI I verified that this produces the same binary code as the
earlier patch.  For O32 I merely tested that it still compiles and
checked the disassembly.

Original comment:

This patch adds a MIPS assembler version of the twofish cipher
algorithm.  x86(_64) had an assembler version of twofish for some time
now, giving it an "unfair" advantage against the not so common
architectures.

The code wast put through various tests and benchmarks in a user-space
testbench, testing its correctness (also via qemu) for 32bit vs. 64bit
and big vs. little endian MIPS.

http://mosquito.dyndns.tv/freesvn/trunk/linux/twofish-mips/

Also the same code backported to a 2.6.39 kernel (64bit) has been
working flawlessly on my loongson-2f machine (with a twofish dm-crypt
root) for a few weeks now.

Performance gain for the pure crypto code in 32-bit mode is about 15% on
both Ingenic Xburst and Loongson-2f.  With 64-bit it is 24-29%, as the C
code suffers from 32->64 bit type conversions inserted by gcc.  The code
uses less unrolling than the C version, and should be smaller by at
least a factor of 8.  Full results in file Benchres.txt at the SVN URL
given above.=20=20

Signed-off-by: David K=C3=BChling <dvdkhlng@gmx.de>
=2D--
 arch/mips/Kbuild                    |    2 +
 arch/mips/crypto/Makefile           |    7 +
 arch/mips/crypto/twofish-mips-asm.S |  332 +++++++++++++++++++++++++++++++=
++++
 arch/mips/crypto/twofish_glue.c     |   97 ++++++++++
 arch/mips/kernel/asm-offsets.c      |    8 +
 crypto/Kconfig                      |   16 ++
 6 files changed, 462 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/crypto/Makefile
 create mode 100644 arch/mips/crypto/twofish-mips-asm.S
 create mode 100644 arch/mips/crypto/twofish_glue.c

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 7dd65cf..fc88443 100644
=2D-- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,3 +17,5 @@ obj- :=3D $(platform-)
 obj-y +=3D kernel/
 obj-y +=3D mm/
 obj-y +=3D math-emu/
+
+obj-y +=3D crypto/
diff --git a/arch/mips/crypto/Makefile b/arch/mips/crypto/Makefile
new file mode 100644
index 0000000..6069354
=2D-- /dev/null
+++ b/arch/mips/crypto/Makefile
@@ -0,0 +1,7 @@
+#
+# Arch-specific CryptoAPI modules.
+#
+
+obj-$(CONFIG_CRYPTO_TWOFISH_MIPS) +=3D twofish-mips.o
+
+twofish-mips-y :=3D twofish-mips-asm.o twofish_glue.o
diff --git a/arch/mips/crypto/twofish-mips-asm.S b/arch/mips/crypto/twofish=
-mips-asm.S
new file mode 100644
index 0000000..dc5ce52
=2D-- /dev/null
+++ b/arch/mips/crypto/twofish-mips-asm.S
@@ -0,0 +1,331 @@
+/*
+ * Copyright (C) 2011 David Kuehling <dvdkhlng AT gmx DOT de>
+ *
+ * (Dervived from twofish-x86_64-asm_64.S by Joachim Fritschi)
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+/*
+ * In this file we reference MIPS registers only via symbolic names aN tN,
+ * taN etc. which makes it work with any of o32/n32/o64/n64 ABIs.  Some
+ * additonal #ifdef'ing is used for handling 32 vs. 64-bit and little
+ * vs. big-endian issues.
+ */
+
+.file "twofish-mips-asm.S"
+.text
+
+#include <asm/regdef.h>
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+
+#define a_offset	0
+#define b_offset	4
+#define c_offset	8
+#define d_offset	12
+
+/* Structure of the crypto context struct */
+
+#define s0offs	0	/* S0 Array 256 Words each */
+#define s1offs	1024	/* S1 Array */
+#define s2offs	2048	/* S2 Array */
+#define s3offs	3072	/* S3 Array */
+#define woffs	4096	/* 8 whitening keys (word) */
+#define koffs	4128	/* key 1-32 ( word ) */
+
+/*
+ * Endianess handling
+ */
+
+#if MIPSEL
+#  define LITTLEENDIAN 1
+#elif MIPSEB
+#  define BIGENDIAN 1
+#else
+#  error "endianess undefined"
+#endif
+
+#ifdef LITTLEENDIAN
+#  define le32_fromto_cpu(a)
+#else
+	/* actually we could pair two conversions for better scheduling */
+#  define le32_fromto_cpu(a)			\
+	sll	t8, a, 24 ;			\
+	srl	t9, a, 24 ;			\
+	srl	ta3, a, 8 ;			\
+	and	a, 0xff00   ;			\
+	or	t8, t9    ;			\
+	sll	a, a, 8    ;			\
+	and	ta3, 0xff00 ;			\
+	or	a, ta3	    ;			\
+	or	a, t8	    ;
+#endif
+
+
+ /* perform input whitening of 16-byte block */
+#define input_whitening(a,b,c,d,context)	\
+	lw	ta2, woffs+a_offset(context)	; \
+	lw	ta3, woffs+b_offset(context)	; \
+	lw	t8, woffs+c_offset(context)	; \
+	lw	t9, woffs+d_offset(context)	; \
+	xor	a, ta2				; \
+	xor	b, ta3				; \
+	xor	c, t8				; \
+	xor	d, t9
+
+
+ /* perform output whitening of 16-byte block */
+#define output_whitening(a,b,c,d,context)	\
+	lw	ta2, woffs+16+a_offset(context)	; \
+	lw	ta3, woffs+16+b_offset(context)	; \
+	lw	t8, woffs+16+c_offset(context)	; \
+	lw	t9, woffs+16+d_offset(context)	; \
+	xor	a, ta2				; \
+	xor	b, ta3				; \
+	xor	c, t8				; \
+	xor	d, t9
+
+/*
+ * a input register containing a
+ * b input register containing b
+ * c input register containing c
+ * d input register containing d
+ * koffs: koffs(a3) is the element in the 'k' array to use
+ */
+#define encrypt_round(a,b,c,d,koffs)				\
+	sll	ta0, b, 2					; \
+	sll	ta1, a, 2					; \
+	andi	ta0, 0x3FC					; \
+	andi	ta1, 0x3FC					; \
+	PTR_ADDU	ta0, a0					; \
+	PTR_ADDU	ta1, a0					; \
+	lw	t8, s1offs(ta0)					; \
+	lw	t9, s0offs(ta1)					; \
+								; \
+	srl	ta2, b, 8-2					; \
+	srl	ta3, a, 8-2					; \
+	andi	ta2, 0x3FC					; \
+	andi	ta3, 0x3FC					; \
+	PTR_ADDU	ta2, a0					; \
+	PTR_ADDU	ta3, a0					; \
+	lw	ta2, s2offs(ta2)				; \
+	lw	ta3, s1offs(ta3)				; \
+								; \
+	srl	ta0, b, 16-2					; \
+	srl	ta1, a, 16-2					; \
+	andi	ta0, 0x3FC					; \
+	andi	ta1, 0x3FC					; \
+	PTR_ADDU	ta0, a0					; \
+	PTR_ADDU	ta1, a0					; \
+	lw	ta0, s3offs(ta0)				; \
+	lw	ta1, s2offs(ta1)				; \
+								; \
+	srl	v0, b, 24-2					; \
+	srl	v1, a, 24-2					; \
+	andi	v0, 0x3FC					; \
+	andi	v1, 0x3FC					; \
+	PTR_ADDU	v0, a0					; \
+	PTR_ADDU	v1, a0					; \
+	xor	t8, ta2						; \
+	xor	t9, ta3						; \
+	lw	v0, s0offs(v0)					; \
+	xor	t8, ta0						; \
+	xor	t9, ta1						; \
+	lw	v1, s3offs(v1)					; \
+								; \
+	/* rotate d left by 1, interleaved with xoring, and	\
+	  loading from the 'k' array */				\
+	sll	ta0, d, 1					; \
+	xor	t8, v0						; \
+	lw	ta2, 0+koffs(a3)				; \
+	srl	d, 32-1						; \
+	xor	t9, v1						; \
+	lw	ta3, 4+koffs(a3)				; \
+	or	d, ta0						; \
+								; \
+	addu	t9, t8						; \
+	addu	v0, t8, ta3					; \
+	addu	v1, t9, ta2					; \
+	addu	v0, t9						; \
+	xor	c, v1						; \
+	xor	d, v0						; \
+								; \
+	srl	ta3, c, 1	/* rotate c right 1 */		; \
+	sll	ta2, c, 32-1	/* ... rotate */		; \
+	or	c, ta2, ta3	/* ... rotate */		; \
+
+/*
+ * a input register containing a
+ * b input register containing b
+ * c input register containing c
+ * d input register containing d
+ * koffs: koffs(a3) is the element in the 'k' array to use
+ */
+#define decrypt_round(a,b,c,d,koffs)				\
+	sll	ta0, a, 2					; \
+	sll	ta1, b, 2					; \
+	andi	ta0, 0x3FC					; \
+	andi	ta1, 0x3FC					; \
+	PTR_ADDU	ta0, a0					; \
+	PTR_ADDU	ta1, a0					; \
+	lw	t9, s0offs(ta0)					; \
+	lw	t8, s1offs(ta1)					; \
+								; \
+	srl	ta2, a, 8-2					; \
+	srl	ta3, b, 8-2					; \
+	andi	ta2, 0x3FC					; \
+	andi	ta3, 0x3FC					; \
+	PTR_ADDU	ta2, a0					; \
+	PTR_ADDU	ta3, a0					; \
+	lw	ta2, s1offs(ta2)				; \
+	lw	ta3, s2offs(ta3)				; \
+								; \
+	srl	ta0, a, 16-2					; \
+	srl	ta1, b, 16-2					; \
+	andi	ta1, 0x3FC					; \
+	andi	ta0, 0x3FC					; \
+	PTR_ADDU	ta0, a0					; \
+	PTR_ADDU	ta1, a0					; \
+	lw	ta0, s2offs(ta0)				; \
+	lw	ta1, s3offs(ta1)				; \
+								; \
+	srl	v0, a, 24-2					; \
+	srl	v1, b, 24-2					; \
+	andi	v0, 0x3FC					; \
+	andi	v1, 0x3FC					; \
+	PTR_ADDU	v0, a0					; \
+	PTR_ADDU	v1, a0					; \
+	xor	t9, ta2						; \
+	xor	t8, ta3						; \
+	lw	v0, s3offs(v0)					; \
+	xor	t9, ta0						; \
+	xor	t8, ta1						; \
+	lw	v1, s0offs(v1)					; \
+								; \
+	/* rotate c left by 1, interleaved with xoring, and	\
+	  loading from the 'k' array */				\
+	sll	ta0, c, 1					; \
+	xor	t9, v0						; \
+	lw	ta2, 0+koffs(a3)				; \
+	srl	c, 32-1						; \
+	xor	t8, v1						; \
+	lw	ta3, 4+koffs(a3)				; \
+	or	c, ta0						; \
+								; \
+	addu	t9, t8						; \
+	addu	v0, t8, ta3					; \
+	addu	v1, t9, ta2					; \
+	addu	v0, t9						; \
+	xor	c, v1						; \
+	xor	d, v0						; \
+								; \
+	srl	ta3, d, 1	/* rotate d right by 1 */	; \
+	sll	ta2, d, 32-1	/* ...rotate */			; \
+	or	d, ta2, ta3	/* ...rotate */			; \
+
+
+.global twofish_enc_blk
+.global twofish_dec_blk
+
+twofish_enc_blk:
+	/* a0 contains the crypto tfm address */
+	/* a1 contains the output address */
+	/* a2 contains the input address */
+
+	PTR_ADDU	a0, crypto_tfm_ctx_offset	/* set ctx address */
+
+	/* if we turn this into 64-bit ops, we get endianess issues on
+	   big-endian mips, plus alignment problems */
+	lw	t0, a_offset(a2)
+	lw	t1, b_offset(a2)
+	lw	t2, c_offset(a2)
+	lw	t3, d_offset(a2)
+
+	le32_fromto_cpu(t0)
+	le32_fromto_cpu(t1)
+	le32_fromto_cpu(t2)
+	le32_fromto_cpu(t3)
+
+	input_whitening(t0,t1,t2,t3,a0)
+
+	/* If we unrolled this loop, we gain < 5% performance, but function
+	   size reaches almost 4kB, vs. 0.5kB as implemented below.  During
+	   loop a3 points into the 'k' array, 'a2' denotes the position in
+	   the k array where the loop should exit.  'a3' is incremented at the
+	   start of loop, to help branch prediction and scheduling */
+	PTR_ADDU	a3, a0, koffs
+	PTR_ADDU	a2, a0, koffs+8*16
+1:	PTR_ADDU	a3, a3, 16
+	encrypt_round(t0,t1,t2,t3,-16);
+	encrypt_round(t2,t3,t0,t1,-8);
+	bne	a2, a3, 1b
+
+	output_whitening(t2,t3,t0,t1,a0)
+
+	le32_fromto_cpu(t2)
+	le32_fromto_cpu(t3)
+	le32_fromto_cpu(t0)
+	le32_fromto_cpu(t1)
+
+	sw	t2, a_offset(a1)
+	sw	t3, b_offset(a1)
+	sw	t0, c_offset(a1)
+	sw	t1, d_offset(a1)
+
+	jr	ra
+
+twofish_dec_blk:
+	/* a0 contains the crypto tfm address */
+	/* a1 contains the output address */
+	/* a2 contains the input address */
+
+	PTR_ADDU	a0, crypto_tfm_ctx_offset	/* set ctx address */
+
+	/* if we turned this into 64-bit ops, we get endianess issues on
+	   big-endian mips, plus alignment problems */
+	lw	t0, a_offset(a2)
+	lw	t1, b_offset(a2)
+	lw	t2, c_offset(a2)
+	lw	t3, d_offset(a2)
+
+	le32_fromto_cpu(t0)
+	le32_fromto_cpu(t1)
+	le32_fromto_cpu(t2)
+	le32_fromto_cpu(t3)
+
+	output_whitening(t0,t1,t2,t3,a0)
+
+	/* for details about loop below see comment in twofish_enc_blk */
+	PTR_ADDU	a3, a0, koffs+16*8
+	PTR_ADDU	a2, a0, koffs
+1:	PTR_ADDU	a3, a3, -16
+	decrypt_round(t0,t1,t2,t3,8);
+	decrypt_round(t2,t3,t0,t1,0);
+	bne	a2, a3, 1b
+
+	input_whitening(t2,t3,t0,t1,a0)
+
+	le32_fromto_cpu(t2)
+	le32_fromto_cpu(t3)
+	le32_fromto_cpu(t0)
+	le32_fromto_cpu(t1)
+
+	sw	t2, a_offset(a1)
+	sw	t3, b_offset(a1)
+	sw	t0, c_offset(a1)
+	sw	t1, d_offset(a1)
+
+	jr	ra
diff --git a/arch/mips/crypto/twofish_glue.c b/arch/mips/crypto/twofish_glu=
e.c
new file mode 100644
index 0000000..cefaf8b
=2D-- /dev/null
+++ b/arch/mips/crypto/twofish_glue.c
@@ -0,0 +1,97 @@
+/*
+ * Glue Code for assembler optimized version of TWOFISH
+ *
+ * Originally Twofish for GPG
+ * By Matthew Skala <mskala@ansuz.sooke.bc.ca>, July 26, 1998
+ * 256-bit key length added March 20, 1999
+ * Some modifications to reduce the text size by Werner Koch, April, 1998
+ * Ported to the kerneli patch by Marc Mutz <Marc@Mutz.com>
+ * Ported to CryptoAPI by Colin Slater <hoho@tacomeat.net>
+ *
+ * The original author has disclaimed all copyright interest in this
+ * code and thus put it in the public domain. The subsequent authors
+ * have put this under the GNU General Public License.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ * USA
+ *
+ * This code is a "clean room" implementation, written from the paper
+ * _Twofish: A 128-Bit Block Cipher_ by Bruce Schneier, John Kelsey,
+ * Doug Whiting, David Wagner, Chris Hall, and Niels Ferguson, available
+ * through http://www.counterpane.com/twofish.html
+ *
+ * For background information on multiplication in finite fields, used for
+ * the matrix operations in the key schedule, see the book _Contemporary
+ * Abstract Algebra_ by Joseph A. Gallian, especially chapter 22 in the
+ * Third Edition.
+ */
+
+#include <crypto/twofish.h>
+#include <linux/crypto.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+asmlinkage void twofish_enc_blk(struct crypto_tfm *tfm, u8 *dst, const u8 =
*src);
+asmlinkage void twofish_dec_blk(struct crypto_tfm *tfm, u8 *dst, const u8 =
*src);
+
+static void twofish_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	twofish_enc_blk(tfm, dst, src);
+}
+
+static void twofish_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+{
+	twofish_dec_blk(tfm, dst, src);
+}
+
+static struct crypto_alg alg =3D {
+	.cra_name		=3D	"twofish",
+	.cra_driver_name	=3D	"twofish-asm",
+	.cra_priority		=3D	200,
+	.cra_flags		=3D	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=3D	TF_BLOCK_SIZE,
+	.cra_ctxsize		=3D	sizeof(struct twofish_ctx),
+	.cra_alignmask		=3D	3,
+	.cra_module		=3D	THIS_MODULE,
+	.cra_list		=3D	LIST_HEAD_INIT(alg.cra_list),
+	.cra_u			=3D	{
+		.cipher =3D {
+			.cia_min_keysize	=3D	TF_MIN_KEY_SIZE,
+			.cia_max_keysize	=3D	TF_MAX_KEY_SIZE,
+			.cia_setkey		=3D	twofish_setkey,
+			.cia_encrypt		=3D	twofish_encrypt,
+			.cia_decrypt		=3D	twofish_decrypt
+		}
+	}
+};
+
+static int __init init(void)
+{
+	return crypto_register_alg(&alg);
+}
+
+static void __exit fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION ("Twofish Cipher Algorithm, asm optimized");
+MODULE_ALIAS("twofish");
+MODULE_ALIAS("twofish-asm");
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 6b30fb2..9d91a6d 100644
=2D-- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kbuild.h>
 #include <linux/suspend.h>
+#include <linux/crypto.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
=20
@@ -339,3 +340,10 @@ void output_pbe_defines(void)
 	BLANK();
 }
 #endif
+
+void output_crypto_defines(void)
+{
+	COMMENT(" Linux crypto API offsets. ");
+	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
+	BLANK();
+}
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 527a857..4586715 100644
=2D-- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -856,6 +856,22 @@ config CRYPTO_TWOFISH_X86_64_3WAY
 	  See also:
 	  <http://www.schneier.com/twofish.html>
=20
+config CRYPTO_TWOFISH_MIPS
+	tristate "Twofish cipher algorithm (MIPS)"
+	depends on MIPS
+	select CRYPTO_ALGAPI
+	select CRYPTO_TWOFISH_COMMON
+	help
+	  Twofish cipher algorithm (MIPS).
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  See also:
+	  <http://www.schneier.com/twofish.html>
+
 comment "Compression"
=20
 config CRYPTO_DEFLATE
=2D-=20
1.7.5.4

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7FqU8ACgkQfe9TI8F0fUBL/gCdEwRq70IFwDomJ+9sT5GG1Rnh
DD0AoITv3wKSY7DyTxfakqvVSw78viqt
=4DxA
-----END PGP SIGNATURE-----
--=-=-=--
