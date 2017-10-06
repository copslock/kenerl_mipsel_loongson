Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 19:30:23 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:60426 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993906AbdJFR36Pos2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Oct 2017 19:29:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 309241A45ED;
        Fri,  6 Oct 2017 19:29:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 03F111A45D6;
        Fri,  6 Oct 2017 19:29:52 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats for certain instructions
Date:   Fri,  6 Oct 2017 19:29:00 +0200
Message-Id: <1507310955-3525-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1507310955-3525-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Fix omission of updating of debugfs FP exception stats for
instructions <CLASS|MADDF|MSUBF|MAX|MIN|MAXA|MINA>.<D|S>.

CLASS.<D|S> can generate Unimplemented Operation FP exception.
<MADDF|MSUBF|MAX|MIN|MAXA|MINA>>.<D|S> can generate Inexact,
Unimplemented Operation, Invalid Operation, Overflow, and
Underflow FP exceptions. In such cases, and prior to this
patch, debugfs FP exception stats were not updated, and
therefore contained overall wrong values.

This brings the emulation of mentioned instructions consistent
with the previously implemented emulation of other related
FPU instructions.

There is still some room for refactoring and improving the
code segment under label "copcsr", but this is beyond the
scope of this patch.

Fixes: 38db37ba069f ("MIPS: math-emu: Add support for the MIPS R6 CLASS FPU instruction")
Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")
Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 192542d..d2fcb30 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1795,7 +1795,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
 			rv.s = ieee754sp_maddf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmsubf_op: {
@@ -1809,7 +1809,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			SPFROMREG(fd, MIPSInst_FD(ir));
 			rv.s = ieee754sp_msubf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case frint_op: {
@@ -1834,7 +1834,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.w = ieee754sp_2008class(fs);
 			rfmt = w_fmt;
-			break;
+			goto copcsr;
 		}
 
 		case fmin_op: {
@@ -1847,7 +1847,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmin(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmina_op: {
@@ -1860,7 +1860,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmina(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmax_op: {
@@ -1873,7 +1873,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmax(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmaxa_op: {
@@ -1886,7 +1886,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			SPFROMREG(ft, MIPSInst_FT(ir));
 			SPFROMREG(fs, MIPSInst_FS(ir));
 			rv.s = ieee754sp_fmaxa(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fabs_op:
@@ -2165,7 +2165,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
 			rv.d = ieee754dp_maddf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmsubf_op: {
@@ -2179,7 +2179,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			DPFROMREG(fd, MIPSInst_FD(ir));
 			rv.d = ieee754dp_msubf(fd, fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case frint_op: {
@@ -2204,7 +2204,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.l = ieee754dp_2008class(fs);
 			rfmt = l_fmt;
-			break;
+			goto copcsr;
 		}
 
 		case fmin_op: {
@@ -2217,7 +2217,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmin(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmina_op: {
@@ -2230,7 +2230,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmina(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmax_op: {
@@ -2243,7 +2243,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmax(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fmaxa_op: {
@@ -2256,7 +2256,7 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			DPFROMREG(ft, MIPSInst_FT(ir));
 			DPFROMREG(fs, MIPSInst_FS(ir));
 			rv.d = ieee754dp_fmaxa(fs, ft);
-			break;
+			goto copcsr;
 		}
 
 		case fabs_op:
-- 
2.7.4
