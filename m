Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:35:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8714 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043845AbcFWQe7x-1kz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:34:59 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A4C9CEFB9F023;
        Thu, 23 Jun 2016 17:34:49 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 03/14] MIPS: uasm: Add DI instruction
Date:   Thu, 23 Jun 2016 17:34:36 +0100
Message-ID: <1466699687-24791-4-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54140
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

Add DI instruction for disabling interrupts to uasm so that KVM can use
uasm for generating its entry point code at runtime.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/uasm.h      |  1 +
 arch/mips/include/uapi/asm/inst.h |  1 +
 arch/mips/mm/uasm-micromips.c     |  1 +
 arch/mips/mm/uasm-mips.c          |  1 +
 arch/mips/mm/uasm.c               | 23 ++++++++++++-----------
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index edc02687016e..4af8a5becbbb 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -110,6 +110,7 @@ Ip_u1u2(_ctc1);
 Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u1(_di);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u1u2(_divu);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 2e624dd058ef..7010d0b7b752 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -376,6 +376,7 @@ enum mm_32axf_minor_op {
 	mm_jalrhb_op = 0x07c,
 	mm_tlbwi_op = 0x08d,
 	mm_tlbwr_op = 0x0cd,
+	mm_di_op = 0x11d,
 	mm_jalrs_op = 0x13c,
 	mm_jalrshb_op = 0x17c,
 	mm_sync_op = 0x1ad,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index eba5018961eb..40bef28f192c 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -59,6 +59,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_ctcmsa, M(mm_pool32s_op, 0, msa_ctc_op, 0, 0, mm_32s_elm_op), RD | RE },
 	{ insn_daddu, 0, 0 },
 	{ insn_daddiu, 0, 0 },
+	{ insn_di, M(mm_pool32a_op, 0, 0, 0, mm_di_op, mm_pool32axf_op), RS },
 	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
 	{ insn_dmfc0, 0, 0 },
 	{ insn_dmtc0, 0, 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 9f77783f23a6..2b7d85b8241f 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -74,6 +74,7 @@ static struct insn insn_table[] = {
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
+	{ insn_di, M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
 	{ insn_divu, M(spec_op, 0, 0, 0, 0, divu_op), RS | RT },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 3affd08a262b..006fb05b74a7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -50,17 +50,17 @@ enum opcode {
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
-	insn_daddiu, insn_daddu, insn_dins, insn_dinsm, insn_divu, insn_dmfc0,
-	insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll, insn_dsll32, insn_dsra,
-	insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret, insn_ext, insn_ins,
-	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_ld, insn_ldx,
-	insn_lh, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
-	insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0, insn_mthc0, insn_mul,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra,
-	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
-	insn_xor, insn_xori, insn_yield, insn_lddir, insn_ldpte,
+	insn_daddiu, insn_daddu, insn_di, insn_dins, insn_dinsm, insn_divu,
+	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
+	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
+	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
+	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
+	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
+	insn_mthc0, insn_mul, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
+	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu,
+	insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync,
+	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
+	insn_wsbh, insn_xor, insn_xori, insn_yield, insn_lddir, insn_ldpte,
 };
 
 struct insn {
@@ -276,6 +276,7 @@ I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
+I_u1(_di);
 I_u1u2(_divu)
 I_u2u1u3(_dsll)
 I_u2u1u3(_dsll32)
-- 
2.4.10
