Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2005 16:26:03 +0100 (BST)
Received: from RT-soft-1.Moscow.itn.ru ([IPv6:::ffff:80.240.96.90]:22928 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225804AbVEaPZh>; Tue, 31 May 2005 16:25:37 +0100
Received: from 192.168.1.226 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j4VFPZt07898;
	Tue, 31 May 2005 20:25:35 +0500
Subject: [PATCH] A LSP for NEC VR5701-SG2 Board.
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	ralf@linux-mips.org
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-mspiNCIP3YakTU/JruAA"
Organization: MontaVista
Date:	Tue, 31 May 2005 19:25:53 +0400
Message-Id: <1117553153.5564.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-mspiNCIP3YakTU/JruAA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ralf!

Attached is a LSP core for NEC VR5701-SG2 Board. The CPU is Vr5701,
Vr5500 core. The drivers have been sent separately. Please review it.

Best wishes,
Sergey Podstavin.
  

--=-mspiNCIP3YakTU/JruAA
Content-Disposition: attachment; filename=community_mips_nec_vr5701_lsp.patch
Content-Type: text/x-patch; name=community_mips_nec_vr5701_lsp.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp --exclude=CVS linux_save/arch/mips/Kconfig linux_mips/arch/mips/Kconfig
--- linux_save/arch/mips/Kconfig	2005-03-18 20:36:52.000000000 +0300
+++ linux_mips/arch/mips/Kconfig	2005-05-31 19:03:47.812560480 +0400
@@ -431,6 +431,18 @@ config DDB5477
 	  Features : kernel debugging, serial terminal, NFS root fs, on-board
 	  ether port USB, AC97, PCI, etc.
 
+config TCUBE
+	bool "Support for NEC VR5701-SG2"
+	select IRQ_CPU
+	select HW_HAS_PCI
+	select DMA_NONCOHERENT
+	select NO_SPINLOCK
+	help
+	  This enables support for the VR5500 - based NEC VR5701-SG2
+	  evaluation board.
+
+
+
 config NEC_OSPREY
 	bool "Support for NEC Osprey board"
 	select DMA_NONCOHERENT
@@ -964,6 +976,11 @@ config CPU_R5432
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 
+config CPU_R5500
+	bool "R5500"
+	help
+	  MIPS Technologies Vr5500 - series processors.
+
 config CPU_R6000
 	bool "R6000"
 	depends on EXPERIMENTAL
diff -Naurp --exclude=CVS linux_save/arch/mips/kernel/cpu-probe.c linux_mips/arch/mips/kernel/cpu-probe.c
--- linux_save/arch/mips/kernel/cpu-probe.c	2005-05-25 17:32:49.000000000 +0400
+++ linux_mips/arch/mips/kernel/cpu-probe.c	2005-05-31 19:03:47.822558960 +0400
@@ -93,6 +93,7 @@ static inline void check_wait(void)
 	case CPU_R4650:
 	case CPU_R4700:
 	case CPU_R5000:
+	case CPU_R5500:
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_RM9000:
diff -Naurp --exclude=CVS linux_save/arch/mips/kernel/Makefile linux_mips/arch/mips/kernel/Makefile
--- linux_save/arch/mips/kernel/Makefile	2005-02-21 13:45:09.000000000 +0300
+++ linux_mips/arch/mips/kernel/Makefile	2005-05-31 19:03:47.823558808 +0400
@@ -22,6 +22,7 @@ obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4
 obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_R5500)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R8000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_RM9000)	+= r4k_fpu.o r4k_switch.o
diff -Naurp --exclude=CVS linux_save/arch/mips/lib-32/Makefile linux_mips/arch/mips/lib-32/Makefile
--- linux_save/arch/mips/lib-32/Makefile	2004-06-08 16:03:09.000000000 +0400
+++ linux_mips/arch/mips/lib-32/Makefile	2005-05-31 19:03:47.827558200 +0400
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R6000)		+=
 obj-$(CONFIG_CPU_R8000)		+=
 obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
diff -Naurp --exclude=CVS linux_save/arch/mips/lib-64/Makefile linux_mips/arch/mips/lib-64/Makefile
--- linux_save/arch/mips/lib-64/Makefile	2004-06-08 16:03:09.000000000 +0400
+++ linux_mips/arch/mips/lib-64/Makefile	2005-05-31 19:03:47.897547560 +0400
@@ -13,6 +13,7 @@ obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
+obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
 obj-$(CONFIG_CPU_R6000)		+=
 obj-$(CONFIG_CPU_R8000)		+=
 obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
diff -Naurp --exclude=CVS linux_save/arch/mips/Makefile linux_mips/arch/mips/Makefile
--- linux_save/arch/mips/Makefile	2005-05-19 18:45:12.000000000 +0400
+++ linux_mips/arch/mips/Makefile	2005-05-31 19:03:47.944540416 +0400
@@ -194,6 +194,10 @@ cflags-$(CONFIG_CPU_R5432)	+= \
 			$(call set_gccflags,r5400,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
 
+cflags-$(CONFIG_CPU_R5500)	+= \
+			$(call set_gccflags,mips32,mips4,r5000,mips4,mips2) \
+			-Wa,--trap
+
 cflags-$(CONFIG_CPU_NEVADA)	+= \
 			$(call set_gccflags,rm5200,mips4,r5000,mips4,mips2) \
 			-Wa,--trap
@@ -490,6 +494,13 @@ load-$(CONFIG_DDB5476)		+= 0xffffffff800
 core-$(CONFIG_DDB5477)		+= arch/mips/ddb5xxx/ddb5477/
 load-$(CONFIG_DDB5477)		+= 0xffffffff80100000
 
+#
+# NEC TCUBE
+#
+core-$(CONFIG_TCUBE)		+= arch/mips/vr5701/common/
+core-$(CONFIG_TCUBE)		+= arch/mips/vr5701/tcube/
+load-$(CONFIG_TCUBE)		+= 0xffffffff80080000
+
 core-$(CONFIG_LASAT)		+= arch/mips/lasat/
 cflags-$(CONFIG_LASAT)		+= -Iinclude/asm-mips/mach-lasat
 load-$(CONFIG_LASAT)		+= 0xffffffff80000000
diff -Naurp --exclude=CVS linux_save/arch/mips/mm/Makefile linux_mips/arch/mips/mm/Makefile
--- linux_save/arch/mips/mm/Makefile	2005-01-12 03:10:42.000000000 +0300
+++ linux_mips/arch/mips/mm/Makefile	2005-05-31 19:03:47.997532360 +0400
@@ -18,6 +18,7 @@ obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-
 obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
+obj-$(CONFIG_CPU_R5500)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o pg-r4k.o tlb-r8k.o
 obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
 obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o pg-r4k.o tlb-r4k.o
diff -Naurp --exclude=CVS linux_save/arch/mips/mm/tlbex.c linux_mips/arch/mips/mm/tlbex.c
--- linux_save/arch/mips/mm/tlbex.c	2005-04-28 12:52:57.000000000 +0400
+++ linux_mips/arch/mips/mm/tlbex.c	2005-05-31 19:03:48.007530840 +0400
@@ -784,6 +784,7 @@ static __init void __attribute__((unused
 	case CPU_R5000:
 	case CPU_R5000A:
 	case CPU_NEVADA:
+	case CPU_R5500:
 		i_nop(p);
 		i_tlbp(p);
 		break;
@@ -832,6 +833,7 @@ static __init void build_tlb_write_entry
 	case CPU_R4600:
 	case CPU_R4700:
 	case CPU_R5000:
+	case CPU_R5500:             
 	case CPU_R5000A:
 	case CPU_5KC:
 	case CPU_TX49XX:
diff -Naurp --exclude=CVS linux_save/arch/mips/pci/Makefile linux_mips/arch/mips/pci/Makefile
--- linux_save/arch/mips/pci/Makefile	2004-12-18 05:23:50.000000000 +0300
+++ linux_mips/arch/mips/pci/Makefile	2005-05-31 19:03:48.013529928 +0400
@@ -52,3 +52,4 @@ obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-j
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
+obj-$(CONFIG_TCUBE)		+= pci-tcube.o ops-tcube.o
diff -Naurp --exclude=CVS linux_save/arch/mips/pci/ops-tcube.c linux_mips/arch/mips/pci/ops-tcube.c
--- linux_save/arch/mips/pci/ops-tcube.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/pci/ops-tcube.c	2005-05-31 19:03:48.018529168 +0400
@@ -0,0 +1,267 @@
+/*
+ * arch/mips/pci/ops-tcube.c
+ *
+ * A config access for PCI controllers on NEC VR5701-SG2 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/addrspace.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+/*
+ * config_swap structure records what set of pdar/pmr are used
+ * to access pci config space.  It also provides a place hold the
+ * original values for future restoring.
+ */
+struct pci_config_swap {
+	u32 pdar;
+	u32 pmr;
+	u32 config_base;
+	u32 config_size;
+	u32 pdar_backup;
+	u32 pmr_backup;
+};
+
+/*
+ * On VR5701-SG2, we have two sets of swap registers, for ext PCI and IOPCI.
+ */
+struct pci_config_swap ext_pci_swap = {
+	PADR_EPCIW0,
+	EPCI_INIT0,
+	0x10000000,
+	0x08000000
+};
+struct pci_config_swap io_pci_swap = {
+	PADR_IOPCIW0,
+	IPCI_INIT0,
+	0x18800000,
+	0x00800000
+};
+
+/*
+ * access config space
+ */
+static inline u32 ddb_access_config_base(struct pci_config_swap *swap, u32 bus,	/* 0 means top level bus */
+					 u32 slot_num)
+{
+	u32 pci_addr = 0;
+	u32 pciinit_offset = 0;
+	u32 virt_addr;
+	u32 option;
+
+	/* minimum pdar (window) size is 2MB */
+	db_assert(swap->config_size >= (2 << 20));
+	db_assert(slot_num < (1 << 5));
+	db_assert(bus < (1 << 8));
+
+	/* backup registers */
+	swap->pdar_backup = ddb_in32(swap->pdar);
+	swap->pmr_backup = ddb_in32(swap->pmr);
+
+	/* set the pdar (pci window) register */
+	ddb_set_pdar(swap->pdar, swap->config_base, swap->config_size, 32,	/* 32 bit wide */
+		     0,		/* not on local memory bus */
+		     0);	/* not visible from PCI bus (N/A) */
+
+	/*
+	 * calcuate the absolute pci config addr;
+	 * according to the spec, we start scanning from adr:11 (0x800)
+	 */
+	if (bus == 0) {
+		/* type 0 config */
+		pci_addr = 0x800 << slot_num;
+	} else {
+		/* type 1 config */
+		pci_addr = (bus << 16) | (slot_num << 11);
+	}
+
+	/*
+	 * if pci_addr is less than pci config window size,  we set
+	 * pciinit_offset to 0 and adjust the virt_address.
+	 * Otherwise we will try to adjust pciinit_offset.
+	 */
+	if (pci_addr < swap->config_size) {
+		virt_addr = KSEG1ADDR(swap->config_base + pci_addr);
+		pciinit_offset = 0;
+	} else {
+		db_assert((pci_addr & (swap->config_size - 1)) == 0);
+		virt_addr = KSEG1ADDR(swap->config_base);
+		pciinit_offset = pci_addr;
+	}
+
+	/* set the pmr register */
+	option = DDB_PCI_ACCESS_32;
+	if (bus != 0)
+		option |= DDB_PCI_CFGTYPE1;
+
+	ddb_out32(swap->pmr,
+		  (DDB_PCICMD_CFG << 1) | (pciinit_offset & 0xffe00000) |
+		  option);
+	ddb_out32(swap->pmr + 4, 0);
+
+	return virt_addr;
+}
+
+static inline void ddb_close_config_base(struct pci_config_swap *swap)
+{
+	ddb_out32(swap->pdar, swap->pdar_backup);
+	ddb_out32(swap->pmr, swap->pmr_backup);
+}
+
+static int read_config_dword(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where,
+			     u32 * val)
+{
+	u32 bus_num, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		bus_num = bus->number;
+		db_assert(bus_num != 0);
+	} else {
+		bus_num = 0;
+	}
+	slot_num = PCI_SLOT(devfn);
+	func_num = PCI_FUNC(devfn);
+	base = ddb_access_config_base(swap, bus_num, slot_num);
+	*val = *(volatile u32 *)(base + (func_num << 8) + where);
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int read_config_word(struct pci_config_swap *swap,
+			    struct pci_bus *bus, u32 devfn, u32 where,
+			    u16 * val)
+{
+	int status;
+	u32 result;
+
+	db_assert((where & 1) == 0);
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (where & 2)
+		result >>= 16;
+	*val = result & 0xffff;
+	return status;
+}
+
+static int read_config_byte(struct pci_config_swap *swap,
+			    struct pci_bus *bus, u32 devfn, u32 where, u8 * val)
+{
+	int status;
+	u32 result;
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (where & 1)
+		result >>= 8;
+	if (where & 2)
+		result >>= 16;
+	*val = result & 0xff;
+
+	return status;
+}
+
+static int write_config_dword(struct pci_config_swap *swap,
+			      struct pci_bus *bus, u32 devfn, u32 where,
+			      u32 val)
+{
+	u32 bus_num, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (bus->parent != NULL) {
+		bus_num = bus->number;
+		db_assert(bus_num != 0);
+	} else {
+		bus_num = 0;
+	}
+
+	slot_num = PCI_SLOT(devfn);
+	func_num = PCI_FUNC(devfn);
+	base = ddb_access_config_base(swap, bus_num, slot_num);
+	*(volatile u32 *)(base + (func_num << 8) + where) = val;
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int write_config_word(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where, u16 val)
+{
+	int status, shift = 0;
+	u32 result;
+
+	db_assert((where & 1) == 0);
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL)
+		return status;
+
+	if (where & 2)
+		shift += 16;
+	result &= ~(0xffff << shift);
+	result |= val << shift;
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
+}
+
+static int write_config_byte(struct pci_config_swap *swap,
+			     struct pci_bus *bus, u32 devfn, u32 where, u8 val)
+{
+	int status, shift = 0;
+	u32 result;
+
+	status = read_config_dword(swap, bus, devfn, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL)
+		return status;
+
+	if (where & 2)
+		shift += 16;
+	if (where & 1)
+		shift += 8;
+	result &= ~(0xff << shift);
+	result |= val << shift;
+	return write_config_dword(swap, bus, devfn, where & ~3, result);
+}
+
+#define        MAKE_PCI_OPS(prefix, rw, pciswap, star) \
+static int prefix##_##rw##_config(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 star val) \
+{ \
+	if (size == 1) \
+     		return rw##_config_byte(pciswap, bus, devfn, where, (u8 star)val); \
+	else if (size == 2) \
+     		return rw##_config_word(pciswap, bus, devfn, where, (u16 star)val); \
+	/* Size must be 4 */ \
+     	return rw##_config_dword(pciswap, bus, devfn, where, val); \
+}
+
+MAKE_PCI_OPS(extpci, read, &ext_pci_swap, *)
+    MAKE_PCI_OPS(extpci, write, &ext_pci_swap,)
+
+    MAKE_PCI_OPS(iopci, read, &io_pci_swap, *)
+    MAKE_PCI_OPS(iopci, write, &io_pci_swap,)
+
+struct pci_ops VR5701_ext_pci_ops = {
+	.read = extpci_read_config,
+	.write = extpci_write_config
+};
+
+struct pci_ops VR5701_io_pci_ops = {
+	.read = iopci_read_config,
+	.write = iopci_write_config
+};
diff -Naurp --exclude=CVS linux_save/arch/mips/pci/pci-tcube.c linux_mips/arch/mips/pci/pci-tcube.c
--- linux_save/arch/mips/pci/pci-tcube.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/pci/pci-tcube.c	2005-05-31 19:03:48.018529168 +0400
@@ -0,0 +1,123 @@
+/*
+ * arch/mips/pci/pci-tcube.c
+ *
+ * A code for PCI controllers on NEC VR5701-SG2 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+#include <asm/byteorder.h>
+#include <asm/tcube.h>
+
+static struct resource extpci_io_resource = {
+	"ext pci IO space",
+	0x00001000,
+	0x007FFFFF,
+	IORESOURCE_IO
+};
+
+static struct resource extpci_mem_resource = {
+	"ext pci memory space",
+	0x10000000,
+	0x17FFFFFF,
+	IORESOURCE_MEM
+};
+
+static struct resource iopci_io_resource = {
+	"io pci IO space",
+	0x01000000,
+	0x017FFFFF,
+	IORESOURCE_IO
+};
+
+static struct resource iopci_mem_resource = {
+	"io pci memory space",
+	0x18800000,
+	0x18FFFFFF,
+	IORESOURCE_MEM
+};
+
+struct pci_controller VR5701_ext_controller = {
+	.pci_ops = &VR5701_ext_pci_ops,
+	.io_resource = &extpci_io_resource,
+	.mem_resource = &extpci_mem_resource
+};
+
+struct pci_controller VR5701_io_controller = {
+	.pci_ops = &VR5701_io_pci_ops,
+	.io_resource = &iopci_io_resource,
+	.mem_resource = &iopci_mem_resource
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int slot_num;
+	int k;
+
+	slot_num = PCI_SLOT(dev->devfn);
+
+	if (dev->bus->number == 0) {	/* EPCI */
+		switch (slot_num) {
+		case 25 - 11:	/* INTC# */
+			k = NUM_5701_IRQS + 2;
+			break;
+		case 26 - 11:	/* INTB# */
+			k = NUM_5701_IRQS + 1;
+			break;
+		case 27 - 11:	/* INTA# */
+			k = NUM_5701_IRQS + 0;
+			break;
+		}
+	} else {		/* IPCI */
+		switch (slot_num) {
+		case 29 - 11:	/* INTC# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 2;
+			break;
+		case 30 - 11:	/* INTB# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 1;
+			break;
+		case 31 - 11:	/* INTA# */
+			k = NUM_5701_IRQS + NUM_5701_EPCI_IRQ + 0;
+			break;
+		}
+	}
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, k);
+	dev->irq = k + 8;
+	return dev->irq;
+}
+
+void ddb_pci_reset_bus(void)
+{
+	u32 temp;
+
+	temp = ddb_in32(EPCI_CTRLH);
+	temp |= 0x80000000;
+	ddb_out32(EPCI_CTRLH, temp);
+	udelay(100);
+	temp &= ~0xc0000000;
+	ddb_out32(EPCI_CTRLH, temp);
+
+	temp = ddb_in32(IPCI_CTRLH);
+	temp |= 0x80000000;
+	ddb_out32(IPCI_CTRLH, temp);
+	udelay(100);
+	temp &= ~0xc0000000;
+	ddb_out32(IPCI_CTRLH, temp);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/common/Makefile linux_mips/arch/mips/vr5701/common/Makefile
--- linux_save/arch/mips/vr5701/common/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/common/Makefile	2005-05-31 19:03:48.019529016 +0400
@@ -0,0 +1,5 @@
+#
+# Makefile for the common code of NEC VR5701 board
+#
+
+obj-y += nec_vrxxxx.o prom.o rtc_rx5c348.o
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/common/nec_vrxxxx.c linux_mips/arch/mips/vr5701/common/nec_vrxxxx.c
--- linux_save/arch/mips/vr5701/common/nec_vrxxxx.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/common/nec_vrxxxx.c	2005-05-31 19:03:48.063522328 +0400
@@ -0,0 +1,119 @@
+/*
+ * arch/mips/vr5701/common/nec_vrxxxx.c
+ *
+ * A code for low-level routines on NEC VR5701-SG2 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/tcube.h>
+
+u32
+ddb_calc_pdar(u32 phys, u32 size, int width, int on_memory_bus, int pci_visible)
+{
+	u32 maskbits;
+	u32 widthbits;
+
+	switch (size) {
+	case 0x80000000:	/* 2 GB */
+		maskbits = 5;
+		break;
+	case 0x40000000:	/* 1 GB */
+		maskbits = 6;
+		break;
+	case 0x20000000:	/* 512 MB */
+		maskbits = 7;
+		break;
+	case 0x10000000:	/* 256 MB */
+		maskbits = 8;
+		break;
+	case 0x08000000:	/* 128 MB */
+		maskbits = 9;
+		break;
+	case 0x04000000:	/* 64 MB */
+		maskbits = 10;
+		break;
+	case 0x02000000:	/* 32 MB */
+		maskbits = 11;
+		break;
+	case 0x01000000:	/* 16 MB */
+		maskbits = 12;
+		break;
+	case 0x00800000:	/* 8 MB */
+		maskbits = 13;
+		break;
+	case 0x00400000:	/* 4 MB */
+		maskbits = 14;
+		break;
+	case 0x00200000:	/* 2 MB */
+		maskbits = 15;
+		break;
+	case 0:		/* OFF */
+		maskbits = 0;
+		break;
+	default:
+		panic("VR5701_set_pdar: unsupported size %p", (void *)size);
+	}
+	switch (width) {
+	case 8:
+		widthbits = 0;
+		break;
+	case 16:
+		widthbits = 1;
+		break;
+	case 32:
+		widthbits = 2;
+		break;
+	case 64:
+		widthbits = 3;
+		break;
+	default:
+		panic("VR5701_set_pdar: unsupported width %d", width);
+	}
+
+	return maskbits | (on_memory_bus ? 0x10 : 0) |
+	    (pci_visible ? 0x20 : 0) | (widthbits << 6) | (phys & 0xffe00000);
+}
+
+void
+ddb_set_pdar(u32 pdar, u32 phys, u32 size, int width,
+	     int on_memory_bus, int pci_visible)
+{
+	u32 temp = ddb_calc_pdar(phys, size, width, on_memory_bus, pci_visible);
+	ddb_out32(pdar, temp);
+	ddb_out32(pdar + 4, 0);
+	ddb_in32(pdar);
+	ddb_in32(pdar + 4);
+}
+
+/*
+ * routines that mess with PCIINITx registers
+ */
+
+void ddb_set_pmr(u32 pmr, u32 type, u32 addr, u32 options)
+{
+	switch (type) {
+	case DDB_PCICMD_IACK:	/* PCI Interrupt Acknowledge */
+	case DDB_PCICMD_IO:	/* PCI I/O Space */
+	case DDB_PCICMD_MEM:	/* PCI Memory Space */
+	case DDB_PCICMD_CFG:	/* PCI Configuration Space */
+		break;
+	default:
+		panic("VR5701_set_pmr: invalid type %d", type);
+	}
+	ddb_out32(pmr, (type << 1) | (addr & 0xffe00000) | options);
+	ddb_out32(pmr + 4, 0);
+}
+
+void ddb_set_bar(u32 bar, u32 phys, int prefetchable)
+{
+	ddb_out32(bar, (phys & 0xffe00000) | (!!prefetchable << 3));
+	ddb_out32(bar + 4, 0);
+}
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/common/prom.c linux_mips/arch/mips/vr5701/common/prom.c
--- linux_save/arch/mips/vr5701/common/prom.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/common/prom.c	2005-05-31 19:03:48.064522176 +0400
@@ -0,0 +1,53 @@
+/*
+ * arch/mips/vr5701/common/prom.c
+ *
+ * A code for prom routines on NEC VR5701-SG2 
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/bootmem.h>
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+const char *get_system_type(void)
+{
+	return "NEC VR5701-SG2";
+}
+
+void __init prom_init(void)
+{
+	int i;
+	int argc = fw_arg0;
+	char **arg = (char **)fw_arg1;
+
+	/* if user passes kernel args, ignore the default one */
+	if (argc > 1)
+		arcs_cmdline[0] = '\0';
+
+	/* arg[0] is "g", the rest is boot parameters */
+	for (i = 1; i < argc; i++) {
+		if (strlen(arcs_cmdline) + strlen(arg[i] + 1)
+		    >= sizeof(arcs_cmdline))
+			break;
+		strcat(arcs_cmdline, arg[i]);
+		strcat(arcs_cmdline, " ");
+	}
+	mips_machgroup = MACH_GROUP_SHIMA;
+	mips_machtype = MACH_SHIMA_TCUBE;
+	add_memory_region(0, TCUBE_SDRAM_SIZE, BOOT_MEM_RAM);
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/common/rtc_rx5c348.c linux_mips/arch/mips/vr5701/common/rtc_rx5c348.c
--- linux_save/arch/mips/vr5701/common/rtc_rx5c348.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/common/rtc_rx5c348.c	2005-05-31 19:03:48.065522024 +0400
@@ -0,0 +1,184 @@
+/*
+ * arch/mips/vr5701/common/rtc_rx5c348.c Version 0.02 April 11, 2005
+ *
+ * A Real Time Clock interface for Linux on NEC VR5701-SG2
+ * (RICOH Co., Ltd., Rx5C348B)
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/bcd.h>
+
+#include <asm/time.h>
+#include <asm/addrspace.h>
+#include <asm/delay.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+#undef  DEBUG
+#define RTC_DELAY
+
+void static rtc_set_ce(u32 val)
+{
+	pr_debug("rtc_set_ce(%d)\n", val);
+	reg_set32(GIU_PIO0, GPIO_4_CE, val ? SET_32_BIT : 0);
+#ifdef RTC_DELAY
+	__delay(100000);
+#endif
+}
+
+void static rtc_write_burst(int adr, unsigned char *data, int dataLen)
+{
+	int i;
+	for (i = 0; i < dataLen; i++)
+		pr_debug(" rtc_write_burst : data=%08x\n", data[i]);
+	pr_debug(" rtc_write_burst : adr=0x%02x\n", adr);
+	csi1_reset();
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_AUTO, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, SET_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	rtc_set_ce(1);
+
+	pr_debug(" rtc_write_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_write_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_out32(CSI1_SOTBF, ((adr << 4) | 0x00));
+
+	for (i = 0; i < dataLen; i++) {
+		io_out32(CSI1_SOTB, data[i]);
+		while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+		io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	}
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	rtc_set_ce(0);
+}
+
+void static rtc_read_burst(int adr, unsigned char *data, int dataLen)
+{
+	int i;
+	pr_debug(" rtc_read_burst : adr=0x%02x\n", adr);
+	csi1_reset();
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_AUTO, CLR_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, SET_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+	rtc_set_ce(1);
+
+	pr_debug(" rtc_read_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_read_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_out32(CSI1_SOTB, (((adr & 0xf) << 4) | 0x04));
+	while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_AUTO, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_TRMD, CLR_32_BIT);
+	io_out32(CSI1_INT, CSIn_INT_CSIEND);
+
+	udelay(50);
+	pr_debug(" rtc_read_burst : CSI1_MODE=%08x\n", io_in32(CSI1_MODE));
+	pr_debug(" rtc_read_burst : CSI1_CNT=%08x\n", io_in32(CSI1_CNT));
+	io_in32(CSI1_SIRB);	/* dummy read */
+
+	for (i = 0; i < dataLen; i++) {
+		while (!(io_in32(CSI1_INT) & CSIn_INT_CSIEND)) ;
+		io_out32(CSI1_INT, CSIn_INT_CSIEND);
+		data[i] = io_in32(CSI1_SIRB);
+	}
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+	rtc_set_ce(0);
+	for (i = 0; i < dataLen; i++)
+		pr_debug(" rtc_read_burst : data=%08x\n", data[i]);
+}
+
+static unsigned long rtc_ricoh_rx5c348_get_time(void)
+{
+	u8 date[7];
+	unsigned int year, month, day, hour, minute, second;
+
+	rtc_read_burst(0, date, sizeof(date));
+
+	year = BCD2BIN(date[6]) + (date[5] & 0x80 ? 2000 : 1900);
+	month = BCD2BIN(date[5] & 0x1f);
+	day = BCD2BIN(date[4]);
+	hour = BCD2BIN(date[2]);
+	minute = BCD2BIN(date[1]);
+	second = BCD2BIN(date[0]);
+
+	pr_debug(KERN_INFO
+		 "rtc_ricoh_rx5c348_get_time: %d/%02d/%02d %02d:%02d:%02d\n",
+		 year, month, day, hour, minute, second);
+	return mktime(year, month, day, hour, minute, second);
+}
+
+static int rtc_ricoh_rx5c348_set_time(unsigned long t)
+{
+	u8 date[7];
+	struct rtc_time tm;
+
+	to_tm(t, &tm);
+	date[0] = BIN2BCD(tm.tm_sec);
+	date[1] = BIN2BCD(tm.tm_min);
+	date[2] = BIN2BCD(tm.tm_hour);
+	date[4] = BIN2BCD(tm.tm_mday);
+	date[5] = BIN2BCD(tm.tm_mon + 1) + (tm.tm_year > 1999 ? 0x80 : 0);
+	date[6] =
+	    BIN2BCD(tm.tm_year > 1999 ? tm.tm_year - 2000 : tm.tm_year - 1900);
+
+	rtc_write_burst(0, date, 3);
+	rtc_write_burst(4, date + 4, 3);
+
+	pr_debug(KERN_INFO
+		 "rtc_ricoh_rx5c348_set_time:t=%ld %d/%02d/%02d %02d:%02d:%02d\n",
+		 t, tm.tm_year, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
+		 tm.tm_min, tm.tm_sec);
+	return 0;
+}
+
+static int __devinit rtc_ricoh_rx5c348_init(void)
+{
+	unsigned char data;
+	/* CSI1 reset  */
+	io_set16(PIB_RESET, 0x40, 0xffff);
+	__delay(10000);
+	io_set16(PIB_RESET, 0x40, 0x0000);
+
+	/* set GPIO3 , GPIO4 */
+	reg_set32(GIU_FUNCSEL0, (GPIO_4_CE | GPIO_3_INTR), SET_32_BIT);
+	/* clear GPIO25 , GPIO26 , GPIO27 */
+	reg_set32(GIU_FUNCSEL0, GPIO_CSI1_PIN, CLR_32_BIT);
+	/* make GPIO4 output */
+	reg_set32(GIU_DIR0, GPIO_4_CE, SET_32_BIT);
+	/* make GPIO3 input  */
+	reg_set32(GIU_DIR0, GPIO_3_INTR, CLR_32_BIT);
+
+	csi1_reset();
+
+	rtc_read_burst(0x0e, &data, 1);
+	if ((data & 0x20) == 0) {	/* 24 hour */
+		data |= 0x20;
+		rtc_write_burst(0x0e, &data, 1);
+#ifdef RTC_DELAY
+		__delay(10000);
+#endif
+	}
+
+	/* set the function pointers */
+	rtc_get_time = rtc_ricoh_rx5c348_get_time;
+	rtc_set_time = rtc_ricoh_rx5c348_set_time;
+	return 0;
+}
+
+module_init(rtc_ricoh_rx5c348_init);
+
+MODULE_AUTHOR("Sergey Podstavin");
+MODULE_DESCRIPTION("Real Time Clock interface for Linux on T-Cube VR5701");
+MODULE_LICENSE("GPL");
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/tcube/int-handler.S linux_mips/arch/mips/vr5701/tcube/int-handler.S
--- linux_save/arch/mips/vr5701/tcube/int-handler.S	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/tcube/int-handler.S	2005-05-31 19:03:48.065522024 +0400
@@ -0,0 +1,78 @@
+/*
+ * arch/mips/vr5701/tcube/int-handler.S
+ *
+ * First-level interrupt dispatcher for NEC VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#define  __ASSEMBLY__
+#include <linux/config.h>
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/tcube.h>
+
+/*
+ * first level interrupt dispatcher for ocelot board -
+ * We check for the timer first, then check PCI ints A and D.
+ * Then check for serial IRQ and fall through.
+ */
+	.align	5
+	NESTED(tcube_handle_int, PT_SIZE, sp)
+	SAVE_ALL
+	CLI
+	.set	at
+	.set	noreorder
+	mfc0	t0, CP0_CAUSE  
+	mfc0	t2, CP0_STATUS
+
+	and	t0, t2
+       
+	andi	t1, t0, STATUSF_IP7	/* cpu timer */
+	bnez	t1, ll_cputimer_irq
+	andi	t1, t0, (STATUSF_IP2 | STATUSF_IP3 | STATUSF_IP4 | STATUSF_IP5 | STATUSF_IP6 ) 
+	bnez	t1, ll_tcube_irq
+	andi	t1, t0, STATUSF_IP0	/* software int 0 */
+	bnez	t1, ll_cpu_ip0
+	andi	t1, t0, STATUSF_IP1	/* software int 1 */
+	bnez	t1, ll_cpu_ip1
+	nop
+	.set	reorder
+
+	/* wrong alarm or masked ... */
+	j	spurious_interrupt
+	nop
+	END(tcube_handle_int)
+
+	.align	5
+
+ll_tcube_irq:	
+	move	a0, sp
+	jal	tcube_irq_dispatch
+	j	ret_from_irq
+
+ll_cputimer_irq:
+	li	a0, 7
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
+
+
+ll_cpu_ip0:	
+	li	a0, 0
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
+
+ll_cpu_ip1:	
+	li	a0, 1
+	move	a1, sp
+	jal	do_IRQ
+	j	ret_from_irq
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/tcube/irq.c linux_mips/arch/mips/vr5701/tcube/irq.c
--- linux_save/arch/mips/vr5701/tcube/irq.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/tcube/irq.c	2005-05-31 19:03:48.066521872 +0400
@@ -0,0 +1,146 @@
+/*
+ * arch/mips/vr5701/tcube/irq.c
+ *
+ * The irq setup and misc routines for NEC VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+/*
+ * IRQ mapping
+ *
+ *  0-7: 8 CPU interrupts
+ *	0 -	software interrupt 0
+ *	1 -	software interrupt 1
+ *	2 -	most Vrc5477 interrupts are routed to this pin
+ *	3 -	(optional) some other interrupts routed to this pin for debugg
+ *	4 -	not used
+ *	5 -	not used
+ *	6 -	not used
+ *	7 -	cpu timer (used by default)
+ *
+ */
+
+void tcube_irq_setup(void)
+{
+	pr_debug("T-Cube irq setup invoked.\n");
+
+	/* by default, we disable all interrupts and route all vr5701
+	 * interrupts to pin 0 (irq 2) */
+	ddb_out32(INT_ROUTE0, 0);
+	ddb_out32(INT_ROUTE1, 0);
+	ddb_out32(INT_ROUTE2, 0);
+	ddb_out32(INT_ROUTE3, 0);
+	ddb_out32(INT_MASK, 0);
+	ddb_out32(INT_CLR, ~0x0);
+
+	clear_c0_status(0xff00);
+	set_c0_status(0x0400);
+
+	ll_vr5701_irq_route(24, 1);
+	ll_vr5701_irq_enable(24);
+	ll_vr5701_irq_route(25, 1);
+	ll_vr5701_irq_enable(25);
+	ll_vr5701_irq_route(28, 1);
+	ll_vr5701_irq_enable(28);
+	ll_vr5701_irq_route(29, 1);
+	ll_vr5701_irq_enable(29);
+	ll_vr5701_irq_route(30, 1);
+	ll_vr5701_irq_enable(30);
+	ll_vr5701_irq_route(31, 1);
+	ll_vr5701_irq_enable(31);
+	set_c0_status(0x0800);
+	set_except_vector(0, tcube_handle_int);
+	/* init all controllers */
+	mips_cpu_irq_init(0);
+	vr5701_irq_init(8);
+}
+
+/*
+ * the first level int-handler will jump here if it is a vr7701 irq
+ */
+
+asmlinkage void tcube_irq_dispatch(struct pt_regs *regs)
+{
+	u32 intStatus;
+	u32 bitmask;
+	u32 i;
+	u32 intPCIStatus;
+	if (ddb_in32(INT1_STAT) != 0) {
+		printk(KERN_CRIT "NMI  = %x\n", ddb_in32(NMI_STAT));
+		printk(KERN_CRIT "INT0 = %x\n", ddb_in32(INT0_STAT));
+		printk(KERN_CRIT "INT1 = %x\n", ddb_in32(INT1_STAT));
+		printk(KERN_CRIT "INT2 = %x\n", ddb_in32(INT2_STAT));
+		printk(KERN_CRIT "INT3 = %x\n", ddb_in32(INT3_STAT));
+		printk(KERN_CRIT "INT4 = %x\n", ddb_in32(INT4_STAT));
+		printk(KERN_CRIT "EPCI_ERR = %x\n", ddb_in32(EPCI_ERR));
+		printk(KERN_CRIT "IPCI_ERR = %x\n", ddb_in32(IPCI_ERR));
+
+		panic("error interrupt has happened.");
+	}
+
+	intStatus = ddb_in32(INT0_STAT);
+
+	if (intStatus & 1 << 6)
+		goto IRQ_EPCI;
+
+	if (intStatus & 1 << 7)
+		goto IRQ_IPCI;
+
+      IRQ_OTHER:
+	for (i = 0, bitmask = 1; i <= NUM_5701_IRQS; bitmask <<= 1, i++) {
+		/* do we need to "and" with the int mask? */
+		if (intStatus & bitmask) {
+			do_IRQ(8 + i, regs);
+		}
+	}
+	return;
+
+      IRQ_EPCI:
+	intStatus &= ~(1 << 6);	/* unset Status flag */
+	intPCIStatus = ddb_in32(EPCI_INTS);
+	for (i = 0, bitmask = 1; i < NUM_5701_EPCI_IRQS; bitmask <<= 1, i++) {
+		if (intPCIStatus & bitmask) {
+			do_IRQ(8 + NUM_5701_IRQS + i, regs);
+		}
+	}
+	if (!intStatus)
+		return;
+
+      IRQ_IPCI:
+	intStatus &= ~(1 << 7);
+	intPCIStatus = ddb_in32(IPCI_INTS);
+	if (!intPCIStatus)
+		goto IRQ_OTHER;
+
+	for (i = 0, bitmask = 1; i < NUM_5701_IPCI_IRQS; bitmask <<= 1, i++) {
+		if (intPCIStatus & bitmask) {
+			do_IRQ(8 + NUM_5701_IRQS + NUM_5701_EPCI_IRQS + i,
+			       regs);
+		}
+	}
+
+	if (!intStatus)
+		return;
+
+	goto IRQ_OTHER;
+}
+
+void __init arch_init_irq(void)
+{
+	/* invoke board-specific irq setup */
+	tcube_irq_setup();
+}
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/tcube/irq_vr5701.c linux_mips/arch/mips/vr5701/tcube/irq_vr5701.c
--- linux_save/arch/mips/vr5701/tcube/irq_vr5701.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/tcube/irq_vr5701.c	2005-05-31 19:03:48.067521720 +0400
@@ -0,0 +1,194 @@
+/*
+ * arch/mips/vr5701/tcube/irq_vr5701.c
+ *
+ * This file defines the irq handler for NEC VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+/*
+ * Vr5701 defines 32 IRQs.
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+static int vr5701_irq_base = -1;
+
+void ll_vr5701_irq_disable(int vr5701_irq, int ack);
+
+static void vr5701_irq_enable(unsigned int irq)
+{
+	ll_vr5701_irq_enable(irq - vr5701_irq_base);
+}
+
+static void vr5701_irq_disable(unsigned int irq)
+{
+	ll_vr5701_irq_disable(irq - vr5701_irq_base, 0);
+}
+
+static unsigned int vr5701_irq_startup(unsigned int irq)
+{
+	vr5701_irq_enable(irq);
+	return 0;
+}
+
+static void vr5701_irq_ack(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+
+	/* clear the interrupt bit for edge trigger */
+	/* some irqs require the driver to clear the sources */
+	if (irq < vr5701_irq_base + NUM_5701_IRQ) {
+		ddb_out32(INT_CLR, 1 << (irq - vr5701_irq_base));
+	}
+	/* don't need for PCIs, for they are level triger */
+
+	/* disable interrupt - some handler will re-enable the irq
+	 * and if the interrupt is leveled, we will have infinite loop
+	 */
+	ll_vr5701_irq_disable(irq - vr5701_irq_base, 1);
+	local_irq_restore(flags);
+}
+
+static void vr5701_irq_end(unsigned int irq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+		ll_vr5701_irq_enable(irq - vr5701_irq_base);
+	}
+	local_irq_restore(flags);
+}
+
+struct hw_interrupt_type vr5701_irq_type = {
+	"vr5701_irq",
+	vr5701_irq_startup,
+	vr5701_irq_disable,
+	vr5701_irq_enable,
+	vr5701_irq_disable,
+	vr5701_irq_ack,
+	vr5701_irq_end,
+	NULL			/* no affinity stuff for UP */
+};
+
+void vr5701_irq_init(u32 irq_base)
+{
+	extern irq_desc_t irq_desc[];
+	u32 i;
+	vr5701_irq_base = irq_base;
+	for (i = irq_base;
+	     i < irq_base + NUM_5701_IRQ + NUM_EPCI_IRQ + NUM_IPCI_IRQ; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = 0;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &vr5701_irq_type;
+	}
+}
+
+int vr5701_irq_to_irq(int irq)
+{
+	return irq + vr5701_irq_base;
+}
+
+void ll_vr5701_irq_route(int vr5701_irq, int ip)
+{
+	u32 reg_value;
+	u32 reg_bitmask;
+	u32 reg_index;
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			vr5701_irq = 7;
+		} else {
+			vr5701_irq = 6;
+		}
+	}
+	reg_index = INT_ROUTE0 + vr5701_irq / 8 * 4;
+	reg_value = ddb_in32(reg_index);
+	reg_bitmask = 7 << (vr5701_irq % 8 * 4);
+	reg_value &= ~reg_bitmask;
+	reg_value |= ip << (vr5701_irq % 8 * 4);
+	ddb_out32(reg_index, reg_value);
+}
+
+void ll_vr5701_irq_enable(int vr5701_irq)
+{
+	u16 reg_value;
+	u32 reg_bitmask;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	irq_desc[vr5701_irq_base + vr5701_irq].depth++;
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			reg_value = ddb_in32(IPCI_INTM);
+			reg_bitmask =
+			    1 << (vr5701_irq - NUM_5701_IRQ - NUM_EPCI_IRQ);
+			ddb_out32(IPCI_INTM, reg_value | reg_bitmask);
+			vr5701_irq = 7;
+		} else {
+			reg_value = ddb_in32(EPCI_INTM);
+			reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ);
+			ddb_out32(EPCI_INTM, reg_value | reg_bitmask);
+			vr5701_irq = 6;
+		}
+	}
+	reg_value = ddb_in32(INT_MASK);
+	ddb_out32(INT_MASK, reg_value | (1 << vr5701_irq));
+	local_irq_restore(flags);
+}
+
+void ll_vr5701_irq_disable(int vr5701_irq, int ack)
+{
+	u16 reg_value;
+	u32 udummy;
+	u32 reg_bitmask;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (!ack) {
+		irq_desc[vr5701_irq_base + vr5701_irq].depth--;
+		if (irq_desc[vr5701_irq_base + vr5701_irq].depth) {
+			local_irq_restore(flags);
+			return;
+		}
+	}
+
+	if (vr5701_irq >= NUM_5701_IRQ) {
+		if (vr5701_irq >= NUM_5701_IRQ + NUM_EPCI_IRQ) {
+			goto DISABLE_IRQ_IPCI;
+		} else {
+			goto DISABLE_IRQ_EPCI;
+		}
+	}
+	reg_value = ddb_in32(INT_MASK);
+	ddb_out32(INT_MASK, reg_value & ~(1 << vr5701_irq));
+	udummy = ddb_in32(INT_MASK);
+	local_irq_restore(flags);
+	return;
+
+      DISABLE_IRQ_IPCI:
+	reg_value = ddb_in32(IPCI_INTM);
+	reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ - NUM_EPCI_IRQ);
+	ddb_out32(IPCI_INTM, reg_value & ~reg_bitmask);
+	local_irq_restore(flags);
+	return;
+
+      DISABLE_IRQ_EPCI:
+	reg_value = ddb_in32(EPCI_INTM);
+	reg_bitmask = 1 << (vr5701_irq - NUM_5701_IRQ);
+	ddb_out32(EPCI_INTM, reg_value & ~reg_bitmask);
+	local_irq_restore(flags);
+}
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/tcube/Makefile linux_mips/arch/mips/vr5701/tcube/Makefile
--- linux_save/arch/mips/vr5701/tcube/Makefile	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/tcube/Makefile	2005-05-31 19:03:48.067521720 +0400
@@ -0,0 +1,7 @@
+#
+# Makefile for the NEC VR5701-SG2 specific kernel interface routines
+# under Linux.
+#
+
+obj-y += setup.o irq.o int-handler.o irq_vr5701.o 
+EXTRA_AFLAGS: = $(CFLAGS)
diff -Naurp --exclude=CVS linux_save/arch/mips/vr5701/tcube/setup.c linux_mips/arch/mips/vr5701/tcube/setup.c
--- linux_save/arch/mips/vr5701/tcube/setup.c	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/arch/mips/vr5701/tcube/setup.c	2005-05-31 19:03:48.068521568 +0400
@@ -0,0 +1,189 @@
+/*
+ * arch/mips/vr5701/tcube/setup.c
+ *
+ * Setup file for NEC VR5701-SG2
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/console.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/fs.h>		/* for ROOT_DEV */
+#include <linux/ioport.h>
+#include <linux/param.h>	/* for HZ */
+#include <asm/bootinfo.h>
+#include <asm/addrspace.h>
+#include <asm/time.h>
+#include <asm/bcache.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/debug.h>
+#include <asm/tcube.h>
+
+static void tcube_machine_restart(char *command)
+{
+	static void (*back_to_prom) (void) = (void (*)(void))0xbfc00000;
+	back_to_prom();
+}
+
+static void tcube_machine_halt(void)
+{
+	printk(KERN_CRIT "VR5701-SG2 halted.\n");
+	while (1) ;
+}
+
+static void tcube_machine_power_off(void)
+{
+	printk(KERN_CRIT "VR5701-SG2 halted. Please turn off the power.\n");
+	while (1) ;
+}
+
+static void __init tcube_time_init(void)
+{
+	mips_hpt_frequency = CPU_COUNTER_FREQUENCY;
+}
+
+static void __init tcube_timer_setup(struct irqaction *irq)
+{
+	unsigned int count;
+	irq->flags |= SA_NODELAY;
+
+	/* we are using the cpu counter for timer interrupts */
+	setup_irq(7, irq);
+
+	/* to generate the first timer interrupt */
+	count = read_c0_count();
+	write_c0_compare(count + 10000);
+}
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+extern unsigned long __rd_start, __rd_end, initrd_start, initrd_end;
+#endif
+
+static void chk_init_5701_reg(unsigned long addr, unsigned long data)
+{
+	unsigned long a = ddb_in32(addr);
+
+	if (a != data) {
+		printk(KERN_INFO
+		       "Unexpected 5701 reg : addr = %08lX, expected = %08lX, read = %08lX\n",
+		       addr + VR5701_IO_BASE, data, a);
+	}
+}
+
+static void __init tcube_board_init(void)
+{
+	chk_init_5701_reg(0, 0x1e00008f);
+	chk_init_5701_reg(PADR_SDRAM01, 0x000000a8);
+	chk_init_5701_reg(PADR_LOCALCS0, 0x1f00004c);
+	chk_init_5701_reg(LOCAL_CST0, 0x00088622);
+	chk_init_5701_reg(LOCAL_CFG, 0x000f0000);
+
+	/* setup PCI windows - window0 for MEM/config, window1 for IO */
+	ddb_set_pdar(PADR_PCIW0, 0x10000000, 0x08000000, 32, 0, 1);
+	ddb_set_pdar(PADR_PCIW1, 0x18000000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PADR_IOPCIW0, 0x18800000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PADR_IOPCIW1, 0x19000000, 0x00800000, 32, 0, 1);
+	/* ------------ reset PCI bus and BARs ----------------- */
+	ddb_pci_reset_bus();
+	/* Ext. PCI memory space */
+	ddb_out32(PCI_BAR_MEM01, 0x00000008);
+	ddb_out8(PCI_MLTIM, 0x40);
+
+	ddb_out32(PCI_BAR_LCS0, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS1, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS2, 0xffffffff);
+	ddb_out32(PCI_BAR_LCS3, 0xffffffff);
+	/* Int. PCI memory space */
+	ddb_out8(IPCI_MLTIM, 0x40);
+
+	ddb_out32(IPCI_BAR_LCS0, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS1, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS2, 0xffffffff);
+	ddb_out32(IPCI_BAR_LCS3, 0xffffffff);
+	ddb_out32(IPCI_BAR_IREG, 0xffffffff);
+
+	/*
+	 * We use pci master register 0  for memory space / config space
+	 * And we use register 1 for IO space.
+	 * Note that for memory space, we bump up the pci base address
+	 * so that we have 1:1 mapping between PCI memory and cpu physical.
+	 * For PCI IO space, it starts from 0 in PCI IO space but with
+	 * IO_BASE in CPU physical address space.
+	 */
+	ddb_set_pmr(EPCI_INIT0, DDB_PCICMD_MEM, 0x10000000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(EPCI_INIT1, DDB_PCICMD_IO, 0x00001000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(IPCI_INIT0, DDB_PCICMD_MEM, 0x18800000, DDB_PCI_ACCESS_32);
+	ddb_set_pmr(IPCI_INIT1, DDB_PCICMD_IO, 0x01000000, DDB_PCI_ACCESS_32);
+
+	/* PCI cross window should be set properly */
+	ddb_set_pdar(PCI_BAR_IPCIW0, 0x18800000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(PCI_BAR_IPCIW1, 0x19000000, 0x00800000, 32, 0, 1);
+	ddb_set_pdar(IPCI_BAR_EPCIW0, 0x10000000, 0x08000000, 32, 0, 1);
+	ddb_set_pdar(IPCI_BAR_EPCIW1, 0x18000000, 0x00800000, 32, 0, 1);
+
+	/* setup GPIO */
+	ddb_out32(GIU_DIR0, 0xf7ebffdf);
+	ddb_out32(GIU_DIR1, 0x000007fa);
+	ddb_out32(GIU_FUNCSEL0, 0xf1c1ffff);
+	ddb_out32(GIU_FUNCSEL1, 0x000007f0);
+	chk_init_5701_reg(GIU_DIR0, 0xf7ebffdf);
+	chk_init_5701_reg(GIU_DIR1, 0x000007fa);
+	chk_init_5701_reg(GIU_FUNCSEL0, 0xf1c1ffff);
+	chk_init_5701_reg(GIU_FUNCSEL1, 0x000007f0);
+
+	/* enable USB input buffers */
+	ddb_out32(PIB_MISC, (ddb_in32(PIB_MISC) | 0x00000031));
+}
+
+static int __init shima_tcube_setup(void)
+{
+	set_io_port_base(0xB8000000);
+
+	board_time_init = tcube_time_init;
+	board_timer_setup = tcube_timer_setup;
+
+	_machine_restart = tcube_machine_restart;
+	_machine_halt = tcube_machine_halt;
+	_machine_power_off = tcube_machine_power_off;
+
+	/* setup resource limits */
+	ioport_resource.end = 0x02000000;
+	iomem_resource.end = 0xffffffff;
+
+	/* Reboot on panic */
+	panic_timeout = 30;
+
+#ifdef CONFIG_FB
+	conswitchp = &dummy_con;
+#endif
+
+	tcube_board_init();
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	initrd_start = (unsigned long)&__rd_start;
+	initrd_end = (unsigned long)&__rd_end;
+#endif
+	register_pci_controller(&VR5701_ext_controller);
+	register_pci_controller(&VR5701_io_controller);
+	return 0;
+}
+
+void __init bus_error_init(void)
+{
+	/* do nothing */
+}
+
+early_initcall(shima_tcube_setup);
diff -Naurp --exclude=CVS linux_save/include/asm-mips/bootinfo.h linux_mips/include/asm-mips/bootinfo.h
--- linux_save/include/asm-mips/bootinfo.h	2005-03-01 09:33:17.000000000 +0300
+++ linux_mips/include/asm-mips/bootinfo.h	2005-05-31 19:03:48.000000000 +0400
@@ -215,6 +215,12 @@
 #define MACH_GROUP_TITAN       22	/* PMC-Sierra Titan		*/
 #define  MACH_TITAN_YOSEMITE	1	/* PMC-Sierra Yosemite		*/
 
+/*
+ * Valid machtype for group SHIMA
+ */
+#define MACH_GROUP_SHIMA       24 /* SHIMAFUJI                              */
+#define MACH_SHIMA_TCUBE         0      /* SHIMAFUJI T-Cube(Vr5701) */
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
diff -Naurp --exclude=CVS linux_save/include/asm-mips/serial.h linux_mips/include/asm-mips/serial.h
--- linux_save/include/asm-mips/serial.h	2005-03-04 20:24:33.000000000 +0300
+++ linux_mips/include/asm-mips/serial.h	2005-05-31 19:10:01.000000000 +0400
@@ -391,6 +391,21 @@
 #define DDB5477_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_TCUBE
+#include <asm/tcube.h>
+#define TCUBE_SERIAL_PORT_DEFNS                                   \
+	{ baud_base: BASE_BAUD, irq: 16, flags: STD_COM_FLAGS,          \
+	  iomem_base: (u8*)0xbe000a00, iomem_reg_shift: 3,              \
+	  io_type: SERIAL_IO_MEM},\
+	{ baud_base: BASE_BAUD, irq: 17, flags: STD_COM_FLAGS,          \
+	  iomem_base: (u8*)0xbe000a40, iomem_reg_shift: 3,              \
+	  io_type: SERIAL_IO_MEM},
+#else
+#define TCUBE_SERIAL_PORT_DEFNS
+#endif
+
+
+
 #ifdef CONFIG_SGI_IP32
 /*
  * The IP32 (SGI O2) has standard serial ports (UART 16550A) mapped in memory
@@ -416,6 +431,7 @@
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
-	AU1000_SERIAL_PORT_DEFNS
+	AU1000_SERIAL_PORT_DEFNS			\
+	TCUBE_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
diff -Naurp --exclude=CVS linux_save/include/asm-mips/tcube.h linux_mips/include/asm-mips/tcube.h
--- linux_save/include/asm-mips/tcube.h	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/include/asm-mips/tcube.h	2005-05-31 19:03:48.000000000 +0400
@@ -0,0 +1,201 @@
+/*
+ * include/asm-mips/tcube.h
+ *
+ * Flash memory access on NEC VR5701-SG2 board.
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __TCUBE_H
+#define __TCUBE_H
+
+#include <asm/vr5701.h>
+
+#define TCUBE_SDRAM_SIZE 	0x10000000
+
+#ifndef __ASSEMBLY__
+#include <asm/delay.h>
+
+/*
+ *  PCI Master Registers
+ */
+
+#define DDB_PCICMD_IACK		0	/* PCI Interrupt Acknowledge */
+#define DDB_PCICMD_IO		1	/* PCI I/O Space */
+#define DDB_PCICMD_MEM		3	/* PCI Memory Space */
+#define DDB_PCICMD_CFG		5	/* PCI Configuration Space */
+
+/*
+ * additional options for pci init reg (no shifting needed)
+ */
+#define DDB_PCI_CFGTYPE1     	0x200	/* for pci init0/1 regs */
+#define DDB_PCI_ACCESS_32    	0x10	/* for pci init0/1 regs */
+#define NUM_5701_IRQS 	  	32
+#define NUM_5701_EPCI_IRQ 	4
+
+/* A Real Time Clock interface for Linux on NEC VR5701-SG2 */
+#define SET_32_BIT		0xffffffff
+#define CLR_32_BIT		0x00000000
+
+#define GPIO_3_INTR		(0x1 <<  3)
+#define GPIO_4_CE		(0x1 <<  4)
+#define GPIO_25_S1CLK		(0x1 << 25)
+#define GPIO_26_S1DO		(0x1 << 26)
+#define GPIO_27_S1DI		(0x1 << 27)
+#define GPIO_CSI1_PIN	(GPIO_25_S1CLK | GPIO_26_S1DO | GPIO_27_S1DI)
+
+#define CSIn_MODE_CKP		(0x1 << 12)
+#define CSIn_MODE_DAP		(0x1 << 11)
+#define CSIn_MODE_CKS_MASK	(0x7 <<  8)
+#define CSIn_MODE_CKS_833333MHZ	(0x1 <<  8)
+#define CSIn_MODE_CKS_416667MHZ	(0x2 <<  8)
+#define CSIn_MODE_CKS_208333MHZ	(0x3 <<  8)
+#define CSIn_MODE_CKS_104167MHZ	(0x4 <<  8)
+#define CSIn_MODE_CKS_052083MHZ	(0x5 <<  8)
+#define CSIn_MODE_CKS_0260417HZ	(0x6 <<  8)	/* Default */
+#define CSIn_MODE_CSIE		(0x1 <<  7)
+#define CSIn_MODE_TRMD		(0x1 <<  6)
+#define CSIn_MODE_CCL_16	(0x1 <<  5)
+#define CSIn_MODE_DIR_LSB	(0x1 <<  4)
+#define CSIn_MODE_AUTO		(0x1 <<  2)
+#define CSIn_MODE_CSOT		(0x1 <<  0)
+
+#define CSIn_INT_CSIEND		(0x1 << 15)
+#define CSIn_INT_T_EMP		(0x1 <<  8)
+#define CSIn_INT_R_OVER		(0x1 <<  0)
+
+/* IRQs */
+#define ACTIVE_LOW		1
+#define ACTIVE_HIGH		0
+
+#define LEVEL_SENSE		2
+#define EDGE_TRIGGER		0
+
+#define NUM_5701_IRQS 		32
+#define NUM_5701_EPCI_IRQS 	4
+#define NUM_5701_IPCI_IRQS 	8
+#define NUM_5701_IRQ  		32
+#define NUM_EPCI_IRQ  		4
+#define NUM_IPCI_IRQ  		8
+
+#define INTA			0
+#define INTB			1
+#define INTC			2
+#define INTD			3
+#define INTE			4
+
+/* Timers */
+#define	CPU_COUNTER_FREQUENCY		133333333
+
+#define ddb_sync       		io_sync
+#define ddb_out32(x,y) 		io_out32(x,y)
+#define ddb_out16(x,y) 		io_out16(x,y)
+#define ddb_out8(x,y)  		io_out8(x,y)
+#define ddb_in32(x)    		io_in32(x)
+#define ddb_in16(x)    		io_in16(x)
+#define ddb_in8(x)     		io_in8(x)
+
+static inline void io_sync(void)
+{
+	asm("sync");
+}
+
+static inline void io_out32(u32 offset, u32 val)
+{
+	*(volatile u32 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u32 io_in32(u32 offset)
+{
+	u32 val = *(volatile u32 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_out16(u32 offset, u16 val)
+{
+	*(volatile u16 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u16 io_in16(u32 offset)
+{
+	u16 val = *(volatile u16 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_reset16(unsigned long adr,
+			      unsigned short val1,
+			      unsigned delay, unsigned short val2)
+{
+	io_out16(adr, val1);
+	__delay(delay);
+	io_out16(adr, val2);
+}
+
+static inline void io_out8(u32 offset, u8 val)
+{
+	*(volatile u8 *)(VR5701_IO_BASE + offset) = val;
+	io_sync();
+}
+
+static inline u8 io_in8(u32 offset)
+{
+	u8 val = *(volatile u8 *)(VR5701_IO_BASE + offset);
+	io_sync();
+	return val;
+}
+
+static inline void io_set16(u32 offset, u16 mask, u16 val)
+{
+	u16 val0 = io_in16(offset);
+	io_out16(offset, (val & mask) | (val0 & ~mask));
+}
+
+static inline void reg_set32(u32 offset, u32 mask, u32 val)
+{
+	u32 val0 = io_in32(offset);
+	io_out32(offset, (val & mask) | (val0 & ~mask));
+}
+
+static inline void csi1_reset(void)
+{
+	/* CSI1 reset */
+	reg_set32(CSI1_CNT, 0x00008000, SET_32_BIT);	/* set CSIRST bit */
+	__delay(100000);
+	reg_set32(CSI1_CNT, 0x00008000, CLR_32_BIT);	/* clear CSIRST bit */
+	/* set clock phase  */
+	while (io_in32(CSI1_MODE) & 1) ;
+	reg_set32(CSI1_MODE, CSIn_MODE_CSIE, CLR_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CKP, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CKS_104167MHZ, SET_32_BIT);
+	reg_set32(CSI1_MODE, CSIn_MODE_CSIE, SET_32_BIT);
+	while (io_in32(CSI1_MODE) & CSIn_MODE_CSOT) ;
+}
+
+extern void ll_vr5701_irq_route(int vr5701_irq, int ip);
+extern void ll_vr5701_irq_enable(int vr5701_irq);
+extern void ddb_set_pdar(u32, u32, u32, int, int, int);
+extern void ddb_set_pmr(u32 pmr, u32 type, u32 addr, u32 options);
+extern void ddb_set_bar(u32 bar, u32 phys, int prefetchable);
+extern void ddb_pci_reset_bus(void);
+extern struct pci_ops VR5701_ext_pci_ops;
+extern struct pci_ops VR5701_io_pci_ops;
+extern struct pci_controller VR5701_ext_controller;
+extern struct pci_controller VR5701_io_controller;
+extern int shima_tcube_setup(void);
+extern void tcube_irq_init(u32 base);
+extern void mips_cpu_irq_init(u32 base);
+extern asmlinkage void tcube_handle_int(void);
+extern void vr5701_irq_init(u32 irq_base);
+extern int setup_irq(unsigned int irq, struct irqaction *irqaction);
+extern int panic_timeout;
+
+#endif
+#endif
diff -Naurp --exclude=CVS linux_save/include/asm-mips/vr5701.h linux_mips/include/asm-mips/vr5701.h
--- linux_save/include/asm-mips/vr5701.h	1970-01-01 03:00:00.000000000 +0300
+++ linux_mips/include/asm-mips/vr5701.h	2005-05-31 19:03:48.000000000 +0400
@@ -0,0 +1,96 @@
+/*
+ * include/asm-mips/vr5701.h
+ *
+ * A header for NEC VR5701 CPU
+ *
+ * Author: Sergey Podstavin <spodstavin@ru.mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __VR5701_H
+#define __VR5701_H
+
+#define VR5701_IO_BASE	0xbe000000
+
+/* PADR registers */
+#define PADR_SDRAM01	0x40
+#define PADR_LOCALCS0	0x80
+#define PADR_PCIW0	0xC0
+#define PADR_PCIW1	0xC8
+#define PADR_EPCIW0	0xC0
+#define PADR_IOPCIW0	0xE0
+#define PADR_IOPCIW1	0xE8
+/* INT registers */
+#define INT0_STAT	0x100
+#define INT1_STAT	0x108
+#define INT2_STAT	0x110
+#define INT3_STAT	0x118
+#define INT4_STAT	0x120
+#define NMI_STAT	0x130
+#define INT_CLR		0x140
+#define INT_MASK	0x150
+#define INT_ROUTE0	0x160
+#define INT_ROUTE1	0x168
+#define INT_ROUTE2	0x170
+#define INT_ROUTE3	0x178
+/* LOCAL registers */
+#define LOCAL_CST0	0x400
+#define LOCAL_CFG	0x440
+/* EPCI registers */
+#define EPCI_CTRLH	0x604
+#define EPCI_INIT0	0x610
+#define EPCI_INIT1	0x618
+#define EPCI_ERR	0x628
+#define EPCI_INTS	0x630
+#define EPCI_INTM	0x638
+/* PCI registers */
+#define PCI_MLTIM	0x70D
+#define PCI_BAR_MEM01	0x710
+#define PCI_BAR_LCS0	0x740
+#define PCI_BAR_LCS1	0x748
+#define PCI_BAR_LCS2	0x750
+#define PCI_BAR_LCS3	0x758
+#define PCI_BAR_IPCIW0	0x7A0
+#define PCI_BAR_IPCIW1	0x7A8
+#define PCI_BAR_IREG	0x7C0
+
+/* PIB registers*/
+#define PIB_RESET	0x800
+#define PIB_MISC	0x830
+
+/* GPIO registers*/
+#define GIU_PIO0	0x940
+#define GIU_DIR0	0x950
+#define GIU_DIR1	0x958
+#define GIU_FUNCSEL0	0x960
+#define GIU_FUNCSEL1	0x968
+
+/* CSI1 registers*/
+#define CSI1_MODE	0xB80
+#define CSI1_SIRB	0xB88
+#define CSI1_SOTB	0xB90
+#define CSI1_SOTBF	0xBA0
+#define CSI1_CNT	0xBC0
+#define CSI1_INT	0xBC8
+
+/* IPCI registers*/
+#define IPCI_CTRLH	0xE04
+#define IPCI_INIT0	0xE10
+#define IPCI_INIT1	0xE18
+#define IPCI_ERR	0xE28
+#define IPCI_INTS	0xE30
+#define IPCI_INTM	0xE38
+/* PCI registers */
+#define IPCI_MLTIM	0xF0D
+#define IPCI_BAR_LCS0	0xF40
+#define IPCI_BAR_LCS1	0xF48
+#define IPCI_BAR_LCS2	0xF50
+#define IPCI_BAR_LCS3	0xF58
+#define IPCI_BAR_EPCIW0	0xF80
+#define IPCI_BAR_EPCIW1	0xF88
+#define IPCI_BAR_IREG	0xFC0
+
+#endif				/*  __VR5701_H */

--=-mspiNCIP3YakTU/JruAA--
