Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:39:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45689 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860000AbaFWJj3H9WKl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F2E046A607F0D
        for <linux-mips@linux-mips.org>; Mon, 23 Jun 2014 10:39:19 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:22 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:21 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 02/17] MIPS: uasm: Add slt uasm instruction
Date:   Mon, 23 Jun 2014 10:38:45 +0100
Message-ID: <1403516340-22997-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40657
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
 arch/mips/include/asm/uasm.h      | 1 +
 arch/mips/include/uapi/asm/inst.h | 1 +
 arch/mips/mm/uasm-micromips.c     | 1 +
 arch/mips/mm/uasm-mips.c          | 1 +
 arch/mips/mm/uasm.c               | 3 ++-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 43259b3fca6d..708c5d414905 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -150,6 +150,7 @@ Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
 Ip_u2u1u3(_sll);
 Ip_u3u2u1(_sllv);
+Ip_s3s1s2(_slt);
 Ip_u2u1s3(_sltiu);
 Ip_u3u1u2(_sltu);
 Ip_u2u1u3(_sra);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 4b7160259292..4bfdb9d4c186 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -273,6 +273,7 @@ enum mm_32a_minor_op {
 	mm_and_op = 0x250,
 	mm_or32_op = 0x290,
 	mm_xor32_op = 0x310,
+	mm_slt_op = 0x350,
 	mm_sltu_op = 0x390,
 };
 
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 775c2800cba2..8399ddf03a02 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -102,6 +102,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_sd, 0, 0 },
 	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
 	{ insn_sllv, M(mm_pool32a_op, 0, 0, 0, 0, mm_sllv32_op), RT | RS | RD },
+	{ insn_slt, M(mm_pool32a_op, 0, 0, 0, 0, mm_slt_op), RT | RS | RD },
 	{ insn_sltiu, M(mm_sltiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_sltu, M(mm_pool32a_op, 0, 0, 0, 0, mm_sltu_op), RT | RS | RD },
 	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 38792c2364f5..4535a9d19ea5 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -110,6 +110,7 @@ static struct insn insn_table[] = {
 	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
 	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
+	{ insn_slt,  M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD },
 	{ insn_sltiu, M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_sltu, M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD },
 	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 1e3e10919423..a01b0d6cedd2 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -53,7 +53,7 @@ enum opcode {
 	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
 	insn_lwx, insn_mfc0, insn_mfhi, insn_mflo, insn_mtc0, insn_mul,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sllv, insn_sltiu, insn_sltu, insn_sra,
+	insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra,
 	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
 	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
 	insn_xor, insn_xori, insn_yield,
@@ -296,6 +296,7 @@ I_u2s3u1(_scd)
 I_u2s3u1(_sd)
 I_u2u1u3(_sll)
 I_u3u2u1(_sllv)
+I_s3s1s2(_slt)
 I_u2u1s3(_sltiu)
 I_u3u1u2(_sltu)
 I_u2u1u3(_sra)
-- 
2.0.0
