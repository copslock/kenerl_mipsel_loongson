Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 02:09:10 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:63263 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133457AbWBCCFA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 02:05:00 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 3 Feb 2006 02:10:13 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 386B22038D;
	Fri,  3 Feb 2006 11:10:12 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 248F91F0C0;
	Fri,  3 Feb 2006 11:10:12 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k132AC4D022295;
	Fri, 3 Feb 2006 11:10:12 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 03 Feb 2006 11:10:12 +0900 (JST)
Message-Id: <20060203.111012.130238823.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060202172434.GE17352@linux-mips.org>
References: <20060202165656.GC17352@linux-mips.org>
	<20060203.020428.59032357.anemo@mba.ocn.ne.jp>
	<20060202172434.GE17352@linux-mips.org>
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
X-archive-position: 10318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 2 Feb 2006 17:24:34 +0000, Ralf Baechle <ralf@linux-mips.org> said:
ralf> It should be ok for any R4000-style status register.  I'm not
ralf> sure about R3000 - but I'm sure Maciej will know.  If he agrees
ralf> I'd say let's go for it.

It should be OK for all CPU while STI/CLI/KMODE macro always clear
bit[4:1] of status register.  Could you confirm, Maciej ?

So here is a patch against current GIT.


Always clear bit[4:1] of status register.  This makes interrupt.h TX49
bug proof.  TX49XX_MFC0_WAR is not needed anymore.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/interrupt.h b/include/asm-mips/interrupt.h
index 951ee7a..7743487 100644
--- a/include/asm-mips/interrupt.h
+++ b/include/asm-mips/interrupt.h
@@ -13,7 +13,6 @@
 
 #include <linux/config.h>
 #include <asm/hazards.h>
-#include <asm/war.h>
 
 __asm__ (
 	"	.macro	local_irq_enable				\n"
@@ -48,6 +47,17 @@ static inline void local_irq_enable(void
  * R4000/R4400 need three nops, the R4600 two nops and the R10000 needs
  * no nops at all.
  */
+/*
+ * For TX49, operating only IE bit is not enough.
+ *
+ * If mfc0 $12 follows store and the mfc0 is last instruction of a
+ * page and fetching the next instruction causes TLB miss, the result
+ * of the mfc0 might wrongly contain EXL bit.
+ *
+ * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
+ *
+ * Workaround: mask EXL bit of the result or place a nop before mfc0.
+ */
 __asm__ (
 	"	.macro	local_irq_disable\n"
 	"	.set	push						\n"
@@ -56,13 +66,8 @@ __asm__ (
 	"	di							\n"
 #else
 	"	mfc0	$1,$12						\n"
-#if TX49XX_MFC0_WAR && defined(MODULE)
-	"	ori	$1,3						\n"
-	"	xori	$1,3						\n"
-#else
-	"	ori	$1,1						\n"
-	"	xori	$1,1						\n"
-#endif
+	"	ori	$1,0x1f						\n"
+	"	xori	$1,0x1f						\n"
 	"	.set	noreorder					\n"
 	"	mtc0	$1,$12						\n"
 #endif
@@ -102,13 +107,8 @@ __asm__ (
 	"	andi	\\result, 1					\n"
 #else
 	"	mfc0	\\result, $12					\n"
-#if TX49XX_MFC0_WAR && defined(MODULE)
-	"	ori	$1, \\result, 3					\n"
-	"	xori	$1, 3						\n"
-#else
-	"	ori	$1, \\result, 1					\n"
-	"	xori	$1, 1						\n"
-#endif
+	"	ori	$1, \\result, 0x1f				\n"
+	"	xori	$1, 0x1f					\n"
 	"	.set	noreorder					\n"
 	"	mtc0	$1, $12						\n"
 #endif
@@ -147,13 +147,8 @@ __asm__ (
 #else
 	"	mfc0	$1, $12						\n"
 	"	andi	\\flags, 1					\n"
-#if TX49XX_MFC0_WAR && defined(MODULE)
-	"	ori	$1, 3						\n"
-	"	xori	$1, 3						\n"
-#else
-	"	ori	$1, 1						\n"
-	"	xori	$1, 1						\n"
-#endif
+	"	ori	$1, 0x1f					\n"
+	"	xori	$1, 0x1f					\n"
 	"	or	\\flags, $1					\n"
 	"	mtc0	\\flags, $12					\n"
 #endif
diff --git a/include/asm-mips/war.h b/include/asm-mips/war.h
index 859520a..229afaa 100644
--- a/include/asm-mips/war.h
+++ b/include/asm-mips/war.h
@@ -169,19 +169,6 @@
 #endif
 
 /*
- * If mfc0 $12 follows store and the mfc0 is last instruction of a
- * page and fetching the next instruction causes TLB miss, the result
- * of the mfc0 might wrongly contain EXL bit.
- *
- * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
- *
- * Workaround: mask EXL bit of the result or place a nop before mfc0.
- */
-#ifdef CONFIG_CPU_TX49XX
-#define TX49XX_MFC0_WAR 1
-#endif
-
-/*
  * On the RM9000 there is a problem which makes the CreateDirtyExclusive
  * cache operation unusable on SMP systems.
  */
