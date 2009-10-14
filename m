Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:18:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1728 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493720AbZJNTSs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:18:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad623c30000>; Wed, 14 Oct 2009 12:17:24 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:17:00 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:17:00 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9EJGvhJ007570;
	Wed, 14 Oct 2009 12:16:57 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9EJGu3g007568;
	Wed, 14 Oct 2009 12:16:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Add drotr and dins instructions to uasm.
Date:	Wed, 14 Oct 2009 12:16:55 -0700
Message-Id: <1255547816-7544-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AD62353.2080603@caviumnetworks.com>
References: <4AD62353.2080603@caviumnetworks.com>
X-OriginalArrivalTime: 14 Oct 2009 19:17:00.0101 (UTC) FILETIME=[E7668750:01CA4D02]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/uasm.c |   16 +++++++++++++---
 arch/mips/mm/uasm.h |    7 +++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f467199..0a165c5 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -60,11 +60,11 @@ enum opcode {
 	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
 	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
-	insn_dsrl32, insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr,
-	insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
+	insn_dsrl32, insn_drotr, insn_dsubu, insn_eret, insn_j, insn_jal,
+	insn_jr, insn_ld, insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0,
 	insn_mtc0, insn_ori, insn_pref, insn_rfe, insn_sc, insn_scd,
 	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
-	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori
+	insn_tlbp, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori, insn_dins
 };
 
 struct insn {
@@ -104,6 +104,7 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
 	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
 	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
 	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
@@ -132,6 +133,7 @@ static struct insn insn_table[] __cpuinitdata = {
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
 	{ insn_invalid, 0, 0 }
 };
 
@@ -304,6 +306,12 @@ Ip_u2u1s3(op)						\
 	build_insn(buf, insn##op, b, a, c);		\
 }
 
+#define I_u2u1msbu3(op)					\
+Ip_u2u1msbu3(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, c+d-1, c);	\
+}
+
 #define I_u1u2(op)					\
 Ip_u1u2(op)						\
 {							\
@@ -349,6 +357,7 @@ I_u2u1u3(_dsll32)
 I_u2u1u3(_dsra)
 I_u2u1u3(_dsrl)
 I_u2u1u3(_dsrl32)
+I_u2u1u3(_drotr)
 I_u3u1u2(_dsubu)
 I_0(_eret)
 I_u1(_j)
@@ -377,6 +386,7 @@ I_0(_tlbwi)
 I_0(_tlbwr)
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
+I_u2u1msbu3(_dins);
 
 /* Handle labels. */
 void __cpuinit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
diff --git a/arch/mips/mm/uasm.h b/arch/mips/mm/uasm.h
index c6d1e3d..3d153ed 100644
--- a/arch/mips/mm/uasm.h
+++ b/arch/mips/mm/uasm.h
@@ -34,6 +34,11 @@ uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
 void __cpuinit								\
 uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
+#define Ip_u2u1msbu3(op)						\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
+	   unsigned int d)
+
 #define Ip_u1u2(op)							\
 void __cpuinit uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
 
@@ -65,6 +70,7 @@ Ip_u2u1u3(_dsll32);
 Ip_u2u1u3(_dsra);
 Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
+Ip_u2u1u3(_drotr);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
 Ip_u1(_j);
@@ -93,6 +99,7 @@ Ip_0(_tlbwi);
 Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
+Ip_u2u1msbu3(_dins);
 
 /* Handle labels. */
 struct uasm_label {
-- 
1.6.0.6
