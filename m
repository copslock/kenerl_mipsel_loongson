Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 15:42:48 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.224]:8870 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038868AbWHYOmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Aug 2006 15:42:45 +0100
Received: by wx-out-0506.google.com with SMTP id h30so964233wxd
        for <linux-mips@linux-mips.org>; Fri, 25 Aug 2006 07:42:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=RVFEx36x7Rg25MMa5lX2WewphEhmhnCx/Bfj/T3IUeDes+ZzFCIwmFz1ew1KD2meG9BMcvJ/MIsCMSaYhWCepLc+IYlmuismX3dYc/zvLsyhzOq0sys4kGP9/OV2nRl+ofuxyrvsaiAJd/2mT++A54trc1bxHi1hrpjoR/Ph5Cs=
Received: by 10.70.100.1 with SMTP id x1mr4641240wxb;
        Fri, 25 Aug 2006 07:42:44 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i11sm3095668wxd.2006.08.25.07.42.42;
        Fri, 25 Aug 2006 07:42:43 -0700 (PDT)
Message-ID: <44EF0C61.7090008@gmail.com>
Date:	Fri, 25 Aug 2006 10:42:41 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Jonathan Day <imipak@yahoo.com>
Subject: [PATCH 2] 64K page size
Content-Type: multipart/mixed;
 boundary="------------060606020903060407080701"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060606020903060407080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Attached is the rest of the 64K page patch. It's been tested 
uniprocessor on Malta 20KC and 25KF. It also runs on a 6-way SMP 
functional simulator containing 5KF's. Ran tests with 16K and 64K page 
size.

Question: Is there an SMP malta board?

There are 2 areas which could use improvement:

(1) Because 64K is larger than a 15 bit immediate operand, I could not 
get the asm-offsets mechanism to produce the correct constants. So I 
enlisted a fairly gruesome hack of using #define's for _PAGE_SIZE and 
_THREAD_SIZE, for that page size. Hopefully someone has a better idea.

(2) In tlbex.c:build_adjust_context(), I suspect the change for shift = 
PAGE_SHIFT - 12 should be more generally true, rather than just for the 
CPU's mentioned in the case statement. I was conservative there because 
I'm not familiar with the CPU_VR41* machines. Hopefully someone more 
intimate with that code can comment.


Signed-off-by: Peter Watkins <treestem@gmail.com>





--------------060606020903060407080701
Content-Type: text/plain;
 name="patch-pagesize-2.6.18-rc1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pagesize-2.6.18-rc1.txt"

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
index c06f63e..c9de17c 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -190,7 +190,12 @@ #endif /* CONFIG_MIPS_MT_SMTC */
 
 	MTC0		zero, CP0_CONTEXT	# clear context register
 	PTR_LA		$28, init_thread_union
+#ifdef CONFIG_PAGE_SIZE_64KB
+	PTR_ADDIU	sp, $28, (_THREAD_SIZE - 32)/2
+	PTR_ADDIU	sp,  sp, (_THREAD_SIZE - 32)/2
+#else
 	PTR_ADDIU	sp, $28, _THREAD_SIZE - 32
+#endif
 	set_saved_sp	sp, t0, t1
 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
 
diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index d5c8b82..fe534c7 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -85,7 +85,12 @@ #endif
 	move	$28, a2
 	cpu_restore_nonscratch a1
 
+#ifdef CONFIG_PAGE_SIZE_64KB
+	PTR_ADDIU	t0, $28, (_THREAD_SIZE - 32)/2
+	PTR_ADDIU	t0,  t0, (_THREAD_SIZE - 32)/2
+#else
 	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
+#endif
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
index 375e099..bf093aa 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -97,6 +97,8 @@ #define FUNC_SH		0
 #define SET_MASK	0x7
 #define SET_SH		0
 
+#define OP_ERET		0x42000018
+
 enum opcode {
 	insn_invalid,
 	insn_addu, insn_addiu, insn_and, insn_andi, insn_beq,
@@ -631,6 +633,9 @@ static __init void copy_handler(struct r
 static __init int __attribute__((unused)) insn_has_bdelay(struct reloc *rel,
 							  u32 *addr)
 {
+	if (*addr == OP_ERET)
+		return 1;
+
 	for (; rel->lab != label_invalid; rel++) {
 		if (rel->addr == addr
 		    && (rel->type == R_MIPS_PC16
@@ -996,7 +1001,12 @@ #else
 #endif
 
 	l_vmalloc_done(l, *p);
-	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-3); /* get pgd offset in bytes */
+
+	/* Want PGDIR_SHIFT-3 here, but break it into two ops so we don't
+	 * exceed the max shift amount of 31 with large page sizes. */
+	i_dsrl(p, tmp, tmp, PGDIR_SHIFT-16);   	/* get pgd offset in bytes */
+	i_dsrl(p, tmp, tmp, 16-3); 		/* get pgd offset in bytes */
+
 	i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
 	i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
@@ -1087,6 +1097,11 @@ static __init void build_adjust_context(
 	case CPU_VR4133:
 		shift += 2;
 		break;
+	case CPU_20KC:
+	case CPU_25KF:
+	case CPU_5KC:
+		shift  = PAGE_SHIFT - 12;
+		break;
 
 	default:
 		break;
@@ -1811,7 +1826,7 @@ void __init build_tlb_refill_handler(voi
 	default:
 		build_r4000_tlb_refill_handler();
 		if (!run_once) {
-			build_r4000_tlb_load_handler();
+ 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
 			run_once++;
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 6ed1151..64cc068 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -34,6 +34,14 @@ #endif
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
+/* 
+ * Since asm-offsets.c does not work for more than 15 bit values,
+ * we defines these here.
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

--------------060606020903060407080701--
