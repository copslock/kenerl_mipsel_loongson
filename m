Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:27:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54142 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009208AbaLRPNYOSaGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:13:24 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 17DE52F9F6A5D
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:13:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:13:23 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:13:22 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 59/67] MIPS: kernel: branch: Emulate the BEQZC and JIC instructions
Date:   Thu, 18 Dec 2014 15:10:08 +0000
Message-ID: <1418915416-3196-60-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44791
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

MIPS R6 uses the <R6 ldc2 opcode for the new BEQZC and JIC instructions

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/branch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 426f876403d0..4473c23cacf2 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -802,6 +802,15 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		epc = epc + 4 + (insn.i_format.simmediate << 2);
 		regs->cp0_epc = epc;
 		break;
+	case ldc2_or_bzcjic_op:
+		/* Compact branch: BEQZC || JIC */
+		if (insn.i_format.rs) /* BEQZC */
+			epc = epc + 8;
+		else /* JIC */
+			epc = regs->regs[insn.i_format.rt] +
+				insn.i_format.simmediate;
+		regs->cp0_epc = epc;
+		break;
 #endif
 	}
 
-- 
2.2.0
