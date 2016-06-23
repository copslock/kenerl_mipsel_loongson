Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:35:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39095 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043843AbcFWQe7SKvHz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:34:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EC33674DAFBDC;
        Thu, 23 Jun 2016 17:34:48 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 02/14] MIPS: uasm: Add CFCMSA/CTCMSA instructions
Date:   Thu, 23 Jun 2016 17:34:35 +0100
Message-ID: <1466699687-24791-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54139
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

Add CFCMSA/CTCMSA instructions for accessing MSA control registers to
uasm so that KVM can use uasm for generating its entry point code at
runtime.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/uasm.h      |  2 ++
 arch/mips/include/uapi/asm/inst.h | 24 +++++++++++++++++++++++-
 arch/mips/mm/uasm-micromips.c     |  2 ++
 arch/mips/mm/uasm-mips.c          |  2 ++
 arch/mips/mm/uasm.c               | 26 ++++++++++++++------------
 5 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3153ada46e9a..edc02687016e 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -105,7 +105,9 @@ Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
 Ip_u2s3u1(_cache);
 Ip_u1u2(_cfc1);
+Ip_u2u1(_cfcmsa);
 Ip_u1u2(_ctc1);
+Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
 Ip_u2u1msbu3(_dins);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index a1ebf973725c..2e624dd058ef 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -238,6 +238,21 @@ enum bshfl_func {
 };
 
 /*
+ * MSA minor opcodes.
+ */
+enum msa_func {
+	msa_elm_op = 0x19,
+};
+
+/*
+ * MSA ELM opcodes.
+ */
+enum msa_elm {
+	msa_ctc_op = 0x3e,
+	msa_cfc_op = 0x7e,
+};
+
+/*
  * func field for MSA MI10 format.
  */
 enum msa_mi10_func {
@@ -264,7 +279,7 @@ enum mm_major_op {
 	mm_pool32b_op, mm_pool16b_op, mm_lhu16_op, mm_andi16_op,
 	mm_addiu32_op, mm_lhu32_op, mm_sh32_op, mm_lh32_op,
 	mm_pool32i_op, mm_pool16c_op, mm_lwsp16_op, mm_pool16d_op,
-	mm_ori32_op, mm_pool32f_op, mm_reserved1_op, mm_reserved2_op,
+	mm_ori32_op, mm_pool32f_op, mm_pool32s_op, mm_reserved2_op,
 	mm_pool32c_op, mm_lwgp16_op, mm_lw16_op, mm_pool16e_op,
 	mm_xori32_op, mm_jals32_op, mm_addiupc_op, mm_reserved3_op,
 	mm_reserved4_op, mm_pool16f_op, mm_sb16_op, mm_beqz16_op,
@@ -479,6 +494,13 @@ enum mm_32f_73_minor_op {
 };
 
 /*
+ * (microMIPS) POOL32S minor opcodes.
+ */
+enum mm_32s_minor_op {
+	mm_32s_elm_op = 0x16,
+};
+
+/*
  * (microMIPS) POOL16C minor opcodes.
  */
 enum mm_16c_minor_op {
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 8b1acb2f6b8b..eba5018961eb 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -54,7 +54,9 @@ static struct insn insn_table_MM[] = {
 	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
 	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
 	{ insn_cfc1, M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS },
+	{ insn_cfcmsa, M(mm_pool32s_op, 0, msa_cfc_op, 0, 0, mm_32s_elm_op), RD | RE },
 	{ insn_ctc1, M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS },
+	{ insn_ctcmsa, M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE },
 	{ insn_daddu, 0, 0 },
 	{ insn_daddiu, 0, 0 },
 	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 5152544962c3..9f77783f23a6 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -68,7 +68,9 @@ static struct insn insn_table[] = {
 	{ insn_cache,  M6(cache_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
 #endif
 	{ insn_cfc1, M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD },
+	{ insn_cfcmsa, M(msa_op, 0, msa_cfc_op, 0, 0, msa_elm_op), RD | RE },
 	{ insn_ctc1, M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD },
+	{ insn_ctcmsa, M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE },
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 4731893db3f7..3affd08a262b 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,18 +49,18 @@ enum opcode {
 	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_cfc1, insn_ctc1, insn_daddiu, insn_daddu,
-	insn_dins, insn_dinsm, insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr,
-	insn_drotr32, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
-	insn_dsubu, insn_eret, insn_ext, insn_ins, insn_j, insn_jal, insn_jalr,
-	insn_jr, insn_lb, insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld,
-	insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
-	insn_mflo, insn_mtc0, insn_mthc0, insn_mul, insn_or, insn_ori,
-	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
-	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
-	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
-	insn_xori, insn_yield, insn_lddir, insn_ldpte,
+	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
+	insn_daddiu, insn_daddu, insn_dins, insn_dinsm, insn_divu, insn_dmfc0,
+	insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll, insn_dsll32, insn_dsra,
+	insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret, insn_ext, insn_ins,
+	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_ld, insn_ldx,
+	insn_lh, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
+	insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0, insn_mthc0, insn_mul,
+	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
+	insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra,
+	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
+	insn_xor, insn_xori, insn_yield, insn_lddir, insn_ldpte,
 };
 
 struct insn {
@@ -269,7 +269,9 @@ I_u1s2(_bltzl)
 I_u1u2s3(_bne)
 I_u2s3u1(_cache)
 I_u1u2(_cfc1)
+I_u2u1(_cfcmsa)
 I_u1u2(_ctc1)
+I_u2u1(_ctcmsa)
 I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
 I_u2u1s3(_daddiu)
-- 
2.4.10
