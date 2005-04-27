Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2005 06:36:47 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:14101
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224863AbVD0Fg2>; Wed, 27 Apr 2005 06:36:28 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 27 Apr 2005 05:36:26 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id D6ACE1F2C3;
	Wed, 27 Apr 2005 14:36:22 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C15481D6CA;
	Wed, 27 Apr 2005 14:36:22 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3R5aMoj034147;
	Wed, 27 Apr 2005 14:36:22 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 27 Apr 2005 14:36:22 +0900 (JST)
Message-Id: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: preempt safe fpu-emulator
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  Here is a patch to make the fpu-emulator preempt-safe.  It would
be SMP-safe also.

The 'ieee754_csr' global variable is removed.  Now the 'ieee754_csr'
is an alias of current->thread.fpu.soft.fcr31.  While the fpu-emulator
uses different mapping for RM bits (FPU_CSR_Rm vs. IEEE754_Rm), RM
bits are converted before (and after) calling of cop1Emulate().  If we
adjusted IEEE754_Rm to match with FPU_CSR_Rm, we can remove ieee_rm[]
and mips_rm[].  Should we do it?

With this patch, whole fpu-emulator can be run without disabling
preempt.  I will post a patch to fix preemption issue soon.

diff -u linux-mips/arch/mips/math-emu/cp1emu.c linux/arch/mips/math-emu/cp1emu.c
--- linux-mips/arch/mips/math-emu/cp1emu.c	2005-03-04 10:19:33.000000000 +0900
+++ linux/arch/mips/math-emu/cp1emu.c	2005-04-27 10:45:08.000000000 +0900
@@ -79,7 +79,17 @@
 
 /* Convert Mips rounding mode (0..3) to IEEE library modes. */
 static const unsigned char ieee_rm[4] = {
-	IEEE754_RN, IEEE754_RZ, IEEE754_RU, IEEE754_RD
+	[FPU_CSR_RN] = IEEE754_RN,
+	[FPU_CSR_RZ] = IEEE754_RZ,
+	[FPU_CSR_RU] = IEEE754_RU,
+	[FPU_CSR_RD] = IEEE754_RD,
+};
+/* Convert IEEE library modes to Mips rounding mode (0..3). */
+static const unsigned char mips_rm[4] = {
+	[IEEE754_RN] = FPU_CSR_RN,
+	[IEEE754_RZ] = FPU_CSR_RZ,
+	[IEEE754_RD] = FPU_CSR_RD,
+	[IEEE754_RU] = FPU_CSR_RU,
 };
 
 #if __mips >= 4
@@ -368,6 +378,7 @@
 			}
 			if (MIPSInst_RD(ir) == FPCREG_CSR) {
 				value = ctx->fcr31;
+				value = (value & ~0x3) | mips_rm[value & 0x3];
 #ifdef CSRTRACE
 				printk("%p gpr[%d]<-csr=%08x\n",
 					(void *) (xcp->cp0_epc),
@@ -400,11 +411,10 @@
 					(void *) (xcp->cp0_epc),
 					MIPSInst_RT(ir), value);
 #endif
-				ctx->fcr31 = value;
-				/* copy new rounding mode and
-				   flush bit to ieee library state! */
-				ieee754_csr.nod = (ctx->fcr31 & 0x1000000) != 0;
-				ieee754_csr.rm = ieee_rm[value & 0x3];
+				value &= (FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
+				ctx->fcr31 &= ~(FPU_CSR_FLUSH | FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
+				/* convert to ieee library modes */
+				ctx->fcr31 |= (value & ~0x3) | ieee_rm[value & 0x3];
 			}
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				return SIGFPE;
@@ -570,7 +580,7 @@
 static ieee754##p fpemu_##p##_##name (ieee754##p r, ieee754##p s, \
     ieee754##p t) \
 { \
-	struct ieee754_csr ieee754_csr_save; \
+	struct _ieee754_csr ieee754_csr_save; \
 	s = f1 (s, t); \
 	ieee754_csr_save = ieee754_csr; \
 	s = f2 (s, r); \
@@ -699,8 +709,6 @@
 				rcsr |= FPU_CSR_INV_X | FPU_CSR_INV_S;
 
 			ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
-			if (ieee754_csr.nod)
-				ctx->fcr31 |= 0x1000000;
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
 				/*printk ("SIGFPE: fpu csr = %08x\n",
 				   ctx->fcr31); */
@@ -1297,12 +1305,17 @@
 		if (insn == 0)
 			xcp->cp0_epc += 4;	/* skip nops */
 		else {
-			/* Update ieee754_csr. Only relevant if we have a
-			   h/w FPU */
-			ieee754_csr.nod = (ctx->fcr31 & 0x1000000) != 0;
-			ieee754_csr.rm = ieee_rm[ctx->fcr31 & 0x3];
-			ieee754_csr.cx = (ctx->fcr31 >> 12) & 0x1f;
+			/*
+			 * The 'ieee754_csr' is an alias of
+			 * ctx->fcr31.  No need to copy ctx->fcr31 to
+			 * ieee754_csr.  But ieee754_csr.rm is ieee
+			 * library modes. (not mips rounding mode)
+			 */
+			/* convert to ieee library modes */
+			ieee754_csr.rm = ieee_rm[ieee754_csr.rm];
 			sig = cop1Emulate(xcp, ctx);
+			/* revert to mips rounding mode */
+			ieee754_csr.rm = mips_rm[ieee754_csr.rm];
 		}
 
 		if (cpu_has_fpu)
diff -u linux-mips/arch/mips/math-emu/dp_sqrt.c linux/arch/mips/math-emu/dp_sqrt.c
--- linux-mips/arch/mips/math-emu/dp_sqrt.c	2005-01-31 11:05:18.000000000 +0900
+++ linux/arch/mips/math-emu/dp_sqrt.c	2005-04-27 10:04:18.000000000 +0900
@@ -37,7 +37,7 @@
 
 ieee754dp ieee754dp_sqrt(ieee754dp x)
 {
-	struct ieee754_csr oldcsr;
+	struct _ieee754_csr oldcsr;
 	ieee754dp y, z, t;
 	unsigned scalx, yh;
 	COMPXDP;
diff -u linux-mips/arch/mips/math-emu/ieee754.c linux/arch/mips/math-emu/ieee754.c
--- linux-mips/arch/mips/math-emu/ieee754.c	2005-01-31 11:05:18.000000000 +0900
+++ linux/arch/mips/math-emu/ieee754.c	2005-04-26 18:24:27.000000000 +0900
@@ -50,10 +50,6 @@
 	"SNaN",
 };
 
-/* the control status register
-*/
-struct ieee754_csr ieee754_csr;
-
 /* special constants
 */
 
diff -u linux-mips/arch/mips/math-emu/ieee754.h linux/arch/mips/math-emu/ieee754.h
--- linux-mips/arch/mips/math-emu/ieee754.h	2005-01-31 11:05:18.000000000 +0900
+++ linux/arch/mips/math-emu/ieee754.h	2005-04-27 10:04:57.000000000 +0900
@@ -35,6 +35,7 @@
 #ifdef __KERNEL__
 /* Going from Algorithmics to Linux native environment, add this */
 #include <linux/types.h>
+#include <linux/sched.h>	/* for 'current' */
 
 /*
  * Not very pretty, but the Linux kernel's normal va_list definition
@@ -323,15 +324,28 @@
 
 /* the control status register
 */
-struct ieee754_csr {
-	unsigned pad:13;
+struct _ieee754_csr {
+#if (defined(BYTE_ORDER) && BYTE_ORDER == BIG_ENDIAN) || defined(__MIPSEB__)
+	unsigned pad0:7;
 	unsigned nod:1;		/* set 1 for no denormalised numbers */
-	unsigned cx:5;		/* exceptions this operation */
+	unsigned c:1;		/* condition */
+	unsigned pad1:5;
+	unsigned cx:6;		/* exceptions this operation */
 	unsigned mx:5;		/* exception enable  mask */
 	unsigned sx:5;		/* exceptions total */
 	unsigned rm:2;		/* current rounding mode */
+#else
+	unsigned rm:2;		/* current rounding mode */
+	unsigned sx:5;		/* exceptions total */
+	unsigned mx:5;		/* exception enable  mask */
+	unsigned cx:6;		/* exceptions this operation */
+	unsigned pad1:5;
+	unsigned c:1;		/* condition */
+	unsigned nod:1;		/* set 1 for no denormalised numbers */
+	unsigned pad0:7;
+#endif
 };
-extern struct ieee754_csr ieee754_csr;
+#define ieee754_csr (*(struct _ieee754_csr *)(&current->thread.fpu.soft.fcr31))
 
 static __inline unsigned ieee754_getrm(void)
 {
