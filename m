Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g51IfdnC023528
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 1 Jun 2002 11:41:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g51IfdYv023527
	for linux-mips-outgoing; Sat, 1 Jun 2002 11:41:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g51IfWnC023524
	for <linux-mips@oss.sgi.com>; Sat, 1 Jun 2002 11:41:32 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g51Igf008248
	for linux-mips@oss.sgi.com; Sat, 1 Jun 2002 11:42:41 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VJ4rnC011892
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 12:04:54 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.2/8.12.2/Debian -5) with ESMTP id g4VJ6OtS023396
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 21:06:24 +0200
Message-ID: <3CF7C9B0.20808@murphy.dk>
Date: Fri, 31 May 2002 21:06:24 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Patch for support of Lasat 100 and 200 machines (~60k)
Content-Type: multipart/mixed;
 boundary="------------040102050900040803070107"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------040102050900040803070107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
    this is the reference source for the lasat platforms.
I have cleaned up the original code to give a patch which
applies against todays tree and produces a running kernel
on both platforms.

The patch adds (v)r5000 cache support, the general stuff
required to add a new platform and some small patches
in various places to fix bugs and add, for example, mtd
support for the flash in these machines.

The files not patched (not existing in the oss CVS) are
in lasat.tar.gz. This includes arch/mips/lasat and
include/asm-mips/lasat - one file to support r5000 cache
support and one for the memory mapped flash modules
to give mtd support. In addition there are two drivers for
the rtc and display in the two machines which have
interface include files in include/linux.

I know I was encouraged to split up this stuff but I could
spend weeks or months doing that and not have something
which would satisfy the authorities - This is my first attempt.
Perhaps, Florian, you can look at it and give me some advice
as to how I should structure any splitting-up to get this
accepted.

If anyone has a masquerade (or safepipe) box then you will
also need the information on http://debian.murphy.dk to get
this stuff uploaded on your box. Any problems, send me a
mail.

regards
/Brian

--------------040102050900040803070107
Content-Type: text/plain;
 name="sgi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sgi.diff"

? arch/mips/defconfig-lasat100
? arch/mips/defconfig-lasat200
? arch/mips/lasat
? arch/mips/patch
? arch/mips/mm/c-r5000.c
? drivers/mtd/maps/lasat.c
? include/asm-mips/lasat
? include/linux/ds1603.h
? include/linux/picvue.h
Index: arch/mips/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/Makefile,v
retrieving revision 1.78.2.2
diff -u -r1.78.2.2 Makefile
--- arch/mips/Makefile	2002/02/15 21:05:47	1.78.2.2
+++ arch/mips/Makefile	2002/05/30 10:33:14
@@ -77,6 +77,9 @@
 ifdef CONFIG_CPU_R5000
 GCCFLAGS	+= -mcpu=r5000 -mips2 -Wa,--trap
 endif
+ifdef CONFIG_CPU_VR5000
+GCCFLAGS	+= -mcpu=vr5000 -mips2 -Wa,--trap
+endif
 ifdef CONFIG_CPU_R5432
 GCCFLAGS        += -mcpu=r5000 -mips2 -Wa,--trap
 endif
@@ -288,7 +291,14 @@
 LOADADDR      += 0x80100000
 endif
 
+ifdef CONFIG_LASAT
+LIBS          += arch/mips/lasat/lasatkern.o
+SUBDIRS       += arch/mips/lasat
+LOADADDR      += 0x80000000
+endif
+
 #
+#
 # Au1000 eval board
 #
 ifdef CONFIG_MIPS_PB1000
@@ -379,6 +389,11 @@
 endif
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+
+ifdef CONFIG_LASAT
+rom.bin: vmlinux
+		$(MAKE) -C arch/$(ARCH)/lasat/image $@
+endif
 
 vmlinux.ecoff: vmlinux
 	@$(MAKEBOOT) $@
Index: arch/mips/config.in
===================================================================
RCS file: /cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.19
diff -u -r1.154.2.19 config.in
--- arch/mips/config.in	2002/05/29 14:30:49	1.154.2.19
+++ arch/mips/config.in	2002/05/30 10:33:14
@@ -43,6 +43,22 @@
 fi
 dep_bool 'Support for Galileo EV96100 Evaluation board (EXPERIMENTAL)' CONFIG_MIPS_EV96100 $CONFIG_EXPERIMENTAL
 bool 'Support for Globespan IVR board' CONFIG_MIPS_IVR
+bool 'Support for LASAT Networks platforms' CONFIG_LASAT
+if [ "$CONFIG_LASAT" = "y" ]; then
+   bool '  Support for LASAT Networks 100 series' CONFIG_LASAT_100
+   bool '  Support for LASAT Networks 200 series' CONFIG_LASAT_200
+   tristate '  DS1603 rtc support' CONFIG_DS1603
+   tristate '  PICVUE LCD display driver' CONFIG_PICVUE
+   dep_tristate '   PICVUE LCD display driver /proc interface' CONFIG_PICVUE_PROC $CONFIG_PICVUE
+   if [ "$CONFIG_LASAT_100" = "y" ]; then
+      define_bool CONFIG_PCI y
+      define_bool CONFIG_NONCOHERENT_IO y
+   fi
+   if [ "$CONFIG_LASAT_200" = "y" ]; then
+      define_bool CONFIG_PCI y
+      define_bool CONFIG_NONCOHERENT_IO y
+   fi
+fi
 bool 'Support for Hewlett Packard LaserJet board' CONFIG_HP_LASERJET
 bool 'Support for ITE 8172G board' CONFIG_MIPS_ITE8172
 if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
@@ -324,6 +340,7 @@
 	 R4x00	CONFIG_CPU_R4X00 \
 	 R49XX	CONFIG_CPU_TX49XX \
 	 R5000	CONFIG_CPU_R5000 \
+	 VR5000	CONFIG_CPU_VR5000 \
 	 R5432	CONFIG_CPU_R5432 \
 	 RM7000	CONFIG_CPU_RM7000 \
 	 R52xx	CONFIG_CPU_NEVADA \
@@ -355,6 +372,7 @@
 
 if [ "$CONFIG_CPU_R4X00"  = "y" -o \
      "$CONFIG_CPU_R5000" = "y" -o \
+     "$CONFIG_CPU_VR5000" = "y" -o \
      "$CONFIG_CPU_RM7000" = "y" -o \
      "$CONFIG_CPU_R10000" = "y" -o \
      "$CONFIG_CPU_SB1" = "y" -o \
Index: arch/mips/kernel/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/Makefile,v
retrieving revision 1.51.2.1
diff -u -r1.51.2.1 Makefile
--- arch/mips/kernel/Makefile	2002/01/24 23:14:24	1.51.2.1
+++ arch/mips/kernel/Makefile	2002/05/30 10:33:15
@@ -32,6 +32,7 @@
 obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_VR5000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_NEVADA)	+= r4k_fpu.o r4k_switch.o
Index: arch/mips/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
retrieving revision 1.96.2.17
diff -u -r1.96.2.17 setup.c
--- arch/mips/kernel/setup.c	2002/05/28 05:38:37	1.96.2.17
+++ arch/mips/kernel/setup.c	2002/05/30 10:33:16
@@ -137,7 +137,7 @@
 		printk(" available.\n");
 		break;
 	case CPU_R4200: 
-/*	case CPU_R4300: */
+	case CPU_R4300: 
 	case CPU_R4600: 
 	case CPU_R4640: 
 	case CPU_R4650: 
@@ -762,6 +762,11 @@
 	case MACH_GROUP_PHILIPS:
 		nino_setup();
 		break;
+#endif
+#ifdef CONFIG_LASAT
+        case MACH_GROUP_LASAT:
+                platform_setup();
+                break;
 #endif
 #ifdef CONFIG_MIPS_PB1000
 	case MACH_GROUP_ALCHEMY:
Index: arch/mips/mm/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/mm/Makefile,v
retrieving revision 1.27
diff -u -r1.27 Makefile
--- arch/mips/mm/Makefile	2001/11/26 13:38:14	1.27
+++ arch/mips/mm/Makefile	2002/05/30 10:33:16
@@ -24,6 +24,7 @@
 obj-$(CONFIG_CPU_R4X00)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_VR41XX)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
+obj-$(CONFIG_CPU_VR5000)	+= pg-r4k.o c-r5000.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_NEVADA)	+= pg-r4k.o c-r4k.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= pg-r5432.o c-r5432.o tlb-r4k.o tlbex-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= pg-rm7k.o c-rm7k.o tlb-r4k.o tlbex-r4k.o
Index: arch/mips/mm/loadmmu.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/loadmmu.c,v
retrieving revision 1.45
diff -u -r1.45 loadmmu.c
--- arch/mips/mm/loadmmu.c	2001/11/29 04:47:24	1.45
+++ arch/mips/mm/loadmmu.c	2002/05/30 10:33:17
@@ -52,6 +52,7 @@
 
 extern void ld_mmu_r23000(void);
 extern void ld_mmu_r4xx0(void);
+extern void ld_mmu_r5000(void);
 extern void ld_mmu_tx39(void);
 extern void ld_mmu_tx49(void);
 extern void ld_mmu_r5432(void);
@@ -72,6 +73,10 @@
     defined(CONFIG_CPU_R4300) || defined(CONFIG_CPU_R5000) || \
     defined(CONFIG_CPU_NEVADA)
 		ld_mmu_r4xx0();
+		r4k_tlb_init();
+#endif
+#if defined(CONFIG_CPU_VR5000)
+		ld_mmu_r5000();
 		r4k_tlb_init();
 #endif
 #if defined(CONFIG_CPU_RM7000)
Index: drivers/mtd/maps/Config.in
===================================================================
RCS file: /cvs/linux/drivers/mtd/maps/Config.in,v
retrieving revision 1.3.2.2
diff -u -r1.3.2.2 Config.in
--- drivers/mtd/maps/Config.in	2002/02/15 21:05:48	1.3.2.2
+++ drivers/mtd/maps/Config.in	2002/05/30 10:33:21
@@ -50,6 +50,7 @@
       int '    Bus width in octets' CONFIG_MTD_CSTM_MIPS_IXX_BUSWIDTH 2
    fi
    dep_tristate '  Momenco Ocelot boot flash device' CONFIG_MTD_OCELOT $CONFIG_MOMENCO_OCELOT
+   dep_tristate '  LASAT flash device' CONFIG_MTD_LASAT $CONFIG_MTD_CFI $CONFIG_LASAT
 fi
 
 if [ "$CONFIG_SH" = "y" ]; then
Index: drivers/mtd/maps/Makefile
===================================================================
RCS file: /cvs/linux/drivers/mtd/maps/Makefile,v
retrieving revision 1.2.2.2
diff -u -r1.2.2.2 Makefile
--- drivers/mtd/maps/Makefile	2002/02/15 21:05:48	1.2.2.2
+++ drivers/mtd/maps/Makefile	2002/05/30 10:33:21
@@ -31,5 +31,6 @@
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
 obj-$(CONFIG_MTD_PB1000)        += pb1xxx-flash.o
 obj-$(CONFIG_MTD_PB1500)        += pb1xxx-flash.o
+obj-$(CONFIG_MTD_LASAT)     	+= lasat.o
 
 include $(TOPDIR)/Rules.make
Index: drivers/net/pcnet32.c
===================================================================
RCS file: /cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.33.2.1
diff -u -r1.33.2.1 pcnet32.c
--- drivers/net/pcnet32.c	2002/02/26 05:59:35	1.33.2.1
+++ drivers/net/pcnet32.c	2002/05/30 10:33:23
@@ -656,7 +656,7 @@
 #if defined(__i386__)
 	    printk(KERN_WARNING "%s: Probably a Compaq, using the PROM address of", dev->name);
 	    memcpy(dev->dev_addr, promaddr, 6);
-#elif defined(__powerpc__)
+#else
 	    if (!is_valid_ether_addr(dev->dev_addr)
 		&& is_valid_ether_addr(promaddr)) {
 		    printk("\n" KERN_WARNING "%s: using PROM address:",
@@ -765,8 +765,12 @@
     if (irq_line) {
 	dev->irq = irq_line;
     }
-    
+
+#ifdef CONFIG_LASAT
+    if (dev->irq >= 0)
+#else
     if (dev->irq >= 2)
+#endif
 	printk(" assigned IRQ %d.\n", dev->irq);
     else {
 	unsigned long irq_mask = probe_irq_on();
@@ -821,7 +825,10 @@
     u16 val;
     int i;
 
-    if (dev->irq == 0 ||
+    if (
+#ifndef CONFIG_LASAT
+	dev->irq == 0 ||
+#endif
 	request_irq(dev->irq, &pcnet32_interrupt,
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
@@ -1343,6 +1350,10 @@
 		if (!rx_in_place) {
 		    skb_reserve(skb,2); /* 16 byte align */
 		    skb_put(skb,pkt_len);	/* Make room */
+                    pci_dma_sync_single(lp->pci_dev, 
+				    lp->rx_skbuff[entry]->tail, 
+				    pkt_len,
+				    PCI_DMA_FROMDEVICE);
 		    eth_copy_and_sum(skb,
 				     (unsigned char *)(lp->rx_skbuff[entry]->tail),
 				     pkt_len,0);
@@ -1664,7 +1675,7 @@
     }
     return -EOPNOTSUPP;
 }
-					    
+
 static struct pci_driver pcnet32_driver = {
 	name:		DRV_NAME,
 	probe:		pcnet32_probe_pci,
Index: drivers/pci/pci.c
===================================================================
RCS file: /cvs/linux/drivers/pci/pci.c,v
retrieving revision 1.48
diff -u -r1.48 pci.c
--- drivers/pci/pci.c	2001/12/02 11:34:45	1.48
+++ drivers/pci/pci.c	2002/05/30 10:33:25
@@ -38,6 +38,8 @@
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
 
+static int pci_reverse = 0;
+
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
@@ -1327,8 +1329,13 @@
 		 * Link the device to both the global PCI device chain and
 		 * the per-bus list of devices.
 		 */
-		list_add_tail(&dev->global_list, &pci_devices);
-		list_add_tail(&dev->bus_list, &bus->devices);
+		if (!pci_reverse) {
+			list_add_tail(&dev->global_list, &pci_devices);
+			list_add_tail(&dev->bus_list, &bus->devices);
+		} else {
+			list_add(&dev->global_list, &pci_devices);
+			list_add(&dev->bus_list, &bus->devices);
+		}
 
 		/* Fix up broken headers */
 		pci_fixup_device(PCI_FIXUP_HEADER, dev);
@@ -1952,7 +1959,10 @@
 			*k++ = 0;
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			/* PCI layer options should be handled here */
-			printk(KERN_ERR "PCI: Unknown option `%s'\n", str);
+			if (!strcmp(str, "reverse"))
+				pci_reverse = 1;
+			else
+				printk(KERN_ERR "PCI: Unknown option `%s'\n", str);
 		}
 		str = k;
 	}
Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.43.2.8
diff -u -r1.43.2.8 bootinfo.h
--- include/asm-mips/bootinfo.h	2002/02/15 21:05:49	1.43.2.8
+++ include/asm-mips/bootinfo.h	2002/05/30 10:33:31
@@ -35,6 +35,7 @@
 #define MACH_GROUP_ALCHEMY     18 /* Alchemy Semi Eval Boards*/
 #define MACH_GROUP_NEC_VR41XX  19 /* NEC Vr41xx based boards/gadgets          */
 #define MACH_GROUP_HP_LJ	20 /* Hewlett Packard LaserJet */
+#define MACH_GROUP_LASAT       21
 
 /*
  * Valid machtype values for group unknown (low order halfword of mips_machtype)
@@ -151,6 +152,12 @@
 #define MACH_TOPAS		1
 #define MACH_JMR		2
 #define MACH_TOSHIBA_JMR3927    3      /* JMR-TX3927 CPU/IO board */
+
+/*
+ * Valid machtype for group LASAT
+ */
+#define MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
+#define MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
 
 /*
  * Valid machtype for group Alchemy
Index: include/asm-mips/cacheops.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cacheops.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cacheops.h
--- include/asm-mips/cacheops.h	1997/06/01 03:17:12	1.1.1.1
+++ include/asm-mips/cacheops.h	2002/05/30 10:33:31
@@ -35,6 +35,7 @@
 #define Hit_Writeback_Inv_D	0x15
 					/* 0x16 is unused */
 #define Hit_Writeback_Inv_SD	0x17
+#define Page_Invalidate		0x17
 #define Hit_Writeback_I		0x18
 #define Hit_Writeback_D		0x19
 					/* 0x1a is unused */
Index: include/asm-mips/cpu.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/cpu.h,v
retrieving revision 1.24.2.6
diff -u -r1.24.2.6 cpu.h
--- include/asm-mips/cpu.h	2002/05/13 18:54:25	1.24.2.6
+++ include/asm-mips/cpu.h	2002/05/30 10:33:32
@@ -53,6 +53,7 @@
 #define PRID_IMP_R4640		0x2200
 #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
 #define PRID_IMP_R5000		0x2300
+#define PRID_IMP_VR5000		0x2300
 #define PRID_IMP_TX49		0x2d00
 #define PRID_IMP_SONIC		0x2400
 #define PRID_IMP_MAGIC		0x2500
@@ -127,7 +128,7 @@
 	CPU_R5000A, CPU_R4640, CPU_NEVADA, CPU_RM7000, CPU_R5432, CPU_4KC,
 	CPU_5KC, CPU_R4310, CPU_SB1, CPU_TX3912, CPU_TX3922, CPU_TX3927,
 	CPU_AU1000, CPU_4KEC, CPU_4KSC, CPU_VR41XX, CPU_R5500, CPU_TX49XX,
-	CPU_TX39XX, CPU_AU1500, CPU_20KC, CPU_LAST
+	CPU_TX39XX, CPU_AU1500, CPU_20KC, CPU_VR5000, CPU_LAST
 };
 
 #endif
Index: include/asm-mips/r4kcache.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/r4kcache.h,v
retrieving revision 1.8
diff -u -r1.8 r4kcache.h
--- include/asm-mips/r4kcache.h	2001/10/31 02:31:23	1.8
+++ include/asm-mips/r4kcache.h	2002/05/30 10:33:35
@@ -76,6 +76,19 @@
 		  "i" (Hit_Writeback_Inv_D));
 }
 
+extern inline void flush_dcache_line_wb(unsigned long addr)
+{
+	__asm__ __volatile__(
+		".set noreorder\n\t"
+		".set mips3\n\t"
+		"cache %1, (%0)\n\t"
+		".set mips0\n\t"
+		".set reorder"
+		:
+		: "r" (addr),
+		  "i" (Hit_Writeback_D));
+}
+
 static inline void invalidate_dcache_line(unsigned long addr)
 {
 	__asm__ __volatile__(
@@ -606,6 +619,40 @@
 static inline void blast_scache128_page_indexed(unsigned long page)
 {
 	cache128_unroll32(page,Index_Writeback_Inv_SD);
+}
+
+
+#define cache_unroll(base,op)	        	\
+	__asm__ __volatile__("	         	\
+		.set noreorder;		        \
+		.set mips3;		        \
+                cache %1, (%0);	                \
+		.set mips0;			\
+		.set reorder"			\
+		:				\
+		: "r" (base),			\
+		  "i" (op));
+
+extern inline void blast_r5000_scache(void)
+{
+	unsigned long start = KSEG0;
+	unsigned long end = KSEG0 + scache_size;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*sc_lsize;
+	}
+}
+
+extern inline void blast_r5000_scache_page_indexed(unsigned long page)
+{
+	unsigned long start = page;
+	unsigned long end = page + PAGE_SIZE;
+
+	while(start < end) {
+		cache_unroll(start,Page_Invalidate);
+		start += 128*sc_lsize;
+	}
 }
 
 #endif /* !(_MIPS_R4KCACHE_H) */
Index: include/asm-mips/serial.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/serial.h,v
retrieving revision 1.23.2.2
diff -u -r1.23.2.2 serial.h
--- include/asm-mips/serial.h	2002/01/07 03:33:54	1.23.2.2
+++ include/asm-mips/serial.h	2002/05/30 10:33:35
@@ -144,6 +144,18 @@
 #define IVR_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_LASAT
+#include <asm/lasat/lasatint.h>
+#define LASAT_SERIAL_PORT_DEFNS						\
+	{ baud_base: LASAT_BASE_BAUD, irq: LASATINT_UART,		\
+	  flags: STD_COM_FLAGS,						\
+	  port: LASAT_UART_REGS_BASE, /* Only for display */		\
+	  iomem_base: (u8 *)KSEG1ADDR(LASAT_UART_REGS_BASE),		\
+	  iomem_reg_shift: LASAT_UART_REGS_SHIFT, io_type: SERIAL_IO_MEM }
+#else
+#define LASAT_SERIAL_PORT_DEFNS
+#endif
+
 #ifdef CONFIG_AU1000_UART
 #include <asm/au1000.h>
 #define AU1000_SERIAL_PORT_DEFNS                              \
@@ -286,6 +298,7 @@
 	COBALT_SERIAL_PORT_DEFNS	\
 	EV96100_SERIAL_PORT_DEFNS	\
 	JAZZ_SERIAL_PORT_DEFNS		\
+	LASAT_SERIAL_PORT_DEFNS		\
 	STD_SERIAL_PORT_DEFNS		\
 	EXTRA_SERIAL_PORT_DEFNS		\
 	HUB6_SERIAL_PORT_DFNS		\

--------------040102050900040803070107
Content-Type: application/gzip;
 name="lasat.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lasat.tar.gz"

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
6/NXIPAVE6SuORKCPO7EGZlo5ss08qJ3jgsFfUYGIDxtva8326fn1cuTGr1f3Bh2AJP8T/Ud
hfrjKwTpJksk5QFmgAip5S8EJZ+9jhBxpwAPPNqx8RzkBbVuPTGw1xPNENq2A51cfYmCPm7U
zv5SPzfsCWM0J4ojN8JltT48Y4wXIEuDJFn8+gDfYkd2PdBG/kP0WHkhpqSLSzSNGSYbqOSO
5GhLUnVAkfIph6AKiUZp5a5un8AAOGvW8qvvLk5w3MrH5cvW+/NGfvUIr2qL09lkfPMgfrjC
X38e0q/N7ue3GkK11qw06het+vlZfvWEliGYyXTcH3tbWoJFYD02XfDyFfH/6IXUf+hHrmu2
YFmzoaWBe9Y6LKvk7G5vZ63/8cPr/93izo69i+v/bdv+/8T2s1KR8fkvX/9n9P/tpLMNXbJ5
8xx1zN//sR17Nxn/qbS7U3rZ//kaH/Js7aGiJ2MaZ+sP3PfsS0DRbm4eArK6q2xGl+Vdl4bc
+A5E/qJabgQFiaIinjSrjfKpBRMu5U21KHYNPRNH7uizsPQwKvTcVrB7SVhbh61Wmo6EtLlU
SVjlpj/eaFJUF+EkMIoKYy8Lo5jAKEkMJ7OOUgJjW2Fk1rGdwNiRGMXMOnYSGLsKYy9nRkA/
bPQ30ZH2JFIpsxrOCx7iXFTqH1XP7TASPAp7/mN/1PXv4j2IKKoDd/ayULAjo2rqZ61KU+Ls
WgJbBGsZMGYo/FYdozFibKpI0HCxwdQHet1o0UcFceW4ihKN89NYM/nqAIs1JoWiKnroDxvV
oZWL+bta5ZYseI8ZgXhNjrOogWJTWo0TBco01MN4krJZCQws3GKMN1YCQ1ZhGVBsiZKsRKLY
xKawefRKZkpJMv+kIQkuJ6uv4MF0ou6Li5picjnqYWMjKcQohbneWMDj09qpxrgK08GoJq6V
K81W/bSmwPd08HKHblS0+hQVSe/H97BOU02txnAqN17ns6hR5uKoV1e4bRtHsyBGdWyEaGTX
rJzkhoFkeFxuHCnIPQVZnlz18epHHLJ+VlcicRwWCpYvQubrqKfdqT8ppMYe4km5ON6bg8cD
UMeMOHMUIkqGSE6cYGa7FC/CMk4qZ8fvuAhbqnnCEIhR0fNG89lBiNZsST1u2yk0bdDK/nTi
dTZbRYW8txi5GOs8xJbq3XaWqLqUrHpbIS9R9TYr5Bi+1Pt2cYnKd5KV7yrkJSrfTSLLqcAu
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
53z+/2mP4MQAwAMA
--------------040102050900040803070107--
