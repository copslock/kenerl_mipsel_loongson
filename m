Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 08:10:10 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34308 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903548Ab2EKGJz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 08:09:55 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSj2x-0001tC-W8; Fri, 11 May 2012 01:09:48 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: Add support for microMIPS instructions.
Date:   Fri, 11 May 2012 01:09:41 -0500
Message-Id: <1336716581-32708-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

The MIPS micro-assembler needs to use microMIPS instructions
when building all of the core exception handlers.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/inst.h     |  882 +++++++++++++++++++++++++++++++++++---
 arch/mips/include/asm/mipsregs.h |  359 +++++++---------
 arch/mips/mm/uasm.c              |  173 +++++++-
 3 files changed, 1133 insertions(+), 281 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 7ebfc39..7e8f793 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -5,8 +5,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 2000 by Ralf Baechle
- * Copyright (C) 2006 by Thiemo Seufer
+ * Copyright (C) 1996, 2000  Ralf Baechle
+ * Copyright (C) 2006  Thiemo Seufer
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  */
 #ifndef _ASM_INST_H
 #define _ASM_INST_H
@@ -116,7 +117,7 @@ enum bcop_op {
 enum cop0_coi_func {
 	tlbr_op       = 0x01, tlbwi_op      = 0x02,
 	tlbwr_op      = 0x06, tlbp_op       = 0x08,
-	rfe_op        = 0x10, eret_op       = 0x18
+	rfe_op        = 0x10, eret_op       = 0x18,
 };
 
 /*
@@ -261,85 +262,523 @@ struct ma_format {	/* FPU multipy and add format (MIPS IV) */
 	unsigned int fmt : 2;
 };
 
-struct b_format { /* BREAK and SYSCALL */
+struct b_format {	/* BREAK and SYSCALL */
 	unsigned int opcode:6;
 	unsigned int code:20;
 	unsigned int func:6;
 };
 
+struct fb_format {	/* FPU branch format */
+	unsigned int opcode:6;
+	unsigned int bc:5;
+	unsigned int cc:3;
+	unsigned int flag:2;
+	unsigned int simmediate:16;
+};
+
+struct fp0_format {      /* FPU multipy and add format (MIPS32) */
+	unsigned int opcode:6;
+	unsigned int fmt:5;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int func:6;
+};
+
+struct mm_fp0_format {      /* FPU multipy and add format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int fmt:3;
+	unsigned int op:2;
+	unsigned int func:6;
+};
+
+struct fp1_format {      /* FPU mfc1 and cfc1 format (MIPS32) */
+	unsigned int opcode:6;
+	unsigned int op:5;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int func:6;
+};
+
+struct mm_fp1_format {      /* FPU mfc1 and cfc1 format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int fmt:2;
+	unsigned int op:8;
+	unsigned int func:6;
+};
+
+struct mm_fp2_format {      /* FPU movt and movf format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int cc:3;
+	unsigned int zero:2;
+	unsigned int fmt:2;
+	unsigned int op:3;
+	unsigned int func:6;
+};
+
+struct mm_fp3_format {      /* FPU abs and neg format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int fmt:3;
+	unsigned int op:7;
+	unsigned int func:6;
+};
+
+struct mm_fp4_format {      /* FPU c.cond format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int cc:3;
+	unsigned int fmt:3;
+	unsigned int cond:4;
+	unsigned int func:6;
+};
+
+struct mm_fp5_format {      /* FPU lwxc1 and swxc1 format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int index:5;
+	unsigned int base:5;
+	unsigned int fd:5;
+	unsigned int op:5;
+	unsigned int func:6;
+};
+
+struct fp6_format {	/* FPU madd and msub format (MIPS IV) */
+	unsigned int opcode:6;
+	unsigned int fr:5;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int func:6;
+};
+
+struct mm_fp6_format {	/* FPU madd and msub format (micro_mips) */
+	unsigned int opcode:6;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int fr:5;
+	unsigned int func:6;
+};
+
+struct mm16b1_format {		/* micro_mips 16-bit branch format */
+	unsigned int opcode:6;
+	unsigned int rs:3;
+	signed int simmediate:7;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
+struct mm16b0_format {		/* micro_mips 16-bit branch format */
+	unsigned int opcode:6;
+	signed int simmediate:10;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
+struct mm_i_format {		/* Immediate format (addi, lw, ...) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	signed int simmediate:16;
+};
+
+/*  MIPS16e */
+
+struct rr {
+	unsigned int opcode:5;
+	unsigned int rx:3;
+	unsigned int nd:1;
+	unsigned int l:1;
+	unsigned int ra:1;
+	unsigned int func:5;
+};
+
+struct jal {
+	unsigned int opcode:5;
+	unsigned int x:1;
+	unsigned int imm20_16:5;
+	signed int imm25_21:5;
+	/* unsigned int    imm20_15:0;  here is only first 16bits in first HW */
+};
+
+struct i64 {
+	unsigned int opcode:5;
+	unsigned int func:3;
+	unsigned int imm:8;
+};
+
+struct ri64 {
+	unsigned int opcode:5;
+	unsigned int func:3;
+	unsigned int ry:3;
+	unsigned int imm:5;
+};
+
+struct ri {
+	unsigned int opcode:5;
+	unsigned int rx:3;
+	unsigned int imm:8;
+};
+
+struct rri {
+	unsigned int opcode:5;
+	unsigned int rx:3;
+	unsigned int ry:3;
+	unsigned int imm:5;
+};
+
+struct i8 {
+	unsigned int opcode:5;
+	unsigned int func:3;
+	unsigned int imm:8;
+};
+
+struct mm_m_format {
+	unsigned int opcode:6;
+	unsigned int rd:5;
+	unsigned int base:5;
+	unsigned int func:4;
+	signed int simmediate:12;
+};
+
+struct mm_x_format {
+	unsigned int opcode:6;
+	unsigned int index:5;
+	unsigned int base:5;
+	unsigned int rd:5;
+	unsigned int func:11;
+};
+
+struct mm16_m_format {
+	unsigned int opcode:6;
+	unsigned int func:4;
+	unsigned int rlist:2;
+	unsigned int imm:4;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
+struct mm16_rb_format {
+	unsigned int opcode:6;
+	unsigned int rt:3;
+	unsigned int base:3;
+	signed int simmediate:4;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
+struct mm16_r5_format {
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	signed int simmediate:5;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
+struct mm16_r3_format {
+	unsigned int opcode:6;
+	unsigned int rt:3;
+	signed int simmediate:7;
+	unsigned int duplicate:16;	/* a copy of the instn */
+};
+
 #elif defined(__MIPSEL__)
 
-struct j_format {	/* Jump format */
-	unsigned int target : 26;
-	unsigned int opcode : 6;
+struct j_format {		/* Jump format */
+	unsigned int target:26;
+	unsigned int opcode:6;
 };
 
-struct i_format {	/* Immediate format */
-	signed int simmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+struct i_format {		/* Immediate format */
+	signed int simmediate:16;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
-struct u_format {	/* Unsigned immediate format */
-	unsigned int uimmediate : 16;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+struct u_format {		/* Unsigned immediate format */
+	unsigned int uimmediate:16;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
-struct c_format {	/* Cache (>= R6000) format */
-	unsigned int simmediate : 16;
-	unsigned int cache : 2;
-	unsigned int c_op : 3;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+struct c_format {		/* Cache (>= R6000) format */
+	unsigned int simmediate:16;
+	unsigned int cache:2;
+	unsigned int c_op:3;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
-struct r_format {	/* Register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+struct r_format {		/* Register format */
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
-struct p_format {	/* Performance counter format (R10000) */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int rs : 5;
-	unsigned int opcode : 6;
+struct p_format {		/* Performance counter format (R10000) */
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int rs:5;
+	unsigned int opcode:6;
 };
 
-struct f_format {	/* FPU register format */
-	unsigned int func : 6;
-	unsigned int re : 5;
-	unsigned int rd : 5;
-	unsigned int rt : 5;
-	unsigned int fmt : 4;
-	unsigned int : 1;
-	unsigned int opcode : 6;
+struct f_format {		/* FPU register format */
+	unsigned int func:6;
+	unsigned int re:5;
+	unsigned int rd:5;
+	unsigned int rt:5;
+	unsigned int fmt:4;
+	unsigned int:1;
+	unsigned int opcode:6;
 };
 
-struct ma_format {	/* FPU multipy and add format (MIPS IV) */
-	unsigned int fmt : 2;
-	unsigned int func : 4;
-	unsigned int fd : 5;
-	unsigned int fs : 5;
-	unsigned int ft : 5;
-	unsigned int fr : 5;
-	unsigned int opcode : 6;
+struct ma_format {		/* FPU multipy and add format (MIPS IV) */
+	unsigned int fmt:2;
+	unsigned int func:4;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int fr:5;
+	unsigned int opcode:6;
 };
 
-struct b_format { /* BREAK and SYSCALL */
+struct b_format {		/* BREAK and SYSCALL */
 	unsigned int func:6;
 	unsigned int code:20;
 	unsigned int opcode:6;
 };
 
+struct fb_format {		/* FPU branch format */
+	unsigned int simmediate:16;
+	unsigned int flag:2;
+	unsigned int cc:3;
+	unsigned int bc:5;
+	unsigned int opcode:6;
+};
+
+struct fp0_format {		/* FPU multipy and add format (MIPS32) */
+	unsigned int func:6;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int fmt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp0_format {		/* FPU multipy and add format (micro_mips) */
+	unsigned int func:6;
+	unsigned int op:2;
+	unsigned int fmt:3;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int opcode:6;
+};
+
+struct fp1_format {		/* FPU mfc1 and cfc1 format (MIPS32) */
+	unsigned int func:6;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int op:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp1_format {		/* FPU mfc1 and cfc1 format (micro_mips) */
+	unsigned int func:6;
+	unsigned int op:8;
+	unsigned int fmt:2;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp2_format {		/* FPU movt and movf format (micro_mips) */
+	unsigned int func:6;
+	unsigned int op:3;
+	unsigned int fmt:2;
+	unsigned int zero:2;
+	unsigned int cc:3;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp3_format {		/* FPU abs and neg format (micro_mips) */
+	unsigned int func:6;
+	unsigned int op:7;
+	unsigned int fmt:3;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp4_format {		/* FPU c.cond format (micro_mips) */
+	unsigned int func:6;
+	unsigned int cond:4;
+	unsigned int fmt:3;
+	unsigned int cc:3;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp5_format {		/* FPU lwxc1 and swxc1 format (micro_mips) */
+	unsigned int func:6;
+	unsigned int op:5;
+	unsigned int fd:5;
+	unsigned int base:5;
+	unsigned int index:5;
+	unsigned int opcode:6;
+};
+
+struct fp6_format {		/* FPU madd and msub format (MIPS IV) */
+	unsigned int func:6;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int fr:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp6_format {		/* FPU madd and msub format (micro_mips) */
+	unsigned int func:6;
+	unsigned int fr:5;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int opcode:6;
+};
+
+struct mm16b1_format {		/* micro_mips 16-bit branch format */
+	unsigned int duplicate:16;	/* a copy of the instn */
+	signed int simmediate:7;
+	unsigned int rs:3;
+	unsigned int opcode:6;
+};
+
+struct mm16b0_format {		/* micro_mips 16-bit branch format */
+	unsigned int duplicate:16;	/* a copy of the instn */
+	signed int simmediate:10;
+	unsigned int opcode:6;
+};
+
+struct mm_i_format {		/* Immediate format */
+	signed int simmediate:16;
+	unsigned int rs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+/*  MIPS16e */
+
+struct rr {
+	unsigned int func:5;
+	unsigned int ra:1;
+	unsigned int l:1;
+	unsigned int nd:1;
+	unsigned int rx:3;
+	unsigned int opcode:5;
+};
+
+struct jal {
+	/* unsigned int    imm20_15:0;  here is only first 16bits in first HW */
+	signed int imm25_21:5;
+	unsigned int imm20_16:5;
+	unsigned int x:1;
+	unsigned int opcode:5;
+};
+
+struct i64 {
+	unsigned int imm:8;
+	unsigned int func:3;
+	unsigned int opcode:5;
+};
+
+struct ri64 {
+	unsigned int imm:5;
+	unsigned int ry:3;
+	unsigned int func:3;
+	unsigned int opcode:5;
+};
+
+struct ri {
+	unsigned int imm:8;
+	unsigned int rx:3;
+	unsigned int opcode:5;
+};
+
+struct rri {
+	unsigned int imm:5;
+	unsigned int ry:3;
+	unsigned int rx:3;
+	unsigned int opcode:5;
+};
+
+struct i8 {
+	unsigned int imm:8;
+	unsigned int func:3;
+	unsigned int opcode:5;
+};
+
+struct mm_m_format {
+	signed int simmediate:12;
+	unsigned int func:4;
+	unsigned int base:5;
+	unsigned int rd:5;
+	unsigned int opcode:6;
+};
+
+struct mm_x_format {
+	unsigned int func:11;
+	unsigned int rd:5;
+	unsigned int base:5;
+	unsigned int index:5;
+	unsigned int opcode:6;
+};
+
+struct mm16_m_format {
+	unsigned int duplicate:16;	/* a copy of the instn */
+	unsigned int imm:4;
+	unsigned int rlist:2;
+	unsigned int func:4;
+	unsigned int opcode:6;
+};
+
+struct mm16_rb_format {
+	unsigned int duplicate:16;	/* a copy of the instn */
+	signed int simmediate:4;
+	unsigned int base:3;
+	unsigned int rt:3;
+	unsigned int opcode:6;
+};
+
+struct mm16_r5_format {
+	unsigned int duplicate:16;	/* a copy of the instn */
+	signed int simmediate:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm16_r3_format {
+	unsigned int duplicate:16;	/* a copy of the instn */
+	signed int simmediate:7;
+	unsigned int rt:3;
+	unsigned int opcode:6;
+};
+
 #else /* !defined (__MIPSEB__) && !defined (__MIPSEL__) */
 #error "MIPS but neither __MIPSEL__ nor __MIPSEB__?"
 #endif
@@ -356,6 +795,26 @@ union mips_instruction {
 	struct f_format f_format;
 	struct ma_format ma_format;
 	struct b_format b_format;
+	struct mm16b0_format mm16b0_format;
+	struct mm16b1_format mm16b1_format;
+	struct mm_i_format mm_i_format;
+	struct fb_format fb_format;
+	struct fp0_format fp0_format;
+	struct fp1_format fp1_format;
+	struct fp6_format fp6_format;
+	struct mm_fp0_format mm_fp0_format;
+	struct mm_fp1_format mm_fp1_format;
+	struct mm_fp2_format mm_fp2_format;
+	struct mm_fp3_format mm_fp3_format;
+	struct mm_fp4_format mm_fp4_format;
+	struct mm_fp5_format mm_fp5_format;
+	struct mm_fp6_format mm_fp6_format;
+	struct mm_m_format mm_m_format;
+	struct mm_x_format mm_x_format;
+	struct mm16_m_format mm16_m_format;
+	struct mm16_rb_format mm16_rb_format;
+	struct mm16_r3_format mm16_r3_format;
+	struct mm16_r5_format mm16_r5_format;
 };
 
 /* HACHACHAHCAHC ...  */
@@ -418,4 +877,319 @@ union mips_instruction {
 
 typedef unsigned int mips_instruction;
 
+/* The following are for micro_mips mode */
+#define MM_16_OPCODE_SFT        10
+#define MM_NOP16                0x0c00
+#define MM_POOL32A_MINOR_MSK    0x3f
+#define MM_POOL32A_MINOR_SFT    0x6
+#define MIPS32_COND_FC          0x30
+
+/*
+ * Major opcodes; micro_mips mode.
+ */
+enum mm_major_op {
+	mm_pool32a_op, mm_pool16a_op, mm_lbu16_op, mm_move16_op,
+	mm_addi32_op, mm_lbu32_op, mm_sb32_op, mm_lb32_op,
+	mm_pool32b_op, mm_pool16b_op, mm_lhu16_op, mm_andi16_op,
+	mm_addiu32_op, mm_lhu32_op, mm_sh32_op, mm_lh32_op,
+	mm_pool32i_op, mm_pool16c_op, mm_lwsp16_op, mm_pool16d_op,
+	mm_ori32_op, mm_pool32f_op, mm_reserved1_op, mm_reserved2_op,
+	mm_pool32c_op, mm_lwgp16_op, mm_lw16_op, mm_pool16e_op,
+	mm_xori32_op, mm_jals32_op, mm_addiupc_op, mm_reserved3_op,
+	mm_reserved4_op, mm_pool16f_op, mm_sb16_op, mm_beqz16_op,
+	mm_slti32_op, mm_beq32_op, mm_swc132_op, mm_lwc132_op,
+	mm_reserved5_op, mm_reserved6_op, mm_sh16_op, mm_bnez16_op,
+	mm_sltiu32_op, mm_bne32_op, mm_sdc132_op, mm_ldc132_op,
+	mm_reserved7_op, mm_reserved8_op, mm_swsp16_op, mm_b16_op,
+	mm_andi32_op, mm_j32_op, mm_sd32_op, mm_ld32_op,
+	mm_reserved11_op, mm_reserved12_op, mm_sw16_op, mm_li16_op,
+	mm_jalx32_op, mm_jal32_op, mm_sw32_op, mm_lw32_op,
+};
+
+/*
+ * POOL32I minor opcodes.
+ */
+enum mm_32i_minor_op {
+	mm_bltz_op, mm_bltzal_op, mm_bgez_op, mm_bgezal_op,
+	mm_blez_op, mm_bnezc_op, mm_bgtz_op, mm_beqzc_op,
+	mm_tlti_op, mm_tgei_op, mm_tltiu_op, mm_tgeiu_op,
+	mm_tnei_op, mm_lui_op, mm_teqi_op, mm_reserved13_op,
+	mm_synci_op, mm_bltzals_op, mm_reserved14_op, mm_bgezals_op,
+	mm_bc2f_op, mm_bc2t_op, mm_reserved15_op, mm_reserved16_op,
+	mm_reserved17_op, mm_reserved18_op, mm_bposge64_op, mm_bposge32_op,
+	mm_bc1f_op, mm_bc1t_op, mm_reserved19_op, mm_reserved20_op,
+	mm_bc1any2f_op, mm_bc1any2t_op, mm_bc1any4f_op, mm_bc1any4t_op,
+};
+
+/*
+ * POOL32A minor opcodes.
+ */
+enum mm_32a_minor_op {
+	mm_sll32_op = 0x000,
+	mm_ins_op = 0x00c,
+	mm_ext_op = 0x02c,
+	mm_pool32axf_op = 0x03c,
+	mm_srl32_op = 0x040,
+	mm_sra_op = 0x080,
+	mm_rotr_op = 0x0c0,
+	mm_lwxs_op = 0x118,
+	mm_addu32_op = 0x150,
+	mm_subu32_op = 0x1d0,
+	mm_and_op = 0x250,
+	mm_or32_op = 0x290,
+	mm_xor32_op = 0x310,
+};
+
+/*
+ * POOL32B functions.
+ */
+enum mm_32b_func {
+	mm_lwc2_func = 0x0,
+	mm_lwp_func = 0x1,
+	mm_ldc2_func = 0x2,
+	mm_ldp_func = 0x4,
+	mm_lwm32_func = 0x5,
+	mm_cache_func = 0x6,
+	mm_ldm_func = 0x7,
+	mm_swc2_func = 0x8,
+	mm_swp_func = 0x9,
+	mm_sdc2_func = 0xa,
+	mm_sdp_func = 0xc,
+	mm_swm32_func = 0xd,
+	mm_sdm_func = 0xf,
+};
+
+/*
+ * POOL32C functions.
+ */
+enum mm_32c_func {
+	mm_pref_func = 0x2,
+	mm_ll_func = 0x3,
+	mm_swr_func = 0x9,
+	mm_sc_func = 0xb,
+	mm_lwu_func = 0xe,
+};
+
+/*
+ * POOL32AXF minor opcodes.
+ */
+enum mm_32axf_minor_op {
+	mm_mfc0_op = 0x003,
+	mm_mtc0_op = 0x00b,
+	mm_tlbp_op = 0x00d,
+	mm_jalr_op = 0x03c,
+	mm_tlbr_op = 0x04d,
+	mm_jalrhb_op = 0x07c,
+	mm_tlbwi_op = 0x08d,
+	mm_tlbwr_op = 0x0cd,
+	mm_jalrs_op = 0x13c,
+	mm_jalrshb_op = 0x17c,
+	mm_syscall_op = 0x22d,
+	mm_eret_op = 0x3cd,
+};
+
+/*
+ * POOL32F minor opcodes.
+ */
+enum mm_32f_minor_op {
+	mm_32f_00_op = 0x00,
+	mm_32f_01_op = 0x01,
+	mm_32f_02_op = 0x02,
+	mm_32f_10_op = 0x08,
+	mm_32f_11_op = 0x09,
+	mm_32f_12_op = 0x0a,
+	mm_32f_20_op = 0x10,
+	mm_32f_30_op = 0x18,
+	mm_32f_40_op = 0x20,
+	mm_32f_41_op = 0x21,
+	mm_32f_42_op = 0x22,
+	mm_32f_50_op = 0x28,
+	mm_32f_51_op = 0x29,
+	mm_32f_52_op = 0x2a,
+	mm_32f_60_op = 0x30,
+	mm_32f_70_op = 0x38,
+	mm_32f_73_op = 0x3b,
+	mm_32f_74_op = 0x3c,
+};
+
+/*
+ * POOL32F secondary minor opcodes.
+ */
+enum mm_32f_10_minor_op {
+	mm_lwxc1_op = 0x1,
+	mm_swxc1_op,
+	mm_ldxc1_op,
+	mm_sdxc1_op,
+	mm_luxc1_op,
+	mm_suxc1_op,
+};
+
+enum mm_32f_func {
+	mm_lwxc1_func = 0x048,
+	mm_swxc1_func = 0x088,
+	mm_ldxc1_func = 0x0c8,
+	mm_sdxc1_func = 0x108,
+};
+
+/*
+ * POOL32F secondary minor opcodes.
+ */
+enum mm_32f_40_minor_op {
+	mm_fmovf_op,
+	mm_fmovt_op,
+};
+
+/*
+ * POOL32F secondary minor opcodes.
+ */
+enum mm_32f_60_minor_op {
+	mm_fadd_op,
+	mm_fsub_op,
+	mm_fmul_op,
+	mm_fdiv_op,
+};
+
+/*
+ * POOL32F secondary minor opcodes.
+ */
+enum mm_32f_70_minor_op {
+	mm_fmovn_op,
+	mm_fmovz_op,
+};
+
+/*
+ * POOL32F secondary minor opcodes (POOL32FXF).
+ */
+enum mm_32f_73_minor_op {
+	mm_fmov0_op = 0x01,
+	mm_fcvtl_op = 0x04,
+	mm_movf0_op = 0x05,
+	mm_frsqrt_op = 0x08,
+	mm_ffloorl_op = 0x0c,
+	mm_fabs0_op = 0x0d,
+	mm_fcvtw_op = 0x24,
+	mm_movt0_op = 0x25,
+	mm_fsqrt_op = 0x28,
+	mm_ffloorw_op = 0x2c,
+	mm_fneg0_op = 0x2d,
+	mm_cfc1_op = 0x40,
+	mm_frecip_op = 0x48,
+	mm_fceill_op = 0x4c,
+	mm_fcvtd0_op = 0x4d,
+	mm_ctc1_op = 0x60,
+	mm_fceilw_op = 0x6c,
+	mm_fcvts0_op = 0x6d,
+	mm_mfc1_op = 0x80,
+	mm_fmov1_op = 0x81,
+	mm_movf1_op = 0x85,
+	mm_ftruncl_op = 0x8c,
+	mm_fabs1_op = 0x8d,
+	mm_mtc1_op = 0xa0,
+	mm_movt1_op = 0xa5,
+	mm_ftruncw_op = 0xac,
+	mm_fneg1_op = 0xad,
+	mm_froundl_op = 0xcc,
+	mm_fcvtd1_op = 0xcd,
+	mm_froundw_op = 0xec,
+	mm_fcvts1_op = 0xed,
+};
+
+/*
+ * POOL16C minor opcodes.
+ */
+enum mm_16c_minor_op {
+	mm_lwm16_op = 0x04,
+	mm_swm16_op = 0x05,
+	mm_jr16_op = 0x18,
+	mm_jrc_op = 0x1a,
+	mm_jalr16_op = 0x1c,
+	mm_jalrs16_op = 0x1e,
+};
+
+/*
+ * POOL16D minor opcodes.
+ */
+enum mm_16d_minor_op {
+	mm_addius5_func,
+	mm_addiusp_func,
+};
+
+struct decoded_instn {
+	mips_instruction insn;
+	mips_instruction next_insn;
+	int pc_inc;
+	int next_pc_inc;
+	int micro_mips_mode;
+};
+
+/*  recode table from MIPS16e register notation to GPR */
+extern int mips16e_reg2gpr[];
+
+union mips16e_instruction {
+	unsigned int full:16;
+	struct rr rr;
+	struct jal jal;
+	struct i64 i64;
+	struct ri64 ri64;
+	struct ri ri;
+	struct rri rri;
+	struct i8 i8;
+};
+
+enum MIPS16e_ops {
+	MIPS16e_jal_op = 003,
+	MIPS16e_ld_op = 007,
+	MIPS16e_i8_op = 014,
+	MIPS16e_sd_op = 017,
+	MIPS16e_lb_op = 020,
+	MIPS16e_lh_op = 021,
+	MIPS16e_lwsp_op = 022,
+	MIPS16e_lw_op = 023,
+	MIPS16e_lbu_op = 024,
+	MIPS16e_lhu_op = 025,
+	MIPS16e_lwpc_op = 026,
+	MIPS16e_lwu_op = 027,
+	MIPS16e_sb_op = 030,
+	MIPS16e_sh_op = 031,
+	MIPS16e_swsp_op = 032,
+	MIPS16e_sw_op = 033,
+	MIPS16e_rr_op = 035,
+	MIPS16e_extend_op = 036,
+	MIPS16e_i64_op = 037,
+};
+
+enum MIPS16e_i64_func {
+	MIPS16e_ldsp_func,
+	MIPS16e_sdsp_func,
+	MIPS16e_sdrasp_func,
+	MIPS16e_dadjsp_func,
+	MIPS16e_ldpc_func,
+};
+
+enum MIPS16e_rr_func {
+	MIPS16e_jr_func,
+};
+
+enum MIPS6e_i8_func {
+	MIPS16e_swrasp_func = 02,
+};
+
+/*
+ * This functions returns 1 if the micro_mips instr is a 16 bit instr.
+ * Otherwise return 0.
+ */
+#define MIPS_ISA_MODE   01
+#define is16mode(regs)  (regs->cp0_epc & MIPS_ISA_MODE)
+
+static inline int mm_is16bit(u16 instr)
+{
+	/* take LS 3 bits */
+	u16 opcode_low = (instr >> MM_16_OPCODE_SFT) & 0x7;
+
+	if (opcode_low >= 1 && opcode_low <= 3)
+		return 1;
+	else
+		return 0;
+}
+
 #endif /* _ASM_INST_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7f87d82..a16d9d0 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -9,6 +9,7 @@
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 07 MIPS Technologies, Inc.
  * Copyright (C) 2003, 2004  Maciej W. Rozycki
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  */
 #ifndef _ASM_MIPSREGS_H
 #define _ASM_MIPSREGS_H
@@ -106,6 +107,11 @@
 #define CP0_S3_SRSMAP	  $12	/* MIPSR2 */
 
 /*
+ * Coprocessor 0 Set 5 register names
+ */
+#define CP0_S5_SRSMAP2	  $12	/* MIPSR2 */
+
+/*
  *  TX39 Series
  */
 #define CP0_TX39_CACHE	$7
@@ -591,13 +597,18 @@
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
+#define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
+#define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
 
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
 #define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
 #define MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT (_ULCAST_(1) << 14)
 
-#define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
+#define MIPS_CONF6_SYND         (_ULCAST_(1) << 13)
 
+#define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
+#define MIPS_CONF7_AR           (_ULCAST_(1) << 16)
+#define MIPS_CONF7_IAR          (_ULCAST_(1) << 10)
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
 
 
@@ -626,10 +637,10 @@
 	unsigned int __res;					\
 	__asm__ __volatile__(					\
 	"mfpc\t%0, %1"						\
-        : "=r" (__res)						\
+	: "=r" (__res)						\
 	: "i" (counter));					\
 								\
-        __res;							\
+	__res;							\
 })
 
 #define write_r10k_perf_cntr(counter,val)                       \
@@ -645,10 +656,10 @@ do {								\
 	unsigned int __res;					\
 	__asm__ __volatile__(					\
 	"mfps\t%0, %1"						\
-        : "=r" (__res)						\
+	: "=r" (__res)						\
 	: "i" (counter));					\
 								\
-        __res;							\
+	__res;							\
 })
 
 #define write_r10k_perf_cntl(counter,val)                       \
@@ -1073,6 +1084,9 @@ do {									\
 #define read_c0_srsmap()	__read_32bit_c0_register($12, 3)
 #define write_c0_srsmap(val)	__write_32bit_c0_register($12, 3, val)
 
+#define read_c0_srsmap2()	__read_32bit_c0_register($12, 5)
+#define write_c0_srsmap2(val)	__write_32bit_c0_register($12, 5, val)
+
 #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
 #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
 
@@ -1144,48 +1158,31 @@ do {									\
 /*
  * Macros to access the floating point coprocessor control registers
  */
-#define read_32bit_cp1_register(source)                         \
-({ int __res;                                                   \
-	__asm__ __volatile__(                                   \
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
-	".set\tmips1\n\t"					\
-        "cfc1\t%0,"STR(source)"\n\t"                            \
-	".set\tpop"						\
-        : "=r" (__res));                                        \
-        __res;})
-
-#define rddsp(mask)							\
+#define read_32bit_cp1_register(source)					\
 ({									\
-	unsigned int __res;						\
+	int __res;							\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push				\n"		\
-	"	.set	noat				\n"		\
-	"	# rddsp $1, %x1				\n"		\
-	"	.word	0x7c000cb8 | (%x1 << 16)	\n"		\
-	"	move	%0, $1				\n"		\
-	"	.set	pop				\n"		\
-	: "=r" (__res)							\
-	: "i" (mask));							\
-	__res;								\
-})
-
-#define wrdsp(val, mask)						\
-do {									\
-	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# wrdsp $1, %x1					\n"	\
-	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
+	"	.set	reorder					\n"	\
+	"	# gas fails to assemble cfc1 for some archs,	\n"	\
+	"	# like Octeon.					\n"	\
+	"	.set	mips1					\n"	\
+	"	cfc1	%0,"STR(source)"			\n"	\
 	"	.set	pop					\n"	\
-        :								\
-	: "r" (val), "i" (mask));					\
-} while (0)
+	: "=r" (__res));						\
+	__res;								\
+})
 
+/*
+ * Macros to access the DSP ASE registers
+ */
 #if 0	/* Need DSP ASE capable assembler ... */
+#define rddsp(mask)							\
+({ long dspctl; __asm__("rddsp %0, %x1" : "=r" (dspctl) : "i" (mask)); dspctl;})
+
+#define wrdsp(val, mask) (__asm__("wrdsp %0, %x1" : "r" (val) : "i" (mask)))
+
 #define mflo0() ({ long mflo0; __asm__("mflo %0, $ac0" : "=r" (mflo0)); mflo0;})
 #define mflo1() ({ long mflo1; __asm__("mflo %0, $ac1" : "=r" (mflo1)); mflo1;})
 #define mflo2() ({ long mflo2; __asm__("mflo %0, $ac2" : "=r" (mflo2)); mflo2;})
@@ -1208,230 +1205,178 @@ do {									\
 
 #else
 
-#define mfhi0()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac0		\n"			\
-	"	.word	0x00000810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi1()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac1		\n"			\
-	"	.word	0x00200810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi2()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac2		\n"			\
-	"	.word	0x00400810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mfhi3()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mfhi	%0, $ac3		\n"			\
-	"	.word	0x00600810		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo0()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac0		\n"			\
-	"	.word	0x00000812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo1()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac1		\n"			\
-	"	.word	0x00200812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo2()								\
-({									\
-	unsigned long __treg;						\
-									\
-	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac2		\n"			\
-	"	.word	0x00400812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mflo3()								\
+#ifdef CONFIG_CPU_MICROMIPS
+#define rddsp(mask)							\
 ({									\
-	unsigned long __treg;						\
+	unsigned int __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push			\n"			\
-	"	.set	noat			\n"			\
-	"	# mflo	%0, $ac3		\n"			\
-	"	.word	0x00600812		\n"			\
-	"	move	%0, $1			\n"			\
-	"	.set	pop			\n"			\
-	: "=r" (__treg));						\
-	__treg;								\
-})
-
-#define mthi0(x)							\
-do {									\
-	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac0				\n"	\
-	"	.word	0x00200011				\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020067c | (%x1 << 14)) & 0xffff)	\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__res)							\
+	: "i" (mask));							\
+	__res;								\
+})
 
-#define mthi1(x)							\
+#define wrdsp(val, mask)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac1				\n"	\
-	"	.word	0x00200811				\n"	\
+	"	# wrdsp $1, %x1					\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) >> 16)	\n"	\
+	"	.hword	((0x0020167c | (%x1 << 14)) & 0xffff)	\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define mthi2(x)							\
-do {									\
+#define _umips_dsp_mfxxx(ins)						\
+({									\
+	unsigned long __treg;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac2				\n"	\
-	"	.word	0x00201011				\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__treg)							\
+	: "i" (ins));							\
+	__treg;								\
+})
 
-#define mthi3(x)							\
+#define _umips_dsp_mtxxx(val, ins)					\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mthi	$1, $ac3				\n"	\
-	"	.word	0x00201811				\n"	\
+	"	.hword	0x0001					\n"	\
+	"	.hword	%x1					\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (ins));					\
 } while (0)
 
-#define mtlo0(x)							\
-do {									\
+#define _umips_dsp_mflo(reg) _umips_dsp_mfxxx((reg << 14) | 0x107c)
+#define _umips_dsp_mfhi(reg) _umips_dsp_mfxxx((reg << 14) | 0x007c)
+
+#define _umips_dsp_mtlo(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x307c))
+#define _umips_dsp_mthi(val, reg) _umips_dsp_mtxxx(val, ((reg << 14) | 0x207c))
+
+#define mflo0() _umips_dsp_mflo(0)
+#define mflo1() _umips_dsp_mflo(1)
+#define mflo2() _umips_dsp_mflo(2)
+#define mflo3() _umips_dsp_mflo(3)
+
+#define mfhi0() _umips_dsp_mfhi(0)
+#define mfhi1() _umips_dsp_mfhi(1)
+#define mfhi2() _umips_dsp_mfhi(2)
+#define mfhi3() _umips_dsp_mfhi(3)
+
+#define mtlo0(x) _umips_dsp_mtlo(x, 0)
+#define mtlo1(x) _umips_dsp_mtlo(x, 1)
+#define mtlo2(x) _umips_dsp_mtlo(x, 2)
+#define mtlo3(x) _umips_dsp_mtlo(x, 3)
+
+#define mthi0(x) _umips_dsp_mthi(x, 0)
+#define mthi1(x) _umips_dsp_mthi(x, 1)
+#define mthi2(x) _umips_dsp_mthi(x, 2)
+#define mthi3(x) _umips_dsp_mthi(x, 3)
+
+#else  /* !CONFIG_CPU_MICROMIPS */
+
+#define rddsp(mask)							\
+({									\
+	unsigned int __res;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac0				\n"	\
-	"	.word	0x00200013				\n"	\
+	"	# rddsp $1, %x1					\n"	\
+	"	.word	0x7c000cb8 | (%x1 << 16)		\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__res)							\
+	: "i" (mask));							\
+	__res;								\
+})
 
-#define mtlo1(x)							\
+#define wrdsp(val, mask)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac1				\n"	\
-	"	.word	0x00200813				\n"	\
+	"	# wrdsp $1, %x1					\n"	\
+	"	.word	0x7c2004f8 | (%x1 << 11)		\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (mask));					\
 } while (0)
 
-#define mtlo2(x)							\
-do {									\
+#define _dsp_mfxxx(ins)							\
+({									\
+	unsigned long __treg;						\
+									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac2				\n"	\
-	"	.word	0x00201013				\n"	\
+	"	.word	(0x00000810 | %1)			\n"	\
+	"	move	%0, $1					\n"	\
 	"	.set	pop					\n"	\
-	:								\
-	: "r" (x));							\
-} while (0)
+	: "=r" (__treg)							\
+	: "i" (ins));							\
+	__treg;								\
+})
 
-#define mtlo3(x)							\
+#define _dsp_mtxxx(val, ins)						\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
-	"	# mtlo	$1, $ac3				\n"	\
-	"	.word	0x00201813				\n"	\
+	"	.word	(0x00200011 | %1)			\n"	\
 	"	.set	pop					\n"	\
 	:								\
-	: "r" (x));							\
+	: "r" (val), "i" (ins));					\
 } while (0)
 
+#define _dsp_mflo(reg) _dsp_mfxxx((reg << 21) | 0x0002)
+#define _dsp_mfhi(reg) _dsp_mfxxx((reg << 21) | 0x0000)
+
+#define _dsp_mtlo(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0002))
+#define _dsp_mthi(val, reg) _dsp_mtxxx(val, ((reg << 11) | 0x0000))
+
+#define mflo0() _dsp_mflo(0)
+#define mflo1() _dsp_mflo(1)
+#define mflo2() _dsp_mflo(2)
+#define mflo3() _dsp_mflo(3)
+
+#define mfhi0() _dsp_mfhi(0)
+#define mfhi1() _dsp_mfhi(1)
+#define mfhi2() _dsp_mfhi(2)
+#define mfhi3() _dsp_mfhi(3)
+
+#define mtlo0(x) _dsp_mtlo(x, 0)
+#define mtlo1(x) _dsp_mtlo(x, 1)
+#define mtlo2(x) _dsp_mtlo(x, 2)
+#define mtlo3(x) _dsp_mtlo(x, 3)
+
+#define mthi0(x) _dsp_mthi(x, 0)
+#define mthi1(x) _dsp_mthi(x, 1)
+#define mthi2(x) _dsp_mthi(x, 2)
+#define mthi3(x) _dsp_mthi(x, 3)
+
+#endif /* CONFIG_CPU_MICROMIPS */
 #endif
 
 /*
@@ -1665,8 +1610,10 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(intcontrol)
+__BUILD_SET_C0(srsctl)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
+__BUILD_SET_C0(srsmap2)
 __BUILD_SET_C0(brcm_config_0)
 __BUILD_SET_C0(brcm_bus_pll)
 __BUILD_SET_C0(brcm_reset)
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index d3d0218..faa1e22 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -39,9 +39,18 @@ enum fields {
 #define OP_MASK		0x3f
 #define OP_SH		26
 #define RS_MASK		0x1f
-#define RS_SH		21
 #define RT_MASK		0x1f
+#ifdef CONFIG_CPU_MICROMIPS
+#define RS_SH		16
+#define RT_SH		21
+#define SCIMM_MASK	0x3ff
+#define SCIMM_SH	16
+#else
+#define RS_SH		21
 #define RT_SH		16
+#define SCIMM_MASK	0xfffff
+#define SCIMM_SH	6
+#endif
 #define RD_MASK		0x1f
 #define RD_SH		11
 #define RE_MASK		0x1f
@@ -54,8 +63,6 @@ enum fields {
 #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
-#define SCIMM_MASK	0xfffff
-#define SCIMM_SH	6
 
 enum opcode {
 	insn_invalid,
@@ -81,6 +88,15 @@ struct insn {
 };
 
 /* This macro sets the non-variable bits of an instruction. */
+#ifdef CONFIG_CPU_MICROMIPS
+#define M(a, b, c, d, e, f)					\
+	((a) << OP_SH						\
+	 | (b) << RT_SH						\
+	 | (c) << RS_SH						\
+	 | (d) << RD_SH						\
+	 | (e) << RE_SH						\
+	 | (f) << FUNC_SH)
+#else
 #define M(a, b, c, d, e, f)					\
 	((a) << OP_SH						\
 	 | (b) << RS_SH						\
@@ -88,10 +104,79 @@ struct insn {
 	 | (d) << RD_SH						\
 	 | (e) << RE_SH						\
 	 | (f) << FUNC_SH)
+#endif
 
+#ifdef CONFIG_CPU_MICROMIPS
+static struct insn insn_table[] __uasminitdata = {
+	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
+	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
+	{ insn_andi, M(mm_andi32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_beq, M(mm_beq32_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beql, 0, 0 },
+	{ insn_bgez, M(mm_pool32i_op, mm_bgez_op, 0, 0, 0, 0), RS | BIMM },
+	{ insn_bgezl, 0, 0 },
+	{ insn_bltz, M(mm_pool32i_op, mm_bltz_op, 0, 0, 0, 0), RS | BIMM },
+	{ insn_bltzl, 0, 0 },
+	{ insn_bne, M(mm_bne32_op, 0, 0, 0, 0, 0), RT | RS | BIMM },
+	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
+	{ insn_daddu, 0, 0 },
+	{ insn_daddiu, 0, 0 },
+	{ insn_dmfc0, 0, 0 },
+	{ insn_dmtc0, 0, 0 },
+	{ insn_dsll, 0, 0 },
+	{ insn_dsll32, 0, 0 },
+	{ insn_dsra, 0, 0 },
+	{ insn_dsrl, 0, 0 },
+	{ insn_dsrl32, 0, 0 },
+	{ insn_drotr, 0, 0 },
+	{ insn_drotr32, 0, 0 },
+	{ insn_dsubu, 0, 0 },
+	{ insn_eret, M(mm_pool32a_op, 0, 0, 0, mm_eret_op, mm_pool32axf_op), 0 },
+	{ insn_ins, M(mm_pool32a_op, 0, 0, 0, 0, mm_ins_op), RT | RS | RD | RE },
+	{ insn_ext, M(mm_pool32a_op, 0, 0, 0, 0, mm_ext_op), RT | RS | RD | RE },
+	{ insn_j, M(mm_j32_op, 0, 0, 0, 0, 0), JIMM },
+	{ insn_jal, M(mm_jal32_op, 0, 0, 0, 0, 0), JIMM },
+	{ insn_jr, M(mm_pool32a_op, 0, 0, 0, mm_jalr_op, mm_pool32axf_op), RS },
+	{ insn_ld, 0, 0 },
+	{ insn_ll, M(mm_pool32c_op, 0, 0, (mm_ll_func << 1), 0, 0), RS | RT | SIMM },
+	{ insn_lld, 0, 0 },
+	{ insn_lui, M(mm_pool32i_op, mm_lui_op, 0, 0, 0, 0), RS | SIMM },
+	{ insn_lw, M(mm_lw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_mfc0, M(mm_pool32a_op, 0, 0, 0, mm_mfc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_mtc0, M(mm_pool32a_op, 0, 0, 0, mm_mtc0_op, mm_pool32axf_op), RT | RS | RD },
+	{ insn_or, M(mm_pool32a_op, 0, 0, 0, 0, mm_or32_op), RT | RS | RD },
+	{ insn_ori, M(mm_ori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_pref, M(mm_pool32c_op, 0, 0, (mm_pref_func << 1), 0, 0), RT | RS | SIMM },
+	{ insn_rfe, 0, 0 },
+	{ insn_sc, M(mm_pool32c_op, 0, 0, (mm_sc_func << 1), 0, 0), RT | RS | SIMM },
+	{ insn_scd, 0, 0 },
+	{ insn_sd, 0, 0 },
+	{ insn_sll, M(mm_pool32a_op, 0, 0, 0, 0, mm_sll32_op), RT | RS | RD },
+	{ insn_sra, M(mm_pool32a_op, 0, 0, 0, 0, mm_sra_op), RT | RS | RD },
+	{ insn_srl, M(mm_pool32a_op, 0, 0, 0, 0, mm_srl32_op), RT | RS | RD },
+	{ insn_rotr, M(mm_pool32a_op, 0, 0, 0, 0, mm_rotr_op), RT | RS | RD },
+	{ insn_subu, M(mm_pool32a_op, 0, 0, 0, 0, mm_subu32_op), RT | RS | RD },
+	{ insn_sw, M(mm_sw32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
+	{ insn_tlbp, M(mm_pool32a_op, 0, 0, 0, mm_tlbp_op, mm_pool32axf_op), 0 },
+	{ insn_tlbr, M(mm_pool32a_op, 0, 0, 0, mm_tlbr_op, mm_pool32axf_op), 0 },
+	{ insn_tlbwi, M(mm_pool32a_op, 0, 0, 0, mm_tlbwi_op, mm_pool32axf_op), 0 },
+	{ insn_tlbwr, M(mm_pool32a_op, 0, 0, 0, mm_tlbwr_op, mm_pool32axf_op), 0 },
+	{ insn_xor, M(mm_pool32a_op, 0, 0, 0, 0, mm_xor32_op), RT | RS | RD },
+	{ insn_xori, M(mm_xori32_op, 0, 0, 0, 0, 0), RT | RS | UIMM },
+	{ insn_dins, 0, 0 },
+	{ insn_dinsm, 0, 0 },
+	{ insn_syscall, M(mm_pool32a_op, 0, 0, 0, mm_syscall_op, mm_pool32axf_op), SCIMM},
+	{ insn_bbit0, 0, 0 },
+	{ insn_bbit1, 0, 0 },
+	{ insn_lwx, 0, 0 },
+	{ insn_ldx, 0, 0 },
+	{ insn_invalid, 0, 0 }
+};
+#else
 static struct insn insn_table[] __uasminitdata = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
+	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
 	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
 	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
@@ -102,8 +187,8 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
 	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
 	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
 	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
@@ -155,88 +240,112 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_invalid, 0, 0 }
 };
+#endif
 
 #undef M
 
 static inline __uasminit u32 build_rs(u32 arg)
 {
-	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler RS field overflow\n");
 
 	return (arg & RS_MASK) << RS_SH;
 }
 
 static inline __uasminit u32 build_rt(u32 arg)
 {
-	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~RT_MASK)
+		printk(KERN_WARNING "Micro-assembler RT field overflow\n");
 
 	return (arg & RT_MASK) << RT_SH;
 }
 
 static inline __uasminit u32 build_rd(u32 arg)
 {
-	WARN(arg & ~RD_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~RD_MASK)
+		printk(KERN_WARNING "Micro-assembler RD field overflow\n");
 
 	return (arg & RD_MASK) << RD_SH;
 }
 
 static inline __uasminit u32 build_re(u32 arg)
 {
-	WARN(arg & ~RE_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~RE_MASK)
+		printk(KERN_WARNING "Micro-assembler RE field overflow\n");
 
 	return (arg & RE_MASK) << RE_SH;
 }
 
 static inline __uasminit u32 build_simm(s32 arg)
 {
-	WARN(arg > 0x7fff || arg < -0x8000,
-	     KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg > 0x7fff || arg < -0x8000)
+		printk(KERN_WARNING "Micro-assembler SIMM field overflow\n");
 
 	return arg & 0xffff;
 }
 
 static inline __uasminit u32 build_uimm(u32 arg)
 {
-	WARN(arg & ~IMM_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~IMM_MASK)
+		printk(KERN_WARNING "Micro-assembler UIMM field overflow\n");
 
 	return arg & IMM_MASK;
 }
 
 static inline __uasminit u32 build_bimm(s32 arg)
 {
-	WARN(arg > 0x1ffff || arg < -0x20000,
-	     KERN_WARNING "Micro-assembler field overflow\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	if (arg > 0xffff || arg < -0x10000)
+#else
+	if (arg > 0x1ffff || arg < -0x20000)
+#endif
+		printk(KERN_WARNING "Micro-assembler BIMM field overflow\n");
 
-	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
+	if (arg & 0x3)
+		printk(KERN_WARNING "Invalid micro-assembler branch target\n");
 
+#ifdef CONFIG_CPU_MICROMIPS
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 1) & 0x7fff);
+#else
 	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+#endif
 }
 
 static inline __uasminit u32 build_jimm(u32 arg)
 {
-	WARN(arg & ~(JIMM_MASK << 2),
-	     KERN_WARNING "Micro-assembler field overflow\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	if ((arg & ~((JIMM_MASK) << 1)) - 1)
+#else
+	if (arg & ~((JIMM_MASK) << 2))
+#endif
+		printk(KERN_WARNING "Micro-assembler JIMM field overflow\n");
 
+#ifdef CONFIG_CPU_MICROMIPS
+	return (arg >> 1) & JIMM_MASK;
+#else
 	return (arg >> 2) & JIMM_MASK;
+#endif
 }
 
 static inline __uasminit u32 build_scimm(u32 arg)
 {
-	WARN(arg & ~SCIMM_MASK,
-	     KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~SCIMM_MASK)
+		printk(KERN_WARNING "Micro-assembler SCIMM field overflow\n");
 
 	return (arg & SCIMM_MASK) << SCIMM_SH;
 }
 
 static inline __uasminit u32 build_func(u32 arg)
 {
-	WARN(arg & ~FUNC_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~FUNC_MASK)
+		printk(KERN_WARNING "Micro-assembler FUNC field overflow\n");
 
 	return arg & FUNC_MASK;
 }
 
 static inline __uasminit u32 build_set(u32 arg)
 {
-	WARN(arg & ~SET_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~SET_MASK)
+		printk(KERN_WARNING "Micro-assembler SET field overflow\n");
 
 	return arg & SET_MASK;
 }
@@ -264,9 +373,23 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 	op = ip->match;
 	va_start(ap, opc);
 	if (ip->fields & RS)
+	{
+#ifdef CONFIG_CPU_MICROMIPS
+	if (opc == insn_mfc0 || opc == insn_mtc0)
+		op |= build_rt(va_arg(ap, u32));
+	else
+#endif
 		op |= build_rs(va_arg(ap, u32));
+	}
 	if (ip->fields & RT)
+	{
+#ifdef CONFIG_CPU_MICROMIPS
+	if (opc == insn_mfc0 || opc == insn_mtc0)
+		op |= build_rs(va_arg(ap, u32));
+	else
+#endif
 		op |= build_rt(va_arg(ap, u32));
+	}
 	if (ip->fields & RD)
 		op |= build_rd(va_arg(ap, u32));
 	if (ip->fields & RE)
@@ -287,7 +410,11 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 		op |= build_scimm(va_arg(ap, u32));
 	va_end(ap);
 
+#if defined(CONFIG_CPU_MICROMIPS) && defined(CONFIG_CPU_LITTLE_ENDIAN)
+	**buf = ((op & 0xffff) << 16) | (op >> 16);
+#else
 	**buf = op;
+#endif
 	(*buf)++;
 }
 
@@ -562,7 +689,11 @@ __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 
 	switch (rel->type) {
 	case R_MIPS_PC16:
+#if defined(CONFIG_CPU_MICROMIPS) && defined(CONFIG_CPU_LITTLE_ENDIAN)
+		*rel->addr |= (build_bimm(laddr - (raddr + 4)) << 16);
+#else
 		*rel->addr |= build_bimm(laddr - (raddr + 4));
+#endif
 		break;
 
 	default:
-- 
1.7.10
