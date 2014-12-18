Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:14:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40445 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009158AbaLRPLqXoxkt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1E9BA43B7996
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:38 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:40 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:39 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 15/67] MIPS: asm: hazards: Add MIPSR6 definitions
Date:   Thu, 18 Dec 2014 15:09:24 +0000
Message-ID: <1418915416-3196-16-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44750
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

Add the MIPSR6 related definitions to MIPS hazards

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/hazards.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index e3ee92d4dbe7..beb55bac40a1 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -21,7 +21,7 @@
 /*
  * TLB hazards
  */
-#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 /*
  * MIPSR2 defines ehb for hazard avoidance
@@ -58,7 +58,7 @@ do {									\
 	unsigned long tmp;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	mips64r2				\n"	\
+	"	.set "MIPS_ISA_LEVEL"				\n"	\
 	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
 	"	.set	mips0					\n"	\
@@ -132,7 +132,7 @@ do {									\
 
 #define instruction_hazard()						\
 do {									\
-	if (cpu_has_mips_r2)						\
+	if (cpu_has_mips_r2 || cpu_has_mips_r6)						\
 		__instruction_hazard();					\
 } while (0)
 
@@ -240,7 +240,7 @@ do {									\
 
 #define __disable_fpu_hazard
 
-#elif defined(CONFIG_CPU_MIPSR2)
+#elif defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)
 
 #define __enable_fpu_hazard						\
 	___ehb
-- 
2.2.0
