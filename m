Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 16:38:07 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:37203 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993969AbdCMPgu1T4pT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Mar 2017 16:36:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id E6BF31A458A;
        Mon, 13 Mar 2017 16:36:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (rtrkw197-lin.domain.local [10.10.13.80])
        by mail.rt-rk.com (Postfix) with ESMTPSA id C2DD11A462E;
        Mon, 13 Mar 2017 16:36:42 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com
Cc:     leonid.yegoshin@imgtec.com, douglas.leung@imgtec.com,
        aleksandar.markovic@imgtec.com, petar.jovanovic@imgtec.com,
        miodrag.dinic@imgtec.com, goran.ferenc@imgtec.com
Subject: [PATCH 3/3] MIPS: math-emu: Fix BC1EQZ and BC1NEZ condition handling
Date:   Mon, 13 Mar 2017 16:36:37 +0100
Message-Id: <1489419397-25291-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1489419397-25291-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1489419397-25291-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57157
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

From: Douglas Leung <douglas.leung@imgtec.com>

Correct the treatment of branching conditions for BC1EQZ and BC1NEZ
instructions in function isBranchInstr().

Previously, corresponding conditions were swapped, which in turn meant
that, for these two instructions, function isBranchInstr() returned
wrong value in its output parameter contpc.

This change is actually an extension of the fix done by the commit
93583e178ebf ("MIPS: math-emu: Fix BC1{EQ,NE}Z emulation"). That commit
dealt with a similar problem in function cop1Emulate(), while this
commit deals with condition handling in function isBranchInstr().
The code styles of changes in these two commits are kept as
consistent as possible.

Signed-off-by: Douglas Leung <douglas.leung@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index a298ac9..f12fde1 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -439,6 +439,8 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	union mips_instruction insn = (union mips_instruction)dec_insn.insn;
 	unsigned int fcr31;
 	unsigned int bit = 0;
+	unsigned int bit0;
+	union fpureg *fpr;
 
 	switch (insn.i_format.opcode) {
 	case spec_op:
@@ -706,14 +708,14 @@ int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		    ((insn.i_format.rs == bc1eqz_op) ||
 		     (insn.i_format.rs == bc1nez_op))) {
 			bit = 0;
+			fpr = &current->thread.fpu.fpr[insn.i_format.rt];
+			bit0 = get_fpr32(fpr, 0) & 0x1;
 			switch (insn.i_format.rs) {
 			case bc1eqz_op:
-				if (get_fpr32(&current->thread.fpu.fpr[insn.i_format.rt], 0) & 0x1)
-				    bit = 1;
+				bit = bit0 == 0;
 				break;
 			case bc1nez_op:
-				if (!(get_fpr32(&current->thread.fpu.fpr[insn.i_format.rt], 0) & 0x1))
-				    bit = 1;
+				bit = bit0 != 0;
 				break;
 			}
 			if (bit)
-- 
2.7.4
