Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:36:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52087 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992316AbcGDSfjH-S37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8C4179A4EF47;
        Mon,  4 Jul 2016 19:35:29 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 2/9] MIPS: inst.h: Rename cbcond{0,1}_op to pop{1,3}0_op
Date:   Mon, 4 Jul 2016 19:35:08 +0100
Message-ID: <1467657315-19975-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
References: <1467657315-19975-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

The opcodes currently defined in inst.h as cbcond0_op & cbcond1_op are
actually defined in the MIPS base instruction set manuals as pop10 &
pop30 respectively. Rename them as such, for consistency with the
documentation.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/inst.h | 4 ++--
 arch/mips/kernel/branch.c         | 4 ++--
 arch/mips/math-emu/cp1emu.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 3fc00e7b33c4..77429d1622b3 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -21,11 +21,11 @@
 enum major_op {
 	spec_op, bcond_op, j_op, jal_op,
 	beq_op, bne_op, blez_op, bgtz_op,
-	addi_op, cbcond0_op = addi_op, addiu_op, slti_op, sltiu_op,
+	addi_op, pop10_op = addi_op, addiu_op, slti_op, sltiu_op,
 	andi_op, ori_op, xori_op, lui_op,
 	cop0_op, cop1_op, cop2_op, cop1x_op,
 	beql_op, bnel_op, blezl_op, bgtzl_op,
-	daddi_op, cbcond1_op = daddi_op, daddiu_op, ldl_op, ldr_op,
+	daddi_op, pop30_op = daddi_op, daddiu_op, ldl_op, ldr_op,
 	spec2_op, jalx_op, mdmx_op, msa_op = mdmx_op, spec3_op,
 	lb_op, lh_op, lwl_op, lw_op,
 	lbu_op, lhu_op, lwr_op, lwu_op,
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index fb9ed96d7858..46c227fc98f5 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -809,8 +809,8 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		regs->cp0_epc += 8;
 		break;
 #endif
-	case cbcond0_op:
-	case cbcond1_op:
+	case pop10_op:
+	case pop30_op:
 		/* Only valid for MIPS R6 */
 		if (!cpu_has_mips_r6) {
 			ret = -SIGILL;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 1bbf16581f19..6dc07fba187f 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -627,8 +627,8 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 				dec_insn.pc_inc +
 				dec_insn.next_pc_inc;
 		return 1;
-	case cbcond0_op:
-	case cbcond1_op:
+	case pop10_op:
+	case pop30_op:
 		if (!cpu_has_mips_r6)
 			break;
 		if (insn.i_format.rt && !insn.i_format.rs)
-- 
2.4.10
