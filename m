Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:50:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:33990 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822519AbaDHLrbBKkDt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7096538A0DACA
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:19 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 8 Apr
 2014 12:47:21 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:21 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:20 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 10/14] MIPS: uasm: Add wsbh uasm instruction
Date:   Tue, 8 Apr 2014 12:47:11 +0100
Message-ID: <1396957635-27071-11-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 39717
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
 arch/mips/include/uapi/asm/inst.h | 11 +++++++++++
 arch/mips/mm/uasm-micromips.c     |  1 +
 arch/mips/mm/uasm-mips.c          |  1 +
 arch/mips/mm/uasm.c               |  4 +++-
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 1f1d777..e1258f3 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -155,6 +155,7 @@ Ip_0(_tlbp);
 Ip_0(_tlbr);
 Ip_0(_tlbwi);
 Ip_0(_tlbwr);
+Ip_u2u1(_wsbh);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
 
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index da27bf7..c98b061 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -202,6 +202,16 @@ enum lx_func {
 };
 
 /*
+ * BSHFL opcodes
+ */
+enum bshfl_func {
+	wsbh_op = 0x2,
+	dshd_op = 0x5,
+	seb_op  = 0x10,
+	seh_op  = 0x18,
+};
+
+/*
  * (microMIPS) Major opcodes.
  */
 enum mm_major_op {
@@ -254,6 +264,7 @@ enum mm_32a_minor_op {
 	mm_lwxs_op = 0x118,
 	mm_addu32_op = 0x150,
 	mm_subu32_op = 0x1d0,
+	mm_wsbh_op = 0x1ec,
 	mm_and_op = 0x250,
 	mm_or32_op = 0x290,
 	mm_xor32_op = 0x310,
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index bc4e912..528526a 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -110,6 +110,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
+	{ insn_wsbh, M(mm_pool32a_op, 0, 0, 0, mm_wsbh_op, mm_pool32axf_op), RT | RS },
 	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
 	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
 	{ insn_dins, 0, 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index a135b3c..a1845dc 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -118,6 +118,7 @@ static struct insn insn_table[] = {
 	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
 	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
+	{ insn_wsbh, M(spec3_op, 0, 0, 0, wsbh_op, bshfl_op), RT | RD },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_invalid, 0, 0 }
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 36658f6..d816a3a 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -54,7 +54,8 @@ enum opcode {
 	insn_mfhi, insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
 	insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_sltiu, insn_sltu,
 	insn_sra, insn_srl, insn_srlv, insn_subu, insn_sw, insn_syscall,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wsbh, insn_xor,
+	insn_xori,
 };
 
 struct insn {
@@ -295,6 +296,7 @@ I_0(_tlbp)
 I_0(_tlbr)
 I_0(_tlbwi)
 I_0(_tlbwr)
+I_u2u1(_wsbh)
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
 I_u2u1msbu3(_dins);
-- 
1.9.1
