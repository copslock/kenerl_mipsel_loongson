Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 16:29:31 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:42188 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3465640AbWBBQ3N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 16:29:13 +0000
Received: from localhost (p4005-ipad24funabasi.chiba.ocn.ne.jp [220.104.82.5])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5480D16D2; Fri,  3 Feb 2006 01:34:21 +0900 (JST)
Date:	Fri, 03 Feb 2006 01:34:01 +0900 (JST)
Message-Id: <20060203.013401.41198517.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] TX49 MFC0 bug workaround
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If mfc0 $12 follows store and the mfc0 is last instruction of a
page and fetching the next instruction causes TLB miss, the result
of the mfc0 might wrongly contain EXL bit.

ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008

Workaround: mask EXL bit of the result or place a nop before mfc0.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/interrupt.h b/include/asm-mips/interrupt.h
index 0da5818..951ee7a 100644
--- a/include/asm-mips/interrupt.h
+++ b/include/asm-mips/interrupt.h
@@ -13,6 +13,7 @@
 
 #include <linux/config.h>
 #include <asm/hazards.h>
+#include <asm/war.h>
 
 __asm__ (
 	"	.macro	local_irq_enable				\n"
@@ -55,8 +56,13 @@ __asm__ (
 	"	di							\n"
 #else
 	"	mfc0	$1,$12						\n"
+#if TX49XX_MFC0_WAR && defined(MODULE)
+	"	ori	$1,3						\n"
+	"	xori	$1,3						\n"
+#else
 	"	ori	$1,1						\n"
 	"	xori	$1,1						\n"
+#endif
 	"	.set	noreorder					\n"
 	"	mtc0	$1,$12						\n"
 #endif
@@ -96,8 +102,13 @@ __asm__ (
 	"	andi	\\result, 1					\n"
 #else
 	"	mfc0	\\result, $12					\n"
+#if TX49XX_MFC0_WAR && defined(MODULE)
+	"	ori	$1, \\result, 3					\n"
+	"	xori	$1, 3						\n"
+#else
 	"	ori	$1, \\result, 1					\n"
 	"	xori	$1, 1						\n"
+#endif
 	"	.set	noreorder					\n"
 	"	mtc0	$1, $12						\n"
 #endif
@@ -136,8 +147,13 @@ __asm__ (
 #else
 	"	mfc0	$1, $12						\n"
 	"	andi	\\flags, 1					\n"
+#if TX49XX_MFC0_WAR && defined(MODULE)
+	"	ori	$1, 3						\n"
+	"	xori	$1, 3						\n"
+#else
 	"	ori	$1, 1						\n"
 	"	xori	$1, 1						\n"
+#endif
 	"	or	\\flags, $1					\n"
 	"	mtc0	\\flags, $12					\n"
 #endif
diff --git a/include/asm-mips/war.h b/include/asm-mips/war.h
index ad374bd..859520a 100644
--- a/include/asm-mips/war.h
+++ b/include/asm-mips/war.h
@@ -169,6 +169,19 @@
 #endif
 
 /*
+ * If mfc0 $12 follows store and the mfc0 is last instruction of a
+ * page and fetching the next instruction causes TLB miss, the result
+ * of the mfc0 might wrongly contain EXL bit.
+ *
+ * ERT-TX49H2-027, ERT-TX49H3-012, ERT-TX49HL3-006, ERT-TX49H4-008
+ *
+ * Workaround: mask EXL bit of the result or place a nop before mfc0.
+ */
+#ifdef CONFIG_CPU_TX49XX
+#define TX49XX_MFC0_WAR 1
+#endif
+
+/*
  * On the RM9000 there is a problem which makes the CreateDirtyExclusive
  * cache operation unusable on SMP systems.
  */
@@ -228,6 +241,9 @@
 #ifndef TX49XX_ICACHE_INDEX_INV_WAR
 #define TX49XX_ICACHE_INDEX_INV_WAR	0
 #endif
+#ifndef TX49XX_MFC0_WAR
+#define TX49XX_MFC0_WAR	0
+#endif
 #ifndef RM9000_CDEX_SMP_WAR
 #define RM9000_CDEX_SMP_WAR		0
 #endif
