Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7ACXvRw003260
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 10 Aug 2002 05:33:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7ACXvkL003259
	for linux-mips-outgoing; Sat, 10 Aug 2002 05:33:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7ACXJRw003245
	for <linux-mips@oss.sgi.com>; Sat, 10 Aug 2002 05:33:23 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g7ACZRui031503
	for <linux-mips@oss.sgi.com>; Sat, 10 Aug 2002 14:35:27 +0200
Message-ID: <3D55088F.4020503@murphy.dk>
Date: Sat, 10 Aug 2002 14:35:27 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: [PATCH 2.4] R5000 secondary cache support
Content-Type: multipart/mixed;
 boundary="------------090100090209060001070007"
X-Spam-Status: No, hits=-4.3 required=5.0 tests=TO_LOCALPART_EQ_REAL,PORN_10,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------090100090209060001070007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have (re)implimented R5000 secondary cache support as a board cache 
with the attached
patch. Comments are welcome.

/Brian

--------------090100090209060001070007
Content-Type: text/plain;
 name="r5k-sc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r5k-sc.patch"

Index: include/asm-mips/mipsregs.h
===================================================================
RCS file: /cvs/linux-mips/include/asm-mips/mipsregs.h,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- include/asm-mips/mipsregs.h	18 Jul 2002 17:34:00 -0000	1.1.1.1
+++ include/asm-mips/mipsregs.h	10 Aug 2002 11:51:38 -0000	1.2
@@ -376,6 +376,7 @@
 #define CONF_CM_CMASK			7
 #define CONF_DB				(1 <<  4)
 #define CONF_IB				(1 <<  5)
+#define CONF_SE 			(1 << 12)
 #define CONF_SC				(1 << 17)
 #define CONF_AC                         (1 << 23)
 #define CONF_HALT                       (1 << 25)
Index: include/asm-mips/cacheops.h
===================================================================
RCS file: /cvs/linux-mips/include/asm-mips/cacheops.h,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- include/asm-mips/cacheops.h	18 Jul 2002 17:34:01 -0000	1.1.1.1
+++ include/asm-mips/cacheops.h	18 Jul 2002 17:41:35 -0000	1.2
@@ -35,6 +35,7 @@
 #define Hit_Writeback_Inv_D	0x15
 					/* 0x16 is unused */
 #define Hit_Writeback_Inv_SD	0x17
+#define Page_Invalidate		0x17
 #define Hit_Writeback_I		0x18
 #define Hit_Writeback_D		0x19
 					/* 0x1a is unused */
Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux-mips/arch/mips/mm/c-r4k.c,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- arch/mips/mm/c-r4k.c	18 Jul 2002 17:35:18 -0000	1.1.1.1
+++ arch/mips/mm/c-r4k.c	10 Aug 2002 11:47:56 -0000	1.3
@@ -1457,6 +1457,8 @@
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
 }
 
+extern void r5k_sc_init(void);
+
 typedef int (*probe_func_t)(unsigned long);
 
 static inline void __init setup_scache(unsigned int config)
@@ -1469,7 +1471,13 @@
 	sc_present = probe_scache_kseg1(config);
 
 	if (sc_present) {
-		setup_scache_funcs();
+#ifdef CONFIG_CPU_R5000
+		if (mips_cpu.cputype == CPU_R5000) {
+			setup_noscache_funcs();
+			r5k_sc_init();
+		} else
+#endif
+			setup_scache_funcs();
 		return;
 	}
 
Index: arch/mips/mm/r5k-sc.c
===================================================================
RCS file: arch/mips/mm/r5k-sc.c
diff -N arch/mips/mm/r5k-sc.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ arch/mips/mm/r5k-sc.c	10 Aug 2002 11:48:23 -0000	1.1
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 1997, 2001 Ralf Baechle (ralf@gnu.org),
+ * derived from r4xx0.c by David S. Miller (dm@engr.sgi.com).
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/mipsregs.h>
+#include <asm/bcache.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/cacheops.h>
+
+/* Secondary cache size in bytes, if present.  */
+static unsigned long scache_size;
+
+#define SC_LINE 32
+
+#define cache_unroll(base,op)                   \
+__asm__ __volatile__("				\
+		.set noreorder;                 \
+		.set mips3;                     \
+		cache %1, (%0);                 \
+		.set mips0;                     \
+		.set reorder"                   \
+		:                               \
+		: "r" (base),                   \
+		  "i" (op));
+
+static inline void blast_r5000_scache(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = KSEG0 + scache_size;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*SC_LINE;
+	}
+}
+
+static inline void blast_r5000_scache_page_indexed(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*SC_LINE;
+	}
+}
+
+static void
+r5k_dma_cache_inv_sc(unsigned long addr, unsigned long size)
+{
+	unsigned long end, a;
+
+	if (size >= scache_size) {
+		blast_r5000_scache();
+		return;
+	}
+
+	/* We assume the address is in KSEG0. On the R5000 we
+	* cannot invalidate less than a page at a time, and
+	* there is no Hit_xxx cache operations.
+	*/
+	a = addr & ~(PAGE_SIZE - 1);
+	end = (addr + size - 1) & ~(PAGE_SIZE - 1);
+	while (a <= end) {
+		blast_r5000_scache_page_indexed(a);     /* Page_Invalidate */
+		a += PAGE_SIZE;
+	}
+}
+
+static void r5k_sc_enable(void)
+{
+        unsigned long flags;
+
+	__save_and_cli(flags);
+	change_cp0_config(CONF_SE, CONF_SE);
+	blast_r5000_scache();
+	__restore_flags(flags);
+}
+
+static void r5k_sc_disable(void)
+{
+        unsigned long flags;
+
+	__save_and_cli(flags);
+	blast_r5000_scache();
+	change_cp0_config(CONF_SE, 0);
+	__restore_flags(flags);
+}
+
+static inline int __init r5k_sc_probe(void)
+{
+	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);
+
+	if(config & CONF_SC)
+		return(0);
+
+	scache_size = (512*1024) << ((config >> 20)&3);
+
+	printk("R5000 SCACHE size %ldK, linesize 32 bytes.\n",
+			scache_size >> 10);
+
+	return 1;
+}
+
+struct bcache_ops r5k_sc_ops = {
+	r5k_sc_enable,
+	r5k_sc_disable,
+	r5k_dma_cache_inv_sc,
+	r5k_dma_cache_inv_sc
+};
+
+void __init r5k_sc_init(void)
+{
+	if (r5k_sc_probe()) {
+		r5k_sc_enable();
+		bcops = &r5k_sc_ops;
+	}
+}
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /cvs/linux-mips/arch/mips/mm/Makefile,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/mips/mm/Makefile	18 Jul 2002 17:35:18 -0000	1.1.1.1
+++ arch/mips/mm/Makefile	10 Aug 2002 11:48:30 -0000	1.2
@@ -20,7 +20,8 @@
 obj-$(CONFIG_CPU_R4300)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o \
+				   r5k-sc.o
 obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux-mips/arch/mips/config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.5
diff -u -r1.1.1.1 -r1.5
--- arch/mips/config.in	18 Jul 2002 17:35:15 -0000	1.1.1.1
+++ arch/mips/config.in	10 Aug 2002 11:49:49 -0000	1.5
@@ -382,6 +395,10 @@
 	 MIPS32	CONFIG_CPU_MIPS32 \
 	 MIPS64	CONFIG_CPU_MIPS64" R4x00
 
+if [ "$CONFIG_CPU_R5000"  = "y" ]; then
+   define_bool CONFIG_BOARD_SCACHE y
+if
+  
 if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
    define_bool CONFIG_CPU_HAS_PREFETCH y
    bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE

--------------090100090209060001070007--
