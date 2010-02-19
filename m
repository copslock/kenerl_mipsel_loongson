Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 01:15:26 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9521 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492157Ab0BSANz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 01:13:55 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7dd7c70004>; Thu, 18 Feb 2010 16:13:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1J0DQaX029139;
        Thu, 18 Feb 2010 16:13:26 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1J0DQG5029138;
        Thu, 18 Feb 2010 16:13:26 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Add SYSCALL to uasm.
Date:   Thu, 18 Feb 2010 16:13:03 -0800
Message-Id: <1266538385-29088-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
References: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 19 Feb 2010 00:13:28.0838 (UTC) FILETIME=[5CC6A260:01CAB0F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    1 +
 arch/mips/mm/uasm.c          |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b99bd07..32fe2ec 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -102,6 +102,7 @@ Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
 Ip_u2u1msbu3(_dins);
+Ip_u1(_syscall);
 
 /* Handle labels. */
 struct uasm_label {
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 1581e98..d22d7bc 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -31,7 +31,8 @@ enum fields {
 	BIMM = 0x040,
 	JIMM = 0x080,
 	FUNC = 0x100,
-	SET = 0x200
+	SET = 0x200,
+	SCIMM = 0x400
 };
 
 #define OP_MASK		0x3f
@@ -52,6 +53,8 @@ enum fields {
 #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
+#define SCIMM_MASK	0xfffff
+#define SCIMM_SH	6
 
 enum opcode {
 	insn_invalid,
@@ -64,7 +67,7 @@ enum opcode {
 	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
 	insn_sd, insn_sll, insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw,
 	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
-	insn_dins
+	insn_dins, insn_syscall
 };
 
 struct insn {
@@ -136,6 +139,7 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
 	{ insn_invalid, 0, 0 }
 };
 
@@ -208,6 +212,14 @@ static inline __cpuinit u32 build_jimm(u32 arg)
 	return (arg >> 2) & JIMM_MASK;
 }
 
+static inline __cpuinit u32 build_scimm(u32 arg)
+{
+	if (arg & ~SCIMM_MASK)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & SCIMM_MASK) << SCIMM_SH;
+}
+
 static inline __cpuinit u32 build_func(u32 arg)
 {
 	if (arg & ~FUNC_MASK)
@@ -266,6 +278,8 @@ static void __cpuinit build_insn(u32 **buf, enum opcode opc, ...)
 		op |= build_func(va_arg(ap, u32));
 	if (ip->fields & SET)
 		op |= build_set(va_arg(ap, u32));
+	if (ip->fields & SCIMM)
+		op |= build_scimm(va_arg(ap, u32));
 	va_end(ap);
 
 	**buf = op;
@@ -391,6 +405,7 @@ I_0(_tlbwr)
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
 I_u2u1msbu3(_dins);
+I_u1(_syscall);
 
 /* Handle labels. */
 void __cpuinit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
-- 
1.6.6
