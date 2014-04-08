Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:50:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34330 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822524AbaDHLrb2sySG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7D6DB1F451434
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:21 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:21 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 11/14] MIPS: uasm: Add lh uam instruction
Date:   Tue, 8 Apr 2014 12:47:12 +0100
Message-ID: <1396957635-27071-12-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 39718
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
 arch/mips/include/asm/uasm.h  |  1 +
 arch/mips/mm/uasm-micromips.c |  1 +
 arch/mips/mm/uasm-mips.c      |  1 +
 arch/mips/mm/uasm.c           | 13 +++++++------
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index e1258f3..ec11524 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -125,6 +125,7 @@ Ip_u2u1(_jalr);
 Ip_u1(_jr);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
+Ip_u2s3u1(_lh);
 Ip_u2s3u1(_ll);
 Ip_u2s3u1(_lld);
 Ip_u1s2(_lui);
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 528526a..89df379 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -82,6 +82,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_jalr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RT | RS },
 	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
 	{ insn_ld, 0, 0 },
+	{ insn_lh, M(mm_lh32_op, 0, 0, 0, 0, 0), RS | RS | SIMM },
 	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
 	{ insn_lld, 0, 0 },
 	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index a1845dc..576ae34 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -88,6 +88,7 @@ static struct insn insn_table[] = {
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
+	{ insn_lh,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
 	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index d816a3a..96f8b5b 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -50,12 +50,12 @@ enum opcode {
 	insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_ld,
-	insn_ldx, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
-	insn_mfhi, insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
-	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_sltiu, insn_sltu,
-	insn_sra, insn_srl, insn_srlv, insn_subu, insn_sw, insn_syscall,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wsbh, insn_xor,
-	insn_xori,
+	insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx,
+	insn_mfc0, insn_mfhi, insn_mtc0, insn_or, insn_ori, insn_pref,
+	insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv,
+	insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu,
+	insn_sw, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr,
+	insn_wsbh, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -269,6 +269,7 @@ I_u1(_jal)
 I_u2u1(_jalr)
 I_u1(_jr)
 I_u2s3u1(_ld)
+I_u2s3u1(_lh)
 I_u2s3u1(_ll)
 I_u2s3u1(_lld)
 I_u1s2(_lui)
-- 
1.9.1
