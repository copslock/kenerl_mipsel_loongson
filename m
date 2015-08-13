Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 09:58:54 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27011627AbbHMH6inI4w4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:58:38 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 02/10] MIPS: math-emu: cp1emu: Add support for the CMP.condn.fmt R6 instruction
Date:   Thu, 13 Aug 2015 09:56:28 +0200
Message-Id: <1439452596-16759-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48833
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

Add support for emulating the new CMP.condn.fmt R6 instructions and
return SIGILL for the old C.cond.fmt if R2 emulation is not enabled
since it's not supported by R6.

The functionality of the new CMP.condn.fmt is the following one:

If the comparison specified by the condn field of the instruction
is true for the operand values, the result is true; otherwise, the
result is false. If no exception is taken, the result is written into
FPR fd; true is all 1s and false is all 0s repeated the operand width
of fmt. All other bits beyond the operand width fmt are UNPREDICTABLE.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 130 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 712f17a2ecf2..363b30a5c398 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1376,6 +1376,14 @@ static const unsigned char cmptab[8] = {
 	IEEE754_CLT | IEEE754_CEQ | IEEE754_CUN,	/* cmp_ule (sig) cmp_ngt */
 };
 
+static const unsigned char negative_cmptab[8] = {
+	0, /* Reserved */
+	IEEE754_CLT | IEEE754_CGT | IEEE754_CEQ,
+	IEEE754_CLT | IEEE754_CGT | IEEE754_CUN,
+	IEEE754_CLT | IEEE754_CGT,
+	/* Reserved */
+};
+
 
 /*
  * Additional MIPS4 instructions
@@ -1820,7 +1828,7 @@ copcsr:
 			goto copcsr;
 
 		default:
-			if (MIPSInst_FUNC(ir) >= fcmp_op) {
+			if (!NO_R6EMU && MIPSInst_FUNC(ir) >= fcmp_op) {
 				unsigned cmpop = MIPSInst_FUNC(ir) - fcmp_op;
 				union ieee754sp fs, ft;
 
@@ -1997,7 +2005,7 @@ dcopuop:
 			goto copcsr;
 
 		default:
-			if (MIPSInst_FUNC(ir) >= fcmp_op) {
+			if (!NO_R6EMU && MIPSInst_FUNC(ir) >= fcmp_op) {
 				unsigned cmpop = MIPSInst_FUNC(ir) - fcmp_op;
 				union ieee754dp fs, ft;
 
@@ -2036,10 +2044,65 @@ dcopuop:
 			rv.d = ieee754dp_fint(fs.bits);
 			rfmt = d_fmt;
 			goto copcsr;
-		default:
-			return SIGILL;
+		default: {
+			/* Emulating the new CMP.condn.fmt R6 instruction */
+#define CMPOP_MASK	0x7
+#define SIGN_BIT	(0x1 << 3)
+#define PREDICATE_BIT	(0x1 << 4)
+
+			int cmpop = MIPSInst_FUNC(ir) & CMPOP_MASK;
+			int sig = MIPSInst_FUNC(ir) & SIGN_BIT;
+			union ieee754sp fs, ft;
+
+			/* This is an R6 only instruction */
+			if (!cpu_has_mips_r6 ||
+			    (MIPSInst_FUNC(ir) & 0x20))
+				return SIGILL;
+
+			/* fmt is w_fmt for single precision so fix it */
+			rfmt = s_fmt;
+			/* default to false */
+			rv.w = 0;
+
+			/* CMP.condn.S */
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			SPFROMREG(ft, MIPSInst_FT(ir));
+
+			/* positive predicates */
+			if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+				if (ieee754sp_cmp(fs, ft, cmptab[cmpop],
+						  sig))
+				    rv.w = -1; /* true, all 1s */
+				if ((sig) &&
+				    ieee754_cxtest(IEEE754_INVALID_OPERATION))
+					rcsr = FPU_CSR_INV_X | FPU_CSR_INV_S;
+				else
+					goto copcsr;
+			} else {
+				/* negative predicates */
+				switch (cmpop) {
+				case 1:
+				case 2:
+				case 3:
+					if (ieee754sp_cmp(fs, ft,
+							  negative_cmptab[cmpop],
+							  sig))
+						rv.w = -1; /* true, all 1s */
+					if (sig &&
+					    ieee754_cxtest(IEEE754_INVALID_OPERATION))
+						rcsr = FPU_CSR_INV_X | FPU_CSR_INV_S;
+					else
+						goto copcsr;
+					break;
+				default:
+					/* Reserved R6 ops */
+					pr_err("Reserved MIPS R6 CMP.condn.S operation\n");
+					return SIGILL;
+				}
+			}
+			break;
+			}
 		}
-		break;
 	}
 
 	case l_fmt:
@@ -2060,11 +2123,60 @@ dcopuop:
 			rv.d = ieee754dp_flong(bits);
 			rfmt = d_fmt;
 			goto copcsr;
-		default:
-			return SIGILL;
-		}
-		break;
+		default: {
+			/* Emulating the new CMP.condn.fmt R6 instruction */
+			int cmpop = MIPSInst_FUNC(ir) & CMPOP_MASK;
+			int sig = MIPSInst_FUNC(ir) & SIGN_BIT;
+			union ieee754dp fs, ft;
+
+			if (!cpu_has_mips_r6 ||
+			    (MIPSInst_FUNC(ir) & 0x20))
+				return SIGILL;
 
+			/* fmt is l_fmt for double precision so fix it */
+			rfmt = d_fmt;
+			/* default to false */
+			rv.l = 0;
+
+			/* CMP.condn.D */
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			DPFROMREG(ft, MIPSInst_FT(ir));
+
+			/* positive predicates */
+			if (!(MIPSInst_FUNC(ir) & PREDICATE_BIT)) {
+				if (ieee754dp_cmp(fs, ft,
+						  cmptab[cmpop], sig))
+				    rv.l = -1LL; /* true, all 1s */
+				if (sig &&
+				    ieee754_cxtest(IEEE754_INVALID_OPERATION))
+					rcsr = FPU_CSR_INV_X | FPU_CSR_INV_S;
+				else
+					goto copcsr;
+			} else {
+				/* negative predicates */
+				switch (cmpop) {
+				case 1:
+				case 2:
+				case 3:
+					if (ieee754dp_cmp(fs, ft,
+							  negative_cmptab[cmpop],
+							  sig))
+						rv.l = -1LL; /* true, all 1s */
+					if (sig &&
+					    ieee754_cxtest(IEEE754_INVALID_OPERATION))
+						rcsr = FPU_CSR_INV_X | FPU_CSR_INV_S;
+					else
+						goto copcsr;
+					break;
+				default:
+					/* Reserved R6 ops */
+					pr_err("Reserved MIPS R6 CMP.condn.D operation\n");
+					return SIGILL;
+				}
+			}
+			break;
+			}
+		}
 	default:
 		return SIGILL;
 	}
-- 
2.5.0
