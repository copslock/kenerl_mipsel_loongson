Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 11:03:17 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:17937
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224907AbUJFKDM>; Wed, 6 Oct 2004 11:03:12 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 6 Oct 2004 10:03:09 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id CBAE5239E36; Wed,  6 Oct 2004 18:44:04 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i969fI8G026099;
	Wed, 6 Oct 2004 18:41:19 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 06 Oct 2004 18:40:14 +0900 (JST)
Message-Id: <20041006.184014.25481149.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
References: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 06 Oct 2004 10:19:20 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> Also, there is another problem in the math-emu.  While math-emu
anemo> is not reentrant, it will not work properly if a process lose
anemo> ownership in the math-emu and another process uses the
anemo> math-emu.  One possible fix is to save/restore ieee754_csr on
anemo> get_user/put_user.  I will post a patch later.

Here it is.  Can be applied bath 2.4 and 2.6.

--- linux-mips/arch/mips/math-emu/cp1emu.c	Wed Sep  1 10:47:21 2004
+++ linux/arch/mips/math-emu/cp1emu.c	Wed Oct  6 12:34:43 2004
@@ -51,6 +51,24 @@
 #include "ieee754.h"
 #include "dsemul.h"
 
+#define math_put_user(x, ptr) \
+({ \
+	long math_pu_err; \
+	struct ieee754_csr pu_csr_save; \
+	pu_csr_save = ieee754_csr; \
+	math_pu_err = put_user(x, ptr); \
+	ieee754_csr = pu_csr_save; \
+	math_pu_err; \
+})
+#define math_get_user(x, ptr) \
+({ \
+	long math_gu_err; \
+	struct ieee754_csr gu_csr_save; \
+	gu_csr_save = ieee754_csr; \
+	math_gu_err = get_user(x, ptr); \
+	ieee754_csr = gu_csr_save; \
+	math_gu_err; \
+})
 /* Strap kernel emulator for full MIPS IV emulation */
 
 #ifdef __mips
@@ -199,7 +217,7 @@
 	vaddr_t emulpc, contpc;
 	unsigned int cond;
 
-	if (get_user(ir, (mips_instruction *) xcp->cp0_epc)) {
+	if (math_get_user(ir, (mips_instruction *) xcp->cp0_epc)) {
 		fpuemuprivate.stats.errors++;
 		return SIGBUS;
 	}
@@ -230,7 +248,7 @@
 #endif
 			return SIGILL;
 		}
-		if (get_user(ir, (mips_instruction *) emulpc)) {
+		if (math_get_user(ir, (mips_instruction *) emulpc)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -254,7 +272,7 @@
 		u64 val;
 
 		fpuemuprivate.stats.loads++;
-		if (get_user(val, va)) {
+		if (math_get_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -269,7 +287,7 @@
 
 		fpuemuprivate.stats.stores++;
 		DIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (math_put_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -283,7 +301,7 @@
 		u32 val;
 
 		fpuemuprivate.stats.loads++;
-		if (get_user(val, va)) {
+		if (math_get_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -310,7 +328,7 @@
 		}
 #endif
 		SIFROMREG(val, MIPSInst_RT(ir));
-		if (put_user(val, va)) {
+		if (math_put_user(val, va)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}
@@ -449,7 +467,7 @@
 					(xcp->cp0_epc +
 					(MIPSInst_SIMM(ir) << 2));
 
-				if (get_user(ir, (mips_instruction *)
+				if (math_get_user(ir, (mips_instruction *)
 						REG_TO_VA xcp->cp0_epc)) {
 					fpuemuprivate.stats.errors++;
 					return SIGBUS;
@@ -632,7 +650,7 @@
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			fpuemuprivate.stats.loads++;
-			if (get_user(val, va)) {
+			if (math_get_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -662,7 +680,7 @@
 #endif
 
 			SIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (math_put_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -728,7 +746,7 @@
 				xcp->regs[MIPSInst_FT(ir)]);
 
 			fpuemuprivate.stats.loads++;
-			if (get_user(val, va)) {
+			if (math_get_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -741,7 +759,7 @@
 
 			fpuemuprivate.stats.stores++;
 			DIFROMREG(val, MIPSInst_FS(ir));
-			if (put_user(val, va)) {
+			if (math_put_user(val, va)) {
 				fpuemuprivate.stats.errors++;
 				return SIGBUS;
 			}
@@ -1290,7 +1308,7 @@
 	do {
 		prevepc = xcp->cp0_epc;
 
-		if (get_user(insn, (mips_instruction *) xcp->cp0_epc)) {
+		if (math_get_user(insn, (mips_instruction *) xcp->cp0_epc)) {
 			fpuemuprivate.stats.errors++;
 			return SIGBUS;
 		}

---
Atsushi Nemoto
