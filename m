Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 13:50:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52389 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823034Ab3KGMszPDLM- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 13:48:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/6] mips: mfhc1 & mthc1 support for the FPU emulator
Date:   Thu, 7 Nov 2013 12:48:28 +0000
Message-ID: <1383828513-28462-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
References: <1383828513-28462-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_07_12_48_49
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

This patch adds support for the mfhc1 & mthc1 instructions to the FPU
emulator. These instructions were introduced in release 2 of the mips32
& mips64 architectures, and allow access to the most significant 32 bits
of a 64-bit FP register.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |  5 +++--
 arch/mips/math-emu/cp1emu.c       | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index e5a676e..0ee9656 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -98,8 +98,9 @@ enum rt_op {
  */
 enum cop_op {
 	mfc_op	      = 0x00, dmfc_op	    = 0x01,
-	cfc_op	      = 0x02, mtc_op	    = 0x04,
-	dmtc_op	      = 0x05, ctc_op	    = 0x06,
+	cfc_op	      = 0x02, mfhc_op	    = 0x03,
+	mtc_op        = 0x04, dmtc_op	    = 0x05,
+	ctc_op	      = 0x06, mthc_op	    = 0x07,
 	bc_op	      = 0x08, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index efe0088..20a51d0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -878,6 +878,10 @@ static inline int cop1_64bit(struct pt_regs *xcp)
 			ctx->fpr[x & ~1] >> 32 << 32 | (u32)(si) : \
 			ctx->fpr[x & ~1] << 32 >> 32 | (u64)(si) << 32)
 
+#define SIFROMHREG(si, x)	((si) = (int)(ctx->fpr[x] >> 32))
+#define SITOHREG(si, x)		(ctx->fpr[x] = \
+				ctx->fpr[x] << 32 >> 32 | (u64)(si) << 32)
+
 #define DIFROMREG(di, x) ((di) = ctx->fpr[x & ~(cop1_64bit(xcp) == 0)])
 #define DITOREG(di, x)	(ctx->fpr[x & ~(cop1_64bit(xcp) == 0)] = (di))
 
@@ -1055,6 +1059,21 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			break;
 #endif
 
+#ifdef CONFIG_CPU_MIPSR2
+		case mfhc_op:
+			/* copregister rd -> gpr[rt] */
+			if (MIPSInst_RT(ir) != 0) {
+				SIFROMHREG(xcp->regs[MIPSInst_RT(ir)],
+					MIPSInst_RD(ir));
+			}
+			break;
+
+		case mthc_op:
+			/* copregister rd <- gpr[rt] */
+			SITOHREG(xcp->regs[MIPSInst_RT(ir)], MIPSInst_RD(ir));
+			break;
+#endif
+
 		case mfc_op:
 			/* copregister rd -> gpr[rt] */
 			if (MIPSInst_RT(ir) != 0) {
-- 
1.8.4.1
