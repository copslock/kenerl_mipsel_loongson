Received:  by oss.sgi.com id <S553744AbRAPQWZ>;
	Tue, 16 Jan 2001 08:22:25 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:33751 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553682AbRAPQWF>;
	Tue, 16 Jan 2001 08:22:05 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17203;
	Tue, 16 Jan 2001 17:08:26 +0100 (MET)
Date:   Tue, 16 Jan 2001 17:08:26 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <Pine.GSO.3.96.1010116162557.5546J-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1010116170729.5546L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Here is the patch I mentioned earlier.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test12-20010110-mem_map-39
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/arc/memory.c linux-mips-2.4.0-test12-20010110/arch/mips/arc/memory.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/arc/memory.c	Thu Jan  4 05:26:53 2001
+++ linux-mips-2.4.0-test12-20010110/arch/mips/arc/memory.c	Tue Jan 16 01:17:44 2001
@@ -12,6 +12,7 @@
 #include <linux/bootmem.h>
 #include <linux/swap.h>
 
+#include <asm/addrspace.h>
 #include <asm/sgialib.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -120,7 +121,7 @@ void __init prom_meminit(void)
 		unsigned long base, size;
 		long type;
 
-		base = __pa(p->base << PAGE_SHIFT);	/* Fix up from KSEG0 */
+		base = p->base << PAGE_SHIFT;
 		size = p->pages << PAGE_SHIFT;
 		type = prom_memtype_classify(p->type);
 
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/baget/prom/init.c linux-mips-2.4.0-test12-20010110/arch/mips/baget/prom/init.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/baget/prom/init.c	Thu Dec 14 05:26:23 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/baget/prom/init.c	Tue Jan 16 01:00:28 2001
@@ -4,16 +4,22 @@
  * Copyright (C) 1998 Gleb Raiko & Vladimir Roganov 
  */
 #include <linux/init.h>
+#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 char arcs_cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_init(unsigned int mem_upper)
 {
-	mips_memory_upper = mem_upper;
+	mem_upper = PHYSADDR(mem_upper);
+
 	mips_machgroup  = MACH_GROUP_UNKNOWN;
 	mips_machtype   = MACH_UNKNOWN;
 	arcs_cmdline[0] = 0;
+
+	vac_memory_upper = mem_upper;
+
+	add_memory_region(0, mem_upper, BOOT_MEM_RAM);
 }
 
 void prom_free_prom_memory (void)
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/baget/setup.c linux-mips-2.4.0-test12-20010110/arch/mips/baget/setup.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/baget/setup.c	Tue Mar 28 04:26:01 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/baget/setup.c	Tue Jan 16 01:43:10 2001
@@ -14,7 +14,7 @@
 
 #include <asm/baget/baget.h>
 
-extern long mips_memory_upper;
+long int vac_memory_upper;
 
 #define CACHEABLE_STR(val) ((val) ? "not cached" : "cached")
 #define MIN(a,b)           (((a)<(b)) ? (a):(b)) 
@@ -172,7 +172,7 @@ static void __init vac_show(void)
 
 static void __init vac_init(void)
 {
-	unsigned short mem_limit = ((mips_memory_upper-KSEG0) >> 16);
+	unsigned short mem_limit = (vac_memory_upper >> 16);
 
 	switch(vac_inw(VAC_ID)) {
 	case 0x1AC0:
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/galileo-boards/ev64120/setup.c linux-mips-2.4.0-test12-20010110/arch/mips/galileo-boards/ev64120/setup.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/galileo-boards/ev64120/setup.c	Thu Jan  4 05:26:53 2001
+++ linux-mips-2.4.0-test12-20010110/arch/mips/galileo-boards/ev64120/setup.c	Tue Jan 16 00:37:52 2001
@@ -133,7 +133,6 @@ void ev64120_setup(void)
 
 	board_time_init = galileo_time_init;
 	mips_io_port_base = KSEG1;
-	mips_memory_upper = 32 * 1024 * 1024 | KSEG0;
 	set_cp0_status(ST0_FR, 0);
 
 #ifdef CONFIG_L2_L3_CACHE
@@ -174,7 +173,6 @@ void SetUpBootInfo(int argc, char **argv
 	mips_machtype = MACH_EV64120A;
 }
 
-unsigned long mem_size;
 void __init prom_init(int a, char **b, char **c, int *d)
 {
 	unsigned long free_start, free_end, start_pfn, bootmap_size;
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/galileo-boards/ev96100/setup.c linux-mips-2.4.0-test12-20010110/arch/mips/galileo-boards/ev96100/setup.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/galileo-boards/ev96100/setup.c	Mon Nov  6 22:59:55 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/galileo-boards/ev96100/setup.c	Tue Jan 16 00:35:49 2001
@@ -86,9 +86,6 @@ static void __init ev96100_irq_setup(voi
 void __init ev96100_setup(void)
 {
 
-	unsigned long mem_size, free_start, free_end, start_pfn,
-	    bootmap_size;
-
 #ifdef CONFIG_REMOTE_DEBUG
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/arch/mips/mips-boards/generic/memory.c linux-mips-2.4.0-test12-20010110/arch/mips/mips-boards/generic/memory.c
--- linux-mips-2.4.0-test12-20010110.macro/arch/mips/mips-boards/generic/memory.c	Sat Dec 30 05:26:48 2000
+++ linux-mips-2.4.0-test12-20010110/arch/mips/mips-boards/generic/memory.c	Tue Jan 16 01:19:47 2001
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 
+#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/page.h>
 
@@ -135,7 +136,7 @@ void __init prom_meminit(void)
 		long type;
 
 		type = prom_memtype_classify (p->type);
-		base = __pa(p->base);			/* Fix up from KSEG0 */
+		base = PHYSADDR(p->base);		/* Fix up from KSEG0 */
 		size = p->size;
 
 		add_memory_region(base, size, type);
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/addrspace.h linux-mips-2.4.0-test12-20010110/include/asm-mips/addrspace.h
--- linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/addrspace.h	Sat Aug 26 04:26:45 2000
+++ linux-mips-2.4.0-test12-20010110/include/asm-mips/addrspace.h	Tue Jan 16 01:04:14 2001
@@ -24,7 +24,7 @@
  * Returns the kernel segment base of a given address
  */
 #ifndef __ASSEMBLY__
-#define KSEGX(a)                (((unsigned long)(a)) & 0xe0000000)
+#define KSEGX(a)                ((__typeof__(a))(((unsigned long)(a) & 0xe0000000)))
 #else
 #define KSEGX(a)                ((a) & 0xe0000000)
 #endif
@@ -33,7 +33,7 @@
  * Returns the physical address of a KSEG0/KSEG1 address
  */
 #ifndef __ASSEMBLY__
-#define PHYSADDR(a)		(((unsigned long)(a)) & 0x1fffffff)
+#define PHYSADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x1fffffff)))
 #else
 #define PHYSADDR(a)		((a) & 0x1fffffff)
 #endif
