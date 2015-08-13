Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 09:58:36 +0200 (CEST)
Received: (from localhost user: 'mchandras' uid#10145 fake: STDIN
        (mchandras@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S27010918AbbHMH6ehTDC4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 09:58:34 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 01/10] MIPS: include: uapi: inst: Add new MIPS R6 FPU opcodes
Date:   Thu, 13 Aug 2015 09:56:27 +0200
Message-Id: <1439452596-16759-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
References: <1439452596-16759-1-git-send-email-markos.chandras@imgtec.com>
Return-Path: <mchandras@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48832
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

Add opcodes for the new MIPS R6 FPU instructions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index fc0cf5ac0cf7..20e234880eed 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -167,8 +167,13 @@ enum cop1_sdw_func {
 	fround_op    =	0x0c, ftrunc_op	   =  0x0d,
 	fceil_op     =	0x0e, ffloor_op	   =  0x0f,
 	fmovc_op     =	0x11, fmovz_op	   =  0x12,
-	fmovn_op     =	0x13, frecip_op	   =  0x15,
-	frsqrt_op    =	0x16, fcvts_op	   =  0x20,
+	fmovn_op     =	0x13, fseleqz_op   =  0x14,
+	frecip_op    =  0x15, frsqrt_op    =  0x16,
+	fselnez_op   =  0x17, fmaddf_op    =  0x18,
+	fmsubf_op    =  0x19, frint_op     =  0x1a,
+	fclass_op    =  0x1b, fmin_op      =  0x1c,
+	fmina_op     =  0x1d, fmax_op      =  0x1e,
+	fmaxa_op     =  0x1f, fcvts_op     =  0x20,
 	fcvtd_op     =	0x21, fcvte_op	   =  0x22,
 	fcvtw_op     =	0x24, fcvtl_op	   =  0x25,
 	fcmp_op	     =	0x30
-- 
2.5.0
