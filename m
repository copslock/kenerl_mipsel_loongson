Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 09:59:31 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27012009AbbHMH6mO8eT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:58:42 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 04/10] MIPS: math-emu: cp1emu: Add support for the MIPS R6 SELNEZ FPU instruction
Date:   Thu, 13 Aug 2015 09:56:30 +0200
Message-Id: <1439452596-16759-5-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48835
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
SELNEZ.fmt: FPR[fd]  FPR[ft].bit0 ? FPR[fs] : 0

Add support for emulating the single and double precision
formats of the said instruction.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 9cb46e1f8d8f..66d9a78d03ad 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1736,6 +1736,17 @@ static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 				SPFROMREG(rv.s, MIPSInst_FS(ir));
 			break;
 
+		case fselnez_op:
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			SPFROMREG(rv.s, MIPSInst_FT(ir));
+			if (rv.w & 0x1)
+				SPFROMREG(rv.s, MIPSInst_FS(ir));
+			else
+				rv.w = 0;
+			break;
+
 		case fabs_op:
 			handler.u = ieee754sp_abs;
 			goto scopuop;
@@ -1945,6 +1956,17 @@ copcsr:
 				DPFROMREG(rv.d, MIPSInst_FS(ir));
 			break;
 
+		case fselnez_op:
+			if (!cpu_has_mips_r6)
+				return SIGILL;
+
+			DPFROMREG(rv.d, MIPSInst_FT(ir));
+			if (rv.l & 0x1)
+				DPFROMREG(rv.d, MIPSInst_FS(ir));
+			else
+				rv.l = 0;
+			break;
+
 		case fabs_op:
 			handler.u = ieee754dp_abs;
 			goto dcopuop;
-- 
2.5.0
