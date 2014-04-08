Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:49:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:33983 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822515AbaDHLr3g7ZD- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0D15DF60BEE95
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:18 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:19 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:19 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:18 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 08/14] MIPS: uasm: Add sltiu uasm instruction
Date:   Tue, 8 Apr 2014 12:47:09 +0100
Message-ID: <1396957635-27071-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

It will be used later on by bpf-jit

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uasm.h  | 1 +
 arch/mips/mm/uasm-micromips.c | 1 +
 arch/mips/mm/uasm-mips.c      | 1 +
 arch/mips/mm/uasm.c           | 7 ++++---
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 61c8cce..340b34a 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -143,6 +143,7 @@ Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
 Ip_u2u1u3(_sll);
 Ip_u3u2u1(_sllv);
+Ip_u2u1s3(_sltiu);
 Ip_u2u1u3(_sra);
 Ip_u2u1u3(_srl);
 Ip_u3u2u1(_srlv);
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index a6f0686..929d887 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -98,6 +98,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_sd, 0, 0 },
 	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
 	{ insn_sllv, M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD },
+	{ insn_sltiu, M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
 	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
 	{ insn_srlv, M(mm_pool32a_op, 0, 0, 0, 0, mm_srlv32_op), RT | RS | RD },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 6e295c2..d2a56a6 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -106,6 +106,7 @@ static struct insn insn_table[] = {
 	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
 	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
+	{ insn_sltiu, M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
 	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
 	{ insn_srlv,  M(spec_op, 0, 0, 0, 0, srlv_op),  RS | RT | RD },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 87d233d..d451266 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -52,9 +52,9 @@ enum opcode {
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_ld,
 	insn_ldx, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
 	insn_mfhi, insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
-	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_sra, insn_srl,
-	insn_srlv, insn_subu, insn_sw, insn_syscall, insn_tlbp, insn_tlbr,
-	insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
+	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_sltiu, insn_sra,
+	insn_srl, insn_srlv, insn_subu, insn_sw, insn_syscall, insn_tlbp,
+	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -283,6 +283,7 @@ I_u2s3u1(_scd)
 I_u2s3u1(_sd)
 I_u2u1u3(_sll)
 I_u3u2u1(_sllv)
+I_u2u1s3(_sltiu)
 I_u2u1u3(_sra)
 I_u2u1u3(_srl)
 I_u3u2u1(_srlv)
-- 
1.9.1
