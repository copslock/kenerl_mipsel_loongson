Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:25:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10739 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009149AbaLRPNQYEm2o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 85190B8511EB8
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:10 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:09 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 51/67] MIPS: uapi: inst: Add new BC1EQZ and BC1NEZ MIPS R6 opcodes
Date:   Thu, 18 Dec 2014 15:10:00 +0000
Message-ID: <1418915416-3196-52-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44786
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

Add new opcodes for the BC1EQZ and BC1NEZ instructions:

BC1EQZ: Branch if Cop1 (FPR) Register Bit 0 is Equal to Zero
BC1NEZ: Branch if Cop1 (FPR) Register Bit 0 is Not Equal to Zero

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h | 3 ++-
 arch/mips/kernel/branch.c         | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b7aa4c788983..648addfe1e1c 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -114,7 +114,8 @@ enum cop_op {
 	cfc_op	      = 0x02, mfhc_op	    = 0x03,
 	mtc_op        = 0x04, dmtc_op	    = 0x05,
 	ctc_op	      = 0x06, mthc_op	    = 0x07,
-	bc_op	      = 0x08, cop_op	    = 0x10,
+	bc_op	      = 0x08, bc1eqz_op     = 0x09,
+	bc1nez_op     = 0x0d, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
 
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index ba68c005aeab..a6f7af2aa6ee 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -621,9 +621,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 
 	case bgtz_op:
 	case bgtzl_op:
-		if (NO_R6EMU && insn.i_format.opcode == bgtzl_op)
+		if (NO_R6EMU && insn.i_format.opcode == bgtzl_op) {
 			/* not emulating the branch likely for R6 */
+			ret = -SIGILL;
 			break;
+		}
 		/* rt field assumed to be zero */
 		if ((long)regs->regs[insn.i_format.rs] > 0) {
 			epc = epc + 4 + (insn.i_format.simmediate << 2);
-- 
2.2.0
