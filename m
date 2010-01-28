Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 15:21:57 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:50440 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492053Ab0A1OVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 15:21:50 +0100
Received: by ewy23 with SMTP id 23so438141ewy.24
        for <multiple recipients>; Thu, 28 Jan 2010 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:organization:to:content-type
         :content-transfer-encoding:message-id;
        bh=X4mEAry+grFex5P15uZQeEC6bV9fQmLKuoCEq9d0Eg0=;
        b=JgX2OHTllnKDQUeXibgag6SXKVMO9ET6TGtqNr2z3r6gOsNegVBM5HBDErBGgMJWXL
         3oHmeXKs/rzT5WJ0759uveUTTiDs0tJ06PidimkAfRSUyA5IMuVs8nSISqDD5gi+DAXN
         TkUZ3XecC80bSHvmQyq7egr9P9q4e/6CYJhCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:organization
         :to:content-type:content-transfer-encoding:message-id;
        b=ja2CAeI/KTmzODZ6QyQHEDZrqkjYE9APhKd/ypQt2JqrFVJ4l4VdMcRyCORSDravVL
         8mOEjzClCkhgon+xJv006If7CaRdagvKGLFjvH2j8j/xS1iWEiALe4pbQr39lgmgLFB2
         PNpDUo3szVby5Acy3g5jRJefw2IWtNr7ht5Go=
Received: by 10.213.42.205 with SMTP id t13mr2118849ebe.4.1264688505187;
        Thu, 28 Jan 2010 06:21:45 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 16sm664417ewy.10.2010.01.28.06.21.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 06:21:44 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 28 Jan 2010 15:21:24 +0100
Subject: [PATCH 1/3] MIPS: move arch/mips/mm/uasm.h to arch/mips/include/asm/uasm.h
MIME-Version: 1.0
X-Length: 16365
Organization: OpenWrt
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001281521.24710.florian@openwrt.org>
X-archive-position: 25717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18234


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
new file mode 100644
index 0000000..3d153ed
--- /dev/null
+++ b/arch/mips/include/asm/uasm.h
@@ -0,0 +1,191 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
+ * Copyright (C) 2005  Maciej W. Rozycki
+ * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include <linux/types.h>
+
+#define Ip_u1u2u3(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u2u1u3(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u3u1u2(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
+#define Ip_u1u2s3(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+
+#define Ip_u2s3u1(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
+
+#define Ip_u2u1s3(op)							\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
+
+#define Ip_u2u1msbu3(op)						\
+void __cpuinit								\
+uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
+	   unsigned int d)
+
+#define Ip_u1u2(op)							\
+void __cpuinit uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
+
+#define Ip_u1s2(op)							\
+void __cpuinit uasm_i##op(u32 **buf, unsigned int a, signed int b)
+
+#define Ip_u1(op) void __cpuinit uasm_i##op(u32 **buf, unsigned int a)
+
+#define Ip_0(op) void __cpuinit uasm_i##op(u32 **buf)
+
+Ip_u2u1s3(_addiu);
+Ip_u3u1u2(_addu);
+Ip_u2u1u3(_andi);
+Ip_u3u1u2(_and);
+Ip_u1u2s3(_beq);
+Ip_u1u2s3(_beql);
+Ip_u1s2(_bgez);
+Ip_u1s2(_bgezl);
+Ip_u1s2(_bltz);
+Ip_u1s2(_bltzl);
+Ip_u1u2s3(_bne);
+Ip_u2s3u1(_cache);
+Ip_u1u2u3(_dmfc0);
+Ip_u1u2u3(_dmtc0);
+Ip_u2u1s3(_daddiu);
+Ip_u3u1u2(_daddu);
+Ip_u2u1u3(_dsll);
+Ip_u2u1u3(_dsll32);
+Ip_u2u1u3(_dsra);
+Ip_u2u1u3(_dsrl);
+Ip_u2u1u3(_dsrl32);
+Ip_u2u1u3(_drotr);
+Ip_u3u1u2(_dsubu);
+Ip_0(_eret);
+Ip_u1(_j);
+Ip_u1(_jal);
+Ip_u1(_jr);
+Ip_u2s3u1(_ld);
+Ip_u2s3u1(_ll);
+Ip_u2s3u1(_lld);
+Ip_u1s2(_lui);
+Ip_u2s3u1(_lw);
+Ip_u1u2u3(_mfc0);
+Ip_u1u2u3(_mtc0);
+Ip_u2u1u3(_ori);
+Ip_u2s3u1(_pref);
+Ip_0(_rfe);
+Ip_u2s3u1(_sc);
+Ip_u2s3u1(_scd);
+Ip_u2s3u1(_sd);
+Ip_u2u1u3(_sll);
+Ip_u2u1u3(_sra);
+Ip_u2u1u3(_srl);
+Ip_u3u1u2(_subu);
+Ip_u2s3u1(_sw);
+Ip_0(_tlbp);
+Ip_0(_tlbwi);
+Ip_0(_tlbwr);
+Ip_u3u1u2(_xor);
+Ip_u2u1u3(_xori);
+Ip_u2u1msbu3(_dins);
+
+/* Handle labels. */
+struct uasm_label {
+	u32 *addr;
+	int lab;
+};
+
+void __cpuinit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid);
+#ifdef CONFIG_64BIT
+int uasm_in_compat_space_p(long addr);
+#endif
+int uasm_rel_hi(long val);
+int uasm_rel_lo(long val);
+void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
+void UASM_i_LA(u32 **buf, unsigned int rs, long addr);
+
+#define UASM_L_LA(lb)							\
+static inline void __cpuinit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
+{									\
+	uasm_build_label(lab, addr, label##lb);				\
+}
+
+/* convenience macros for instructions */
+#ifdef CONFIG_64BIT
+# define UASM_i_LW(buf, rs, rt, off) uasm_i_ld(buf, rs, rt, off)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sd(buf, rs, rt, off)
+# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
+# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
+# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_daddu(buf, rs, rt, rd)
+# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_dsubu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
+#else
+# define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
+# define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
+# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
+# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
+# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
+# define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
+# define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
+# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
+# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_addu(buf, rs, rt, rd)
+# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_subu(buf, rs, rt, rd)
+# define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
+# define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
+#endif
+
+#define uasm_i_b(buf, off) uasm_i_beq(buf, 0, 0, off)
+#define uasm_i_beqz(buf, rs, off) uasm_i_beq(buf, rs, 0, off)
+#define uasm_i_beqzl(buf, rs, off) uasm_i_beql(buf, rs, 0, off)
+#define uasm_i_bnez(buf, rs, off) uasm_i_bne(buf, rs, 0, off)
+#define uasm_i_bnezl(buf, rs, off) uasm_i_bnel(buf, rs, 0, off)
+#define uasm_i_move(buf, a, b) UASM_i_ADDU(buf, a, 0, b)
+#define uasm_i_nop(buf) uasm_i_sll(buf, 0, 0, 0)
+#define uasm_i_ssnop(buf) uasm_i_sll(buf, 0, 0, 1)
+#define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
+
+/* Handle relocations. */
+struct uasm_reloc {
+	u32 *addr;
+	unsigned int type;
+	int lab;
+};
+
+/* This is zero so we can use zeroed label arrays. */
+#define UASM_LABEL_INVALID 0
+
+void uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid);
+void uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
+void uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end, long off);
+void uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end, long off);
+void uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab,
+	u32 *first, u32 *end, u32 *target);
+int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr);
+
+/* Convenience functions for labeled branches. */
+void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_b(u32 **p, struct uasm_reloc **r, int lid);
+void uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
+		 unsigned int reg2, int lid);
+void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
+void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index f5c7375..36272f7 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -35,7 +35,7 @@
 #include <asm/sibyte/sb1250_dma.h>
 #endif
 
-#include "uasm.h"
+#include <asm/uasm.h>
 
 /* Registers used in the assembled routines. */
 #define ZERO 0
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index eae45f0..bcf3002 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -29,8 +29,7 @@
 
 #include <asm/mmu_context.h>
 #include <asm/war.h>
-
-#include "uasm.h"
+#include <asm/uasm.h>
 
 static inline int r45k_bvahwbug(void)
 {
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 0a165c5..e3ca0f7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -19,8 +19,7 @@
 #include <asm/inst.h>
 #include <asm/elf.h>
 #include <asm/bugs.h>
-
-#include "uasm.h"
+#include <asm/uasm.h>
 
 enum fields {
 	RS = 0x001,
diff --git a/arch/mips/mm/uasm.h b/arch/mips/mm/uasm.h
deleted file mode 100644
index 3d153ed..0000000
--- a/arch/mips/mm/uasm.h
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
- * Copyright (C) 2005  Maciej W. Rozycki
- * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
- */
-
-#include <linux/types.h>
-
-#define Ip_u1u2u3(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
-
-#define Ip_u2u1u3(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
-
-#define Ip_u3u1u2(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
-
-#define Ip_u1u2s3(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
-
-#define Ip_u2s3u1(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, signed int b, unsigned int c)
-
-#define Ip_u2u1s3(op)							\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, signed int c)
-
-#define Ip_u2u1msbu3(op)						\
-void __cpuinit								\
-uasm_i##op(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
-	   unsigned int d)
-
-#define Ip_u1u2(op)							\
-void __cpuinit uasm_i##op(u32 **buf, unsigned int a, unsigned int b)
-
-#define Ip_u1s2(op)							\
-void __cpuinit uasm_i##op(u32 **buf, unsigned int a, signed int b)
-
-#define Ip_u1(op) void __cpuinit uasm_i##op(u32 **buf, unsigned int a)
-
-#define Ip_0(op) void __cpuinit uasm_i##op(u32 **buf)
-
-Ip_u2u1s3(_addiu);
-Ip_u3u1u2(_addu);
-Ip_u2u1u3(_andi);
-Ip_u3u1u2(_and);
-Ip_u1u2s3(_beq);
-Ip_u1u2s3(_beql);
-Ip_u1s2(_bgez);
-Ip_u1s2(_bgezl);
-Ip_u1s2(_bltz);
-Ip_u1s2(_bltzl);
-Ip_u1u2s3(_bne);
-Ip_u2s3u1(_cache);
-Ip_u1u2u3(_dmfc0);
-Ip_u1u2u3(_dmtc0);
-Ip_u2u1s3(_daddiu);
-Ip_u3u1u2(_daddu);
-Ip_u2u1u3(_dsll);
-Ip_u2u1u3(_dsll32);
-Ip_u2u1u3(_dsra);
-Ip_u2u1u3(_dsrl);
-Ip_u2u1u3(_dsrl32);
-Ip_u2u1u3(_drotr);
-Ip_u3u1u2(_dsubu);
-Ip_0(_eret);
-Ip_u1(_j);
-Ip_u1(_jal);
-Ip_u1(_jr);
-Ip_u2s3u1(_ld);
-Ip_u2s3u1(_ll);
-Ip_u2s3u1(_lld);
-Ip_u1s2(_lui);
-Ip_u2s3u1(_lw);
-Ip_u1u2u3(_mfc0);
-Ip_u1u2u3(_mtc0);
-Ip_u2u1u3(_ori);
-Ip_u2s3u1(_pref);
-Ip_0(_rfe);
-Ip_u2s3u1(_sc);
-Ip_u2s3u1(_scd);
-Ip_u2s3u1(_sd);
-Ip_u2u1u3(_sll);
-Ip_u2u1u3(_sra);
-Ip_u2u1u3(_srl);
-Ip_u3u1u2(_subu);
-Ip_u2s3u1(_sw);
-Ip_0(_tlbp);
-Ip_0(_tlbwi);
-Ip_0(_tlbwr);
-Ip_u3u1u2(_xor);
-Ip_u2u1u3(_xori);
-Ip_u2u1msbu3(_dins);
-
-/* Handle labels. */
-struct uasm_label {
-	u32 *addr;
-	int lab;
-};
-
-void __cpuinit uasm_build_label(struct uasm_label **lab, u32 *addr, int lid);
-#ifdef CONFIG_64BIT
-int uasm_in_compat_space_p(long addr);
-#endif
-int uasm_rel_hi(long val);
-int uasm_rel_lo(long val);
-void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
-void UASM_i_LA(u32 **buf, unsigned int rs, long addr);
-
-#define UASM_L_LA(lb)							\
-static inline void __cpuinit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
-{									\
-	uasm_build_label(lab, addr, label##lb);				\
-}
-
-/* convenience macros for instructions */
-#ifdef CONFIG_64BIT
-# define UASM_i_LW(buf, rs, rt, off) uasm_i_ld(buf, rs, rt, off)
-# define UASM_i_SW(buf, rs, rt, off) uasm_i_sd(buf, rs, rt, off)
-# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_dsll(buf, rs, rt, sh)
-# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_dsra(buf, rs, rt, sh)
-# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_dsrl(buf, rs, rt, sh)
-# define UASM_i_MFC0(buf, rt, rd...) uasm_i_dmfc0(buf, rt, rd)
-# define UASM_i_MTC0(buf, rt, rd...) uasm_i_dmtc0(buf, rt, rd)
-# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_daddiu(buf, rs, rt, val)
-# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_daddu(buf, rs, rt, rd)
-# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_dsubu(buf, rs, rt, rd)
-# define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
-# define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
-#else
-# define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
-# define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
-# define UASM_i_SLL(buf, rs, rt, sh) uasm_i_sll(buf, rs, rt, sh)
-# define UASM_i_SRA(buf, rs, rt, sh) uasm_i_sra(buf, rs, rt, sh)
-# define UASM_i_SRL(buf, rs, rt, sh) uasm_i_srl(buf, rs, rt, sh)
-# define UASM_i_MFC0(buf, rt, rd...) uasm_i_mfc0(buf, rt, rd)
-# define UASM_i_MTC0(buf, rt, rd...) uasm_i_mtc0(buf, rt, rd)
-# define UASM_i_ADDIU(buf, rs, rt, val) uasm_i_addiu(buf, rs, rt, val)
-# define UASM_i_ADDU(buf, rs, rt, rd) uasm_i_addu(buf, rs, rt, rd)
-# define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_subu(buf, rs, rt, rd)
-# define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
-# define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
-#endif
-
-#define uasm_i_b(buf, off) uasm_i_beq(buf, 0, 0, off)
-#define uasm_i_beqz(buf, rs, off) uasm_i_beq(buf, rs, 0, off)
-#define uasm_i_beqzl(buf, rs, off) uasm_i_beql(buf, rs, 0, off)
-#define uasm_i_bnez(buf, rs, off) uasm_i_bne(buf, rs, 0, off)
-#define uasm_i_bnezl(buf, rs, off) uasm_i_bnel(buf, rs, 0, off)
-#define uasm_i_move(buf, a, b) UASM_i_ADDU(buf, a, 0, b)
-#define uasm_i_nop(buf) uasm_i_sll(buf, 0, 0, 0)
-#define uasm_i_ssnop(buf) uasm_i_sll(buf, 0, 0, 1)
-#define uasm_i_ehb(buf) uasm_i_sll(buf, 0, 0, 3)
-
-/* Handle relocations. */
-struct uasm_reloc {
-	u32 *addr;
-	unsigned int type;
-	int lab;
-};
-
-/* This is zero so we can use zeroed label arrays. */
-#define UASM_LABEL_INVALID 0
-
-void uasm_r_mips_pc16(struct uasm_reloc **rel, u32 *addr, int lid);
-void uasm_resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
-void uasm_move_relocs(struct uasm_reloc *rel, u32 *first, u32 *end, long off);
-void uasm_move_labels(struct uasm_label *lab, u32 *first, u32 *end, long off);
-void uasm_copy_handler(struct uasm_reloc *rel, struct uasm_label *lab,
-	u32 *first, u32 *end, u32 *target);
-int uasm_insn_has_bdelay(struct uasm_reloc *rel, u32 *addr);
-
-/* Convenience functions for labeled branches. */
-void uasm_il_bltz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_b(u32 **p, struct uasm_reloc **r, int lid);
-void uasm_il_beqz(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_beqzl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bne(u32 **p, struct uasm_reloc **r, unsigned int reg1,
-		 unsigned int reg2, int lid);
-void uasm_il_bnez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bgezl(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
-void uasm_il_bgez(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid);
