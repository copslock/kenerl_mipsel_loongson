Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 10:52:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58140 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008520AbbFXIwV7T8Yx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 10:52:21 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 67B59EC4D77E9;
        Wed, 24 Jun 2015 09:52:14 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Jun 2015 09:52:16 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 24 Jun 2015 09:52:15 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: Fix branch emulation for BLTC and BGEC instructions
Date:   Wed, 24 Jun 2015 09:52:00 +0100
Message-ID: <1435135921-7090-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435135921-7090-1-git-send-email-markos.chandras@imgtec.com>
References: <1435135921-7090-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48020
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

Commits f1b44067c19258b7614e3cd09dfe8d8e12ff5895 ("MIPS: Emulate the
new MIPS R6 B{L,G}T{Z,}{AL,}C instructions") and commit
a8ff66f52d3f17b5ae793955270675c197f73d6c ("MIPS: Emulate the new MIPS
R6 B{L,G}E{Z,}{AL,}C instructions") added support for emulating various
branch compact instructions. However, it missed the case for those which
use the old BLEZL and BGTZL opcodes leading to random crashes when the R6
emulator is disabled. We fix this by ensuring that the 'rt' field is not
zero which is always true for these branch compact instructions.

Fixes: f1b44067c192 ("MIPS: Emulate the new MIPS R6 B{L,G}T{Z,}{AL,}C instructions")
Fixes: a8ff66f52d3f ("MIPS: Emulate the new MIPS R6 B{L,G}E{Z,}{AL,}C instructions")
Cc: <stable@vger.kernel.org> # 4.0+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/branch.c   | 4 ++--
 arch/mips/math-emu/cp1emu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index c0c5e5972256..d8f9b357b222 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -600,7 +600,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		break;
 
 	case blezl_op: /* not really i_format */
-		if (NO_R6EMU)
+		if (!insn.i_format.rt && NO_R6EMU)
 			goto sigill_r6;
 	case blez_op:
 		/*
@@ -635,7 +635,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		break;
 
 	case bgtzl_op:
-		if (NO_R6EMU)
+		if (!insn.i_format.rt && NO_R6EMU)
 			goto sigill_r6;
 	case bgtz_op:
 		/*
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 22b9b2cb9219..00c241ae04ce 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -551,7 +551,7 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.next_pc_inc;
 		return 1;
 	case blezl_op:
-		if (NO_R6EMU)
+		if (!insn.i_format.rt && NO_R6EMU)
 			break;
 	case blez_op:
 
@@ -588,7 +588,7 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.next_pc_inc;
 		return 1;
 	case bgtzl_op:
-		if (NO_R6EMU)
+		if (!insn.i_format.rt && NO_R6EMU)
 			break;
 	case bgtz_op:
 		/*
-- 
2.4.4
