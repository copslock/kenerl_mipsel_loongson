Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 12:19:01 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:53932 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993420AbdKBLRMP8swI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 12:17:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id CA3DC1A4AC1;
        Thu,  2 Nov 2017 12:17:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A727D1A4AAF;
        Thu,  2 Nov 2017 12:17:06 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
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
Subject: [PATCH v3 8/8] MIPS: math-emu: Mark fall throughs in switch statements with a comment
Date:   Thu,  2 Nov 2017 12:14:05 +0100
Message-Id: <1509621287-32198-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1509621287-32198-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60670
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

Mark intentional fall throughs in switch statements with a consistent
comment.

In most of the cases, a new comment line containing text "fall through"
is inserted. In some of the cases, existing comment contained a variation
of the text "fall through" (for example, "FALL THROUGH" or "drop through").
In such cases, the existing comment is modified to contain "fall through".
Lastly, in two cases, code segments were described in comments as "fall
througs", but were in reality "breaks out" of switch statement. In such
cases, existing comments are accordingly modified.

Apart from making code easier to follow and debug, this change enables
some static code analysers to interpret newly inserted comments as their
annotations (and, therefore, not issue warnings of type "fall through in
switch statement", which is desireable, since marked fallthroughs are
intentional).

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 arch/mips/math-emu/cp1emu.c   | 22 +++++++++++++++-------
 arch/mips/math-emu/dp_add.c   |  3 +--
 arch/mips/math-emu/dp_div.c   |  1 +
 arch/mips/math-emu/dp_fmax.c  |  2 ++
 arch/mips/math-emu/dp_fmin.c  |  2 ++
 arch/mips/math-emu/dp_maddf.c |  3 ++-
 arch/mips/math-emu/dp_mul.c   |  1 +
 arch/mips/math-emu/dp_sqrt.c  |  2 +-
 arch/mips/math-emu/dp_sub.c   |  2 +-
 arch/mips/math-emu/sp_add.c   |  3 +--
 arch/mips/math-emu/sp_div.c   |  1 +
 arch/mips/math-emu/sp_fdp.c   |  3 ++-
 arch/mips/math-emu/sp_fmax.c  |  2 ++
 arch/mips/math-emu/sp_fmin.c  |  2 ++
 arch/mips/math-emu/sp_maddf.c |  3 ++-
 arch/mips/math-emu/sp_mul.c   |  1 +
 arch/mips/math-emu/sp_sub.c   |  1 +
 17 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index fe74973..62deb02 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -451,7 +451,7 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 					regs->cp0_epc + dec_insn.pc_inc +
 					dec_insn.next_pc_inc;
 			}
-			/* Fall through */
+			/* fall through */
 		case jr_op:
 			/* For R6, JR already emulated in jalr_op */
 			if (NO_R6EMU && insn.r_format.func == jr_op)
@@ -471,10 +471,11 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			regs->regs[31] = regs->cp0_epc +
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
-			/* Fall through */
+			/* fall through */
 		case bltzl_op:
 			if (NO_R6EMU)
 				break;
+			/* fall through */
 		case bltz_op:
 			if ((long)regs->regs[insn.i_format.rs] < 0)
 				*contpc = regs->cp0_epc +
@@ -494,10 +495,11 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			regs->regs[31] = regs->cp0_epc +
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
-			/* Fall through */
+			/* fall through */
 		case bgezl_op:
 			if (NO_R6EMU)
 				break;
+			/* fall through */
 		case bgez_op:
 			if ((long)regs->regs[insn.i_format.rs] >= 0)
 				*contpc = regs->cp0_epc +
@@ -512,11 +514,12 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		break;
 	case jalx_op:
 		set_isa16_mode(bit);
+		/* fall through */
 	case jal_op:
 		regs->regs[31] = regs->cp0_epc +
 			dec_insn.pc_inc +
 			dec_insn.next_pc_inc;
-		/* Fall through */
+		/* fall through */
 	case j_op:
 		*contpc = regs->cp0_epc + dec_insn.pc_inc;
 		*contpc >>= 28;
@@ -528,6 +531,7 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	case beql_op:
 		if (NO_R6EMU)
 			break;
+		/* fall through */
 	case beq_op:
 		if (regs->regs[insn.i_format.rs] ==
 		    regs->regs[insn.i_format.rt])
@@ -542,6 +546,7 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	case bnel_op:
 		if (NO_R6EMU)
 			break;
+		/* fall through */
 	case bne_op:
 		if (regs->regs[insn.i_format.rs] !=
 		    regs->regs[insn.i_format.rt])
@@ -556,6 +561,7 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	case blezl_op:
 		if (!insn.i_format.rt && NO_R6EMU)
 			break;
+		/* fall through */
 	case blez_op:
 
 		/*
@@ -593,6 +599,7 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	case bgtzl_op:
 		if (!insn.i_format.rt && NO_R6EMU)
 			break;
+		/* fall through */
 	case bgtz_op:
 		/*
 		 * Compact branches for R6 for the
@@ -729,7 +736,8 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 
 			return 1;
 		}
-		/* R2/R6 compatible cop1 instruction. Fall through */
+		/* R2/R6 compatible cop1 instruction */
+		/* fall through */
 	case cop2_op:
 	case cop1x_op:
 		if (insn.i_format.rs == bc_op) {
@@ -1221,14 +1229,14 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			case bcfl_op:
 				if (cpu_has_mips_2_3_4_5_r)
 					likely = 1;
-				/* Fall through */
+				/* fall through */
 			case bcf_op:
 				cond = !cond;
 				break;
 			case bctl_op:
 				if (cpu_has_mips_2_3_4_5_r)
 					likely = 1;
-				/* Fall through */
+				/* fall through */
 			case bct_op:
 				break;
 			}
diff --git a/arch/mips/math-emu/dp_add.c b/arch/mips/math-emu/dp_add.c
index 8954ef0..678de20 100644
--- a/arch/mips/math-emu/dp_add.c
+++ b/arch/mips/math-emu/dp_add.c
@@ -104,8 +104,7 @@ union ieee754dp ieee754dp_add(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
-
-		/* FALL THROUGH */
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
diff --git a/arch/mips/math-emu/dp_div.c b/arch/mips/math-emu/dp_div.c
index f4746f7..3063ae3 100644
--- a/arch/mips/math-emu/dp_div.c
+++ b/arch/mips/math-emu/dp_div.c
@@ -103,6 +103,7 @@ union ieee754dp ieee754dp_div(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
diff --git a/arch/mips/math-emu/dp_fmax.c b/arch/mips/math-emu/dp_fmax.c
index 5bec64f..d1f984b 100644
--- a/arch/mips/math-emu/dp_fmax.c
+++ b/arch/mips/math-emu/dp_fmax.c
@@ -96,6 +96,7 @@ union ieee754dp ieee754dp_fmax(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
@@ -224,6 +225,7 @@ union ieee754dp ieee754dp_fmaxa(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
diff --git a/arch/mips/math-emu/dp_fmin.c b/arch/mips/math-emu/dp_fmin.c
index a287b23..f98b9613 100644
--- a/arch/mips/math-emu/dp_fmin.c
+++ b/arch/mips/math-emu/dp_fmin.c
@@ -96,6 +96,7 @@ union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
@@ -224,6 +225,7 @@ union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 5c4ad8e..7ea2f82 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -157,6 +157,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		if (zc == IEEE754_CLASS_INF)
@@ -173,7 +174,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754dp_inf(zs);
-		/* fall through to real computations */
+		/* continue to real computations */
 	}
 
 	/* Finally get to do some computation */
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index 7bc5dde..c34a6cd 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -101,6 +101,7 @@ union ieee754dp ieee754dp_mul(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		DPDNORMY;
diff --git a/arch/mips/math-emu/dp_sqrt.c b/arch/mips/math-emu/dp_sqrt.c
index fa39eb8..1d26c92 100644
--- a/arch/mips/math-emu/dp_sqrt.c
+++ b/arch/mips/math-emu/dp_sqrt.c
@@ -142,7 +142,7 @@ union ieee754dp ieee754dp_sqrt(union ieee754dp x)
 		switch (oldcsr.rm) {
 		case FPU_CSR_RU:
 			y.bits += 1;
-			/* drop through */
+			/* fall through */
 		case FPU_CSR_RN:
 			t.bits += 1;
 			break;
diff --git a/arch/mips/math-emu/dp_sub.c b/arch/mips/math-emu/dp_sub.c
index fc17a78..3cc48b8 100644
--- a/arch/mips/math-emu/dp_sub.c
+++ b/arch/mips/math-emu/dp_sub.c
@@ -106,7 +106,7 @@ union ieee754dp ieee754dp_sub(union ieee754dp x, union ieee754dp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		DPDNORMX;
-		/* FALL THROUGH */
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		/* normalize ym,ye */
diff --git a/arch/mips/math-emu/sp_add.c b/arch/mips/math-emu/sp_add.c
index c55c0c0..51dced9 100644
--- a/arch/mips/math-emu/sp_add.c
+++ b/arch/mips/math-emu/sp_add.c
@@ -104,8 +104,7 @@ union ieee754sp ieee754sp_add(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
-
-		/* FALL THROUGH */
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
diff --git a/arch/mips/math-emu/sp_div.c b/arch/mips/math-emu/sp_div.c
index 23587b3..5d29049 100644
--- a/arch/mips/math-emu/sp_div.c
+++ b/arch/mips/math-emu/sp_div.c
@@ -103,6 +103,7 @@ union ieee754sp ieee754sp_div(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
diff --git a/arch/mips/math-emu/sp_fdp.c b/arch/mips/math-emu/sp_fdp.c
index 5060e8f..36a50f9 100644
--- a/arch/mips/math-emu/sp_fdp.c
+++ b/arch/mips/math-emu/sp_fdp.c
@@ -46,7 +46,8 @@ union ieee754sp ieee754sp_fdp(union ieee754dp x)
 	case IEEE754_CLASS_SNAN:
 		x = ieee754dp_nanxcpt(x);
 		EXPLODEXDP;
-		/* Fall through.  */
+		/* fall through */
+
 	case IEEE754_CLASS_QNAN:
 		y = ieee754sp_nan_fdp(xs, xm);
 		if (!ieee754_csr.nan2008) {
diff --git a/arch/mips/math-emu/sp_fmax.c b/arch/mips/math-emu/sp_fmax.c
index 74a5a00..22019ed 100644
--- a/arch/mips/math-emu/sp_fmax.c
+++ b/arch/mips/math-emu/sp_fmax.c
@@ -96,6 +96,7 @@ union ieee754sp ieee754sp_fmax(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
@@ -224,6 +225,7 @@ union ieee754sp ieee754sp_fmaxa(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
diff --git a/arch/mips/math-emu/sp_fmin.c b/arch/mips/math-emu/sp_fmin.c
index c51385f..feaec39 100644
--- a/arch/mips/math-emu/sp_fmin.c
+++ b/arch/mips/math-emu/sp_fmin.c
@@ -96,6 +96,7 @@ union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
@@ -224,6 +225,7 @@ union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index f823338..07ba675 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -126,6 +126,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		if (zc == IEEE754_CLASS_INF)
@@ -142,7 +143,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_NORM):
 		if (zc == IEEE754_CLASS_INF)
 			return ieee754sp_inf(zs);
-		/* fall through to real computations */
+		/* continue to real computations */
 	}
 
 	/* Finally get to do some computation */
diff --git a/arch/mips/math-emu/sp_mul.c b/arch/mips/math-emu/sp_mul.c
index 4015101..fde71e2 100644
--- a/arch/mips/math-emu/sp_mul.c
+++ b/arch/mips/math-emu/sp_mul.c
@@ -101,6 +101,7 @@ union ieee754sp ieee754sp_mul(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
diff --git a/arch/mips/math-emu/sp_sub.c b/arch/mips/math-emu/sp_sub.c
index dc998ed..9f2ff72 100644
--- a/arch/mips/math-emu/sp_sub.c
+++ b/arch/mips/math-emu/sp_sub.c
@@ -106,6 +106,7 @@ union ieee754sp ieee754sp_sub(union ieee754sp x, union ieee754sp y)
 
 	case CLPAIR(IEEE754_CLASS_DNORM, IEEE754_CLASS_DNORM):
 		SPDNORMX;
+		/* fall through */
 
 	case CLPAIR(IEEE754_CLASS_NORM, IEEE754_CLASS_DNORM):
 		SPDNORMY;
-- 
2.7.4
