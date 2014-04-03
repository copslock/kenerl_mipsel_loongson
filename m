Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 23:02:02 +0200 (CEST)
Received: from [217.156.156.69] ([217.156.156.69]:2520 "EHLO
        mailapp01.imgtec.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816635AbaDCVB7exitU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 23:01:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6D7EC59711447
        for <linux-mips@linux-mips.org>; Thu,  3 Apr 2014 17:52:15 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 3 Apr
 2014 17:52:17 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 3 Apr 2014 17:52:17 +0100
Received: from fun-lab.mips.com (192.168.136.61) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 3 Apr
 2014 09:52:15 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <Steven.Hill@imgtec.com>, <james.hogan@imgtec.com>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH] MIPS: math-emu: Add IEEE754 exception statistics to debugfs
Date:   Thu, 3 Apr 2014 09:52:12 -0700
Message-ID: <1396543932-30051-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Sometimes it's useful to let the user, while doing performance research,
know what in the IEEE754 exceptions has caused many times of FP emulation
when running a specific application. This patch adds 5 more files to
/sys/kernel/debug/mips/fpuemustats/, whose filenames begin with "ieee754".
These stats are in addition to the existing cp1ops, cp1xops, errors, loads
and stores, which may not be useful in understanding the reasons of ieee754
exceptions.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/asm/fpu_emulator.h |  5 +++++
 arch/mips/math-emu/cp1emu.c          | 41 ++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..0ab4a3c 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -36,6 +36,11 @@ struct mips_fpu_emulator_stats {
 	local_t cp1ops;
 	local_t cp1xops;
 	local_t errors;
+	local_t ieee754_inexact;
+	local_t ieee754_underflow;
+	local_t ieee754_overflow;
+	local_t ieee754_zerodiv;
+	local_t ieee754_invalidop;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 0b4e2e3..f630b74 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1444,14 +1444,22 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPTOREG(fd, MIPSInst_FD(ir));
 
 		      copcsr:
-			if (ieee754_cxtest(IEEE754_INEXACT))
+			if (ieee754_cxtest(IEEE754_INEXACT)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_inexact);
 				rcsr |= FPU_CSR_INE_X | FPU_CSR_INE_S;
-			if (ieee754_cxtest(IEEE754_UNDERFLOW))
+			}
+			if (ieee754_cxtest(IEEE754_UNDERFLOW)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_underflow);
 				rcsr |= FPU_CSR_UDF_X | FPU_CSR_UDF_S;
-			if (ieee754_cxtest(IEEE754_OVERFLOW))
+			}
+			if (ieee754_cxtest(IEEE754_OVERFLOW)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_overflow);
 				rcsr |= FPU_CSR_OVF_X | FPU_CSR_OVF_S;
-			if (ieee754_cxtest(IEEE754_INVALID_OPERATION))
+			}
+			if (ieee754_cxtest(IEEE754_INVALID_OPERATION)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_invalidop);
 				rcsr |= FPU_CSR_INV_X | FPU_CSR_INV_S;
+			}
 
 			ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
 			if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
@@ -1660,16 +1668,26 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				goto copcsr;
 			}
 		      copcsr:
-			if (ieee754_cxtest(IEEE754_INEXACT))
+			if (ieee754_cxtest(IEEE754_INEXACT)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_inexact);
 				rcsr |= FPU_CSR_INE_X | FPU_CSR_INE_S;
-			if (ieee754_cxtest(IEEE754_UNDERFLOW))
+			}
+			if (ieee754_cxtest(IEEE754_UNDERFLOW)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_underflow);
 				rcsr |= FPU_CSR_UDF_X | FPU_CSR_UDF_S;
-			if (ieee754_cxtest(IEEE754_OVERFLOW))
+			}
+			if (ieee754_cxtest(IEEE754_OVERFLOW)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_overflow);
 				rcsr |= FPU_CSR_OVF_X | FPU_CSR_OVF_S;
-			if (ieee754_cxtest(IEEE754_ZERO_DIVIDE))
+			}
+			if (ieee754_cxtest(IEEE754_ZERO_DIVIDE)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_zerodiv);
 				rcsr |= FPU_CSR_DIV_X | FPU_CSR_DIV_S;
-			if (ieee754_cxtest(IEEE754_INVALID_OPERATION))
+			}
+			if (ieee754_cxtest(IEEE754_INVALID_OPERATION)) {
+				MIPS_FPU_EMU_INC_STATS(ieee754_invalidop);
 				rcsr |= FPU_CSR_INV_X | FPU_CSR_INV_S;
+			}
 			break;
 
 			/* unary conv ops */
@@ -2179,6 +2197,11 @@ static int __init debugfs_fpuemu(void)
 	FPU_STAT_CREATE(cp1ops);
 	FPU_STAT_CREATE(cp1xops);
 	FPU_STAT_CREATE(errors);
+	FPU_STAT_CREATE(ieee754_inexact);
+	FPU_STAT_CREATE(ieee754_underflow);
+	FPU_STAT_CREATE(ieee754_overflow);
+	FPU_STAT_CREATE(ieee754_zerodiv);
+	FPU_STAT_CREATE(ieee754_invalidop);
 
 	return 0;
 }
-- 
1.8.5.3
