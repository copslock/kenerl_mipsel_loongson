Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 21:13:35 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:49010 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835853Ab3FQTN0lURa0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 21:13:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5HJDJFF022071
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 17 Jun 2013 12:13:19 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.2.342.3; Mon, 17 Jun 2013 12:13:18 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/2] mips: delete __cpuinit usage from uasm code
Date:   Mon, 17 Jun 2013 15:13:09 -0400
Message-ID: <1371496390-16088-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

The __cpuinit type of throwaway sections might have made sense
some time ago when RAM was more constrained, but now the savings
do not offset the cost and complications.  For example, the fix in
commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
is a good example of the nasty type of bugs that can be created
with improper use of the various __init prefixes.

After a discussion on LKML[1] it was decided that cpuinit should go
the way of devinit and be phased out.  Once all the users are gone,
we can then finally remove the macros themselves from linux/init.h.

Here, we start with removing all the MIPS uasm users that are
hiding behind their own versions of the __cpuinit macros.

[1] https://lkml.org/lkml/2013/5/20/589

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/include/asm/uasm.h  |  37 ++++++---------
 arch/mips/mm/uasm-micromips.c |  10 ++--
 arch/mips/mm/uasm-mips.c      |  10 ++--
 arch/mips/mm/uasm.c           | 106 ++++++++++++++++++++----------------------
 4 files changed, 73 insertions(+), 90 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 370d967..c33a956 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -13,12 +13,8 @@
 
 #ifdef CONFIG_EXPORT_UASM
 #include <linux/export.h>
-#define __uasminit
-#define __uasminitdata
 #define UASM_EXPORT_SYMBOL(sym) EXPORT_SYMBOL(sym)
 #else
-#define __uasminit __cpuinit
-#define __uasminitdata __cpuinitdata
 #define UASM_EXPORT_SYMBOL(sym)
 #endif
 
@@ -54,43 +50,36 @@
 #endif
 
 #define Ip_u1u2u3(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u2u1u3(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u3u1u2(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u1u2s3(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2s3u1(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
 
 #define Ip_u2u1s3(op)							\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2u1msbu3(op)						\
-void __uasminit								\
-ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c, \
 	   unsigned int d)
 
 #define Ip_u1u2(op)							\
-void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
 
 #define Ip_u1s2(op)							\
-void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
+void ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
 
-#define Ip_u1(op) void __uasminit ISAOPC(op)(u32 **buf, unsigned int a)
+#define Ip_u1(op) void ISAOPC(op)(u32 **buf, unsigned int a)
 
-#define Ip_0(op) void __uasminit ISAOPC(op)(u32 **buf)
+#define Ip_0(op) void ISAOPC(op)(u32 **buf)
 
 Ip_u2u1s3(_addiu);
 Ip_u3u1u2(_addu);
@@ -163,7 +152,7 @@ struct uasm_label {
 	int lab;
 };
 
-void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
+void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
 			int lid);
 #ifdef CONFIG_64BIT
 int ISAFUNC(uasm_in_compat_space_p)(long addr);
@@ -174,7 +163,7 @@ void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr);
 void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr);
 
 #define UASM_L_LA(lb)							\
-static inline void __uasminit ISAFUNC(uasm_l##lb)(struct uasm_label **lab, u32 *addr) \
+static inline void ISAFUNC(uasm_l##lb)(struct uasm_label **lab, u32 *addr) \
 {									\
 	ISAFUNC(uasm_build_label)(lab, addr, label##lb);		\
 }
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 162ee6d..060000f 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -49,7 +49,7 @@
 
 #include "uasm.c"
 
-static struct insn insn_table_MM[] __uasminitdata = {
+static struct insn insn_table_MM[] = {
 	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
 	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
 	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
@@ -118,7 +118,7 @@ static struct insn insn_table_MM[] __uasminitdata = {
 
 #undef M
 
-static inline __uasminit u32 build_bimm(s32 arg)
+static inline u32 build_bimm(s32 arg)
 {
 	WARN(arg > 0xffff || arg < -0x10000,
 	     KERN_WARNING "Micro-assembler field overflow\n");
@@ -128,7 +128,7 @@ static inline __uasminit u32 build_bimm(s32 arg)
 	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 1) & 0x7fff);
 }
 
-static inline __uasminit u32 build_jimm(u32 arg)
+static inline u32 build_jimm(u32 arg)
 {
 
 	WARN(arg & ~((JIMM_MASK << 2) | 1),
@@ -141,7 +141,7 @@ static inline __uasminit u32 build_jimm(u32 arg)
  * The order of opcode arguments is implicitly left to right,
  * starting with RS and ending with FUNC or IMM.
  */
-static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
+static void build_insn(u32 **buf, enum opcode opc, ...)
 {
 	struct insn *ip = NULL;
 	unsigned int i;
@@ -199,7 +199,7 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 	(*buf)++;
 }
 
-static inline void __uasminit
+static inline void
 __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 {
 	long laddr = (long)lab->addr;
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 5fcdd8f..0c72458 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -49,7 +49,7 @@
 
 #include "uasm.c"
 
-static struct insn insn_table[] __uasminitdata = {
+static struct insn insn_table[] = {
 	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
 	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
@@ -119,7 +119,7 @@ static struct insn insn_table[] __uasminitdata = {
 
 #undef M
 
-static inline __uasminit u32 build_bimm(s32 arg)
+static inline u32 build_bimm(s32 arg)
 {
 	WARN(arg > 0x1ffff || arg < -0x20000,
 	     KERN_WARNING "Micro-assembler field overflow\n");
@@ -129,7 +129,7 @@ static inline __uasminit u32 build_bimm(s32 arg)
 	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
 }
 
-static inline __uasminit u32 build_jimm(u32 arg)
+static inline u32 build_jimm(u32 arg)
 {
 	WARN(arg & ~(JIMM_MASK << 2),
 	     KERN_WARNING "Micro-assembler field overflow\n");
@@ -141,7 +141,7 @@ static inline __uasminit u32 build_jimm(u32 arg)
  * The order of opcode arguments is implicitly left to right,
  * starting with RS and ending with FUNC or IMM.
  */
-static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
+static void build_insn(u32 **buf, enum opcode opc, ...)
 {
 	struct insn *ip = NULL;
 	unsigned int i;
@@ -187,7 +187,7 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
 	(*buf)++;
 }
 
-static inline void __uasminit
+static inline void
 __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
 {
 	long laddr = (long)lab->addr;
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 7eb5e43..b9d14b6 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -63,35 +63,35 @@ struct insn {
 	enum fields fields;
 };
 
-static inline __uasminit u32 build_rs(u32 arg)
+static inline u32 build_rs(u32 arg)
 {
 	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RS_MASK) << RS_SH;
 }
 
-static inline __uasminit u32 build_rt(u32 arg)
+static inline u32 build_rt(u32 arg)
 {
 	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RT_MASK) << RT_SH;
 }
 
-static inline __uasminit u32 build_rd(u32 arg)
+static inline u32 build_rd(u32 arg)
 {
 	WARN(arg & ~RD_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RD_MASK) << RD_SH;
 }
 
-static inline __uasminit u32 build_re(u32 arg)
+static inline u32 build_re(u32 arg)
 {
 	WARN(arg & ~RE_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return (arg & RE_MASK) << RE_SH;
 }
 
-static inline __uasminit u32 build_simm(s32 arg)
+static inline u32 build_simm(s32 arg)
 {
 	WARN(arg > 0x7fff || arg < -0x8000,
 	     KERN_WARNING "Micro-assembler field overflow\n");
@@ -99,14 +99,14 @@ static inline __uasminit u32 build_simm(s32 arg)
 	return arg & 0xffff;
 }
 
-static inline __uasminit u32 build_uimm(u32 arg)
+static inline u32 build_uimm(u32 arg)
 {
 	WARN(arg & ~IMM_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & IMM_MASK;
 }
 
-static inline __uasminit u32 build_scimm(u32 arg)
+static inline u32 build_scimm(u32 arg)
 {
 	WARN(arg & ~SCIMM_MASK,
 	     KERN_WARNING "Micro-assembler field overflow\n");
@@ -114,21 +114,21 @@ static inline __uasminit u32 build_scimm(u32 arg)
 	return (arg & SCIMM_MASK) << SCIMM_SH;
 }
 
-static inline __uasminit u32 build_func(u32 arg)
+static inline u32 build_func(u32 arg)
 {
 	WARN(arg & ~FUNC_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & FUNC_MASK;
 }
 
-static inline __uasminit u32 build_set(u32 arg)
+static inline u32 build_set(u32 arg)
 {
 	WARN(arg & ~SET_MASK, KERN_WARNING "Micro-assembler field overflow\n");
 
 	return arg & SET_MASK;
 }
 
-static void __uasminit build_insn(u32 **buf, enum opcode opc, ...);
+static void build_insn(u32 **buf, enum opcode opc, ...);
 
 #define I_u1u2u3(op)					\
 Ip_u1u2u3(op)						\
@@ -286,7 +286,7 @@ I_u3u1u2(_ldx)
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #include <asm/octeon/octeon.h>
-void __uasminit ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
+void ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
 			    unsigned int c)
 {
 	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X) && a <= 24 && a != 5)
@@ -304,7 +304,7 @@ I_u2s3u1(_pref)
 #endif
 
 /* Handle labels. */
-void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
+void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
 {
 	(*lab)->addr = addr;
 	(*lab)->lab = lid;
@@ -312,7 +312,7 @@ void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, in
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_build_label));
 
-int __uasminit ISAFUNC(uasm_in_compat_space_p)(long addr)
+int ISAFUNC(uasm_in_compat_space_p)(long addr)
 {
 	/* Is this address in 32bit compat space? */
 #ifdef CONFIG_64BIT
@@ -323,7 +323,7 @@ int __uasminit ISAFUNC(uasm_in_compat_space_p)(long addr)
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_in_compat_space_p));
 
-static int __uasminit uasm_rel_highest(long val)
+static int uasm_rel_highest(long val)
 {
 #ifdef CONFIG_64BIT
 	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
@@ -332,7 +332,7 @@ static int __uasminit uasm_rel_highest(long val)
 #endif
 }
 
-static int __uasminit uasm_rel_higher(long val)
+static int uasm_rel_higher(long val)
 {
 #ifdef CONFIG_64BIT
 	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
@@ -341,19 +341,19 @@ static int __uasminit uasm_rel_higher(long val)
 #endif
 }
 
-int __uasminit ISAFUNC(uasm_rel_hi)(long val)
+int ISAFUNC(uasm_rel_hi)(long val)
 {
 	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_hi));
 
-int __uasminit ISAFUNC(uasm_rel_lo)(long val)
+int ISAFUNC(uasm_rel_lo)(long val)
 {
 	return ((val & 0xffff) ^ 0x8000) - 0x8000;
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_lo));
 
-void __uasminit ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
+void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
 {
 	if (!ISAFUNC(uasm_in_compat_space_p)(addr)) {
 		ISAFUNC(uasm_i_lui)(buf, rs, uasm_rel_highest(addr));
@@ -371,7 +371,7 @@ void __uasminit ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA_mostly));
 
-void __uasminit ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
+void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
 {
 	ISAFUNC(UASM_i_LA_mostly)(buf, rs, addr);
 	if (ISAFUNC(uasm_rel_lo(addr))) {
@@ -386,8 +386,7 @@ void __uasminit ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
 UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA));
 
 /* Handle relocations. */
-void __uasminit
-ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
+void ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
 {
 	(*rel)->addr = addr;
 	(*rel)->type = R_MIPS_PC16;
@@ -396,11 +395,11 @@ ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_r_mips_pc16));
 
-static inline void __uasminit
-__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
+static inline void __resolve_relocs(struct uasm_reloc *rel,
+				    struct uasm_label *lab);
 
-void __uasminit
-ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel, struct uasm_label *lab)
+void ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel,
+				  struct uasm_label *lab)
 {
 	struct uasm_label *l;
 
@@ -411,8 +410,8 @@ ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel, struct uasm_label *lab)
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_resolve_relocs));
 
-void __uasminit
-ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end, long off)
+void ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end,
+			       long off)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++)
 		if (rel->addr >= first && rel->addr < end)
@@ -420,8 +419,8 @@ ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end, long off
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_relocs));
 
-void __uasminit
-ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end, long off)
+void ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end,
+			       long off)
 {
 	for (; lab->lab != UASM_LABEL_INVALID; lab++)
 		if (lab->addr >= first && lab->addr < end)
@@ -429,9 +428,8 @@ ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end, long off
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_labels));
 
-void __uasminit
-ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
-		  u32 *end, u32 *target)
+void ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab,
+				u32 *first, u32 *end, u32 *target)
 {
 	long off = (long)(target - first);
 
@@ -442,7 +440,7 @@ ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab, u32 *
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_copy_handler));
 
-int __uasminit ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
+int ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++) {
 		if (rel->addr == addr
@@ -456,83 +454,79 @@ int __uasminit ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_insn_has_bdelay));
 
 /* Convenience functions for labeled branches. */
-void __uasminit
-ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bltz)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bltz));
 
-void __uasminit
-ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
+void ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_b)(p, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_b));
 
-void __uasminit
-ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_beqz)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqz));
 
-void __uasminit
-ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			    int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_beqzl)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqzl));
 
-void __uasminit
-ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
-	unsigned int reg2, int lid)
+void ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+			  unsigned int reg2, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bne)(p, reg1, reg2, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bne));
 
-void __uasminit
-ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bnez)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bnez));
 
-void __uasminit
-ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			    int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bgezl)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgezl));
 
-void __uasminit
-ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
+void ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bgez)(p, reg, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgez));
 
-void __uasminit
-ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
-	      unsigned int bit, int lid)
+void ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			    unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bbit0)(p, reg, bit, 0);
 }
 UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit0));
 
-void __uasminit
-ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
-	      unsigned int bit, int lid)
+void ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+			    unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
 	ISAFUNC(uasm_i_bbit1)(p, reg, bit, 0);
-- 
1.8.1.2
