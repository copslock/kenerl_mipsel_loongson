Received:  by oss.sgi.com id <S554140AbRA0I6a>;
	Sat, 27 Jan 2001 00:58:30 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:11774 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554137AbRA0I6T>;
	Sat, 27 Jan 2001 00:58:19 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA00684;
	Sat, 27 Jan 2001 09:58:39 +0100 (MET)
Date:   Sat, 27 Jan 2001 09:58:38 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: A few memory map updates
Message-ID: <Pine.GSO.3.96.1010127095516.29150G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 Below is a patch that cleans-up a few remaining memory map bits.  Please
apply.  Thanks.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-20010126-mem_map-42
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/baget/prom/init.c linux-mips-2.4.0-20010126/arch/mips/baget/prom/init.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/baget/prom/init.c	Thu Dec 14 05:26:23 2000
+++ linux-mips-2.4.0-20010126/arch/mips/baget/prom/init.c	Tue Jan 16 01:00:28 2001
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
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/baget/setup.c linux-mips-2.4.0-20010126/arch/mips/baget/setup.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/baget/setup.c	Tue Mar 28 04:26:01 2000
+++ linux-mips-2.4.0-20010126/arch/mips/baget/setup.c	Tue Jan 16 01:43:10 2001
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
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/galileo-boards/ev64120/setup.c linux-mips-2.4.0-20010126/arch/mips/galileo-boards/ev64120/setup.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/galileo-boards/ev64120/setup.c	Thu Jan  4 05:26:53 2001
+++ linux-mips-2.4.0-20010126/arch/mips/galileo-boards/ev64120/setup.c	Tue Jan 16 00:37:52 2001
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
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/galileo-boards/ev96100/setup.c linux-mips-2.4.0-20010126/arch/mips/galileo-boards/ev96100/setup.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/galileo-boards/ev96100/setup.c	Mon Nov  6 22:59:55 2000
+++ linux-mips-2.4.0-20010126/arch/mips/galileo-boards/ev96100/setup.c	Tue Jan 16 00:35:49 2001
@@ -86,9 +86,6 @@ static void __init ev96100_irq_setup(voi
 void __init ev96100_setup(void)
 {
 
-	unsigned long mem_size, free_start, free_end, start_pfn,
-	    bootmap_size;
-
 #ifdef CONFIG_REMOTE_DEBUG
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
diff -up --recursive --new-file linux-mips-2.4.0-20010126.macro/arch/mips/mips-boards/generic/memory.c linux-mips-2.4.0-20010126/arch/mips/mips-boards/generic/memory.c
--- linux-mips-2.4.0-20010126.macro/arch/mips/mips-boards/generic/memory.c	Sat Dec 30 05:26:48 2000
+++ linux-mips-2.4.0-20010126/arch/mips/mips-boards/generic/memory.c	Fri Jan 26 22:04:35 2001
@@ -135,7 +135,7 @@ void __init prom_meminit(void)
 		long type;
 
 		type = prom_memtype_classify (p->type);
-		base = __pa(p->base);			/* Fix up from KSEG0 */
+		base = p->base;
 		size = p->size;
 
 		add_memory_region(base, size, type);
