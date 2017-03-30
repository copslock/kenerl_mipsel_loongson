Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 23:52:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12584 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992881AbdC3VwkD4Y9H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 23:52:40 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9496A9501E02C;
        Thu, 30 Mar 2017 22:52:28 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 22:52:32
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: uasm: Remove needless ISA abstraction
Date:   Thu, 30 Mar 2017 14:52:15 -0700
Message-ID: <20170330215216.6872-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

We always either target MIPS32/MIPS64 or microMIPS, and always include
one & only one of uasm-mips.c or uasm-micromips.c. Therefore the
abstraction of the ISA in asm/uasm.h declaring functions for either ISA
is redundant & needless. Remove it to simplify the code.

This is largely the result of the following:

  :%s/ISAOPC(\(.\{-}\))/uasm_i##\1/
  :%s/ISAFUNC(\(.\{-}\))/\1/

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/include/asm/uasm.h |  87 ++++++++----------------
 arch/mips/mm/uasm.c          | 156 +++++++++++++++++++++----------------------
 2 files changed, 106 insertions(+), 137 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index e9a9e2ade1d2..c68ef7a95b10 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -21,77 +21,46 @@
 #define UASM_EXPORT_SYMBOL(sym)
 #endif
 
-#define _UASM_ISA_CLASSIC	0
-#define _UASM_ISA_MICROMIPS	1
-
-#ifndef UASM_ISA
-#ifdef CONFIG_CPU_MICROMIPS
-#define UASM_ISA	_UASM_ISA_MICROMIPS
-#else
-#define UASM_ISA	_UASM_ISA_CLASSIC
-#endif
-#endif
-
-#if (UASM_ISA == _UASM_ISA_CLASSIC)
-#ifdef CONFIG_CPU_MICROMIPS
-#define ISAOPC(op)	CL_uasm_i##op
-#define ISAFUNC(x)	CL_##x
-#else
-#define ISAOPC(op)	uasm_i##op
-#define ISAFUNC(x)	x
-#endif
-#elif (UASM_ISA == _UASM_ISA_MICROMIPS)
-#ifdef CONFIG_CPU_MICROMIPS
-#define ISAOPC(op)	uasm_i##op
-#define ISAFUNC(x)	x
-#else
-#define ISAOPC(op)	MM_uasm_i##op
-#define ISAFUNC(x)	MM_##x
-#endif
-#else
-#error Unsupported micro-assembler ISA!!!
-#endif
-
 #define Ip_u1u2u3(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u2u1u3(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u3u2u1(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u3u1u2(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
 #define Ip_u1u2s3(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2s3u1(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
+void uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
 
 #define Ip_s3s1s2(op)							\
-void ISAOPC(op)(u32 **buf, int a, int b, int c)
+void uasm_i##op(u32 **buf, int a, int b, int c)
 
 #define Ip_u2u1s3(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
 #define Ip_u2u1msbu3(op)						\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c, \
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c, \
 	   unsigned int d)
 
 #define Ip_u1u2(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
 
 #define Ip_u2u1(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
+void uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
 
 #define Ip_u1s2(op)							\
-void ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
+void uasm_i##op(u32 **buf, unsigned int a, signed int b)
 
-#define Ip_u1(op) void ISAOPC(op)(u32 **buf, unsigned int a)
+#define Ip_u1(op) void uasm_i##op(u32 **buf, unsigned int a)
 
-#define Ip_0(op) void ISAOPC(op)(u32 **buf)
+#define Ip_0(op) void uasm_i##op(u32 **buf)
 
 Ip_u2u1s3(_addiu);
 Ip_u3u1u2(_addu);
@@ -190,20 +159,20 @@ struct uasm_label {
 	int lab;
 };
 
-void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
+void uasm_build_label(struct uasm_label **lab, u32 *addr,
 			int lid);
 #ifdef CONFIG_64BIT
-int ISAFUNC(uasm_in_compat_space_p)(long addr);
+int uasm_in_compat_space_p(long addr);
 #endif
-int ISAFUNC(uasm_rel_hi)(long val);
-int ISAFUNC(uasm_rel_lo)(long val);
-void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr);
-void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr);
+int uasm_rel_hi(long val);
+int uasm_rel_lo(long val);
+void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
+void UASM_i_LA(u32 **buf, unsigned int rs, long addr);
 
 #define UASM_L_LA(lb)							\
-static inline void ISAFUNC(uasm_l##lb)(struct uasm_label **lab, u32 *addr) \
+static inline void uasm_l##lb(struct uasm_label **lab, u32 *addr)	\
 {									\
-	ISAFUNC(uasm_build_label)(lab, addr, label##lb);		\
+	uasm_build_label(lab, addr, label##lb);				\
 }
 
 /* convenience macros for instructions */
@@ -255,27 +224,27 @@ static inline void uasm_i_drotr_safe(u32 **p, unsigned int a1,
 				     unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		ISAOPC(_drotr)(p, a1, a2, a3);
+		uasm_i_drotr(p, a1, a2, a3);
 	else
-		ISAOPC(_drotr32)(p, a1, a2, a3 - 32);
+		uasm_i_drotr32(p, a1, a2, a3 - 32);
 }
 
 static inline void uasm_i_dsll_safe(u32 **p, unsigned int a1,
 				    unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		ISAOPC(_dsll)(p, a1, a2, a3);
+		uasm_i_dsll(p, a1, a2, a3);
 	else
-		ISAOPC(_dsll32)(p, a1, a2, a3 - 32);
+		uasm_i_dsll32(p, a1, a2, a3 - 32);
 }
 
 static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
 				    unsigned int a2, unsigned int a3)
 {
 	if (a3 < 32)
-		ISAOPC(_dsrl)(p, a1, a2, a3);
+		uasm_i_dsrl(p, a1, a2, a3);
 	else
-		ISAOPC(_dsrl32)(p, a1, a2, a3 - 32);
+		uasm_i_dsrl32(p, a1, a2, a3 - 32);
 }
 
 /* Handle relocations. */
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index a82970442b8a..d1b89ae73d39 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -349,7 +349,7 @@ I_u2u1u3(_lddir)
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #include <asm/octeon/octeon.h>
-void ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
+void uasm_i_pref(u32 **buf, unsigned int a, signed int b,
 			    unsigned int c)
 {
 	if (CAVIUM_OCTEON_DCACHE_PREFETCH_WAR && a <= 24 && a != 5)
@@ -361,26 +361,26 @@ void ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
 	else
 		build_insn(buf, insn_pref, c, a, b);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_i_pref));
+UASM_EXPORT_SYMBOL(uasm_i_pref);
 #else
 I_u2s3u1(_pref)
 #endif
 
 /* Handle labels. */
-void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
+void uasm_build_label(struct uasm_label **lab, u32 *addr, int lid)
 {
 	(*lab)->addr = addr;
 	(*lab)->lab = lid;
 	(*lab)++;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_build_label));
+UASM_EXPORT_SYMBOL(uasm_build_label);
 
-int ISAFUNC(uasm_in_compat_space_p)(long addr)
+int uasm_in_compat_space_p(long addr)
 {
 	/* Is this address in 32bit compat space? */
 	return addr == (int)addr;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_in_compat_space_p));
+UASM_EXPORT_SYMBOL(uasm_in_compat_space_p);
 
 static int uasm_rel_highest(long val)
 {
@@ -400,64 +400,64 @@ static int uasm_rel_higher(long val)
 #endif
 }
 
-int ISAFUNC(uasm_rel_hi)(long val)
+int uasm_rel_hi(long val)
 {
 	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_hi));
+UASM_EXPORT_SYMBOL(uasm_rel_hi);
 
-int ISAFUNC(uasm_rel_lo)(long val)
+int uasm_rel_lo(long val)
 {
 	return ((val & 0xffff) ^ 0x8000) - 0x8000;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_lo));
+UASM_EXPORT_SYMBOL(uasm_rel_lo);
 
-void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
+void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 {
-	if (!ISAFUNC(uasm_in_compat_space_p)(addr)) {
-		ISAFUNC(uasm_i_lui)(buf, rs, uasm_rel_highest(addr));
+	if (!uasm_in_compat_space_p(addr)) {
+		uasm_i_lui(buf, rs, uasm_rel_highest(addr));
 		if (uasm_rel_higher(addr))
-			ISAFUNC(uasm_i_daddiu)(buf, rs, rs, uasm_rel_higher(addr));
-		if (ISAFUNC(uasm_rel_hi(addr))) {
-			ISAFUNC(uasm_i_dsll)(buf, rs, rs, 16);
-			ISAFUNC(uasm_i_daddiu)(buf, rs, rs,
-					ISAFUNC(uasm_rel_hi)(addr));
-			ISAFUNC(uasm_i_dsll)(buf, rs, rs, 16);
+			uasm_i_daddiu(buf, rs, rs, uasm_rel_higher(addr));
+		if (uasm_rel_hi(addr)) {
+			uasm_i_dsll(buf, rs, rs, 16);
+			uasm_i_daddiu(buf, rs, rs,
+					uasm_rel_hi(addr));
+			uasm_i_dsll(buf, rs, rs, 16);
 		} else
-			ISAFUNC(uasm_i_dsll32)(buf, rs, rs, 0);
+			uasm_i_dsll32(buf, rs, rs, 0);
 	} else
-		ISAFUNC(uasm_i_lui)(buf, rs, ISAFUNC(uasm_rel_hi(addr)));
+		uasm_i_lui(buf, rs, uasm_rel_hi(addr));
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA_mostly));
+UASM_EXPORT_SYMBOL(UASM_i_LA_mostly);
 
-void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
+void UASM_i_LA(u32 **buf, unsigned int rs, long addr)
 {
-	ISAFUNC(UASM_i_LA_mostly)(buf, rs, addr);
-	if (ISAFUNC(uasm_rel_lo(addr))) {
-		if (!ISAFUNC(uasm_in_compat_space_p)(addr))
-			ISAFUNC(uasm_i_daddiu)(buf, rs, rs,
-					ISAFUNC(uasm_rel_lo(addr)));
+	UASM_i_LA_mostly(buf, rs, addr);
+	if (uasm_rel_lo(addr)) {
+		if (!uasm_in_compat_space_p(addr))
+			uasm_i_daddiu(buf, rs, rs,
+					uasm_rel_lo(addr));
 		else
-			ISAFUNC(uasm_i_addiu)(buf, rs, rs,
-					ISAFUNC(uasm_rel_lo(addr)));
+			uasm_i_addiu(buf, rs, rs,
+					uasm_rel_lo(addr));
 	}
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA));
+UASM_EXPORT_SYMBOL(UASM_i_LA);
 
 /* Handle relocations. */
-void ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
+void uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid)
 {
 	(*rel)->addr = addr;
 	(*rel)->type = R_MIPS_PC16;
 	(*rel)->lab = lid;
 	(*rel)++;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_r_mips_pc16));
+UASM_EXPORT_SYMBOL(uasm_r_mips_pc16);
 
 static inline void __resolve_relocs(struct uasm_reloc *rel,
 				    struct uasm_label *lab);
 
-void ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel,
+void uasm_resolve_relocs(struct uasm_reloc *rel,
 				  struct uasm_label *lab)
 {
 	struct uasm_label *l;
@@ -467,39 +467,39 @@ void ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel,
 			if (rel->lab == l->lab)
 				__resolve_relocs(rel, l);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_resolve_relocs));
+UASM_EXPORT_SYMBOL(uasm_resolve_relocs);
 
-void ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end,
+void uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end,
 			       long off)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++)
 		if (rel->addr >= first && rel->addr < end)
 			rel->addr += off;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_relocs));
+UASM_EXPORT_SYMBOL(uasm_move_relocs);
 
-void ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end,
+void uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end,
 			       long off)
 {
 	for (; lab->lab != UASM_LABEL_INVALID; lab++)
 		if (lab->addr >= first && lab->addr < end)
 			lab->addr += off;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_labels));
+UASM_EXPORT_SYMBOL(uasm_move_labels);
 
-void ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab,
+void uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab,
 				u32 *first, u32 *end, u32 *target)
 {
 	long off = (long)(target - first);
 
 	memcpy(target, first, (end - first) * sizeof(u32));
 
-	ISAFUNC(uasm_move_relocs(rel, first, end, off));
-	ISAFUNC(uasm_move_labels(lab, first, end, off));
+	uasm_move_relocs(rel, first, end, off);
+	uasm_move_labels(lab, first, end, off);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_copy_handler));
+UASM_EXPORT_SYMBOL(uasm_copy_handler);
 
-int ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
+int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr)
 {
 	for (; rel->lab != UASM_LABEL_INVALID; rel++) {
 		if (rel->addr == addr
@@ -510,92 +510,92 @@ int ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
 
 	return 0;
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_insn_has_bdelay));
+UASM_EXPORT_SYMBOL(uasm_insn_has_bdelay);
 
 /* Convenience functions for labeled branches. */
-void ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bltz)(p, reg, 0);
+	uasm_i_bltz(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bltz));
+UASM_EXPORT_SYMBOL(uasm_il_bltz);
 
-void ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
+void uasm_il_b(u32 **p, struct uasm_reloc **r, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_b)(p, 0);
+	uasm_i_b(p, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_b));
+UASM_EXPORT_SYMBOL(uasm_il_b);
 
-void ISAFUNC(uasm_il_beq)(u32 **p, struct uasm_reloc **r, unsigned int r1,
+void uasm_il_beq(u32 **p, struct uasm_reloc **r, unsigned int r1,
 			  unsigned int r2, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_beq)(p, r1, r2, 0);
+	uasm_i_beq(p, r1, r2, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beq));
+UASM_EXPORT_SYMBOL(uasm_il_beq);
 
-void ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_beqz)(p, reg, 0);
+	uasm_i_beqz(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqz));
+UASM_EXPORT_SYMBOL(uasm_il_beqz);
 
-void ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			    int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_beqzl)(p, reg, 0);
+	uasm_i_beqzl(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqzl));
+UASM_EXPORT_SYMBOL(uasm_il_beqzl);
 
-void ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
 			  unsigned int reg2, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bne)(p, reg1, reg2, 0);
+	uasm_i_bne(p, reg1, reg2, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bne));
+UASM_EXPORT_SYMBOL(uasm_il_bne);
 
-void ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bnez)(p, reg, 0);
+	uasm_i_bnez(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bnez));
+UASM_EXPORT_SYMBOL(uasm_il_bnez);
 
-void ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			    int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bgezl)(p, reg, 0);
+	uasm_i_bgezl(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgezl));
+UASM_EXPORT_SYMBOL(uasm_il_bgezl);
 
-void ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			   int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bgez)(p, reg, 0);
+	uasm_i_bgez(p, reg, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgez));
+UASM_EXPORT_SYMBOL(uasm_il_bgez);
 
-void ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bbit0(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			    unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bbit0)(p, reg, bit, 0);
+	uasm_i_bbit0(p, reg, bit, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit0));
+UASM_EXPORT_SYMBOL(uasm_il_bbit0);
 
-void ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
+void uasm_il_bbit1(u32 **p, struct uasm_reloc **r, unsigned int reg,
 			    unsigned int bit, int lid)
 {
 	uasm_r_mips_pc16(r, *p, lid);
-	ISAFUNC(uasm_i_bbit1)(p, reg, bit, 0);
+	uasm_i_bbit1(p, reg, bit, 0);
 }
-UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit1));
+UASM_EXPORT_SYMBOL(uasm_il_bbit1);
-- 
2.12.1
