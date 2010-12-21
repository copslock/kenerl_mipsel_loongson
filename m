Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 23:19:54 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12582 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491840Ab0LUWT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 23:19:26 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1128190001>; Tue, 21 Dec 2010 14:20:09 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:46 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBLMJKVk011463;
        Tue, 21 Dec 2010 14:19:20 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBLMJKQg011462;
        Tue, 21 Dec 2010 14:19:20 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 2/3] MIPS: Add DINSM to uasm.
Date:   Tue, 21 Dec 2010 14:19:10 -0800
Message-Id: <1292969951-11418-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
References: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 21 Dec 2010 22:20:46.0816 (UTC) FILETIME=[50B37600:01CBA15D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    1 +
 arch/mips/mm/uasm.c          |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 892062d..99dae68 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -115,6 +115,7 @@ Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
 Ip_u2u1msbu3(_dins);
+Ip_u2u1msbu3(_dinsm);
 Ip_u1(_syscall);
 
 /* Handle labels. */
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 23afdeb..99f0347 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -68,7 +68,7 @@ enum opcode {
 	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
 	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
-	insn_dins, insn_syscall, insn_bbit0, insn_bbit1
+	insn_dins, insn_dinsm, insn_syscall, insn_bbit0, insn_bbit1
 };
 
 struct insn {
@@ -142,6 +142,7 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
 	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
 	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
@@ -340,6 +341,13 @@ Ip_u2u1msbu3(op)					\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_u2u1msb32u3(op)				\
+Ip_u2u1msbu3(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, c+d-33, c);	\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u1u2(op)					\
 Ip_u1u2(op)						\
 {							\
@@ -422,6 +430,7 @@ I_0(_tlbwr)
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
 I_u2u1msbu3(_dins);
+I_u2u1msb32u3(_dinsm);
 I_u1(_syscall);
 I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
-- 
1.7.2.3
