Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 14:49:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55479 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855603AbaEWMtmB6mYw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 May 2014 14:49:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9202BA532B717;
        Fri, 23 May 2014 13:49:32 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 23 May 2014 13:49:35 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.62) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 23 May 2014 13:49:34 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH mips-for-linux-next] MIPS: math-emu: Regression fixes
Date:   Fri, 23 May 2014 13:49:24 +0100
Message-ID: <1400849364-7077-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.62]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Fix some errors introduced by commit e2efc0ab3a ("MIPS: math-emu:
Remove most ifdefery."), which result in incorrect behaviour of the
FPU emulator.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
Ralf, the above commit in mips-for-linux-next causes a regression
which this patch fixes (the regression I was seeing is fixed by the
last change, but I also noticed a couple of incorrect ISA level
checks which I fixed up as well). Could you squash this into that
commit?
---
 arch/mips/math-emu/cp1emu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 331334c..08e6a74 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1512,7 +1512,7 @@ copcsr:
 			goto copcsr;
 
 		case fcvtl_op:
-			if (!cpu_has_mips_3_4_5 && cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
 				return SIGILL;
 
 			SPFROMREG(fs, MIPSInst_FS(ir));
@@ -1524,7 +1524,7 @@ copcsr:
 		case ftruncl_op:
 		case fceill_op:
 		case ffloorl_op:
-			if (!cpu_has_mips_3_4_5 && cpu_has_mips64)
+			if (!cpu_has_mips_3_4_5 && !cpu_has_mips64)
 				return SIGILL;
 
 			oldrm = ieee754_csr.rm;
@@ -1808,11 +1808,10 @@ dcopuop:
 			cbit = fpucondbit[MIPSInst_RT(ir) >> 2];
 		else
 			cbit = FPU_CSR_COND;
-		cond = ctx->fcr31 & cbit;
 		if (rv.w)
-			ctx->fcr31 |= cond;
+			ctx->fcr31 |= cbit;
 		else
-			ctx->fcr31 &= ~cond;
+			ctx->fcr31 &= ~cbit;
 		break;
 
 	case d_fmt:
-- 
1.9.3
