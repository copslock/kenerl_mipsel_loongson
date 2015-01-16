Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:10:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26753 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011453AbbAPKyLP7TRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:54:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 70195FE3DC368
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:54:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:54:05 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:54:04 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 66/70] MIPS: Handle MIPS IV, V and R2 FPU instructions on MIPS R6 as well
Date:   Fri, 16 Jan 2015 10:49:45 +0000
Message-ID: <1421405389-15512-67-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45210
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

MIPS R2 FPU instructions are also present in MIPS R6 so amend the
preprocessor definitions to take MIPS R6 into consideration.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 3 ++-
 arch/mips/math-emu/cp1emu.c          | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 904dd1ca5cf4..3274065de231 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -217,7 +217,8 @@
 #define cpu_has_mips_4_5_r	(cpu_has_mips_4 | cpu_has_mips_5_r)
 #define cpu_has_mips_5_r	(cpu_has_mips_5 | cpu_has_mips_r)
 
-#define cpu_has_mips_4_5_r2	(cpu_has_mips_4_5 | cpu_has_mips_r2)
+#define cpu_has_mips_4_5_r2_r6	(cpu_has_mips_4_5 | cpu_has_mips_r2 | \
+				 cpu_has_mips_r6)
 
 #define cpu_has_mips32	(cpu_has_mips32r1 | cpu_has_mips32r2 | cpu_has_mips32r6)
 #define cpu_has_mips64	(cpu_has_mips64r1 | cpu_has_mips64r2 | cpu_has_mips64r6)
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 4d32033e8081..eef958edc4c7 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1562,14 +1562,14 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		 * achieve full IEEE-754 accuracy - however this emulator does.
 		 */
 		case frsqrt_op:
-			if (!cpu_has_mips_4_5_r2)
+			if (!cpu_has_mips_4_5_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_sp_rsqrt;
 			goto scopuop;
 
 		case frecip_op:
-			if (!cpu_has_mips_4_5_r2)
+			if (!cpu_has_mips_4_5_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_sp_recip;
@@ -1764,13 +1764,13 @@ copcsr:
 		 * achieve full IEEE-754 accuracy - however this emulator does.
 		 */
 		case frsqrt_op:
-			if (!cpu_has_mips_4_5_r2)
+			if (!cpu_has_mips_4_5_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_dp_rsqrt;
 			goto dcopuop;
 		case frecip_op:
-			if (!cpu_has_mips_4_5_r2)
+			if (!cpu_has_mips_4_5_r2_r6)
 				return SIGILL;
 
 			handler.u = fpemu_dp_recip;
-- 
2.2.1
