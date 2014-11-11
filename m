Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:09:33 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:40655 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013353AbaKKLJcSCYME (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 12:09:32 +0100
Received: from bl15-104-53.dsl.telepac.pt ([188.80.104.53] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Xo9KE-0006vx-Kc; Tue, 11 Nov 2014 11:09:30 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 034/170] MIPS: cp1emu: Fix ISA restrictions for cop1x_op instructions
Date:   Tue, 11 Nov 2014 11:06:33 +0000
Message-Id: <1415704129-12709-35-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1415704129-12709-1-git-send-email-luis.henriques@canonical.com>
References: <1415704129-12709-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt1 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit a5466d7bba9af83a82cc7c081b2a7d557cde3204 upstream.

Commit 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery") removed
the #ifdef ISA conditions and switched to runtime detection. However,
according to the instruction set manual, the cop1x_op instructions are
available in >=MIPS32r2 as well. This fixes a problem on MIPS32r2
with the ntpd package which failed to execute with a SIGILL exit code due
to the fact that a madd.d instruction was not being emulated.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 08a07904e1828 ("MIPS: math-emu: Remove most ifdefery")
Cc: linux-mips@linux-mips.org
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/8173/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 7a4727795a70..51a0fde4bec1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1023,7 +1023,7 @@ emul:
 					goto emul;
 
 				case cop1x_op:
-					if (cpu_has_mips_4_5 || cpu_has_mips64)
+					if (cpu_has_mips_4_5 || cpu_has_mips64 || cpu_has_mips32r2)
 						/* its one of ours */
 						goto emul;
 
@@ -1068,7 +1068,7 @@ emul:
 		break;
 
 	case cop1x_op:
-		if (!cpu_has_mips_4_5 && !cpu_has_mips64)
+		if (!cpu_has_mips_4_5 && !cpu_has_mips64 && !cpu_has_mips32r2)
 			return SIGILL;
 
 		sig = fpux_emu(xcp, ctx, ir, fault_addr);
-- 
2.1.0
