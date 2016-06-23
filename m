Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:35:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20131 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043841AbcFWQe6bGhkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:34:58 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 45ADE86E7D6AB;
        Thu, 23 Jun 2016 17:34:48 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:51 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 01/14] MIPS: uasm: Add CFC1/CTC1 instructions
Date:   Thu, 23 Jun 2016 17:34:34 +0100
Message-ID: <1466699687-24791-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54138
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

Add CFC1/CTC1 instructions for accessing FP control registers to uasm so
that KVM can use uasm for generating its entry point code at runtime.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/uasm.h  |  2 ++
 arch/mips/mm/uasm-micromips.c |  8 ++++++--
 arch/mips/mm/uasm-mips.c      |  2 ++
 arch/mips/mm/uasm.c           | 26 ++++++++++++++------------
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b6ecfeee4dbe..3153ada46e9a 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -104,6 +104,8 @@ Ip_u1s2(_bltz);
 Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
 Ip_u2s3u1(_cache);
+Ip_u1u2(_cfc1);
+Ip_u1u2(_ctc1);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
 Ip_u2u1msbu3(_dins);
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index d78178daea4b..8b1acb2f6b8b 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -53,6 +53,8 @@ static struct insn insn_table_MM[] = {
 	{ insn_bltzl, 0, 0 },
 	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
 	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
+	{ insn_cfc1, M(mm_pool32f_op, 0, 0, 0, mm_cfc1_op, mm_32f_73_op), RT | RS },
+	{ insn_ctc1, M(mm_pool32f_op, 0, 0, 0, mm_ctc1_op, mm_32f_73_op), RT | RS },
 	{ insn_daddu, 0, 0 },
 	{ insn_daddiu, 0, 0 },
 	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
@@ -166,13 +168,15 @@ static void build_insn(u32 **buf, enum opcode opc, ...)
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS) {
-		if (opc == insn_mfc0 || opc == insn_mtc0)
+		if (opc == insn_mfc0 || opc == insn_mtc0 ||
+		    opc == insn_cfc1 || opc == insn_ctc1)
 			op |= build_rt(va_arg(ap, u32));
 		else
 			op |= build_rs(va_arg(ap, u32));
 	}
 	if (ip->fields & RT) {
-		if (opc == insn_mfc0 || opc == insn_mtc0)
+		if (opc == insn_mfc0 || opc == insn_mtc0 ||
+		    opc == insn_cfc1 || opc == insn_ctc1)
 			op |= build_rs(va_arg(ap, u32));
 		else
 			op |= build_rt(va_arg(ap, u32));
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 9c2220a45189..5152544962c3 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -67,6 +67,8 @@ static struct insn insn_table[] = {
 #else
 	{ insn_cache,  M6(cache_op, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
 #endif
+	{ insn_cfc1, M(cop1_op, cfc_op, 0, 0, 0, 0), RT | RD },
+	{ insn_ctc1, M(cop1_op, ctc_op, 0, 0, 0, 0), RT | RD },
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index ad718debc35a..4731893db3f7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,18 +49,18 @@ enum opcode {
 	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
-	insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
-	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
-	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
-	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
-	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
-	insn_mthc0, insn_mul, insn_or, insn_ori, insn_pref, insn_rfe,
-	insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_slt,
-	insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu,
-	insn_sw, insn_sync, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi,
-	insn_tlbwr, insn_wait, insn_wsbh, insn_xor, insn_xori, insn_yield,
-	insn_lddir, insn_ldpte,
+	insn_bne, insn_cache, insn_cfc1, insn_ctc1, insn_daddiu, insn_daddu,
+	insn_dins, insn_dinsm, insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr,
+	insn_drotr32, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
+	insn_dsubu, insn_eret, insn_ext, insn_ins, insn_j, insn_jal, insn_jalr,
+	insn_jr, insn_lb, insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld,
+	insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
+	insn_mflo, insn_mtc0, insn_mthc0, insn_mul, insn_or, insn_ori,
+	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
+	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
+	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
+	insn_xori, insn_yield, insn_lddir, insn_ldpte,
 };
 
 struct insn {
@@ -268,6 +268,8 @@ I_u1s2(_bltz)
 I_u1s2(_bltzl)
 I_u1u2s3(_bne)
 I_u2s3u1(_cache)
+I_u1u2(_cfc1)
+I_u1u2(_ctc1)
 I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
 I_u2u1s3(_daddiu)
-- 
2.4.10
