Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 21:01:16 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6555 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298232AbYKFUz5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:57 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B491359a20002>; Thu, 06 Nov 2008 15:54:58 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:58 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:57 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6Ksr1F027753;
	Thu, 6 Nov 2008 12:54:53 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsqYH027752;
	Thu, 6 Nov 2008 12:54:52 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 19/29] MIPS: Cavium OCTEON: PT vs MFC0 reorder, multiplier state preservation.
Date:	Thu,  6 Nov 2008 12:54:32 -0800
Message-Id: <1226004875-27654-19-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:57.0933 (UTC) FILETIME=[ED9603D0:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For cavium, reorder PT ops to be after mfc0 and not before.
Also implement a save and restore of the multiplier state
so that if it gets corrupted, it will not impact things.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/stackframe.h |   46 ++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 4c37c4e..bcaac81 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -51,10 +51,12 @@
 		LONG_S	v1, PT_ACX(sp)
 #else
 		mfhi	v1
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 		LONG_S	v1, PT_HI(sp)
 		mflo	v1
 		LONG_S	v1, PT_LO(sp)
 #endif
+#endif
 #ifdef CONFIG_32BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
@@ -62,10 +64,17 @@
 		LONG_S	$10, PT_R10(sp)
 		LONG_S	$11, PT_R11(sp)
 		LONG_S	$12, PT_R12(sp)
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		LONG_S	v1, PT_HI(sp)
+		mflo	v1
+#endif
 		LONG_S	$13, PT_R13(sp)
 		LONG_S	$14, PT_R14(sp)
 		LONG_S	$15, PT_R15(sp)
 		LONG_S	$24, PT_R24(sp)
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		LONG_S	v1, PT_LO(sp)
+#endif
 		.endm
 
 		.macro	SAVE_STATIC
@@ -166,7 +175,9 @@
 		LONG_S	$0, PT_R0(sp)
 		mfc0	v1, CP0_STATUS
 		LONG_S	$2, PT_R2(sp)
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 		LONG_S	v1, PT_STATUS(sp)
+#endif
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -178,22 +189,53 @@
 		LONG_S	v1, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_S	$4, PT_R4(sp)
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 		mfc0	v1, CP0_CAUSE
+#endif
 		LONG_S	$5, PT_R5(sp)
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		LONG_S	v1, PT_STATUS(sp)
+		mfc0	v1, CP0_CAUSE
+#else
 		LONG_S	v1, PT_CAUSE(sp)
+#endif
 		LONG_S	$6, PT_R6(sp)
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 		MFC0	v1, CP0_EPC
+#endif
 		LONG_S	$7, PT_R7(sp)
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		LONG_S	v1, PT_CAUSE(sp)
+		MFC0	v1, CP0_EPC
+#endif
 #ifdef CONFIG_64BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
 #endif
+#ifndef CONFIG_CPU_CAVIUM_OCTEON
 		LONG_S	v1, PT_EPC(sp)
+#endif
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
 		LONG_S	$31, PT_R31(sp)
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		LONG_S	v1, PT_EPC(sp)
+#endif
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		.set    mips64
+		pref    0, 0($28)       /* Prefetch the current pointer */
+		pref    0, PT_R31(sp)   /* Prefetch the $31(ra) */
+		/* The Octeon multiplier state is affected by general multiply
+		    instructions. It must be saved before and kernel code might
+		    corrupt it */
+		jal     octeon_mult_save
+		LONG_L  v1, 0($28)  /* Load the current pointer */
+			 /* Restore $31(ra) that was changed by the jal */
+		LONG_L  ra, PT_R31(sp)
+		pref    0, 0(v1)    /* Prefetch the current thread */
+#endif
 		.set	pop
 		.endm
 
@@ -324,6 +366,10 @@
 		DVPE	5				# dvpe a1
 		jal	mips_ihb
 #endif /* CONFIG_MIPS_MT_SMTC */
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+		/* Restore the Octeon multiplier state */
+		jal	octeon_mult_restore
+#endif
 		mfc0	a0, CP0_STATUS
 		ori	a0, STATMASK
 		xori	a0, STATMASK
-- 
1.5.6.5
