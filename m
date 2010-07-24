Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:43:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16604 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492621Ab0GXBmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a450f0000>; Fri, 23 Jul 2010 18:42:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:11 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:11 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1g739004054;
        Fri, 23 Jul 2010 18:42:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1g4hs004053;
        Fri, 23 Jul 2010 18:42:04 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/7] MIPS: Add BBIT0 and BBIT1 instructions to uasm
Date:   Fri, 23 Jul 2010 18:41:42 -0700
Message-Id: <1279935707-3997-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jul 2010 01:42:11.0296 (UTC) FILETIME=[6F3C8600:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These are OCTEON specific instructions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    4 ++++
 arch/mips/mm/uasm.c          |   22 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3964b2e..db9d449 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -223,3 +223,7 @@ void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
 void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
+		   unsigned int bit, int lid);
+void uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
+		   unsigned int bit, int lid);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index fe041d5..636b817 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -68,7 +68,7 @@ enum opcode {
 	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
 	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
-	insn_dins, insn_syscall
+	insn_dins, insn_syscall, insn_bbit0, insn_bbit1
 };
 
 struct insn {
@@ -143,6 +143,8 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
 	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
+	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_invalid, 0, 0 }
 };
 
@@ -411,6 +413,8 @@ I_u3u1u2(_xor)
 I_u2u1u3(_xori)
 I_u2u1msbu3(_dins);
 I_u1(_syscall);
+I_u1u2s3(_bbit0);
+I_u1u2s3(_bbit1);
 
 /* Handle labels. */
 void __cpuinit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
@@ -620,3 +624,19 @@ uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
 	uasm_r_mips_pc16(r, *p, lid);
 	uasm_i_bgez(p, reg, 0);
 }
+
+void __cpuinit
+uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
+	      unsigned int bit, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bbit0(p, reg, bit, 0);
+}
+
+void __cpuinit
+uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
+	      unsigned int bit, int lid)
+{
+	uasm_r_mips_pc16(r, *p, lid);
+	uasm_i_bbit1(p, reg, bit, 0);
+}
-- 
1.7.1.1
