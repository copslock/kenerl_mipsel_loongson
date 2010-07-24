Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:42:41 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16599 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492620Ab0GXBmL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:11 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a450c0000>; Fri, 23 Jul 2010 18:42:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:09 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1g3gg004050;
        Fri, 23 Jul 2010 18:42:03 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1g2SN004049;
        Fri, 23 Jul 2010 18:42:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/7] MIPS: Add drotr32 and uasm_i_drotr_safe to uasm.
Date:   Fri, 23 Jul 2010 18:41:41 -0700
Message-Id: <1279935707-3997-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jul 2010 01:42:09.0296 (UTC) FILETIME=[6E0B5900:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |   10 ++++++++++
 arch/mips/mm/uasm.c          |   13 ++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 697e40c..3964b2e 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -71,6 +71,7 @@ Ip_u2u1u3(_dsra);
 Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
 Ip_u2u1u3(_drotr);
+Ip_u2u1u3(_drotr32);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
 Ip_u1(_j);
@@ -176,6 +177,15 @@ static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
 		uasm_i_dsrl32(p, a1, a2, a3 - 32);
 }
 
+static inline void uasm_i_drotr_safe(u32 **p, unsigned int a1,
+				     unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_drotr(p, a1, a2, a3);
+	else
+		uasm_i_drotr32(p, a1, a2, a3 - 32);
+}
+
 static inline void uasm_i_dsll_safe(u32 **p, unsigned int a1,
 				    unsigned int a2, unsigned int a3)
 {
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 611d564..fe041d5 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -62,11 +62,12 @@ enum opcode {
 	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
 	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
-	insn_dsrl32, insn_drotr, insn_dsubu, insn_eret, insn_j, insn_jal,
-	insn_jr, insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
-	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
+	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
+	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
+	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
+	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
+	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
+	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
 	insn_dins, insn_syscall
 };
 
@@ -108,6 +109,7 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
 	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
 	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
@@ -375,6 +377,7 @@ I_u2u1u3(_dsra)
 I_u2u1u3(_dsrl)
 I_u2u1u3(_dsrl32)
 I_u2u1u3(_drotr)
+I_u2u1u3(_drotr32)
 I_u3u1u2(_dsubu)
 I_0(_eret)
 I_u1(_j)
-- 
1.7.1.1
