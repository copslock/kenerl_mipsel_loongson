Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 14:44:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51710 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039881AbWJJNol (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 14:44:41 +0100
Received: from localhost (p3213-ipad213funabasi.chiba.ocn.ne.jp [124.85.68.213])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2270E46BD; Tue, 10 Oct 2006 22:44:37 +0900 (JST)
Date:	Tue, 10 Oct 2006 22:46:52 +0900 (JST)
Message-Id: <20061010.224652.53335173.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] optimize and cleanup get_saved_sp, set_saved_sp
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
X-archive-position: 12863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If CONFIG_BUILD_ELF64 was not selected and gcc had -msym32 option
(i.e. 4.0 or newer), there is no point to use %highest, %higher for
kernel symbols.

This patch also fixes 64-bit SMTC version of get_saved_sp() which is
broken but harmless since there is no such CPUs for now.

A bonus is set_saved_sp() and SMP version of get_saved_sp() are more
readable now.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/stackframe.h b/include/asm-mips/stackframe.h
index 158a4cd..1fae5dc 100644
--- a/include/asm-mips/stackframe.h
+++ b/include/asm-mips/stackframe.h
@@ -59,69 +59,43 @@ #endif
 		.endm
 
 #ifdef CONFIG_SMP
-		.macro	get_saved_sp	/* SMP variation */
-#ifdef CONFIG_32BIT
 #ifdef CONFIG_MIPS_MT_SMTC
-		.set	mips32
-		mfc0	k0, CP0_TCBIND;
-		.set	mips0
-		lui	k1, %hi(kernelsp)
-		srl	k0, k0, 19
-		/* No need to shift down and up to clear bits 0-1 */
+#define PTEBASE_SHIFT	19	/* TCBIND */
 #else
-		mfc0	k0, CP0_CONTEXT
-		lui	k1, %hi(kernelsp)
-		srl	k0, k0, 23
-#endif
-		addu	k1, k0
-		LONG_L	k1, %lo(kernelsp)(k1)
+#define PTEBASE_SHIFT	23	/* CONTEXT */
 #endif
-#ifdef CONFIG_64BIT
+		.macro	get_saved_sp	/* SMP variation */
 #ifdef CONFIG_MIPS_MT_SMTC
-		.set	mips64
-		mfc0	k0, CP0_TCBIND;
-		.set	mips0
-		lui	k0, %highest(kernelsp)
-		dsrl	k1, 19
-		/* No need to shift down and up to clear bits 0-2 */
+		mfc0	k0, CP0_TCBIND
 #else
-		MFC0	k1, CP0_CONTEXT
-		lui	k0, %highest(kernelsp)
-		dsrl	k1, 23
-		daddiu	k0, %higher(kernelsp)
-		dsll	k0, k0, 16
-		daddiu	k0, %hi(kernelsp)
-		dsll	k0, k0, 16
-#endif /* CONFIG_MIPS_MT_SMTC */
-		daddu	k1, k1, k0
+		MFC0	k0, CP0_CONTEXT
+#endif
+#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
+		lui	k1, %highest(kernelsp)
+		daddiu	k1, %higher(kernelsp)
+		dsll	k1, 16
+		daddiu	k1, %hi(kernelsp)
+		dsll	k1, 16
+#else
+		lui	k1, %hi(kernelsp)
+#endif
+		LONG_SRL	k0, PTEBASE_SHIFT
+		LONG_ADDU	k1, k0
 		LONG_L	k1, %lo(kernelsp)(k1)
-#endif /* CONFIG_64BIT */
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
-#ifdef CONFIG_32BIT
-#ifdef CONFIG_MIPS_MT_SMTC
-		mfc0	\temp, CP0_TCBIND
-		srl	\temp, 19
-#else
-		mfc0	\temp, CP0_CONTEXT
-		srl	\temp, 23
-#endif
-#endif
-#ifdef CONFIG_64BIT
 #ifdef CONFIG_MIPS_MT_SMTC
 		mfc0	\temp, CP0_TCBIND
-		dsrl	\temp, 19
 #else
 		MFC0	\temp, CP0_CONTEXT
-		dsrl	\temp, 23
-#endif
 #endif
+		LONG_SRL	\temp, PTEBASE_SHIFT
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_BUILD_ELF64) || (defined(CONFIG_64BIT) && __GNUC__ < 4)
 		lui	k1, %highest(kernelsp)
 		daddiu	k1, %higher(kernelsp)
 		dsll	k1, k1, 16
