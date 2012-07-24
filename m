Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:43:02 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49879 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903774Ab2GXVke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:34 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1StmqB-0003yN-Fq; Tue, 24 Jul 2012 16:40:27 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2,2/9] MIPS: Add support for microMIPS instructions.
Date:   Tue, 24 Jul 2012 16:40:23 -0500
Message-Id: <1343166023-1827-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33978
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
 arch/mips/include/asm/inst.h  | 774 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/uasm-micromips.c | 194 +++++++++++
 arch/mips/mm/uasm-mips.c      | 178 ++++++++++
 arch/mips/mm/uasm.c           | 210 ++----------
 4 files changed, 1180 insertions(+), 176 deletions(-)
 create mode 100644 arch/mips/mm/uasm-micromips.c
 create mode 100644 arch/mips/mm/uasm-mips.c

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index ab84064..6212f58 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 1996, 2000 by Ralf Baechle
  * Copyright (C) 2006 by Thiemo Seufer
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #ifndef _ASM_INST_H
 #define _ASM_INST_H
@@ -267,6 +268,225 @@ struct b_format { /* BREAK and SYSCALL */
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
+struct mm_fp0_format {      /* FPU multipy and add format (microMIPS) */
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
+struct mm_fp1_format {      /* FPU mfc1 and cfc1 format (microMIPS) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int fmt:2;
+	unsigned int op:8;
+	unsigned int func:6;
+};
+
+struct mm_fp2_format {      /* FPU movt and movf format (microMIPS) */
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
+struct mm_fp3_format {      /* FPU abs and neg format (microMIPS) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int fmt:3;
+	unsigned int op:7;
+	unsigned int func:6;
+};
+
+struct mm_fp4_format {      /* FPU c.cond format (microMIPS) */
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	unsigned int fs:5;
+	unsigned int cc:3;
+	unsigned int fmt:3;
+	unsigned int cond:4;
+	unsigned int func:6;
+};
+
+struct mm_fp5_format {      /* FPU lwxc1 and swxc1 format (microMIPS) */
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
+struct mm_fp6_format {	/* FPU madd and msub format (microMIPS) */
+	unsigned int opcode:6;
+	unsigned int ft:5;
+	unsigned int fs:5;
+	unsigned int fd:5;
+	unsigned int fr:5;
+	unsigned int func:6;
+};
+
+struct mm16b1_format {		/* microMIPS 16-bit branch format */
+	unsigned int opcode:6;
+	unsigned int rs:3;
+	signed int simmediate:7;
+	unsigned int duplicate:16;	/* a copy of the instr */
+};
+
+struct mm16b0_format {		/* microMIPS 16-bit branch format */
+	unsigned int opcode:6;
+	signed int simmediate:10;
+	unsigned int duplicate:16;	/* a copy of the instr */
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
+	unsigned int duplicate:16;	/* a copy of the instr */
+};
+
+struct mm16_rb_format {
+	unsigned int opcode:6;
+	unsigned int rt:3;
+	unsigned int base:3;
+	signed int simmediate:4;
+	unsigned int duplicate:16;	/* a copy of the instr */
+};
+
+struct mm16_r5_format {
+	unsigned int opcode:6;
+	unsigned int rt:5;
+	signed int simmediate:5;
+	unsigned int duplicate:16;	/* a copy of the instr */
+};
+
+struct mm16_r3_format {
+	unsigned int opcode:6;
+	unsigned int rt:3;
+	signed int simmediate:7;
+	unsigned int duplicate:16;	/* a copy of the instr */
+};
+
 #elif defined(__MIPSEL__)
 
 struct j_format {	/* Jump format */
@@ -340,6 +560,225 @@ struct b_format { /* BREAK and SYSCALL */
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
+struct mm_fp0_format {		/* FPU multipy and add format (microMIPS) */
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
+struct mm_fp1_format {		/* FPU mfc1 and cfc1 format (microMIPS) */
+	unsigned int func:6;
+	unsigned int op:8;
+	unsigned int fmt:2;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp2_format {		/* FPU movt and movf format (microMIPS) */
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
+struct mm_fp3_format {		/* FPU abs and neg format (microMIPS) */
+	unsigned int func:6;
+	unsigned int op:7;
+	unsigned int fmt:3;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp4_format {		/* FPU c.cond format (microMIPS) */
+	unsigned int func:6;
+	unsigned int cond:4;
+	unsigned int fmt:3;
+	unsigned int cc:3;
+	unsigned int fs:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm_fp5_format {		/* FPU lwxc1 and swxc1 format (microMIPS) */
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
+struct mm_fp6_format {		/* FPU madd and msub format (microMIPS) */
+	unsigned int func:6;
+	unsigned int fr:5;
+	unsigned int fd:5;
+	unsigned int fs:5;
+	unsigned int ft:5;
+	unsigned int opcode:6;
+};
+
+struct mm16b1_format {		/* microMIPS 16-bit branch format */
+	unsigned int duplicate:16;	/* a copy of the instr */
+	signed int simmediate:7;
+	unsigned int rs:3;
+	unsigned int opcode:6;
+};
+
+struct mm16b0_format {		/* microMIPS 16-bit branch format */
+	unsigned int duplicate:16;	/* a copy of the instr */
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
+	unsigned int duplicate:16;	/* a copy of the instr */
+	unsigned int imm:4;
+	unsigned int rlist:2;
+	unsigned int func:4;
+	unsigned int opcode:6;
+};
+
+struct mm16_rb_format {
+	unsigned int duplicate:16;	/* a copy of the instr */
+	signed int simmediate:4;
+	unsigned int base:3;
+	unsigned int rt:3;
+	unsigned int opcode:6;
+};
+
+struct mm16_r5_format {
+	unsigned int duplicate:16;	/* a copy of the instr */
+	signed int simmediate:5;
+	unsigned int rt:5;
+	unsigned int opcode:6;
+};
+
+struct mm16_r3_format {
+	unsigned int duplicate:16;	/* a copy of the instr */
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
 
+/* The following are for microMIPS mode */
+#define MM_16_OPCODE_SFT        10
+#define MM_NOP16                0x0c00
+#define MM_POOL32A_MINOR_MSK    0x3f
+#define MM_POOL32A_MINOR_SFT    0x6
+#define MIPS32_COND_FC          0x30
+
+/*
+ * Major opcodes; microMIPS mode.
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
+/* Recode table from MIPS16e register notation to GPR */
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
+ * This functions returns 1 if the microMIPS instr is a 16 bit instr.
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
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
new file mode 100644
index 0000000..f2b834a
--- /dev/null
+++ b/arch/mips/mm/uasm-micromips.c
@@ -0,0 +1,194 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+
+#define RS_MASK		0x1f
+#define RS_SH		16
+#define RT_MASK		0x1f
+#define RT_SH		21
+#define SCIMM_MASK	0x3ff
+#define SCIMM_SH	16
+
+/* This macro sets the non-variable bits of an instruction. */
+#define M(a, b, c, d, e, f)					\
+	((a) << OP_SH						\
+	 | (b) << RT_SH						\
+	 | (c) << RS_SH						\
+	 | (d) << RD_SH						\
+	 | (e) << RE_SH						\
+	 | (f) << FUNC_SH)
+
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
+
+#undef M
+
+static inline __uasminit u32 build_bimm(s32 arg)
+{
+	if(arg > 0xffff || arg < -0x10000)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	if(arg & 0x3)
+		printk(KERN_WARNING "Invalid micro-assembler branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 1) & 0x7fff);
+}
+
+static inline __uasminit u32 build_jimm(u32 arg)
+{
+	if ((arg & ~(JIMM_MASK << 1)) - 1)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg >> 1) & JIMM_MASK;
+}
+
+/*
+ * The order of opcode arguments is implicitly left to right,
+ * starting with RS and ending with FUNC or IMM.
+ */
+static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
+{
+	struct insn *ip = NULL;
+	unsigned int i;
+	va_list ap;
+	u32 op;
+
+	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
+		if (insn_table[i].opcode == opc) {
+			ip = &insn_table[i];
+			break;
+		}
+
+	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+		panic("Unsupported Micro-assembler instruction %d", opc);
+
+	op = ip->match;
+	va_start(ap, opc);
+	if (ip->fields & RS) {
+		if (opc == insn_mfc0 || opc == insn_mtc0)
+			op |= build_rt(va_arg(ap, u32));
+		else
+			op |= build_rs(va_arg(ap, u32));
+	}
+	if (ip->fields & RT) {
+		if (opc == insn_mfc0 || opc == insn_mtc0)
+			op |= build_rs(va_arg(ap, u32));
+		else
+			op |= build_rt(va_arg(ap, u32));
+	}	
+	if (ip->fields & RD)
+		op |= build_rd(va_arg(ap, u32));
+	if (ip->fields & RE)
+		op |= build_re(va_arg(ap, u32));
+	if (ip->fields & SIMM)
+		op |= build_simm(va_arg(ap, s32));
+	if (ip->fields & UIMM)
+		op |= build_uimm(va_arg(ap, u32));
+	if (ip->fields & BIMM)
+		op |= build_bimm(va_arg(ap, s32));
+	if (ip->fields & JIMM)
+		op |= build_jimm(va_arg(ap, u32));
+	if (ip->fields & FUNC)
+		op |= build_func(va_arg(ap, u32));
+	if (ip->fields & SET)
+		op |= build_set(va_arg(ap, u32));
+	if (ip->fields & SCIMM)
+		op |= build_scimm(va_arg(ap, u32));
+	va_end(ap);
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	**buf = ((op & 0xffff) << 16) | (op >> 16);
+#else
+	**buf = op;
+#endif
+	(*buf)++;
+}
+
+static inline void __uasminit
+__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
+{
+	long laddr = (long)lab->addr;
+	long raddr = (long)rel->addr;
+
+	switch (rel->type) {
+	case R_MIPS_PC16:
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+		*rel->addr |= (build_bimm(laddr - (raddr + 4)) << 16);
+#else
+		*rel->addr |= build_bimm(laddr - (raddr + 4));
+#endif
+		break;
+
+	default:
+		panic("Unsupported Micro-assembler relocation %d",
+		      rel->type);
+	}
+}
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
new file mode 100644
index 0000000..e86334b
--- /dev/null
+++ b/arch/mips/mm/uasm-mips.c
@@ -0,0 +1,178 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+
+#define RS_MASK		0x1f
+#define RS_SH		21
+#define RT_MASK		0x1f
+#define RT_SH		16
+#define SCIMM_MASK	0xfffff
+#define SCIMM_SH	6
+
+/* This macro sets the non-variable bits of an instruction. */
+#define M(a, b, c, d, e, f)					\
+	((a) << OP_SH						\
+	 | (b) << RS_SH						\
+	 | (c) << RT_SH						\
+	 | (d) << RD_SH						\
+	 | (e) << RE_SH						\
+	 | (f) << FUNC_SH)
+
+static struct insn insn_table[] __uasminitdata = {
+	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
+	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
+	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
+	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
+	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
+	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
+	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
+	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
+	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
+	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
+	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
+	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
+	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
+	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
+	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
+	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
+	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
+	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),  RT | SIMM },
+	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
+	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
+	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
+	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
+	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
+	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
+	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
+	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
+	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
+	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
+	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
+	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
+	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
+	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
+	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
+	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
+	{ insn_invalid, 0, 0 }
+};
+
+#undef M
+
+static inline __uasminit u32 build_bimm(s32 arg)
+{
+	if(arg > 0x1ffff || arg < -0x20000)
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	if(arg & 0x3)
+		printk(KERN_WARNING "Invalid micro-assembler branch target\n");
+
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+}
+
+static inline __uasminit u32 build_jimm(u32 arg)
+{
+	if(arg & ~(JIMM_MASK << 2))
+		printk(KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg >> 2) & JIMM_MASK;
+}
+
+/*
+ * The order of opcode arguments is implicitly left to right,
+ * starting with RS and ending with FUNC or IMM.
+ */
+static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
+{
+	struct insn *ip = NULL;
+	unsigned int i;
+	va_list ap;
+	u32 op;
+
+	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
+		if (insn_table[i].opcode == opc) {
+			ip = &insn_table[i];
+			break;
+		}
+
+	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
+		panic("Unsupported Micro-assembler instruction %d", opc);
+
+	op = ip->match;
+	va_start(ap, opc);
+	if (ip->fields & RS)
+		op |= build_rs(va_arg(ap, u32));
+	if (ip->fields & RT)
+		op |= build_rt(va_arg(ap, u32));
+	if (ip->fields & RD)
+		op |= build_rd(va_arg(ap, u32));
+	if (ip->fields & RE)
+		op |= build_re(va_arg(ap, u32));
+	if (ip->fields & SIMM)
+		op |= build_simm(va_arg(ap, s32));
+	if (ip->fields & UIMM)
+		op |= build_uimm(va_arg(ap, u32));
+	if (ip->fields & BIMM)
+		op |= build_bimm(va_arg(ap, s32));
+	if (ip->fields & JIMM)
+		op |= build_jimm(va_arg(ap, u32));
+	if (ip->fields & FUNC)
+		op |= build_func(va_arg(ap, u32));
+	if (ip->fields & SET)
+		op |= build_set(va_arg(ap, u32));
+	if (ip->fields & SCIMM)
+		op |= build_scimm(va_arg(ap, u32));
+	va_end(ap);
+
+	**buf = op;
+	(*buf)++;
+}
+
+static inline void __uasminit
+__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
+{
+	long laddr = (long)lab->addr;
+	long raddr = (long)rel->addr;
+
+	switch (rel->type) {
+	case R_MIPS_PC16:
+		*rel->addr |= build_bimm(laddr - (raddr + 4));
+		break;
+
+	default:
+		panic("Unsupported Micro-assembler relocation %d",
+		      rel->type);
+	}
+}
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f6ba16e..51728b7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
  * Copyright (C) 2005, 2007  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -38,9 +39,18 @@ enum fields {
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
@@ -53,8 +63,6 @@ enum fields {
 #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
-#define SCIMM_MASK	0xfffff
-#define SCIMM_SH	6
 
 enum opcode {
 	insn_invalid,
@@ -78,216 +86,83 @@ struct insn {
 	enum fields fields;
 };
 
-/* This macro sets the non-variable bits of an instruction. */
-#define M(a, b, c, d, e, f)					\
-	((a) << OP_SH						\
-	 | (b) << RS_SH						\
-	 | (c) << RT_SH						\
-	 | (d) << RD_SH						\
-	 | (e) << RE_SH						\
-	 | (f) << FUNC_SH)
-
-static struct insn insn_table[] __uasminitdata = {
-	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
-	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
-	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
-	{ insn_beq, M(beq_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_beql, M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bgez, M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM },
-	{ insn_bgezl, M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
-	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
-	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
-	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
-	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
-	{ insn_dsll, M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE },
-	{ insn_dsll32, M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE },
-	{ insn_dsra, M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE },
-	{ insn_dsrl, M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_dsrl32, M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_drotr, M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE },
-	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
-	{ insn_dsubu, M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD },
-	{ insn_eret,  M(cop0_op, cop_op, 0, 0, 0, eret_op),  0 },
-	{ insn_ext, M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE },
-	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
-	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),  JIMM },
-	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
-	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),  RT | SIMM },
-	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
-	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
-	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
-	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
-	{ insn_sra,  M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE },
-	{ insn_srl,  M(spec_op, 0, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
-	{ insn_subu,  M(spec_op, 0, 0, 0, 0, subu_op),  RS | RT | RD },
-	{ insn_sw,  M(sw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
-	{ insn_tlbp,  M(cop0_op, cop_op, 0, 0, 0, tlbp_op),  0 },
-	{ insn_tlbr,  M(cop0_op, cop_op, 0, 0, 0, tlbr_op),  0 },
-	{ insn_tlbwi,  M(cop0_op, cop_op, 0, 0, 0, tlbwi_op),  0 },
-	{ insn_tlbwr,  M(cop0_op, cop_op, 0, 0, 0, tlbwr_op),  0 },
-	{ insn_xor,  M(spec_op, 0, 0, 0, 0, xor_op),  RS | RT | RD },
-	{ insn_xori,  M(xori_op, 0, 0, 0, 0, 0),  RS | RT | UIMM },
-	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
-	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
-	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
-	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
-	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
-	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
-	{ insn_invalid, 0, 0 }
-};
-
-#undef M
-
 static inline __uasminit u32 build_rs(u32 arg)
 {
-	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+	if (arg & ~RS_MASK)
+		printk(KERN_WARNING "Micro-assembler RS field overflow\n");
 
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
 
-static inline __uasminit u32 build_bimm(s32 arg)
-{
-	WARN(arg > 0x1ffff || arg < -0x20000,
-	     KERN_WARNING "Micro-assembler field overflow\n");
-
-	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
-
-	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
-}
-
-static inline __uasminit u32 build_jimm(u32 arg)
-{
-	WARN(arg & ~(JIMM_MASK << 2),
-	     KERN_WARNING "Micro-assembler field overflow\n");
-
-	return (arg >> 2) & JIMM_MASK;
-}
-
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
 
-/*
- * The order of opcode arguments is implicitly left to right,
- * starting with RS and ending with FUNC or IMM.
- */
-static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
-{
-	struct insn *ip = NULL;
-	unsigned int i;
-	va_list ap;
-	u32 op;
-
-	for (i = 0; insn_table[i].opcode != insn_invalid; i++)
-		if (insn_table[i].opcode == opc) {
-			ip = &insn_table[i];
-			break;
-		}
-
-	if (!ip || (opc == insn_daddiu && r4k_daddiu_bug()))
-		panic("Unsupported Micro-assembler instruction %d", opc);
-
-	op = ip->match;
-	va_start(ap, opc);
-	if (ip->fields & RS)
-		op |= build_rs(va_arg(ap, u32));
-	if (ip->fields & RT)
-		op |= build_rt(va_arg(ap, u32));
-	if (ip->fields & RD)
-		op |= build_rd(va_arg(ap, u32));
-	if (ip->fields & RE)
-		op |= build_re(va_arg(ap, u32));
-	if (ip->fields & SIMM)
-		op |= build_simm(va_arg(ap, s32));
-	if (ip->fields & UIMM)
-		op |= build_uimm(va_arg(ap, u32));
-	if (ip->fields & BIMM)
-		op |= build_bimm(va_arg(ap, s32));
-	if (ip->fields & JIMM)
-		op |= build_jimm(va_arg(ap, u32));
-	if (ip->fields & FUNC)
-		op |= build_func(va_arg(ap, u32));
-	if (ip->fields & SET)
-		op |= build_set(va_arg(ap, u32));
-	if (ip->fields & SCIMM)
-		op |= build_scimm(va_arg(ap, u32));
-	va_end(ap);
-
-	**buf = op;
-	(*buf)++;
-}
+#ifdef CONFIG_CPU_MICROMIPS
+#include "uasm-micromips.c"
+#else
+#include "uasm-mips.c"
+#endif
 
 #define I_u1u2u3(op)					\
 Ip_u1u2u3(op)						\
@@ -552,23 +427,6 @@ uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid)
 }
 UASM_EXPORT_SYMBOL(uasm_r_mips_pc16);
 
-static inline void __uasminit
-__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
-{
-	long laddr = (long)lab->addr;
-	long raddr = (long)rel->addr;
-
-	switch (rel->type) {
-	case R_MIPS_PC16:
-		*rel->addr |= build_bimm(laddr - (raddr + 4));
-		break;
-
-	default:
-		panic("Unsupported Micro-assembler relocation %d",
-		      rel->type);
-	}
-}
-
 void __uasminit
 uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 {
-- 
1.7.11.1
