Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jan 2013 03:50:44 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:37565 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824767Ab3A3CunSWpIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jan 2013 03:50:43 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1U0Nkv-00049B-Pv; Tue, 29 Jan 2013 20:50:33 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        cernekee@gmail.com, ddaney.cavm@gmail.com
Subject: [PATCH][RFC] MIPS: microMIPS: Add support to micro-assembler.
Date:   Tue, 29 Jan 2013 20:50:27 -0600
Message-Id: <1359514228-2161-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35621
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

This adds microMIPS instruction support to the micro-assembler.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/uasm.c |  121 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 43 deletions(-)

diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 942ff6c..13f0ca7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2004, 2005, 2006, 2008	 Thiemo Seufer
  * Copyright (C) 2005, 2007  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -35,27 +36,6 @@ enum fields {
 	SCIMM = 0x400
 };
 
-#define OP_MASK		0x3f
-#define OP_SH		26
-#define RS_MASK		0x1f
-#define RS_SH		21
-#define RT_MASK		0x1f
-#define RT_SH		16
-#define RD_MASK		0x1f
-#define RD_SH		11
-#define RE_MASK		0x1f
-#define RE_SH		6
-#define IMM_MASK	0xffff
-#define IMM_SH		0
-#define JIMM_MASK	0x3ffffff
-#define JIMM_SH		0
-#define FUNC_MASK	0x3f
-#define FUNC_SH		0
-#define SET_MASK	0x7
-#define SET_SH		0
-#define SCIMM_MASK	0xfffff
-#define SCIMM_SH	6
-
 enum opcode {
 	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
@@ -77,14 +57,17 @@ struct insn {
 	enum fields fields;
 };
 
+/* Register length mask. */
+#define RX_MASK		0x1f
+
 /* This macro sets the non-variable bits of an instruction. */
 #define M(a, b, c, d, e, f)					\
-	((a) << OP_SH						\
-	 | (b) << RS_SH						\
-	 | (c) << RT_SH						\
-	 | (d) << RD_SH						\
-	 | (e) << RE_SH						\
-	 | (f) << FUNC_SH)
+	((a) << 26						\
+	 | (b) << 21						\
+	 | (c) << 16						\
+	 | (d) << 11						\
+	 | (e) << 6						\
+	 | (f) << 0)
 
 static struct insn insn_table[] __uasminitdata = {
 	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
@@ -158,30 +141,46 @@ static struct insn insn_table[] __uasminitdata = {
 
 static inline __uasminit u32 build_rs(u32 arg)
 {
-	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+#ifdef CONFIG_CPU_MICROMIPS
+#define RS_SH		16
+#else
+#define RS_SH		21
+#endif
 
-	return (arg & RS_MASK) << RS_SH;
+	WARN(arg & ~RX_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RX_MASK) << RS_SH;
 }
 
 static inline __uasminit u32 build_rt(u32 arg)
 {
-	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+#ifdef CONFIG_CPU_MICROMIPS
+#define RT_SH		21
+#else
+#define RT_SH		16
+#endif
+
+	WARN(arg & ~RX_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
-	return (arg & RT_MASK) << RT_SH;
+	return (arg & RX_MASK) << RT_SH;
 }
 
 static inline __uasminit u32 build_rd(u32 arg)
 {
-	WARN(arg & ~RD_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+#define RD_SH		11
 
-	return (arg & RD_MASK) << RD_SH;
+	WARN(arg & ~RX_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RX_MASK) << RD_SH;
 }
 
 static inline __uasminit u32 build_re(u32 arg)
 {
-	WARN(arg & ~RE_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+#define RE_SH		6
 
-	return (arg & RE_MASK) << RE_SH;
+	WARN(arg & ~RX_MASK, KERN_WARNING "Micro-assembler field overflow\n");
+
+	return (arg & RX_MASK) << RE_SH;
 }
 
 static inline __uasminit u32 build_simm(s32 arg)
@@ -194,6 +193,8 @@ static inline __uasminit u32 build_simm(s32 arg)
 
 static inline __uasminit u32 build_uimm(u32 arg)
 {
+#define IMM_MASK	0xffff
+
 	WARN(arg & ~IMM_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & IMM_MASK;
@@ -201,32 +202,54 @@ static inline __uasminit u32 build_uimm(u32 arg)
 
 static inline __uasminit u32 build_bimm(s32 arg)
 {
-	WARN(arg > 0x1ffff || arg < -0x20000,
+#ifdef CONFIG_CPU_MICROMIPS
+#define BIMM_SHIFT	1
+#else
+#define BIMM_SHIFT	2
+#endif
+
+	WARN(arg > (0x1ffff >> (2 - BIMM_SHIFT)) ||
+	     arg < (-0x20000 >> (2 - BIMM_SHIFT)),
 	     KERN_WARNING "Micro-assembler field overflow\n");
 
 	WARN(arg & 0x3, KERN_WARNING "Invalid micro-assembler branch target\n");
 
-	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
+	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> BIMM_SHIFT) & 0x7fff);
 }
 
 static inline __uasminit u32 build_jimm(u32 arg)
 {
-	WARN(arg & ~(JIMM_MASK << 2),
+#define JIMM_MASK	0x3ffffff
+#ifdef CONFIG_CPU_MICROMIPS
+	arg >>= 1;
+#else
+	arg >>= 2;
+#endif
+
+	WARN(arg & ~JIMM_MASK,
 	     KERN_WARNING "Micro-assembler field overflow\n");
 
-	return (arg >> 2) & JIMM_MASK;
+	return (arg & JIMM_MASK);
 }
 
 static inline __uasminit u32 build_scimm(u32 arg)
 {
-	WARN(arg & ~SCIMM_MASK,
+#ifdef CONFIG_CPU_MICROMIPS
+#define SCIMM_SH	6
+#else
+#define SCIMM_SH	0
+#endif
+
+	WARN(arg & ~(0xfffff >> SCIMM_SH),
 	     KERN_WARNING "Micro-assembler field overflow\n");
 
-	return (arg & SCIMM_MASK) << SCIMM_SH;
+	return (arg & ((0xfffff >> SCIMM_SH) << (SCIMM_SH + 10)));
 }
 
 static inline __uasminit u32 build_func(u32 arg)
 {
+#define FUNC_MASK	0x3f
+
 	WARN(arg & ~FUNC_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & FUNC_MASK;
@@ -234,6 +257,8 @@ static inline __uasminit u32 build_func(u32 arg)
 
 static inline __uasminit u32 build_set(u32 arg)
 {
+#define SET_MASK	0x7
+
 	WARN(arg & ~SET_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & SET_MASK;
@@ -245,6 +270,11 @@ static inline __uasminit u32 build_set(u32 arg)
  */
 static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 {
+#if defined(CONFIG_CPU_MICROMIPS) && defined(CONFIG_CPU_LITTLE_ENDIAN)
+#define OP_SHIFT	16
+#else
+#define OP_SHIFT	0
+#endif
 	struct insn *ip = NULL;
 	unsigned int i;
 	va_list ap;
@@ -285,7 +315,7 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 		op |= build_scimm(va_arg(ap, u32));
 	va_end(ap);
 
-	**buf = op;
+	**buf = ((op & 0xffff) << OP_SHIFT) | (op >> OP_SHIFT);
 	(*buf)++;
 }
 
@@ -555,12 +585,17 @@ UASM_EXPORT_SYMBOL(uasm_r_mips_pc16);
 static inline void __uasminit
 __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 {
+#if defined(CONFIG_CPU_MICROMIPS) && defined(CONFIG_CPU_LITTLE_ENDIAN)
+#define REL_SHIFT	16
+#else
+#define REL_SHIFT	0
+#endif
 	long laddr = (long)lab->addr;
 	long raddr = (long)rel->addr;
 
 	switch (rel->type) {
 	case R_MIPS_PC16:
-		*rel->addr |= build_bimm(laddr - (raddr + 4));
+		*rel->addr |= (build_bimm(laddr - (raddr + 4)) << REL_SHIFT);
 		break;
 
 	default:
-- 
1.7.9.5
