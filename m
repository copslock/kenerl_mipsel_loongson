Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:36:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37978 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043846AbcFWQfA1s9sz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 53CB6448D937D;
        Thu, 23 Jun 2016 17:34:50 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:53 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 04/14] MIPS: uasm: Add MTHI/MTLO instructions
Date:   Thu, 23 Jun 2016 17:34:37 +0100
Message-ID: <1466699687-24791-5-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54141
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

Add MTHI/MTLO instructions for writing to the hi & lo registers to uasm
so that KVM can use uasm for generating its entry point code at runtime.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/uasm.h      |  2 ++
 arch/mips/include/uapi/asm/inst.h |  2 ++
 arch/mips/mm/uasm-micromips.c     |  2 ++
 arch/mips/mm/uasm-mips.c          |  2 ++
 arch/mips/mm/uasm.c               | 13 ++++++++-----
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 4af8a5becbbb..f7929f65f7ca 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -146,6 +146,8 @@ Ip_u1(_mfhi);
 Ip_u1(_mflo);
 Ip_u1u2u3(_mtc0);
 Ip_u1u2u3(_mthc0);
+Ip_u1(_mthi);
+Ip_u1(_mtlo);
 Ip_u3u1u2(_mul);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 7010d0b7b752..6319c5037e66 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -375,7 +375,9 @@ enum mm_32axf_minor_op {
 	mm_mflo32_op = 0x075,
 	mm_jalrhb_op = 0x07c,
 	mm_tlbwi_op = 0x08d,
+	mm_mthi32_op = 0x0b5,
 	mm_tlbwr_op = 0x0cd,
+	mm_mtlo32_op = 0x0f5,
 	mm_di_op = 0x11d,
 	mm_jalrs_op = 0x13c,
 	mm_jalrshb_op = 0x17c,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 40bef28f192c..277cf52d80e1 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -89,6 +89,8 @@ static struct insn insn_table_MM[] = {
 	{ insn_mfhi, M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS },
 	{ insn_mflo, M(mm_pool32a_op, 0, 0, 0, mm_mflo32_op, mm_pool32axf_op), RS },
 	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_mthi, M(mm_pool32a_op, 0, 0, 0, mm_mthi32_op, mm_pool32axf_op), RS },
+	{ insn_mtlo, M(mm_pool32a_op, 0, 0, 0, mm_mtlo32_op, mm_pool32axf_op), RS },
 	{ insn_mul, M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD },
 	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
 	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 2b7d85b8241f..86a3c76a1ad8 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -119,6 +119,8 @@ static struct insn insn_table[] = {
 	{ insn_mflo,  M(spec_op, 0, 0, 0, 0, mflo_op), RD },
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mthc0,  M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mthi,  M(spec_op, 0, 0, 0, 0, mthi_op), RS },
+	{ insn_mtlo,  M(spec_op, 0, 0, 0, 0, mtlo_op), RS },
 	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 006fb05b74a7..3e0282d301d6 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -56,11 +56,12 @@ enum opcode {
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
 	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
 	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
-	insn_mthc0, insn_mul, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
-	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu,
-	insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync,
-	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
-	insn_wsbh, insn_xor, insn_xori, insn_yield, insn_lddir, insn_ldpte,
+	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_or, insn_ori,
+	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
+	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
+	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
+	insn_xori, insn_yield, insn_lddir, insn_ldpte,
 };
 
 struct insn {
@@ -306,6 +307,8 @@ I_u1(_mfhi)
 I_u1(_mflo)
 I_u1u2u3(_mtc0)
 I_u1u2u3(_mthc0)
+I_u1(_mthi)
+I_u1(_mtlo)
 I_u3u1u2(_mul)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
-- 
2.4.10
