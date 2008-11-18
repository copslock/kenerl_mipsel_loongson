Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 23:54:27 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:60642 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23755748AbYKRXyS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 23:54:18 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492355a40000>; Tue, 18 Nov 2008 18:54:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 15:54:10 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 15:54:10 -0800
Message-ID: <492355A2.30607@caviumnetworks.com>
Date:	Tue, 18 Nov 2008 15:54:10 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: Reorder operations in stackframe.h for better scheduling
 (v2)
References: <49235080.3070202@caviumnetworks.com>
In-Reply-To: <49235080.3070202@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2008 23:54:10.0394 (UTC) FILETIME=[F3825BA0:01C949D8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Reorder PT ops to avoid pipeline stalls.
> 
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -51,9 +51,6 @@
>         LONG_S    v1, PT_ACX(sp)
> #else
>         mfhi    v1
> -        LONG_S    v1, PT_HI(sp)
> -        mflo    v1
> -        LONG_S    v1, PT_LO(sp)
> #endif
> #ifdef CONFIG_32BIT
>         LONG_S    $8, PT_R8(sp)
> @@ -62,10 +59,13 @@
>         LONG_S    $10, PT_R10(sp)
>         LONG_S    $11, PT_R11(sp)
>         LONG_S    $12, PT_R12(sp)
> +        LONG_S    v1, PT_HI(sp)
> +        mflo    v1
>         LONG_S    $13, PT_R13(sp)
>         LONG_S    $14, PT_R14(sp)
>         LONG_S    $15, PT_R15(sp)
>         LONG_S    $24, PT_R24(sp)
> +        LONG_S    v1, PT_LO(sp)
>         .endm

Those changes escaped the CONFIG_CPU_HAS_SMARTMIPS, please try this
version instead:

MIPS: Reorder operations in stackframe.h for better scheduling

Reorder PT ops to avoid pipeline stalls.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
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
@@ -178,19 +181,20 @@
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
