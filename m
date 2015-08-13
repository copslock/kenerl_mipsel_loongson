Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 10:00:27 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27012101AbbHMH6uCEf74 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:58:50 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 07/10] MIPS: math-emu: Add support for the MIPS R6 RINT FPU instruction
Date:   Thu, 13 Aug 2015 09:56:33 +0200
Message-Id: <1439452596-16759-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48838
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

MIPS R6 introduced the following instruction:
Floating-Point Round to Integral
Scalar floating-point round to integral floating point value.

RINT.fmt: FPR[fd] = round_int(FPR[fs])

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 69da5a89e72c..6b09b37ff50a 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1773,6 +1773,18 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 		}
 
+		case frint_op: {
+			union ieee754sp fs;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(fs, MIPSInst_FS(ir));
+			rv.l = ieee754sp_tlong(fs);
+			rv.s = ieee754sp_flong(rv.l);
+			goto copcsr;
+		}
+
 		case fabs_op:
 			handler.u = ieee754sp_abs;
 			goto scopuop;
@@ -2019,6 +2031,18 @@ copcsr:
 			break;
 		}
 
+		case frint_op: {
+			union ieee754dp fs;
+
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(fs, MIPSInst_FS(ir));
+			rv.l = ieee754dp_tlong(fs);
+			rv.d = ieee754dp_flong(rv.l);
+			goto copcsr;
+		}
+
 		case fabs_op:
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
-- 
2.5.0
