Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:19:21 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:41497 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992181AbdJTOTMx6G8- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 16:19:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id A2CE51A495B;
        Fri, 20 Oct 2017 16:19:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 833C81A494C;
        Fri, 20 Oct 2017 16:19:06 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "# 4 . 3+" <stable@vger.kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 1/2] MIPS: math-emu: Update debugfs FP exception stats for certain instructions
Date:   Fri, 20 Oct 2017 16:16:27 +0200
Message-Id: <1508509002-28518-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508509002-28518-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1508509002-28518-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60494
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Fix omission of updating of debugfs FP exception stats for
instructions <CLASS|MADDF|MSUBF|MAX|MIN|MAXA|MINA>.<D|S>.

CLASS.<D|S> instruction can generate "Unimplemented Operation"
FP exception. <MADDF|MSUBF>.<D|S> can generate "Inexact",
"Unimplemented Operation", "Invalid Operation", "Overflow",
and "Underflow" FP exceptions. <MAX|MIN|MAXA|MINA>.<D|S> can
generate "Unimplemented Operation" and "Invalid Operation" FP
exceptions. In all such cases (and prior to this patch),
SIGFPE signal was not generated, even though, according to
its specifications, it should be. Also, debugfs FP exception
stats were not updated, and therefore contained overall
wrong values.

This patch fixes those problems, and brings the emulation
of mentioned instructions consistent with the previously
implemented emulation of other related FPU instructions
(ADD, SUB, etc.).

Fixes: 38db37ba069f ("MIPS: math-emu: Add support for the MIPS R6 CLASS FPU instruction")
Fixes: e24c3bec3e8e ("MIPS: math-emu: Add support for the MIPS R6 MADDF FPU instruction")
Fixes: 83d43305a1df ("MIPS: math-emu: Add support for the MIPS R6 MSUBF FPU instruction")
Fixes: a79f5f9ba508 ("MIPS: math-emu: Add support for the MIPS R6 MAX{, A} FPU instruction")
Fixes: 4e9561b20e2f ("MIPS: math-emu: Add support for the MIPS R6 MIN{, A} FPU instruction")

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: <stable@vger.kernel.org> # 4.3+
---
 arch/mips/math-emu/cp1emu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 16d9ef5..6f57212 100644
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
