Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:01:11 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38391 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaAOOAqey2P3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:00:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/10] MIPS: uasm: add jr.hb instruction
Date:   Wed, 15 Jan 2014 13:55:32 +0000
Message-ID: <1389794137-11361-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_14_00_41
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch allows use of the jr.hb instruction from uasm, in order to
clear instruction hazards. It will be used by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h      |  1 +
 arch/mips/include/uapi/asm/inst.h |  7 +++++++
 arch/mips/mm/uasm-micromips.c     |  1 +
 arch/mips/mm/uasm-mips.c          |  1 +
 arch/mips/mm/uasm.c               | 13 +++++++------
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 7458a94..2d9cedd 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -115,6 +115,7 @@ Ip_u2u1msbu3(_ins);
 Ip_u1(_j);
 Ip_u1(_jal);
 Ip_u1(_jr);
+Ip_u1(_jr_hb);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
 Ip_u2s3u1(_ll);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 203f28b..e19d63e 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -196,6 +196,13 @@ enum lx_func {
 };
 
 /*
+ * hint/re field for jr instructions.
+ */
+enum jr_hint {
+	jr_hb_hint = 0x10,
+};
+
+/*
  * (microMIPS) Major opcodes.
  */
 enum mm_major_op {
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 1150eda..19ebbcd 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -80,6 +80,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
 	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
 	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
+	{ insn_jr_hb, M(mm_pool32a_op, 0, 0, 0, mm_jalrhb_op, mm_pool32axf_op), RS },
 	{ insn_ld, 0, 0 },
 	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
 	{ insn_lld, 0, 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 343840a..46ca072 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -85,6 +85,7 @@ static struct insn insn_table[] = {
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	{ insn_jr_hb,  M(spec_op, 0, 0, 0, jr_hb_hint, jr_op),  RS },
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 1b42934..f725309 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,12 +49,12 @@ enum opcode {
 	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
 	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
-	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw, insn_sync,
-	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
-	insn_xor, insn_xori,
+	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_jr_hb, insn_ld,
+	insn_ldx, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
+	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc,
+	insn_scd, insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
+	insn_sync, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr,
+	insn_wait, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -251,6 +251,7 @@ I_u2u1msbu3(_ins)
 I_u1(_j)
 I_u1(_jal)
 I_u1(_jr)
+I_u1(_jr_hb)
 I_u2s3u1(_ld)
 I_u2s3u1(_ll)
 I_u2s3u1(_lld)
-- 
1.8.4.2
