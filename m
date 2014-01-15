Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:00:48 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38390 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827340AbaAOOAqc0Caq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:00:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/10] MIPS: uasm: add wait instruction
Date:   Wed, 15 Jan 2014 13:55:31 +0000
Message-ID: <1389794137-11361-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 39005
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

This patch allows use of the wait instruction from uasm. It will be used
by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h  | 1 +
 arch/mips/mm/uasm-micromips.c | 1 +
 arch/mips/mm/uasm-mips.c      | 1 +
 arch/mips/mm/uasm.c           | 5 +++--
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 4f4ed49..7458a94 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -143,6 +143,7 @@ Ip_0(_tlbp);
 Ip_0(_tlbr);
 Ip_0(_tlbwi);
 Ip_0(_tlbwr);
+Ip_u1(_wait);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
 
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 15b46da..1150eda 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -105,6 +105,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
+	{ insn_wait, M(mm_pool32a_op, 0, 0, 0, mm_wait_op, mm_pool32axf_op), SCIMM },
 	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
 	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
 	{ insn_dins, 0, 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 07ec837..343840a 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -113,6 +113,7 @@ static struct insn insn_table[] = {
 	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
 	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
+	{ insn_wait, M(cop0_op, cop_op, 0, 0, 0, wait_op), SCIMM },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_invalid, 0, 0 }
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index e688800..1b42934 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -53,8 +53,8 @@ enum opcode {
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
 	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw, insn_sync,
-	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor,
-	insn_xori,
+	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
+	insn_xor, insn_xori,
 };
 
 struct insn {
@@ -275,6 +275,7 @@ I_0(_tlbp)
 I_0(_tlbr)
 I_0(_tlbwi)
 I_0(_tlbwr)
+I_u1(_wait);
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
 I_u2u1msbu3(_dins);
-- 
1.8.4.2
