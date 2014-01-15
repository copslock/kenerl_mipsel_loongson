Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 14:58:21 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38355 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaAON4yV2mVu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 14:56:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/10] MIPS: uasm: add sync instruction
Date:   Wed, 15 Jan 2014 13:55:30 +0000
Message-ID: <1389794137-11361-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_13_56_49
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39004
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

This patch allows use of the sync instruction from uasm. It will be used
by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h  | 1 +
 arch/mips/mm/uasm-micromips.c | 1 +
 arch/mips/mm/uasm-mips.c      | 1 +
 arch/mips/mm/uasm.c           | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index c33a956..4f4ed49 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -137,6 +137,7 @@ Ip_u2u1u3(_sra);
 Ip_u2u1u3(_srl);
 Ip_u3u1u2(_subu);
 Ip_u2s3u1(_sw);
+Ip_u1(_sync);
 Ip_u1(_syscall);
 Ip_0(_tlbp);
 Ip_0(_tlbr);
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 060000f..15b46da 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -100,6 +100,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
 	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
 	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_sync, M(mm_pool32a_op, 0, 0, 0, mm_sync_op, mm_pool32axf_op), RS },
 	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
 	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 0c72458..07ec837 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -107,6 +107,7 @@ static struct insn insn_table[] = {
 	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
 	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),	RS | RT | RD },
 	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sync, M(spec_op, 0, 0, 0, 0, sync_op), RE },
 	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
 	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
 	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index b9d14b6..e688800 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -52,7 +52,7 @@ enum opcode {
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
+	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw, insn_sync,
 	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor,
 	insn_xori,
 };
@@ -270,6 +270,7 @@ I_u2u1u3(_srl)
 I_u2u1u3(_rotr)
 I_u3u1u2(_subu)
 I_u2s3u1(_sw)
+I_u1(_sync)
 I_0(_tlbp)
 I_0(_tlbr)
 I_0(_tlbwi)
-- 
1.8.4.2
