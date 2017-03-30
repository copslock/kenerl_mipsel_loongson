Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 20:39:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24631 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993875AbdC3SixJtXwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 20:38:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 54AACFBC8B8E9;
        Thu, 30 Mar 2017 19:38:42 +0100 (IST)
Received: from localhost (10.20.1.33) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 30 Mar 2017 19:38:45
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 2/2] MIPS: module: Unify rel & rela reloc handling
Date:   Thu, 30 Mar 2017 11:37:45 -0700
Message-ID: <20170330183746.25339-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.12.1
In-Reply-To: <20170330183746.25339-1-paul.burton@imgtec.com>
References: <20170330183746.25339-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57485
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

The module load code has previously had entirely separate
implementations for rel & rela style relocs, which unnecessarily
duplicates a whole lot of code. Unify the implementations of both types
of reloc, sharing the bulk of the code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>

---

 arch/mips/include/asm/module.h |   8 +-
 arch/mips/kernel/Makefile      |   1 -
 arch/mips/kernel/module-rela.c | 202 -----------------------------------------
 arch/mips/kernel/module.c      | 195 ++++++++++++++++++++++++++++++---------
 4 files changed, 154 insertions(+), 252 deletions(-)
 delete mode 100644 arch/mips/kernel/module-rela.c

diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 702c273e67a9..e51add184717 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -47,8 +47,8 @@ typedef struct {
 #define Elf_Mips_Rel	Elf32_Rel
 #define Elf_Mips_Rela	Elf32_Rela
 
-#define ELF_MIPS_R_SYM(rel) ELF32_R_SYM(rel.r_info)
-#define ELF_MIPS_R_TYPE(rel) ELF32_R_TYPE(rel.r_info)
+#define ELF_MIPS_R_SYM(rel) ELF32_R_SYM((rel).r_info)
+#define ELF_MIPS_R_TYPE(rel) ELF32_R_TYPE((rel).r_info)
 
 #endif
 
@@ -65,8 +65,8 @@ typedef struct {
 #define Elf_Mips_Rel	Elf64_Mips_Rel
 #define Elf_Mips_Rela	Elf64_Mips_Rela
 
-#define ELF_MIPS_R_SYM(rel) (rel.r_sym)
-#define ELF_MIPS_R_TYPE(rel) (rel.r_type)
+#define ELF_MIPS_R_SYM(rel) ((rel).r_sym)
+#define ELF_MIPS_R_TYPE(rel) ((rel).r_type)
 
 #endif
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9a0e37b92ce0..f0edd7e8a0b7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 obj-$(CONFIG_DEBUG_FS)		+= segment.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= module.o
-obj-$(CONFIG_MODULES_USE_ELF_RELA) += module-rela.o
 
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/mips/kernel/module-rela.c b/arch/mips/kernel/module-rela.c
deleted file mode 100644
index 781168834456..000000000000
--- a/arch/mips/kernel/module-rela.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *  Copyright (C) 2001 Rusty Russell.
- *  Copyright (C) 2003, 2004 Ralf Baechle (ralf@linux-mips.org)
- *  Copyright (C) 2005 Thiemo Seufer
- *  Copyright (C) 2015 Imagination Technologies Ltd.
- */
-
-#include <linux/elf.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/moduleloader.h>
-
-extern int apply_r_mips_none(struct module *me, u32 *location, Elf_Addr v);
-
-static int apply_r_mips_32_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	*location = v;
-
-	return 0;
-}
-
-static int apply_r_mips_26_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	if (v % 4) {
-		pr_err("module %s: dangerous R_MIPS_26 RELA relocation\n",
-		       me->name);
-		return -ENOEXEC;
-	}
-
-	if ((v & 0xf0000000) != (((unsigned long)location + 4) & 0xf0000000)) {
-		pr_err("module %s: relocation overflow\n", me->name);
-		return -ENOEXEC;
-	}
-
-	*location = (*location & ~0x03ffffff) | ((v >> 2) & 0x03ffffff);
-
-	return 0;
-}
-
-static int apply_r_mips_hi16_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	*location = (*location & 0xffff0000) |
-		    ((((long long) v + 0x8000LL) >> 16) & 0xffff);
-
-	return 0;
-}
-
-static int apply_r_mips_lo16_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	*location = (*location & 0xffff0000) | (v & 0xffff);
-
-	return 0;
-}
-
-static int apply_r_mips_pc_rela(struct module *me, u32 *location, Elf_Addr v,
-				unsigned bits)
-{
-	unsigned long mask = GENMASK(bits - 1, 0);
-	unsigned long se_bits;
-	long offset;
-
-	if (v % 4) {
-		pr_err("module %s: dangerous R_MIPS_PC%u RELA relocation\n",
-		       me->name, bits);
-		return -ENOEXEC;
-	}
-
-	offset = ((long)v - (long)location) >> 2;
-
-	/* check the sign bit onwards are identical - ie. we didn't overflow */
-	se_bits = (offset & BIT(bits - 1)) ? ~0ul : 0;
-	if ((offset & ~mask) != (se_bits & ~mask)) {
-		pr_err("module %s: relocation overflow\n", me->name);
-		return -ENOEXEC;
-	}
-
-	*location = (*location & ~mask) | (offset & mask);
-
-	return 0;
-}
-
-static int apply_r_mips_pc16_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	return apply_r_mips_pc_rela(me, location, v, 16);
-}
-
-static int apply_r_mips_pc21_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	return apply_r_mips_pc_rela(me, location, v, 21);
-}
-
-static int apply_r_mips_pc26_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	return apply_r_mips_pc_rela(me, location, v, 26);
-}
-
-static int apply_r_mips_64_rela(struct module *me, u32 *location, Elf_Addr v)
-{
-	*(Elf_Addr *)location = v;
-
-	return 0;
-}
-
-static int apply_r_mips_higher_rela(struct module *me, u32 *location,
-				    Elf_Addr v)
-{
-	*location = (*location & 0xffff0000) |
-		    ((((long long) v + 0x80008000LL) >> 32) & 0xffff);
-
-	return 0;
-}
-
-static int apply_r_mips_highest_rela(struct module *me, u32 *location,
-				     Elf_Addr v)
-{
-	*location = (*location & 0xffff0000) |
-		    ((((long long) v + 0x800080008000LL) >> 48) & 0xffff);
-
-	return 0;
-}
-
-static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
-				Elf_Addr v) = {
-	[R_MIPS_NONE]		= apply_r_mips_none,
-	[R_MIPS_32]		= apply_r_mips_32_rela,
-	[R_MIPS_26]		= apply_r_mips_26_rela,
-	[R_MIPS_HI16]		= apply_r_mips_hi16_rela,
-	[R_MIPS_LO16]		= apply_r_mips_lo16_rela,
-	[R_MIPS_PC16]		= apply_r_mips_pc16_rela,
-	[R_MIPS_64]		= apply_r_mips_64_rela,
-	[R_MIPS_HIGHER]		= apply_r_mips_higher_rela,
-	[R_MIPS_HIGHEST]	= apply_r_mips_highest_rela,
-	[R_MIPS_PC21_S2]	= apply_r_mips_pc21_rela,
-	[R_MIPS_PC26_S2]	= apply_r_mips_pc26_rela,
-};
-
-int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-		       unsigned int symindex, unsigned int relsec,
-		       struct module *me)
-{
-	Elf_Mips_Rela *rel = (void *) sechdrs[relsec].sh_addr;
-	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
-	Elf_Sym *sym;
-	u32 *location;
-	unsigned int i, type;
-	Elf_Addr v;
-	int res;
-
-	pr_debug("Applying relocate section %u to %u\n", relsec,
-	       sechdrs[relsec].sh_info);
-
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
-		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
-			+ ELF_MIPS_R_SYM(rel[i]);
-		if (sym->st_value >= -MAX_ERRNO) {
-			/* Ignore unresolved weak symbol */
-			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
-				continue;
-			pr_warn("%s: Unknown symbol %s\n",
-			       me->name, strtab + sym->st_name);
-			return -ENOENT;
-		}
-
-		type = ELF_MIPS_R_TYPE(rel[i]);
-
-		if (type < ARRAY_SIZE(reloc_handlers_rela))
-			handler = reloc_handlers_rela[type];
-		else
-			handler = NULL;
-
-		if (!handler) {
-			pr_err("%s: Unknown relocation type %u\n",
-			       me->name, type);
-			return -EINVAL;
-		}
-
-		v = sym->st_value + rel[i].r_addend;
-		res = handler(me, location, v);
-		if (res)
-			return res;
-	}
-
-	return 0;
-}
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index ddcfb59593b6..b250eb0c4fc1 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -53,22 +53,25 @@ void *module_alloc(unsigned long size)
 }
 #endif
 
-int apply_r_mips_none(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_none(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
 	return 0;
 }
 
-static int apply_r_mips_32_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_32(struct module *me, u32 *location,
+			   u32 base, Elf_Addr v, bool rela)
 {
-	*location += v;
+	*location = base + v;
 
 	return 0;
 }
 
-static int apply_r_mips_26_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_26(struct module *me, u32 *location,
+			   u32 base, Elf_Addr v, bool rela)
 {
 	if (v % 4) {
-		pr_err("module %s: dangerous R_MIPS_26 REL relocation\n",
+		pr_err("module %s: dangerous R_MIPS_26 relocation\n",
 		       me->name);
 		return -ENOEXEC;
 	}
@@ -80,15 +83,22 @@ static int apply_r_mips_26_rel(struct module *me, u32 *location, Elf_Addr v)
 	}
 
 	*location = (*location & ~0x03ffffff) |
-		    ((*location + (v >> 2)) & 0x03ffffff);
+		    ((base + (v >> 2)) & 0x03ffffff);
 
 	return 0;
 }
 
-static int apply_r_mips_hi16_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_hi16(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
 	struct mips_hi16 *n;
 
+	if (rela) {
+		*location = (*location & 0xffff0000) |
+			    ((((long long) v + 0x8000LL) >> 16) & 0xffff);
+		return 0;
+	}
+
 	/*
 	 * We cannot relocate this one now because we don't know the value of
 	 * the carry we need to add.  Save the information, and let LO16 do the
@@ -117,12 +127,18 @@ static void free_relocation_chain(struct mips_hi16 *l)
 	}
 }
 
-static int apply_r_mips_lo16_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_lo16(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
-	unsigned long insnlo = *location;
+	unsigned long insnlo = base;
 	struct mips_hi16 *l;
 	Elf_Addr val, vallo;
 
+	if (rela) {
+		*location = (*location & 0xffff0000) | (v & 0xffff);
+		return 0;
+	}
+
 	/* Sign extend the addend we extract from the lo insn.	*/
 	vallo = ((insnlo & 0xffff) ^ 0x8000) - 0x8000;
 
@@ -178,26 +194,26 @@ static int apply_r_mips_lo16_rel(struct module *me, u32 *location, Elf_Addr v)
 	free_relocation_chain(l);
 	me->arch.r_mips_hi16_list = NULL;
 
-	pr_err("module %s: dangerous R_MIPS_LO16 REL relocation\n", me->name);
+	pr_err("module %s: dangerous R_MIPS_LO16 relocation\n", me->name);
 
 	return -ENOEXEC;
 }
 
-static int apply_r_mips_pc_rel(struct module *me, u32 *location, Elf_Addr v,
-			       unsigned bits)
+static int apply_r_mips_pc(struct module *me, u32 *location, u32 base,
+			   Elf_Addr v, unsigned int bits)
 {
 	unsigned long mask = GENMASK(bits - 1, 0);
 	unsigned long se_bits;
 	long offset;
 
 	if (v % 4) {
-		pr_err("module %s: dangerous R_MIPS_PC%u REL relocation\n",
+		pr_err("module %s: dangerous R_MIPS_PC%u relocation\n",
 		       me->name, bits);
 		return -ENOEXEC;
 	}
 
-	/* retrieve & sign extend implicit addend */
-	offset = *location & mask;
+	/* retrieve & sign extend implicit addend if any */
+	offset = base & mask;
 	offset |= (offset & BIT(bits - 1)) ? ~mask : 0;
 
 	offset += ((long)v - (long)location) >> 2;
@@ -214,56 +230,121 @@ static int apply_r_mips_pc_rel(struct module *me, u32 *location, Elf_Addr v,
 	return 0;
 }
 
-static int apply_r_mips_pc16_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_pc16(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
-	return apply_r_mips_pc_rel(me, location, v, 16);
+	return apply_r_mips_pc(me, location, base, v, 16);
 }
 
-static int apply_r_mips_pc21_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_pc21(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
-	return apply_r_mips_pc_rel(me, location, v, 21);
+	return apply_r_mips_pc(me, location, base, v, 21);
 }
 
-static int apply_r_mips_pc26_rel(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_mips_pc26(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela)
 {
-	return apply_r_mips_pc_rel(me, location, v, 26);
+	return apply_r_mips_pc(me, location, base, v, 26);
 }
 
-static int (*reloc_handlers_rel[]) (struct module *me, u32 *location,
-				Elf_Addr v) = {
+static int apply_r_mips_64(struct module *me, u32 *location,
+			   u32 base, Elf_Addr v, bool rela)
+{
+	if (WARN_ON(!rela))
+		return -EINVAL;
+
+	*(Elf_Addr *)location = v;
+
+	return 0;
+}
+
+static int apply_r_mips_higher(struct module *me, u32 *location,
+			       u32 base, Elf_Addr v, bool rela)
+{
+	if (WARN_ON(!rela))
+		return -EINVAL;
+
+	*location = (*location & 0xffff0000) |
+		    ((((long long)v + 0x80008000LL) >> 32) & 0xffff);
+
+	return 0;
+}
+
+static int apply_r_mips_highest(struct module *me, u32 *location,
+				u32 base, Elf_Addr v, bool rela)
+{
+	if (WARN_ON(!rela))
+		return -EINVAL;
+
+	*location = (*location & 0xffff0000) |
+		    ((((long long)v + 0x800080008000LL) >> 48) & 0xffff);
+
+	return 0;
+}
+
+/**
+ * reloc_handler() - Apply a particular relocation to a module
+ * @me: the module to apply the reloc to
+ * @location: the address at which the reloc is to be applied
+ * @base: the existing value at location for REL-style; 0 for RELA-style
+ * @v: the value of the reloc, with addend for RELA-style
+ *
+ * Each implemented reloc_handler function applies a particular type of
+ * relocation to the module @me. Relocs that may be found in either REL or RELA
+ * variants can be handled by making use of the @base & @v parameters which are
+ * set to values which abstract the difference away from the particular reloc
+ * implementations.
+ *
+ * Return: 0 upon success, else -ERRNO
+ */
+typedef int (*reloc_handler)(struct module *me, u32 *location,
+			     u32 base, Elf_Addr v, bool rela);
+
+/* The handlers for known reloc types */
+static reloc_handler reloc_handlers[] = {
 	[R_MIPS_NONE]		= apply_r_mips_none,
-	[R_MIPS_32]		= apply_r_mips_32_rel,
-	[R_MIPS_26]		= apply_r_mips_26_rel,
-	[R_MIPS_HI16]		= apply_r_mips_hi16_rel,
-	[R_MIPS_LO16]		= apply_r_mips_lo16_rel,
-	[R_MIPS_PC16]		= apply_r_mips_pc16_rel,
-	[R_MIPS_PC21_S2]	= apply_r_mips_pc21_rel,
-	[R_MIPS_PC26_S2]	= apply_r_mips_pc26_rel,
+	[R_MIPS_32]		= apply_r_mips_32,
+	[R_MIPS_26]		= apply_r_mips_26,
+	[R_MIPS_HI16]		= apply_r_mips_hi16,
+	[R_MIPS_LO16]		= apply_r_mips_lo16,
+	[R_MIPS_PC16]		= apply_r_mips_pc16,
+	[R_MIPS_64]		= apply_r_mips_64,
+	[R_MIPS_HIGHER]		= apply_r_mips_higher,
+	[R_MIPS_HIGHEST]	= apply_r_mips_highest,
+	[R_MIPS_PC21_S2]	= apply_r_mips_pc21,
+	[R_MIPS_PC26_S2]	= apply_r_mips_pc26,
 };
 
-int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
-		   unsigned int symindex, unsigned int relsec,
-		   struct module *me)
+static int __apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
+			    unsigned int symindex, unsigned int relsec,
+			    struct module *me, bool rela)
 {
-	Elf_Mips_Rel *rel = (void *) sechdrs[relsec].sh_addr;
-	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
+	union {
+		Elf_Mips_Rel *rel;
+		Elf_Mips_Rela *rela;
+	} r;
+	reloc_handler handler;
 	Elf_Sym *sym;
-	u32 *location;
+	u32 *location, base;
 	unsigned int i, type;
 	Elf_Addr v;
 	int err = 0;
+	size_t reloc_sz;
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 
+	r.rel = (void *)sechdrs[relsec].sh_addr;
+	reloc_sz = rela ? sizeof(*r.rela) : sizeof(*r.rel);
 	me->arch.r_mips_hi16_list = NULL;
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+	for (i = 0; i < sechdrs[relsec].sh_size / reloc_sz; i++) {
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
+			+ r.rel->r_offset;
 		/* This is the symbol it is referring to */
 		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
-			+ ELF_MIPS_R_SYM(rel[i]);
+			+ ELF_MIPS_R_SYM(*r.rel);
 		if (sym->st_value >= -MAX_ERRNO) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
@@ -274,10 +355,9 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 			goto out;
 		}
 
-		type = ELF_MIPS_R_TYPE(rel[i]);
-
-		if (type < ARRAY_SIZE(reloc_handlers_rel))
-			handler = reloc_handlers_rel[type];
+		type = ELF_MIPS_R_TYPE(*r.rel);
+		if (type < ARRAY_SIZE(reloc_handlers))
+			handler = reloc_handlers[type];
 		else
 			handler = NULL;
 
@@ -288,8 +368,17 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 			goto out;
 		}
 
-		v = sym->st_value;
-		err = handler(me, location, v);
+		if (rela) {
+			v = sym->st_value + r.rela->r_addend;
+			base = 0;
+			r.rela = &r.rela[1];
+		} else {
+			v = sym->st_value;
+			base = *location;
+			r.rel = &r.rel[1];
+		}
+
+		err = handler(me, location, base, v, rela);
 		if (err)
 			goto out;
 	}
@@ -312,6 +401,22 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 	return err;
 }
 
+int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
+		   unsigned int symindex, unsigned int relsec,
+		   struct module *me)
+{
+	return __apply_relocate(sechdrs, strtab, symindex, relsec, me, false);
+}
+
+#ifdef CONFIG_MODULES_USE_ELF_RELA
+int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+		       unsigned int symindex, unsigned int relsec,
+		       struct module *me)
+{
+	return __apply_relocate(sechdrs, strtab, symindex, relsec, me, true);
+}
+#endif /* CONFIG_MODULES_USE_ELF_RELA */
+
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_dbetables(unsigned long addr)
 {
-- 
2.12.1
