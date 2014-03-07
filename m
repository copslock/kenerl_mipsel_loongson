Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2014 02:05:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.114]:48683 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823083AbaCGBFtllZKH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Mar 2014 02:05:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2E447860E8839
        for <linux-mips@linux-mips.org>; Fri,  7 Mar 2014 01:05:40 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 7 Mar
 2014 01:05:43 +0000
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Fri, 7 Mar 2014 01:05:43 +0000
Received: from fun-lab.mips.com (192.168.136.61) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 6 Mar
 2014 17:05:41 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <paul.burton@imgtec.com>, <Leonid.Yegoshin@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH] MIPS FPU emulator: Fix prefx detection and COP1X function field definition
Date:   Thu, 6 Mar 2014 17:05:27 -0800
Message-ID: <1394154327-16677-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39438
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

When running applications which contain the instruction "prefx" on FPU-less
CPUs, a message "Illegal instruction" will be seen. This instruction is
supposed to be ignored by the FPU emulator. However, its current detection
and function field encoding are incorrect. This patch fix the issue.

Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 4 ++--
 arch/mips/math-emu/cp1emu.c       | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b39ba25..0832fac 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -163,8 +163,8 @@ enum cop1_sdw_func {
  */
 enum cop1x_func {
 	lwxc1_op     =	0x00, ldxc1_op	   =  0x01,
-	pfetch_op    =	0x07, swxc1_op	   =  0x08,
-	sdxc1_op     =	0x09, madd_s_op	   =  0x20,
+	swxc1_op     =  0x08, sdxc1_op	   =  0x09,
+	pfetch_op    =	0x0f, madd_s_op	   =  0x20,
 	madd_d_op    =	0x21, madd_e_op	   =  0x22,
 	msub_s_op    =	0x28, msub_d_op	   =  0x29,
 	msub_e_op    =	0x2a, nmadd_s_op   =  0x30,
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 506925b..0b4e2e3 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1538,10 +1538,10 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		break;
 	}
 
-	case 0x7:		/* 7 */
-		if (MIPSInst_FUNC(ir) != pfetch_op) {
+	case 0x3:
+		if (MIPSInst_FUNC(ir) != pfetch_op)
 			return SIGILL;
-		}
+
 		/* ignore prefx operation */
 		break;
 
-- 
1.8.5.3
