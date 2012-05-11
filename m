Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 08:36:06 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34408 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903557Ab2EKGf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 08:35:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSjSA-0001wq-OR; Fri, 11 May 2012 01:35:50 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: Fixup ordering of micro assembler instructions.
Date:   Fri, 11 May 2012 01:35:47 -0500
Message-Id: <1336718147-1307-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

A number of new instructions have been added to the micro
assembler causing the list to no longer be in alphabetical
order. This patch fixes up the name ordering.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uasm.h |  103 +++++++++++++++++++++---------------------
 arch/mips/mm/uasm.c          |   75 +++++++++++++++---------------
 2 files changed, 88 insertions(+), 90 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 814bc9f..b068ea0 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -6,6 +6,7 @@
  * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
  * Copyright (C) 2005  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2012  MIPS Technologies, Inc.
  */
 
 #include <linux/types.h>
@@ -62,8 +63,10 @@ void __uasminit uasm_i##op(u32 **buf, unsigned int a, signed int b)
 
 Ip_u2u1s3(_addiu);
 Ip_u3u1u2(_addu);
-Ip_u2u1u3(_andi);
 Ip_u3u1u2(_and);
+Ip_u2u1u3(_andi);
+Ip_u1u2s3(_bbit0);
+Ip_u1u2s3(_bbit1);
 Ip_u1u2s3(_beq);
 Ip_u1u2s3(_beql);
 Ip_u1s2(_bgez);
@@ -72,57 +75,55 @@ Ip_u1s2(_bltz);
 Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
 Ip_u2s3u1(_cache);
-Ip_u1u2u3(_dmfc0);
-Ip_u1u2u3(_dmtc0);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u2u1msbu3(_dins);
+Ip_u2u1msbu3(_dinsm);
+Ip_u1u2u3(_dmfc0);
+Ip_u1u2u3(_dmtc0);
+Ip_u2u1u3(_drotr);
+Ip_u2u1u3(_drotr32);
 Ip_u2u1u3(_dsll);
 Ip_u2u1u3(_dsll32);
 Ip_u2u1u3(_dsra);
 Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
-Ip_u2u1u3(_drotr);
-Ip_u2u1u3(_drotr32);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
+Ip_u2u1msbu3(_ext);
+Ip_u2u1msbu3(_ins);
 Ip_u1(_j);
 Ip_u1(_jal);
 Ip_u1(_jr);
 Ip_u2s3u1(_ld);
+Ip_u3u1u2(_ldx);
 Ip_u2s3u1(_ll);
 Ip_u2s3u1(_lld);
 Ip_u1s2(_lui);
 Ip_u2s3u1(_lw);
+Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mtc0);
-Ip_u2u1u3(_ori);
 Ip_u3u1u2(_or);
+Ip_u2u1u3(_ori);
 Ip_u2s3u1(_pref);
 Ip_0(_rfe);
+Ip_u2u1u3(_rotr);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
 Ip_u2u1u3(_sll);
 Ip_u2u1u3(_sra);
 Ip_u2u1u3(_srl);
-Ip_u2u1u3(_rotr);
 Ip_u3u1u2(_subu);
 Ip_u2s3u1(_sw);
+Ip_u1(_syscall);
 Ip_0(_tlbp);
 Ip_0(_tlbr);
 Ip_0(_tlbwi);
 Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
-Ip_u2u1msbu3(_ext);
-Ip_u2u1msbu3(_ins);
-Ip_u2u1msbu3(_dins);
-Ip_u2u1msbu3(_dinsm);
-Ip_u1(_syscall);
-Ip_u1u2s3(_bbit0);
-Ip_u1u2s3(_bbit1);
-Ip_u3u1u2(_lwx);
-Ip_u3u1u2(_ldx);
 
 /* Handle labels. */
 struct uasm_label {
@@ -147,37 +148,37 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 
 /* convenience macros for instructions */
 #ifdef CONFIG_64BIT
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_daddu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
 # define UASM_i_LW(buf, rs, rt, off) uasm_i_ld(buf, rs, rt, off)
-# define UASM_i_SW(buf, rs, rt, off) uasm_i_sd(buf, rs, rt, off)
+# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_ldx(buf, rs, rt, rd)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
+# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_drotr(buf, rs, rt, sh)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
 # define UASM_i_SRL_SAFE(buf, rs, rt, sh) uasm_i_dsrl_safe(buf, rs, rt, sh)
-# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_drotr(buf, rs, rt, sh)
-# define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
-# define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
-# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
-# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_daddu(buf, rs, rt, rd)
 # define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_dsubu(buf, rs, rt, rd)
-# define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
-# define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
-# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_ldx(buf, rs, rt, rd)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sd(buf, rs, rt, off)
 #else
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_addu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
 # define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
-# define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
+# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_lwx(buf, rs, rt, rd)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
+# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_rotr(buf, rs, rt, sh)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
 # define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
 # define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
 # define UASM_i_SRL_SAFE(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
-# define UASM_i_ROTR(buf, rs, rt, sh) uasm_i_rotr(buf, rs, rt, sh)
-# define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
-# define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
-# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
-# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_addu(buf, rs, rt, rd)
 # define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_subu(buf, rs, rt, rd)
-# define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
-# define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
-# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_lwx(buf, rs, rt, rd)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
 #endif
 
 #define uasm_i_b(buf, off) uasm_i_beq(buf, 0, 0, off)
@@ -185,19 +186,10 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 #define uasm_i_beqzl(buf, rs, off) uasm_i_beql(buf, rs, 0, off)
 #define uasm_i_bnez(buf, rs, off) uasm_i_bne(buf, rs, 0, off)
 #define uasm_i_bnezl(buf, rs, off) uasm_i_bnel(buf, rs, 0, off)
+#define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
 #define uasm_i_move(buf, a, b) UASM_i_ADDU(buf, a, 0, b)
 #define uasm_i_nop(buf) uasm_i_sll(buf, 0, 0, 0)
 #define uasm_i_ssnop(buf) uasm_i_sll(buf, 0, 0, 1)
-#define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
-
-static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
-				    unsigned int a2, unsigned int a3)
-{
-	if (a3 < 32)
-		uasm_i_dsrl(p, a1, a2, a3);
-	else
-		uasm_i_dsrl32(p, a1, a2, a3 - 32);
-}
 
 static inline void uasm_i_drotr_safe(u32 **p, unsigned int a1,
 				     unsigned int a2, unsigned int a3)
@@ -217,6 +209,15 @@ static inline void uasm_i_dsll_safe(u32 **p, unsigned int a1,
 		uasm_i_dsll32(p, a1, a2, a3 - 32);
 }
 
+static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
+				    unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_dsrl(p, a1, a2, a3);
+	else
+		uasm_i_dsrl32(p, a1, a2, a3 - 32);
+}
+
 /* Handle relocations. */
 struct uasm_reloc {
 	u32 *addr;
@@ -236,16 +237,16 @@ void uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab,
 int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr);
 
 /* Convenience functions for labeled branches. */
-void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_b(u32 **p, struct uasm_reloc **r, int lid);
+void uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
+		   unsigned int bit, int lid);
+void uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
+		   unsigned int bit, int lid);
 void uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
 void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
 		 unsigned int reg2, int lid);
 void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
-		   unsigned int bit, int lid);
-void uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
-		   unsigned int bit, int lid);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index faa1e22..3ccf5f4 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -66,19 +66,16 @@ enum fields {
 
 enum opcode {
 	insn_invalid,
-	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
-	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
-	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
-	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
-	insn_ins, insn_ext,
-	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
-	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
-	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
-	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
-	insn_dins, insn_dinsm, insn_syscall, insn_bbit0, insn_bbit1,
-	insn_lwx, insn_ldx
+	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
+	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
+	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
+	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
+	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
+	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
+	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
+	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
+	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw, insn_syscall,
+	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -108,10 +105,12 @@ struct insn {
 
 #ifdef CONFIG_CPU_MICROMIPS
 static struct insn insn_table[] __uasminitdata = {
-	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
 	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
 	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
 	{ insn_andi, M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_bbit0, 0, 0 },
+	{ insn_bbit1, 0, 0 },
 	{ insn_beq, M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_beql, 0, 0 },
 	{ insn_bgez, M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM },
@@ -120,65 +119,65 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_bltzl, 0, 0 },
 	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
 	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
-	{ insn_daddu, 0, 0 },
 	{ insn_daddiu, 0, 0 },
+	{ insn_daddu, 0, 0 },
+	{ insn_dins, 0, 0 },
+	{ insn_dinsm, 0, 0 },
 	{ insn_dmfc0, 0, 0 },
 	{ insn_dmtc0, 0, 0 },
+	{ insn_drotr, 0, 0 },
+	{ insn_drotr32, 0, 0 },
 	{ insn_dsll, 0, 0 },
 	{ insn_dsll32, 0, 0 },
 	{ insn_dsra, 0, 0 },
 	{ insn_dsrl, 0, 0 },
 	{ insn_dsrl32, 0, 0 },
-	{ insn_drotr, 0, 0 },
-	{ insn_drotr32, 0, 0 },
 	{ insn_dsubu, 0, 0 },
 	{ insn_eret, M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0 },
-	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
 	{ insn_ext, M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE },
+	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
 	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
 	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
 	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
 	{ insn_ld, 0, 0 },
+	{ insn_ldx, 0, 0 },
 	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
 	{ insn_lld, 0, 0 },
 	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
 	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_lwx, 0, 0 },
 	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
 	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
 	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
 	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
 	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
 	{ insn_rfe, 0, 0 },
+	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
 	{ insn_sc, M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM },
 	{ insn_scd, 0, 0 },
 	{ insn_sd, 0, 0 },
 	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
 	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
 	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
-	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
 	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
 	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
 	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
 	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
 	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
 	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
 	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
-	{ insn_dins, 0, 0 },
-	{ insn_dinsm, 0, 0 },
-	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
-	{ insn_bbit0, 0, 0 },
-	{ insn_bbit1, 0, 0 },
-	{ insn_lwx, 0, 0 },
-	{ insn_ldx, 0, 0 },
 	{ insn_invalid, 0, 0 }
 };
 #else
 static struct insn insn_table[] __uasminitdata = {
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
 	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
 	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
 	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
+	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
@@ -187,57 +186,55 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
 	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
 	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
 	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
 	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
 	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
 	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
 	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
 	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
+	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),  RT | SIMM },
 	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
 	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
+	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
 	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
 	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
 	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
 	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
 	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
 	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
 	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
 	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
 	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
 	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
 	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
-	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
-	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
-	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_invalid, 0, 0 }
 };
 #endif
-- 
1.7.10
