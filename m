Received:  by oss.sgi.com id <S42291AbQHNMP4>;
	Mon, 14 Aug 2000 05:15:56 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:2040 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42186AbQHNMPi>;
	Mon, 14 Aug 2000 05:15:38 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA18734;
	Mon, 14 Aug 2000 14:15:22 +0200 (MET DST)
Date:   Mon, 14 Aug 2000 14:15:21 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Non-contiguous memory support
Message-ID: <Pine.GSO.3.96.1000814133957.7256S-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Following is a patch that provides support for non-contiguous memory. 
This is needed at least for MS02-based DECstations in mixed memory
configurations, where 24MB holes exist between 8MB memory modules.

 I decided to write it in a generic way, hence the code is common to all
MIPS platforms, removing tons of now unnecessary duplicate code.  It's
modelled after the E820 memory support for i386 and provides similar
functionality, i.e. platform-specific backends can obtain a memory map in
a system-dependent fashion and register it with the generic code.  Later,
the map may get either accepted or overridden by a command line providing
a series of "mem=<size>@<start>" statements.  The latter may be useful for
developers to avoid pulling away memory modules to get specific memory
configurations tested (e.g. low memory performance).

 The generic code registers the memory map in '/proc/iomem' just like it
happens for other platforms -- here is an example output from my machine:

$ cat /proc/iomem
00000000-067fffff : System RAM
  00040000-00298e7f : Kernel code
  002ac0a0-00344b0f : Kernel data
08000000-087fffff : System RAM
0a000000-0a7fffff : System RAM
0c000000-0c7fffff : System RAM

Eventually all memory-mapped resources should get registered there, but
this is something for a start. 

 The code from arc/memory.c to place the bootmem allocator bitmap in the
largest area available got removed.  The bitmap gets always placed right
above the kernel.  I don't really think it should really matter, but if it
did, I may add this code in a generic way (people interested in such
machines, please make comments).

 I removed orion/misc.c completely instead of rewriting it --
orion/setup.c contains everything the former did and more. 

 I tried to fix every system supported, but a few look weird -- they do
not provide prom_init(), thus I am not sure how they even can be started
by kernel/setup.c.  As a result their memory initialization code remains
intact (non-existent?).  That aside, the memory initialization should look
fairly sane now.  The DEC path was tested as usual -- others did not.  If
there are any specific questions about some part of the code, I am looking
forward to read them.

 Comments are welcomed, as usually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/arc/cmdline.c linux-mips-2.4.0-test5-20000731/arch/mips/arc/cmdline.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/arc/cmdline.c	Tue Mar 28 04:26:00 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/arc/cmdline.c	Sun Aug 13 12:14:21 2000
@@ -14,7 +14,7 @@
 
 /* #define DEBUG_CMDLINE */
 
-char arcs_cmdline[CL_SIZE];
+char arcs_cmdline[COMMAND_LINE_SIZE];
 
 char * __init prom_getcmdline(void)
 {
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/arc/memory.c linux-mips-2.4.0-test5-20000731/arch/mips/arc/memory.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/arc/memory.c	Wed Jul  5 04:25:46 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/arc/memory.c	Sun Aug 13 20:37:39 2000
@@ -47,31 +47,25 @@
 	"LoadedProgram",
 	"FirmwareTemporary",
 	"FirmwarePermanent",
-	"FreeContigiuous"
+	"FreeContiguous"
 };
 #define mtypes(a) (prom_flags & PROM_FLAG_ARCS) ? arcs_mtypes[a.arcs] : arc_mtypes[a.arc]
 #endif
 
-static struct prom_pmemblock pblocks[PROM_MAX_PMEMBLOCKS];
-
-#define MEMTYPE_DONTUSE   0
-#define MEMTYPE_PROM      1
-#define MEMTYPE_FREE      2
-
 static inline int memtype_classify_arcs (union linux_memtypes type)
 {
 	switch (type.arcs) {
 	case arcs_fcontig:
 	case arcs_free:
-		return MEMTYPE_FREE;
+		return BOOT_MEM_RAM;
 	case arcs_atmp:
-		return MEMTYPE_PROM;
+		return BOOT_MEM_ROM_DATA;
 	case arcs_eblock:
 	case arcs_rvpage:
 	case arcs_bmem:
 	case arcs_prog:
 	case arcs_aperm:
-		return MEMTYPE_DONTUSE;
+		return BOOT_MEM_RESERVED;
 	default:
 		BUG();
 	}
@@ -83,15 +77,15 @@
 	switch (type.arc) {
 	case arc_free:
 	case arc_fcontig:
-		return MEMTYPE_FREE;
+		return BOOT_MEM_RAM;
 	case arc_atmp:
-		return MEMTYPE_PROM;
+		return BOOT_MEM_ROM_DATA;
 	case arc_eblock:
 	case arc_rvpage:
 	case arc_bmem:
 	case arc_prog:
 	case arc_aperm:
-		return MEMTYPE_DONTUSE;
+		return BOOT_MEM_RESERVED;
 	default:
 		BUG();
 	}
@@ -106,50 +100,13 @@
 	return memtype_classify_arc(type);
 }
 
-static inline unsigned long find_max_low_pfn(void)
-{
-	struct prom_pmemblock *p, *highest;
-	unsigned long pfn;
-
-	p = pblocks;
-	highest = 0;
-	while (p->size != 0) {
-		if (!highest || p->base > highest->base)
-			highest = p;
-		p++;
-	}
-
-	pfn = (highest->base + highest->size) >> PAGE_SHIFT;
-#ifdef DEBUG
-	prom_printf("find_max_low_pfn: 0x%lx pfns.\n", pfn);
-#endif
-	return pfn;
-}
-
-static inline struct prom_pmemblock *find_largest_memblock(void)
-{
-	struct prom_pmemblock *p, *largest;
-
-	p = pblocks;
-	largest = 0;
-	while (p->size != 0) {
-		if (!largest || p->size > largest->size)
-			largest = p;
-		p++;
-	}
-
-	return largest;
-}
-
 void __init prom_meminit(void)
 {
-	struct prom_pmemblock *largest;
-	unsigned long bootmap_size;
 	struct linux_mdesc *p;
-	int totram;
-	int i = 0;
 
 #ifdef DEBUG
+	int i = 0;
+
 	prom_printf("ARCS MEMORY DESCRIPTOR dump:\n");
 	p = ArcGetMemoryDescriptor(PROM_NULL_MDESC);
 	while(p) {
@@ -160,77 +117,37 @@
 	}
 #endif
 
-	totram = 0;
-	i = 0;
 	p = PROM_NULL_MDESC;
 	while ((p = ArcGetMemoryDescriptor(p))) {
-		pblocks[i].type = prom_memtype_classify(p->type);
-		pblocks[i].base = p->base << PAGE_SHIFT;
-		pblocks[i].size = p->pages << PAGE_SHIFT;
-
-		switch (pblocks[i].type) {
-		case MEMTYPE_FREE:
-			totram += pblocks[i].size;
-#ifdef DEBUG
-			prom_printf("free_chunk[%d]: base=%08lx size=%x\n",
-				    i, pblocks[i].base,
-				    pblocks[i].size);
-#endif
-			i++;
-			break;
-		case MEMTYPE_PROM:
-#ifdef DEBUG
-			prom_printf("prom_chunk[%d]: base=%08lx size=%x\n",
-				    i, pblocks[i].base,
-				    pblocks[i].size);
-#endif
-			i++;
-			break;
-		default:
-			break;
-		}
-	}
-	pblocks[i].size = 0;
-
-	max_low_pfn = find_max_low_pfn();
-
-	largest = find_largest_memblock();
-	bootmap_size = init_bootmem(largest->base >> PAGE_SHIFT, max_low_pfn);
+		unsigned long base, size;
+		long type;
 
-	for (i = 0; pblocks[i].size; i++)
-		if (pblocks[i].type == MEMTYPE_FREE)
-			free_bootmem(pblocks[i].base, pblocks[i].size);
+		base = __pa(p->base << PAGE_SHIFT);	/* Fix up from KSEG0 */
+		size = p->pages << PAGE_SHIFT;
+		type = prom_memtype_classify(p->type);
 
-	/* This test is simpleminded.  It will fail if the bootmem bitmap
-	   falls into multiple adjacent ARC memory areas.  */
-	if (bootmap_size > largest->size) {
-		prom_printf("CRITIAL: overwriting PROM data.\n");
-		BUG();
+		add_memory_region(base, pages, type);
 	}
-
-	/* Reserve the memory bootmap itself */
-	reserve_bootmem(largest->base, bootmap_size);
-
-	printk("PROMLIB: Total free ram %dK / %dMB.\n",
-	       totram >> 10, totram >> 20);
 }
 
 void __init
 prom_free_prom_memory (void)
 {
+	int i;
 	struct prom_pmemblock *p;
 	unsigned long freed = 0;
 	unsigned long addr;
 
-	for (p = pblocks; p->size != 0; p++) {
-		if (p->type != MEMTYPE_PROM)
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
 			continue;
 
-		addr = PAGE_OFFSET + p->base;
-		while (addr < p->base + p->size) {
-			ClearPageReserved(mem_map + MAP_NR(addr));
-			set_page_count(mem_map + MAP_NR(addr), 1);
-			free_page(addr);
+		addr = boot_mem_map.map[i].addr;
+		while (addr < boot_mem_map.map[i].addr
+			      + boot_mem_map.map[i].size) {
+			ClearPageReserved(mem_map + MAP_NR(__va(addr)));
+			set_page_count(mem_map + MAP_NR(__va(addr)), 1);
+			free_page(__va(addr));
 			addr += PAGE_SIZE;
 			freed += PAGE_SIZE;
 		}
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/baget/prom/init.c linux-mips-2.4.0-test5-20000731/arch/mips/baget/prom/init.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/baget/prom/init.c	Tue Mar 28 04:26:02 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/baget/prom/init.c	Sun Aug 13 20:24:28 2000
@@ -8,7 +8,7 @@
 #include <linux/init.h>
 #include <asm/bootinfo.h>
 
-char arcs_cmdline[CL_SIZE];
+char arcs_cmdline[COMMAND_LINE_SIZE];
 
 int __init prom_init(unsigned int mem_upper)
 {
@@ -17,10 +17,6 @@
 	mips_machtype   = MACH_UNKNOWN;
 	arcs_cmdline[0] = 0;
 	return 0;
-}
-
-void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
-{
 }
 
 void prom_free_prom_memory (void)
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/ddb5074/prom.c linux-mips-2.4.0-test5-20000731/arch/mips/ddb5074/prom.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/ddb5074/prom.c	Thu May 11 04:26:44 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/ddb5074/prom.c	Sun Aug 13 20:24:58 2000
@@ -15,18 +15,11 @@
 #include <asm/bootinfo.h>
 
 
-char arcs_cmdline[CL_SIZE];
-
-extern char _end;
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
+char arcs_cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_init(const char *s)
 {
     int i = 0;
-    unsigned long mem_size, free_start, free_end, start_pfn, bootmap_size;
 
 //  _serinit();
 
@@ -37,24 +30,9 @@
 
     mips_machgroup = MACH_GROUP_NEC_DDB;
     mips_machtype = MACH_NEC_DDB5074;
-    /* 64 MB non-upgradable */
-    mem_size = 64 << 20;
-
-    free_start = PHYSADDR(PFN_ALIGN(&_end));
-    free_end = mem_size;
-    start_pfn = PFN_UP((unsigned long)&_end);
 
-    /* Register all the contiguous memory with the bootmem allocator
-       and free it.  Be careful about the bootmem freemap.  */
-    bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);
-
-    /* Free the entire available memory after the _end symbol.  */
-    free_start += bootmap_size;
-    free_bootmem(free_start, free_end-free_start);
-}
-
-void __init prom_fixup_mem_map(unsigned long start, unsigned long end)
-{
+    /* 64 MB non-upgradable */
+    add_memory_region(0, 64 << 20, BOOT_MEM_RAM);
 }
 
 void __init prom_free_prom_memory(void)
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/ddb5074/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/ddb5074/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/ddb5074/setup.c	Wed Jun 21 04:26:38 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/ddb5074/setup.c	Sun Aug 13 18:40:51 2000
@@ -118,11 +118,6 @@
     panic_timeout = 180;
 }
 
-int __init page_is_ram(unsigned long pagenr)
-{
-    return 1;
-}
-
 
 #define USE_NILE4_SERIAL	0
 
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/prom/cmdline.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/prom/cmdline.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/prom/cmdline.c	Tue Mar 28 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/prom/cmdline.c	Sun Aug 13 16:54:47 2000
@@ -19,7 +19,7 @@
 extern int (*prom_printf)(char *, ...);
 #endif
 
-char arcs_cmdline[CL_SIZE];
+char arcs_cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_init_cmdline(int argc, char **argv, unsigned long magic)
 {
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/prom/memory.c linux-mips-2.4.0-test5-20000731/arch/mips/dec/prom/memory.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/dec/prom/memory.c	Mon Jul 10 04:26:02 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/dec/prom/memory.c	Sun Aug 13 20:49:47 2000
@@ -2,6 +2,7 @@
  * memory.c: memory initialisation code.
  *
  * Copyright (C) 1998 Harald Koerfgen, Frieder Streffer and Paul M. Antoine
+ * Copyright (C) 2000 Maciej W. Rozycki
  *
  * $Id: memory.c,v 1.3 1999/10/09 00:00:58 ralf Exp $
  */
@@ -14,6 +15,8 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 
+#include <asm/bootinfo.h>
+
 #include <asm/dec/machtype.h>
 
 #include "prom.h"
@@ -33,11 +36,6 @@
 
 volatile unsigned long mem_err = 0;	/* So we know an error occured */
 
-extern char _end;
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
 /*
  * Probe memory in 4MB chunks, waiting for an error to tell us we've fallen
  * off the end of real memory.  Only suitable for the 2100/3100's (PMAX).
@@ -45,7 +43,7 @@
 
 #define CHUNK_SIZE 0x400000
 
-unsigned long __init pmax_get_memory_size(void)
+static void __init pmax_setup_memory_region(void)
 {
 	volatile unsigned char *memory_page, dummy;
 	char	old_handler[0x80];
@@ -66,17 +64,19 @@
 		dummy = *memory_page;
 	}
 	memcpy((void *)(KSEG0 + 0x80), &old_handler, 0x80);
-	return (unsigned long)memory_page - KSEG1 - CHUNK_SIZE;
+
+	add_memory_region(0, (unsigned long)memory_page - KSEG1 - CHUNK_SIZE,
+			  BOOT_MEM_RAM);
 }
 
 /*
  * Use the REX prom calls to get hold of the memory bitmap, and thence
  * determine memory size.
  */
-unsigned long __init rex_get_memory_size(void)
+static void __init rex_setup_memory_region(void)
 {
 	int i, bitmap_size;
-	unsigned long mem_size = 0;
+	unsigned long mem_start = 0, mem_size = 0;
 	memmap *bm;
 
 	/* some free 64k */
@@ -88,40 +88,24 @@
 		/* FIXME: very simplistically only add full sets of pages */
 		if (bm->bitmap[i] == 0xff)
 			mem_size += (8 * bm->pagesize);
+		else if (!mem_size)
+			mem_start += (8 * bm->pagesize);
+		else {
+			add_memory_region(mem_start, mem_size, BOOT_MEM_RAM);
+			mem_start += mem_size + (8 * bm->pagesize);
+			mem_size = 0;
+		}
 	}
-
-	return (mem_size);
+	if (mem_size)
+		add_memory_region(mem_start, mem_size, BOOT_MEM_RAM);
 }
 
 void __init prom_meminit(unsigned int magic)
 {
-	unsigned long free_start, free_end, start_pfn, bootmap_size;
-	unsigned long mem_size = 0;
-
 	if (magic != REX_PROM_MAGIC)
-		mem_size = pmax_get_memory_size();
+		pmax_setup_memory_region();
 	else
-		mem_size = rex_get_memory_size();
-
-	free_start = PHYSADDR(PFN_ALIGN(&_end));
-	free_end = mem_size;
-	start_pfn = PFN_UP((unsigned long)&_end);
-
-#ifdef PROM_DEBUG
-	prom_printf("free_start: 0x%08x\n", free_start);
-	prom_printf("free_end: 0x%08x\n", free_end);
-	prom_printf("start_pfn: 0x%08x\n", start_pfn);
-#endif
-
-	/* Register all the contiguous memory with the bootmem allocator
-	   and free it.  Be careful about the bootmem freemap.  */
-	bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);
-	free_bootmem(free_start + bootmap_size, free_end - free_start - bootmap_size);
-}
-
-int __init page_is_ram(unsigned long pagenr)
-{
-        return 1;
+		rex_setup_memory_region();
 }
 
 void prom_free_prom_memory (void)
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/jazz/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/jazz/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/jazz/setup.c	Tue Mar 28 04:26:07 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/jazz/setup.c	Sun Aug 13 18:42:14 2000
@@ -80,11 +80,6 @@
 	i8259_setup_irq(2, &irq2);
 }
 
-int __init page_is_ram(unsigned long pagenr)
-{
-	return 1;
-}
-
 void __init jazz_setup(void)
 {
 	add_wired_entry (0x02000017, 0x03c00017, 0xe0000000, PM_64K);
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/kernel/Makefile linux-mips-2.4.0-test5-20000731/arch/mips/kernel/Makefile
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/kernel/Makefile	Tue Jul 11 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/kernel/Makefile	Sun Aug 13 12:23:32 2000
@@ -6,8 +6,10 @@
 # unless it's something special (ie not a .c file).
 #
 
+.S.s:
+	$(CPP) $(AFLAGS) $< -o $*.o
 .S.o:
-	$(CC) $(CFLAGS) -c $< -o $*.o
+	$(CC) $(AFLAGS) -c $< -o $*.o
 
 all:	kernel.o head.o init_task.o
 EXTRA_ASFLAGS = -mips3 -mcpu=r4000
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/kernel/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/kernel/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/kernel/setup.c	Tue Jul 11 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/kernel/setup.c	Sun Aug 13 20:48:28 2000
@@ -6,6 +6,7 @@
  * Copyright (C) 1995  Linus Torvalds
  * Copyright (C) 1995, 1996, 1997, 1998  Ralf Baechle
  * Copyright (C) 1996  Stoned Elipot
+ * Copyright (C) 2000  Maciej W. Rozycki
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -99,12 +100,14 @@
 unsigned long mips_machtype = MACH_UNKNOWN;
 unsigned long mips_machgroup = MACH_GROUP_UNKNOWN;
 
+struct boot_mem_map boot_mem_map;
+
 unsigned char aux_device_present;
-extern int _end;
+extern char _ftext, _etext, _fdata, _edata, _end;
 
-static char command_line[CL_SIZE] = { 0, };
-       char saved_command_line[CL_SIZE];
-extern char arcs_cmdline[CL_SIZE];
+static char command_line[COMMAND_LINE_SIZE];
+       char saved_command_line[COMMAND_LINE_SIZE];
+extern char arcs_cmdline[COMMAND_LINE_SIZE];
 
 /*
  * The board specific setup routine sets irq_setup to point to a board
@@ -130,6 +133,9 @@
 extern asmlinkage void start_kernel(void);
 extern int prom_init(int, char **, char **, int *);
 
+static struct resource code_resource = { "Kernel code" };
+static struct resource data_resource = { "Kernel data" };
+
 /*
  * Probe whether cpu has config register by trying to play with
  * alternate cache bit and see whether it matters.
@@ -251,6 +257,97 @@
 	panic("Unknown machtype in init_IRQ");
 }
 
+void __init add_memory_region(unsigned long start, unsigned long size,
+			      long type)
+{
+	int x = boot_mem_map.nr_map;
+
+	if (x == BOOT_MEM_MAP_MAX) {
+		printk("Ooops! Too many entries in the memory map!\n");
+		return;
+	}
+
+	boot_mem_map.map[x].addr = start;
+	boot_mem_map.map[x].size = size;
+	boot_mem_map.map[x].type = type;
+	boot_mem_map.nr_map++;
+}
+
+static void __init print_memory_map(void)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		printk(" memory: %08lx @ %08lx ",
+			boot_mem_map.map[i].size, boot_mem_map.map[i].addr);
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+			printk("(usable)\n");
+			break;
+		case BOOT_MEM_ROM_DATA:
+			printk("(ROM data)\n");
+			break;
+		case BOOT_MEM_RESERVED:
+			printk("(reserved)\n");
+			break;
+		default:
+			printk("type %lu\n", boot_mem_map.map[i].type);
+			break;
+		}
+	}
+}
+
+static inline void parse_mem_cmdline(void)
+{
+	char c = ' ', *to = command_line, *from = saved_command_line;
+	unsigned long start_at, mem_size;
+	int len = 0;
+	int usermem = 0;
+
+	printk("Determined physical RAM map:\n");
+	print_memory_map();
+
+	for (;;) {
+		/*
+		 * "mem=XXX[kKmM]" defines a memory region from
+		 * 0 to <XXX>, overriding the determined size.
+		 * "mem=XXX[KkmM]@YYY[KkmM]" defines a memory region from
+		 * <YYY> to <YYY>+<XXX>, overriding the determined size.
+		 */
+		if (c == ' ' && !memcmp(from, "mem=", 4)) {
+			if (to != command_line)
+				to--;
+			/*
+			 * If a user specifies memory size, we
+			 * blow away any automatically generated
+			 * size.
+			 */
+			if (usermem == 0) {
+				boot_mem_map.nr_map = 0;
+				usermem = 1;
+			}
+			mem_size = memparse(from + 4, &from);
+			if (*from == '@')
+				start_at = memparse(from + 1, &from);
+			else
+				start_at = 0;
+			add_memory_region(start_at, mem_size, BOOT_MEM_RAM);
+		}
+		c = *(from++);
+		if (!c)
+			break;
+		if (COMMAND_LINE_SIZE <= ++len)
+			break;
+		*(to++) = c;
+	}
+	*to = '\0';
+
+	if (usermem) {
+		printk("User-defined physical RAM map:\n");
+		print_memory_map();
+	}
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	void baget_setup(void);
@@ -263,6 +360,10 @@
 	void ddb_setup(void);
 	void orion_setup(void);
 
+	unsigned long bootmap_size;
+	unsigned long start_pfn, max_pfn;
+	int i;
+
 	/* Save defaults for configuration-dependent routines.  */
 	irq_setup = default_irq_setup;
 
@@ -327,12 +428,88 @@
 		panic("Unsupported architecture");
 	}
 
-        strncpy (command_line, arcs_cmdline, CL_SIZE);
-	memcpy(saved_command_line, command_line, CL_SIZE);
-	saved_command_line[CL_SIZE-1] = '\0';
-
+	strncpy(command_line, arcs_cmdline, sizeof command_line);
+	command_line[sizeof command_line - 1] = 0;
+	strcpy(saved_command_line, command_line);
 	*cmdline_p = command_line;
 
+	parse_mem_cmdline();
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+	/*
+	 * Partially used pages are not usable - thus
+	 * we are rounding upwards.
+	 */
+	start_pfn = PFN_UP(__pa(&_end));
+
+	/* Find the highest page frame number we have available.  */
+	max_pfn = 0;
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long start, end;
+
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end = PFN_DOWN(boot_mem_map.map[i].addr
+		      + boot_mem_map.map[i].size);
+
+		if (start >= end)
+			continue;
+		if (end > max_pfn)
+			max_pfn = end;
+	}
+
+	/* Initialize the boot-time allocator.  */
+	bootmap_size = init_bootmem(start_pfn, max_pfn);
+
+	/*
+	 * Register fully available low RAM pages with the bootmem allocator.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long curr_pfn, last_pfn, size;
+
+		/*
+		 * Reserve usable memory.
+		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+
+		/*
+		 * We are rounding up the start address of usable memory:
+		 */
+		curr_pfn = PFN_UP(boot_mem_map.map[i].addr);
+		if (curr_pfn >= max_pfn)
+			continue;
+		if (curr_pfn < start_pfn)
+			curr_pfn = start_pfn;
+
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(boot_mem_map.map[i].addr
+				    + boot_mem_map.map[i].size);
+
+		if (last_pfn > max_pfn)
+			last_pfn = max_pfn;
+
+		/*
+		 * ... finally, did all the rounding and playing
+		 * around just make the area go away?
+		 */
+		if (last_pfn <= curr_pfn)
+			continue;
+
+		size = last_pfn - curr_pfn;
+		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
+	}
+
+	/* Reserve the bootmap memory.  */
+	reserve_bootmem(PFN_PHYS(start_pfn), bootmap_size);
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #error "Fixme, I'm broken."
 	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
@@ -354,6 +531,41 @@
 #endif
 
 	paging_init();
+
+	code_resource.start = virt_to_bus(&_ftext);
+	code_resource.end = virt_to_bus(&_etext) - 1;
+	data_resource.start = virt_to_bus(&_fdata);
+	data_resource.end = virt_to_bus(&_edata) - 1;
+
+	/*
+	 * Request address space for all standard RAM.
+	 */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		struct resource *res;
+
+		res = alloc_bootmem(sizeof(struct resource));
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_ROM_DATA:
+			res->name = "System RAM";
+			break;
+		case BOOT_MEM_RESERVED:
+		default:
+			res->name = "reserved";
+		}
+		res->start = boot_mem_map.map[i].addr;
+		res->end = res->start + boot_mem_map.map[i].size - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		request_resource(&iomem_resource, res);
+
+		/*
+		 *  We dont't know which RAM region contains kernel data,
+		 *  so we try it repeatedly and let the resource manager
+		 *  test it.
+		 */
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+	}
 }
 
 void r3081_wait(void) 
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/mm/init.c linux-mips-2.4.0-test5-20000731/arch/mips/mm/init.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/mm/init.c	Mon Jul  3 04:25:56 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/mm/init.c	Sun Aug 13 20:25:18 2000
@@ -41,7 +41,6 @@
 
 static unsigned long totalram_pages = 0;
 
-extern void prom_fixup_mem_map(unsigned long start, unsigned long end);
 extern void prom_free_prom_memory(void);
 
 
@@ -270,7 +269,30 @@
 	free_area_init(zones_size);
 }
 
-extern int page_is_ram(unsigned long pagenr);
+#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+
+static inline int page_is_ram(unsigned long pagenr)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long addr, end;
+
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			/* not usable memory */
+			continue;
+
+		addr = PFN_UP(boot_mem_map.map[i].addr);
+		end = PFN_DOWN(boot_mem_map.map[i].addr
+			       + boot_mem_map.map[i].size);
+
+		if (pagenr >= addr && pagenr < end)
+			return 1;
+	}
+
+	return 0;
+}
 
 void __init mem_init(void)
 {
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/orion/misc.c linux-mips-2.4.0-test5-20000731/arch/mips/orion/misc.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/orion/misc.c	Tue Jul 11 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/orion/misc.c	Thu Jan  1 00:00:00 1970
@@ -1,102 +0,0 @@
-/*
- * Catch-all for Orion-specify code that doesn't fit easily elsewhere.
- *   -- Cort
- */
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/hdreg.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/string.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
-#include <linux/malloc.h>
-#include <linux/user.h>
-#include <linux/utsname.h>
-#include <linux/a.out.h>
-#include <linux/tty.h>
-#ifdef CONFIG_BLK_DEV_RAM
-#include <linux/blk.h>
-#endif
-#include <linux/ide.h>
-#ifdef CONFIG_RTC
-#include <linux/timex.h>
-#endif
-
-#include <asm/asm.h>
-#include <asm/bootinfo.h>
-#include <asm/cachectl.h>
-#include <asm/io.h>
-#include <asm/stackframe.h>
-#include <asm/system.h>
-#include <asm/cpu.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <asm/addrspace.h>
-#include <asm/bootinfo.h>
-#include <asm/mc146818rtc.h>
-
-char arcs_cmdline[CL_SIZE] = {0, };
-extern int _end;
-
-static unsigned char orion_rtc_read_data(unsigned long addr)
-{
-	return 0;
-}
-
-static void orion_rtc_write_data(unsigned char data, unsigned long addr)
-{
-}
-
-static int orion_rtc_bcd_mode(void)
-{
-	return 0;
-}
-
-struct rtc_ops orion_rtc_ops = {
-	&orion_rtc_read_data,
-	&orion_rtc_write_data,
-	&orion_rtc_bcd_mode
-};
-
-extern void InitCIB(void);
-extern void InitQpic(void);
-extern void InitCupid(void);
-
-void __init orion_setup(void)
-{
-	InitCIB();
-	InitQpic();
-	InitCupid();
-}
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
-
-
-int orion_sysinit(void)
-{
-	unsigned long mem_size, free_start, free_end, start_pfn, bootmap_size;
-	
-	mips_machgroup = MACH_GROUP_ORION;
-	/* 64 MB non-upgradable */
-	mem_size = 32 << 20;
-	
-	free_start = PHYSADDR(PFN_ALIGN(&_end));
-	free_end = mem_size;
-	start_pfn = PFN_UP((unsigned long)&_end);
-	
-	/* Register all the contiguous memory with the bootmem allocator
-	   and free it.  Be careful about the bootmem freemap.  */
-	bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);
-	
-	/* Free the entire available memory after the _end symbol.  */
-	free_start += bootmap_size;
-	free_bootmem(free_start, free_end-free_start);
-}
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/orion/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/orion/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/orion/setup.c	Tue Jul 11 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/orion/setup.c	Sun Aug 13 18:57:53 2000
@@ -42,8 +42,7 @@
 #include <asm/mc146818rtc.h>
 #include <asm/orion.h>
 
-char arcs_cmdline[CL_SIZE] = { "console=ttyS0,19200" };
-extern int _end;
+char arcs_cmdline[COMMAND_LINE_SIZE] = { "console=ttyS0,19200" };
 
 static unsigned char orion_rtc_read_data(unsigned long addr)
 {
@@ -83,45 +82,18 @@
 	InitCupid();
 }
 
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
-
-unsigned long mem_size;
 int __init prom_init(int a, char **b, char **c, int *d)
 {
-	unsigned long free_start, free_end, start_pfn, bootmap_size;
 	extern unsigned long orion_initrd_start[], orion_initrd_size;
 
 	mips_machgroup = MACH_GROUP_ORION;
+
 	/* 64 MB non-upgradable */
-	mem_size = 64 << 20;
-	
-	free_start = PHYSADDR(PFN_ALIGN(&_end));
-	free_end = mem_size;
-	start_pfn = PFN_UP((unsigned long)&_end);
-	
-	/* Register all the contiguous memory with the bootmem allocator
-	   and free it.  Be careful about the bootmem freemap.  */
-	bootmap_size = init_bootmem(start_pfn, mem_size >> PAGE_SHIFT);
-	
-	/* Free the entire available memory after the _end symbol.  */
-	free_start += bootmap_size;
-	free_bootmem(free_start, free_end-free_start);
-
-	initrd_start = (ulong)orion_initrd_start;
-	initrd_end = (ulong)orion_initrd_start + (ulong)orion_initrd_size;
-	initrd_below_start_ok = 1;
+	add_memory_region(0, 64 << 20, BOOT_MEM_RAM);
 
 	return 0;
 }
 
 void prom_free_prom_memory (void)
 {
-}
-
-int page_is_ram(unsigned long pagenr)
-{
-	if ( pagenr < (mem_size >> PAGE_SHIFT) )
-		return 1;
-	return 0;
 }
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/sgi/kernel/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/sgi/kernel/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/sgi/kernel/setup.c	Mon Jul 24 04:26:01 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/sgi/kernel/setup.c	Sun Aug 13 18:48:39 2000
@@ -128,15 +128,6 @@
 #endif
 }
 
-int __init page_is_ram(unsigned long pagenr)
-{
-	if (pagenr < MAP_NR(PAGE_OFFSET + 0x2000UL))
-		return 1;
-	if (pagenr > MAP_NR(PAGE_OFFSET + 0x08002000))
-		return 1;
-	return 0;
-}
-
 void (*board_time_init)(struct irqaction *irq);
 
 static unsigned long dosample(volatile unsigned char *tcwp,
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/arch/mips/sni/setup.c linux-mips-2.4.0-test5-20000731/arch/mips/sni/setup.c
--- linux-mips-2.4.0-test5-20000731.macro/arch/mips/sni/setup.c	Wed Jun 21 04:26:41 2000
+++ linux-mips-2.4.0-test5-20000731/arch/mips/sni/setup.c	Sun Aug 13 18:48:47 2000
@@ -101,11 +101,6 @@
 	printk("%s.\n", boardtype);
 }
 
-int __init page_is_ram(unsigned long pagenr)
-{
-	return 1;
-}
-
 void __init sni_rm200_pci_setup(void)
 {
 #if 0 /* XXX Tag me deeper  */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/bootinfo.h linux-mips-2.4.0-test5-20000731/include/asm-mips/bootinfo.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/bootinfo.h	Tue Jul 11 04:26:27 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/bootinfo.h	Sun Aug 13 20:04:00 2000
@@ -1,4 +1,4 @@
-/* $Id: bootinfo.h,v 1.11 2000/03/06 11:14:32 raiko Exp $
+/* $Id: bootinfo.h,v 2.11 2000/03/06 11:14:32 raiko Exp $
  *
  * bootinfo.h -- Definition of the Linux/MIPS boot information structure
  *
@@ -155,9 +155,14 @@
         "R6000A", "R8000", "R10000", "R4300", "R4650", "R4700", "R5000",     \
         "R5000A", "R4640", "Nevada" }
 
-#define CL_SIZE      (80)
+#define COMMAND_LINE_SIZE	256
 
-#ifndef _LANGUAGE_ASSEMBLY
+#define BOOT_MEM_MAP_MAX	32
+#define BOOT_MEM_RAM		1
+#define BOOT_MEM_ROM_DATA	2
+#define BOOT_MEM_RESERVED	3
+
+#ifndef __ASSEMBLY__
 
 /*
  * Some machine parameters passed by the bootloaders. 
@@ -191,6 +196,24 @@
 extern unsigned long mips_machgroup;
 extern unsigned long mips_tlb_entries;
 
-#endif /* _LANGUAGE_ASSEMBLY */
+/*
+ * A memory map that's built upon what was determined
+ * or specified on the command line.
+ */
+struct boot_mem_map {
+	int nr_map;
+	struct {
+		unsigned long addr;	/* start of memory segment */
+		unsigned long size;	/* size of memory segment */
+		long type;		/* type of memory segment */
+	} map[BOOT_MEM_MAP_MAX];
+};
+
+extern struct boot_mem_map boot_mem_map;
+
+extern void add_memory_region(unsigned long start, unsigned long size,
+			      long type);
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_MIPS_BOOTINFO_H */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/sgialib.h linux-mips-2.4.0-test5-20000731/include/asm-mips/sgialib.h
--- linux-mips-2.4.0-test5-20000731.macro/include/asm-mips/sgialib.h	Tue Mar 28 04:27:20 2000
+++ linux-mips-2.4.0-test5-20000731/include/asm-mips/sgialib.h	Sun Aug 13 20:29:14 2000
@@ -30,28 +30,12 @@
 /* Generic printf() using ARCS console I/O. */
 extern void prom_printf(char *fmt, ...);
 
-/* Memory descriptor management. */
-#define PROM_MAX_PMEMBLOCKS    32
-struct prom_pmemblock {
-	unsigned long base; /* Within KSEG0. */
-	unsigned int size;  /* In bytes. */
-        unsigned int type;  /* free or prom memory */
-};
-
-/* Get next memory descriptor after CURR, returns first descriptor
- * in chain is CURR is NULL.
- */
-extern struct linux_mdesc *prom_getmdesc(struct linux_mdesc *curr);
 #define PROM_NULL_MDESC   ((struct linux_mdesc *) 0)
 
 /* Called by prom_init to setup the physical memory pmemblock
  * array.
  */
 extern void prom_meminit(void);
-extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
-
-/* Returns pointer to PROM physical memory block array. */
-extern struct prom_pmemblock *prom_getpblock_array(void);
 
 /* PROM device tree library routines. */
 #define PROM_NULL_COMPONENT ((pcomponent *) 0)
