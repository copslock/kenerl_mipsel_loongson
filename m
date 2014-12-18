Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:13:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10516 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009152AbaLRPLYtiBSp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 77D7CF3F71417
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:16 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:19 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:18 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 09/67] MIPS: asm: stackframe: Do not preserve the HI/LO registers on MIPS R6
Date:   Thu, 18 Dec 2014 15:09:18 +0000
Message-ID: <1418915416-3196-10-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The HI/LO registers have been removed from MIPS R6. Instructions
such as MULT and DIV have been replaced with a new pair of
instructions for the HI/LO operations for example:

MULT -> MUL, MUH
DIV -> DIV, MOD

So we avoid preserving the pre-R6 HI/LO registers in MIPS R6

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/stackframe.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index b188c797565c..28d6d9364bd1 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -40,7 +40,7 @@
 		LONG_S	v1, PT_HI(sp)
 		mflhxu	v1
 		LONG_S	v1, PT_ACX(sp)
-#else
+#elif !defined(CONFIG_CPU_MIPSR6)
 		mfhi	v1
 #endif
 #ifdef CONFIG_32BIT
@@ -50,7 +50,7 @@
 		LONG_S	$10, PT_R10(sp)
 		LONG_S	$11, PT_R11(sp)
 		LONG_S	$12, PT_R12(sp)
-#ifndef CONFIG_CPU_HAS_SMARTMIPS
+#if !defined(CONFIG_CPU_HAS_SMARTMIPS) && !defined(CONFIG_CPU_MIPSR6)
 		LONG_S	v1, PT_HI(sp)
 		mflo	v1
 #endif
@@ -58,7 +58,7 @@
 		LONG_S	$14, PT_R14(sp)
 		LONG_S	$15, PT_R15(sp)
 		LONG_S	$24, PT_R24(sp)
-#ifndef CONFIG_CPU_HAS_SMARTMIPS
+#if !defined(CONFIG_CPU_HAS_SMARTMIPS) && !defined(CONFIG_CPU_MIPSR6)
 		LONG_S	v1, PT_LO(sp)
 #endif
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -226,7 +226,7 @@
 		mtlhx	$24
 		LONG_L	$24, PT_LO(sp)
 		mtlhx	$24
-#else
+#elif !defined(CONFIG_CPU_MIPSR6)
 		LONG_L	$24, PT_LO(sp)
 		mtlo	$24
 		LONG_L	$24, PT_HI(sp)
-- 
2.2.0
