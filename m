Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2008 06:24:21 +0100 (BST)
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:39050
	"EHLO QMTA02.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20022287AbYGaFYM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Jul 2008 06:24:12 +0100
Received: from OMTA09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id wAtl1Z0010SCNGk52VQAaz; Thu, 31 Jul 2008 05:24:10 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA09.westchester.pa.mail.comcast.net with comcast
	id wVQ41Z00758Be2l3VVQ534; Thu, 31 Jul 2008 05:24:10 +0000
X-Authority-Analysis: v=1.0 c=1 a=5KkjwRb-_X8A:10 a=7-cKWoymOU4A:10
 a=-8ZXg7HmImZL_YaBKiUA:9 a=hIR2hz0Wb-VbDk44pV-rStuQm2wA:4 a=uVawpVqKyvgA:10
 a=5s7kCPR2Yx7SiBUC5z8A:9 a=W-GjneXc1E4bFoj3B4gA:7
 a=8aLmrnVPUFkz6ehnB6m2eLWVVeQA:4 a=1DbiqZag68YA:10 a=oUQuMaGMe1cA:10
 a=WeOa-AV5lc8A:10 a=NfA2RSpTaHsA:10
Message-ID: <48914C74.6090309@gentoo.org>
Date:	Thu, 31 Jul 2008 01:24:04 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH/RFC]: SGI Octane (IP30) Patches, Part two, Octane core
Content-Type: multipart/mixed;
 boundary="------------020900080705080800030905"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020900080705080800030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The second part is the actual IP30 Patch that makes these beasts boot.  Assuming 
you've already lit incense candles and sacrificed a PC to the MIPS Gods above.

There's one change that probably needs good scrutiny, as it changes a value in 
dma-default.c, and this'll affect other systems:

diff -Naurp linux-2.6.26.orig/arch/mips/mm/dma-default.c 
linux-2.6.26/arch/mips/mm/dma-default.c
--- linux-2.6.26.orig/arch/mips/mm/dma-default.c        2008-07-13 
17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/mm/dma-default.c     2008-07-25 03:14:40.000000000 -0400
@@ -209,7 +209,7 @@ dma_addr_t dma_map_page(struct device *d
                 dma_cache_wback_inv(addr, size);
         }

-       return plat_map_dma_mem_page(dev, page) + offset;
+       return plat_map_dma_mem_page(dev, page, size) + offset;
  }


It's used because IP30's implementation of plat_map_dma_mem_page passes the 
'size' var to a few functions, ultimately leading to IP30's version of 
pdev_to_baddr, where it checks to make sure we're not above a certain memory 
limit (2GB) that could cause problems with DMA & PCI (I think - it's been awhile).

That's just one example, though.  There's probably more, but I've mostly done 
forward ports, and haven't really messed with re-writing much.  Hence why I'd 
like to ask others to look, poke, prod, compile, and boot, and see if they have 
other suggestions for improving and fixing this up.

Thanks!,


--Kumba

-- 
Unofficial Gentoo/MIPS Hermit & Kernel Monkey

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------020900080705080800030905
Content-Type: text/plain;
 name="misc-2.6.26-ip30-octane-support-r28.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.26-ip30-octane-support-r28.patch"

diff -Naurp linux-2.6.26.orig/arch/mips/Kconfig linux-2.6.26/arch/mips/Kconfig
--- linux-2.6.26.orig/arch/mips/Kconfig	2008-07-25 01:03:02.000000000 -0400
+++ linux-2.6.26/arch/mips/Kconfig	2008-07-25 03:15:09.000000000 -0400
@@ -449,6 +449,31 @@ config SGI_IP28
         This is the SGI Indigo2 with R10000 processor.  To compile a Linux
         kernel that runs on these, say Y here.
 
+config SGI_IP30
+	bool "SGI IP30 (Octane/Octane2) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	select ARC
+	select ARC64
+	select BOOT_ELF64
+        select CEVT_R4K
+        select CSRC_R4K
+	select DMA_IP30
+	select DMA_COHERENT
+	select GENERIC_ISA_DMA
+	select HW_HAS_PCI
+        select IRQ_CPU
+	select NR_CPUS_DEFAULT_2
+	select PCI_DOMAINS
+	select SYS_HAS_CPU_R10000
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_SMP
+        select ARC_MEMORY
+        select ARC_PROMLIB
+	help
+	  This are the SGI Octane and Octane2 graphics workstations.  To
+	  compile a Linux kernel that runs on these, say Y here.
+
 config SGI_IP32
 	bool "SGI IP32 (O2)"
 	select ARC
@@ -812,6 +837,9 @@ config DMA_COHERENT
 config DMA_IP27
 	bool
 
+config DMA_IP30
+	bool
+
 config DMA_NONCOHERENT
 	bool
 	select DMA_NEED_PCI_MAP_STATE
@@ -1006,7 +1034,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION
-	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM
+	default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SGI_IP30 || SNI_RM
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
@@ -1019,12 +1047,12 @@ config ARC_CONSOLE
 
 config ARC_MEMORY
 	bool
-	depends on MACH_JAZZ || SNI_RM || SGI_IP32
+	depends on MACH_JAZZ || SNI_RM || SGI_IP30 || SGI_IP32
 	default y
 
 config ARC_PROMLIB
 	bool
-	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP28 || SGI_IP32
+	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP28 || SGI_IP30 || SGI_IP32
 	default y
 
 config ARC64
diff -Naurp linux-2.6.26.orig/arch/mips/Makefile linux-2.6.26/arch/mips/Makefile
--- linux-2.6.26.orig/arch/mips/Makefile	2008-07-23 22:26:29.000000000 -0400
+++ linux-2.6.26/arch/mips/Makefile	2008-07-25 03:14:40.000000000 -0400
@@ -492,6 +492,15 @@ cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cach
 load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
 
 #
+# SGI-IP30 (Octane/Octane2)
+#
+ifdef CONFIG_SGI_IP30
+core-$(CONFIG_SGI_IP30)		+= arch/mips/sgi-ip30/
+cflags-$(CONFIG_SGI_IP30)	+= -Iinclude/asm-mips/mach-ip30
+load-$(CONFIG_SGI_IP30)		+= 0xa800000020004000
+endif
+
+#
 # SGI-IP32 (O2)
 #
 # Set the load address to >= 80069000 if you want to leave space for symmon,
diff -Naurp linux-2.6.26.orig/arch/mips/fw/arc/init.c linux-2.6.26/arch/mips/fw/arc/init.c
--- linux-2.6.26.orig/arch/mips/fw/arc/init.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/fw/arc/init.c	2008-07-25 03:14:40.000000000 -0400
@@ -56,4 +56,11 @@ void __init prom_init(void)
 		register_smp_ops(&ip27_smp_ops);
 	}
 #endif
+#ifdef CONFIG_SGI_IP30
+	{
+		extern struct plat_smp_ops ip30_smp_ops;
+
+		register_smp_ops(&ip30_smp_ops);
+	}
+#endif
 }
diff -Naurp linux-2.6.26.orig/arch/mips/kernel/cevt-r4k.c linux-2.6.26/arch/mips/kernel/cevt-r4k.c
--- linux-2.6.26.orig/arch/mips/kernel/cevt-r4k.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/kernel/cevt-r4k.c	2008-07-25 03:14:40.000000000 -0400
@@ -251,7 +251,6 @@ int __cpuinit mips_clockevent_init(void)
 	irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
 	if (get_c0_compare_int)
 		irq = get_c0_compare_int();
-
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
 	cd->name		= "MIPS";
diff -Naurp linux-2.6.26.orig/arch/mips/kernel/setup.c linux-2.6.26/arch/mips/kernel/setup.c
--- linux-2.6.26.orig/arch/mips/kernel/setup.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/kernel/setup.c	2008-07-25 03:14:40.000000000 -0400
@@ -481,6 +481,10 @@ static void __init arch_mem_init(char **
 	printk("Determined physical RAM map:\n");
 	print_memory_map();
 
+#ifdef CONFIG_CMDLINE
+	if (strlen(CONFIG_CMDLINE))
+		strlcpy(arcs_cmdline, CONFIG_CMDLINE, sizeof(command_line));
+#endif
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 
@@ -575,7 +579,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	arch_mem_init(cmdline_p);
-
 	resource_init();
 	plat_smp_setup();
 }
diff -Naurp linux-2.6.26.orig/arch/mips/mm/dma-default.c linux-2.6.26/arch/mips/mm/dma-default.c
--- linux-2.6.26.orig/arch/mips/mm/dma-default.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/mm/dma-default.c	2008-07-25 03:14:40.000000000 -0400
@@ -209,7 +209,7 @@ dma_addr_t dma_map_page(struct device *d
 		dma_cache_wback_inv(addr, size);
 	}
 
-	return plat_map_dma_mem_page(dev, page) + offset;
+	return plat_map_dma_mem_page(dev, page, size) + offset;
 }
 
 EXPORT_SYMBOL(dma_map_page);
diff -Naurp linux-2.6.26.orig/arch/mips/pci/Makefile linux-2.6.26/arch/mips/pci/Makefile
--- linux-2.6.26.orig/arch/mips/pci/Makefile	2008-07-25 01:03:02.000000000 -0400
+++ linux-2.6.26/arch/mips/pci/Makefile	2008-07-25 03:14:40.000000000 -0400
@@ -34,6 +34,7 @@ obj-$(CONFIG_PMC_MSP7120_FPGA)	+= fixup-
 obj-$(CONFIG_PMC_YOSEMITE)	+= fixup-yosemite.o ops-titan.o ops-titan-ht.o \
 				   pci-yosemite.o
 obj-$(CONFIG_SGI_IP27)		+= ops-bridge.o pci-ip27.o
+obj-$(CONFIG_SGI_IP30)		+= ops-bridge.o pci-ip30.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM112X)	+= fixup-sb1250.o pci-sb1250.o
diff -Naurp linux-2.6.26.orig/arch/mips/pci/ops-bridge.c linux-2.6.26/arch/mips/pci/ops-bridge.c
--- linux-2.6.26.orig/arch/mips/pci/ops-bridge.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/pci/ops-bridge.c	2008-07-25 03:14:40.000000000 -0400
@@ -9,9 +9,15 @@
 #include <linux/pci.h>
 #include <asm/paccess.h>
 #include <asm/pci/bridge.h>
+
+#ifdef CONFIG_SGI_IP30
+#include <asm/mach-ip30/addrs.h>
+#include <asm/mach-ip30/pcibr.h>
+#else
 #include <asm/sn/arch.h>
 #include <asm/sn/intr.h>
 #include <asm/sn/sn0/hub.h>
+#endif
 
 /*
  * Most of the IOC3 PCI config register aren't present
diff -Naurp linux-2.6.26.orig/arch/mips/pci/pci-ip30.c linux-2.6.26/arch/mips/pci/pci-ip30.c
--- linux-2.6.26.orig/arch/mips/pci/pci-ip30.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/pci/pci-ip30.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,321 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek (skylark@linux-mips.org)
+ * Based on pci-ip27.c by
+ *  Copyright (C) 2003 Christoph Hellwig (hch@lst.de)
+ *  Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/mach-ip30/addrs.h>
+#include <asm/mach-ip30/pcibr.h>
+#include <asm/pci/bridge.h>
+#include <asm/paccess.h>
+
+extern unsigned int allocate_irqno(void);
+
+/*
+ * XXX: No kmalloc available when we do our crosstalk scan,
+ * 	we should try to move it later in the boot process.
+ */
+static struct bridge_controller bridges[PCIBR_MAX_PCI_BUSSES];
+
+/* Translate from irq to software PCI bus number and PCI slot. */
+struct bridge_controller *irq_to_bridge[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS];
+int irq_to_slot[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS];
+bridge_t *ip30_irq_bridge[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS] = {NULL};
+unsigned int ip30_irq_in_bridge[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS] = {0};
+
+extern struct pci_ops bridge_pci_ops;
+
+unsigned int ip30_bridge_count = 0;
+unsigned int ip30_irq_assigned = PCIBR_IRQ_BASE;
+
+
+/* OK, spikey dildo time */
+#define AT_FAIL	0
+#define AT_D32	1
+#define AT_D64	2
+#define AT_DIO	3
+#define AT_WIN	4
+
+static char *at_names[] = {"failed", "direct 32-bit", "direct 64-bit",
+			   "direct I/O", "window"};
+
+static unsigned int align(unsigned int ptr, unsigned int size)
+{
+	return (ptr + size - 1) & ~(size - 1);
+}
+
+static inline unsigned int win_size(int n)
+{
+	return (n < 2)? 0x200000 : 0x100000;
+}
+
+static inline unsigned int win_base(int n)
+{
+	return (n < 3) ? (0x200000 * (n + 1)) : (0x100000 * (n + 4));
+}
+
+static int startup_resource(struct pci_controller *hose, struct pci_dev *dev, int res)
+{
+	struct bridge_controller *bc = (struct bridge_controller *)hose;
+	struct resource *rs = &dev->resource[res];
+	bridge_t *bvma = (bridge_t *)bc->base;
+	int slot = PCI_SLOT(dev->devfn);
+	int is_be = bc->slot_be[slot];
+	int is_io = !!(rs->flags & IORESOURCE_IO);
+	unsigned int size = rs->end - rs->start + 1;
+	int at = AT_FAIL;
+	unsigned int base = 0;
+	unsigned long vma = 0;
+	unsigned int devio;
+	int i, j;
+
+	/* check for nonexistant resources */
+	if (size < 2)
+		return 0;
+
+	/* try direct mappings first */
+	if (!is_io && !is_be) {
+		base = align(bc->d32_p, size);
+		vma = base + BRIDGE_PCI_MEM32_BASE;
+		bc->d32_p = base + size;
+		at = AT_D32;
+	}
+	if (is_io && !is_be && bc->bridge_rev >= BRIDGE_REV_D) {
+		base = align(bc->dio_p, size);
+		vma = base + BRIDGE_PCI_IO_BASE;
+		bc->dio_p = base + size;
+		at = AT_DIO;
+	}
+
+	/* OK, that failed, try finding a compatible DevIO */
+	if (at == AT_FAIL)
+		for (j = 0; j < 8; j++) {
+			i = (j + slot) & 7;
+			if (bc->win_p[i] && bc->win_io[i] == is_io && bc->win_be[i] == is_be)
+				if (align(bc->win_p[i], size) + size <= win_size(i)) {
+					base = align(bc->win_p[i], size);
+					bc->win_p[i] = base + size;
+					base += win_base(i);
+					vma = base;
+					at = AT_WIN;
+					break;
+				}
+		}
+
+	/* if everything else fails, allocate a new DevIO */
+	if (at == AT_FAIL)
+		for (j = 0; j < 8; j++) {
+			i = (j + slot) & 7;
+			if (!bc->win_p[i] && size <= win_size(i)) {
+				bc->win_p[i] = size;
+				bc->win_io[i] = is_io;
+				bc->win_be[i] = is_be;
+				base = win_base(i);
+				vma = base;
+				at = AT_WIN;
+				/* set the DevIO params */
+				devio = bvma->b_device[i].reg;
+				if (is_be)
+					devio |= BRIDGE_DEV_DEV_SWAP;
+				else
+					devio &= ~BRIDGE_DEV_DEV_SWAP;
+				if (is_io)
+					devio &= ~BRIDGE_DEV_DEV_IO_MEM;
+				else
+					devio |= BRIDGE_DEV_DEV_IO_MEM;
+				devio &= ~BRIDGE_DEV_OFF_MASK;
+				devio |= win_base(i) >> BRIDGE_DEV_OFF_ADDR_SHFT;
+				bvma->b_device[i].reg = devio;
+				break;
+			}
+		}
+
+	/* get real VMA */
+	if (vma < PCIBR_OFFSET_END)
+		vma += NODE_SWIN_BASE(bc->nasid, bc->widget_id);
+	else
+		vma += NODE_BWIN_BASE(bc->nasid, bc->widget_id);
+
+	/* dump useless info to console */
+	if (at != AT_FAIL)
+		printk(KERN_INFO "BRIDGE: %s #%d, size 0x%x for %s-endian %s --> %s at bus 0x%08x vma 0x%016lx\n",
+					is_io ? "IO" : "Memory", res, size,
+					is_be ? "big" : "little", pci_name(dev),
+					at_names[at], base, vma);
+	else
+		printk(KERN_INFO "BRIDGE: %s #%d, size 0x%x for %s-endian %s --> %s\n",
+					is_io ? "IO" : "Memory", res, size,
+					is_be ? "big" : "little", pci_name(dev),
+					at_names[at]);
+
+	if (at == AT_FAIL)
+		return -ENOMEM;
+
+	/* set the device resource to the new address */
+	rs->start = vma;
+	rs->end = vma + size - 1;
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (4 * res), &devio);
+	devio &= 15;
+	devio |= base & ~15;
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + (4 * res), devio);
+	
+	return 0;
+}
+
+int __init bridge_probe(nasid_t nasid, int widget_id, int masterwid)
+{
+	struct bridge_controller *bc;
+	static int num_bridges = 0;
+	bridge_t *bridge;
+	int i;
+
+	printk(KERN_INFO "BRIDGE chip at xtalk:%d, initializing...\n", widget_id);
+
+	/* XXX: kludge alert.. */
+	if (!num_bridges)
+		ioport_resource.end = ~0UL;
+
+	bc = &bridges[num_bridges];
+
+	bc->pc.pre_enable	= startup_resource;
+
+	bc->pc.pci_ops		= &bridge_pci_ops;
+	bc->pc.mem_resource	= &bc->mem;
+	bc->pc.io_resource	= &bc->io;
+
+	bc->pc.index		= num_bridges;
+
+	bc->mem.name		= "Bridge PCI MEM";
+	bc->mem.start		= NODE_SWIN_BASE(0, widget_id) + PCIBR_OFFSET_MEM;
+	bc->mem.end		= NODE_SWIN_BASE(0, widget_id) + PCIBR_OFFSET_IO - 1;
+	bc->pc.mem_offset	= NODE_SWIN_BASE(0, widget_id);
+	bc->mem.flags		= IORESOURCE_MEM;
+
+	bc->io.name		= "Bridge IO MEM";
+	bc->io.start		= NODE_SWIN_BASE(0, widget_id) + PCIBR_OFFSET_IO;
+	bc->io.end		= NODE_SWIN_BASE(0, widget_id) + PCIBR_OFFSET_END - 1;
+	bc->pc.io_offset	= NODE_SWIN_BASE(0, widget_id);
+	bc->io.flags		= IORESOURCE_IO;
+
+	bc->irq_cpu = smp_processor_id();
+	bc->widget_id = widget_id;
+	bc->nasid = nasid;
+
+	/* set direct allocation base */
+	bc->dio_p = PCIBR_DIR_ALLOC_BASE;
+	bc->d32_p = PCIBR_DIR_ALLOC_BASE;
+
+	bc->baddr = (u64)masterwid << 60;
+	bc->baddr |= (1UL << 56);	/* Barrier set */
+
+	/* point to this bridge */
+	bridge = (bridge_t *) RAW_NODE_SWIN_BASE(nasid, widget_id);
+
+	bc->bridge_rev		= bridge->b_wid_id >> 28;
+
+	/* Clear all pending interrupts. */
+	bridge->b_int_rst_stat = BRIDGE_IRR_ALL_CLR;
+
+	/* Until otherwise set up, assume all interrupts are from slot 0 */
+	bridge->b_int_device = 0x0;
+
+	/* Fix the initial b_device configuration. */
+	bridge->b_wid_control &= ~(BRIDGE_CTRL_IO_SWAP | BRIDGE_CTRL_MEM_SWAP);
+
+	for (i = 0; i < 8; i++)
+		bridge->b_device[i].reg = BRIDGE_DEV_ERR_LOCK_EN | BRIDGE_DEV_VIRTUAL_EN |
+					  BRIDGE_DEV_PMU_WRGA_EN | BRIDGE_DEV_DIR_WRGA_EN |
+					  BRIDGE_DEV_SWAP_PMU | BRIDGE_DEV_SWAP_DIR | 
+					  BRIDGE_DEV_COH;
+
+	/* Configure direct-mapped DMA */
+	bridge->b_dir_map = (masterwid << BRIDGE_DIRMAP_W_ID_SHFT) | BRIDGE_DIRMAP_ADD512;
+
+	/*
+	 * Allocate the RRBs randomly.
+	 *
+	 * No, I'm joking :)
+	 * These are occult numbers of the Black Priesthood of Ancient Mu.
+	 */
+	bridge->b_even_resp = PCIBR_ANCIENT_MU_EVEN_RESP;
+	bridge->b_odd_resp = PCIBR_ANCIENT_MU_ODD_RESP;
+
+	/*
+	 * Route all PCI bridge interrupts to the HEART ASIC. The idea is
+	 * that we cause the bridge to send an Xtalk write to a specified
+	 * interrupt register (0x80 for HEART, 0x90 for HUB) in a defined
+	 * widget. The actual IRQ support and masking is done elsewhere.
+	 */
+	bridge->b_wid_int_upper = masterwid << 16;
+	bridge->b_wid_int_lower = PCIBR_XIO_SEES_HEART;
+
+	/* We map the IRQs to slots in a straightforward way. */
+	bc->irq_base = ip30_irq_assigned;
+	for (i = 0; i < 8; i++) {
+		bridge->b_int_addr[i].addr = ip30_irq_assigned;
+		ip30_irq_bridge[ip30_irq_assigned] = bridge;
+		ip30_irq_in_bridge[ip30_irq_assigned] = i;
+		ip30_irq_assigned++;
+	}
+	bridge->b_int_device &= PCIBR_ANCIENT_MU_INT_DEVICE;
+	bridge->b_int_enable = PCIBR_ANCIENT_MU_INT_ENABLE;
+	bridge->b_int_mode = PCIBR_ANCIENT_MU_INT_MODE;
+	ip30_bridge_count++;
+
+	bridge->b_wid_tflush;     /* wait until Bridge PIO complete */
+
+	bc->base = bridge;
+
+	register_pci_controller(&bc->pc);
+
+	num_bridges++;
+
+	return 0;
+}
+
+int __devinit pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+
+	return (bc->irq_base + slot);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static inline void pci_disable_swapping_pio(struct pci_dev *dev)
+{
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+
+	bc->slot_be[PCI_SLOT(dev->devfn)] = 1;
+}
+
+static inline void pci_disable_swapping_dma(struct pci_dev *dev)
+{
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+	bridge_t *bvma = (bridge_t *)bc->base;
+	unsigned int devio;
+	int slot = PCI_SLOT(dev->devfn);
+
+	bc->slot_bs[slot] = 1;
+	devio = bvma->b_device[slot].reg;
+	devio &= ~(BRIDGE_DEV_SWAP_PMU | BRIDGE_DEV_SWAP_DIR);
+	bvma->b_device[slot].reg = devio;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
+	pci_disable_swapping_dma);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_RAD1,
+	pci_disable_swapping_dma);
diff -Naurp linux-2.6.26.orig/arch/mips/pci/pci.c linux-2.6.26/arch/mips/pci/pci.c
--- linux-2.6.26.orig/arch/mips/pci/pci.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/arch/mips/pci/pci.c	2008-07-25 03:14:40.000000000 -0400
@@ -77,6 +77,10 @@ pcibios_align_resource(void *data, struc
 
 void __devinit register_pci_controller(struct pci_controller *hose)
 {
+	if (hose->pre_scan)
+		if(hose->pre_scan(hose) < 0)
+			goto out;
+
 	if (request_resource(&iomem_resource, hose->mem_resource) < 0)
 		goto out;
 	if (request_resource(&ioport_resource, hose->io_resource) < 0) {
@@ -145,6 +149,10 @@ static int __init pcibios_init(void)
 		hose->need_domain_info = need_domain_info;
 		if (bus) {
 			next_busno = bus->subordinate + 1;
+ 
+ 			if (hose->post_scan)
+ 				hose->post_scan(hose, bus);
+
 			/* Don't allow 8-bit bus number overflow inside the hose -
 			   reserve some space for bridges. */
 			if (next_busno > 224) {
@@ -168,6 +176,7 @@ static int pcibios_enable_resources(stru
 	u16 cmd, old_cmd;
 	int idx;
 	struct resource *r;
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
@@ -176,6 +185,10 @@ static int pcibios_enable_resources(stru
 		if (!(mask & (1<<idx)))
 			continue;
 
+		if(hose->pre_enable)
+			if(hose->pre_enable(hose, dev, idx) < 0)
+				return -EINVAL;
+
 		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/Makefile linux-2.6.26/arch/mips/sgi-ip30/Makefile
--- linux-2.6.26.orig/arch/mips/sgi-ip30/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/Makefile	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,8 @@
+#
+# Makefile for the IP30 specific kernel interface routines under Linux.
+#
+
+obj-y	:= ip30-setup.o ip30-irq.o ip30-timer.o ip30-err.o ip30-xtalk.o ip30-power.o
+obj-$(CONFIG_SMP)	+= ip30-smp.o ip30-smp-glue.o
+
+EXTRA_AFLAGS := $(CFLAGS)
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-err.c linux-2.6.26/arch/mips/sgi-ip30/ip30-err.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-err.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-err.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,42 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-err.c: HEART error handling for IP30 architecture.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+
+#include <asm/mach-ip30/heart.h>
+
+void ip30_do_err(void)
+{
+	unsigned long errors = *HEART_ISR;
+	int i;
+	irq_enter();
+	*HEART_CLR_ISR = HEART_INT_LEVEL4;
+	printk("IP30: HEART ATTACK! Caught errors: 0x%04x!\n",
+		(int)((errors >> HEART_ERR_MASK_START) & HEART_ERR_MASK));
+	for(i = HEART_ERR_MASK_END; i >= HEART_ERR_MASK_START; i--)
+		if ((errors >> i) & 1)
+			printk("    interrupt #%d\n", i);
+	irq_exit();
+}
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-irq.c linux-2.6.26/arch/mips/sgi-ip30/ip30-irq.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-irq.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-irq.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,337 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-irq.c: Highlevel interrupt handling for IP30 architecture.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ *
+ * Inspired by ip27-irq.c and ip32-irq.c
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+
+#include <asm/mach-ip30/heart.h>
+#include <asm/mach-ip30/pcibr.h>
+#include <asm/mach-ip30/racermp.h>
+#include <asm/pci/bridge.h>
+
+#undef DEBUG_IRQ
+#undef DEBUG_IRQ_SET
+
+#define DYNAMIC_IRQ_START 64
+
+#ifndef CONFIG_SMP
+#define cpu_logical_map(x) 0
+#define cpu_next_pcpu(x) 0
+#else
+extern int cpu_next_pcpu(int pcpu);
+#endif
+
+/* CPU IRQ */
+
+void ip30_timer_bcast(void);
+
+void cpu_do_irq(void)
+{
+#ifdef CONFIG_SMP
+	ip30_timer_bcast();
+#endif
+	do_IRQ(TIMER_IRQ);
+}
+
+static void enable_cpu_irq(unsigned int irq)
+{
+	set_c0_status(STATUSF_IP7);
+}
+
+static unsigned int startup_cpu_irq(unsigned int irq)
+{
+	enable_cpu_irq(irq);
+	return 0;
+}
+
+static void disable_cpu_irq(unsigned int irq)
+{
+	clear_c0_status(STATUSF_IP7);
+}
+
+static void end_cpu_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		enable_cpu_irq(irq);
+}
+
+#define shutdown_cpu_irq disable_cpu_irq
+#define mask_and_ack_cpu_irq disable_cpu_irq
+
+static struct irq_chip ip30_cpu_irq = {
+	.typename = "CPU",
+	.startup = startup_cpu_irq,
+	.shutdown = shutdown_cpu_irq,
+	.enable = enable_cpu_irq,
+	.disable = disable_cpu_irq,
+	.ack = mask_and_ack_cpu_irq,
+	.end = end_cpu_irq,
+};
+
+/* real HEART IRQs */
+
+int heart_irq_thisowner;
+static int heart_irq_owner[SOFT_IRQ_COUNT];
+
+void ip30_do_irq(void)
+{
+	unsigned int pcpu=cpu_logical_map(smp_processor_id());
+	unsigned long irqs=((*HEART_ISR) & HEART_ATK_MASK) & (*HEART_IMR(pcpu));
+	unsigned long irqsel;
+	int irqnum;
+#ifdef DEBUG_IRQ
+	bridge_t *bvma = (bridge_t *)RAW_NODE_SWIN_BASE(0, 15);
+	if(irqs & ~(15UL << IRQ_TIMER_P(0)))
+		printk("IP30: received HEART IRQs: 0x%016lx (mask 0x%016lx) PCPU%d BRIDGE %08x\n",
+			*HEART_ISR, *HEART_IMR(pcpu), pcpu, bvma->b_int_status);
+#endif
+	/* check for all IRQs in decreasing priority order */
+	irqsel = NON_HEART_IRQ_ST;
+	irqnum = 50;
+
+	/* poll all interrupts according to priority */
+	while (irqsel) {
+		if(irqs & irqsel)
+			do_IRQ(irqnum);
+		irqsel >>= 1;
+		irqnum--;
+	}
+}
+
+static void enable_heart_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	*HEART_IMR(heart_irq_owner[irq]) |= (1UL << irq);
+	local_irq_restore(flags);
+}
+
+static unsigned int startup_heart_irq(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int device;
+	unsigned int pcpu;
+	if (irq == 14 || irq == 15)
+		pcpu = 0;
+	else if (irq < IRQ_TIMER_P(0) || irq > IRQ_IPI_P(3))
+		pcpu = heart_irq_thisowner = cpu_next_pcpu(heart_irq_thisowner);
+	else
+		pcpu = cpu_logical_map(smp_processor_id());
+#ifdef DEBUG_IRQ_SET
+	printk("IP30: start up IRQ%d for PCPU%d\n", irq, pcpu);
+#endif
+	local_irq_save(flags);
+
+	if (heart_irq_owner[irq] != -1) {
+		printk(KERN_ERR "IP30: ambiprocessorous IRQ startup request (is %d, was %d).\n",
+			pcpu, heart_irq_owner[irq]);
+		local_irq_restore(flags);
+		return 0;
+	}
+
+	heart_irq_owner[irq] = pcpu;
+	*HEART_CLR_ISR = (1UL << irq);				/* clear IRQ flag */
+	*HEART_IMR(heart_irq_owner[irq]) |= (1UL << irq);	/* unmask IRQ */
+
+	if (ip30_irq_bridge[irq]) {
+		ip30_irq_bridge[irq]->b_int_enable |= (1 << ip30_irq_in_bridge[irq]);
+		ip30_irq_bridge[irq]->b_int_mode |= (1 << ip30_irq_in_bridge[irq]);
+		device = ip30_irq_bridge[irq]->b_int_device;
+		device &= ~(7 << (ip30_irq_in_bridge[irq] * 3));
+		device |= (ip30_irq_in_bridge[irq] << (ip30_irq_in_bridge[irq] * 3));
+		ip30_irq_bridge[irq]->b_int_device = device;
+		ip30_irq_bridge[irq]->b_widget.w_tflush;
+	}
+
+	local_irq_restore(flags);
+
+	/* This is probably not right; we could have pending irqs */
+	return 0;
+}
+
+static void disable_heart_irq(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	*HEART_IMR(heart_irq_owner[irq]) &= ~(1UL << irq);
+	local_irq_restore(flags);
+}
+
+static void shutdown_heart_irq(unsigned int irq)
+{
+	unsigned long flags;
+#ifdef DEBUG_IRQ_SET
+	printk("IP30: shutdown IRQ%d\n", irq);
+#endif
+	local_irq_save(flags);
+	*HEART_IMR(heart_irq_owner[irq]) &= ~(1UL << irq);		/* mask IRQ */
+	if (ip30_irq_bridge[irq])
+		ip30_irq_bridge[irq]->b_int_enable &= ~(1 << ip30_irq_in_bridge[irq]);
+	heart_irq_owner[irq] = -1;
+	local_irq_restore(flags);
+}
+
+static void mask_and_ack_heart_irq (unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	if (irq >= IRQ_TIMER_P(0) && irq <= IRQ_IPI_P(3))
+		*HEART_CLR_ISR = (1UL << irq);
+	if (!ip30_irq_bridge[irq])
+		*HEART_ISR = (1UL << irq);
+	*HEART_IMR(heart_irq_owner[irq]) &= ~(1UL << irq);
+	local_irq_restore(flags);
+}
+
+static void end_heart_irq(unsigned int irq)
+{
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		enable_heart_irq(irq);
+}
+
+static struct irq_chip ip30_heart_irq = {
+	.typename = "HEART",
+	.startup = startup_heart_irq,
+	.shutdown = shutdown_heart_irq,
+	.enable = enable_heart_irq,
+	.disable = disable_heart_irq,
+	.ack = mask_and_ack_heart_irq,
+	.end = end_heart_irq,
+};
+
+/* dynamic pseudo-IRQs */
+
+static void do_nothing_irq(unsigned int irq)
+{
+	/* Empty */
+}
+
+static unsigned int do_nothing_irq_i(unsigned int irq)
+{
+	return 0;
+}
+
+static struct irq_chip dynamic_allocated_irq = {
+	.typename = "Allocated",
+	.startup = do_nothing_irq_i,
+	.shutdown = do_nothing_irq,
+	.enable = do_nothing_irq,
+	.disable = do_nothing_irq,
+	.ack = do_nothing_irq,
+	.end = do_nothing_irq,
+};
+
+static struct irq_chip dynamic_free_irq = {
+	.typename = "Free",
+	.startup = do_nothing_irq_i,
+	.shutdown = do_nothing_irq,
+	.enable = do_nothing_irq,
+	.disable = do_nothing_irq,
+	.ack = do_nothing_irq,
+	.end = do_nothing_irq,
+};
+
+int new_dynamic_irq(void)
+{
+	int i;
+	for (i = 0; i < NR_IRQS; i++)
+		if(irq_desc[i].chip == &dynamic_free_irq)
+			break;
+	if ( i== NR_IRQS)
+		return -1;
+	irq_desc[i].chip = &dynamic_allocated_irq;
+	return i;
+}
+
+void delete_dynamic_irq(int irq)
+{
+	irq_desc[irq].chip = &dynamic_free_irq;
+}
+
+void call_dynamic_irq(int irq)
+{
+	do_IRQ(irq);
+}
+
+/* setup procedure */
+
+extern void ip30_do_err(void);
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause();
+
+	if (likely(pending & (IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3)))
+		ip30_do_irq();
+	else if (unlikely(pending & IE_IRQ4))
+		ip30_do_err();
+	else if (unlikely(pending & IE_IRQ5))
+		cpu_do_irq();
+}
+
+void __init arch_init_irq(void)
+{
+	int i;
+	*HEART_CLR_ISR = HEART_ACK_ALL_MASK;	/* acknowledge everything */
+	for (i = 0; i < MP_NCPU; i++)		/* mask all IRQs, leave errors on */
+		*HEART_IMR(i) = HEART_CLR_ALL_MASK;
+
+	*HEART_IMR(cpu_logical_map(0)) = HEART_BR_ERR_MASK;
+
+	for (i = 0; i < SOFT_IRQ_COUNT; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth  = 1;
+		irq_desc[i].chip   = &ip30_heart_irq;
+		heart_irq_owner[i] = -1;
+	}
+
+	irq_desc[TIMER_IRQ].status = IRQ_DISABLED;
+	irq_desc[TIMER_IRQ].action = 0;
+	irq_desc[TIMER_IRQ].depth  = 1;
+	irq_desc[TIMER_IRQ].chip   = &ip30_cpu_irq;
+
+	for ( i = DYNAMIC_IRQ_START; i < NR_IRQS; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth  = 1;
+		irq_desc[i].chip   = &dynamic_free_irq;
+	}
+
+	/* mask IP0, IP1 (sw int) */
+	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP5 | STATUSF_IP6);
+	set_c0_status(ST0_IE);
+	printk("IP30: interrupt controller initialized.\n");
+}
+
+void ip30_secondary_init_irq(void)
+{
+	int pcpu = cpu_logical_map(smp_processor_id());
+	*HEART_IMR(pcpu) = HEART_CLR_ALL_MASK;
+	change_c0_status(ST0_IM, STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 |
+				 STATUSF_IP5 | STATUSF_IP6);
+}
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-power.c linux-2.6.26/arch/mips/sgi-ip30/ip30-power.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-power.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-power.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,132 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-power.c: Software powerdown and reset handling for IP30 architecture.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/time.h>
+#include <linux/console.h>
+#include <linux/tty.h>
+#include <linux/delay.h>
+
+#include <asm/mach-ip30/addrs.h>
+#include <asm/mach-ip30/heart.h>
+#include <asm/mach-ip30/racermp.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/pci/bridge.h>
+
+#define IP30_POWER_IRQ	14
+#define IP30_ACFAIL_IRQ	15
+
+void ip30_machine_restart(char *command)
+{
+	printk("Rebooting...");
+#ifdef CONFIG_SMP
+	smp_send_stop();
+	udelay(1000);
+#endif
+	/* execute HEART cold reset
+	 *	Yes, it's cold-HEARTed! */
+	*HEART_MODE |= (1UL << 23);
+}
+
+void ip30_soft_powerdown(void);
+int ip30_clear_power_irq(void);
+int ip30_can_powerdown(void);
+
+void ip30_machine_power_off(void)
+{
+#ifdef CONFIG_SGI_IP30_RTC	
+	int i;
+
+	if (!ip30_can_powerdown())
+		return;
+	printk("Powering down, please wait...");
+
+#ifdef CONFIG_SMP
+	smp_send_stop();
+	udelay(1000);
+#endif
+
+	/* kill interrupts */
+        *HEART_CLR_ISR = HEART_ACK_ALL_MASK;
+        for (i = 0; i < MP_NCPU; i++)
+                *HEART_IMR(i) = HEART_CLR_ALL_MASK;
+
+	/* execute RTC powerdown */
+	ip30_soft_powerdown();
+#else
+	printk("RTC support is required to power down.\n");
+	printk("System halted.\n");
+	while (1);
+#endif
+}
+
+void ip30_machine_halt(void)
+{
+	ip30_machine_power_off();
+}
+
+/* power button */
+static struct timer_list power_timer;
+
+static int is_shutdown;
+
+static void power_timeout(unsigned long data)
+{
+	ip30_machine_power_off();
+}
+
+static irqreturn_t power_irq(int irq, void *dev_id)
+{
+	/* prepare for next IRQs */
+#ifdef CONFIG_SGI_IP30_RTC
+	if (!ip30_clear_power_irq())
+#endif
+		disable_irq_nosync(irq);
+
+	/* button pressed twice or no init */
+	if (is_shutdown || kill_proc(1, SIGINT, 1)) {
+		printk(KERN_INFO "Immediate powerdown...\n");
+		ip30_machine_power_off();
+		return IRQ_HANDLED;
+	}
+
+	/* power button, set LEDs if we can */
+	is_shutdown = 1;
+	printk(KERN_INFO "Power button pressed, shutting down...\n");
+
+	init_timer(&power_timer);
+	power_timer.function = power_timeout;
+	power_timer.expires = jiffies + (30 * HZ);
+	add_timer(&power_timer);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t acfail_irq(int irq, void *dev_id)
+{
+	/* we have a bit of time here */
+	return IRQ_HANDLED;
+}
+
+static int __init reboot_setup(void)
+{
+	request_irq(IP30_POWER_IRQ, power_irq, 0, "powerbtn", NULL);
+	request_irq(IP30_ACFAIL_IRQ, acfail_irq, 0, "acfail", NULL);
+	return 0;
+}
+
+subsys_initcall(reboot_setup);
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-setup.c linux-2.6.26/arch/mips/sgi-ip30/ip30-setup.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-setup.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-setup.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,73 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * SGI IP30 specific setup.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *               2007 Joshua Kinard <kumba@gentoo.org>
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/time.h>
+#include <linux/console.h>
+#include <linux/tty.h>
+
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/mach-ip30/heart.h>
+#include <asm/mach-ip30/addrs.h>
+
+extern void ip30_machine_restart(char *command);
+extern void ip30_machine_halt(void);
+extern void ip30_machine_power_off(void);
+
+extern void ip30_xtalk_setup(void);
+
+extern void ip30_time_init(void);
+
+extern int ip30_locate_bootcpu(void);
+
+static unsigned long ip30_size_memory(void)
+{
+	unsigned long result = 0;
+	unsigned int *memcfg = (unsigned int *)HEART_MEMCFG0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		if(memcfg[i] & HEART_MEMCFG_VLD)
+			result += ((memcfg[i] & HEART_MEMCFG_RAM_MSK) 
+					>> HEART_MEMCFG_RAM_SHFT) + 1;
+	return result << HEART_MEMCFG_UNIT_SHFT;
+}
+
+
+static void ip30_fix_memory(void)
+{
+	unsigned long size = ip30_size_memory();
+	printk(KERN_INFO "Detected %ld MB of physical memory.\n", size >> 20);
+
+	if(size > IP30_MAX_PROM_MEM) {
+		printk(KERN_INFO "Updating PROM memory size.\n");
+		add_memory_region((IP30_MAX_PROM_MEM + IP30_MEM_BASE),
+					size - IP30_MAX_PROM_MEM, BOOT_MEM_RAM);
+	}
+}
+
+
+void __init plat_mem_setup(void)
+{
+	printk("Silicon Graphics Octane (IP30) support: (c) 2004-2007 Stanislaw Skowronek.\n");
+	set_io_port_base(IP30_IO_PORT_BASE);
+        _machine_restart  = ip30_machine_restart;
+        _machine_halt = ip30_machine_halt;
+        pm_power_off = ip30_machine_power_off;
+	ip30_fix_memory();
+	ip30_xtalk_setup();
+}
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-smp-glue.S linux-2.6.26/arch/mips/sgi-ip30/ip30-smp-glue.S
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-smp-glue.S	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-smp-glue.S	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,21 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Stanislaw Skowronek
+ */
+
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+	.text
+	.set	noat
+	.set	reorder
+	.align	5
+LEAF(ip30_smp_bootstrap)
+	move	gp, a0
+	j	smp_bootstrap
+	END(ip30_smp_bootstrap)
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-smp.c linux-2.6.26/arch/mips/sgi-ip30/ip30-smp.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-smp.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-smp.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,165 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-smp.c: SMP on IP30 architecture.
+ *
+ * Copyright (C) 2005-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *               2006-2007 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/spinlock.h>
+
+#include <asm/mmu_context.h>
+#include <asm/bootinfo.h>
+#include <asm/mach-ip30/heart.h>
+#include <asm/mach-ip30/racermp.h>
+#include <asm/mach-ip30/addrs.h>
+
+#undef DEBUG_IPI
+
+extern void asmlinkage ip30_smp_bootstrap(void);
+extern void plat_time_init(void);
+extern void ip30_secondary_init_irq(void);
+
+static spinlock_t ipi_mbx_lock = SPIN_LOCK_UNLOCKED;
+static volatile unsigned int ipi_mailbox[NR_CPUS];
+
+extern unsigned int (*mips_hpt_read)(void);
+extern void (*mips_hpt_init)(unsigned int);
+extern void ip30_secondary_timer_setup(void);
+
+static void ip30_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+#ifdef DEBUG_IPI
+	if(action == SMP_CALL_FUNCTION)
+		printk("KERN_INFO IPI call_function TX -> %d\n", cpu);
+#endif
+	spin_lock_irqsave(&ipi_mbx_lock, flags);
+	ipi_mailbox[cpu] |= action;
+	spin_unlock_irqrestore(&ipi_mbx_lock, flags);
+	*HEART_SET_ISR = 1UL << (IRQ_IPI_P(cpu));
+}
+
+static void ip30_send_ipi_mask(cpumask_t mask, unsigned int action)
+{
+        unsigned int i;
+
+        for_each_cpu_mask(i, mask)
+                ip30_send_ipi_single(i, action);
+}
+
+int cpu_next_pcpu(int pcpu)
+{
+	int i;
+	for (i = (pcpu + 1) % MP_NCPU; !cpu_isset(i, phys_cpu_present_map); i = (i + 1) % MP_NCPU)
+		if(i == pcpu)
+			return pcpu;
+	return i;
+}
+
+irqreturn_t ip30_mailbox_irq(int irq, void *dev)
+{
+	int cpu = smp_processor_id();
+	int mbx;
+	spin_lock(&ipi_mbx_lock);
+	mbx = ipi_mailbox[cpu];
+	ipi_mailbox[cpu] = 0;
+	spin_unlock(&ipi_mbx_lock);
+	if (mbx & SMP_RESCHEDULE_YOURSELF)
+		/* ignore - reschedule after IRQ */ ;
+	if (mbx & SMP_CALL_FUNCTION) {
+		smp_call_function_interrupt();
+#ifdef DEBUG_IPI
+		printk("KERN_INFO IPI call_function RX -> %d\n",
+			smp_processor_id());
+#endif
+	}
+	return IRQ_HANDLED;
+}
+
+void ip30_timer_bcast(void)
+{
+	int i;
+	for (i = 1; i < NR_CPUS; i++)
+		if (cpu_isset(i, cpu_present_map))
+			*HEART_SET_ISR = 1UL << (IRQ_TIMER_P(i));
+}
+
+irqreturn_t ip30_secondary_timer_irq(int irq, void *dev)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	local_irq_restore(flags);
+	return IRQ_HANDLED;
+}
+
+static void __init ip30_prepare_cpus(unsigned int max_cpus)
+{
+	/* everything should be ready by now */
+}
+
+static void __init ip30_smp_setup(void)
+{
+	int i, j;
+	
+	cpus_clear(phys_cpu_present_map);
+	for (i = 0, j = 0; i < MP_NCPU; i++)
+		if (MP_MAGIC(i) == MPCONF_MAGIC && MP_VIRTID(i) < NR_CPUS) {
+			cpu_set(i, phys_cpu_present_map);
+			__cpu_number_map[i] = MP_VIRTID(i);
+			__cpu_logical_map[MP_VIRTID(i)] = i;
+			j++;
+		}
+	printk("Detected %d enabled CPU(s).\n", j);
+}
+
+static void __cpuinit ip30_boot_secondary(int cpu, struct task_struct *idle)
+{
+	int pcpu = cpu_logical_map(cpu);
+	MP_STACKADDR(pcpu) = __KSTK_TOS(idle);
+	MP_LPARM(pcpu) = (unsigned long)idle->stack;
+	MP_LAUNCH(pcpu) = ip30_smp_bootstrap;
+}
+
+static void __cpuinit ip30_init_secondary(void)
+{
+	ip30_secondary_init_irq();
+}
+
+static void __cpuinit ip30_smp_finish(void)
+{
+	int cpu = smp_processor_id();
+	if (request_irq(IRQ_IPI_P(cpu), ip30_mailbox_irq, 0, "SMP IPI", NULL))
+		printk("IP30: IPI allocation for CPU%d failed.\n", cpu);
+	if (request_irq(IRQ_TIMER_P(cpu), ip30_secondary_timer_irq, 0, "SMP TIMER", NULL))
+		printk("IP30: TIMER allocation for CPU%d failed.\n", cpu);
+	local_irq_enable();
+}
+
+static void __init ip30_cpus_done(void)
+{
+	int cpu = smp_processor_id();
+	if (request_irq(IRQ_IPI_P(cpu), ip30_mailbox_irq, 0, "SMP IPI", NULL))
+		printk("IP30: IPI allocation for CPU%d failed.\n", cpu);
+}
+
+struct plat_smp_ops ip30_smp_ops = {
+	.send_ipi_single	= ip30_send_ipi_single,
+	.send_ipi_mask		= ip30_send_ipi_mask,
+	.init_secondary		= ip30_init_secondary,
+	.smp_finish		= ip30_smp_finish,
+	.cpus_done		= ip30_cpus_done,
+	.boot_secondary		= ip30_boot_secondary,
+	.smp_setup		= ip30_smp_setup,
+	.prepare_cpus		= ip30_prepare_cpus,
+};
+
+
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-timer.c linux-2.6.26/arch/mips/sgi-ip30/ip30-timer.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-timer.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-timer.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-timer.c: Timer handling for IP30 architecture.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ * Inspired by ip32-timer.c
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <asm/i8253.h>
+
+#include <asm/time.h>
+#include <asm/mipsregs.h>
+#include <asm/mmu_context.h>
+#include <asm/mach-ip30/heart.h>
+
+#define NSEC_PER_CYCLE		80
+#define CYCLES_PER_100MSEC	(100000000 / NSEC_PER_CYCLE)
+
+void __init plat_time_init(void)
+{
+	unsigned long heart_compare;
+	printk("IP30: initializing timer.\n");
+	heart_compare = (*HEART_COUNT) + CYCLES_PER_100MSEC;
+	write_c0_count(0);
+	while ((*HEART_COUNT - heart_compare) & 0x800000) ;
+	mips_hpt_frequency = read_c0_count() * 10;
+	printk("%d MHz CPU detected\n", (mips_hpt_frequency * 2) / 1000000);
+}
+
+unsigned int get_c0_compare_int(void) {
+	/* Return Octane's Timer IRQ */
+	return TIMER_IRQ;
+}
diff -Naurp linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-xtalk.c linux-2.6.26/arch/mips/sgi-ip30/ip30-xtalk.c
--- linux-2.6.26.orig/arch/mips/sgi-ip30/ip30-xtalk.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/arch/mips/sgi-ip30/ip30-xtalk.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,182 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * ip30-xtalk.c
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ *
+ * XIO bus probing code
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+
+#include <asm/mach-ip30/heart.h>
+#include <asm/mach-ip30/addrs.h>
+#include <asm/mach-ip30/pcibr.h>
+#include <asm/mach-ip30/xtalk.h>
+#include <asm/xtalk/xwidget.h>
+
+static struct widget_ident widget_idents[] = {
+	{
+		XTALK_XBOW_MFGR_ID,
+		XTALK_XBOW_PART_ID,
+		"XBow",
+		{NULL, "1.0", "1.1", "1.2", "1.3", "2.0", NULL}
+	},
+	{
+		XTALK_XXBOW_MFGR_ID,
+		XTALK_XXBOW_PART_ID,
+		"XXBow",
+		{NULL, "1.0", "2.0", NULL}
+	},
+	{
+		XTALK_ODYS_MFGR_ID,
+		XTALK_ODYS_PART_ID,
+		"Buzz / Odyssey",
+		{NULL, "A", "B", NULL}
+	},
+	{
+		XTALK_TPU_MFGR_ID,
+		XTALK_TPU_PART_ID,
+		"TPU",
+		{"0", NULL}
+	},
+	{
+		XTALK_XBRDG_MFGR_ID,
+		XTALK_XBRDG_PART_ID,
+		"XBridge",
+		{NULL, "A", "B", NULL}
+	},
+	{
+		XTALK_HEART_MFGR_ID,
+		XTALK_HEART_PART_ID,
+		"Heart",
+		{NULL, "A", "B", "C", "D", "E", "F", NULL}
+	},
+	{
+		XTALK_BRIDG_MFGR_ID,
+		XTALK_BRIDG_PART_ID,
+		"Bridge",
+		{NULL, "A", "B", "C", "D", NULL}
+	},
+	{
+		XTALK_HUB_MFGR_ID,
+		XTALK_HUB_PART_ID,
+		"Hub",
+		{NULL, "1.0", "2.0", "2.1", "2.2", "2.3", "2.4", NULL}
+	},
+	{
+		XTALK_BDRCK_MFGR_ID,
+		XTALK_BDRCK_PART_ID,
+		"Bedrock",
+		{NULL, "1.0", "1.1", NULL}
+	},
+	{
+		XTALK_IMPCT_MFGR_ID,
+		XTALK_IMPCT_PART_ID,
+		"HQ4 / ImpactSR",
+		{NULL, "A", "B", NULL}
+	},
+	{
+		XTALK_KONA_MFGR_ID,
+		XTALK_KONA_PART_ID,
+		"XG / KONA",
+		{NULL}
+	},
+	{
+		XTALK_NULL_MFGR_ID,
+		XTALK_NULL_PART_ID,
+		NULL,
+		{NULL}
+	}
+};
+
+extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
+
+unsigned long ip30_xtalk_swin(int wid)
+{
+	return NODE_SWIN_BASE(0, wid);
+}
+
+unsigned ip30_xtalk_get_id(int wid)
+{
+	unsigned int link_stat;
+	if (wid != XTALK_XBOW &&
+		(wid < XTALK_LOW_DEV || wid > XTALK_HIGH_DEV))
+			return XTALK_NODEV;
+
+	if (wid) {
+		link_stat = *(volatile unsigned int *)(RAW_NODE_SWIN_BASE(0, 0) + 
+				XBOW_REG_LINK_STAT_0 + 
+				XBOW_REG_LINK_BLOCK_SIZE * (wid - XTALK_LOW_DEV));
+		if (!(link_stat & XBOW_REG_LINK_ALIVE))	/* is the link alive? */
+			return XTALK_NODEV;
+	}
+
+	return *(volatile unsigned int *)(RAW_NODE_SWIN_BASE(0, wid) + WIDGET_ID);
+}
+
+int ip30_xtalk_find(unsigned mfgr, unsigned part, int last)
+{
+	unsigned wid_id;
+	while (last > 0) {
+		last--;
+		wid_id = ip30_xtalk_get_id(last);
+		if (XWIDGET_MFG_NUM(wid_id) == mfgr &&
+			XWIDGET_PART_NUM(wid_id) == part)
+				return last;
+	}
+	return -1;
+}
+
+void __init ip30_xtalk_setup(void)
+{
+	int i;
+	unsigned int wid_id;
+	unsigned int wid_part, wid_mfgr, wid_rev;
+	struct widget_ident *res;
+
+	for (i = 0; i < IP30_XTALK_NUM_WID; i++) {
+		wid_id = ip30_xtalk_get_id(i);
+		if (wid_id != XTALK_NODEV) {
+			printk(KERN_INFO "xtalk: Detected ");
+			wid_mfgr = XWIDGET_MFG_NUM(wid_id);
+			wid_part = XWIDGET_PART_NUM(wid_id);
+			wid_rev = XWIDGET_REV_NUM(wid_id);
+
+			for (res = widget_idents; res->name; res++)
+				if(res->mfgr == wid_mfgr && res->part == wid_part)
+					break;
+
+			if (res->name) {
+				printk(res->name);
+				if (res->revs[wid_rev])
+					printk(" (revision %s)", res->revs[wid_rev]);
+				else
+					printk(" (unknown revision %d)", wid_rev);
+			} else
+				printk("unknown widget 0x%08x", wid_id);
+			printk(" at %d.\n", i);
+		}
+	}
+
+	i = IP30_XTALK_NUM_WID;
+	while ((i = ip30_xtalk_find(PCIBR_XTALK_MFGR, PCIBR_XTALK_PART, i)) != -1)
+		bridge_probe(0, i, IP30_WIDGET_HEART);
+}
diff -Naurp linux-2.6.26.orig/drivers/char/Kconfig linux-2.6.26/drivers/char/Kconfig
--- linux-2.6.26.orig/drivers/char/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/char/Kconfig	2008-07-25 03:14:40.000000000 -0400
@@ -819,6 +819,17 @@ config SGI_IP27_RTC
 	  via the file /proc/rtc and its behaviour is set by various ioctls on
 	  /dev/rtc.
 
+config SGI_IP30_RTC
+	bool "SGI Octane RTC support"
+	depends on SGI_IP30 && SGI_IOC3
+	help
+	  If you say Y here and create a character special file /dev/rtc with
+	  major number 10 and minor number 135 using mknod ("man mknod"), you
+	  will get access to the real time clock built into your computer.
+	  Every SGI has such a clock built in. It reports status information
+	  via the file /proc/rtc and its behaviour is set by various ioctls on
+	  /dev/rtc.
+
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y && !IA64 && !ARM && !M32R && !MIPS && !SPARC && !FRV && !S390 && !SUPERH && !AVR32
@@ -866,6 +877,14 @@ config COBALT_LCD
 	  This option enables support for the LCD display and buttons found
 	  on Cobalt systems through a misc device.
 
+config SGI_IP30_LEDS
+	bool "SGI Octane LED support"
+	depends on SGI_IP30 && SGI_IOC3
+	help
+	  If you say Y here and create a character special file /dev/leds with
+	  major number 10 and minor number 42 using mknod ("man mknod"), you
+	  will be able to control the lightbar on your Octane.
+
 config DTLK
 	tristate "Double Talk PC internal speech card support"
 	depends on ISA
diff -Naurp linux-2.6.26.orig/drivers/char/Makefile linux-2.6.26/drivers/char/Makefile
--- linux-2.6.26.orig/drivers/char/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/char/Makefile	2008-07-25 03:14:40.000000000 -0400
@@ -76,6 +76,8 @@ obj-$(CONFIG_GEN_RTC)		+= genrtc.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
 obj-$(CONFIG_SGI_IP27_RTC)	+= ip27-rtc.o
+obj-$(CONFIG_SGI_IP30_LEDS) += ip30-leds.o
+obj-$(CONFIG_SGI_IP30_RTC) += ip30-rtc.o
 obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
diff -Naurp linux-2.6.26.orig/drivers/char/ip30-leds.c linux-2.6.26/drivers/char/ip30-leds.c
--- linux-2.6.26.orig/drivers/char/ip30-leds.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/char/ip30-leds.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,280 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ *	Driver for the LEDs in SGI Octane.
+ *
+ *	Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ */
+
+#include <linux/bcd.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
+#include <linux/delay.h>
+#include <linux/notifier.h>
+
+#include <linux/miscdevice.h>
+#include <asm/mach-ip30/leds.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#include <linux/ioc3.h>
+
+#define LEDS_STREAM_SIZE	4096
+
+
+/* hardware dependent LEDs driver */
+static struct ioc3_driver_data *ioc3 = NULL;
+static unsigned int leds_buff;
+
+static void ip30_leds_begin(void)
+{
+	leds_buff = ioc3->gpdr_shadow;
+}
+
+static void ip30_leds_set(int led, unsigned char state)
+{
+	state >>= 7;
+	leds_buff &= ~(1 << led);
+	leds_buff |= state << led;
+}
+
+static void ip30_leds_end(void)
+{
+	ioc3_gpio(ioc3, 3, leds_buff);
+}
+
+
+/* generic LEDs stream interpreter part */
+static spinlock_t leds_lock = SPIN_LOCK_UNLOCKED;
+static int leds_are_open = 0;
+static struct timer_list leds_timer;
+static unsigned char leds_stream[LEDS_STREAM_SIZE];
+static int leds_pc = 0;
+
+static void leds_timer_proc(unsigned long param)
+{
+	unsigned long timer_ms = 0;
+	int end_flag = 0;
+	unsigned char byte1, byte2;
+
+	ip30_leds_begin();
+
+	while (!end_flag) {
+		byte1 = leds_stream[leds_pc++];
+		byte2 = leds_stream[leds_pc++];
+
+		switch (byte1 >> 6) {
+		case LEDS_OP_SET:
+			ip30_leds_set(byte1 & 0x3f, byte2);
+			break;
+		case LEDS_OP_LOOP:
+			leds_pc = 0;
+		case LEDS_OP_WAIT:
+			timer_ms = ((unsigned long)byte2) << (byte1 & 0x3f);
+			end_flag = 1;
+			break;
+		case LEDS_OP_RSVD:
+			printk(KERN_INFO "ip30-leds: Stream to the future!\n");
+			leds_pc = 0;
+			timer_ms = 0;
+			end_flag = 1;
+			break;
+		}
+
+		if(leds_pc >= LEDS_STREAM_SIZE) {
+			printk(KERN_INFO "ip30-leds: The Neverending Stream?\n");
+			leds_pc = 0;
+			timer_ms = 0;
+			end_flag = 1;
+		}
+	}
+
+	ip30_leds_end();
+
+	if (timer_ms) {
+		timer_ms = (timer_ms * HZ) / 1000;
+		leds_timer.expires = jiffies + timer_ms;
+		add_timer(&leds_timer);
+	}
+}
+
+static int leds_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&leds_lock);
+	if (leds_are_open) {
+		spin_unlock_irq(&leds_lock);
+		return -EBUSY;
+	}
+	leds_are_open = 1;
+	del_timer(&leds_timer);
+	memset(leds_stream, 0xFF, LEDS_STREAM_SIZE);
+	spin_unlock_irq(&leds_lock);
+
+	return 0;
+}
+
+static int leds_release(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&leds_lock);
+	leds_are_open = 0;
+	leds_pc = 0;
+	leds_timer.expires = (jiffies + 1);
+	leds_timer.function = leds_timer_proc;
+	add_timer(&leds_timer);
+	spin_unlock_irq(&leds_lock);
+
+	return 0;
+}
+
+static ssize_t leds_write(struct file *file, const char *buf, size_t count, loff_t * ppos)
+{
+	if (count > LEDS_STREAM_SIZE)
+		return -ENOSPC;
+	copy_from_user(leds_stream, buf, count);
+	return count;
+}
+
+static struct file_operations leds_fops = {
+	.owner		= THIS_MODULE,
+	.open		= leds_open,
+	.write		= leds_write,
+	.release	= leds_release,
+};
+
+static struct miscdevice leds_dev= {
+	LEDS_MINOR,
+	"leds",
+	&leds_fops
+};
+
+
+/* special hacks */
+static int panic_event(struct notifier_block *this, unsigned long event,
+                      void *ptr)
+{
+	del_timer(&leds_timer);
+	memset(leds_stream, 0xFF, LEDS_STREAM_SIZE);
+
+	leds_stream[0] = 0x00;
+	leds_stream[1] = 0x00;
+	leds_stream[2] = 0x01;
+	leds_stream[3] = 0xFF;
+
+	leds_stream[4] = 0x49;
+	leds_stream[5] = 0x01;
+
+	leds_stream[6] = 0x01;
+	leds_stream[7] = 0x00;
+	leds_stream[8] = 0x00;
+	leds_stream[9] = 0xFF;
+
+	leds_stream[10] = 0x89;
+	leds_stream[11] = 0x01;
+
+	leds_pc = 0;
+	leds_timer.expires = (jiffies + 1);
+	leds_timer.function = leds_timer_proc;
+	add_timer(&leds_timer);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block panic_block = {
+	.notifier_call	= panic_event,
+};
+
+
+/* IOC3 SuperIO probe */
+static int ioc3led_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	int i, p = 0;
+	if (ioc3 || idd->class != IOC3_CLASS_BASE_IP30)
+		return 1; /* no sense in setting LEDs on the MENETs */
+
+	ioc3 = idd;
+
+	if (misc_register(&leds_dev)) {
+		printk(KERN_ERR "ip30-leds: There is no place for me here <sob, sniff>.\n");
+		return 1;
+	}
+
+	for (i = 0; i < 3; i++) {
+		leds_stream[p++] = 0x00;
+		leds_stream[p++] = 0x00;
+		leds_stream[p++] = 0x01;
+		leds_stream[p++] = 0xff;
+
+		leds_stream[p++] = 0x48;
+		leds_stream[p++] = 0x01;
+
+		leds_stream[p++] = 0x01;
+		leds_stream[p++] = 0x00;
+		leds_stream[p++] = 0x00;
+		leds_stream[p++] = 0xff;
+
+		leds_stream[p++] = 0x48;
+		leds_stream[p++] = 0x01;
+	}
+	leds_stream[p++] = 0x80;
+	leds_stream[p++] = 0x00;
+
+	init_timer(&leds_timer);
+	leds_timer.expires = (jiffies + 1);
+	leds_timer.function = leds_timer_proc;
+	add_timer(&leds_timer);
+
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	return 0;
+}
+
+static int ioc3led_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	if (ioc3 != idd)
+		return 1;
+
+	misc_deregister(&leds_dev);
+	ioc3 = NULL;
+	return 0;
+}
+
+
+/* entry/exit functions */
+static struct ioc3_submodule ioc3led_submodule = {
+	.name = "leds",
+	.probe = ioc3led_probe,
+	.remove = ioc3led_remove,
+	.owner = THIS_MODULE,
+};
+
+static int __init leds_init(void)
+{
+	ioc3_register_submodule(&ioc3led_submodule);
+	return 0;
+}
+
+static void __exit leds_exit (void)
+{
+	ioc3_unregister_submodule(&ioc3led_submodule);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) LEDS Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(leds_init);
+module_exit(leds_exit);
diff -Naurp linux-2.6.26.orig/drivers/char/ip30-rtc.c linux-2.6.26/drivers/char/ip30-rtc.c
--- linux-2.6.26.orig/drivers/char/ip30-rtc.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/char/ip30-rtc.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,417 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ *	Driver for the Maxim/Dallas DS1687 real time clock in SGI Octane.
+ *
+ *	Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		           2007 Joshua Kinard <kumba@gentoo.org>
+ *
+ *	Somewhat based on: ip27-rtc.c (userland interface code).
+ */
+
+#include <linux/bcd.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+#include <asm/mach-ip30/ds1687.h>
+
+
+/* physical access functions */
+extern spinlock_t rtc_lock;
+static struct ioc3_driver_data *ioc3 = NULL;
+
+static unsigned char ip30_rtc_read(int addr)
+{
+	RTC_ADDR = addr & 0x7f;		/* field is 7-bits wide */
+	return RTC_DATA;
+}
+
+static void ip30_rtc_write(int addr, unsigned char data)
+{
+	RTC_ADDR = addr & 0x7f;		/* field is 7-bits wide */
+	RTC_DATA = data;
+}
+
+
+/* RTC hardware driver */
+static void rtc_begin_access(int bank)
+{
+	unsigned char val = ip30_rtc_read(DS1687_CTRL_B);
+	unsigned long start = jiffies;
+	spin_lock_irq(&rtc_lock);
+	ip30_rtc_write(DS1687_CTRL_B, val | DS1687_BIT7);	/* SET bit */
+	val = ip30_rtc_read(DS1687_CTRL_A);
+	while (val & DS1687_BIT7) {				/* UIP bit */
+		udelay(10);
+
+		/* 137 is a magic number.  Don't touch! */
+		if (jiffies > start + 137) {
+			printk(KERN_ERR "ip30-rtc: RTC access lock timeout.\n");
+			return;
+		}
+		val = ip30_rtc_read(DS1687_CTRL_A);
+	}
+	ip30_rtc_write(DS1687_CTRL_A, (val & 0xef) | (bank << 4));
+}
+
+static void rtc_end_access(void)
+{
+	unsigned char val = ip30_rtc_read(DS1687_CTRL_B);
+	ip30_rtc_write(DS1687_CTRL_B, val & 0x7f);
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void get_rtc_time(struct rtc_time *rtc_tm)
+{
+	rtc_begin_access(1);
+	rtc_tm->tm_sec = ip30_rtc_read(DS1687_SECNDS);
+	rtc_tm->tm_min = ip30_rtc_read(DS1687_MINS);
+	rtc_tm->tm_hour = ip30_rtc_read(DS1687_HOUR);
+	rtc_tm->tm_mday = ip30_rtc_read(DS1687_DATE);
+	rtc_tm->tm_mon = ip30_rtc_read(DS1687_MONTH);
+	rtc_tm->tm_year = ip30_rtc_read(DS1687_YEAR);
+	rtc_tm->tm_year += ip30_rtc_read(DS1687_CENTURY) * 100;
+	rtc_end_access();
+
+	rtc_tm->tm_year -= 1900;
+	rtc_tm->tm_mon--;
+}
+
+static const unsigned char days_in_mo[] =
+{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
+
+static int set_rtc_time(struct rtc_time *rtc_tm)
+{
+	unsigned char mon, day, hrs, min, sec, leap_yr;
+	unsigned int yrs;
+
+	yrs = rtc_tm->tm_year + 1900;
+	mon = rtc_tm->tm_mon + 1;   /* tm_mon starts at zero */
+	day = rtc_tm->tm_mday;
+	hrs = rtc_tm->tm_hour;
+	min = rtc_tm->tm_min;
+	sec = rtc_tm->tm_sec;
+
+	leap_yr = ((!(yrs % 4) && (yrs % 100)) || !(yrs % 400));
+	if ((mon > 12) || (day == 0))
+		return -EINVAL;
+
+	if (day > (days_in_mo[mon] + ((mon == 2) && leap_yr)))
+		return -EINVAL;
+
+	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
+		return -EINVAL;
+
+	rtc_begin_access(1);
+	ip30_rtc_write(DS1687_SECNDS, sec);
+	ip30_rtc_write(DS1687_MINS, min);
+	ip30_rtc_write(DS1687_HOUR, hrs);
+	ip30_rtc_write(DS1687_DATE, day);
+	ip30_rtc_write(DS1687_MONTH, mon);
+	ip30_rtc_write(DS1687_YEAR, yrs % 100);
+	ip30_rtc_write(DS1687_CENTURY, yrs / 100);
+	rtc_end_access();
+
+	return 0;
+}
+
+
+/* power-down logic */
+static int ip30_soft_powerdown_called;
+static int ip30_clear_irq_called;
+
+int ip30_clear_power_irq(void)
+{
+	unsigned char val;
+
+	if (!ioc3) {
+		ip30_clear_irq_called = 1;
+		return 0;
+	}
+
+	spin_lock_irq(&rtc_lock);
+	val = ip30_rtc_read(DS1687_CTRL_A);
+	ip30_rtc_write(DS1687_CTRL_A, val | DS1687_BIT4);	/* select extended regs */
+	ip30_rtc_write(DS1687_EXT_CTRL_4A, 0x00);
+	spin_unlock_irq(&rtc_lock);
+	return 1;
+}
+
+int ip30_can_powerdown(void)
+{
+	if (!ioc3) {
+		ip30_soft_powerdown_called = 1;
+		return 0;
+	}
+	return 1;
+}
+
+void ip30_soft_powerdown(void)
+{
+	unsigned char val;
+	rtc_begin_access(1);
+
+	if (!ioc3) {
+		ip30_soft_powerdown_called = 1;
+		return;
+	}
+
+	/* prepare the RTC for waking us up so we don't wind up dead */
+	val = ip30_rtc_read(DS1687_EXT_CTRL_4B);
+	val &= 0x2a;
+	val |= 0x81;
+	ip30_rtc_write(DS1687_EXT_CTRL_4B, val);
+	rtc_end_access();
+
+	while (1) {
+		ip30_rtc_write(DS1687_EXT_CTRL_4A, DS1687_BIT3);	/* power down */
+		udelay(100000);
+	}
+
+	/* there is no way out */
+	/* (of mordor!) */
+}
+
+
+/* userland interface stuff */
+static int rtc_is_open = 0;
+
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg)
+{
+
+	struct rtc_time wtime;
+
+	switch (cmd) {
+	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
+		get_rtc_time(&wtime);
+		return copy_to_user((void *)arg, &wtime, sizeof wtime) ? -EFAULT : 0;
+
+	case RTC_SET_TIME:	/* Set the RTC */
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+
+		if (copy_from_user(&wtime, (struct rtc_time*)arg,
+				   sizeof(struct rtc_time)))
+			return -EFAULT;
+
+		return set_rtc_time(&wtime);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rtc_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+
+	if (rtc_is_open) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+
+	rtc_is_open = 1;
+	spin_unlock_irq(&rtc_lock);
+
+	return 0;
+}
+
+static int rtc_release(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+	rtc_is_open = 0;
+	spin_unlock_irq(&rtc_lock);
+
+	return 0;
+}
+
+static struct file_operations rtc_fops = {
+	.owner		= THIS_MODULE,
+	.ioctl		= rtc_ioctl,
+	.open		= rtc_open,
+	.release	= rtc_release,
+};
+
+static struct miscdevice rtc_dev=
+{
+	RTC_MINOR,
+	"rtc",
+	&rtc_fops
+};
+
+
+/* Info exported via "/proc/rtc". */
+static int rtc_get_status(char *buf)
+{
+	char *p;
+	struct rtc_time tm;
+
+	/* Just emulate the standard /proc/rtc */
+	p = buf;
+	get_rtc_time(&tm);
+
+	/*
+	 * There is no way to tell if the luser has the RTC set for local
+	 * time or for Universal Standard Time (GMT). Probably local though.
+	 */
+	p += sprintf(p,
+		     "rtc_time\t: %02d:%02d:%02d\n"
+		     "rtc_date\t: %04d-%02d-%02d\n"
+	 	     "rtc_epoch\t: %04u\n"
+		     "BCD\t\t: no\n"
+		     "24hr\t\t: yes\n",
+		     tm.tm_hour, tm.tm_min, tm.tm_sec,
+		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, 1900);
+
+	return  p - buf;
+}
+
+static int rtc_read_proc(char *page, char **start, off_t off,
+                                 int count, int *eof, void *data)
+{
+        int len = rtc_get_status(page);
+
+        if (len <= (off + count))
+		*eof = 1;
+
+        *start = (page + off);
+        len -= off;
+
+        if (len > count)
+		len = count;
+
+	/* Block negative time */
+        if (len < 0)
+		len = 0;
+
+        return len;
+}
+
+
+/* general MIPS compatibility */
+unsigned long read_persistent_clock(void)
+{
+	struct rtc_time tm;
+	if (ioc3) {
+		get_rtc_time(&tm);
+		return mktime((tm.tm_year + 1900), (tm.tm_mon + 1),
+			      tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
+	}
+
+	/* default value ??? */
+	return mktime(2004, 8, 23, 12, 15, 0);
+}
+
+int rtc_mips_set_time(unsigned long tim)
+{
+	struct rtc_time tm;
+	rtc_time_to_tm(tim, &tm);
+
+	if (ioc3)
+		set_rtc_time(&tm);
+
+	return 0;
+}
+
+
+/* IOC3 SuperIO probe */
+static int ioc3rtc_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	struct rtc_time wtime;
+
+	if (ioc3 || idd->class != IOC3_CLASS_BASE_IP30)
+		return 1; /* this is good and proper */
+
+	ioc3 = idd;
+
+	if (misc_register(&rtc_dev)) {
+		printk(KERN_ERR "ip30-rtc: Cannot register device.\n");
+		return 1;
+	}
+
+	if (!create_proc_read_entry("driver/rtc", 0, NULL, rtc_read_proc, NULL)) {
+		printk(KERN_ERR "ip30-rtc: Cannot create procfs entry.\n");
+		misc_deregister(&rtc_dev);
+		return 1;
+	}
+
+	/* can we set xtime here? */
+	get_rtc_time(&wtime);
+	write_seqlock_irq(&xtime_lock);
+	xtime.tv_sec = mktime((wtime.tm_year + 1900), (wtime.tm_mon + 1),
+			      wtime.tm_mday, wtime.tm_hour, wtime.tm_min,
+			      wtime.tm_sec);
+	xtime.tv_nsec = 0;
+	set_normalized_timespec(&wall_to_monotonic,
+	                        -xtime.tv_sec, -xtime.tv_nsec);
+
+	write_sequnlock_irq(&xtime_lock);
+
+	ip30_clear_power_irq();
+
+	if (ip30_clear_irq_called)
+		enable_irq(14);
+
+	if (ip30_soft_powerdown_called)
+		ip30_soft_powerdown();
+
+	return 0;
+}
+
+static int ioc3rtc_remove(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
+{
+	if (ioc3 != idd)
+		return 1;
+
+	misc_deregister(&rtc_dev);
+
+	/* TODO: kill proc, although this driver should not be removable anyway */
+	ioc3 = NULL;
+	return 0;
+}
+
+
+/* entry/exit functions */
+static struct ioc3_submodule ioc3rtc_submodule = {
+	.name = "rtc",
+	.probe = ioc3rtc_probe,
+	.remove = ioc3rtc_remove,
+	.owner = THIS_MODULE,
+};
+
+static int __init rtc_init(void)
+{
+	ioc3_register_submodule(&ioc3rtc_submodule);
+	return 0;
+}
+
+static void __exit rtc_exit (void)
+{
+	ioc3_unregister_submodule(&ioc3rtc_submodule);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) RTC Interface Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(rtc_init);
+module_exit(rtc_exit);
diff -Naurp linux-2.6.26.orig/drivers/usb/host/pci-quirks.c linux-2.6.26/drivers/usb/host/pci-quirks.c
--- linux-2.6.26.orig/drivers/usb/host/pci-quirks.c	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/usb/host/pci-quirks.c	2008-07-25 03:14:40.000000000 -0400
@@ -147,6 +147,9 @@ static void __devinit quirk_usb_handoff_
 	unsigned long base = 0;
 	int i;
 
+	if (!pci_enable_device(pdev))
+		return;
+
 	if (!pio_enabled(pdev))
 		return;
 
diff -Naurp linux-2.6.26.orig/drivers/video/Kconfig linux-2.6.26/drivers/video/Kconfig
--- linux-2.6.26.orig/drivers/video/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/video/Kconfig	2008-07-25 03:14:40.000000000 -0400
@@ -955,6 +955,18 @@ config FB_ATMEL_STN
 
 	  If unsure, say N.
 
+config FB_IMPACTSR
+	tristate "SGI Octane ImpactSR graphics support"
+	depends on FB && SGI_IP30
+	help
+	  SGI Octane ImpactSR (SI/SSI/MXI/SE/SSE/MXE) graphics card support.
+
+config FB_ODYSSEY
+	tristate "SGI Octane Odyssey graphics support"
+	depends on FB && SGI_IP30
+	help
+	  SGI Octane Odyssey (VPro V6/V8/V10/V12) graphics card support.
+
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
 	depends on FB && PCI
diff -Naurp linux-2.6.26.orig/drivers/video/Makefile linux-2.6.26/drivers/video/Makefile
--- linux-2.6.26.orig/drivers/video/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/video/Makefile	2008-07-25 03:15:47.000000000 -0400
@@ -117,6 +117,8 @@ obj-$(CONFIG_FB_SM501)            += sm5
 obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
+obj-$(CONFIG_FB_IMPACTSR)         += impactsr.o
+obj-$(CONFIG_FB_ODYSSEY)          += odyssey.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff -Naurp linux-2.6.26.orig/drivers/video/impactsr.c linux-2.6.26/drivers/video/impactsr.c
--- linux-2.6.26.orig/drivers/video/impactsr.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/video/impactsr.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,994 @@
+/*
+ * linux/drivers/video/impactsr.c -- SGI Octane MardiGras (IMPACTSR) graphics
+ *
+ *  Copyright (c) 2004 by Stanislaw Skowronek
+ *
+ *  Based on linux/drivers/video/skeletonfb.c
+ *
+ *  This driver, as most of the IP30 (SGI Octane) port, is a result of massive
+ *  amounts of reverse engineering and trial-and-error. If anyone is interested
+ *  in helping with it, please contact me: <skylark@linux-mips.org>.
+ *
+ *  The basic functions of this driver are filling and blitting rectangles.
+ *  To achieve the latter, two DMA operations are used on Impact. It is unclear
+ *  to me, why is it so, but even Xsgi (the IRIX X11 server) does it this way.
+ *  It seems that fb->fb operations are not operational on these cards.
+ *
+ *  For this purpose, a kernel DMA pool is allocated (pool number 0). This pool
+ *  is (by default) 64kB in size. An ioctl could be used to set the value at
+ *  run-time. Applications can use this pool, however proper locking has to be
+ *  guaranteed. Kernel should be locked out from this pool by an ioctl.
+ *
+ *  The IMPACTSR is quite well worked-out currently, except for the Geometry
+ *  Engines (GE11). Any information about use of those devices would be very
+ *  useful. It would enable a Linux OpenGL driver, as most of OpenGL calls are
+ *  supported directly by the hardware. So far, I can't initialize the GE11.
+ *  Verification of microcode crashes the graphics.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/font.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ip30/xtalk.h>
+#include <video/impactsr.h>
+
+#define IMPACTSR_KPOOL_SIZE	65536
+
+struct impactsr_par {
+	/* physical mmio base in HEART XTalk space */
+	unsigned long mmio_base;
+
+	/* virtual mmio base in kernel space */
+	unsigned long mmio_virt;
+
+	/* DMA pool management */
+	unsigned int *pool_txtbl[5];
+	unsigned int pool_txnum[5];
+	unsigned int pool_txmax[5];
+	unsigned long pool_txphys[5];
+
+	/* kernel DMA pools */
+	unsigned long **kpool_virt[5];
+	unsigned long *kpool_phys[5];
+	unsigned int kpool_size[5];
+
+	/* board config */
+	unsigned int num_ge, num_rss;
+
+	/* locks to prevent simultaneous user and kernel access */
+	int open_flag;
+	spinlock_t lock;
+};
+
+static struct fb_fix_screeninfo impactsr_fix = {
+	.id =		"ImpactSR 0RSS", 
+	.smem_start = 	0,
+	.smem_len =	0,
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_TRUECOLOR,
+	.xpanstep =	0,
+	.ypanstep =	0,
+	.ywrapstep =	0, 
+	.line_length =	0,
+	.accel =	FB_ACCEL_SGI_IMPACTSR,
+};
+
+static struct fb_var_screeninfo impactsr_var = {
+	.xres =		1280,
+	.yres =		1024,
+	.xres_virtual =	1280,
+	.yres_virtual =	1024,
+	.bits_per_pixel = 24,
+	.red =		{ .offset = 0, .length = 8 },
+	.green =	{ .offset = 8, .length = 8 },
+	.blue =		{ .offset = 16, .length = 8 },
+	.transp =	{ .offset = 24, .length = 8 },
+};
+
+static struct fb_info info;
+static unsigned int pseudo_palette[256];
+static struct impactsr_par current_par;
+int impactsr_init(void);
+
+
+/* --------------------- Gory Details --------------------- */
+#define MMIO (((struct impactsr_par *)p->par)->mmio_virt)
+#define PAR (*((struct impactsr_par *)p->par))
+
+static void impactsr_wait_cfifo(struct fb_info *p, int nslots)
+{
+	while ((IMPACTSR_FIFOSTATUS(MMIO) & 0xff) > (IMPACTSR_CFIFO_MAX - nslots));
+}
+
+static void impactsr_wait_cfifo_empty(struct fb_info *p)
+{
+	while (IMPACTSR_FIFOSTATUS(MMIO) & 0xff);
+}
+
+static void impactsr_wait_bfifo(struct fb_info *p, int nslots)
+{
+	while ((IMPACTSR_GIOSTATUS(MMIO) & 0x1f) > (IMPACTSR_BFIFO_MAX - nslots));
+}
+
+static void impactsr_wait_bfifo_empty(struct fb_info *p)
+{
+	while (IMPACTSR_GIOSTATUS(MMIO) & 0x1f);
+}
+
+static void impactsr_wait_dma(struct fb_info *p)
+{
+	while (IMPACTSR_DMABUSY(MMIO) & 0x1f);
+	while (!(IMPACTSR_STATUS(MMIO) & 1));
+	while (!(IMPACTSR_STATUS(MMIO) & 2));
+	while (!(IMPACTSR_RESTATUS(MMIO) & 0x100));
+}
+static void impactsr_wait_dmaready(struct fb_info *p)
+{
+	IMPACTSR_CFIFOW(MMIO) = 0x000e0100;
+	while (IMPACTSR_DMABUSY(MMIO) & 0x1eff);
+	while (!(IMPACTSR_STATUS(MMIO) & 2));
+}
+
+static void impactsr_inithq4(struct fb_info *p)
+{
+	/* CFIFO parameters */
+	IMPACTSR_CFIFO_HW(MMIO) = 0x47;
+	IMPACTSR_CFIFO_LW(MMIO) = 0x14;
+	IMPACTSR_CFIFO_DELAY(MMIO) = 0x64;
+
+	/* DFIFO parameters */
+	IMPACTSR_DFIFO_HW(MMIO) = 0x40;
+	IMPACTSR_DFIFO_LW(MMIO) = 0x10;
+	IMPACTSR_DFIFO_DELAY(MMIO) = 0;
+}
+
+static void impactsr_initrss(struct fb_info *p)
+{
+	/* transfer mask registers */
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKMSBS(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMASKLO(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMASKHI(0xffffff);
+
+	/* use the main plane */
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_DRBPOINTERS(0xc8240);
+
+	/* set the RE into vertical flip mode */
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xcac);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XYWIN(0, 0x3ff);
+}
+
+static void impactsr_initxmap(struct fb_info *p)
+{
+	/* set XMAP into 24-bpp mode */
+	IMPACTSR_XMAP_PP1SELECT(MMIO) = 0x01;
+	IMPACTSR_XMAP_INDEX(MMIO) = 0x00;
+	IMPACTSR_XMAP_MAIN_MODE(MMIO) = 0x07a4;
+}
+
+static void impactsr_initvc3(struct fb_info *p)
+{
+	/* cursor-b-gone (disable DISPLAY bit) */
+	IMPACTSR_VC3_INDEXDATA(MMIO) = 0x1d000100;
+}
+
+static void impactsr_initdma(struct fb_info *p)
+{
+	unsigned long pool;
+	/* clear DMA pools */
+	for (pool = 0; pool < 5; pool++) {
+		impactsr_wait_cfifo_empty(p);
+		IMPACTSR_CFIFOPW(MMIO) = IMPACTSR_CMD_HQ_TXBASE(pool);
+		IMPACTSR_CFIFOP(MMIO) = 0x0000000000000009;
+		IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_TXMAX(pool, 0);
+		IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_PGBITS(pool, 0);
+		IMPACTSR_CFIFOP(MMIO) = 0x00484b0400080000|(pool << 40);
+		PAR.pool_txmax[pool] = 0;
+		PAR.pool_txnum[pool] = 0;
+	}
+
+	/* set DMA parameters */
+	IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_PGSIZE(0);
+	IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_STACKPTR(0);
+	IMPACTSR_CFIFOP(MMIO) = 0x00484a0400180000;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_REG32(MMIO,0x40918) = 0x00680000;
+	IMPACTSR_REG32(MMIO,0x40920) = 0x80280000;
+	IMPACTSR_REG32(MMIO,0x40928) = 0x00000000;
+}
+
+static void impactsr_alloctxtbl(struct fb_info *p, int pool, int txmax)
+{
+	dma_addr_t dma_handle;
+	int alloc_size;
+	if (txmax > PAR.pool_txmax[pool]) {	/* grow the pool - unlikely but supported */
+		alloc_size = txmax;
+		if (alloc_size < 1024)
+			alloc_size = 1024;
+		if (PAR.pool_txmax[pool])
+			dma_free_coherent(NULL, (PAR.pool_txmax[pool] * 4),
+					  PAR.pool_txtbl[pool],
+					  PAR.pool_txphys[pool]);
+		PAR.pool_txtbl[pool] = dma_alloc_coherent(NULL, (alloc_size * 4),
+							  &dma_handle, GFP_KERNEL);
+		PAR.pool_txphys[pool] = dma_handle;
+		PAR.pool_txmax[pool] = alloc_size;
+	}
+	PAR.pool_txnum[pool] = txmax;
+}
+
+static void impactsr_writetxtbl(struct fb_info *p, int pool)
+{
+	impactsr_wait_cfifo_empty(p);
+
+	/* inform the card about a new DMA pool */
+	IMPACTSR_CFIFOPW(MMIO) = IMPACTSR_CMD_HQ_TXBASE(pool);
+	IMPACTSR_CFIFOP(MMIO) = PAR.pool_txphys[pool];
+	IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_TXMAX(pool, PAR.pool_txnum[pool]);
+	IMPACTSR_CFIFOP(MMIO) = IMPACTSR_CMD_HQ_PGBITS(pool, 0x0a);
+	IMPACTSR_CFIFOP(MMIO) = (0x00484b0400180000 | ((long)pool << 40));
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+	IMPACTSR_CFIFOPW(MMIO) = 0x000e0100;
+}
+
+static void impactsr_settxtbl(struct fb_info *p, int pool, unsigned *txtbl,
+			      int txmax)
+{
+	impactsr_alloctxtbl(p, pool, txmax);
+	memcpy(PAR.pool_txtbl[pool], txtbl, (txmax * 4));
+	impactsr_writetxtbl(p, pool);
+}
+
+static void impactsr_resizekpool(struct fb_info *p, int pool, int size,
+				 int growonly)
+{
+	int pages;
+	int i;
+	dma_addr_t dma_handle;
+
+	if (growonly && PAR.kpool_size[pool] >= size)
+		return;
+
+	if (size < 8192)	/* single line smallcopy (1280 * 4) *must* work */
+		size = 8192;
+
+	pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (PAR.kpool_size[pool] > 0) {
+		for (i = 0; i < PAR.pool_txnum[pool]; i++) {
+			ClearPageReserved(virt_to_page(PAR.kpool_virt[pool][i]));
+			dma_free_coherent(NULL, PAGE_SIZE, PAR.kpool_virt[pool][i],
+					  PAR.kpool_phys[pool][i]);
+		}
+		vfree(PAR.kpool_phys[pool]);
+		vfree(PAR.kpool_virt[pool]);
+	}
+
+	impactsr_alloctxtbl(p, pool, pages);
+	PAR.kpool_virt[pool] = vmalloc(pages * sizeof(unsigned long));
+	PAR.kpool_phys[pool] = vmalloc(pages * sizeof(unsigned long));
+	for (i = 0; i < PAR.pool_txnum[pool]; i++) {
+		PAR.kpool_virt[pool][i] = dma_alloc_coherent(NULL, PAGE_SIZE,
+							     &dma_handle, GFP_KERNEL);
+		SetPageReserved(virt_to_page(PAR.kpool_virt[pool][i]));
+		PAR.kpool_phys[pool][i] = dma_handle;
+		PAR.pool_txtbl[pool][i] = PAR.kpool_phys[pool][i] >> PAGE_SHIFT;
+		if (!PAR.kpool_virt[pool][i])
+			printk(KERN_ERR "impactsr: Page allocation failed!\n");
+	}
+
+	impactsr_writetxtbl(p, pool);
+	PAR.kpool_size[pool] = (pages * PAGE_SIZE);
+}
+
+static void impactsr_rect(struct fb_info *p, int x, int y, int w, int h, unsigned c, int lo)
+{
+	impactsr_wait_cfifo_empty(p);
+
+	if (lo == IMPACTSR_LO_COPY)
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x6300, lo);
+	else
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x6304, lo);
+
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_FILLMODE(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PACKEDCOLOR(c);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYENDI(x + w - 1, y + h - 1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_IR_ALIAS(0x18);
+}
+
+static void impactsr_framerect(struct fb_info *p, int x, int y, int w, int h,
+			       unsigned c)
+{
+	impactsr_rect(p, x, y, w, 1, c, IMPACTSR_LO_COPY);
+	impactsr_rect(p, x, (y + h - 1), w, 1, c, IMPACTSR_LO_COPY);
+	impactsr_rect(p, x, y, 1, h, c, IMPACTSR_LO_COPY);
+	impactsr_rect(p, (x + w - 1), y, 1, h, c, IMPACTSR_LO_COPY);
+}
+
+static unsigned long dcntr;
+static void impactsr_debug(struct fb_info *p,int v)
+{
+	int i;
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PIXCMD(3);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PIXELFORMAT(0xe00);
+
+	switch (v) {
+	case 0:
+		for (i = 0; i < 64; i++)
+			impactsr_rect(p, 4 * (i & 7), 28 - 4 * (i >> 3),
+				      4, 4, (dcntr & (1L << i)) ? 0xa080ff : 0x100030,
+				      IMPACTSR_LO_COPY);
+		break;
+
+	case 1:
+		dcntr++;
+		for (i = 0; i < 64; i++)
+			impactsr_rect(p, 4 * (i & 7), 28 - 4 * (i >> 3),
+				      4, 4, (dcntr & (1L << i)) ? 0xff80a0 : 0x300010,
+				      IMPACTSR_LO_COPY);
+		break;
+
+	case 2:
+		for (i = 0; i < 64; i++)
+			impactsr_rect(p, 4 * (i & 7), 28 - 4 * (i >> 3),
+				      4, 4, (dcntr & (1L << i)) ? 0xa0ff80 : 0x103000,
+				      IMPACTSR_LO_COPY);
+	}
+}
+
+static void impactsr_smallcopy(struct fb_info *p, unsigned sx, unsigned sy,
+			       unsigned dx, unsigned dy, unsigned w, unsigned h)
+{
+	if (w < 1 || h < 1)
+		return;
+
+	w=(w + 1) & ~1;
+
+	/* setup and perform DMA from RE to HOST */
+	impactsr_wait_dma(p);
+
+	/* select RSS to read from */
+	if (PAR.num_rss == 2) {
+		if (sy & 1)
+			IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xca5);
+		else
+			IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xca4);
+	} else	/* 1 */
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xca4);
+
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PIXCMD(2);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x2200, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_COLORMASKMSBS(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_DRBPOINTERS(0xc8240);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYSTARTI(sx, sy + h - 1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYENDI(sx + w - 1, sy);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMASKLO(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMASKHI(0xffffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRSIZE(w, h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(w, h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMODE(0x00080);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_FILLMODE(0x01000000);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PIXELFORMAT(0x200);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_SCANWIDTH(w << 2);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_DMATYPE(0x0a);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_LIST_0(0x80000000);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_WIDTH(w << 2);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_OFFSET(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_STARTADDR(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_LINECNT(h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_WIDTHA(w << 2);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCONTROL(8);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_IR_ALIAS(0x18);
+	IMPACTSR_CFIFOW(MMIO) = 0x00080b04;
+	IMPACTSR_CFIFO(MMIO) = 0x000000b900190204L;
+	IMPACTSR_CFIFOW(MMIO) = 0x00000009;
+	impactsr_wait_dmaready(p);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_RE_TOGGLECNTX(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(0, 0);
+
+	/* setup and perform DMA from HOST to RE */
+	impactsr_wait_dma(p);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xca4);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x6200, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYSTARTI(dx, dy + h - 1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYENDI(dx + w - 1, dy);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_FILLMODE(0x01400000);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMODE(0x00080);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PIXELFORMAT(0x600);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_SCANWIDTH(w << 2);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_DMATYPE(0x0c);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PIXCMD(3);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRSIZE(w, h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(w, h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_IR_ALIAS(0x18);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCONTROL(1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_LIST_0(0x80000000);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_OFFSET(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_STARTADDR(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_LINECNT(h);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PG_WIDTHA(w << 2);
+	IMPACTSR_CFIFOW(MMIO) = 0x0080b04;
+	IMPACTSR_CFIFO(MMIO) = 0x000000b1000e0400L;
+
+	impactsr_wait_dma(p);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_RE_TOGGLECNTX(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(0, 0);
+}
+
+static unsigned impactsr_getpalreg(struct fb_info *p, unsigned i)
+{
+	return ((unsigned *)p->pseudo_palette)[i];
+}
+
+
+/* ------------ Accelerated Functions --------------------- */
+static void impactsr_fillrect(struct fb_info *p, const struct fb_fillrect *region)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+
+	switch (region->rop) {
+	case ROP_XOR:
+		impactsr_rect(p, region->dx, region->dy, region->width, region->height,
+			      impactsr_getpalreg(p, region->color), IMPACTSR_LO_XOR);
+		break;
+
+	case ROP_COPY:
+	default:
+		impactsr_rect(p, region->dx, region->dy, region->width, region->height,
+			      impactsr_getpalreg(p, region->color), IMPACTSR_LO_COPY);
+		break;
+	}
+
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+static void impactsr_copyarea(struct fb_info *p, const struct fb_copyarea *area) 
+{
+	unsigned sx, sy, dx, dy, w, h;
+	unsigned th, ah;
+	unsigned long flags;
+
+	w = area->width;
+	h = area->height;
+
+	if (w < 1 || h < 1)
+		return;
+
+	spin_lock_irqsave(&PAR.lock, flags);
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+
+	sx = area->sx;
+	sy = 0x3ff - (area->sy + h - 1);
+	dx = area->dx;
+	dy = 0x3ff - (area->dy + h - 1);
+	th = PAR.kpool_size[0] / (w * 4);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XYWIN(0, 0);
+
+	if (dy > sy) {
+		dy += h;
+		sy += h;
+		while (h > 0) {
+			ah = (th > h) ? h : th;
+			impactsr_smallcopy(p, sx, sy - ah, dx, dy - ah, w, ah);
+			dy -= ah;
+			sy -= ah;
+			h -= ah;
+		}
+	} else {
+		while (h > 0) {
+			ah = (th > h) ? h : th;
+			impactsr_smallcopy(p, sx, sy, dx, dy, w, ah);
+			dy += ah;
+			sy += ah;
+			h -= ah;
+		}
+	}
+
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PIXCMD(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_HQ_PIXELFORMAT(0xe00);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CONFIG(0xcac);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XYWIN(0, 0x3ff);
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+/* 8-bpp blits are done as PIO draw operation; the pixels are unpacked into 32-bpp
+   values from the current palette in software */
+static void impactsr_imageblit_8bpp(struct fb_info *p, const struct fb_image *image)
+{
+	int i,u,v;
+	const unsigned char *dp;
+	unsigned pix;
+	unsigned pal[256];
+
+	/* setup PIO to RE */
+	impactsr_wait_cfifo_empty(p);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYSTARTI(image->dx, image->dy);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYENDI((image->dx + image->width - 1),
+							(image->dy + image->height - 1));
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_FILLMODE(0x00c00000);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRMODE(0x00080);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRSIZE(image->width, image->height);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(image->width, image->height);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(1);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_IR_ALIAS(0x18);
+
+	/* another workaround.. 33 writes to alpha... hmm... */
+	for (i = 0; i < 33; i++)
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_ALPHA(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCONTROL(2);
+
+	/* pairs of pixels are sent in two writes to the RE */
+	i = 0;
+	dp = image->data;
+	for (v = 0; v < 256; v++)
+		pal[v] = impactsr_getpalreg(p, v);
+	for (v = 0; v < image->height; v++) {
+		for (u = 0; u < image->width; u++) {
+			pix = pal[*(dp++)];
+			if (i)
+				IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CHAR_L(pix);
+			else
+				IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CHAR_H(pix);
+			i ^= 1;
+		}
+	}
+	if (i)
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CHAR_L(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_GLINE_XSTARTF(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_RE_TOGGLECNTX(0);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_XFRCOUNTERS(0, 0);
+}
+
+/* 1-bpp blits are done as character drawing; the bitmaps are drawn as 8-bit wide
+   strips; technically, Impact supports 16-pixel wide characters, but Linux
+   bitmap alignment is 8 bits and most draws are 8 pixels wide (font width), anyway */
+static void impactsr_imageblit_1bpp(struct fb_info *p, const struct fb_image *image) 
+{
+	int x, y, w, h, b;
+	int u, v, a;
+	const unsigned char *d;
+	impactsr_wait_cfifo_empty(p);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_FILLMODE(0x400018);
+	a = impactsr_getpalreg(p, image->fg_color);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_PACKEDCOLOR(a);
+	a = impactsr_getpalreg(p, image->bg_color);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BKGRD_RG(a & 0xffff);
+	IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BKGRD_BA((a & 0xff0000) >> 16);
+
+	x = image->dx;
+	y = image->dy;
+	w = image->width;
+	h = image->height;
+	b = ((w + 7) / 8);
+
+	for (u = 0; u < b; u++) {
+		impactsr_wait_cfifo_empty(p);
+		a = (w < 8) ? w : 8;
+		d = (image->data + u);
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_BLOCKXYENDI(x + a - 1, y + h - 1);
+		IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_IR_ALIAS(0x18);
+		for (v = 0; v < h; v++) {
+			IMPACTSR_CFIFO(MMIO) = IMPACTSR_CMD_CHAR((*d) << 24);
+			d += b;
+		}
+		w -= a;
+		x += a;
+	}
+}
+
+static void impactsr_imageblit(struct fb_info *p, const struct fb_image *image) 
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+
+	switch (image->depth) {
+	case 1:
+		impactsr_imageblit_1bpp(p, image);
+		break;
+	case 8:
+		impactsr_imageblit_8bpp(p, image);
+		break;
+	}
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+static int impactsr_sync(struct fb_info *info)
+{
+	return 0;
+}
+
+static int impactsr_blank(int blank_mode, struct fb_info *info)
+{
+	/* TODO */
+	return 0;
+}
+
+static int impactsr_setcolreg(unsigned regno, unsigned red, unsigned green,
+			      unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 255)
+		return 1;
+
+	((unsigned *)info->pseudo_palette)[regno] = (red >> 8) |
+						    (green & 0xff00) |
+						    ((blue << 8) & 0xff0000);
+	return 0;
+}
+
+
+/* ------------------- Framebuffer Access -------------------- */
+ssize_t impactsr_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+ssize_t impactsr_write(struct file *file, const char *buf, size_t count,
+		       loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+
+/* --------------------- Userland Access --------------------- */
+int impactsr_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+int impactsr_mmap(struct fb_info *p, struct vm_area_struct *vma)
+{
+	unsigned pool, i, n;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long start = vma->vm_start;
+
+	switch (offset) {
+	case 0x0000000:
+		if (size != 0x200000)
+			return -EINVAL;
+
+		if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+			return -EINVAL;
+
+		offset += MMIO;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		vma->vm_flags |= VM_IO;
+		if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT, size, vma->vm_page_prot))
+			return -EAGAIN;
+
+		return 0;
+
+	case 0x1000000:
+	case 0x2000000:
+	case 0x3000000:
+	case 0x8000000:
+	case 0x9000000:
+	case 0xa000000:
+	case 0xb000000:
+		if (size > 0x1000000)
+			return EINVAL;
+
+		pool = (offset >> 24) & 3;
+		impactsr_resizekpool(&info, pool, size, (offset & 0x8000000));
+		n = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		for (i = 0; i < n; i++) {
+			if (remap_pfn_range(vma, start,
+					    PAR.kpool_phys[pool][i] >> PAGE_SHIFT,
+					    PAGE_SIZE, vma->vm_page_prot))
+				return -EAGAIN;
+			start += PAGE_SIZE;
+		}
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int impactsr_open(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+        if (user)
+		PAR.open_flag++;
+	spin_unlock_irqrestore(&PAR.lock, flags);
+	return 0;
+}
+
+static int impactsr_release(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+        if (user && PAR.open_flag)
+                PAR.open_flag--;
+	spin_unlock_irqrestore(&PAR.lock, flags);
+	return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Frame buffer operations
+     */
+
+static struct fb_ops impactsr_ops = {
+	.owner		= THIS_MODULE,
+	.fb_read	= impactsr_read,
+	.fb_write	= impactsr_write,
+	.fb_blank	= impactsr_blank,
+	.fb_fillrect	= impactsr_fillrect,
+	.fb_copyarea	= impactsr_copyarea,
+	.fb_imageblit	= impactsr_imageblit,
+	.fb_sync	= impactsr_sync,
+	.fb_ioctl	= impactsr_ioctl,
+	.fb_setcolreg	= impactsr_setcolreg,
+	.fb_mmap	= impactsr_mmap,
+	.fb_open	= impactsr_open,
+	.fb_release	= impactsr_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Private early console
+     */
+
+#define MMIO_FIXED	0x900000001c000000
+
+static void impactsr_earlyrect(int x, int y, int w, int h, unsigned c)
+{
+	while (IMPACTSR_FIFOSTATUS(MMIO_FIXED) & 0xff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_FILLMODE(0);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PACKEDCOLOR(c);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYENDI(x + w - 1, y + h - 1);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_IR_ALIAS(0x18);
+}
+static void impactsr_paintchar(int x, int y, unsigned char *b, unsigned c, unsigned a)
+{
+	int v;
+	while (IMPACTSR_FIFOSTATUS(MMIO_FIXED) & 0xff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PP1FILLMODE(0x6300, IMPACTSR_LO_COPY);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_FILLMODE(0x400018);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_PACKEDCOLOR(c);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BKGRD_RG(a & 0xffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BKGRD_BA((a&0xff0000) >> 16);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYSTARTI(x, y);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_BLOCKXYENDI(x + 7, y + 15);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_IR_ALIAS(0x18);
+	for (v = 0; v < 16; v++)
+		IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_CHAR((*(b++)) << 24);
+}
+static void impactsr_earlyhwinit(void)
+{
+	IMPACTSR_CFIFO_HW(MMIO_FIXED) = 0x47;
+	IMPACTSR_CFIFO_LW(MMIO_FIXED) = 0x14;
+	IMPACTSR_CFIFO_DELAY(MMIO_FIXED) = 0x64;
+	IMPACTSR_DFIFO_HW(MMIO_FIXED) = 0x40;
+	IMPACTSR_DFIFO_LW(MMIO_FIXED) = 0x10;
+	IMPACTSR_DFIFO_DELAY(MMIO_FIXED) = 0;
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_COLORMASKMSBS(0);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XFRMASKLO(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XFRMASKHI(0xffffff);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_DRBPOINTERS(0xc8240);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_CONFIG(0xcac);
+	IMPACTSR_CFIFO(MMIO_FIXED) = IMPACTSR_CMD_XYWIN(0, 0x3ff);
+	IMPACTSR_XMAP_PP1SELECT(MMIO_FIXED) = 0x01;
+	IMPACTSR_XMAP_INDEX(MMIO_FIXED) = 0x00;
+	IMPACTSR_XMAP_MAIN_MODE(MMIO_FIXED) = 0x07a4;
+	IMPACTSR_VC3_INDEXDATA(MMIO_FIXED) = 0x1d000100;
+}
+
+static int posx = -1, posy;
+static spinlock_t earlylock = SPIN_LOCK_UNLOCKED;
+
+void impactsr_earlychar(unsigned char c, unsigned f)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&earlylock, flags);
+	if (posx == -1)
+		goto out;
+
+	if (c == '\n') {
+		posy += 16;
+		if (posy >= 1024)
+			posy = 0;
+		posx = 0;
+		goto out;
+	}
+
+	if (posx == 0) {
+		impactsr_earlyrect(0, posy, 1280, 16, 0x000000);
+		if (posy + 16 < 1024)
+			impactsr_earlyrect(0, posy + 16, 1280, 2, 0x0000ff);
+	}
+
+	impactsr_paintchar(posx, posy, (unsigned char *)font_vga_8x16.data + (c << 4),
+			   f, 0);
+	posx += 8;
+
+	if (posx >= 1280) {
+		posx = 0;
+		posy++;
+		if (posy >= 1024)
+			posy = 0;
+	}
+out:
+	spin_unlock_irqrestore(&earlylock, flags);
+}
+void impactsr_earlystring(char *s, unsigned f)
+{
+	while (*s)
+		impactsr_earlychar(*(s++), f);
+}
+void impactsr_earlyinit(void)
+{
+	impactsr_earlyhwinit();
+	impactsr_earlyrect(0, 0, 1280, 1024, 0);
+	posx = 0;
+	posy = 0;
+	impactsr_earlystring("ImpactSR early console ready.\n",0xffffff);
+}
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Initialization
+     */
+
+static void __init impactsr_hwinit(void)
+{
+	/* initialize hardware */
+	impactsr_inithq4(&info);
+	impactsr_initvc3(&info);
+	impactsr_initrss(&info);
+	impactsr_initxmap(&info);
+	impactsr_initdma(&info);
+}
+
+static int __init impactsr_devinit(void)
+{
+	int xwid;
+
+	xwid = ip30_xtalk_find(IMPACTSR_XTALK_MFGR, IMPACTSR_XTALK_PART,
+			       IP30_XTALK_NUM_WID);
+	if (xwid == -1)
+		return -ENODEV;
+
+	current_par.open_flag = 0;
+	current_par.lock = SPIN_LOCK_UNLOCKED;
+
+	current_par.mmio_base = ip30_xtalk_swin(xwid);
+	current_par.mmio_virt = (unsigned long)ioremap(current_par.mmio_base, 0x200000);
+
+	impactsr_fix.mmio_start = current_par.mmio_base;
+	impactsr_fix.mmio_len = 0x200000;
+
+	info.flags = FBINFO_FLAG_DEFAULT;
+	info.screen_base = NULL;
+	info.fbops = &impactsr_ops;
+	info.fix = impactsr_fix;
+	info.var = impactsr_var;
+	info.par = &current_par;
+	info.pseudo_palette = pseudo_palette;
+
+	/* get board config */
+	current_par.num_ge = IMPACTSR_BDVERS1(current_par.mmio_virt) & 3;
+	current_par.num_rss = current_par.num_ge;
+	info.fix.id[9] = '0' + current_par.num_rss;
+
+	impactsr_hwinit();
+
+	/* initialize buffers */
+	impactsr_resizekpool(&info, 0, 65536, 0);
+	impactsr_resizekpool(&info, 1, 8192, 0);
+	impactsr_resizekpool(&info, 2, 8192, 0);
+	impactsr_resizekpool(&info, 3, 8192, 0);
+	impactsr_resizekpool(&info, 4, 8192, 0);
+
+	/* This has to been done !!! */	
+	fb_alloc_cmap(&info.cmap, 256, 0);
+
+	if (register_framebuffer(&info) < 0)
+		return -EINVAL;
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
+			  info.fix.id);
+	return 0;
+}
+
+static int __init impactsr_probe(struct device *dev)
+{
+	return impactsr_devinit();
+}
+
+static struct device_driver impactsr_driver = {
+	.name = "impactsr",
+	.bus = &platform_bus_type,
+	.probe = impactsr_probe,
+	/* add remove someday */
+};
+
+static struct platform_device impactsr_device = {
+	.name = "impactsr",
+};
+
+int __init impactsr_init(void)
+{
+	int ret = driver_register(&impactsr_driver);
+	if (!ret) {
+		ret = platform_device_register(&impactsr_device);
+		if (ret)
+			driver_unregister(&impactsr_driver);
+	}
+	return ret;
+}
+
+void __exit impactsr_exit(void)
+{
+	 driver_unregister(&impactsr_driver);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) ImpactSR / HQ4 Video Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(impactsr_init);
+module_exit(impactsr_exit);
+
+MODULE_LICENSE("GPL");
diff -Naurp linux-2.6.26.orig/drivers/video/logo/Kconfig linux-2.6.26/drivers/video/logo/Kconfig
--- linux-2.6.26.orig/drivers/video/logo/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/drivers/video/logo/Kconfig	2008-07-25 03:14:40.000000000 -0400
@@ -54,7 +54,7 @@ config LOGO_PARISC_CLUT224
 
 config LOGO_SGI_CLUT224
 	bool "224-color SGI Linux logo"
-	depends on SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS
+	depends on SGI_IP22 || SGI_IP27 || SGI_IP30 || SGI_IP32 || X86_VISWS
 	default y
 
 config LOGO_SUN_CLUT224
diff -Naurp linux-2.6.26.orig/drivers/video/odyssey.c linux-2.6.26/drivers/video/odyssey.c
--- linux-2.6.26.orig/drivers/video/odyssey.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/drivers/video/odyssey.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,1055 @@
+/*
+ * linux/drivers/video/odyssey.c -- SGI Octane Odyssey graphics
+ *
+ *  Copyright (c) 2005 by Stanislaw Skowronek
+ *
+ *  This driver, as most of the IP30 (SGI Octane) port, is a result of massive
+ *  amounts of reverse engineering and trial-and-error. If anyone is interested
+ *  in helping with it, please contact me: <skylark@linux-mips.org>.
+ *
+ *  Note: the driver is specialcased for 8x16 font (will be a bit faster).
+ *
+ *  Odyssey is a really cool graphics device. It is a dual-chip OpenGL
+ *  implementation with ARB_imaging support, and overall a very elegant design.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/font.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ip30/xtalk.h>
+#include <video/odyssey.h>
+
+struct odyssey_par {
+	/* physical mmio base in HEART XTalk space */
+	unsigned long mmio_base;
+
+	/* virtual mmio base in kernel space */
+	unsigned long mmio_virt;
+
+	/* locks to prevent simultaneous user and kernel access */
+	int open_flag;
+	int mmap_flag;
+	spinlock_t lock;
+};
+
+static struct fb_fix_screeninfo odyssey_fix = {
+	.id =		"Odyssey", 
+	.smem_start = 	0,
+	.smem_len =	0,
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_TRUECOLOR,
+	.xpanstep =	0,
+	.ypanstep =	0,
+	.ywrapstep =	0, 
+	.line_length =	0,
+	.accel =	FB_ACCEL_SGI_ODYSSEY,
+};
+
+static struct fb_var_screeninfo odyssey_var = {
+	.xres =		1280,
+	.yres =		1024,
+	.xres_virtual =	1280,
+	.yres_virtual =	1024,
+	.bits_per_pixel = 24,
+	.red =		{ .offset = 0, .length = 8 },
+	.green =	{ .offset = 8, .length = 8 },
+	.blue =		{ .offset = 16, .length = 8 },
+	.transp =	{ .offset = 24, .length = 8 },
+};
+
+static struct fb_info info;
+static unsigned int pseudo_palette[256];
+static struct odyssey_par current_par;
+int odyssey_init(void);
+
+
+/* Most of the hex numbers seen in the various functions, especially those in
+ * the hardware init functions, were discovered via reverse engineering of IRIX
+ * drivers.  Little is known as to what they do or what they mean.
+ *
+ * Possibly, these hex numbers are addresses to locations outside of what we
+ * perceive as normal reality, and instead reference a location within the void
+ * itself, from which various dark and black magiks flow forth and breathe life
+ * into this hardware.
+ *
+ * If you think you can come up with a better explanation, then feel free to
+ * send a patch!
+ */
+
+
+/* --------------------- Gory Details --------------------- */
+#define MMIO (((struct odyssey_par *)p->par)->mmio_virt)
+#define PAR (*((struct odyssey_par *)p->par))
+
+static unsigned int pack_ieee754(int val)
+{
+	unsigned sign,exp;
+
+	if (!val)
+		return 0;
+	sign = (val & 0x80000000);
+
+	if (sign)
+		val = -val;
+
+	if (val & 0xff000000)
+		return 0;
+
+	exp = 150;
+	while (!(val & 0x00800000)) {
+		val << =1;
+		exp--;
+	}
+
+	return sign | (exp << 23) | (val & 0x007fffff);
+}
+
+static void odyssey_wait_cfifo(unsigned long mmio)
+{
+	while (!(ODY_STATUS0(mmio) & ODY_STATUS0_CFIFO_LW));
+}
+
+static void odyssey_wait_dfifo(unsigned long mmio, int lw)
+{
+	while ((ODY_DBESTAT(mmio) & 0x7f) > lw);
+}
+
+static void odyssey_dfifo_write(unsigned long mmio, unsigned reg, unsigned val)
+{
+	ODY_DFIFO_D(mmio) = ((unsigned long)(0x30000001 | (reg << 14)) << 32) | val;
+}
+
+static void odyssey_flush(unsigned long mmio)
+{
+	odyssey_wait_cfifo(mmio);
+	ODY_CFIFO_W(mmio) = 0x00010443;
+	ODY_CFIFO_W(mmio) = 0x000000fa;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010019;
+	ODY_CFIFO_W(mmio) = 0x00010443;
+	ODY_CFIFO_W(mmio) = 0x00000096;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010443;
+	ODY_CFIFO_W(mmio) = 0x000000fa;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+}
+
+static void odyssey_smallflush(unsigned long mmio)
+{
+	odyssey_wait_cfifo(mmio);
+	ODY_CFIFO_W(mmio) = 0x00010443;
+	ODY_CFIFO_W(mmio) = 0x000000fa;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+	ODY_CFIFO_W(mmio) = 0x00010046;
+}
+
+static void odyssey_initbuzzgfe(unsigned long mmio)
+{
+	ODY_CFIFO_W(mmio) = 0x20008003;
+	ODY_CFIFO_W(mmio) = 0x21008010;
+	ODY_CFIFO_W(mmio) = 0x22008000;
+	ODY_CFIFO_W(mmio) = 0x23008002;
+	ODY_CFIFO_W(mmio) = 0x2400800c;
+	ODY_CFIFO_W(mmio) = 0x2500800e;
+	ODY_CFIFO_W(mmio) = 0x27008000;
+	ODY_CFIFO_W(mmio) = 0x28008000;
+	ODY_CFIFO_W(mmio) = 0x290080d6;
+	ODY_CFIFO_W(mmio) = 0x2a0080e0;
+	ODY_CFIFO_W(mmio) = 0x2c0080ea;
+	ODY_CFIFO_W(mmio) = 0x2e008380;
+	ODY_CFIFO_W(mmio) = 0x2f008000;
+	ODY_CFIFO_W(mmio) = 0x30008000;
+	ODY_CFIFO_W(mmio) = 0x31008000;
+	ODY_CFIFO_W(mmio) = 0x32008000;
+	ODY_CFIFO_W(mmio) = 0x33008000;
+	ODY_CFIFO_W(mmio) = 0x34008000;
+	ODY_CFIFO_W(mmio) = 0x35008000;
+	ODY_CFIFO_W(mmio) = 0x310081e0;
+	odyssey_flush(mmio);
+}
+
+static void odyssey_initbuzzxform(unsigned long mmio)
+{
+	ODY_CFIFO_W(mmio) = 0x9080bda2;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x3f000000;
+	ODY_CFIFO_W(mmio) = 0xbf800000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x4e000000;
+	ODY_CFIFO_W(mmio) = 0x40400000;
+	ODY_CFIFO_W(mmio) = 0x4e000000;
+	ODY_CFIFO_W(mmio) = 0x4d000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x34008000;
+	ODY_CFIFO_W(mmio) = 0x9080bdc8;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x34008010;
+	ODY_CFIFO_W(mmio) = 0x908091df;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x3f800000;
+	ODY_CFIFO_W(mmio) = 0x34008000;
+	odyssey_flush(mmio);
+}
+
+static void odyssey_initbuzzrast(unsigned long mmio)
+{
+	ODY_CFIFO_W(mmio) = 0x0001203b;
+	ODY_CFIFO_W(mmio) = 0x00001000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00001000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00001000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00001000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x0001084a;
+	ODY_CFIFO_W(mmio) = 0x00000080;
+	ODY_CFIFO_W(mmio) = 0x00000080;
+	ODY_CFIFO_W(mmio) = 0x00010845;
+	ODY_CFIFO_W(mmio) = 0x000000ff;
+	ODY_CFIFO_W(mmio) = 0x000076ff;
+	ODY_CFIFO_W(mmio) = 0x0001141b;
+	ODY_CFIFO_W(mmio) = 0x00000001;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00011c16;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x03000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00010404;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00011023;
+	ODY_CFIFO_W(mmio) = 0x00ff0ff0;
+	ODY_CFIFO_W(mmio) = 0x00ff0ff0;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x000000ff;
+	ODY_CFIFO_W(mmio) = 0x00011017;
+	ODY_CFIFO_W(mmio) = 0x00002000;
+	ODY_CFIFO_W(mmio) = 0x00000050;
+	ODY_CFIFO_W(mmio) = 0x20004950;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x0001204b;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x004ff3ff;
+	ODY_CFIFO_W(mmio) = 0x00ffffff;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00ffffff;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	ODY_CFIFO_W(mmio) = 0x00ffffff;
+	ODY_CFIFO_W(mmio) = 0x00000000;
+	odyssey_flush(mmio);
+}
+
+static void odyssey_initpbjvc(unsigned long mmio)
+{
+	int x;
+
+	odyssey_wait_dfifo(mmio, 0);
+	for (x = 0; x < 16; x++)
+		odyssey_dfifo_write(mmio, (0x2900 | x), 0x905215a6);
+
+	odyssey_wait_dfifo(mmio, 0);
+	for (x = 16; x < 32; x++)
+		odyssey_dfifo_write(mmio, (0x2900 | x), 0x905215a6);
+
+	odyssey_wait_dfifo(mmio, 0);
+	odyssey_dfifo_write(mmio, 0x2581, 0x00000000);
+}
+
+static void odyssey_initpbjgamma(unsigned long mmio)
+{
+	unsigned i,v;
+
+	for (i = 0; i < 0x200; i++) {
+		if ((i & 15) == 0)
+			odyssey_wait_dfifo(mmio, 0);
+		v = i >> 2;
+		v = (v << 20) | (v << 10) | v;
+		odyssey_dfifo_write(mmio, (i + 0x1a00), v);
+	}
+
+	for (i = 0x200; i < 0x300; i++) {
+		if ((i & 15) == 0)
+			odyssey_wait_dfifo(mmio, 0);
+		v = ((i - 0x200) >> 1) + 0x80;
+		v =(v << 20) | (v << 10) | v;
+		odyssey_dfifo_write(mmio, (i + 0x1a00), v);
+	}
+
+	for (i = 0x300; i < 0x600; i++) {
+		if ((i & 15) == 0)
+			odyssey_wait_dfifo(mmio, 0);
+		v = (i - 0x300) + 0x100;
+		v = (v << 20) | (v << 10) | v;
+		odyssey_dfifo_write(mmio, (i + 0x1a00), v);
+	}
+}
+
+static void odyssey_rect(unsigned long mmio, int x, int y, int w, int h,
+			 unsigned c, int lo)
+{
+	if ( lo != ODY_LO_COPY) {
+		ODY_CFIFO_W(mmio) = 0x00010404;
+		ODY_CFIFO_W(mmio) = 0x00100000;
+		ODY_CFIFO_W(mmio) = 0x00010422;	/* glLogicOp */
+		ODY_CFIFO_W(mmio) = lo;
+		odyssey_smallflush(mmio);
+	}
+
+	ODY_CFIFO_W(mmio) = 0x00014400;		/* glBegin */
+	ODY_CFIFO_W(mmio) = 0x00000007;		/* GL_QUADS */
+	ODY_CFIFO_W(mmio) = 0xc580cc08;		/* glColor3ub */
+	ODY_CFIFO_W(mmio) = c & 255;
+	ODY_CFIFO_W(mmio) = (c >> 8) & 255;
+	ODY_CFIFO_W(mmio) = (c >> 16) & 255;
+	ODY_CFIFO_W(mmio) = 0x8080c800;		/* glVertex2i */
+	ODY_CFIFO_W(mmio) = x;
+	ODY_CFIFO_W(mmio) = y;
+	ODY_CFIFO_W(mmio) = 0x8080c800;		/* glVertex2i */
+	ODY_CFIFO_W(mmio) = (x + w);
+	ODY_CFIFO_W(mmio) = y;
+	ODY_CFIFO_W(mmio) = 0x8080c800;		/* glVertex2i */
+	ODY_CFIFO_W(mmio) = (x + w);
+	ODY_CFIFO_W(mmio) = (y + h);
+	ODY_CFIFO_W(mmio) = 0x8080c800;		/* glVertex2i */
+	ODY_CFIFO_W(mmio) = x;
+	ODY_CFIFO_W(mmio) = (y + h);
+	ODY_CFIFO_W(mmio) = 0x00014001;		/* glEnd */
+	odyssey_smallflush(mmio);
+
+	if (lo != ODY_LO_COPY) {
+		ODY_CFIFO_W(mmio) = 0x00010404;
+		ODY_CFIFO_W(mmio) = 0x00000000;
+		ODY_CFIFO_W(mmio) = 0x00010422;	/* glLogicOp */
+		ODY_CFIFO_W(mmio) = ODY_LO_COPY;
+		odyssey_smallflush(mmio);
+	}
+}
+
+static unsigned odyssey_getpalreg(struct fb_info *p, unsigned i)
+{
+	return ((unsigned *)p->pseudo_palette)[i];
+}
+
+
+/* ------------ Accelerated Functions --------------------- */
+static void odyssey_fillrect(struct fb_info *p, const struct fb_fillrect *region)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+
+	switch (region->rop) {
+	case ROP_XOR:
+		odyssey_rect(MMIO, region->dx, region->dy, region->width, region->height,
+			     odyssey_getpalreg(p, region->color), ODY_LO_XOR);
+		break;
+	case ROP_COPY:
+	default:
+		odyssey_rect(MMIO, region->dx, region->dy, region->width, region->height,
+			     odyssey_getpalreg(p, region->color), ODY_LO_COPY);
+		break;
+	}
+
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+static void odyssey_copyarea(struct fb_info *p, const struct fb_copyarea *area) 
+{
+	unsigned long flags;
+	unsigned sx, sy, dx, dy, w, h;
+	w = area->width;
+	h = area->height;
+
+	if (w < 1 || h < 1)
+		return;
+
+	spin_lock_irqsave(&PAR.lock, flags);
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+
+	sx = area->sx;
+	sy = area->sy;
+	dx = area->dx;
+	dy = area->dy;
+
+	odyssey_flush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x00010658;
+	ODY_CFIFO_W(MMIO) = 0x00120000;
+	ODY_CFIFO_W(MMIO) = 0x00002031;
+	ODY_CFIFO_W(MMIO) = 0x00002000;
+	ODY_CFIFO_W(MMIO) = sx | (sy << 16);
+	ODY_CFIFO_W(MMIO) = 0x80502050;
+	ODY_CFIFO_W(MMIO) = w | (h << 16);	/* size */
+	ODY_CFIFO_W(MMIO) = 0x82223042;
+	ODY_CFIFO_W(MMIO) = 0x00002000;
+	ODY_CFIFO_W(MMIO) = dx | (dy << 16);	/* dest */
+	ODY_CFIFO_W(MMIO) = 0x3222204b;
+
+	/* draw stuff */
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+static void odyssey_imageblit_8bpp(struct fb_info *p, const struct fb_image *image)
+{
+	int i, j, l;
+	const unsigned char *dp;
+	unsigned pal[256];
+
+	dp = image->data;
+	for (i = 0; i < 256; i++)
+		pal[i] = odyssey_getpalreg(p, i);
+
+	/* perform a PIO blit to card */
+	odyssey_smallflush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x00010405;
+	ODY_CFIFO_W(MMIO) = 0x00002400;
+	ODY_CFIFO_W(MMIO) = 0xc580cc08;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00011453;
+	ODY_CFIFO_W(MMIO) = 0x00000002;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	odyssey_flush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x2900812f;
+	ODY_CFIFO_W(MMIO) = 0x00014400;
+	ODY_CFIFO_W(MMIO) = 0x0000000a;
+	ODY_CFIFO_W(MMIO) = 0xcf80a92f;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dx);
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dy);
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dx + image->width);
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dy + image->height);
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00004570;
+	ODY_CFIFO_W(MMIO) = 0x0f00104c;
+	ODY_CFIFO_W(MMIO) = 0x00000071;
+
+	for (j = 0; j < image->height; j++) {
+		ODY_CFIFO_W(MMIO) = 0x00004570;
+		ODY_CFIFO_W(MMIO) = 0x0fd1104c;
+		ODY_CFIFO_W(MMIO) = 0x00000071;
+		i = image->width;
+		while (i > 0) {
+			l = (i > 14) ? 14 : i;
+			i -= l;
+			ODY_CFIFO_W(MMIO) = 0x00014011 | (l << 10);
+			while (l--)
+				ODY_CFIFO_W(MMIO) = pal[*(dp++)];
+		}
+	}
+
+	ODY_CFIFO_W(MMIO) = 0x00014001;
+	odyssey_smallflush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x290080d6;
+	ODY_CFIFO_W(MMIO) = 0x00011453;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00010405;
+	ODY_CFIFO_W(MMIO) = 0x00002000;
+	odyssey_flush(MMIO);
+}
+
+static void odyssey_imageblit_1bpp_stp(struct fb_info *p, const struct fb_image *image) 
+{
+	unsigned palf, palb, buf;
+	int i;
+	const unsigned char *pic;
+
+	palf = odyssey_getpalreg(p, image->fg_color);
+	palb = odyssey_getpalreg(p, image->bg_color);
+	odyssey_smallflush(MMIO);
+
+	if ((image->dy & 31) < 16)
+		ODY_CFIFO_W(MMIO) = 0x00013c4e;
+	else
+		ODY_CFIFO_W(MMIO) = 0x00013c4f;
+
+	pic = image->data;
+
+	for (i = 0; i < 16; i++) {
+		buf = *(pic++);
+		buf |= buf << 8;
+		ODY_CFIFO_W(MMIO) = buf | (buf << 16);
+	}
+
+	ODY_CFIFO_W(MMIO) = 0x00010404;
+	ODY_CFIFO_W(MMIO) = 0x00000018;
+	odyssey_smallflush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x0001043f;
+	ODY_CFIFO_W(MMIO) = 0x00000010;
+	ODY_CFIFO_W(MMIO) = 0x00010c21;
+	ODY_CFIFO_W(MMIO) = 0x00000200;
+	ODY_CFIFO_W(MMIO) = ((palb & 255) << 16) | ((palb >> 4) & 0xff0);
+	ODY_CFIFO_W(MMIO) = (palb & 0xff0000) | 0xfff;
+	ODY_CFIFO_W(MMIO) = 0x00014400;
+	ODY_CFIFO_W(MMIO) = 0x00010407;
+	ODY_CFIFO_W(MMIO) = 0xc580cc08;
+	ODY_CFIFO_W(MMIO) = palf&255;
+	ODY_CFIFO_W(MMIO) = (palf >> 8) & 255;
+	ODY_CFIFO_W(MMIO) = (palf >> 16) & 255;
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = image->dx;
+	ODY_CFIFO_W(MMIO) = image->dy;
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = (image->dx + 8);
+	ODY_CFIFO_W(MMIO) = image->dy;
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = (image->dx + 8);
+	ODY_CFIFO_W(MMIO) = (image->dy + 16);
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = image->dx;
+	ODY_CFIFO_W(MMIO) = (image->dy + 16);
+	ODY_CFIFO_W(MMIO) = 0x00014001;
+	odyssey_flush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x00010404;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+}
+
+/* this is a slow fallback */
+static void odyssey_imageblit_1bpp_pio(struct fb_info *p, const struct fb_image *image) 
+{
+	int i, j, l, c;
+	const unsigned char *dp;
+	unsigned char d = 0;
+	unsigned palf, palb;
+
+	dp = image->data;
+	palf = odyssey_getpalreg(p, image->fg_color);
+	palb = odyssey_getpalreg(p, image->bg_color);
+
+	/* perform a PIO blit to card */
+	odyssey_smallflush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x00010405;
+	ODY_CFIFO_W(MMIO) = 0x00002400;
+	ODY_CFIFO_W(MMIO) = 0xc580cc08;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00011453;
+	ODY_CFIFO_W(MMIO) = 0x00000002;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	odyssey_flush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x2900812f;
+	ODY_CFIFO_W(MMIO) = 0x00014400;
+	ODY_CFIFO_W(MMIO) = 0x0000000a;
+	ODY_CFIFO_W(MMIO) = 0xcf80a92f;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dx);
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dy);
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dx + image->width);
+	ODY_CFIFO_W(MMIO) = pack_ieee754(image->dy + image->height);
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x8080c800;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00004570;
+	ODY_CFIFO_W(MMIO) = 0x0f00104c;
+	ODY_CFIFO_W(MMIO) = 0x00000071;
+
+	for (j = 0; j < image->height; j++) {
+		c = 0;
+		ODY_CFIFO_W(MMIO) = 0x00004570;
+		ODY_CFIFO_W(MMIO) = 0x0fd1104c;
+		ODY_CFIFO_W(MMIO) = 0x00000071;
+		i = image->width;
+		while (i > 0) {
+			l = (i > 14) ? 14 : i;
+			i -= l;
+			ODY_CFIFO_W(MMIO) = 0x00014011 | (l << 10);
+			while (l--) {
+				if (!c)
+					d = *(dp++);
+				ODY_CFIFO_W(MMIO) = (d & 0x80) ? palf : palb;
+				d <<= 1;
+				c = (c + 1) & 7;
+			}
+		}
+	}
+
+	ODY_CFIFO_W(MMIO) = 0x00014001;
+	odyssey_smallflush(MMIO);
+	ODY_CFIFO_W(MMIO) = 0x290080d6;
+	ODY_CFIFO_W(MMIO) = 0x00011453;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00000000;
+	ODY_CFIFO_W(MMIO) = 0x00010405;
+	ODY_CFIFO_W(MMIO) = 0x00002000;
+	odyssey_flush(MMIO);
+}
+
+static void odyssey_imageblit(struct fb_info *p, const struct fb_image *image) 
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+	if (PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock, flags);
+		return;
+	}
+	switch (image->depth) {
+	case 1:
+		if (image->width != 8 || image->height != 16 ||
+		   image->dx & 7 || image->dy & 15)
+			odyssey_imageblit_1bpp_pio(p, image);
+		else
+			odyssey_imageblit_1bpp_stp(p, image);
+		break;
+	case 8:
+		odyssey_imageblit_8bpp(p, image);
+		break;
+	}
+	spin_unlock_irqrestore(&PAR.lock, flags);
+}
+
+static int odyssey_sync(struct fb_info *info)
+{
+	return 0;
+}
+
+static int odyssey_blank(int blank_mode, struct fb_info *info)
+{
+	/* TODO */
+	return 0;
+}
+
+static int odyssey_setcolreg(unsigned regno, unsigned red, unsigned green,
+			     unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if (regno > 255)
+		return 1;
+	((unsigned *)info->pseudo_palette)[regno] = (red >> 8) |
+						    (green & 0xff00) |
+						    ((blue << 8) & 0xff0000);
+	return 0;
+}
+
+
+/* ------------------- Framebuffer Access -------------------- */
+ssize_t odyssey_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+ssize_t odyssey_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+
+/* --------------------- Userland Access --------------------- */
+int odyssey_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+int odyssey_mmap(struct fb_info *p, struct vm_area_struct *vma)
+{
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long start = vma->vm_start;
+
+	switch (offset) {
+	case 0x0000000:
+		if (size != 0x410000)
+			return -EINVAL;
+
+		if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+			return -EINVAL;
+
+		offset += MMIO;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		vma->vm_flags |= VM_IO;
+
+		if (remap_pfn_range(vma, start, (offset >> PAGE_SHIFT), size, vma->vm_page_prot))
+			return -EAGAIN;
+
+		PAR.mmap_flag = 1;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int odyssey_open(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+
+        if (user)
+		PAR.open_flag++;
+
+	spin_unlock_irqrestore(&PAR.lock, flags);
+	return 0;
+}
+
+static int odyssey_release(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock, flags);
+
+        if (user && PAR.open_flag) {
+                PAR.open_flag--;
+		if (PAR.open_flag == 0)
+                        PAR.mmap_flag = 0;
+	}
+
+	spin_unlock_irqrestore(&PAR.lock, flags);
+	return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Frame buffer operations
+     */
+
+static struct fb_ops odyssey_ops = {
+	.owner		= THIS_MODULE,
+	.fb_read	= odyssey_read,
+	.fb_write	= odyssey_write,
+	.fb_blank	= odyssey_blank,
+	.fb_fillrect	= odyssey_fillrect,
+	.fb_copyarea	= odyssey_copyarea,
+	.fb_imageblit	= odyssey_imageblit,
+	.fb_sync	= odyssey_sync,
+	.fb_ioctl	= odyssey_ioctl,
+	.fb_setcolreg	= odyssey_setcolreg,
+	.fb_mmap	= odyssey_mmap,
+	.fb_open	= odyssey_open,
+	.fb_release	= odyssey_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Private early console
+     */
+
+#define MMIO_FIXED	0x900000001b000000
+
+int odyssey_earlyactive = 1;
+static void odyssey_earlyrect(int x, int y, int w, int h, unsigned c)
+{
+	odyssey_rect(MMIO_FIXED, x, y, w, h, c, ODY_LO_COPY);
+}
+
+static void odyssey_earlypaintchar(int x, int y, unsigned char *b, unsigned c, unsigned a)
+{
+	int i, j;
+
+	odyssey_smallflush(MMIO_FIXED);
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00010405;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00002400;
+	ODY_CFIFO_W(MMIO_FIXED) = 0xc580cc08;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00011453;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000002;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	odyssey_flush(MMIO_FIXED);
+	ODY_CFIFO_W(MMIO_FIXED) = 0x2900812f;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00014400;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x0000000a;
+	ODY_CFIFO_W(MMIO_FIXED) = 0xcf80a92f;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = pack_ieee754(x);
+	ODY_CFIFO_W(MMIO_FIXED) = pack_ieee754(y);
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = pack_ieee754(x + 8);
+	ODY_CFIFO_W(MMIO_FIXED) = pack_ieee754(y + 16);
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x8080c800;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00004570;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x0f00104c;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000071;
+
+	for (j = 0; j < 16; j++) {
+		ODY_CFIFO_W(MMIO_FIXED) = 0x00004570;
+		ODY_CFIFO_W(MMIO_FIXED) = 0x0fd1104c;
+		ODY_CFIFO_W(MMIO_FIXED) = 0x00000071;
+		ODY_CFIFO_W(MMIO_FIXED) = 0x00016011;
+		for (i = 7; i >= 0; i--)
+			if ((b[j] >> i) & 1)
+				ODY_CFIFO_W(MMIO_FIXED) = c;
+			else
+				ODY_CFIFO_W(MMIO_FIXED) = a;
+	}
+
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00014001;
+	odyssey_smallflush(MMIO_FIXED);
+	ODY_CFIFO_W(MMIO_FIXED) = 0x290080d6;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00011453;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00000000;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00010405;
+	ODY_CFIFO_W(MMIO_FIXED) = 0x00002000;
+	odyssey_flush(MMIO_FIXED);
+}
+
+static void odyssey_earlyhwinit(void)
+{
+	odyssey_initbuzzgfe(MMIO_FIXED);
+	odyssey_initbuzzxform(MMIO_FIXED);
+	odyssey_initbuzzrast(MMIO_FIXED);
+	odyssey_initpbjvc(MMIO_FIXED);
+	odyssey_initpbjgamma(MMIO_FIXED);
+}
+
+static int posx = -1, posy;
+static spinlock_t earlylock = SPIN_LOCK_UNLOCKED;
+void odyssey_earlychar(unsigned char c, unsigned f)
+{
+	unsigned long flags;
+
+	if (!odyssey_earlyactive)
+		return;
+
+	spin_lock_irqsave(&earlylock, flags);
+
+	if (posx == -1)
+		goto out;
+
+	if (c == '\n') {
+		posy += 16;
+		if (posy >= 1024)
+			posy = 0;
+		posx = 0;
+		goto out;
+	}
+
+	if (posx == 0) {
+		odyssey_earlyrect(0, posy, 1280, 16, 0x000000);
+		if ((posy + 16) < 1024)
+			odyssey_earlyrect(0, (posy + 16), 1280, 1, 0x0000ff);
+	}
+
+	odyssey_earlypaintchar(posx, posy,
+			       (unsigned char *)font_vga_8x16.data + (c << 4),
+				f, 0);
+	posx += 8;
+	if (posx >= 1280) {
+		posx = 0;
+		posy++;
+		if (posy >= 1024)
+			posy = 0;
+	}
+
+out:
+	spin_unlock_irqrestore(&earlylock, flags);
+}
+
+void odyssey_earlystring(char *s,unsigned f)
+{
+	while (*s)
+		odyssey_earlychar(*(s++), f);
+}
+
+void odyssey_earlyinit(void)
+{
+	odyssey_earlyhwinit();
+	odyssey_earlyrect(0, 0, 1280, 1024, 0);
+	posx = 0;
+	posy = 0;
+	odyssey_earlystring("Odyssey early console ready.\n",0xffffff);
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Initialization
+     */
+
+static void __init odyssey_hwinit(unsigned long mmio)
+{
+	/* initialize hardware */
+	odyssey_initbuzzgfe(mmio);
+	odyssey_initbuzzxform(mmio);
+	odyssey_initbuzzrast(mmio);
+	odyssey_initpbjvc(mmio);
+	odyssey_initpbjgamma(mmio);
+}
+
+static int __init odyssey_devinit(void)
+{
+	int xwid;
+
+	xwid = ip30_xtalk_find(ODY_XTALK_MFGR, ODY_XTALK_PART,
+			       IP30_XTALK_NUM_WID);
+
+	if (xwid == -1)
+		return -ENODEV;
+
+	current_par.open_flag = 0;
+	current_par.mmap_flag = 0;
+	current_par.lock = SPIN_LOCK_UNLOCKED;
+
+	current_par.mmio_base = ip30_xtalk_swin(xwid);
+	current_par.mmio_virt = (unsigned long)ioremap(current_par.mmio_base, 0x410000);
+
+	odyssey_fix.mmio_start = current_par.mmio_base;
+	odyssey_fix.mmio_len = 0x410000;
+
+	info.flags = FBINFO_FLAG_DEFAULT;
+	info.screen_base = NULL;
+	info.fbops = &odyssey_ops;
+	info.fix = odyssey_fix;
+	info.var = odyssey_var;
+	info.par = &current_par;
+	info.pseudo_palette = pseudo_palette;
+
+	odyssey_hwinit(current_par.mmio_virt);
+
+	/* This has to been done !!! */	
+	fb_alloc_cmap(&info.cmap, 256, 0);
+
+	odyssey_earlyactive = 0;
+
+	if (register_framebuffer(&info) < 0)
+		return -EINVAL;
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
+			 info.fix.id);
+
+	return 0;
+}
+
+static int __init odyssey_probe(struct device *dev)
+{
+	return odyssey_devinit();
+}
+
+static struct device_driver odyssey_driver = {
+	.name = "odyssey",
+	.bus = &platform_bus_type,
+	.probe = odyssey_probe,
+	/* add remove someday */
+};
+
+static struct platform_device odyssey_device = {
+	.name = "odyssey",
+};
+
+int __init odyssey_init(void)
+{
+	int ret = driver_register(&odyssey_driver);
+	if (!ret) {
+		ret = platform_device_register(&odyssey_device);
+		if (ret)
+			driver_unregister(&odyssey_driver);
+	}
+	return ret;
+}
+
+void __exit odyssey_exit(void)
+{
+	 driver_unregister(&odyssey_driver);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) Odyssey / Buzz Video Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(odyssey_init);
+module_exit(odyssey_exit);
+
+MODULE_LICENSE("GPL");
diff -Naurp linux-2.6.26.orig/include/asm-mips/addrspace.h linux-2.6.26/include/asm-mips/addrspace.h
--- linux-2.6.26.orig/include/asm-mips/addrspace.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/asm-mips/addrspace.h	2008-07-25 03:14:40.000000000 -0400
@@ -54,6 +54,14 @@
 #define XPHYSADDR(a)            ((_ACAST64_(a)) &			\
 				 _CONST64_(0x000000ffffffffff))
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_64BIT
+unsigned long kernel_physaddr(unsigned long);
+#else
+#define kernel_physaddr CPHYSADDR
+#endif
+#endif
+
 #ifdef CONFIG_64BIT
 
 /*
diff -Naurp linux-2.6.26.orig/include/asm-mips/dma.h linux-2.6.26/include/asm-mips/dma.h
--- linux-2.6.26.orig/include/asm-mips/dma.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/asm-mips/dma.h	2008-07-25 03:14:40.000000000 -0400
@@ -88,10 +88,15 @@
 /* don't care; ISA bus master won't work, ISA slave DMA supports 32bit addr */
 #define MAX_DMA_ADDRESS		PAGE_OFFSET
 #else
+/* Horrible hack for IP30; there has to be a better way */
+#ifdef CONFIG_SGI_IP30
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0xA0000000UL)
+#else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
 #define MAX_DMA_PFN		PFN_DOWN(virt_to_phys((void *)MAX_DMA_ADDRESS))
 #define MAX_DMA32_PFN		(1UL << (32 - PAGE_SHIFT))
+#endif
 
 /* 8237 DMA controllers */
 #define IO_DMA1_BASE	0x00	/* 8 bit slave DMA, channels 0..3 */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/addrs.h linux-2.6.26/include/asm-mips/mach-ip30/addrs.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/addrs.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/addrs.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,36 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2004-2007 Stanislaw Skowronek
+ *               2007 Joshua Kinard <kumba@gentoo.org>
+ */
+#ifndef __ASM_MACH_IP30_ADDRS_H
+#define __ASM_MACH_IP30_ADDRS_H
+
+#include <asm/sn/types.h>
+
+#define IP30_WIDGET_XBOW	0
+#define IP30_WIDGET_HEART	8
+#define IP30_WIDGET_GFX_1	12
+#define IP30_WIDGET_BASEIO	15
+
+#define NODE_SWIN_BASE(nasid, widget) \
+	(0x0000000010000000 | (((unsigned long)(widget)) << 24))
+#define NODE_BWIN_BASE(nasid, widget) \
+	(0x0000001000000000 | (((unsigned long)(widget)) << 36))
+#define RAW_NODE_SWIN_BASE(nasid, widget) \
+	(0x9000000010000000 | (((unsigned long)(widget)) << 24))
+#define RAW_NODE_BWIN_BASE(nasid, widget) \
+	(0x9000001000000000 | (((unsigned long)(widget)) << 36))
+
+#define SWIN_SIZE		0x1000000
+#define BWIN_SIZE		0x1000000000L
+
+#define IP30_IO_PORT_BASE	0x9000000000000000
+
+#define IP30_MAX_PROM_MEM	0x40000000
+#define IP30_MEM_BASE		0x20000000
+
+#endif /* __ASM_MACH_IP30_ADDRS_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/cpu-feature-overrides.h linux-2.6.26/include/asm-mips/mach-ip30/cpu-feature-overrides.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/cpu-feature-overrides.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/cpu-feature-overrides.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,39 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2004-2007 Stanislaw Skowronek
+ */
+
+#ifndef __ASM_MACH_IP30_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_IP30_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_watch		1
+#define cpu_has_mips16		0
+#define cpu_has_divec		0
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+#define cpu_has_mcheck		0
+#define cpu_has_ejtag		0
+
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	0
+
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		1
+
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+
+#define cpu_has_subset_pcaches	1
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	64
+#define cpu_scache_line_size()	128
+
+#endif /* __ASM_MACH_IP30_CPU_FEATURE_OVERRIDES_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/dma-coherence.h linux-2.6.26/include/asm-mips/mach-ip30/dma-coherence.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/dma-coherence.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/dma-coherence.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,90 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *               2007  Joshua Kinard <kumba@gentoo.org>
+ *
+ * derived from include/asm-mips/mach-ip27/dma-coherence.h
+ * and based on code found in the old dma-ip30.c, which is
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ */
+#ifndef __ASM_MACH_IP30_DMA_COHERENCE_H
+#define __ASM_MACH_IP30_DMA_COHERENCE_H
+
+#include <asm/mach-ip30/addrs.h>
+#include <asm/pci/bridge.h>
+
+#include <linux/dma-mapping.h>
+
+static inline dma_addr_t pdev_to_baddr(struct pci_dev *dev, dma_addr_t addr,
+					int virt, int size)
+{
+	if(dev->dma_mask == DMA_64BIT_MASK) {
+		if(virt)
+			return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr) |
+				PCI64_ATTR_VIRTUAL;
+
+		if(size >= 0x200)
+			return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr) |
+				PCI64_ATTR_PREF;
+
+		if(addr >= 0x20000000 || addr < 0xA0000000)
+			return (PCI32_DIRECT_BASE + addr - 0x20000000);
+
+		return (BRIDGE_CONTROLLER(dev->bus)->baddr + addr);
+	}
+
+	if(addr < 0x20000000 || addr >= 0xA0000000) {
+		printk(KERN_ERR
+			"BRIDGE: Mapping can't be realized in direct DMA.\n");
+		return -1;
+	}
+
+	return (PCI32_DIRECT_BASE + addr - 0x20000000);
+}
+
+static inline dma_addr_t dev_to_baddr(struct device *dev, dma_addr_t addr,
+					int virt, int size)
+{
+	if(dev)
+		return pdev_to_baddr(to_pci_dev(dev), addr, virt, size);
+	return addr;
+}
+
+struct device;
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+					size_t size)
+{
+	dma_addr_t pa = dev_to_baddr(dev, virt_to_phys(addr), 1, size);
+
+	return pa;
+}
+
+static dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page,
+					size_t size)
+{
+	dma_addr_t pa = dev_to_baddr(dev, page_to_phys(page), 0, size);
+
+	return pa;
+}
+
+static unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return dma_addr & (0xffUL << 56);
+}
+
+static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
+{
+	/* Empty */
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 1;		/* IP30 non-cohernet mode is unsupported
+				 * (does it even have one?) */
+}
+
+#endif /* __ASM_MACH_IP30_DMA_COHERENCE_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/ds1687.h linux-2.6.26/include/asm-mips/mach-ip30/ds1687.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/ds1687.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/ds1687.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,56 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2007 Joshua Kinard <kumba@gentoo.org>
+ */
+#ifndef __ASM_MACH_IP30_DS1687_H
+#define __ASM_MACH_IP30_DS1687_H
+
+#include <asm/sn/types.h>
+
+#include <linux/ioc3.h>
+
+
+#define RTC_ADDR (*(unsigned char *) ((unsigned long)(ioc3->vma) + IOC3_BYTEBUS_DEV1))
+#define RTC_DATA (*(unsigned char *) ((unsigned long)(ioc3->vma) + IOC3_BYTEBUS_DEV2))
+
+/* Registers */
+#define DS1687_SECNDS		0x00
+#define DS1687_SECNDS_ALRM	0x01
+#define DS1687_MINS		0x02
+#define DS1687_MINS_ALRM	0x03
+#define DS1687_HOUR		0x04
+#define DS1687_HOUR_ALRM	0x05
+#define DS1687_DAY		0x06
+#define DS1687_DATE		0x07
+#define DS1687_MONTH		0x08
+#define DS1687_YEAR		0x09
+#define DS1687_CTRL_A		0x0a
+#define DS1687_CTRL_B		0x0b
+#define DS1687_CTRL_C		0x0c
+#define DS1687_CTRL_D		0x0d
+#define DS1687_CENTURY		0x48
+#define DS1687_DATE_ALRM	0x49
+#define DS1687_EXT_CTRL_4A	0x4a
+#define DS1687_EXT_CTRL_4B	0x4b
+
+
+/* Bitfields of the registers
+ *
+ * Each bitfield can have a different meaning depending
+ * on the register in question.  For more information,
+ * see the DS1687/DS1685 datasheet for the various
+ * meanings and functions of the bitfields with their
+ * respective registers
+ */
+#define DS1687_BIT1		0x02
+#define DS1687_BIT2		0x04
+#define DS1687_BIT3		0x08
+#define DS1687_BIT4		0x10
+#define DS1687_BIT5		0x20
+#define DS1687_BIT6		0x40
+#define DS1687_BIT7		0x80
+
+#endif /* __ASM_MACH_IP30_DS1687_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/heart.h linux-2.6.26/include/asm-mips/mach-ip30/heart.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/heart.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/heart.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,231 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#ifndef __ASM_MACH_IP30_HEART_H
+#define __ASM_MACH_IP30_HEART_H
+
+#include <linux/types.h>
+
+/* HEART internal register space */
+#define HEART_PIU_BASE		0x900000000ff00000
+
+/* full addresses */
+#define HEART_MODE		((volatile ulong *)0x900000000ff00000)
+#define HEART_SDRAM_MODE	((volatile ulong *)0x900000000ff00008)
+#define HEART_MEM_REF		((volatile ulong *)0x900000000ff00010)
+#define HEART_MEM_REQ_ARB	((volatile ulong *)0x900000000ff00018)
+#define	HEART_MEMCFG0		((volatile ulong *)0x900000000ff00020)
+#define	HEART_MEMCFG1		((volatile ulong *)0x900000000ff00028)
+#define	HEART_MEMCFG2		((volatile ulong *)0x900000000ff00030)
+#define	HEART_MEMCFG3		((volatile ulong *)0x900000000ff00038)
+#define HEART_FC_MODE		((volatile ulong *)0x900000000ff00040)
+#define HEART_FC_TIMER_LIMIT	((volatile ulong *)0x900000000ff00048)
+#define HEART_FC0_ADDR		((volatile ulong *)0x900000000ff00050)
+#define HEART_FC1_ADDR		((volatile ulong *)0x900000000ff00058)
+#define HEART_FC0_CR_CNT	((volatile ulong *)0x900000000ff00060)
+#define HEART_FC1_CR_CNT	((volatile ulong *)0x900000000ff00068)
+#define HEART_FC0_TIMER		((volatile ulong *)0x900000000ff00070)
+#define HEART_FC1_TIMER		((volatile ulong *)0x900000000ff00078)
+#define HEART_STATUS		((volatile ulong *)0x900000000ff00080)
+#define HEART_BERR_ADDR		((volatile ulong *)0x900000000ff00088)
+#define HEART_BERR_MISC		((volatile ulong *)0x900000000ff00090)
+#define HEART_MEMERR_ADDR	((volatile ulong *)0x900000000ff00098)
+#define HEART_MEMERR_DATA	((volatile ulong *)0x900000000ff000a0)
+#define HEART_PIUR_ACC_ERR	((volatile ulong *)0x900000000ff000a8)
+#define	HEART_MLAN_CLK_DIV	((volatile ulong *)0x900000000ff000b0)
+#define	HEART_MLAN_CTL		((volatile ulong *)0x900000000ff000b8)
+#define HEART_IMR(x)		((volatile ulong *)0x900000000ff10000 + (8 * (x)))
+#define HEART_SET_ISR		((volatile ulong *)0x900000000ff10020)
+#define HEART_CLR_ISR		((volatile ulong *)0x900000000ff10028)
+#define HEART_ISR		((volatile ulong *)0x900000000ff10030)
+#define HEART_IMSR		((volatile ulong *)0x900000000ff10038)
+#define HEART_CAUSE		((volatile ulong *)0x900000000ff10040)
+#define HEART_COUNT		((volatile ulong *)0x900000000ff20000)	/* 52-bit counter */
+#define HEART_COMPARE		((volatile ulong *)0x900000000ff30000)	/* 24-bit compare */
+#define HEART_TRIGGER		((volatile ulong *)0x900000000ff40000)
+#define HEART_PRID		((volatile ulong *)0x900000000ff50000)
+#define HEART_SYNC		((volatile ulong *)0x900000000ff60000)
+
+/* HEART Masks */
+#define HEART_ATK_MASK		0x0007ffffffffffff	/* HEART Attack Mask */
+#define HEART_ACK_ALL_MASK	0xffffffffffffffff	/* Acknowledge everything */
+#define HEART_CLR_ALL_MASK	0x0000000000000000	/* Clear all */
+#define HEART_BR_ERR_MASK	0x7ff8000000000000	/* BRIDGE Error Mask */
+#define HEART_ERR_MASK		0x1ff			/* HEART Error Mask */
+#define HEART_ERR_MASK_START	51			/* HEART Error start */
+#define HEART_ERR_MASK_END	63			/* HEART Error end */
+
+#define NON_HEART_IRQ_ST	0x0004000000000000	/* Where non-HEART IRQs begin */
+
+/* bits in the HEART_MODE registers */
+#define	HM_PROC_DISABLE_SHFT	60
+#define	HM_PROC_DISABLE_MSK	((ulong) 0xf << HM_PROC_DISABLE_SHFT)
+#define	HM_PROC_DISABLE(x)	((ulong) 0x1 << (x) + HM_PROC_DISABLE_SHFT)
+#define	HM_MAX_PSR		((ulong) 0x7 << 57)
+#define	HM_MAX_IOSR		((ulong) 0x7 << 54)
+#define	HM_MAX_PEND_IOSR	((ulong) 0x7 << 51)
+
+#define	HM_TRIG_SRC_SEL_MSK	((ulong) 0x7 << 48)
+#define	HM_TRIG_HEART_EXC	((ulong) 0x0 << 48)	/* power-up default */
+#define	HM_TRIG_REG_BIT		((ulong) 0x1 << 48)
+#define	HM_TRIG_SYSCLK		((ulong) 0x2 << 48)
+#define	HM_TRIG_MEMCLK_2X	((ulong) 0x3 << 48)
+#define	HM_TRIG_MEMCLK		((ulong) 0x4 << 48)
+#define	HM_TRIG_IOCLK		((ulong) 0x5 << 48)
+
+#define	HM_PIU_TEST_MODE	((ulong) 0xf << 40)
+
+#define	HM_GP_FLAG_MSK		((ulong) 0xf << 36)
+#define	HM_GP_FLAG(x)		((ulong) 0x1 << (x) + 36)
+
+#define	HM_MAX_PROC_HYST	((ulong) 0xf << 32)
+#define	HM_LLP_WRST_AFTER_RST	((ulong) 0x1 << 28)
+#define	HM_LLP_LINK_RST		((ulong) 0x1 << 27)
+#define	HM_LLP_WARM_RST		((ulong) 0x1 << 26)
+#define	HM_COR_ECC_LCK		((ulong) 0x1 << 25)
+#define	HM_REDUCED_PWR		((ulong) 0x1 << 24)
+#define HM_COLD_RST		((ulong) 0x1 << 23)
+#define	HM_SW_RST		((ulong) 0x1 << 22)
+#define	HM_MEM_FORCE_WR		((ulong) 0x1 << 21)
+#define	HM_DB_ERR_GEN		((ulong) 0x1 << 20)
+#define	HM_SB_ERR_GEN		((ulong) 0x1 << 19)
+#define	HM_CACHED_PIO_EN	((ulong) 0x1 << 18)
+#define	HM_CACHED_PROM_EN	((ulong) 0x1 << 17)
+#define	HM_PE_SYS_COR_ERE	((ulong) 0x1 << 16)
+#define	HM_GLOBAL_ECC_EN	((ulong) 0x1 << 15)
+#define	HM_IO_COH_EN		((ulong) 0x1 << 14)
+#define	HM_INT_EN		((ulong) 0x1 << 13)
+#define	HM_DATA_CHK_EN		((ulong) 0x1 << 12)
+#define	HM_REF_EN		((ulong) 0x1 << 11)
+#define	HM_BAD_SYSWR_ERE	((ulong) 0x1 << 10)
+#define	HM_BAD_SYSRD_ERE	((ulong) 0x1 << 9)
+#define	HM_SYSSTATE_ERE		((ulong) 0x1 << 8)
+#define	HM_SYSCMD_ERE		((ulong) 0x1 << 7)
+#define	HM_NCOR_SYS_ERE		((ulong) 0x1 << 6)
+#define	HM_COR_SYS_ERE		((ulong) 0x1 << 5)
+#define	HM_DATA_ELMNT_ERE	((ulong) 0x1 << 4)
+#define	HM_MEM_ADDR_PROC_ERE	((ulong) 0x1 << 3)
+#define	HM_MEM_ADDR_IO_ERE	((ulong) 0x1 << 2)
+#define	HM_NCOR_MEM_ERE		((ulong) 0x1 << 1)
+#define	HM_COR_MEM_ERE		((ulong) 0x1 << 0)
+
+/* bits in the memory refresh register */
+#define HEART_MEMREF_REFS(x)	((ulong) (0xf & (x)) << 16)	
+#define HEART_MEMREF_PERIOD(x)	((ulong) (0xffff & (x)))
+#define HEART_MEMREF_REFS_VAL	HEART_MEMREF_REFS(8)
+#define HEART_MEMREF_PERIOD_VAL HEART_MEMREF_PERIOD(0x4000)
+#define HEART_MEMREF_VAL	(HEART_MEMREF_REFS_VAL | HEART_MEMREF_PERIOD_VAL)
+
+/* bits in the memory request arbitrarion register */
+#define	HEART_MEMARB_IODIS	(1  << 20)
+#define	HEART_MEMARB_MAXPMWRQS	(15 << 16)
+#define	HEART_MEMARB_MAXPMRRQS	(15 << 12)
+#define	HEART_MEMARB_MAXPMRQS	(15 << 8)
+#define	HEART_MEMARB_MAXRRRQS	(15 << 4)
+#define	HEART_MEMARB_MAXGBRRQS	(15)
+
+/* bits in the memory configuration registers */
+#define	HEART_MEMCFG_VLD	0x80000000	/* bank valid bit */
+#define	HEART_MEMCFG_RAM_MSK	0x003f0000	/* RAM mask */
+#define	HEART_MEMCFG_DENSITY	0x01c00000	/* RAM density */
+#define	HEART_MEMCFG_RAM_SHFT	16
+#define	HEART_MEMCFG_ADDR_MSK	0x000001ff	/* base address mask */
+#define	HEART_MEMCFG_UNIT_SHFT	25		/* 32 MB is the HEART's basic memory unit */
+
+/* bits in the status register */
+#define HEART_STAT_HSTL_SDRV		((ulong) 0x1 << 14)
+#define	HEART_STAT_FC_CR_OUT(x)		((ulong) 0x1 << (x) + 12)
+#define	HEART_STAT_DIR_CNNCT		((ulong) 0x1 << 11)
+#define	HEART_STAT_TRITON		((ulong) 0x1 << 10)
+#define	HEART_STAT_R4K			((ulong) 0x1 << 9)
+#define	HEART_STAT_BIG_ENDIAN		((ulong) 0x1 << 8)
+#define	HEART_STAT_PROC_ACTIVE_SHFT	4
+#define	HEART_STAT_PROC_ACTIVE_MSK	((ulong) 0xf << HEART_STAT_PROC_ACTIVE_SHFT)
+#define	HEART_STAT_PROC_ACTIVE(x)	((ulong) 0x1 << (x) + HEART_STAT_PROC_ACTIVE_SHFT)
+#define	HEART_STAT_WIDGET_ID	0xf
+
+/* interrupt handling */
+#define HEART_VEC_TO_IBIT(vec)	((ulong) 1 << (vec))
+#define	HEART_INT_VECTORS	64		/* how many vectors we manage */
+
+/* IP7 is the CPU count/compare, IP1 and IP0 are SW2 and SW1 */
+#define HEART_INT_LEVEL4	0xfff8000000000000	/* IP6 */
+#define HEART_INT_LEVEL3	0x0004000000000000	/* IP5 */
+#define HEART_INT_LEVEL2	0x0003ffff00000000	/* IP4 */
+#define HEART_INT_LEVEL1	0x00000000ffff0000	/* IP3 */
+#define HEART_INT_LEVEL0	0x000000000000ffff	/* IP2 */
+#define HEART_INT_L4SHIFT	51
+#define HEART_INT_L4MASK	0x1fff
+#define HEART_INT_L3SHIFT	50
+#define HEART_INT_L3MASK	0x1
+#define HEART_INT_L2SHIFT	32
+#define HEART_INT_L2MASK	0x3ffff
+#define HEART_INT_L1SHIFT	16
+#define HEART_INT_L1MASK	0xffff
+#define HEART_INT_L0SHIFT	0
+#define HEART_INT_L0MASK	0xffff
+
+/* errors */
+#define IRQ_HEART_ERR		63
+#define IRQ_BUS_ERR_P(x)	(59 + (x))
+#define IRQ_XT_ERR(xid)		(51 + ((xid) - 1) & 7)
+#define IRQ_XT_ERR_XBOW		58
+#define IRQ_XT_ERR_F		57
+#define IRQ_XT_ERR_E		56
+#define IRQ_XT_ERR_D		55
+#define IRQ_XT_ERR_C		54
+#define IRQ_XT_ERR_B		53
+#define IRQ_XT_ERR_A		52
+#define IRQ_XT_ERR_9		51
+/* count/compare timer */
+#define IRQ_HEART_CC		50
+/* level 2 interrupts */
+#define IRQ_IPI_P(x)		(46 + (x))
+#define IRQ_TIMER_P(x)		(42 + (x))
+#define IRQ_LOCAL_L2_BASE	32
+#define IRQ_LOCAL_L2_NUM	9
+/* level 1 interrupts */
+#define IRQ_LOCAL_L1_BASE	16
+#define IRQ_LOCAL_L1_NUM	16
+/* level 0 interrupts */
+#define IRQ_LOCAL_L0_BASE	3
+#define IRQ_LOCAL_L0_NUM	13
+#define IRQ_FC_HIGH		2
+#define IRQ_FC_LOW		1
+#define IRQ_GENERIC		0
+
+#define SOFT_IRQ_COUNT		51
+#define TIMER_IRQ		63
+
+/* bits in the HEART_CAUSE register */
+#define	HC_PE_SYS_COR_ERR_MSK		((ulong) 0xf << 60)
+#define	HC_PE_SYS_COR_ERR(x)		((ulong) 0x1 << (x) + 60)
+#define	HC_PIOWDB_OFLOW			((ulong) 0x1 << 44)
+#define	HC_PIORWRB_OFLOW		((ulong) 0x1 << 43)
+#define HC_PIUR_ACC_ERR			((ulong) 0x1 << 42)
+#define HC_BAD_SYSWR_ERR		((ulong) 0x1 << 41)
+#define HC_BAD_SYSRD_ERR		((ulong) 0x1 << 40)
+#define	HC_SYSSTATE_ERR_MSK		((ulong) 0xf << 36)
+#define	HC_SYSSTATE_ERR(x)		((ulong) 0x1 << (x) + 36)
+#define HC_SYSCMD_ERR_MSK		((ulong) 0xf << 32)
+#define HC_SYSCMD_ERR(x)		((ulong) 0x1 << (x) + 32)
+#define HC_NCOR_SYSAD_ERR_MSK		((ulong) 0xf << 28)
+#define HC_NCOR_SYSAD_ERR(x)		((ulong) 0x1 << (x) + 28)
+#define HC_COR_SYSAD_ERR_MSK		((ulong) 0xf << 24)
+#define HC_COR_SYSAD_ERR(x)		((ulong) 0x1 << (x) + 24)
+#define HC_DATA_ELMNT_ERR_MSK		((ulong) 0xf << 20)
+#define HC_DATA_ELMNT_ERR(x)		((ulong) 0x1 << (x) + 20)
+#define	HC_WIDGET_ERR			((ulong) 0x1 << 16)
+#define	HC_MEM_ADDR_ERR_PROC_MSK	((ulong) 0xf << 4)
+#define	HC_MEM_ADDR_ERR_PROC(x)		((ulong) 0x1 << (x) + 4)
+#define HC_MEM_ADDR_ERR_IO		((ulong) 0x1 << 2)
+#define HC_NCOR_MEM_ERR			((ulong) 0x1 << 1)
+#define HC_COR_MEM_ERR			((ulong) 0x1 << 0)
+
+#endif /* __ASM_MACH_IP30_HEART_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/leds.h linux-2.6.26/include/asm-mips/mach-ip30/leds.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/leds.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/leds.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,29 @@
+#ifndef IP30LEDS_H
+#define IP30LEDS_H
+
+/*
+ * The LEDs driver reads in a stream of opcodes, two bytes each. The highest
+ * two bits of first byte define the opcode type. Next six bits are parameter
+ * one, and the last eight bits are parameter two.
+ * If a LEDS_LOOP(0) opcode is encountered, the stream is terminated on this
+ * opcode and no operations are performed until a new stream is loaded.
+ * If a LEDS_LOOP(n>0) opcode is encountered, the whole stream is looped.
+ * If neither of these opcodes appears until the end of the stream, the behavior
+ * is the same as at LEDS_LOOP(0), however a warning will be printed.
+ */
+
+#define LEDS_OP_SET	0
+	/* set LED brightness; low bits select LED, next byte sets brightness */
+#define LEDS_OP_WAIT	1
+	/* wait for n ms, where n=param2 * (1 << param1); if n = 0 then stop */
+#define LEDS_OP_LOOP	2
+	/* restart the LEDs, waiting for n ms; if n = 0 then stop */
+#define LEDS_OP_RSVD	3
+	/* reserved opcode */
+
+/*
+ * Anyone who wonders why you can't loop without a delay should consider the
+ * fact that we are processing this opcode inside the kernel.
+ */
+
+#endif
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/mangle-port.h linux-2.6.26/include/asm-mips/mach-ip30/mangle-port.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/mangle-port.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/mangle-port.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ */
+#ifndef __ASM_MACH_IP30_MANGLE_PORT_H
+#define __ASM_MACH_IP30_MANGLE_PORT_H
+
+#define __swizzle_addr_b(port)	((port)^3)
+#define __swizzle_addr_w(port)	((port)^2)
+#define __swizzle_addr_l(port)	(port)
+#define __swizzle_addr_q(port)	(port)
+
+#define ioswabb(a,x)		(x)
+#define __mem_ioswabb(a,x)	(x)
+#define ioswabw(a,x)		(x)
+#define __mem_ioswabw(a,x)	cpu_to_le16(x)
+#define ioswabl(a,x)		(x)
+#define __mem_ioswabl(a,x)	cpu_to_le32(x)
+#define ioswabq(a,x)		(x)
+#define __mem_ioswabq(a,x)	cpu_to_le32(x)
+
+#endif /* __ASM_MACH_IP30_MANGLE_PORT_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/pcibr.h linux-2.6.26/include/asm-mips/mach-ip30/pcibr.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/pcibr.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/pcibr.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Definitions for the built-in PCI bridge
+ * Copyright (C) 2004-2007 Stanislaw Skowronek
+ */
+#ifndef __ASM_MACH_IP30_PCIBR_H
+#define __ASM_MACH_IP30_PCIBR_H
+
+#include <asm/mach-ip30/addrs.h>
+#include <asm/pci/bridge.h>
+
+/* Xtalk */
+#define PCIBR_XTALK_MFGR	0x036
+#define PCIBR_XTALK_PART	0xc002
+
+#define PCIBR_OFFSET_MEM	0x200000
+#define PCIBR_OFFSET_IO		0xa00000
+#define PCIBR_OFFSET_END	0xc00000
+
+#define PCIBR_DIR_ALLOC_BASE	0x1000000
+
+#define PCIBR_XIO_SEES_HEART	0x00000080	/* This is how XIO sees HEART_ISR */
+
+#define PCIBR_IRQ_BASE		8
+
+#define PCIBR_MAX_PCI_BUSSES	8		/* Max PCI Busses/Bridges */
+#define PCIBR_MAX_DEV_PCIBUS	8		/* Max # of devices per bus */
+
+
+
+/* Occult Numbers of the Black Priesthood of Ancient Mu
+ *
+ * Meticuously derived by studying dissassembly,
+ * patents, and random guesses
+ */
+#define PCIBR_ANCIENT_MU_EVEN_RESP	0xddcc9988
+#define PCIBR_ANCIENT_MU_ODD_RESP	0xddcc9988
+#define PCIBR_ANCIENT_MU_INT_DEVICE	0xff000000
+#define PCIBR_ANCIENT_MU_INT_ENABLE	0x7ffffe00
+#define PCIBR_ANCIENT_MU_INT_MODE	0x00000000
+
+
+/* Used by pci-ip30.c and ip30-irq.c */
+extern unsigned int ip30_irq_in_bridge[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS];
+extern bridge_t *ip30_irq_bridge[PCIBR_MAX_PCI_BUSSES * PCIBR_MAX_DEV_PCIBUS];
+
+
+#endif /* __ASM_MACH_IP30_PCIBR_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/racermp.h linux-2.6.26/include/asm-mips/mach-ip30/racermp.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/racermp.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/racermp.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,34 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Stanislaw Skowronek
+ */
+
+#ifndef __ASM_MACH_IP30_RACERMP_H
+#define __ASM_MACH_IP30_RACERMP_H
+
+#include <linux/types.h>
+
+#define MPCONF_MAGIC	0xbaddeed2
+#define	MPCONF_ADDR	0xa800000000000600L
+#define MPCONF_SIZE  	0x80
+#define MPCONF(x)	(MPCONF_ADDR + (x) * MPCONF_SIZE)
+
+#define MP_NCPU		4 /* able to do 4, but only 2 physically possible */
+
+#define MP_MAGIC(x)	(*(volatile uint *)	(MPCONF(x) + 0x00))
+#define MP_PRID(x)	(*(volatile uint *)	(MPCONF(x) + 0x04))
+#define MP_PHYSID(x)	(*(volatile uint *)	(MPCONF(x) + 0x08))
+#define MP_VIRTID(x)	(*(volatile uint *)	(MPCONF(x) + 0x0c))
+#define MP_SCACHESZ(x)	(*(volatile uint *)	(MPCONF(x) + 0x10))
+#define MP_FANLOADS(x)	(*(volatile ushort *)	(MPCONF(x) + 0x14))
+#define MP_LAUNCH(x)	(*(volatile void **)	(MPCONF(x) + 0x18))
+#define MP_RNDVZ(x)	(*(volatile void **)	(MPCONF(x) + 0x20))
+#define MP_STACKADDR(x)	(*(volatile ulong *)	(MPCONF(x) + 0x40))
+#define MP_LPARM(x)	(*(volatile ulong *)	(MPCONF(x) + 0x48))
+#define MP_RPARM(x)	(*(volatile ulong *)	(MPCONF(x) + 0x50))
+#define MP_IDLEFLAG(x)	(*(volatile uint *)	(MPCONF(x) + 0x58))
+
+#endif /* __ASM_MACH_IP30_RACERMP_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/war.h linux-2.6.26/include/asm-mips/mach-ip30/war.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/war.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/war.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_IP30_WAR_H
+#define __ASM_MIPS_MACH_IP30_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			1
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_IP30_WAR_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/mach-ip30/xtalk.h linux-2.6.26/include/asm-mips/mach-ip30/xtalk.h
--- linux-2.6.26.orig/include/asm-mips/mach-ip30/xtalk.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/asm-mips/mach-ip30/xtalk.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,70 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ *		 2007 Joshua Kinard <kumba@gentoo.org>
+ */
+
+#ifndef __ASM_MACH_IP30_XTALK_H
+#define __ASM_MACH_IP30_XTALK_H
+
+#define IP30_XTALK_NUM_WID	16
+
+/* Xtalk Device Mfgr IDs */
+#define XTALK_XBOW_MFGR_ID	0x0	/* IP30 XBow Chip */
+#define XTALK_XXBOW_MFGR_ID	0x0	/* IP35 Xbow + XBridge chip */
+#define XTALK_ODYS_MFGR_ID	0x023	/* Odyssey / VPro */
+#define XTALK_TPU_MFGR_ID	0x024	/* Tensor Processor Unit */
+#define XTALK_XBRDG_MFGR_ID	0x024
+#define XTALK_HEART_MFGR_ID	0x036	/* IP30 HEART Chip */
+#define XTALK_BRIDG_MFGR_ID	0x036	/* PCI Bridge */
+#define XTALK_HUB_MFGR_ID	0x036
+#define XTALK_BDRCK_MFGR_ID	0x036	/* IP35 Hub Chip */
+#define XTALK_IMPCT_MFGR_ID	0x2aa	/* HQ4 / ImpactSR */
+#define XTALK_KONA_MFGR_ID	0x2aa
+#define XTALK_NULL_MFGR_ID	-1	/* NULL */
+
+/* Xtalk Device Part IDs */
+#define XTALK_XBOW_PART_ID	0x0
+#define XTALK_XXBOW_PART_ID	0xd000
+#define XTALK_ODYS_PART_ID	0xc013
+#define XTALK_TPU_PART_ID	0xc202
+#define XTALK_XBRDG_PART_ID	0xd002
+#define XTALK_HEART_PART_ID	0xc001
+#define XTALK_BRIDG_PART_ID	0xc002
+#define XTALK_HUB_PART_ID	0xc101
+#define XTALK_BDRCK_PART_ID	0xc110
+#define XTALK_IMPCT_PART_ID	0xc003
+#define XTALK_KONA_PART_ID	0xc102
+#define XTALK_NULL_PART_ID	-1
+
+/* Xtalk Misc */
+#define XTALK_NODEV		0xffffffff
+#define XTALK_LOW_DEV		8	/* Lowest dev possible (HEART) */
+#define XTALK_HIGH_DEV		15	/* Highest dev possible (BRIDGE) */
+#define XTALK_XBOW		0	/* XBow is always 0 */
+#define XTALK_HEART		8	/* HEART is always 8 */
+#define XTALK_PCIBR		13	/* PCI Cage is always 13 */
+#define XTALK_BRIDGE		15	/* Main Bridge is always 15 */
+#define XTALK_XIO1		12	/* Main XIO Slot / GFX Card */
+
+/* Xbow macros */
+#define XBOW_REG_LINK_STAT_0		0x114
+#define XBOW_REG_LINK_BLOCK_SIZE	0x40
+#define XBOW_REG_LINK_ALIVE		0x80000000
+
+/* For Xtalk Widget identification */
+struct widget_ident {
+	unsigned mfgr;
+	unsigned part;
+	char *name;
+	char *revs[16];
+};
+
+unsigned ip30_xtalk_get_id(int wid);
+unsigned long ip30_xtalk_swin(int wid);
+int ip30_xtalk_find(unsigned mfgr, unsigned part, int last);
+
+#endif /* __ASM_MACH_IP30_XTALK_H */
diff -Naurp linux-2.6.26.orig/include/asm-mips/pci/bridge.h linux-2.6.26/include/asm-mips/pci/bridge.h
--- linux-2.6.26.orig/include/asm-mips/pci/bridge.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/asm-mips/pci/bridge.h	2008-07-25 03:14:40.000000000 -0400
@@ -841,6 +841,17 @@ struct bridge_controller {
 	unsigned int 		irq_cpu;
 	dma64_addr_t		baddr;
 	unsigned int		pci_int[8];
+#ifdef CONFIG_SGI_IP30
+	int			bridge_rev;
+	unsigned int		irq_base;
+	int			slot_be[8];
+	int			slot_bs[8];
+	unsigned int		win_p[8];
+	int			win_io[8];
+	int			win_be[8];
+	unsigned int		dio_p;
+	unsigned int		d32_p;
+#endif
 };
 
 #define BRIDGE_CONTROLLER(bus) \
diff -Naurp linux-2.6.26.orig/include/asm-mips/pci.h linux-2.6.26/include/asm-mips/pci.h
--- linux-2.6.26.orig/include/asm-mips/pci.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/asm-mips/pci.h	2008-07-25 03:14:40.000000000 -0400
@@ -39,6 +39,13 @@ struct pci_controller {
 	   and XFree86. Eventually will be removed. */
 	unsigned int need_domain_info;
 
+	/* called just before pci_scan_bus is executed */
+	int (*pre_scan)(struct pci_controller *);
+	/* called after pci_scan_bus is executed */
+	int (*post_scan)(struct pci_controller *, struct pci_bus *);
+	/* called in pcibios_enable_resources */
+	int (*pre_enable)(struct pci_controller *, struct pci_dev *, int);
+
 	int iommu;
 
 	/* Optional access methods for reading/writing the bus number
diff -Naurp linux-2.6.26.orig/include/linux/fb.h linux-2.6.26/include/linux/fb.h
--- linux-2.6.26.orig/include/linux/fb.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/fb.h	2008-07-25 03:14:40.000000000 -0400
@@ -129,6 +129,8 @@ struct dentry;
 #define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+#define FB_ACCEL_SGI_IMPACTSR   666	/* SGI Octane I/E (IMPACTSR)	*/
+#define FB_ACCEL_SGI_ODYSSEY    668	/* SGI Octane Vx (ODYSSEY)	*/
 
 #define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
 #define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
diff -Naurp linux-2.6.26.orig/include/linux/miscdevice.h linux-2.6.26/include/linux/miscdevice.h
--- linux-2.6.26.orig/include/linux/miscdevice.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/miscdevice.h	2008-07-25 03:14:40.000000000 -0400
@@ -12,6 +12,7 @@
 #define APOLLO_MOUSE_MINOR 7
 #define PC110PAD_MINOR 9
 /*#define ADB_MOUSE_MINOR 10	FIXME OBSOLETE */
+#define LEDS_MINOR	42
 #define WATCHDOG_MINOR		130	/* Watchdog timer     */
 #define TEMP_MINOR		131	/* Temperature Sensor */
 #define RTC_MINOR 135
diff -Naurp linux-2.6.26.orig/include/linux/pci_ids.h linux-2.6.26/include/linux/pci_ids.h
--- linux-2.6.26.orig/include/linux/pci_ids.h	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/include/linux/pci_ids.h	2008-07-25 03:14:40.000000000 -0400
@@ -946,6 +946,7 @@
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
 #define PCI_DEVICE_ID_SGI_LITHIUM	0x1002
+#define PCI_DEVICE_ID_SGI_RAD1		0x0005
 #define PCI_DEVICE_ID_SGI_IOC4		0x100a
 
 #define PCI_VENDOR_ID_WINBOND		0x10ad
diff -Naurp linux-2.6.26.orig/include/sound/rad1.h linux-2.6.26/include/sound/rad1.h
--- linux-2.6.26.orig/include/sound/rad1.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/sound/rad1.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,119 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@linux-mips.org>
+ */
+
+#ifndef _SOUND_RAD1_H
+#define _SOUND_RAD1_H
+
+#include <linux/types.h>
+
+#define RAD1_ADATRX	0
+#define RAD1_AESRX	1
+#define RAD1_ATOD	2
+#define RAD1_ADATSUBRX	3
+#define RAD1_AESSUBRX	4
+#define RAD1_ADATTX	5
+#define RAD1_AESTX	6
+#define RAD1_DTOA	7
+#define RAD1_STATUS	8
+
+struct rad1regs {
+	u32 pci_status;			/* 0x00000000 */
+	u32 adat_rx_msc_ust; 		/* 0x00000004 */
+	u32 adat_rx_msc0_submsc; 	/* 0x00000008 */
+	u32 aes_rx_msc_ust;	 	/* 0x0000000c */
+	u32 aes_rx_msc0_submsc; 	/* 0x00000010 */
+	u32 atod_msc_ust;		/* 0x00000014 */
+	u32 atod_msc0_submsc; 		/* 0x00000018 */
+	u32 adat_tx_msc_ust; 		/* 0x0000001c */
+	u32 adat_tx_msc0_submsc; 	/* 0x00000020 */
+	u32 aes_tx_msc_ust; 		/* 0x00000024 */
+	u32 aes_tx_msc0_submsc; 	/* 0x00000028 */
+	u32 dtoa_msc_ust; 		/* 0x0000002c */
+	u32 ust_register; 		/* 0x00000030 */
+	u32 gpio_status;		/* 0x00000034 */
+	u32 chip_status1; 		/* 0x00000038 */
+	u32 chip_status0;		/* 0x0000003c */
+
+	u32 ust_clock_control; 		/* 0x00000040 */
+	u32 adat_rx_control; 		/* 0x00000044 */
+	u32 aes_rx_control;	 	/* 0x00000048 */
+	u32 atod_control; 		/* 0x0000004c */
+	u32 adat_tx_control; 		/* 0x00000050 */
+	u32 aes_tx_control; 		/* 0x00000054 */
+	u32 dtoa_control; 		/* 0x00000058 */
+	u32 status_timer; 		/* 0x0000005c */
+
+	u32 _pad70[4];
+
+	u32 misc_control; 		/* 0x00000070 */
+	u32 pci_holdoff;		/* 0x00000074 */
+	u32 pci_arb_control; 		/* 0x00000078 */
+
+	u32 volume_control; 		/* 0x0000007c */
+
+	u32 reset;			/* 0x00000080 */
+
+	u32 gpio0;			/* 0x00000084 */
+	u32 gpio1;			/* 0x00000088 */
+	u32 gpio2;			/* 0x0000008c */
+	u32 gpio3;			/* 0x00000090 */
+
+	u32 _pada0[3];
+
+	u32 clockgen_ictl; 		/* 0x000000a0 */
+	u32 clockgen_rem;	 	/* 0x000000a4 */
+	u32 freq_synth_mux_sel[4]; 	/* 0x000000a8 */
+	u32 mpll0_lock_control;		/* 0x000000b8 */
+	u32 mpll1_lock_control;	 	/* 0x000000bc */
+
+	u32 _pad400[208];
+
+	/* descriptor RAM */
+	struct {
+		u32 loadr; 		/* 0x00000400 + 12*idx */
+		u32 hiadr; 		/* 0x00000404 + 12*idx */
+		u32 control;		/* 0x00000408 + 12*idx */
+	} pci_descr[16];
+
+	/* running descriptors */
+	struct {
+		u32 loadr;
+		u32 control;
+	} pci_lc[9];
+	u32 pci_hiadr[9];
+
+	u32 _pad1000[693];
+
+	u32 adat_subcode_txa_u[24];	/* 0x00001000 */
+	u32 adat_subcode_txa_unused;	/* 0x00001060 */
+
+	u32 _pad1080[7];
+
+	u32 adat_subcode_txb_u[24];	/* 0x00001080 */
+	u32 adat_subcode_txb_unused;	/* 0x000010e0 */
+
+	u32 _pad1100[7];
+
+	u32 aes_subcode_txa_lu[6];	/* 0x00001100 */
+	u32 aes_subcode_txa_lc[6];	/* 0x00001118 */
+	u32 aes_subcode_txa_lv[6];	/* 0x00001130 */
+	u32 aes_subcode_txa_ru[6];	/* 0x00001148 */
+	u32 aes_subcode_txa_rc[6];	/* 0x00001160 */
+	u32 aes_subcode_txa_rv0[2];	/* 0x00001178 */
+	u32 aes_subcode_txb_lu[6];	/* 0x00001180 */
+	u32 aes_subcode_txb_lc[6];	/* 0x00001198 */
+	u32 aes_subcode_txb_lv[6];	/* 0x000011b0 */
+	u32 aes_subcode_txb_ru[6];	/* 0x000011c8 */
+	u32 aes_subcode_txb_rc[6];	/* 0x000011e0 */
+	u32 aes_subcode_txb_rv0[2];	/* 0x000011f8 */
+	u32 aes_subcode_txa_rv2[4];	/* 0x00001200 */
+	u32 aes_subcode_txb_rv2[4];	/* 0x00001210 */
+	u32 aes_subcode_tx_unused; 	/* 0x00001220 */
+};
+
+#endif /* _SOUND_RAD1_H */
diff -Naurp linux-2.6.26.orig/include/video/impactsr.h linux-2.6.26/include/video/impactsr.h
--- linux-2.6.26.orig/include/video/impactsr.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/video/impactsr.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,138 @@
+/*
+ *  linux/drivers/video/impactsr.h -- SGI Octane MardiGras (IMPACTSR) graphics
+ *
+ *  Copyright (c) 2004 by Stanislaw Skowronek
+ *  
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef IMPACTSR_H
+#define IMPACTSR_H
+
+/* Xtalk */
+#define IMPACTSR_XTALK_MFGR		0x2aa
+#define IMPACTSR_XTALK_PART		0xc003
+
+/* Convenient access macros */
+#define IMPACTSR_REG64(vma,off)		(*(volatile unsigned long *)((vma)+(off)))
+#define IMPACTSR_REG32(vma,off)		(*(volatile unsigned int *)((vma)+(off)))
+#define IMPACTSR_REG16(vma,off)		(*(volatile unsigned short *)((vma)+(off)))
+#define IMPACTSR_REG8(vma,off)		(*(volatile unsigned char *)((vma)+(off)))
+
+/* ImpactSR (HQ4) register offsets */
+#define IMPACTSR_CFIFO(vma)		IMPACTSR_REG64(vma,0x20400)
+#define IMPACTSR_CFIFOW(vma)		IMPACTSR_REG32(vma,0x20400)
+#define IMPACTSR_CFIFOP(vma)		IMPACTSR_REG64(vma,0x130400)
+#define IMPACTSR_CFIFOPW(vma)		IMPACTSR_REG32(vma,0x130400)
+
+#define IMPACTSR_STATUS(vma)		IMPACTSR_REG32(vma,0x20000)
+#define IMPACTSR_FIFOSTATUS(vma)	IMPACTSR_REG32(vma,0x20008)
+#define IMPACTSR_GIOSTATUS(vma)		IMPACTSR_REG32(vma,0x20100)
+#define IMPACTSR_DMABUSY(vma)		IMPACTSR_REG32(vma,0x20200)
+
+#define IMPACTSR_RESTATUS(vma)		IMPACTSR_REG32(vma,0x2c578)
+
+#define IMPACTSR_CFIFO_HW(vma)		IMPACTSR_REG32(vma,0x40000)
+#define IMPACTSR_CFIFO_LW(vma)		IMPACTSR_REG32(vma,0x40008)
+#define IMPACTSR_CFIFO_DELAY(vma)	IMPACTSR_REG32(vma,0x40010)
+#define IMPACTSR_DFIFO_HW(vma)		IMPACTSR_REG32(vma,0x40020)
+#define IMPACTSR_DFIFO_LW(vma)		IMPACTSR_REG32(vma,0x40028)
+#define IMPACTSR_DFIFO_DELAY(vma)	IMPACTSR_REG32(vma,0x40030)
+
+#define IMPACTSR_XMAP_PP1SELECT(vma)	IMPACTSR_REG8(vma,0x71c08)
+#define IMPACTSR_XMAP_INDEX(vma)	IMPACTSR_REG8(vma,0x71c88)
+#define IMPACTSR_XMAP_CONFIG(vma)	IMPACTSR_REG32(vma,0x71d00)
+#define IMPACTSR_XMAP_CONFIGB(vma)	IMPACTSR_REG8(vma,0x71d08)
+#define IMPACTSR_XMAP_BUF_SELECT(vma)	IMPACTSR_REG32(vma,0x71d80)
+#define IMPACTSR_XMAP_MAIN_MODE(vma)	IMPACTSR_REG32(vma,0x71e00)
+#define IMPACTSR_XMAP_OVERLAY_MODE(vma)	IMPACTSR_REG32(vma,0x71e80)
+#define IMPACTSR_XMAP_DIB(vma)		IMPACTSR_REG32(vma,0x71f00)
+#define IMPACTSR_XMAP_DIB_DW(vma)	IMPACTSR_REG32(vma,0x71f40)
+#define IMPACTSR_XMAP_RE_RAC(vma)	IMPACTSR_REG32(vma,0x71f80)
+
+#define IMPACTSR_VC3_INDEX(vma)		IMPACTSR_REG8(vma,0x72008)
+#define IMPACTSR_VC3_INDEXDATA(vma)	IMPACTSR_REG32(vma,0x72038)
+#define IMPACTSR_VC3_DATA(vma)		IMPACTSR_REG16(vma,0x720b0)
+#define IMPACTSR_VC3_RAM(vma)		IMPACTSR_REG16(vma,0x72190)
+
+#define IMPACTSR_BDVERS0(vma)		IMPACTSR_REG8(vma,0x72408)
+#define IMPACTSR_BDVERS1(vma)		IMPACTSR_REG8(vma,0x72488)
+
+/* FIFO status */
+#define IMPACTSR_CFIFO_MAX		128
+#define IMPACTSR_BFIFO_MAX		16
+
+/* Commands for CFIFO */
+#define IMPACTSR_CMD_WRITERSS(reg,val)	(((0x00180004L|((reg)<<8))<<32)|((unsigned)(val)&0xffffffff))
+#define IMPACTSR_CMD_EXECRSS(reg,val)	(((0x001c0004L|((reg)<<8))<<32)|((unsigned)(val)&0xffffffff))
+
+#define IMPACTSR_CMD_GLINE_XSTARTF(v)	IMPACTSR_CMD_WRITERSS(0x00c,v)
+#define IMPACTSR_CMD_IR_ALIAS(v)	IMPACTSR_CMD_EXECRSS(0x045,v)
+#define IMPACTSR_CMD_BLOCKXYSTARTI(x,y)	IMPACTSR_CMD_WRITERSS(0x046,((x)<<16)|(y))
+#define IMPACTSR_CMD_BLOCKXYENDI(x,y)	IMPACTSR_CMD_WRITERSS(0x047,((x)<<16)|(y))
+#define IMPACTSR_CMD_PACKEDCOLOR(v)	IMPACTSR_CMD_WRITERSS(0x05b,v)
+#define IMPACTSR_CMD_RED(v)		IMPACTSR_CMD_WRITERSS(0x05c,v)
+#define IMPACTSR_CMD_ALPHA(v)		IMPACTSR_CMD_WRITERSS(0x05f,v)
+#define IMPACTSR_CMD_CHAR(v)		IMPACTSR_CMD_EXECRSS(0x070,v)
+#define IMPACTSR_CMD_CHAR_H(v)		IMPACTSR_CMD_WRITERSS(0x070,v)
+#define IMPACTSR_CMD_CHAR_L(v)		IMPACTSR_CMD_EXECRSS(0x071,v)
+#define IMPACTSR_CMD_XFRCONTROL(v)	IMPACTSR_CMD_WRITERSS(0x102,v)
+#define IMPACTSR_CMD_FILLMODE(v)	IMPACTSR_CMD_WRITERSS(0x110,v)
+#define IMPACTSR_CMD_CONFIG(v)		IMPACTSR_CMD_WRITERSS(0x112,v)
+#define IMPACTSR_CMD_XYWIN(x,y)		IMPACTSR_CMD_WRITERSS(0x115,((y)<<16)|(x))
+#define IMPACTSR_CMD_BKGRD_RG(v)	IMPACTSR_CMD_WRITERSS(0x140,((v)<<8))
+#define IMPACTSR_CMD_BKGRD_BA(v)	IMPACTSR_CMD_WRITERSS(0x141,((v)<<8))
+#define IMPACTSR_CMD_WINMODE(v)		IMPACTSR_CMD_WRITERSS(0x14f,v)
+#define IMPACTSR_CMD_XFRSIZE(x,y)	IMPACTSR_CMD_WRITERSS(0x153,((y)<<16)|(x))
+#define IMPACTSR_CMD_XFRMASKLO(v)	IMPACTSR_CMD_WRITERSS(0x156,v)
+#define IMPACTSR_CMD_XFRMASKHI(v)	IMPACTSR_CMD_WRITERSS(0x157,v)
+#define IMPACTSR_CMD_XFRCOUNTERS(x,y)	IMPACTSR_CMD_WRITERSS(0x158,((y)<<16)|(x))
+#define IMPACTSR_CMD_XFRMODE(v)		IMPACTSR_CMD_WRITERSS(0x159,v)
+#define IMPACTSR_CMD_RE_TOGGLECNTX(v)	IMPACTSR_CMD_WRITERSS(0x15f,v)
+#define IMPACTSR_CMD_PIXCMD(v)		IMPACTSR_CMD_WRITERSS(0x160,v)
+#define IMPACTSR_CMD_PP1FILLMODE(m,o)	IMPACTSR_CMD_WRITERSS(0x161,(m)|(o<<26))
+#define IMPACTSR_CMD_COLORMASKMSBS(v)	IMPACTSR_CMD_WRITERSS(0x162,v)
+#define IMPACTSR_CMD_COLORMASKLSBSA(v)	IMPACTSR_CMD_WRITERSS(0x163,v)
+#define IMPACTSR_CMD_COLORMASKLSBSB(v)	IMPACTSR_CMD_WRITERSS(0x164,v)
+#define IMPACTSR_CMD_BLENDFACTOR(v)	IMPACTSR_CMD_WRITERSS(0x165,v)
+#define IMPACTSR_CMD_DRBPOINTERS(v)	IMPACTSR_CMD_WRITERSS(0x16d,v)
+
+#define	IMPACTSR_CMD_HQ_PIXELFORMAT(v)	(0x000c000400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_SCANWIDTH(v)	(0x000a020400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_DMATYPE(v)	(0x000a060400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_LIST_0(v)	(0x0008000400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_WIDTH(v)	(0x0008040400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_OFFSET(v)	(0x0008050400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_STARTADDR(v)	(0x0008060400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_LINECNT(v)	(0x0008070400000000L|((unsigned)(v)&0xffffffff))
+#define	IMPACTSR_CMD_HQ_PG_WIDTHA(v)	(0x0008080400000000L|((unsigned)(v)&0xffffffff))
+#define IMPACTSR_CMD_HQ_TXBASE(p)	(0x00482008|((p)<<9))
+#define IMPACTSR_CMD_HQ_TXMAX(p,v)	(0x0048300400000000L|((unsigned)(v)&0xffffffff)|((unsigned long)(p)<<40))
+#define IMPACTSR_CMD_HQ_PGBITS(p,v)	(0x00482b0400000000L|((unsigned)(v)&0xffffffff)|((unsigned long)(p)<<40))
+#define IMPACTSR_CMD_HQ_PGSIZE(v)	(0x00482a0400000000L|((unsigned)(v)&0xffffffff))
+#define IMPACTSR_CMD_HQ_STACKPTR(v)	(0x00483a0400000000L|((unsigned)(v)&0xffffffff))
+
+/* Logic operations for the PP1 (SI=source invert, DI=dest invert, RI=result invert) */
+#define IMPACTSR_LO_CLEAR	0
+#define IMPACTSR_LO_AND		1
+#define IMPACTSR_LO_DIAND	2
+#define IMPACTSR_LO_COPY	3
+#define IMPACTSR_LO_SIAND	4
+#define IMPACTSR_LO_NOP		5
+#define IMPACTSR_LO_XOR		6
+#define IMPACTSR_LO_OR		7
+#define IMPACTSR_LO_RIOR	8
+#define IMPACTSR_LO_RIXOR	9
+#define IMPACTSR_LO_RINOP	10
+#define IMPACTSR_LO_DIOR	11
+#define IMPACTSR_LO_RICOPY	12
+#define IMPACTSR_LO_SIOR	13
+#define IMPACTSR_LO_RIAND	14
+#define IMPACTSR_LO_SET		15
+
+/* Blending factors */
+#define IMPACTSR_BLEND_ALPHA	0x0704c900
+
+#endif /* IMPACTSR_H */
diff -Naurp linux-2.6.26.orig/include/video/odyssey.h linux-2.6.26/include/video/odyssey.h
--- linux-2.6.26.orig/include/video/odyssey.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/include/video/odyssey.h	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,52 @@
+/*
+ *  linux/drivers/video/odyssey.h -- SGI Octane Odyssey graphics
+ *
+ *  Copyright (c) 2005 by Stanislaw Skowronek
+ *  
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef ODYSSEY_H
+#define ODYSSEY_H
+
+/* Xtalk */
+#define ODY_XTALK_MFGR			0x023
+#define ODY_XTALK_PART			0xc013
+
+/* Convenient access macros */
+#define ODY_REG64(vma,off)		(*(volatile unsigned long *)((vma)+(off)))
+#define ODY_REG32(vma,off)		(*(volatile unsigned int *)((vma)+(off)))
+
+/* ImpactSR registers */
+#define ODY_CFIFO_D(vma)		ODY_REG64(vma,0x110000)
+#define ODY_CFIFO_W(vma)		ODY_REG32(vma,0x110000)
+
+#define ODY_DFIFO_D(vma)		ODY_REG64(vma,0x400000)
+#define ODY_DFIFO_W(vma)		ODY_REG32(vma,0x400000)
+
+#define ODY_STATUS0(vma)		ODY_REG32(vma,0x001064)
+#define ODY_STATUS0_CFIFO_HW		0x00008000
+#define ODY_STATUS0_CFIFO_LW		0x00020000
+#define ODY_DBESTAT(vma)		ODY_REG32(vma,0x00106c)
+
+/* Logic operations (SI=source invert, DI=dest invert, RI=result invert) */
+#define ODY_LO_CLEAR	0
+#define ODY_LO_AND	1
+#define ODY_LO_DIAND	2
+#define ODY_LO_COPY	3
+#define ODY_LO_SIAND	4
+#define ODY_LO_NOP	5
+#define ODY_LO_XOR	6
+#define ODY_LO_OR	7
+#define ODY_LO_RIOR	8
+#define ODY_LO_RIXOR	9
+#define ODY_LO_RINOP	10
+#define ODY_LO_DIOR	11
+#define ODY_LO_RICOPY	12
+#define ODY_LO_SIOR	13
+#define ODY_LO_RIAND	14
+#define ODY_LO_SET	15
+
+#endif /* ODYSSEY_H */
diff -Naurp linux-2.6.26.orig/sound/pci/Kconfig linux-2.6.26/sound/pci/Kconfig
--- linux-2.6.26.orig/sound/pci/Kconfig	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/sound/pci/Kconfig	2008-07-25 03:14:40.000000000 -0400
@@ -975,4 +975,10 @@ config SND_AC97_POWER_SAVE_DEFAULT
 	  The default time-out value in seconds for AC97 automatic
 	  power-save mode.  0 means to disable the power-save mode.
 
+config SND_RAD1
+	tristate "SGI RAD1"
+	depends on SND && SGI_IP30
+	help
+	  Say 'Y' or 'M' to include support for SGI RAD1 Pro Audio in Octane.
+
 endmenu
diff -Naurp linux-2.6.26.orig/sound/pci/Makefile linux-2.6.26/sound/pci/Makefile
--- linux-2.6.26.orig/sound/pci/Makefile	2008-07-13 17:51:29.000000000 -0400
+++ linux-2.6.26/sound/pci/Makefile	2008-07-25 03:14:40.000000000 -0400
@@ -21,6 +21,7 @@ snd-fm801-objs := fm801.o
 snd-intel8x0-objs := intel8x0.o
 snd-intel8x0m-objs := intel8x0m.o
 snd-maestro3-objs := maestro3.o
+snd-rad1-objs := rad1.o
 snd-rme32-objs := rme32.o
 snd-rme96-objs := rme96.o
 snd-sis7019-objs := sis7019.o
@@ -47,6 +48,7 @@ obj-$(CONFIG_SND_FM801) += snd-fm801.o
 obj-$(CONFIG_SND_INTEL8X0) += snd-intel8x0.o
 obj-$(CONFIG_SND_INTEL8X0M) += snd-intel8x0m.o
 obj-$(CONFIG_SND_MAESTRO3) += snd-maestro3.o
+obj-$(CONFIG_SND_RAD1) += snd-rad1.o
 obj-$(CONFIG_SND_RME32) += snd-rme32.o
 obj-$(CONFIG_SND_RME96) += snd-rme96.o
 obj-$(CONFIG_SND_SIS7019) += snd-sis7019.o
diff -Naurp linux-2.6.26.orig/sound/pci/rad1.c linux-2.6.26/sound/pci/rad1.c
--- linux-2.6.26.orig/sound/pci/rad1.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.26/sound/pci/rad1.c	2008-07-25 03:14:40.000000000 -0400
@@ -0,0 +1,1247 @@
+/*
+ * rad1.c - ALSA driver for SGI RAD1 (as found in Octane and Octane2)
+ * Copyright (C) 2004-2007 by Stanislaw Skowronek <skylark@linux-mips.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/control.h>
+
+#include <sound/rad1.h>
+
+typedef struct snd_rad1_pipe {
+	unsigned long pma;		/* physical addr of the ring */
+	int *vma;			/* virtual addr of the ring */
+	struct snd_pcm_substream *subs;	/* ALSA substream */
+	struct snd_pcm *pcm;
+	unsigned int pnum;		/* number of periods */
+	unsigned int plen;		/* length of period (in bytes) */
+	unsigned int hptr;		/* hardware pointer */
+	int adma;			/* DMA active flag */
+	unsigned int qptr;		/* queue pointer */
+} rad1_pipe_t;
+
+typedef struct snd_rad1 {
+	spinlock_t lock;
+	struct snd_card *card;
+	struct pci_dev *pci;
+	unsigned long mmio_phys;
+	volatile struct rad1regs *mmio;
+	int timer_active;
+	struct timer_list timer;
+	rad1_pipe_t pipes[9];
+
+	/* random stuff */
+	int last_aesrx_rate;
+
+	/* card controls */
+	unsigned int attctrl;		/* attenuation control */
+	unsigned int rt_atod;		/* AtoD routing */
+	unsigned int rt_aesr;		/* AES Rx routing */
+	unsigned int rt_adat;		/* ADAT Rx routing */
+	unsigned int rt_opto;		/* Optical Out routing */
+} rad1_t;
+#define chip_t rad1_t
+
+static void snd_rad1_hw_init(rad1_t *chip)
+{
+	/* The hex values listed here are, for the most part, unknown values
+	 * determined by running portions of the IRIX kernel inside of Linux
+	 * as a userland application and then extracting the run-time info.
+	 *
+	 * We could define them via macros if we wanted, but the macro names
+	 * would be no more intelligible as RAD1_ANCIENT_MU_* than they are
+	 * simple hex numbers, so until the purpose of each value is known,
+	 * they shall remain as simple hex numbers.
+	 *
+	 * The same applies for pretty much any other hex number found in
+	 * driver that isn't a bit mask or some sort.  One day, we may figure
+	 * it all out, and create an appropriate header file to define them
+	 * all as intelligible macros.
+	 */
+
+	chip->mmio->reset =			0xffffffff;
+	udelay(1000);
+	chip->mmio->reset =			0xffe3cffe;
+	chip->mmio->pci_holdoff =		0x08000010;
+	chip->mmio->pci_arb_control =		0x00fac688;
+
+	/* I/O routing */
+	chip->mmio->atod_control =		0x03000000;	/* Mike 03000000; LineIn 05000000 */
+	chip->rt_atod =				0x03000000;
+	chip->mmio->dtoa_control =		0x20000000;	/* Default */
+	chip->mmio->aes_rx_control =		0x00000018;	/* Optical In 00000018; AES In 00000010 */
+	chip->rt_aesr =				0x00000018;
+	chip->mmio->aes_tx_control =		0x40000000;	/* Default */
+	chip->mmio->adat_rx_control =		0xa0000000;	/* Disabled A0000000; Optical In A0000018 */
+	chip->rt_adat =				0xa0000000;
+	chip->mmio->adat_tx_control =		0x20000000;	/* Default */
+	chip->mmio->gpio3 =			0x00000002;
+	chip->mmio->misc_control =		0x00001500;
+	chip->mmio->mpll0_lock_control =	0x9fffffff;
+	chip->mmio->mpll1_lock_control =	0x9fffffff;
+	chip->mmio->reset =			0xffe3c0fe;
+	udelay(1000);
+	chip->mmio->clockgen_ictl =		0x02000001;
+	chip->mmio->reset =			0xffe24070;
+	udelay(1000);
+	chip->mmio->reset =			0xffe20000;
+	chip->mmio->gpio2 =			0x00000002;
+	chip->mmio->volume_control =		0xd6d6d6d6;
+	chip->attctrl =				0xd6d6d6d6;
+	udelay(1000);
+	chip->mmio->misc_control =		0x00001040;	/* AES-Optical Out 00001040; AES-AES Out 00001440 */
+	chip->rt_opto =				0x00001040;
+	chip->mmio->reset =			0xffe20100;
+	chip->mmio->freq_synth_mux_sel[3] =	0x00000001;
+	chip->mmio->clockgen_rem =		0x0000ffff;
+	chip->mmio->clockgen_ictl =		0x10000603;
+	chip->mmio->reset =			0xffe20000;
+	chip->mmio->reset =			0xffe20200;
+	chip->mmio->freq_synth_mux_sel[2] =	0x00000001;
+	chip->mmio->clockgen_rem =		0x0000ffff;
+	chip->mmio->clockgen_ictl =		0x20000603;
+	chip->mmio->reset =			0xffe20000;
+	chip->mmio->reset =			0xffe20400;
+	chip->mmio->freq_synth_mux_sel[1] =	0x00000001;
+	chip->mmio->clockgen_rem =		0x0000ffff;
+	chip->mmio->clockgen_ictl =		0x40000603;
+	chip->mmio->reset =			0xffe20000;
+	chip->mmio->reset =			0xffe20800;
+	chip->mmio->freq_synth_mux_sel[0] =	0x00000001;
+	chip->mmio->clockgen_rem =		0x0000ffff;
+	chip->mmio->clockgen_ictl =		0x80000603;
+	chip->mmio->reset =			0xffe20000;
+	chip->mmio->gpio1 =			0x00000003;
+	udelay(10000);
+}
+
+static void snd_rad1_setup_dma_pipe(rad1_t *chip, int pidx)
+{
+	rad1_pipe_t *pipe=chip->pipes+pidx;
+
+	if ((-pipe->pnum * pipe->plen) & 0x7f)
+		printk(KERN_WARNING "rad1: pipe %d has unaligned size %d\n", pidx, (pipe->pnum * pipe->plen));
+
+	chip->mmio->pci_descr[pidx].hiadr = (pipe->pma >> 32);
+	chip->mmio->pci_descr[pidx].loadr = (pipe->pma & 0xffffffff);
+	chip->mmio->pci_descr[pidx].control = ((-pipe->pnum * pipe->plen) & 0xffffff80) | (pidx << 3);
+
+	chip->mmio->pci_hiadr[pidx] = (pipe->pma >> 32);
+	chip->mmio->pci_lc[pidx].loadr = (pipe->pma & 0xffffffff);
+	chip->mmio->pci_lc[pidx].control = ((-pipe->pnum * pipe->plen) & 0xffffff80) | (pidx << 3);
+}
+
+static void snd_rad1_activate_timer(rad1_t *chip)
+{
+	if (!chip->timer_active) {
+		chip->timer.expires = (jiffies + 1);
+		add_timer(&chip->timer);
+		chip->timer_active = 1;
+	}
+}
+
+static void snd_rad1_run_pipe(rad1_t *chip, int pidx, int adma)
+{
+	rad1_pipe_t *pipe = (chip->pipes + pidx);
+
+	if (pipe->adma != adma) {
+		pipe->adma = adma;
+
+		switch (pidx) {
+		case RAD1_ATOD:
+			chip->mmio->atod_control = (chip->rt_atod | adma);
+			break;
+		case RAD1_DTOA:
+			chip->mmio->dtoa_control = (0x20000000 | adma);
+			break;
+		case RAD1_AESRX:
+			chip->mmio->aes_rx_control = (chip->rt_aesr | adma);
+			break;
+		case RAD1_AESTX:
+			chip->mmio->aes_tx_control = (0x40000000 | adma);
+			break;
+		}
+	}
+
+	if (adma)
+		snd_rad1_activate_timer(chip);
+}
+
+static void snd_rad1_poll_pipe(rad1_t *chip, int pidx, int is_tx)
+{
+	rad1_pipe_t *pipe = (chip->pipes + pidx);
+	unsigned int hptr = (pipe->pnum * pipe->plen) + (chip->mmio->pci_lc[pidx].control & 0xffffff80);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (pipe->adma && pipe->subs) {
+		/* use hardware pointer to detect period crossing */
+		if ((hptr / pipe->plen) != (pipe->hptr / pipe->plen)) {
+			if (is_tx)
+				pipe->qptr = (hptr / 8);
+			else
+				pipe->qptr = (pipe->hptr / 8);
+			spin_unlock_irqrestore(&chip->lock, flags);
+			snd_pcm_period_elapsed(pipe->subs);
+			spin_lock_irqsave(&chip->lock, flags);
+		}
+		pipe->hptr = hptr;
+	}
+	spin_unlock_irqrestore(&chip->lock, flags);
+}
+
+static void snd_rad1_poll_timer(unsigned long chip_virt)
+{
+	rad1_t *chip = (rad1_t *)chip_virt;
+	int adma = 0;
+
+	if (chip->pipes[RAD1_ATOD].adma) {
+		snd_rad1_poll_pipe(chip, RAD1_ATOD, 0);
+		adma = 1;
+	}
+	if (chip->pipes[RAD1_DTOA].adma) {
+		snd_rad1_poll_pipe(chip, RAD1_DTOA, 1);
+		adma = 1;
+	}
+	if (chip->pipes[RAD1_AESRX].adma) {
+		snd_rad1_poll_pipe(chip, RAD1_AESRX, 0);
+		adma = 1;
+	}
+	if (chip->pipes[RAD1_AESTX].adma) {
+		snd_rad1_poll_pipe(chip, RAD1_AESTX, 1);
+		adma = 1;
+	}
+
+	if (adma) {
+		chip->timer.expires = (jiffies + 1);
+		add_timer(&chip->timer);
+	} else
+		chip->timer_active = 0;
+}
+
+static int snd_rad1_free_pipe(struct snd_pcm_substream *substream, int pidx)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	rad1_pipe_t *pipe = (chip->pipes + pidx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	snd_rad1_run_pipe(chip, pidx, 0);
+	pipe->subs = NULL;
+	spin_unlock_irqrestore(&chip->lock, flags);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static long snd_rad1_gcd(long x, long y)
+{
+	long t;
+	if (x < y) {
+		t = x;
+		x = y;
+		y = t;
+	}
+
+	while (y) {
+		y = x % (t = y);
+		x = t;
+	}
+
+	return x;
+}
+
+static void snd_rad1_red_frac(long *n, long *d, long max)
+{
+	long gcd = snd_rad1_gcd(*n, *d);
+	if (!gcd)
+		return;
+
+	*n /= gcd;
+	*d /= gcd;
+
+	/* lose precision */
+	while (*n > max || *d > max) {
+		*n >>= 1;
+		*d >>= 1;
+	}
+}
+
+static void snd_rad1_set_cg(rad1_t *chip, int cg, long rate, long base, unsigned muxsel)
+{
+	long div, rem;
+	unsigned flags;
+
+	snd_rad1_red_frac(&base, &rate, 0xffff);
+	div = (base / rate);
+	rem = (base % rate);
+	snd_rad1_red_frac(&rem, &rate, 0xffff);
+	flags = ((rem * 2) < rate) ? 0x600 : 0x200;
+
+	chip->mmio->reset = 0xffe20000 | (0x100 << cg);
+	chip->mmio->freq_synth_mux_sel[3 - cg] = muxsel;
+	chip->mmio->clockgen_rem = (rem << 16) | (0x10000 - rate);
+	chip->mmio->clockgen_ictl = flags | (0x10000000 << cg) | (div - 1);
+	chip->mmio->reset = 0xffe20000;
+}
+
+/* select best master clock source for low jitter */
+static void snd_rad1_set_cgms(rad1_t *chip, int cg, long rate)
+{
+	if (!(176400 % rate))
+		snd_rad1_set_cg(chip, cg, rate, 176400, 0);
+	else
+		snd_rad1_set_cg(chip, cg, rate, 192000, 1);
+}
+
+static void snd_rad1_set_aestx_subcode(rad1_t *chip, unsigned char *sub_lc, unsigned char *sub_rc)
+{
+	unsigned int i, j, lc[6], rc[6];
+
+	for (i = 0; i < 6; i++) {
+		lc[i] = rc[i] = 0;
+		for (j = 0; j < 4; j++) {
+			lc[i] |= sub_lc[i * 4 + j] << (j << 3);
+			rc[i] |= sub_rc[i * 4 + j] << (j << 3);
+		}
+	}
+
+	for (i = 0; i < 6; i++) {
+		chip->mmio->aes_subcode_txa_lu[i] = 0x00000000;
+		chip->mmio->aes_subcode_txa_lc[i] = lc[i];
+		chip->mmio->aes_subcode_txa_lv[i] = 0x00000000;
+		chip->mmio->aes_subcode_txa_ru[i] = 0x00000000;
+		chip->mmio->aes_subcode_txa_rc[i] = rc[i];
+		chip->mmio->aes_subcode_txb_lu[i] = 0x00000000;
+		chip->mmio->aes_subcode_txb_lc[i] = lc[i];
+		chip->mmio->aes_subcode_txb_lv[i] = 0x00000000;
+		chip->mmio->aes_subcode_txb_ru[i] = 0x00000000;
+		chip->mmio->aes_subcode_txb_rc[i] = rc[i];
+	}
+
+	for (i = 0; i < 2; i++) {
+		chip->mmio->aes_subcode_txa_rv0[i] = 0x00000000;
+		chip->mmio->aes_subcode_txb_rv0[i] = 0x00000000;
+	}
+
+	for (i = 0; i < 4; i++) {
+		chip->mmio->aes_subcode_txa_rv2[i] = 0x00000000;
+		chip->mmio->aes_subcode_txb_rv2[i] = 0x00000000;
+	}
+}
+
+static void snd_rad1_genset_aestx_subcode(rad1_t *chip, int rate)
+{
+	unsigned char lc[24], rc[24];
+	int i;
+	for (i = 0; i < 24; i++)
+		lc[i] = rc[i] = 0x00;
+	lc[0] = rc[0] = 0x04;	/* PRO=0, !AUDIO=0, COPY=1, PRE=000, MODE=00 */
+	lc[1] = rc[1] = 0x01;	/* Laser Optical, CD IEC-908 */
+	lc[2] = 0x10;		/* SOURCE=0000, CHANNEL=0001 */
+	rc[2] = 0x20;		/* SOURCE=0000, CHANNEL=0010 */
+
+	/* RAD1 systems have generally decent clock sources, so we mark them Level I */
+	switch (rate) {
+	case 32000:
+		lc[3] = rc[3] = 0x0C;	/* Level I, 32 kHz */
+		break;
+	case 44100:
+		lc[3] = rc[3] = 0x00;	/* Level I, 44.1 kHz */
+		break;
+	case 48000:
+		lc[3] = rc[3] = 0x04;	/* Level I, 48 kHz */
+		break;
+	default:
+		/* not a valid IEC-958 sample rate */
+		lc[3] = rc[3] = 0x10;	/* Level III, 44.1 kHz */
+	}
+	snd_rad1_set_aestx_subcode(chip, lc, rc);
+}
+
+static void snd_rad1_setrate_pipe(rad1_t *chip, int pidx, int rate)
+{
+	if (pidx == RAD1_ATOD)
+		snd_rad1_set_cgms(chip, 0, rate);
+	if (pidx == RAD1_DTOA)
+		snd_rad1_set_cgms(chip, 1, rate);
+	if (pidx == RAD1_AESTX) {
+		snd_rad1_set_cgms(chip, 2, rate);
+		snd_rad1_genset_aestx_subcode(chip, rate);
+	}
+}
+
+static int snd_rad1_prepare_pipe(struct snd_pcm_substream *substream, int pidx)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	rad1_pipe_t *pipe = (chip->pipes + pidx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	snd_rad1_run_pipe(chip, pidx, 0);
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pipe->subs = substream;
+	pipe->vma = (int *)runtime->dma_area;
+	pipe->pma = runtime->dma_addr;
+	pipe->pnum = runtime->periods;
+	pipe->plen = frames_to_bytes(runtime, runtime->period_size);
+
+	snd_rad1_setrate_pipe(chip, pidx, runtime->rate);
+
+	pipe->hptr = 0;
+	pipe->qptr = 0;
+	snd_rad1_setup_dma_pipe(chip, pidx);
+
+	return 0;
+}
+
+static void snd_rad1_detect_aesrx_rate(rad1_t *chip, struct snd_pcm_hardware *hw)
+{
+	int rate;
+	unsigned sc = ((chip->mmio->chip_status0) >> 24) & 7;
+	static int rates[8] = {0, 48000, 44100, 32000, 48000, 44100, 44056, 32000};
+
+	if (!rates[sc]) {
+		printk(KERN_INFO "Warning: Recording from an unlocked IEC958 source.\n");
+		printk(KERN_INFO "         Assuming sample rate: %d.\n", chip->last_aesrx_rate);
+		rate = chip->last_aesrx_rate;
+	} else
+		rate = rates[sc];
+
+	chip->last_aesrx_rate = rate;
+	hw->rate_min = hw->rate_max = rate;
+
+	switch (rate) {
+	case 32000:
+		hw->rates = SNDRV_PCM_RATE_32000;
+		break;
+	case 44056:
+		hw->rates = SNDRV_PCM_RATE_CONTINUOUS;
+		break;
+	case 48000:
+		hw->rates = SNDRV_PCM_RATE_48000;
+	case 44100:
+	default:
+		hw->rates = SNDRV_PCM_RATE_44100;
+		break;
+	}
+}
+
+static int snd_rad1_trigger_pipe(struct snd_pcm_substream *substream, int pidx, int cmd)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	int result = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		snd_rad1_run_pipe(chip, pidx, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		snd_rad1_run_pipe(chip, pidx, 0);
+		break;
+	default:
+		result = -EINVAL;
+	}
+	return result;
+}
+
+static snd_pcm_uframes_t snd_rad1_pointer_pipe(struct snd_pcm_substream *substream, int pidx)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	return chip->pipes[pidx].qptr;
+}
+
+/* ATOD pipe */
+static struct snd_pcm_hardware snd_rad1_atod_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats = SNDRV_PCM_FMTBIT_S24_BE,
+	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_32000 |
+		 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+	.rate_min = 32000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 1048576,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 4096,
+	.periods_min = 4,
+	.periods_max = 256,
+};
+
+static int snd_rad1_atod_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	runtime->hw = snd_rad1_atod_hw;
+	return 0;
+}
+
+static int snd_rad1_atod_close(struct snd_pcm_substream *substream)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	snd_rad1_run_pipe(chip, RAD1_ATOD, 0);
+	return 0;
+}
+
+static int snd_rad1_atod_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_rad1_atod_free(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_free_pipe(substream, RAD1_ATOD);
+}
+
+static int snd_rad1_atod_prepare(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_prepare_pipe(substream, RAD1_ATOD);
+}
+
+static int snd_rad1_atod_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	return snd_rad1_trigger_pipe(substream, RAD1_ATOD, cmd);
+}
+
+static snd_pcm_uframes_t snd_rad1_atod_pointer(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_pointer_pipe(substream, RAD1_ATOD);
+}
+
+static struct snd_pcm_ops snd_rad1_atod_ops = {
+	.open = snd_rad1_atod_open,
+	.close = snd_rad1_atod_close,
+	.hw_params = snd_rad1_atod_params,
+	.hw_free = snd_rad1_atod_free,
+	.prepare = snd_rad1_atod_prepare,
+	.trigger = snd_rad1_atod_trigger,
+	.pointer = snd_rad1_atod_pointer,
+	.ioctl = snd_pcm_lib_ioctl,
+};
+
+static void snd_rad1_atod_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int __devinit snd_rad1_new_atod(rad1_t *chip, int dev)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	if ((err = snd_pcm_new(chip->card, "RAD1 AtoD", dev, 0, 1, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_rad1_atod_pcm_free;
+	strcpy(pcm->name, "RAD1 AtoD");
+	chip->pipes[RAD1_ATOD].pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_rad1_atod_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      65536, 65536);
+
+	return 0;
+}
+
+/* DTOA pipe */
+static struct snd_pcm_hardware snd_rad1_dtoa_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats = SNDRV_PCM_FMTBIT_S24_BE,
+	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_32000 |
+		 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+	.rate_min = 32000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 1048576,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 4096,
+	.periods_min = 4,
+	.periods_max = 256,
+};
+
+static int snd_rad1_dtoa_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	runtime->hw = snd_rad1_dtoa_hw;
+	return 0;
+}
+
+static int snd_rad1_dtoa_close(struct snd_pcm_substream *substream)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	snd_rad1_run_pipe(chip, RAD1_DTOA, 0);
+	return 0;
+}
+
+static int snd_rad1_dtoa_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_rad1_dtoa_free(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_free_pipe(substream, RAD1_DTOA);
+}
+
+static int snd_rad1_dtoa_prepare(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_prepare_pipe(substream, RAD1_DTOA);
+}
+
+static int snd_rad1_dtoa_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	return snd_rad1_trigger_pipe(substream, RAD1_DTOA, cmd);
+}
+
+static snd_pcm_uframes_t snd_rad1_dtoa_pointer(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_pointer_pipe(substream, RAD1_DTOA);
+}
+
+static struct snd_pcm_ops snd_rad1_dtoa_ops = {
+	.open = snd_rad1_dtoa_open,
+	.close = snd_rad1_dtoa_close,
+	.hw_params = snd_rad1_dtoa_params,
+	.hw_free = snd_rad1_dtoa_free,
+	.prepare = snd_rad1_dtoa_prepare,
+	.trigger = snd_rad1_dtoa_trigger,
+	.pointer = snd_rad1_dtoa_pointer,
+	.ioctl = snd_pcm_lib_ioctl,
+};
+
+static void snd_rad1_dtoa_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int __devinit snd_rad1_new_dtoa(rad1_t *chip, int dev)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	if ((err = snd_pcm_new(chip->card, "RAD1 DtoA", dev, 1, 0, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_rad1_dtoa_pcm_free;
+	strcpy(pcm->name, "RAD1 DtoA");
+	chip->pipes[RAD1_DTOA].pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_rad1_dtoa_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      65536, 65536);
+
+	return 0;
+}
+
+/* AESRX pipe */
+static struct snd_pcm_hardware snd_rad1_aesrx_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats = SNDRV_PCM_FMTBIT_S24_BE,
+	.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_32000,
+	.rate_min = 32000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 1048576,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 4096,
+	.periods_min = 4,
+	.periods_max = 256,
+};
+
+static int snd_rad1_aesrx_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	runtime->hw = snd_rad1_aesrx_hw;
+	snd_rad1_detect_aesrx_rate(chip, &runtime->hw);
+	return 0;
+}
+
+static int snd_rad1_aesrx_close(struct snd_pcm_substream *substream)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	snd_rad1_run_pipe(chip, RAD1_AESRX, 0);
+	return 0;
+}
+
+static int snd_rad1_aesrx_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_rad1_aesrx_free(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_free_pipe(substream, RAD1_AESRX);
+}
+
+static int snd_rad1_aesrx_prepare(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_prepare_pipe(substream, RAD1_AESRX);
+}
+
+static int snd_rad1_aesrx_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	return snd_rad1_trigger_pipe(substream, RAD1_AESRX, cmd);
+}
+
+static snd_pcm_uframes_t snd_rad1_aesrx_pointer(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_pointer_pipe(substream, RAD1_AESRX);
+}
+
+static struct snd_pcm_ops snd_rad1_aesrx_ops = {
+	.open = snd_rad1_aesrx_open,
+	.close = snd_rad1_aesrx_close,
+	.hw_params = snd_rad1_aesrx_params,
+	.hw_free = snd_rad1_aesrx_free,
+	.prepare = snd_rad1_aesrx_prepare,
+	.trigger = snd_rad1_aesrx_trigger,
+	.pointer = snd_rad1_aesrx_pointer,
+	.ioctl = snd_pcm_lib_ioctl,
+};
+
+static void snd_rad1_aesrx_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int __devinit snd_rad1_new_aesrx(rad1_t *chip, int dev)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	if ((err = snd_pcm_new(chip->card, "RAD1 AES Rx", dev, 0, 1, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_rad1_aesrx_pcm_free;
+	strcpy(pcm->name, "RAD1 AES Rx");
+	chip->pipes[RAD1_AESRX].pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_rad1_aesrx_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      65536, 65536);
+	chip->last_aesrx_rate = 44100;
+
+	return 0;
+}
+
+/* AESTX pipe */
+static struct snd_pcm_hardware snd_rad1_aestx_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.formats = SNDRV_PCM_FMTBIT_S24_BE,
+	.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
+	.rate_min = 32000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 1048576,
+	.period_bytes_min = 4096,
+	.period_bytes_max = 4096,
+	.periods_min = 4,
+	.periods_max = 256,
+};
+
+static int snd_rad1_aestx_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	runtime->hw = snd_rad1_aestx_hw;
+	return 0;
+}
+
+static int snd_rad1_aestx_close(struct snd_pcm_substream *substream)
+{
+	rad1_t *chip = snd_pcm_substream_chip(substream);
+	snd_rad1_run_pipe(chip, RAD1_AESTX, 0);
+	return 0;
+}
+
+static int snd_rad1_aestx_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+}
+
+static int snd_rad1_aestx_free(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_free_pipe(substream, RAD1_AESTX);
+}
+
+static int snd_rad1_aestx_prepare(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_prepare_pipe(substream, RAD1_AESTX);
+}
+
+static int snd_rad1_aestx_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	return snd_rad1_trigger_pipe(substream, RAD1_AESTX, cmd);
+}
+
+static snd_pcm_uframes_t snd_rad1_aestx_pointer(struct snd_pcm_substream *substream)
+{
+	return snd_rad1_pointer_pipe(substream, RAD1_AESTX);
+}
+
+static struct snd_pcm_ops snd_rad1_aestx_ops = {
+	.open = snd_rad1_aestx_open,
+	.close = snd_rad1_aestx_close,
+	.hw_params = snd_rad1_aestx_params,
+	.hw_free = snd_rad1_aestx_free,
+	.prepare = snd_rad1_aestx_prepare,
+	.trigger = snd_rad1_aestx_trigger,
+	.pointer = snd_rad1_aestx_pointer,
+	.ioctl = snd_pcm_lib_ioctl,
+};
+
+static void snd_rad1_aestx_pcm_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int __devinit snd_rad1_new_aestx(rad1_t *chip, int dev)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	if ((err = snd_pcm_new(chip->card, "RAD1 AES Tx", dev, 1, 0, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = chip;
+	pcm->private_free = snd_rad1_aestx_pcm_free;
+	strcpy(pcm->name, "RAD1 AES Tx");
+	chip->pipes[RAD1_AESTX].pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_rad1_aestx_ops);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      snd_dma_pci_data(chip->pci),
+					      65536, 65536);
+
+	return 0;
+}
+
+/* Volume control */
+static int snd_rad1_control_pv_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 255;
+	return 0;
+}
+
+static int snd_rad1_control_pv_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int shift=kcontrol->private_value * 16;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	u->value.integer.value[0] = (chip->attctrl >> shift) & 0xff;
+	u->value.integer.value[1] = (chip->attctrl >> (8 + shift)) & 0xff;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int snd_rad1_control_pv_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int change = 0, shift = kcontrol->private_value * 16;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (u->value.integer.value[0] != ((chip->attctrl >> shift) & 0xff))
+		change = 1;
+
+	if (u->value.integer.value[1] != ((chip->attctrl >> (8 + shift)) & 0xff))
+		change = 1;
+
+	if (change) {
+		chip->attctrl &= 0xffff << (16 - shift);
+		chip->attctrl |= u->value.integer.value[0] << shift;
+		chip->attctrl |= u->value.integer.value[1] << (8 + shift);
+		chip->mmio->volume_control = chip->attctrl;
+	}
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return change;
+}
+
+/* AES Tx route control */
+static int snd_rad1_control_tr_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info * uinfo)
+{
+	static char *rts[2] = {"Optical", "Coaxial"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, rts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_rad1_control_tr_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (chip->rt_opto == 0x00001440)
+		u->value.enumerated.item[0] = 1;
+	else
+		u->value.enumerated.item[0] = 0;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int snd_rad1_control_tr_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int change = 0;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (u->value.enumerated.item[0] && chip->rt_opto != 0x00001440)
+		change = 1;
+	if (!u->value.enumerated.item[0] && chip->rt_opto == 0x00001440)
+		change = 1;
+	if (change) {
+		if (u->value.enumerated.item[0])
+			chip->rt_opto = 0x00001440;
+		else
+			chip->rt_opto = 0x00001040;
+		chip->mmio->misc_control = chip->rt_opto;
+	}
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return change;
+}
+
+/* AES Rx route control */
+
+static int snd_rad1_control_rr_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (chip->rt_aesr == 0x00000010)
+		u->value.enumerated.item[0] = 1;
+	else
+		u->value.enumerated.item[0] = 0;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int snd_rad1_control_rr_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int change = 0;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (u->value.enumerated.item[0] && chip->rt_aesr != 0x00000010)
+		change = 1;
+	if (!u->value.enumerated.item[0] && chip->rt_aesr == 0x00000010)
+		change = 1;
+	if (change) {
+		if (u->value.enumerated.item[0]) {
+			chip->rt_aesr = 0x00000010;
+			chip->rt_adat = 0xa0000018;
+		} else {
+			chip->rt_aesr = 0x00000018;
+			chip->rt_adat = 0xa0000000;
+		}
+		chip->mmio->aes_rx_control = (chip->rt_aesr | chip->pipes[RAD1_AESRX].adma);
+		chip->mmio->adat_rx_control = (chip->rt_adat | chip->pipes[RAD1_ADATRX].adma);
+	}
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return change;
+}
+
+
+/* AtoD route control */
+static int snd_rad1_control_ar_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info * uinfo)
+{
+	static char *rts[2] = {"Mic", "Line"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name, rts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_rad1_control_ar_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (chip->rt_atod == 0x05000000)
+		u->value.enumerated.item[0] = 1;
+	else
+		u->value.enumerated.item[0] = 0;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int snd_rad1_control_ar_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u)
+{
+	rad1_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned long flags;
+	int change = 0;
+
+	spin_lock_irqsave(&chip->lock, flags);
+	if (u->value.enumerated.item[0] && chip->rt_atod != 0x05000000)
+		change = 1;
+	if (!u->value.enumerated.item[0] && chip->rt_atod == 0x05000000)
+		change = 1;
+	if (change) {
+		if (u->value.enumerated.item[0])
+			chip->rt_atod = 0x05000000;
+		else
+			chip->rt_atod = 0x03000000;
+		chip->mmio->atod_control = (chip->rt_atod | chip->pipes[RAD1_ATOD].adma);
+	}
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return change;
+}
+
+static struct snd_kcontrol_new snd_rad1_controls[] = {
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Master Playback Volume",
+	.info =		snd_rad1_control_pv_info,
+	.get =		snd_rad1_control_pv_get,
+	.put =		snd_rad1_control_pv_put,
+	.private_value = 1
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Line Capture Volume",
+	.info =		snd_rad1_control_pv_info,
+	.get =		snd_rad1_control_pv_get,
+	.put =		snd_rad1_control_pv_put,
+	.private_value = 0
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"IEC958 Playback Routing",
+	.info =		snd_rad1_control_tr_info,
+	.get =		snd_rad1_control_tr_get,
+	.put =		snd_rad1_control_tr_put
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"IEC958 Capture Routing",
+	.info =		snd_rad1_control_tr_info, /* clone */
+	.get =		snd_rad1_control_rr_get,
+	.put =		snd_rad1_control_rr_put
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Line Capture Routing",
+	.info =		snd_rad1_control_ar_info,
+	.get =		snd_rad1_control_ar_get,
+	.put =		snd_rad1_control_ar_put
+},
+};
+
+static int snd_rad1_add_controls(rad1_t *chip)
+{
+	int idx, err;
+
+	for (idx = 0; idx < 5; idx++)
+		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_rad1_controls[idx], chip))) < 0)
+			return err;
+	return 0;
+}
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+static int ndev;
+
+static int snd_rad1_free(rad1_t *chip)
+{
+	if (chip->mmio) {
+		iounmap((void *)(chip->mmio));
+		chip->mmio = NULL;
+	}
+	pci_release_regions(chip->pci);
+	kfree(chip);
+	return 0;
+}
+
+static int snd_rad1_dev_free(struct snd_device *device)
+{
+	rad1_t *chip = device->device_data;
+	return snd_rad1_free(chip);
+}
+
+static int __devinit snd_rad1_create(struct snd_card *card, struct pci_dev *pci, rad1_t **rchip)
+{
+	rad1_t *chip;
+	int err;
+	static struct snd_device_ops ops = {
+		.dev_free = snd_rad1_dev_free,
+	};
+
+	*rchip = NULL;
+
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+
+	chip = kcalloc(sizeof(rad1_t), 1, GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	init_timer(&chip->timer);
+	chip->timer.function = snd_rad1_poll_timer;
+	chip->timer.data = (unsigned long)chip;
+
+	chip->card = card;
+	chip->pci = pci;
+
+	spin_lock_init(&chip->lock);
+
+	pci_set_master(pci);
+
+	if ((err = pci_request_regions(pci, "RAD1")) < 0) {
+		kfree(chip);
+		return err;
+	}
+
+	chip->mmio_phys = pci_resource_start(pci, 0);
+	chip->mmio = ioremap_nocache(chip->mmio_phys, pci_resource_len(pci, 0));
+
+	snd_rad1_hw_init(chip);
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+		snd_rad1_free(chip);
+		return err;
+	}
+	*rchip = chip;
+	return 0;
+}
+
+static struct pci_device_id snd_rad1_ids[] = {
+	{ PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_RAD1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, },
+};
+
+static int __devinit snd_rad1_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	struct snd_card *card;
+	rad1_t *chip;
+	int err;
+
+	if (ndev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[ndev]) {
+		ndev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[ndev], id[ndev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	if ((err = snd_rad1_create(card, pci, &chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	strcpy(card->driver, "RAD1");
+	strcpy(card->shortname, "RADAudio");
+	sprintf(card->longname, "SGI RAD Audio at 0x%lx", chip->mmio_phys);
+
+	/* create pipes */
+	snd_rad1_new_dtoa(chip, 0);
+	snd_rad1_new_atod(chip, 1);
+	snd_rad1_new_aestx(chip, 2);
+	snd_rad1_new_aesrx(chip, 3);
+	snd_rad1_add_controls(chip);
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	pci_set_drvdata(pci, card);
+	ndev++;
+	return 0;
+}
+
+static void __devexit snd_rad1_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+MODULE_DEVICE_TABLE(pci, snd_rad1_ids);
+
+static struct pci_driver driver = {
+	.name = "SGI RAD1",
+	.id_table = snd_rad1_ids,
+	.probe = snd_rad1_probe,
+	.remove = __devexit_p(snd_rad1_remove),
+};
+
+static int __init alsa_card_rad1_init(void)
+{
+	return pci_register_driver(&driver);
+}
+
+static void __exit alsa_card_rad1_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+MODULE_AUTHOR("Stanislaw Skowronek <skylark@linux-mips.org>");
+MODULE_DESCRIPTION("SGI Octane (IP30) RAD1 Alsa Audio Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("R28");
+
+module_init(alsa_card_rad1_init)
+module_exit(alsa_card_rad1_exit)

--------------020900080705080800030905--
