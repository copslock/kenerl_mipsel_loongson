Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6TESiRw002300
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 29 Jul 2002 07:28:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6TESi2F002299
	for linux-mips-outgoing; Mon, 29 Jul 2002 07:28:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6TERkRw002275
	for <linux-mips@oss.sgi.com>; Mon, 29 Jul 2002 07:27:47 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA26325;
	Mon, 29 Jul 2002 16:29:35 +0200 (MET DST)
Date: Mon, 29 Jul 2002 16:29:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: [update] [patch] linux: Cache coherency fixes
In-Reply-To: <Pine.GSO.3.96.1020705170554.11897A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020729161214.22288H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-9.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 The following patch fixes all the places the default caching policy is
used but various local hacks are coded.  Also the sc coherency algorithm
is configured for R4k processors which was previously left as set (or not)
by the firmware.  A side effect is <asm-mips64/pgtable-bits.h> is created
and all conditional CPU options are set somehow.  Tested on an R4400SC
(for both MIPS and MIPS64) and on an R3400. 

 Admittedly, CONF_CM_DEFAULT is defined in a bit weird way, but I couldn't
figure any better one that wouldn't result in a serious but unnecessary
header bloat.  If anyone has a better idea, please share any suggestions
here.

 OK to apply?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020726-cache-coherency-5
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/config-shared.in linux-mips-2.4.19-rc1-20020726/arch/mips/config-shared.in
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/config-shared.in	2002-07-25 20:11:36.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/config-shared.in	2002-07-27 22:14:21.000000000 +0000
@@ -403,6 +403,10 @@ fi
 if [ "$CONFIG_MIPS_AU1000" != "y" ]; then
    define_bool CONFIG_MIPS_AU1000 n
 fi
+
+if [ "$CONFIG_SMP" != "y" ]; then
+   define_bool CONFIG_SMP n
+fi
 endmenu
 
 mainmenu_option next_comment
@@ -492,6 +496,17 @@ if [ "$CONFIG_CPU_R3000" = "y" ]; then
 else
    define_bool CONFIG_CPU_HAS_SYNC y
 fi
+if [ "$CONFIG_CPU_R4X00" = "y" -o "$CONFIG_CPU_SB1" = "y" ]; then
+   define_bool CONFIG_CPU_CACHE_COHERENCY $CONFIG_SMP
+else
+   define_bool CONFIG_CPU_CACHE_COHERENCY n
+fi
+if [ "$CONFIG_VTAG_ICACHE" != "y" ]; then
+   define_bool CONFIG_VTAG_ICACHE n
+fi
+if [ "$CONFIG_CPU_HAS_PREFETCH" != "y" ]; then
+   define_bool CONFIG_CPU_HAS_PREFETCH n
+fi
 endmenu
 
 mainmenu_option next_comment
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-mips32.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-mips32.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-mips32.c	2002-05-30 02:57:43.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-mips32.c	2002-07-27 22:59:42.000000000 +0000
@@ -657,11 +657,7 @@ void __init ld_mmu_mips32(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
 
-#ifdef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-#else
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-r4k.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-r4k.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-r4k.c	2002-07-15 02:57:47.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-r4k.c	2002-07-27 22:59:22.000000000 +0000
@@ -1480,11 +1480,7 @@ void __init ld_mmu_r4xx0(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
 
-#ifdef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-#else
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
+	change_cp0_config(CONF_CM_CMASK | CONF_CU, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-r5432.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-r5432.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-r5432.c	2001-12-01 05:26:01.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-r5432.c	2002-07-27 23:01:23.000000000 +0000
@@ -455,7 +455,7 @@ void __init ld_mmu_r5432(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
 
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-rm7k.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-rm7k.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-rm7k.c	2002-05-30 02:57:46.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-rm7k.c	2002-07-27 23:02:21.000000000 +0000
@@ -319,9 +319,7 @@ void __init ld_mmu_rm7k(void)
 			: "r" (addr), "i" (Index_Store_Tag_I), "i" (Fill));
 	}
 
-#ifndef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-sb1.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-sb1.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-sb1.c	2002-05-30 02:57:46.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-sb1.c	2002-07-27 23:04:17.000000000 +0000
@@ -519,6 +519,6 @@ void ld_mmu_sb1(void)
 	_flush_cache_sigtramp = sb1_flush_cache_sigtramp;
 	_flush_icache_all = sb1_flush_icache_all;
 
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_COW);
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 	flush_cache_all();
 }
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-tx49.c linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-tx49.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips/mm/c-tx49.c	2002-05-30 02:57:46.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips/mm/c-tx49.c	2002-07-27 23:05:01.000000000 +0000
@@ -387,11 +387,7 @@ void __init ld_mmu_tx49(void)
 	if (mips_configk0 != -1)
 		change_cp0_config(CONF_CM_CMASK, mips_configk0);
 	else
-#ifdef CONFIG_MIPS_UNCACHED
-		change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-#else
-		change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
+		change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/c-mips64.c linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/c-mips64.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/c-mips64.c	2002-07-24 16:12:11.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/c-mips64.c	2002-07-27 23:07:05.000000000 +0000
@@ -654,11 +654,7 @@ void __init ld_mmu_mips64(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
 
-#ifdef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-#else
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/c-sb1.c linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/c-sb1.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/c-sb1.c	2002-05-30 02:57:51.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/c-sb1.c	2002-07-27 23:07:42.000000000 +0000
@@ -518,6 +518,6 @@ void ld_mmu_sb1(void)
 	_flush_cache_sigtramp = sb1_flush_cache_sigtramp;
 	_flush_icache_all = sb1_flush_icache_all;
 
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_COW);
+	change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 	flush_cache_all();
 }
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/r4xx0.c linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/r4xx0.c
--- linux-mips-2.4.19-rc1-20020726.macro/arch/mips64/mm/r4xx0.c	2002-06-20 02:57:39.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/arch/mips64/mm/r4xx0.c	2002-07-27 23:09:09.000000000 +0000
@@ -2268,11 +2268,7 @@ void __init ld_mmu_r4xx0(void)
 {
 	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
 
-#ifdef CONFIG_MIPS_UNCACHED
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-#else
-	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
-#endif /* UNCACHED */
+	change_cp0_config(CONF_CM_CMASK | CONF_CU, CONF_CM_DEFAULT);
 
 	probe_icache(config);
 	probe_dcache(config);
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips/mipsregs.h linux-mips-2.4.19-rc1-20020726/include/asm-mips/mipsregs.h
--- linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips/mipsregs.h	2002-07-21 19:21:19.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/include/asm-mips/mipsregs.h	2002-07-27 22:57:03.000000000 +0000
@@ -374,6 +374,7 @@
 #define CONF_CM_CACHABLE_CUW		6
 #define CONF_CM_CACHABLE_ACCELERATED	7
 #define CONF_CM_CMASK			7
+#define CONF_CU				(1 <<  3)
 #define CONF_DB				(1 <<  4)
 #define CONF_IB				(1 <<  5)
 #define CONF_SC				(1 << 17)
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips/pgtable-bits.h linux-mips-2.4.19-rc1-20020726/include/asm-mips/pgtable-bits.h
--- linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips/pgtable-bits.h	2002-06-30 17:18:30.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/include/asm-mips/pgtable-bits.h	2002-07-27 23:00:05.000000000 +0000
@@ -12,7 +12,8 @@
 
 #include <linux/config.h>
 
-/* Note that we shift the lower 32bits of each EntryLo[01] entry
+/*
+ * Note that we shift the lower 32bits of each EntryLo[01] entry
  * 6 bits to the left. That way we can convert the PFN into the
  * physical address by a single 'and' operation and gain 6 additional
  * bits for storing information which isn't present in a normal
@@ -74,9 +75,9 @@
 #define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
 #define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
 #define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00 only           */
+#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00MC only         */
 #define _CACHE_UNCACHED_ACCELERATED (7<<9)  /* R10000 only             */
 
 #endif
@@ -87,12 +88,21 @@
 
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
 
-#ifdef CONFIG_MIPS_UNCACHED
+
+#if defined(CONFIG_MIPS_UNCACHED)
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_UNCACHED
-#elif CONFIG_CPU_SB1
+
+#elif defined(CONFIG_CPU_CACHE_COHERENCY)
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
+
 #else
+
 #define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_NONCOHERENT
+
 #endif
 
+#define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 9)
+
 #endif /* _ASM_CACHINGMODES_H */
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/mipsregs.h linux-mips-2.4.19-rc1-20020726/include/asm-mips64/mipsregs.h
--- linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/mipsregs.h	2002-06-29 03:02:05.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/include/asm-mips64/mipsregs.h	2002-07-27 22:57:22.000000000 +0000
@@ -374,6 +374,7 @@
 #define CONF_CM_CACHABLE_CUW		6
 #define CONF_CM_CACHABLE_ACCELERATED	7
 #define CONF_CM_CMASK			7
+#define CONF_CU				(1 <<  3)
 #define CONF_DB				(1 <<  4)
 #define CONF_IB				(1 <<  5)
 #define CONF_SC				(1 << 17)
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/pgtable-bits.h linux-mips-2.4.19-rc1-20020726/include/asm-mips64/pgtable-bits.h
--- linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/pgtable-bits.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/include/asm-mips64/pgtable-bits.h	2002-07-27 23:00:24.000000000 +0000
@@ -0,0 +1,79 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 2001 by Ralf Baechle at alii
+ * Copyright (C) 1999, 2000, 2001 Silicon Graphics, Inc.
+ * Copyright (C) 2002  Maciej W. Rozycki
+ */
+#ifndef __ASM_MIPS64_PGTABLE_BITS_H
+#define __ASM_MIPS64_PGTABLE_BITS_H
+
+#include <linux/config.h>
+
+/*
+ * Note that we shift the lower 32bits of each EntryLo[01] entry
+ * 6 bits to the left. That way we can convert the PFN into the
+ * physical address by a single 'and' operation and gain 6 additional
+ * bits for storing information which isn't present in a normal
+ * MIPS page table.
+ *
+ * Similar to the Alpha port, we need to keep track of the ref
+ * and mod bits in software.  We have a software "yeah you can read
+ * from this page" bit, and a hardware one which actually lets the
+ * process read from the page.  On the same token we have a software
+ * writable bit and the real hardware one which actually lets the
+ * process write to the page, this keeps a mod bit via the hardware
+ * dirty bit.
+ *
+ * Certain revisions of the R4000 and R5000 have a bug where if a
+ * certain sequence occurs in the last 3 instructions of an executable
+ * page, and the following page is not mapped, the cpu can do
+ * unpredictable things.  The code (when it is written) to deal with
+ * this problem will be in the update_mmu_cache() code for the r4k.
+ */
+#define _PAGE_PRESENT               (1<<0)  /* implemented in software */
+#define _PAGE_READ                  (1<<1)  /* implemented in software */
+#define _PAGE_WRITE                 (1<<2)  /* implemented in software */
+#define _PAGE_ACCESSED              (1<<3)  /* implemented in software */
+#define _PAGE_MODIFIED              (1<<4)  /* implemented in software */
+#define _PAGE_R4KBUG                (1<<5)  /* workaround for r4k bug  */
+#define _PAGE_GLOBAL                (1<<6)
+#define _PAGE_VALID                 (1<<7)
+#define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
+#define _PAGE_DIRTY                 (1<<8)  /* The MIPS dirty bit      */
+#define _PAGE_SILENT_WRITE          (1<<8)
+#define _CACHE_CACHABLE_NO_WA       (0<<9)  /* R4600 only              */
+#define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
+#define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
+#define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
+#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00MC only         */
+#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00MC only         */
+#define _CACHE_UNCACHED_ACCELERATED (7<<9)  /* R10000 only             */
+#define _CACHE_MASK                 (7<<9)
+
+#define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
+#define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
+
+#define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
+
+
+#if defined(CONFIG_MIPS_UNCACHED)
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_UNCACHED
+
+#elif defined(CONFIG_CPU_CACHE_COHERENCY)
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_COW
+
+#else
+
+#define PAGE_CACHABLE_DEFAULT	_CACHE_CACHABLE_NONCOHERENT
+
+#endif
+
+#define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT >> 9)
+
+#endif /* __ASM_MIPS64_PGTABLE_BITS_H */
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/pgtable.h linux-mips-2.4.19-rc1-20020726/include/asm-mips64/pgtable.h
--- linux-mips-2.4.19-rc1-20020726.macro/include/asm-mips64/pgtable.h	2002-07-08 16:46:37.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020726/include/asm-mips64/pgtable.h	2002-07-27 23:31:48.000000000 +0000
@@ -155,64 +155,9 @@ extern void (*_flush_icache_page)(struct
 #define VMALLOC_END	\
 	(VMALLOC_START + ((1 << PGD_ORDER) * PTRS_PER_PTE * PAGE_SIZE))
 
-/*
- * Note that we shift the lower 32bits of each EntryLo[01] entry
- * 6 bits to the left. That way we can convert the PFN into the
- * physical address by a single 'and' operation and gain 6 additional
- * bits for storing information which isn't present in a normal
- * MIPS page table.
- *
- * Similar to the Alpha port, we need to keep track of the ref
- * and mod bits in software.  We have a software "yeah you can read
- * from this page" bit, and a hardware one which actually lets the
- * process read from the page.  On the same token we have a software
- * writable bit and the real hardware one which actually lets the
- * process write to the page, this keeps a mod bit via the hardware
- * dirty bit.
- *
- * Certain revisions of the R4000 and R5000 have a bug where if a
- * certain sequence occurs in the last 3 instructions of an executable
- * page, and the following page is not mapped, the cpu can do
- * unpredictable things.  The code (when it is written) to deal with
- * this problem will be in the update_mmu_cache() code for the r4k.
- */
-#define _PAGE_PRESENT               (1<<0)  /* implemented in software */
-#define _PAGE_READ                  (1<<1)  /* implemented in software */
-#define _PAGE_WRITE                 (1<<2)  /* implemented in software */
-#define _PAGE_ACCESSED              (1<<3)  /* implemented in software */
-#define _PAGE_MODIFIED              (1<<4)  /* implemented in software */
-#define _PAGE_R4KBUG                (1<<5)  /* workaround for r4k bug  */
-#define _PAGE_GLOBAL                (1<<6)
-#define _PAGE_VALID                 (1<<7)
-#define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
-#define _PAGE_DIRTY                 (1<<8)  /* The MIPS dirty bit      */
-#define _PAGE_SILENT_WRITE          (1<<8)
-#define _CACHE_CACHABLE_NO_WA       (0<<9)  /* R4600 only              */
-#define _CACHE_CACHABLE_WA          (1<<9)  /* R4600 only              */
-#define _CACHE_UNCACHED             (2<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_NONCOHERENT (3<<9)  /* R4[0246]00              */
-#define _CACHE_CACHABLE_CE          (4<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_COW         (5<<9)  /* R4[04]00 only           */
-#define _CACHE_CACHABLE_CUW         (6<<9)  /* R4[04]00 only           */
-#define _CACHE_UNCACHED_ACCELERATED (7<<9)  /* R10000 only             */
-#define _CACHE_MASK                 (7<<9)
-
-#define __READABLE	(_PAGE_READ | _PAGE_SILENT_READ | _PAGE_ACCESSED)
-#define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
-
-#define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
-
-#ifdef CONFIG_MIPS_UNCACHED
-#define PAGE_CACHABLE_DEFAULT _CACHE_UNCACHED
-#else /* ! UNCACHED */
-#ifdef CONFIG_SGI_IP22
-#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
-#else /* ! IP22 */
-#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_COW
-#endif /* IP22 */
-#endif /* UNCACHED */
+#include <asm/pgtable-bits.h>
 
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | PAGE_CACHABLE_DEFAULT)
+#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
 #define PAGE_SHARED     __pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 			PAGE_CACHABLE_DEFAULT)
 #define PAGE_COPY       __pgprot(_PAGE_PRESENT | _PAGE_READ | \
@@ -222,7 +167,7 @@ extern void (*_flush_icache_page)(struct
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 			_PAGE_GLOBAL | PAGE_CACHABLE_DEFAULT)
 #define PAGE_USERIO     __pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
-			_CACHE_UNCACHED)
+			PAGE_CACHABLE_DEFAULT)
 #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
 			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
 
