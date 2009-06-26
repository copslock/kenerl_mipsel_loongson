Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 18:08:37 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:15784 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493348AbZFZQIG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 18:08:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a44f1700001>; Fri, 26 Jun 2009 12:04:01 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:01:47 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:01:47 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5QG1iFt031370;
	Fri, 26 Jun 2009 09:01:44 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5QG1iix031369;
	Fri, 26 Jun 2009 09:01:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Reorder operations in stackframe.h for better scheduling
Date:	Fri, 26 Jun 2009 09:01:43 -0700
Message-Id: <1246032103-31345-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 26 Jun 2009 16:01:47.0110 (UTC) FILETIME=[68797060:01C9F677]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Reorder PT ops to avoid pipeline stalls.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/stackframe.h |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index db0fa7b..dd7e220 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -51,9 +51,6 @@
 		LONG_S	v1, PT_ACX(sp)
 #else
 		mfhi	v1
-		LONG_S	v1, PT_HI(sp)
-		mflo	v1
-		LONG_S	v1, PT_LO(sp)
 #endif
 #ifdef CONFIG_32BIT
 		LONG_S	$8, PT_R8(sp)
@@ -62,10 +59,17 @@
 		LONG_S	$10, PT_R10(sp)
 		LONG_S	$11, PT_R11(sp)
 		LONG_S	$12, PT_R12(sp)
+#ifndef CONFIG_CPU_HAS_SMARTMIPS
+		LONG_S	v1, PT_HI(sp)
+		mflo	v1
+#endif
 		LONG_S	$13, PT_R13(sp)
 		LONG_S	$14, PT_R14(sp)
 		LONG_S	$15, PT_R15(sp)
 		LONG_S	$24, PT_R24(sp)
+#ifndef CONFIG_CPU_HAS_SMARTMIPS
+		LONG_S	v1, PT_LO(sp)
+#endif
 		.endm
 
 		.macro	SAVE_STATIC
@@ -166,7 +170,6 @@
 		LONG_S	$0, PT_R0(sp)
 		mfc0	v1, CP0_STATUS
 		LONG_S	$2, PT_R2(sp)
-		LONG_S	v1, PT_STATUS(sp)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -178,20 +181,21 @@
 		LONG_S	v1, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
 		LONG_S	$4, PT_R4(sp)
-		mfc0	v1, CP0_CAUSE
 		LONG_S	$5, PT_R5(sp)
-		LONG_S	v1, PT_CAUSE(sp)
+		LONG_S	v1, PT_STATUS(sp)
+		mfc0	v1, CP0_CAUSE
 		LONG_S	$6, PT_R6(sp)
-		MFC0	v1, CP0_EPC
 		LONG_S	$7, PT_R7(sp)
+		LONG_S	v1, PT_CAUSE(sp)
+		MFC0	v1, CP0_EPC
 #ifdef CONFIG_64BIT
 		LONG_S	$8, PT_R8(sp)
 		LONG_S	$9, PT_R9(sp)
 #endif
-		LONG_S	v1, PT_EPC(sp)
 		LONG_S	$25, PT_R25(sp)
 		LONG_S	$28, PT_R28(sp)
 		LONG_S	$31, PT_R31(sp)
+		LONG_S	v1, PT_EPC(sp)
 		ori	$28, sp, _THREAD_MASK
 		xori	$28, _THREAD_MASK
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
-- 
1.6.0.6
