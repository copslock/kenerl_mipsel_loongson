Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 18:27:31 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.236]:12691 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039480AbWH2R12 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 18:27:28 +0100
Received: by wx-out-0506.google.com with SMTP id h30so2387303wxd
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2006 10:27:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=QfBqs1YMUjtX6Z78ivOkaq7tuzfHMMuHp8ZnkhLbSfHESMVynQkWTVyW+n+4xlhiDIVXj0mi81ZqWYImhEVvqU5quYcK+el06zyOy6bhw4Pff3w8J6JllmOaKJfa/ThMGZV9wyqXi0haOjKVQA9cfGQEENWYUUXaKv4PuGTZhvc=
Received: by 10.70.52.5 with SMTP id z5mr11879036wxz;
        Tue, 29 Aug 2006 10:27:26 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i10sm7344055wxd.2006.08.29.10.27.24;
        Tue, 29 Aug 2006 10:27:25 -0700 (PDT)
Message-ID: <44F478FA.6010802@gmail.com>
Date:	Tue, 29 Aug 2006 13:27:22 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH 3] 64K page size
References: <44EF0C61.7090008@gmail.com> <20060825152121.GF2887@networkno.de>
In-Reply-To: <20060825152121.GF2887@networkno.de>
Content-Type: multipart/mixed;
 boundary="------------060106010403040701090907"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060106010403040701090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello again,

This patch incorporates all of Thiemo's suggestions.

Basic retesting with 4K, 16K, and 64K pages on Malta 20KC and 25KF, and 
an SMP simulator.

FWIW, some of these changes are required to get 16K pages working.

- Peter



--------------060106010403040701090907
Content-Type: text/plain;
 name="patch-pagesize1-2.6.18-rc1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pagesize1-2.6.18-rc1.txt"

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index ec28077..07b6566 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -99,7 +99,10 @@ void output_thread_info_defines(void)
 	offset("#define TI_RESTART_BLOCK   ", struct thread_info, restart_block);
 	offset("#define TI_TP_VALUE	   ", struct thread_info, tp_value);
 	constant("#define _THREAD_SIZE_ORDER ", THREAD_SIZE_ORDER);
+#ifndef CONFIG_PAGE_SIZE_64KB
+	/* See comment in page.h */
 	constant("#define _THREAD_SIZE       ", THREAD_SIZE);
+#endif
 	constant("#define _THREAD_MASK       ", THREAD_MASK);
 	linefeed;
 }
@@ -219,7 +222,10 @@ void output_mm_defines(void)
 	offset("#define MM_PGD        ", struct mm_struct, pgd);
 	offset("#define MM_CONTEXT    ", struct mm_struct, context);
 	linefeed;
+#ifndef CONFIG_PAGE_SIZE_64KB
+	/* See comment in page.h */
 	constant("#define _PAGE_SIZE     ", PAGE_SIZE);
+#endif
 	constant("#define _PAGE_SHIFT    ", PAGE_SHIFT);
 	linefeed;
 	constant("#define _PGD_T_SIZE    ", sizeof(pgd_t));
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index c06f63e..ace4ba6 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -190,7 +190,8 @@ #endif /* CONFIG_MIPS_MT_SMTC */
 
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
-	PTR_ADDIU	sp, $28, _THREAD_SIZE - 32
+	PTR_LI		sp, _THREAD_SIZE - 32
+	PTR_ADDU	sp, $28
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index d5c8b82..839867e 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -85,7 +85,8 @@ #endif
 	move	$28, a2
 	cpu_restore_nonscratch a1
 
-	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
+	PTR_LI		t0, _THREAD_SIZE - 32
+	PTR_ADDU	t0, $28
 	set_saved_sp	t0, t1, t2
 #ifdef CONFIG_MIPS_MT_SMTC
 	/* Read-modify-writes of Status must be atomic on a VPE */
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 0bb9cd8..ad7d6ff 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -1,6 +1,10 @@
 #include <asm/asm-offsets.h>
 #include <asm-generic/vmlinux.lds.h>
 
+#ifdef CONFIG_PAGE_SIZE_64KB
+#define _PAGE_SIZE	0x10000
+#endif
+
 #undef mips
 #define mips mips
 OUTPUT_ARCH(mips)
@@ -50,6 +54,7 @@ #endif
   /* writeable */
   .data : {			/* Data */
     . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
+    . = ALIGN(_PAGE_SIZE);
     *(.data.init_task)
 
     *(.data)
diff --git a/arch/mips/lib-64/dump_tlb.c b/arch/mips/lib-64/dump_tlb.c
index 6db44c7..cc6fd23 100644
--- a/arch/mips/lib-64/dump_tlb.c
+++ b/arch/mips/lib-64/dump_tlb.c
@@ -147,7 +147,7 @@ void dump_list_process(struct task_struc
 	printk("Addr                 == %08lx\n", addr);
 	printk("tasks->mm.pgd        == %08lx\n", (unsigned long) t->mm->pgd);
 
-	page_dir = pgd_offset(t->mm, 0);
+	page_dir = pgd_offset(t->mm, 0UL);
 	printk("page_dir == %016lx\n", (unsigned long) page_dir);
 
 	pgd = pgd_offset(t->mm, addr);
diff --git a/arch/mips/mips-boards/generic/memory.c b/arch/mips/mips-boards/generic/memory.c
index be80c5d..eeed944 100644
--- a/arch/mips/mips-boards/generic/memory.c
+++ b/arch/mips/mips-boards/generic/memory.c
@@ -176,7 +176,7 @@ unsigned long __init prom_free_prom_memo
 		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
 			continue;
 
-		addr = boot_mem_map.map[i].addr;
+		addr = PAGE_ALIGN(boot_mem_map.map[i].addr);
 		while (addr < boot_mem_map.map[i].addr
 			      + boot_mem_map.map[i].size) {
 			ClearPageReserved(virt_to_page(__va(addr)));
diff --git a/arch/mips/mm/pg-r4k.c b/arch/mips/mm/pg-r4k.c
index b7c7492..b173a8d 100644
--- a/arch/mips/mm/pg-r4k.c
+++ b/arch/mips/mm/pg-r4k.c
@@ -270,6 +270,20 @@ static inline void build_addiu_a2_a0(uns
 	emit_instruction(mi);
 }
 
+static inline void build_addiu_a2(unsigned long offset)
+{
+	union mips_instruction mi;
+
+	BUG_ON(offset > 0x7fff);
+
+	mi.i_format.opcode     = cpu_has_64bit_gp_regs ? daddiu_op : addiu_op;
+	mi.i_format.rs         = 6;		/* $a2 */
+	mi.i_format.rt         = 6;		/* $a2 */
+	mi.i_format.simmediate = offset;
+
+	emit_instruction(mi);
+}
+
 static inline void build_addiu_a1(unsigned long offset)
 {
 	union mips_instruction mi;
@@ -369,7 +383,14 @@ void __init build_clear_page(void)
 		}
 	}
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0));
+        unsigned long off = PAGE_SIZE - (cpu_has_prefetch ? pref_offset_clear : 0);
+	if (off > 0x7fff) {
+	    build_addiu_a2_a0(off>>1);
+	    build_addiu_a2(off>>1);
+	}
+	else {
+	    build_addiu_a2_a0(off);
+	}
 
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
 		build_insn_word(0x3c01a000);	/* lui     $at, 0xa000  */
@@ -425,7 +446,14 @@ void __init build_copy_page(void)
 	store_offset = load_offset = 0;
 	instruction_pending = 0;
 
-	build_addiu_a2_a0(PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0));
+	unsigned long off = PAGE_SIZE - (cpu_has_prefetch ? pref_offset_copy : 0);
+	if (off > 0x7fff) {
+	    build_addiu_a2_a0(off>>1);
+	    build_addiu_a2(off>>1);
+	}
+	else {
+	    build_addiu_a2_a0(off);
+	}
 
 	if (R4600_V2_HIT_CACHEOP_WAR && cpu_is_r4600_v2_x())
 		build_insn_word(0x3c01a000);	/* lui     $at, 0xa000  */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 375e099..d1035ca 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -102,7 +102,7 @@ enum opcode {
 	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
 	insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_daddu, insn_daddiu, insn_dmfc0, insn_dmtc0,
-	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl,
+	insn_dsll, insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32,
 	insn_dsubu, insn_eret, insn_j, insn_jal, insn_jr, insn_ld,
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_mfc0, insn_mtc0,
 	insn_ori, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
@@ -145,6 +145,7 @@ static __initdata struct insn insn_table
 	{ insn_dsll32, M(spec_op,0,0,0,0,dsll32_op), RT | RD | RE },
 	{ insn_dsra, M(spec_op,0,0,0,0,dsra_op), RT | RD | RE },
 	{ insn_dsrl, M(spec_op,0,0,0,0,dsrl_op), RT | RD | RE },
+	{ insn_dsrl32, M(spec_op,0,0,0,0,dsrl32_op), RT | RD | RE },
 	{ insn_dsubu, M(spec_op,0,0,0,0,dsubu_op), RS | RT | RD },
 	{ insn_eret, M(cop0_op,cop_op,0,0,0,eret_op), 0 },
 	{ insn_j, M(j_op,0,0,0,0,0), JIMM },
@@ -385,6 +386,7 @@ I_u2u1u3(_dsll);
 I_u2u1u3(_dsll32);
 I_u2u1u3(_dsra);
 I_u2u1u3(_dsrl);
+I_u2u1u3(_dsrl32);
 I_u3u1u2(_dsubu);
 I_0(_eret);
 I_u1(_j);
@@ -996,7 +998,15 @@ #else
 #endif
 
 	l_vmalloc_done(l, *p);
-	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3); /* get pgd offset in bytes */
+
+	/* Want PGDIR_SHIFT-3 here, but handle shifts greater than 32
+	 * bits for large page sizes. */
+#ifdef CONFIG_PAGE_SIZE_4KB
+	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3);   		/* get pgd offset in bytes */
+#else
+	i_dsrl32(p, tmp, tmp, PGDIR_SHIFT-3-32);   	/* get pgd offset in bytes */
+#endif
+
 	i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
 	i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
@@ -1073,7 +1083,7 @@ #endif /* !CONFIG_64BIT */
 
 static __init void build_adjust_context(u32 **p, unsigned int ctx)
 {
-	unsigned int shift = 4 - (PTE_T_LOG2 + 1);
+	unsigned int shift = 4 - (PTE_T_LOG2 + 1) + PAGE_SHIFT - 12;
 	unsigned int mask = (PTRS_PER_PTE / 2 - 1) << (PTE_T_LOG2 + 1);
 
 	switch (current_cpu_data.cputype) {
@@ -1811,7 +1821,7 @@ void __init build_tlb_refill_handler(voi
 	default:
 		build_r4000_tlb_refill_handler();
 		if (!run_once) {
-			build_r4000_tlb_load_handler();
+ 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
 			run_once++;
diff --git a/include/asm-mips/asm.h b/include/asm-mips/asm.h
index e3038a4..838eb31 100644
--- a/include/asm-mips/asm.h
+++ b/include/asm-mips/asm.h
@@ -344,6 +344,7 @@ #define PTR_SUBU	subu
 #define PTR_L		lw
 #define PTR_S		sw
 #define PTR_LA		la
+#define PTR_LI		li
 #define PTR_SLL		sll
 #define PTR_SLLV	sllv
 #define PTR_SRL		srl
@@ -368,6 +369,7 @@ #define PTR_SUBU	dsubu
 #define PTR_L		ld
 #define PTR_S		sd
 #define PTR_LA		dla
+#define PTR_LI		dli
 #define PTR_SLL		dsll
 #define PTR_SLLV	dsllv
 #define PTR_SRL		dsrl
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 6ed1151..be9bb68 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -34,6 +34,14 @@ #endif
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
+/* 
+ * Since asm-offsets.c does not work for more than 15 bit values,
+ * we define these here.
+ */
+#ifdef CONFIG_PAGE_SIZE_64KB
+#define _PAGE_SIZE      0x10000
+#define _THREAD_SIZE    0x10000 
+#endif
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/include/asm-mips/pgalloc.h b/include/asm-mips/pgalloc.h
index 582c1fe..af121c6 100644
--- a/include/asm-mips/pgalloc.h
+++ b/include/asm-mips/pgalloc.h
@@ -48,7 +48,7 @@ static inline pgd_t *pgd_alloc(struct mm
 
 	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
 	if (ret) {
-		init = pgd_offset(&init_mm, 0);
+		init = pgd_offset(&init_mm, 0UL);
 		pgd_init((unsigned long)ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index 9ce72bd..05a0e66 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -174,7 +174,7 @@ #define __pud_offset(address)	(((address
 #define __pmd_offset(address)	pmd_index(address)
 
 /* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(address) pgd_offset(&init_mm, 0)
+#define pgd_offset_k(address) pgd_offset(&init_mm, 0UL)
 
 #define pgd_index(address)	(((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define pmd_index(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))

--------------060106010403040701090907--
