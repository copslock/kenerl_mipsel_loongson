Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7JBnYRw005450
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 19 Aug 2002 04:49:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7JBnYCY005449
	for linux-mips-outgoing; Mon, 19 Aug 2002 04:49:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from brian.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7JBmjRw005425
	for <linux-mips@oss.sgi.com>; Mon, 19 Aug 2002 04:48:46 -0700
Received: from brm by brian.localnet with local (Exim 3.32 #1 (Debian))
	id 17gl4G-0002Za-00; Mon, 19 Aug 2002 13:51:32 +0200
To: linux-mips@oss.sgi.com
Subject: [PATCH 2.4] r5k Secondary Cache support
Cc: vivien.chappelier@enst-bretagne.fr
Message-Id: <E17gl4G-0002Za-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Mon, 19 Aug 2002 13:51:32 +0200
X-Spam-Status: No, hits=-4.9 required=5.0 tests=PORN_10,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have changed the patch slightly so that the nevada cpu is also 
supported. Should this be patched onto mips64 too?

/Brian

Index: arch/mips/mm/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.27.2.1
diff -u -r1.27.2.1 Makefile
--- arch/mips/mm/Makefile	2002/06/25 15:47:00	1.27.2.1
+++ arch/mips/mm/Makefile	2002/08/19 11:33:28
@@ -20,8 +20,10 @@
 obj-$(CONFIG_CPU_R4300)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
-obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o \
+				   r5k-sc.o
+obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o \
+				   r5k-sc.o
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R10000)	+= pg-andes.o c-andes.o tlb-r4k.o tlbex-r4k.o
Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.3.2.6
diff -u -r1.3.2.6 c-r4k.c
--- arch/mips/mm/c-r4k.c	2002/08/09 06:04:48	1.3.2.6
+++ arch/mips/mm/c-r4k.c	2002/08/19 11:33:30
@@ -1451,7 +1451,9 @@
 	_dma_cache_inv = r4k_dma_cache_inv_sc;
 }
 
+
 typedef int (*probe_func_t)(unsigned long);
+extern void r5k_sc_init(void);
 
 static inline void __init setup_scache(unsigned int config)
 {
@@ -1462,12 +1464,24 @@
 	probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
 	sc_present = probe_scache_kseg1(config);
 
-	if (sc_present) {
-		setup_scache_funcs();
+	if (!sc_present) {
+		setup_noscache_funcs();
 		return;
 	}
+
+	switch(mips_cpu.cputype) {
+	case CPU_R5000:
+	case CPU_NEVADA:
+			setup_noscache_funcs();
+#if defined(CONFIG_CPU_R5000) || defined(CONFIG_CPU_NEVADA)
+			r5k_sc_init();
+#endif
+			break;
+	default:
+			setup_scache_funcs();
+	}
+
 
-	setup_noscache_funcs();
 }
 
 void __init ld_mmu_r4xx0(void)
Index: arch/mips/config-shared.in
===================================================================
RCS file: /cvs/linux/arch/mips/config-shared.in,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 config-shared.in
--- arch/mips/config-shared.in	2002/08/15 18:42:02	1.1.2.10
+++ arch/mips/config-shared.in	2002/08/19 11:33:30
@@ -428,6 +428,14 @@
 	 RM7000	CONFIG_CPU_RM7000 \
 	 SB1	CONFIG_CPU_SB1" R4x00
 
+if [ "$CONFIG_CPU_R5000" = "y" ]; then
+   define_bool CONFIG_BOARD_SCACHE y
+fi
+
+if [ "$CONFIG_CPU_NEVADA" = "y" ]; then
+   define_bool CONFIG_BOARD_SCACHE y
+fi
+ 
 if [ "$CONFIG_CPU_MIPS32" = "y" ]; then
    define_bool CONFIG_CPU_HAS_PREFETCH y
    bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE
@@ -517,35 +525,35 @@
 fi
 
 if [ "$CONFIG_CPU_R10000" = "y" ]; then
-   dep_bool 'Support for large 64-bit configurations' CONFIG_MIPS_INSANE_LARGE $CONFIG_MIPS64
+dep_bool 'Support for large 64-bit configurations' CONFIG_MIPS_INSANE_LARGE $CONFIG_MIPS64
 fi
 
 if [ "$CONFIG_ARC32" = "y" ]; then
-   bool 'ARC console support' CONFIG_ARC_CONSOLE
+bool 'ARC console support' CONFIG_ARC_CONSOLE
 fi
 
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
-   dep_bool 'Indigo-2 (IP22) EISA bus support' CONFIG_IP22_EISA $CONFIG_EXPERIMENTAL
+dep_bool 'Indigo-2 (IP22) EISA bus support' CONFIG_IP22_EISA $CONFIG_EXPERIMENTAL
 fi
 
 if [ "$CONFIG_IP22_EISA" = "y" ]; then
-   define_bool CONFIG_EISA y
-   bool '    ISA bus support' CONFIG_ISA
+define_bool CONFIG_EISA y
+bool '    ISA bus support' CONFIG_ISA
 fi
 
 bool 'Networking support' CONFIG_NET
 
 if [ "$CONFIG_PCI" != "y" ]; then
-   define_bool CONFIG_PCI n
+define_bool CONFIG_PCI n
 fi
 
 source drivers/pci/Config.in
 
 if [ "$CONFIG_ISA" != "y" ]; then
-   define_bool CONFIG_ISA n
-   define_bool CONFIG_EISA n
+define_bool CONFIG_ISA n
+define_bool CONFIG_EISA n
 else
-   define_bool CONFIG_EISA y
+define_bool CONFIG_EISA y
 fi
 
 dep_bool 'TURBOchannel support' CONFIG_TC $CONFIG_DECSTATION
@@ -557,11 +565,11 @@
 bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
-   source drivers/pcmcia/Config.in
-   source drivers/hotplug/Config.in
+source drivers/pcmcia/Config.in
+source drivers/hotplug/Config.in
 else
-   define_bool CONFIG_PCMCIA n
-   define_bool CONFIG_HOTPLUG_PCI n
+define_bool CONFIG_PCMCIA n
+define_bool CONFIG_HOTPLUG_PCI n
 fi
 
 bool 'System V IPC' CONFIG_SYSVIPC
@@ -587,16 +595,16 @@
 
 source drivers/block/Config.in
 if [ "$CONFIG_BLK_DEV_INITRD" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'MIPS initrd options'
-   bool '  Embed root filesystem ramdisk into the kernel' CONFIG_EMBEDDED_RAMDISK
-   endmenu
+mainmenu_option next_comment
+comment 'MIPS initrd options'
+bool '  Embed root filesystem ramdisk into the kernel' CONFIG_EMBEDDED_RAMDISK
+endmenu
 fi
 
 source drivers/md/Config.in
 
 if [ "$CONFIG_NET" = "y" ]; then
-   source net/Config.in
+source net/Config.in
 fi
 
 source drivers/telephony/Config.in
@@ -607,10 +615,10 @@
 tristate 'ATA/IDE/MFM/RLL support' CONFIG_IDE
 
 if [ "$CONFIG_IDE" != "n" ]; then
-   source drivers/ide/Config.in
+source drivers/ide/Config.in
 else
-   define_bool CONFIG_BLK_DEV_IDE_MODES n
-   define_bool CONFIG_BLK_DEV_HD n
+define_bool CONFIG_BLK_DEV_IDE_MODES n
+define_bool CONFIG_BLK_DEV_HD n
 fi
 endmenu
 
@@ -620,7 +628,7 @@
 tristate 'SCSI support' CONFIG_SCSI
 
 if [ "$CONFIG_SCSI" != "n" ]; then
-   source drivers/scsi/Config.in
+source drivers/scsi/Config.in
 fi
 endmenu
 
Index: include/asm-mips/cacheops.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cacheops.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cacheops.h
--- include/asm-mips/cacheops.h	1997/06/01 03:17:12	1.1.1.1
+++ include/asm-mips/cacheops.h	2002/08/19 11:33:30
@@ -35,6 +35,7 @@
 #define Hit_Writeback_Inv_D	0x15
 					/* 0x16 is unused */
 #define Hit_Writeback_Inv_SD	0x17
+#define Page_Invalidate		0x17
 #define Hit_Writeback_I		0x18
 #define Hit_Writeback_D		0x19
 					/* 0x1a is unused */
Index: include/asm-mips/mipsregs.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/mipsregs.h,v
retrieving revision 1.30.2.14
diff -u -r1.30.2.14 mipsregs.h
--- include/asm-mips/mipsregs.h	2002/08/05 23:53:37	1.30.2.14
+++ include/asm-mips/mipsregs.h	2002/08/19 11:33:31
@@ -377,6 +377,7 @@
 #define CONF_CU				(1 <<  3)
 #define CONF_DB				(1 <<  4)
 #define CONF_IB				(1 <<  5)
+#define CONF_SE 			(1 << 12)
 #define CONF_SC				(1 << 17)
 #define CONF_AC                         (1 << 23)
 #define CONF_HALT                       (1 << 25)
--- /dev/null	Wed Aug 22 17:18:34 2001
+++ arch/mips/mm/r5k-sc.c	Mon Aug 19 13:30:04 2002
@@ -0,0 +1,127 @@
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
+#define SC_PAGE (128*SC_LINE)
+
+#define cache_op(base,op)                   \
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
+		cache_op(start,Page_Invalidate);
+		start += SC_PAGE;
+	}
+}
+
+static inline void blast_r5000_scache_page_indexed(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	while(start < end) {
+		cache_op(start,Page_Invalidate);
+		start += SC_PAGE;
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
+	a = addr & ~(SC_PAGE - 1);
+	end = (addr + size - 1) & ~(SC_PAGE - 1);
+	while (a <= end) {
+		blast_r5000_scache_page_indexed(a);     /* Page_Invalidate */
+		a += SC_PAGE;
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
