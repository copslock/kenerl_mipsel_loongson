Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:52:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:34021 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822526AbaDHLrcSvwvZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:32 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D5C943AE58011
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:20 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:22 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:22 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:21 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 12/14] MIPS: uasm: Add mul uasm instruction
Date:   Tue, 8 Apr 2014 12:47:13 +0100
Message-ID: <1396957635-27071-13-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 39721
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
index ec11524..45af01b 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -134,6 +134,7 @@ Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
 Ip_u1(_mfhi);
 Ip_u1u2u3(_mtc0);
+Ip_u3u1u2(_mul);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
 Ip_u2s3u1(_pref);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index c98b061..7700284 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -265,6 +265,7 @@ enum mm_32a_minor_op {
 	mm_addu32_op = 0x150,
 	mm_subu32_op = 0x1d0,
 	mm_wsbh_op = 0x1ec,
+	mm_mul_op = 0x210,
 	mm_and_op = 0x250,
 	mm_or32_op = 0x290,
 	mm_xor32_op = 0x310,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 89df379..f47fa6e 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -90,6 +90,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
 	{ insn_mfhi, M(mm_pool32a_op, 0, 0, 0, mm_mfhi32_op, mm_pool32axf_op), RS },
 	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_mul, M(mm_pool32a_op, 0, 0, 0, 0, mm_mul_op), RT | RS | RD },
 	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
 	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
 	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 576ae34..0f66284 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -97,6 +97,7 @@ static struct insn insn_table[] = {
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mfhi,  M(spec_op, 0, 0, 0, 0, mfhi_op),  RT | RD | SET},
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
 	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 96f8b5b..5b15ce7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -51,11 +51,11 @@ enum opcode {
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_ld,
 	insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx,
-	insn_mfc0, insn_mfhi, insn_mtc0, insn_or, insn_ori, insn_pref,
-	insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv,
-	insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu,
-	insn_sw, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr,
-	insn_wsbh, insn_xor, insn_xori,
+	insn_mfc0, insn_mfhi, insn_mtc0, insn_mul, insn_or, insn_ori,
+	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_sllv, insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv,
+	insn_subu, insn_sw, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi,
+	insn_tlbwr, insn_wsbh, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -277,6 +277,7 @@ I_u2s3u1(_lw)
 I_u1u2u3(_mfc0)
 I_u1(_mfhi)
 I_u1u2u3(_mtc0)
+I_u3u1u2(_mul)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
 I_0(_rfe)
-- 
1.9.1
