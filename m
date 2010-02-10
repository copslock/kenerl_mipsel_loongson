Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:15:07 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15983 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492377Ab0BJXNw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:13:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733db60001>; Wed, 10 Feb 2010 15:13:58 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1ANCnvJ005831;
        Wed, 10 Feb 2010 15:12:49 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1ANCn86005830;
        Wed, 10 Feb 2010 15:12:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/6] MIPS: Add TLBR and ROTR to uasm.
Date:   Wed, 10 Feb 2010 15:12:46 -0800
Message-Id: <1265843569-5786-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
X-OriginalArrivalTime: 10 Feb 2010 23:12:52.0410 (UTC) FILETIME=[91FDC1A0:01CAAAA6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The soon to follow Read Inhibit/eXecute Inhibit patch needs TLBR and
ROTR support in uasm.  We also add a UASM_i_ROTR macro.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    4 ++++
 arch/mips/mm/uasm.c          |    9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3d153ed..b99bd07 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -92,9 +92,11 @@ Ip_u2s3u1(_sd);
 Ip_u2u1u3(_sll);
 Ip_u2u1u3(_sra);
 Ip_u2u1u3(_srl);
+Ip_u2u1u3(_rotr);
 Ip_u3u1u2(_subu);
 Ip_u2s3u1(_sw);
 Ip_0(_tlbp);
+Ip_0(_tlbr);
 Ip_0(_tlbwi);
 Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
@@ -129,6 +131,7 @@ static inline void __cpuinit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
+# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_drotr(buf, rs, rt, sh)
 # define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
 # define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
 # define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
@@ -142,6 +145,7 @@ static inline void __cpuinit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
+# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_rotr(buf, rs, rt, sh)
 # define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
 # define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
 # define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index e3ca0f7..1581e98 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -62,8 +62,9 @@ enum opcode {
 	insn_dsrl32, insn_drotr, insn_dsubu, insn_eret, insn_j, insn_jal,
 	insn_jr, insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
 	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
-	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori, insn_dins
+	insn_sd, insn_sll, insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw,
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
+	insn_dins
 };
 
 struct insn {
@@ -125,9 +126,11 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
 	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
 	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
 	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
 	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
+	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
 	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
@@ -378,9 +381,11 @@ I_u2s3u1(_sd)
 I_u2u1u3(_sll)
 I_u2u1u3(_sra)
 I_u2u1u3(_srl)
+I_u2u1u3(_rotr)
 I_u3u1u2(_subu)
 I_u2s3u1(_sw)
 I_0(_tlbp)
+I_0(_tlbr)
 I_0(_tlbwi)
 I_0(_tlbwr)
 I_u3u1u2(_xor)
-- 
1.6.2.5
