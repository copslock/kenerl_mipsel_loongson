Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 20:21:52 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49832 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903839Ab2GLSVq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 20:21:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SpO1B-0004PU-Sg; Thu, 12 Jul 2012 13:21:37 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v5,04/10] Add the MIPS32R2 'ins' and 'ext' instructions for use by the kernel's micro-assembler.
Date:   Thu, 12 Jul 2012 13:21:31 -0500
Message-Id: <1342117291-30268-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uasm.h |  4 ++--
 arch/mips/mm/uasm.c          | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 53db9d7..7e0bf17 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -66,8 +66,6 @@ Ip_u3u1u2(_addu);
 Ip_u3u1u2(_and);
 Ip_u2u1u3(_andi);
 Ip_u1u2s3(_bbit0);
-Ip_u1u2s3(_bbit0);
-Ip_u1u2s3(_bbit1);
 Ip_u1u2s3(_bbit1);
 Ip_u1u2s3(_beq);
 Ip_u1u2s3(_beql);
@@ -92,6 +90,8 @@ Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
+Ip_u2u1msbu3(_ext);
+Ip_u2u1msbu3(_ins);
 Ip_u1(_j);
 Ip_u1(_jal);
 Ip_u1(_jr);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 5fa1851..f6ba16e 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -63,8 +63,8 @@ enum opcode {
 	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
 	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
 	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
-	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
-	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
+	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ll,
+	insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
 	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
 	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
@@ -113,6 +113,8 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
 	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
+	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
+	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
@@ -343,6 +345,13 @@ Ip_u2u1msbu3(op)					\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_u2u1msbdu3(op) 				\
+Ip_u2u1msbu3(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, d-1, c);	\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u1u2(op)					\
 Ip_u1u2(op)						\
 {							\
@@ -396,6 +405,8 @@ I_u2u1u3(_drotr)
 I_u2u1u3(_drotr32)
 I_u3u1u2(_dsubu)
 I_0(_eret)
+I_u2u1msbdu3(_ext)
+I_u2u1msbu3(_ins)
 I_u1(_j)
 I_u1(_jal)
 I_u1(_jr)
-- 
1.7.11.1
