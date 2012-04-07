Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:50:49 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36604 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904119Ab2DGQs7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:48:59 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYom-0004dH-T2; Sat, 07 Apr 2012 11:48:52 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 04/10] MIPS: Add micro-assembler support for 'ins' and 'ext' instructions.
Date:   Sat,  7 Apr 2012 11:48:29 -0500
Message-Id: <1333817315-30091-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add the MIPS32R2 'ins' and 'ext' instructions for use by the
kernel's micro-assembler.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uasm.h |   15 +++++++++++++++
 arch/mips/mm/tlbex.c         |   17 +++++++++++++++++
 arch/mips/mm/uasm.c          |   15 +++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 504d40a..f400629 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -60,6 +60,16 @@ void __uasminit uasm_i##op(u32 **buf, unsigned int a, signed int b)
 
 #define Ip_0(op) void __uasminit uasm_i##op(u32 **buf)
 
+#define Ip_bit_extract(op)					\
+void __cpuinit							\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b,		\
+		unsigned int c, unsigned int d)
+
+#define Ip_bit_insert(op)					\
+void __cpuinit							\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b,		\
+		unsigned int c, unsigned int d)
+
 Ip_u2u1s3(_addiu);
 Ip_u3u1u2(_addu);
 Ip_u2u1u3(_andi);
@@ -114,6 +124,8 @@ Ip_0(_tlbwi);
 Ip_0(_tlbwr);
 Ip_u3u1u2(_xor);
 Ip_u2u1u3(_xori);
+Ip_bit_extract(_ext);
+Ip_bit_insert(_ins);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u1(_syscall);
@@ -161,6 +173,9 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
 # define UASM_i_LWX(buf, rs, rt, rd) uasm_i_ldx(buf, rs, rt, rd)
 #else
+/* actually, the argument sequence is: rt, rs, pos, size. -- LY22 */
+# define UASM_i_EXT(buf, rs, rt, size, pos) uasm_i_ext(buf, rs, rt, size, pos)
+# define UASM_i_INS(buf, rs, rt, size, pos) uasm_i_ins(buf, rs, rt, size, pos)
 # define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
 # define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
 # define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a034229b..4db0d19 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -921,6 +921,13 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #endif
 	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+#ifdef CONFIG_32BIT
+	if (cpu_has_mips32r2) {
+		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
+		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
+		return;
+	}
+#endif
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -956,6 +963,16 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
 
 static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
+#ifdef CONFIG_32BIT
+	if (cpu_has_mips32r2) {
+		/* For MIPS32R2, PTE ptr offset is obtained from BadVAddr */
+		UASM_i_MFC0(p, tmp, C0_BADVADDR);
+		UASM_i_LW(p, ptr, 0, ptr);
+		UASM_i_EXT(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
+		UASM_i_INS(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
+		return;
+	}
+#endif
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
 	 * circumstances the move from cp0_context might produce a
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 5fa1851..fb6d8e27 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -63,6 +63,7 @@ enum opcode {
 	insn_bne, insn_cache, insn_daddu, insn_daddiu, insn_dmfc0,
 	insn_dmtc0, insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
 	insn_dsrl32, insn_drotr, insn_drotr32, insn_dsubu, insn_eret,
+	insn_ins, insn_ext,
 	insn_j, insn_jal, insn_jr, insn_ld, insn_ll, insn_lld,
 	insn_lui, insn_lw, insn_mfc0, insn_mtc0, insn_or, insn_ori,
 	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
@@ -113,6 +114,8 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
 	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
+	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
+	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
@@ -287,6 +290,16 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 	(*buf)++;
 }
 
+#define I_bit_extract(op)				\
+Ip_bit_extract(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, d-1, c);	\
+}
+#define I_bit_insert(op)				\
+Ip_bit_insert(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, c+d-1, c);	\
+}
 #define I_u1u2u3(op)					\
 Ip_u1u2u3(op)						\
 {							\
@@ -396,6 +409,8 @@ I_u2u1u3(_drotr)
 I_u2u1u3(_drotr32)
 I_u3u1u2(_dsubu)
 I_0(_eret)
+I_bit_insert(_ins)
+I_bit_extract(_ext)
 I_u1(_j)
 I_u1(_jal)
 I_u1(_jr)
-- 
1.7.9.6
