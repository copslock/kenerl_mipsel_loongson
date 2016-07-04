Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2016 20:36:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47764 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992272AbcGDSfi0SZk7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jul 2016 20:35:38 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3BA1FD05582C9;
        Mon,  4 Jul 2016 19:35:28 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 4 Jul 2016 19:35:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/9] MIPS: inst.h: Rename b{eq,ne}zcji[al]c_op to pop{6,7}6_op
Date:   Mon, 4 Jul 2016 19:35:07 +0100
Message-ID: <1467657315-19975-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54200
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

The opcodes currently defined in inst.h as beqzcjic_op & bnezcjialc_op
are actually defined in the MIPS base instruction set manuals as pop66 &
pop76 respectively. Rename them as such, for consistency with the
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
index fc96012c75d1..3fc00e7b33c4 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -32,9 +32,9 @@ enum major_op {
 	sb_op, sh_op, swl_op, sw_op,
 	sdl_op, sdr_op, swr_op, cache_op,
 	ll_op, lwc1_op, lwc2_op, bc6_op = lwc2_op, pref_op,
-	lld_op, ldc1_op, ldc2_op, beqzcjic_op = ldc2_op, ld_op,
+	lld_op, ldc1_op, ldc2_op, pop66_op = ldc2_op, ld_op,
 	sc_op, swc1_op, swc2_op, balc6_op = swc2_op, major_3b_op,
-	scd_op, sdc1_op, sdc2_op, bnezcjialc_op = sdc2_op, sd_op
+	scd_op, sdc1_op, sdc2_op, pop76_op = sdc2_op, sd_op
 };
 
 /*
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 6dc3f1fdaccc..fb9ed96d7858 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -790,7 +790,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		epc += 4 + (insn.i_format.simmediate << 2);
 		regs->cp0_epc = epc;
 		break;
-	case beqzcjic_op:
+	case pop66_op:
 		if (!cpu_has_mips_r6) {
 			ret = -SIGILL;
 			break;
@@ -798,7 +798,7 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
 		/* Compact branch: BEQZC || JIC */
 		regs->cp0_epc += 8;
 		break;
-	case bnezcjialc_op:
+	case pop76_op:
 		if (!cpu_has_mips_r6) {
 			ret = -SIGILL;
 			break;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index d96e912b9d44..1bbf16581f19 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -683,14 +683,14 @@ static int isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 			dec_insn.next_pc_inc;
 
 		return 1;
-	case beqzcjic_op:
+	case pop66_op:
 		if (!cpu_has_mips_r6)
 			break;
 		*contpc = regs->cp0_epc + dec_insn.pc_inc +
 			dec_insn.next_pc_inc;
 
 		return 1;
-	case bnezcjialc_op:
+	case pop76_op:
 		if (!cpu_has_mips_r6)
 			break;
 		if (!insn.i_format.rs)
-- 
2.4.10
