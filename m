Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:49:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:33977 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822513AbaDHLr2YOwMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A324BBD38969C
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:16 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:18 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:18 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:17 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 06/14] MIPS: uasm: Add mfhi uasm instruction
Date:   Tue, 8 Apr 2014 12:47:07 +0100
Message-ID: <1396957635-27071-7-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 39713
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
 arch/mips/include/asm/uasm.h      |  1 +
 arch/mips/include/uapi/asm/inst.h |  1 +
 arch/mips/mm/uasm-micromips.c     |  1 +
 arch/mips/mm/uasm-mips.c          |  1 +
 arch/mips/mm/uasm.c               | 11 ++++++-----
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 236b2db..9da0ceb 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -130,6 +130,7 @@ Ip_u1s2(_lui);
 Ip_u2s3u1(_lw);
 Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
+Ip_u1(_mfhi);
 Ip_u1u2u3(_mtc0);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index c28cae1..f46930f 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -296,6 +296,7 @@ enum mm_32axf_minor_op {
 	mm_mfc0_op = 0x003,
 	mm_mtc0_op = 0x00b,
 	mm_tlbp_op = 0x00d,
+	mm_mfhi32_op = 0x035,
 	mm_jalr_op = 0x03c,
 	mm_tlbr_op = 0x04d,
 	mm_jalrhb_op = 0x07c,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index dc448be..fd5ab06 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -86,6 +86,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
 	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_mfhi, M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS },
 	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
 	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
 	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index fe4be68..15e4048 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -93,6 +93,7 @@ static struct insn insn_table[] = {
 	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mfhi,  M(spec_op, 0, 0, 0, 0, mfhi_op),  RT | RD | SET},
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index c2b7c4b..7ecde42 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -50,11 +50,11 @@ enum opcode {
 	insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sllv, insn_sra, insn_srl, insn_srlv, insn_subu,
-	insn_sw, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr,
-	insn_xor, insn_xori,
+	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mfhi,
+	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc,
+	insn_scd, insn_sd, insn_sll, insn_sllv, insn_sra, insn_srl, insn_srlv,
+	insn_subu, insn_sw, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi,
+	insn_tlbwr, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -272,6 +272,7 @@ I_u2s3u1(_lld)
 I_u1s2(_lui)
 I_u2s3u1(_lw)
 I_u1u2u3(_mfc0)
+I_u1(_mfhi)
 I_u1u2u3(_mtc0)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
-- 
1.9.1
