Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 14:39:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:33996 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039586AbWJPNjc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2006 14:39:32 +0100
Received: from localhost (p8069-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.69])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D7E079CC7; Mon, 16 Oct 2006 22:39:26 +0900 (JST)
Date:	Mon, 16 Oct 2006 22:41:46 +0900 (JST)
Message-Id: <20061016.224146.05601109.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] load modules to CKSEG0 if CONFIG_BUILD_ELF64=n
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is a patch to load 64-bit modules to CKSEG0 so that can be
compiled with -msym32 option.  This makes each module ~10% smaller.

* introduce MODULE_START and MODULE_END
* custom module_alloc()
* PGD for modules
* change XTLB refill handler synthesizer
* enable -msym32 for modules again
  (revert ca78b1a5c6a6e70e052d3ea253828e49b5d07c8a)

New XTLB refill handler looks like this:

80000080 dmfc0   k0,C0_BADVADDR
80000084 bltz    k0,800000e4			# goto l_module_alloc
80000088 lui     k1,0x8046			# %high(pgd_current)
8000008c ld      k1,24600(k1)			# %low(pgd_current)
80000090 dsrl    k0,k0,0x1b			# l_vmalloc_done:
80000094 andi    k0,k0,0x1ff8
80000098 daddu   k1,k1,k0
8000009c dmfc0   k0,C0_BADVADDR
800000a0 ld      k1,0(k1)
800000a4 dsrl    k0,k0,0x12
800000a8 andi    k0,k0,0xff8
800000ac daddu   k1,k1,k0
800000b0 dmfc0   k0,C0_XCONTEXT
800000b4 ld      k1,0(k1)
800000b8 andi    k0,k0,0xff0
800000bc daddu   k1,k1,k0
800000c0 ld      k0,0(k1)
800000c4 ld      k1,8(k1)
800000c8 dsrl    k0,k0,0x6
800000cc mtc0    k0,C0_ENTRYLO0
800000d0 dsrl    k1,k1,0x6
800000d4 mtc0    k1,C0_ENTRYL01
800000d8 nop
800000dc tlbwr
800000e0 eret
800000e4 dsll    k1,k0,0x2			# l_module_alloc:
800000e8 bgez    k1,80000008			# goto l_vmalloc
800000ec lui     k1,0xc000
800000f0 dsubu   k0,k0,k1
800000f4 lui     k1,0x8046			# %high(module_pg_dir)
800000f8 beq     zero,zero,80000000
800000fc nop
80000000 beq     zero,zero,80000090		# goto l_vmalloc_done
80000004 daddiu  k1,k1,0x4000
80000008 dsll32  k1,k1,0x0			# l_vmalloc:
8000000c dsubu   k0,k0,k1
80000010 beq     zero,zero,80000090		# goto l_vmalloc_done
80000014 lui     k1,0x8046			# %high(swapper_pg_dir)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/Makefile            |    4 ---
 arch/mips/kernel/head.S       |    3 ++
 arch/mips/kernel/module.c     |   15 +++++++++++
 arch/mips/mm/fault.c          |    4 +++
 arch/mips/mm/pgtable-64.c     |    3 ++
 arch/mips/mm/tlbex.c          |   55 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/pgtable-64.h |   13 +++++++++
 7 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d580d46..641aa30 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -63,9 +63,7 @@ cflags-y		+= -mabi=64
 ifdef CONFIG_BUILD_ELF64
 cflags-y		+= $(call cc-option,-mno-explicit-relocs)
 else
-# -msym32 can not be used for modules since they are loaded into XKSEG
-CFLAGS_MODULE		+= $(call cc-option,-mno-explicit-relocs)
-CFLAGS_KERNEL		+= $(call cc-option,-msym32)
+cflags-y		+= $(call cc-option,-msym32)
 endif
 endif
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 8c6db0f..ccc404d 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -249,6 +249,9 @@ #endif /* CONFIG_SMP */
 	 */
 	page	swapper_pg_dir, _PGD_ORDER
 #ifdef CONFIG_64BIT
+#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64)
+	page	module_pg_dir, _PGD_ORDER
+#endif
 	page	invalid_pmd_table, _PMD_ORDER
 #endif
 	page	invalid_pte_table, _PTE_ORDER
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index d7bf021..cb08014 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -29,6 +29,7 @@ #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <asm/pgtable.h>	/* MODULE_START */
 
 struct mips_hi16 {
 	struct mips_hi16 *next;
@@ -43,9 +44,23 @@ static DEFINE_SPINLOCK(dbe_lock);
 
 void *module_alloc(unsigned long size)
 {
+#ifdef MODULE_START
+	struct vm_struct *area;
+
+	size = PAGE_ALIGN(size);
+	if (!size)
+		return NULL;
+
+	area = __get_vm_area(size, VM_ALLOC, MODULE_START, MODULE_END);
+	if (!area)
+		return NULL;
+
+	return __vmalloc_area(area, GFP_KERNEL, PAGE_KERNEL);
+#else
 	if (size == 0)
 		return NULL;
 	return vmalloc(size);
+#endif
 }
 
 /* Free memory returned from module_alloc */
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 8423d85..6f90e7e 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -60,6 +60,10 @@ #endif
 	 */
 	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
 		goto vmalloc_fault;
+#ifdef MODULE_START
+	if (unlikely(address >= MODULE_START && address < MODULE_END))
+		goto vmalloc_fault;
+#endif
 
 	/*
 	 * If we're in an interrupt or have no user
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 8d600d3..c46eb65 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -58,6 +58,9 @@ void __init pagetable_init(void)
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
+#ifdef MODULE_START
+	pgd_init((unsigned long)module_pg_dir);
+#endif
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
 
 	pgd_base = swapper_pg_dir;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6f8b25c..b9a0260 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -421,6 +421,9 @@ enum label_id {
 	label_invalid,
 	label_second_part,
 	label_leave,
+#ifdef MODULE_START
+	label_module_alloc,
+#endif
 	label_vmalloc,
 	label_vmalloc_done,
 	label_tlbw_hazard,
@@ -453,6 +456,9 @@ #define L_LA(lb)						\
 
 L_LA(_second_part)
 L_LA(_leave)
+#ifdef MODULE_START
+L_LA(_module_alloc)
+#endif
 L_LA(_vmalloc)
 L_LA(_vmalloc_done)
 L_LA(_tlbw_hazard)
@@ -684,6 +690,13 @@ static void __init il_bgezl(u32 **p, str
 	i_bgezl(p, reg, 0);
 }
 
+static void __init __attribute__((unused))
+il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
+{
+	r_mips_pc16(r, *p, l);
+	i_bgez(p, reg, 0);
+}
+
 /* The only general purpose registers allowed in TLB handlers. */
 #define K0		26
 #define K1		27
@@ -968,7 +981,11 @@ build_get_pmde64(u32 **p, struct label *
 	 * The vmalloc handling is not in the hotpath.
 	 */
 	i_dmfc0(p, tmp, C0_BADVADDR);
+#ifdef MODULE_START
+	il_bltz(p, r, tmp, label_module_alloc);
+#else
 	il_bltz(p, r, tmp, label_vmalloc);
+#endif
 	/* No i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_SMP
@@ -1016,8 +1033,46 @@ build_get_pgd_vmalloc64(u32 **p, struct 
 {
 	long swpd = (long)swapper_pg_dir;
 
+#ifdef MODULE_START
+	long modd = (long)module_pg_dir;
+
+	l_module_alloc(l, *p);
+	/*
+	 * Assumption:
+	 * VMALLOC_START >= 0xc000000000000000UL
+	 * MODULE_START >= 0xe000000000000000UL
+	 */
+	i_SLL(p, ptr, bvaddr, 2);
+	il_bgez(p, r, ptr, label_vmalloc);
+
+	if (in_compat_space_p(MODULE_START) && !rel_lo(MODULE_START)) {
+		i_lui(p, ptr, rel_hi(MODULE_START)); /* delay slot */
+	} else {
+		/* unlikely configuration */
+		i_nop(p); /* delay slot */
+		i_LA(p, ptr, MODULE_START);
+	}
+	i_dsubu(p, bvaddr, bvaddr, ptr);
+
+	if (in_compat_space_p(modd) && !rel_lo(modd)) {
+		il_b(p, r, label_vmalloc_done);
+		i_lui(p, ptr, rel_hi(modd));
+	} else {
+		i_LA_mostly(p, ptr, modd);
+		il_b(p, r, label_vmalloc_done);
+		i_daddiu(p, ptr, ptr, rel_lo(modd));
+	}
+
+	l_vmalloc(l, *p);
+	if (in_compat_space_p(MODULE_START) && !rel_lo(MODULE_START) &&
+	    MODULE_START << 32 == VMALLOC_START)
+		i_dsll32(p, ptr, ptr, 0);	/* typical case */
+	else
+		i_LA(p, ptr, VMALLOC_START);
+#else
 	l_vmalloc(l, *p);
 	i_LA(p, ptr, VMALLOC_START);
+#endif
 	i_dsubu(p, bvaddr, bvaddr, ptr);
 
 	if (in_compat_space_p(swpd) && !rel_lo(swpd)) {
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index d05fb6f..a1b41ab 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -14,6 +14,7 @@ #include <linux/linkage.h>
 #include <asm/addrspace.h>
 #include <asm/page.h>
 #include <asm/cachectl.h>
+#include <asm/fixmap.h>
 
 #include <asm-generic/pgtable-nopud.h>
 
@@ -103,6 +104,13 @@ #define FIRST_USER_ADDRESS	0UL
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\
 	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)
+#if defined(CONFIG_MODULES) && !defined(CONFIG_BUILD_ELF64) && \
+	VMALLOC_START != CKSSEG
+/* Load modules into 32bit-compatible segment. */
+#define MODULE_START	CKSSEG
+#define MODULE_END	(FIXADDR_START-2*PAGE_SIZE)
+extern pgd_t module_pg_dir[PTRS_PER_PGD];
+#endif
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -174,7 +182,12 @@ #define __pud_offset(address)	(((address
 #define __pmd_offset(address)	pmd_index(address)
 
 /* to find an entry in a kernel page-table-directory */
+#ifdef MODULE_START
+#define pgd_offset_k(address) \
+	((address) >= MODULE_START ? module_pg_dir : pgd_offset(&init_mm, 0))
+#else
 #define pgd_offset_k(address) pgd_offset(&init_mm, 0)
+#endif
 
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
