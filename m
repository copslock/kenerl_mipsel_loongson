Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 14:56:39 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:31623 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWN42>;
	Fri, 23 May 2003 14:56:28 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NDuCLT006438;
	Fri, 23 May 2003 15:56:12 +0200 (MEST)
Date: Fri, 23 May 2003 15:56:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Kill warnings
Message-ID: <Pine.GSO.4.21.0305231554020.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Ralf,

Kill warnings:
  - Fix incorrect printf()-style format specifier
  - Move static inline get_insn_opcode() before first usage
  - Add missing cast of return value of page_address()
  - Refactor probe_tlb() to avoid unused variables on non-MIPS32/64 CPUs

--- linux-mips-2.4.x/arch/mips/kernel/setup.c	Mon May  5 16:23:41 2003
+++ linux/arch/mips/kernel/setup.c	Wed May  7 11:48:49 2003
@@ -396,7 +396,7 @@
 		       initrd_size);
 		if (PHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
 			printk("initrd extends beyond end of memory "
-			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			       "(0x%08x > 0x%08lx)\ndisabling initrd\n",
 			       PHYSADDR(initrd_end),
 			       PFN_PHYS(max_low_pfn));
 			initrd_start = initrd_end = 0;
--- linux-mips-2.4.x/arch/mips/kernel/traps.c	Mon May  5 16:23:42 2003
+++ linux/arch/mips/kernel/traps.c	Wed May  7 11:48:58 2003
@@ -488,6 +488,19 @@
 	force_sig(signal, current);
 }
 
+static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
+{
+	unsigned int *epc;
+
+	epc = (unsigned int *) regs->cp0_epc +
+	      ((regs->cp0_cause & CAUSEF_BD) != 0);
+	if (!get_user(*opcode, epc))
+		return 0;
+
+	force_sig(SIGSEGV, current);
+	return 1;
+}
+
 /*
  * ll uses the opcode of lwc0 and sc uses the opcode of swc0.  That is both
  * opcodes are supposed to result in coprocessor unusable exceptions if
@@ -564,19 +577,6 @@
 	}
 
 	force_sig(SIGFPE, current);
-}
-
-static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
-{
-	unsigned int *epc;
-
-	epc = (unsigned int *) regs->cp0_epc +
-	      ((regs->cp0_cause & CAUSEF_BD) != 0);
-	if (!get_user(*opcode, epc))
-		return 0;
-
-	force_sig(SIGSEGV, current);
-	return 1;
 }
 
 asmlinkage void do_bp(struct pt_regs *regs)
--- linux-mips-2.4.x/arch/mips/mm/cache.c	Mon May  5 16:30:45 2003
+++ linux/arch/mips/mm/cache.c	Wed May  7 11:49:15 2003
@@ -54,10 +54,9 @@
 	page = pte_page(pte);
 	if (VALID_PAGE(page) && page->mapping &&
 	    (page->flags & (1UL << PG_dcache_dirty))) {
-		if (pages_do_alias(page_address(page), address & PAGE_MASK)) {
-			addr = (unsigned long) page_address(page);
+		addr = (unsigned long)page_address(page);
+		if (pages_do_alias(addr, address & PAGE_MASK))
 			flush_data_cache_page(addr);
-		}
 
 		ClearPageDcacheDirty(page);
 	}
--- linux-mips-2.4.x/arch/mips/mm/tlb-r4k.c	Mon May  5 16:23:58 2003
+++ linux/arch/mips/mm/tlb-r4k.c	Wed May  7 11:49:27 2003
@@ -339,24 +339,24 @@
 
 static void __init probe_tlb(unsigned long config)
 {
+#if defined(CONFIG_CPU_MIPS32) || defined (CONFIG_CPU_MIPS64)
 	unsigned int prid, config1;
 
 	prid = read_c0_prid() & 0xff00;
-	if (prid == PRID_IMP_RM7000 || !(config & (1 << 31)))
-		/*
-		 * Not a MIPS32 complianant CPU.  Config 1 register not
-		 * supported, we assume R4k style.  Cpu probing already figured
-		 * out the number of tlb entries.
-		 */
+	if (prid != PRID_IMP_RM7000 && (config & (1 << 31))) {
+		config1 = read_c0_config1();
+		if (!((config >> 7) & 3))
+			panic("No MMU present");
+		else
+			current_cpu_data.tlbsize = ((config1 >> 25) & 0x3f) + 1;
 		return;
-
-#if defined(CONFIG_CPU_MIPS32) || defined (CONFIG_CPU_MIPS64)
-	config1 = read_c0_config1();
-	if (!((config >> 7) & 3))
-		panic("No MMU present");
-	else
-		current_cpu_data.tlbsize = ((config1 >> 25) & 0x3f) + 1;
+	}
 #endif
+	/*
+	 * Not a MIPS32 compliant CPU.  Config 1 register not
+	 * supported, we assume R4k style.  Cpu probing already figured
+	 * out the number of tlb entries.
+	 */
 }
 
 void __init r4k_tlb_init(void)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
