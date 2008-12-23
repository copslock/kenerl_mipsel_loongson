Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2008 23:24:52 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45643 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24208028AbYLWXYo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Dec 2008 23:24:44 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B495173300000>; Tue, 23 Dec 2008 18:24:32 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Dec 2008 15:23:47 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Dec 2008 15:23:47 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBNNNiCW020751;
	Tue, 23 Dec 2008 15:23:44 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBNNNcqJ020749;
	Tue, 23 Dec 2008 15:23:38 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 03/20] MIPS: Add Cavium OCTEON processor support files to arch/mips/cavium-octeon.
Date:	Tue, 23 Dec 2008 15:23:38 -0800
Message-Id: <1230074618-20726-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
In-Reply-To: <1229038418-31833-3-git-send-email-ddaney@caviumnetworks.com>
References: <1229038418-31833-3-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Dec 2008 23:23:47.0099 (UTC) FILETIME=[8132DEB0:01C96555]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These are the rest of the new files needed to add OCTEON processor
support to the Linux kernel.  Other than Makefile and Kconfig which
should be obvious, we have:

csrc-octeon.c   -- Clock source driver for OCTEON.
dma-octeon.c    -- Helper functions for mapping DMA memory.
flash_setup.c   -- Register on-board flash with the MTD subsystem.
octeon-irq.c    -- OCTEON interrupt controller managment.
octeon-memcpy.S -- Optimized memcpy() implementation.
serial.c        -- Register 8250 platform driver and early console.
setup.c         -- Early architecture initialization.
smp.c           -- OCTEON SMP support.
octeon_switch.S -- Scheduler context switch for OCTEON.
c-octeon.c      -- OCTEON cache controller support.
cex-oct.S       -- OCTEON cache exception handler.

asm/mach-cavium-octeon/*.h -- Architecture include files.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This is an update of the previous 03/20.  Changes are:

* Improve octeon_init_cvmcount in csrc-octeon.c

* Remove some unused PCI code in setup.c

* Set more cpu_has_* values in cpu-feature-overrides.h

* Fix comment in irq.h

 arch/mips/cavium-octeon/Kconfig                    |   85 ++
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/csrc-octeon.c              |   58 ++
 arch/mips/cavium-octeon/dma-octeon.c               |   32 +
 arch/mips/cavium-octeon/flash_setup.c              |   84 ++
 arch/mips/cavium-octeon/octeon-irq.c               |  496 +++++++++++
 arch/mips/cavium-octeon/octeon-memcpy.S            |  521 +++++++++++
 arch/mips/cavium-octeon/serial.c                   |  136 +++
 arch/mips/cavium-octeon/setup.c                    |  929 ++++++++++++++++++++
 arch/mips/cavium-octeon/smp.c                      |  211 +++++
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   78 ++
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   64 ++
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  244 +++++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  131 +++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   26 +
 arch/mips/include/asm/octeon/octeon.h              |  248 ++++++
 arch/mips/kernel/octeon_switch.S                   |  506 +++++++++++
 arch/mips/mm/c-octeon.c                            |  307 +++++++
 arch/mips/mm/cex-oct.S                             |   70 ++
 19 files changed, 4242 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/Kconfig
 create mode 100644 arch/mips/cavium-octeon/Makefile
 create mode 100644 arch/mips/cavium-octeon/csrc-octeon.c
 create mode 100644 arch/mips/cavium-octeon/dma-octeon.c
 create mode 100644 arch/mips/cavium-octeon/flash_setup.c
 create mode 100644 arch/mips/cavium-octeon/octeon-irq.c
 create mode 100644 arch/mips/cavium-octeon/octeon-memcpy.S
 create mode 100644 arch/mips/cavium-octeon/serial.c
 create mode 100644 arch/mips/cavium-octeon/setup.c
 create mode 100644 arch/mips/cavium-octeon/smp.c
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/irq.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 create mode 100644 arch/mips/include/asm/octeon/octeon.h
 create mode 100644 arch/mips/kernel/octeon_switch.S
 create mode 100644 arch/mips/mm/c-octeon.c
 create mode 100644 arch/mips/mm/cex-oct.S

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
new file mode 100644
index 0000000..094c17e
--- /dev/null
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -0,0 +1,85 @@
+config CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	bool "Enable Octeon specific options"
+	depends on CPU_CAVIUM_OCTEON
+	default "y"
+
+config CAVIUM_OCTEON_2ND_KERNEL
+	bool "Build the kernel to be used as a 2nd kernel on the same chip"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "n"
+	help
+	  This option configures this kernel to be linked at a different
+	  address and use the 2nd uart for output. This allows a kernel built
+	  with this option to be run at the same time as one built without this
+	  option.
+
+config CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	bool "Enable hardware fixups of unaligned loads and stores"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "y"
+	help
+	  Configure the Octeon hardware to automatically fix unaligned loads
+	  and stores. Normally unaligned accesses are fixed using a kernel
+	  exception handler. This option enables the hardware automatic fixups,
+	  which requires only an extra 3 cycles. Disable this option if you
+	  are running code that relies on address exceptions on unaligned
+	  accesses.
+
+config CAVIUM_OCTEON_CVMSEG_SIZE
+	int "Number of L1 cache lines reserved for CVMSEG memory"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	range 0 54
+	default 1
+	help
+	  CVMSEG LM is a segment that accesses portions of the dcache as a
+	  local memory; the larger CVMSEG is, the smaller the cache is.
+	  This selects the size of CVMSEG LM, which is in cache blocks. The
+	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
+	  between zero and 6192 bytes).
+
+config CAVIUM_OCTEON_LOCK_L2
+	bool "Lock often used kernel code in the L2"
+	depends on CAVIUM_OCTEON_SPECIFIC_OPTIONS
+	default "y"
+	help
+	  Enable locking parts of the kernel into the L2 cache.
+
+config CAVIUM_OCTEON_LOCK_L2_TLB
+	bool "Lock the TLB handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level TLB fast path into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_EXCEPTION
+	bool "Lock the exception handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level exception handler into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_LOW_LEVEL_INTERRUPT
+	bool "Lock the interrupt handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the low level interrupt handler into L2.
+
+config CAVIUM_OCTEON_LOCK_L2_INTERRUPT
+	bool "Lock the 2nd level interrupt handler in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the 2nd level interrupt handler in L2.
+
+config CAVIUM_OCTEON_LOCK_L2_MEMCPY
+	bool "Lock memcpy() in L2"
+	depends on CAVIUM_OCTEON_LOCK_L2
+	default "y"
+	help
+	  Lock the kernel's implementation of memcpy() into L2.
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_STATIC
+	depends on CPU_CAVIUM_OCTEON
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
new file mode 100644
index 0000000..1c2a7fa
--- /dev/null
+++ b/arch/mips/cavium-octeon/Makefile
@@ -0,0 +1,16 @@
+#
+# Makefile for the Cavium Octeon specific kernel interface routines
+# under Linux.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2005-2008 Cavium Networks
+#
+
+obj-y := setup.o serial.o octeon-irq.o csrc-octeon.o
+obj-y += dma-octeon.o flash_setup.o
+obj-y += octeon-memcpy.o
+
+obj-$(CONFIG_SMP)                     += smp.o
diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
new file mode 100644
index 0000000..70fd92c
--- /dev/null
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -0,0 +1,58 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 by Ralf Baechle
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-ipd-defs.h>
+
+/*
+ * Set the current core's cvmcount counter to the value of the
+ * IPD_CLK_COUNT.  We do this on all cores as they are brought
+ * on-line.  This allows for a read from a local cpu register to
+ * access a synchronized counter.
+ *
+ */
+void octeon_init_cvmcount(void)
+{
+	unsigned long flags;
+	unsigned loops = 2;
+
+	/* Clobber loops so GCC will not unroll the following while loop. */
+	asm("" : "+r" (loops));
+
+	local_irq_save(flags);
+	/*
+	 * Loop several times so we are executing from the cache,
+	 * which should give more deterministic timing.
+	 */
+	while (loops--)
+		write_c0_cvmcount(cvmx_read_csr(CVMX_IPD_CLK_COUNT));
+	local_irq_restore(flags);
+}
+
+static cycle_t octeon_cvmcount_read(void)
+{
+	return read_c0_cvmcount();
+}
+
+static struct clocksource clocksource_mips = {
+	.name		= "OCTEON_CVMCOUNT",
+	.read		= octeon_cvmcount_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init plat_time_init(void)
+{
+	clocksource_mips.rating = 300;
+	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
+	clocksource_register(&clocksource_mips);
+}
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
new file mode 100644
index 0000000..01b1ef9
--- /dev/null
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -0,0 +1,32 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000  Ani Joshi <ajoshi@unixbox.com>
+ * Copyright (C) 2000, 2001  Ralf Baechle <ralf@gnu.org>
+ * Copyright (C) 2005 Ilya A. Volynets-Evenbakh <ilya@total-knowledge.com>
+ * swiped from i386, and cloned for MIPS by Geert, polished by Ralf.
+ * IP32 changes by Ilya.
+ * Cavium Networks: Create new dma setup for Cavium Networks Octeon based on
+ * the kernels original.
+ */
+#include <linux/types.h>
+#include <linux/mm.h>
+
+#include <dma-coherence.h>
+
+dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
+{
+	/* Without PCI/PCIe this function can be called for Octeon internal
+	   devices such as USB. These devices all support 64bit addressing */
+	mb();
+	return virt_to_phys(ptr);
+}
+
+void octeon_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+{
+	/* Without PCI/PCIe this function can be called for Octeon internal
+	 * devices such as USB. These devices all support 64bit addressing */
+	return;
+}
diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
new file mode 100644
index 0000000..553d36c
--- /dev/null
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -0,0 +1,84 @@
+/*
+ *   Octeon Bootbus flash setup
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007, 2008 Cavium Networks
+ */
+#include <linux/kernel.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/octeon/octeon.h>
+
+static struct map_info flash_map;
+static struct mtd_info *mymtd;
+#ifdef CONFIG_MTD_PARTITIONS
+static int nr_parts;
+static struct mtd_partition *parts;
+static const char *part_probe_types[] = {
+	"cmdlinepart",
+#ifdef CONFIG_MTD_REDBOOT_PARTS
+	"RedBoot",
+#endif
+	NULL
+};
+#endif
+
+/**
+ * Module/ driver initialization.
+ *
+ * Returns Zero on success
+ */
+static int __init flash_init(void)
+{
+	/*
+	 * Read the bootbus region 0 setup to determine the base
+	 * address of the flash.
+	 */
+	union cvmx_mio_boot_reg_cfgx region_cfg;
+	region_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(0));
+	if (region_cfg.s.en) {
+		/*
+		 * The bootloader always takes the flash and sets its
+		 * address so the entire flash fits below
+		 * 0x1fc00000. This way the flash aliases to
+		 * 0x1fc00000 for booting. Software can access the
+		 * full flash at the true address, while core boot can
+		 * access 4MB.
+		 */
+		/* Use this name so old part lines work */
+		flash_map.name = "phys_mapped_flash";
+		flash_map.phys = region_cfg.s.base << 16;
+		flash_map.size = 0x1fc00000 - flash_map.phys;
+		flash_map.bankwidth = 1;
+		flash_map.virt = ioremap(flash_map.phys, flash_map.size);
+		pr_notice("Bootbus flash: Setting flash for %luMB flash at "
+			  "0x%08lx\n", flash_map.size >> 20, flash_map.phys);
+		simple_map_init(&flash_map);
+		mymtd = do_map_probe("cfi_probe", &flash_map);
+		if (mymtd) {
+			mymtd->owner = THIS_MODULE;
+
+#ifdef CONFIG_MTD_PARTITIONS
+			nr_parts = parse_mtd_partitions(mymtd,
+							part_probe_types,
+							&parts, 0);
+			if (nr_parts > 0)
+				add_mtd_partitions(mymtd, parts, nr_parts);
+			else
+				add_mtd_device(mymtd);
+#else
+			add_mtd_device(mymtd);
+#endif
+		} else {
+			pr_err("Failed to register MTD device for flash\n");
+		}
+	}
+	return 0;
+}
+
+late_initcall(flash_init);
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
new file mode 100644
index 0000000..788d588
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -0,0 +1,496 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/hardirq.h>
+
+#include <asm/octeon/octeon.h>
+
+DEFINE_RWLOCK(octeon_irq_ciu0_rwlock);
+DEFINE_RWLOCK(octeon_irq_ciu1_rwlock);
+DEFINE_SPINLOCK(octeon_irq_msi_lock);
+
+static void octeon_irq_core_ack(unsigned int irq)
+{
+	unsigned int bit = irq - OCTEON_IRQ_SW0;
+	/*
+	 * We don't need to disable IRQs to make these atomic since
+	 * they are already disabled earlier in the low level
+	 * interrupt code.
+	 */
+	clear_c0_status(0x100 << bit);
+	/* The two user interrupts must be cleared manually. */
+	if (bit < 2)
+		clear_c0_cause(0x100 << bit);
+}
+
+static void octeon_irq_core_eoi(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc + irq;
+	unsigned int bit = irq - OCTEON_IRQ_SW0;
+	/*
+	 * If an IRQ is being processed while we are disabling it the
+	 * handler will attempt to unmask the interrupt after it has
+	 * been disabled.
+	 */
+	if (desc->status & IRQ_DISABLED)
+		return;
+
+	/* There is a race here.  We should fix it.  */
+
+	/*
+	 * We don't need to disable IRQs to make these atomic since
+	 * they are already disabled earlier in the low level
+	 * interrupt code.
+	 */
+	set_c0_status(0x100 << bit);
+}
+
+static void octeon_irq_core_enable(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int bit = irq - OCTEON_IRQ_SW0;
+
+	/*
+	 * We need to disable interrupts to make sure our updates are
+	 * atomic.
+	 */
+	local_irq_save(flags);
+	set_c0_status(0x100 << bit);
+	local_irq_restore(flags);
+}
+
+static void octeon_irq_core_disable_local(unsigned int irq)
+{
+	unsigned long flags;
+	unsigned int bit = irq - OCTEON_IRQ_SW0;
+	/*
+	 * We need to disable interrupts to make sure our updates are
+	 * atomic.
+	 */
+	local_irq_save(flags);
+	clear_c0_status(0x100 << bit);
+	local_irq_restore(flags);
+}
+
+static void octeon_irq_core_disable(unsigned int irq)
+{
+#ifdef CONFIG_SMP
+	on_each_cpu((void (*)(void *)) octeon_irq_core_disable_local,
+		    (void *) (long) irq, 1);
+#else
+	octeon_irq_core_disable_local(irq);
+#endif
+}
+
+static struct irq_chip octeon_irq_chip_core = {
+	.name = "Core",
+	.enable = octeon_irq_core_enable,
+	.disable = octeon_irq_core_disable,
+	.ack = octeon_irq_core_ack,
+	.eoi = octeon_irq_core_eoi,
+};
+
+
+static void octeon_irq_ciu0_ack(unsigned int irq)
+{
+	/*
+	 * In order to avoid any locking accessing the CIU, we
+	 * acknowledge CIU interrupts by disabling all of them.  This
+	 * way we can use a per core register and avoid any out of
+	 * core locking requirements.  This has the side affect that
+	 * CIU interrupts can't be processed recursively.
+	 *
+	 * We don't need to disable IRQs to make these atomic since
+	 * they are already disabled earlier in the low level
+	 * interrupt code.
+	 */
+	clear_c0_status(0x100 << 2);
+}
+
+static void octeon_irq_ciu0_eoi(unsigned int irq)
+{
+	/*
+	 * Enable all CIU interrupts again.  We don't need to disable
+	 * IRQs to make these atomic since they are already disabled
+	 * earlier in the low level interrupt code.
+	 */
+	set_c0_status(0x100 << 2);
+}
+
+static void octeon_irq_ciu0_enable(unsigned int irq)
+{
+	int coreid = cvmx_get_core_num();
+	unsigned long flags;
+	uint64_t en0;
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+
+	/*
+	 * A read lock is used here to make sure only one core is ever
+	 * updating the CIU enable bits at a time. During an enable
+	 * the cores don't interfere with each other. During a disable
+	 * the write lock stops any enables that might cause a
+	 * problem.
+	 */
+	read_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	en0 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	read_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+}
+
+static void octeon_irq_ciu0_disable(unsigned int irq)
+{
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+	unsigned long flags;
+	uint64_t en0;
+#ifdef CONFIG_SMP
+	int cpu;
+	write_lock_irqsave(&octeon_irq_ciu0_rwlock, flags);
+	for_each_online_cpu(cpu) {
+		int coreid = cpu_logical_map(cpu);
+		en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+		en0 &= ~(1ull << bit);
+		cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	}
+	/*
+	 * We need to do a read after the last update to make sure all
+	 * of them are done.
+	 */
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
+	write_unlock_irqrestore(&octeon_irq_ciu0_rwlock, flags);
+#else
+	int coreid = cvmx_get_core_num();
+	local_irq_save(flags);
+	en0 = cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	en0 &= ~(1ull << bit);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+	local_irq_restore(flags);
+#endif
+}
+
+#ifdef CONFIG_SMP
+static void octeon_irq_ciu0_set_affinity(unsigned int irq, cpumask_t dest)
+{
+	int cpu;
+	int bit = irq - OCTEON_IRQ_WORKQ0;	/* Bit 0-63 of EN0 */
+
+	write_lock(&octeon_irq_ciu0_rwlock);
+	for_each_online_cpu(cpu) {
+		int coreid = cpu_logical_map(cpu);
+		uint64_t en0 =
+			cvmx_read_csr(CVMX_CIU_INTX_EN0(coreid * 2));
+		if (cpu_isset(cpu, dest))
+			en0 |= 1ull << bit;
+		else
+			en0 &= ~(1ull << bit);
+		cvmx_write_csr(CVMX_CIU_INTX_EN0(coreid * 2), en0);
+	}
+	/*
+	 * We need to do a read after the last update to make sure all
+	 * of them are done.
+	 */
+	cvmx_read_csr(CVMX_CIU_INTX_EN0(cvmx_get_core_num() * 2));
+	write_unlock(&octeon_irq_ciu0_rwlock);
+}
+#endif
+
+static struct irq_chip octeon_irq_chip_ciu0 = {
+	.name = "CIU0",
+	.enable = octeon_irq_ciu0_enable,
+	.disable = octeon_irq_ciu0_disable,
+	.ack = octeon_irq_ciu0_ack,
+	.eoi = octeon_irq_ciu0_eoi,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu0_set_affinity,
+#endif
+};
+
+
+static void octeon_irq_ciu1_ack(unsigned int irq)
+{
+	/*
+	 * In order to avoid any locking accessing the CIU, we
+	 * acknowledge CIU interrupts by disabling all of them.  This
+	 * way we can use a per core register and avoid any out of
+	 * core locking requirements.  This has the side affect that
+	 * CIU interrupts can't be processed recursively.  We don't
+	 * need to disable IRQs to make these atomic since they are
+	 * already disabled earlier in the low level interrupt code.
+	 */
+	clear_c0_status(0x100 << 3);
+}
+
+static void octeon_irq_ciu1_eoi(unsigned int irq)
+{
+	/*
+	 * Enable all CIU interrupts again.  We don't need to disable
+	 * IRQs to make these atomic since they are already disabled
+	 * earlier in the low level interrupt code.
+	 */
+	set_c0_status(0x100 << 3);
+}
+
+static void octeon_irq_ciu1_enable(unsigned int irq)
+{
+	int coreid = cvmx_get_core_num();
+	unsigned long flags;
+	uint64_t en1;
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+
+	/*
+	 * A read lock is used here to make sure only one core is ever
+	 * updating the CIU enable bits at a time.  During an enable
+	 * the cores don't interfere with each other.  During a disable
+	 * the write lock stops any enables that might cause a
+	 * problem.
+	 */
+	read_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	en1 |= 1ull << bit;
+	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	read_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+}
+
+static void octeon_irq_ciu1_disable(unsigned int irq)
+{
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+	unsigned long flags;
+	uint64_t en1;
+#ifdef CONFIG_SMP
+	int cpu;
+	write_lock_irqsave(&octeon_irq_ciu1_rwlock, flags);
+	for_each_online_cpu(cpu) {
+		int coreid = cpu_logical_map(cpu);
+		en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+		en1 &= ~(1ull << bit);
+		cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	}
+	/*
+	 * We need to do a read after the last update to make sure all
+	 * of them are done.
+	 */
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
+	write_unlock_irqrestore(&octeon_irq_ciu1_rwlock, flags);
+#else
+	int coreid = cvmx_get_core_num();
+	local_irq_save(flags);
+	en1 = cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	en1 &= ~(1ull << bit);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1));
+	local_irq_restore(flags);
+#endif
+}
+
+#ifdef CONFIG_SMP
+static void octeon_irq_ciu1_set_affinity(unsigned int irq, cpumask_t dest)
+{
+	int cpu;
+	int bit = irq - OCTEON_IRQ_WDOG0;	/* Bit 0-63 of EN1 */
+
+	write_lock(&octeon_irq_ciu1_rwlock);
+	for_each_online_cpu(cpu) {
+		int coreid = cpu_logical_map(cpu);
+		uint64_t en1 =
+			cvmx_read_csr(CVMX_CIU_INTX_EN1
+				(coreid * 2 + 1));
+		if (cpu_isset(cpu, dest))
+			en1 |= 1ull << bit;
+		else
+			en1 &= ~(1ull << bit);
+		cvmx_write_csr(CVMX_CIU_INTX_EN1(coreid * 2 + 1), en1);
+	}
+	/*
+	 * We need to do a read after the last update to make sure all
+	 * of them are done.
+	 */
+	cvmx_read_csr(CVMX_CIU_INTX_EN1(cvmx_get_core_num() * 2 + 1));
+	write_unlock(&octeon_irq_ciu1_rwlock);
+}
+#endif
+
+static struct irq_chip octeon_irq_chip_ciu1 = {
+	.name = "CIU1",
+	.enable = octeon_irq_ciu1_enable,
+	.disable = octeon_irq_ciu1_disable,
+	.ack = octeon_irq_ciu1_ack,
+	.eoi = octeon_irq_ciu1_eoi,
+#ifdef CONFIG_SMP
+	.set_affinity = octeon_irq_ciu1_set_affinity,
+#endif
+};
+
+#ifdef CONFIG_PCI_MSI
+
+static void octeon_irq_msi_ack(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* These chips have PCI */
+		cvmx_write_csr(CVMX_NPI_NPI_MSI_RCV,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	} else {
+		/*
+		 * These chips have PCIe. Thankfully the ACK doesn't
+		 * need any locking.
+		 */
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_RCV0,
+			       1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+	}
+}
+
+static void octeon_irq_msi_eoi(unsigned int irq)
+{
+	/* Nothing needed */
+}
+
+static void octeon_irq_msi_enable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/*
+		 * Octeon PCI doesn't have the ability to mask/unmask
+		 * MSI interrupts individually.  Instead of
+		 * masking/unmasking them in groups of 16, we simple
+		 * assume MSI devices are well behaved.  MSI
+		 * interrupts are always enable and the ACK is assumed
+		 * to be enough.
+		 */
+	} else {
+		/* These chips have PCIe.  Note that we only support
+		 * the first 64 MSI interrupts.  Unfortunately all the
+		 * MSI enables are in the same register.  We use
+		 * MSI0's lock to control access to them all.
+		 */
+		uint64_t en;
+		unsigned long flags;
+		spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en |= 1ull << (irq - OCTEON_IRQ_MSI_BIT0);
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+static void octeon_irq_msi_disable(unsigned int irq)
+{
+	if (!octeon_has_feature(OCTEON_FEATURE_PCIE)) {
+		/* See comment in enable */
+	} else {
+		/*
+		 * These chips have PCIe.  Note that we only support
+		 * the first 64 MSI interrupts.  Unfortunately all the
+		 * MSI enables are in the same register.  We use
+		 * MSI0's lock to control access to them all.
+		 */
+		uint64_t en;
+		unsigned long flags;
+		spin_lock_irqsave(&octeon_irq_msi_lock, flags);
+		en = cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		en &= ~(1ull << (irq - OCTEON_IRQ_MSI_BIT0));
+		cvmx_write_csr(CVMX_PEXP_NPEI_MSI_ENB0, en);
+		cvmx_read_csr(CVMX_PEXP_NPEI_MSI_ENB0);
+		spin_unlock_irqrestore(&octeon_irq_msi_lock, flags);
+	}
+}
+
+static struct irq_chip octeon_irq_chip_msi = {
+	.name = "MSI",
+	.enable = octeon_irq_msi_enable,
+	.disable = octeon_irq_msi_disable,
+	.ack = octeon_irq_msi_ack,
+	.eoi = octeon_irq_msi_eoi,
+};
+#endif
+
+void __init arch_init_irq(void)
+{
+	int irq;
+
+#ifdef CONFIG_SMP
+	/* Set the default affinity to the boot cpu. */
+	irq_default_affinity = cpumask_of_cpu(smp_processor_id());
+#endif
+
+	if (NR_IRQS < OCTEON_IRQ_LAST)
+		pr_err("octeon_irq_init: NR_IRQS is set too low\n");
+
+	/* 0 - 15 reserved for i8259 master and slave controller. */
+
+	/* 17 - 23 Mips internal */
+	for (irq = OCTEON_IRQ_SW0; irq <= OCTEON_IRQ_TIMER; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_core,
+					 handle_percpu_irq);
+	}
+
+	/* 24 - 87 CIU_INT_SUM0 */
+	for (irq = OCTEON_IRQ_WORKQ0; irq <= OCTEON_IRQ_BOOTDMA; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu0,
+					 handle_percpu_irq);
+	}
+
+	/* 88 - 151 CIU_INT_SUM1 */
+	for (irq = OCTEON_IRQ_WDOG0; irq <= OCTEON_IRQ_RESERVED151; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_ciu1,
+					 handle_percpu_irq);
+	}
+
+#ifdef CONFIG_PCI_MSI
+	/* 152 - 215 PCI/PCIe MSI interrupts */
+	for (irq = OCTEON_IRQ_MSI_BIT0; irq <= OCTEON_IRQ_MSI_BIT63; irq++) {
+		set_irq_chip_and_handler(irq, &octeon_irq_chip_msi,
+					 handle_percpu_irq);
+	}
+#endif
+	set_c0_status(0x300 << 2);
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	const unsigned long core_id = cvmx_get_core_num();
+	const uint64_t ciu_sum0_address = CVMX_CIU_INTX_SUM0(core_id * 2);
+	const uint64_t ciu_en0_address = CVMX_CIU_INTX_EN0(core_id * 2);
+	const uint64_t ciu_sum1_address = CVMX_CIU_INT_SUM1;
+	const uint64_t ciu_en1_address = CVMX_CIU_INTX_EN1(core_id * 2 + 1);
+	unsigned long cop0_cause;
+	unsigned long cop0_status;
+	uint64_t ciu_en;
+	uint64_t ciu_sum;
+
+	while (1) {
+		cop0_cause = read_c0_cause();
+		cop0_status = read_c0_status();
+		cop0_cause &= cop0_status;
+		cop0_cause &= ST0_IM;
+
+		if (unlikely(cop0_cause & STATUSF_IP2)) {
+			ciu_sum = cvmx_read_csr(ciu_sum0_address);
+			ciu_en = cvmx_read_csr(ciu_en0_address);
+			ciu_sum &= ciu_en;
+			if (likely(ciu_sum))
+				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WORKQ0 - 1);
+			else
+				spurious_interrupt();
+		} else if (unlikely(cop0_cause & STATUSF_IP3)) {
+			ciu_sum = cvmx_read_csr(ciu_sum1_address);
+			ciu_en = cvmx_read_csr(ciu_en1_address);
+			ciu_sum &= ciu_en;
+			if (likely(ciu_sum))
+				do_IRQ(fls64(ciu_sum) + OCTEON_IRQ_WDOG0 - 1);
+			else
+				spurious_interrupt();
+		} else if (likely(cop0_cause)) {
+			do_IRQ(fls(cop0_cause) - 9 + MIPS_CPU_IRQ_BASE);
+		} else {
+			break;
+		}
+	}
+}
diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
new file mode 100644
index 0000000..88e0cdd
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -0,0 +1,521 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Unified implementation of memcpy, memmove and the __copy_user backend.
+ *
+ * Copyright (C) 1998, 99, 2000, 01, 2002 Ralf Baechle (ralf@gnu.org)
+ * Copyright (C) 1999, 2000, 01, 2002 Silicon Graphics, Inc.
+ * Copyright (C) 2002 Broadcom, Inc.
+ *   memcpy/copy_user author: Mark Vandevoorde
+ *
+ * Mnemonic names for arguments to memcpy/__copy_user
+ */
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+
+#define dst a0
+#define src a1
+#define len a2
+
+/*
+ * Spec
+ *
+ * memcpy copies len bytes from src to dst and sets v0 to dst.
+ * It assumes that
+ *   - src and dst don't overlap
+ *   - src is readable
+ *   - dst is writable
+ * memcpy uses the standard calling convention
+ *
+ * __copy_user copies up to len bytes from src to dst and sets a2 (len) to
+ * the number of uncopied bytes due to an exception caused by a read or write.
+ * __copy_user assumes that src and dst don't overlap, and that the call is
+ * implementing one of the following:
+ *   copy_to_user
+ *     - src is readable  (no exceptions when reading src)
+ *   copy_from_user
+ *     - dst is writable  (no exceptions when writing dst)
+ * __copy_user uses a non-standard calling convention; see
+ * arch/mips/include/asm/uaccess.h
+ *
+ * When an exception happens on a load, the handler must
+ # ensure that all of the destination buffer is overwritten to prevent
+ * leaking information to user mode programs.
+ */
+
+/*
+ * Implementation
+ */
+
+/*
+ * The exception handler for loads requires that:
+ *  1- AT contain the address of the byte just past the end of the source
+ *     of the copy,
+ *  2- src_entry <= src < AT, and
+ *  3- (dst - src) == (dst_entry - src_entry),
+ * The _entry suffix denotes values when __copy_user was called.
+ *
+ * (1) is set up up by uaccess.h and maintained by not writing AT in copy_user
+ * (2) is met by incrementing src by the number of bytes copied
+ * (3) is met by not doing loads between a pair of increments of dst and src
+ *
+ * The exception handlers for stores adjust len (if necessary) and return.
+ * These handlers do not need to overwrite any data.
+ *
+ * For __rmemcpy and memmove an exception is always a kernel bug, therefore
+ * they're not protected.
+ */
+
+#define EXC(inst_reg,addr,handler)		\
+9:	inst_reg, addr;				\
+	.section __ex_table,"a";		\
+	PTR	9b, handler;			\
+	.previous
+
+/*
+ * Only on the 64-bit kernel we can made use of 64-bit registers.
+ */
+#ifdef CONFIG_64BIT
+#define USE_DOUBLE
+#endif
+
+#ifdef USE_DOUBLE
+
+#define LOAD   ld
+#define LOADL  ldl
+#define LOADR  ldr
+#define STOREL sdl
+#define STORER sdr
+#define STORE  sd
+#define ADD    daddu
+#define SUB    dsubu
+#define SRL    dsrl
+#define SRA    dsra
+#define SLL    dsll
+#define SLLV   dsllv
+#define SRLV   dsrlv
+#define NBYTES 8
+#define LOG_NBYTES 3
+
+/*
+ * As we are sharing code base with the mips32 tree (which use the o32 ABI
+ * register definitions). We need to redefine the register definitions from
+ * the n64 ABI register naming to the o32 ABI register naming.
+ */
+#undef t0
+#undef t1
+#undef t2
+#undef t3
+#define t0	$8
+#define t1	$9
+#define t2	$10
+#define t3	$11
+#define t4	$12
+#define t5	$13
+#define t6	$14
+#define t7	$15
+
+#else
+
+#define LOAD   lw
+#define LOADL  lwl
+#define LOADR  lwr
+#define STOREL swl
+#define STORER swr
+#define STORE  sw
+#define ADD    addu
+#define SUB    subu
+#define SRL    srl
+#define SLL    sll
+#define SRA    sra
+#define SLLV   sllv
+#define SRLV   srlv
+#define NBYTES 4
+#define LOG_NBYTES 2
+
+#endif /* USE_DOUBLE */
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define LDFIRST LOADR
+#define LDREST  LOADL
+#define STFIRST STORER
+#define STREST  STOREL
+#define SHIFT_DISCARD SLLV
+#else
+#define LDFIRST LOADL
+#define LDREST  LOADR
+#define STFIRST STOREL
+#define STREST  STORER
+#define SHIFT_DISCARD SRLV
+#endif
+
+#define FIRST(unit) ((unit)*NBYTES)
+#define REST(unit)  (FIRST(unit)+NBYTES-1)
+#define UNIT(unit)  FIRST(unit)
+
+#define ADDRMASK (NBYTES-1)
+
+	.text
+	.set	noreorder
+	.set	noat
+
+/*
+ * A combined memcpy/__copy_user
+ * __copy_user sets len to 0 for success; else to an upper bound of
+ * the number of uncopied bytes.
+ * memcpy sets v0 to dst.
+ */
+	.align	5
+LEAF(memcpy)					/* a0=dst a1=src a2=len */
+	move	v0, dst				/* return value */
+__memcpy:
+FEXPORT(__copy_user)
+	/*
+	 * Note: dst & src may be unaligned, len may be 0
+	 * Temps
+	 */
+	#
+	# Octeon doesn't care if the destination is unaligned. The hardware
+	# can fix it faster than we can special case the assembly.
+	#
+	pref	0, 0(src)
+	sltu	t0, len, NBYTES		# Check if < 1 word
+	bnez	t0, copy_bytes_checklen
+	 and	t0, src, ADDRMASK	# Check if src unaligned
+	bnez	t0, src_unaligned
+	 sltu	t0, len, 4*NBYTES	# Check if < 4 words
+	bnez	t0, less_than_4units
+	 sltu	t0, len, 8*NBYTES	# Check if < 8 words
+	bnez	t0, less_than_8units
+	 sltu	t0, len, 16*NBYTES	# Check if < 16 words
+	bnez	t0, cleanup_both_aligned
+	 sltu	t0, len, 128+1		# Check if len < 129
+	bnez	t0, 1f			# Skip prefetch if len is too short
+	 sltu	t0, len, 256+1		# Check if len < 257
+	bnez	t0, 1f			# Skip prefetch if len is too short
+	 pref	0, 128(src)		# We must not prefetch invalid addresses
+	#
+	# This is where we loop if there is more than 128 bytes left
+2:	pref	0, 256(src)		# We must not prefetch invalid addresses
+	#
+	# This is where we loop if we can't prefetch anymore
+1:
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 16*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p16u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p15u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p14u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p13u)
+EXC(	LOAD	t0, UNIT(4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(5)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(7)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(4)(dst),	s_exc_p12u)
+EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p11u)
+EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
+	ADD	src, src, 16*NBYTES
+EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
+	ADD	dst, dst, 16*NBYTES
+EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
+EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
+EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
+EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
+EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(-1)(dst),	s_exc_p1u)
+	sltu	t0, len, 256+1		# See if we can prefetch more
+	beqz	t0, 2b
+	 sltu	t0, len, 128		# See if we can loop more time
+	beqz	t0, 1b
+	 nop
+	#
+	# Jump here if there are less than 16*NBYTES left.
+	#
+cleanup_both_aligned:
+	beqz	len, done
+	 sltu	t0, len, 8*NBYTES
+	bnez	t0, less_than_8units
+	 nop
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 8*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p8u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p7u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p6u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p5u)
+EXC(	LOAD	t0, UNIT(4)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(5)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(6)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(7)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(4)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p1u)
+	ADD	src, src, 8*NBYTES
+	beqz	len, done
+	 ADD	dst, dst, 8*NBYTES
+	#
+	# Jump here if there are less than 8*NBYTES left.
+	#
+less_than_8units:
+	sltu	t0, len, 4*NBYTES
+	bnez	t0, less_than_4units
+	 nop
+EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
+EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
+	SUB	len, len, 4*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
+	ADD	src, src, 4*NBYTES
+	beqz	len, done
+	 ADD	dst, dst, 4*NBYTES
+	#
+	# Jump here if there are less than 4*NBYTES left. This means
+	# we may need to copy up to 3 NBYTES words.
+	#
+less_than_4units:
+	sltu	t0, len, 1*NBYTES
+	bnez	t0, copy_bytes_checklen
+	 nop
+	#
+	# 1) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	sltu	t1, len, 8
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bnez	t1, copy_bytes_checklen
+	 ADD	dst, dst, NBYTES
+	#
+	# 2) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	sltu	t1, len, 8
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bnez	t1, copy_bytes_checklen
+	 ADD	dst, dst, NBYTES
+	#
+	# 3) Copy NBYTES, then check length again
+	#
+EXC(	LOAD	t0, 0(src),		l_exc)
+	SUB	len, len, NBYTES
+	ADD	src, src, NBYTES
+	ADD	dst, dst, NBYTES
+	b copy_bytes_checklen
+EXC(	 STORE	t0, -8(dst),		s_exc_p1u)
+
+src_unaligned:
+#define rem t8
+	SRL	t0, len, LOG_NBYTES+2    # +2 for 4 units/iter
+	beqz	t0, cleanup_src_unaligned
+	 and	rem, len, (4*NBYTES-1)   # rem = len % 4*NBYTES
+1:
+/*
+ * Avoid consecutive LD*'s to the same register since some mips
+ * implementations can't issue them in the same cycle.
+ * It's OK to load FIRST(N+1) before REST(N) because the two addresses
+ * are to the same unit (unless src is aligned, but it's not).
+ */
+EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
+EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
+	SUB     len, len, 4*NBYTES
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+EXC(	LDREST	t1, REST(1)(src),	l_exc_copy)
+EXC(	LDFIRST	t2, FIRST(2)(src),	l_exc_copy)
+EXC(	LDFIRST	t3, FIRST(3)(src),	l_exc_copy)
+EXC(	LDREST	t2, REST(2)(src),	l_exc_copy)
+EXC(	LDREST	t3, REST(3)(src),	l_exc_copy)
+	ADD	src, src, 4*NBYTES
+EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
+EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
+EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
+EXC(	STORE	t3, UNIT(3)(dst),	s_exc_p1u)
+	bne	len, rem, 1b
+	 ADD	dst, dst, 4*NBYTES
+
+cleanup_src_unaligned:
+	beqz	len, done
+	 and	rem, len, NBYTES-1  # rem = len % NBYTES
+	beq	rem, len, copy_bytes
+	 nop
+1:
+EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
+EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
+	SUB	len, len, NBYTES
+EXC(	STORE	t0, 0(dst),		s_exc_p1u)
+	ADD	src, src, NBYTES
+	bne	len, rem, 1b
+	 ADD	dst, dst, NBYTES
+
+copy_bytes_checklen:
+	beqz	len, done
+	 nop
+copy_bytes:
+	/* 0 < len < NBYTES  */
+#define COPY_BYTE(N)			\
+EXC(	lb	t0, N(src), l_exc);	\
+	SUB	len, len, 1;		\
+	beqz	len, done;		\
+EXC(	 sb	t0, N(dst), s_exc_p1)
+
+	COPY_BYTE(0)
+	COPY_BYTE(1)
+#ifdef USE_DOUBLE
+	COPY_BYTE(2)
+	COPY_BYTE(3)
+	COPY_BYTE(4)
+	COPY_BYTE(5)
+#endif
+EXC(	lb	t0, NBYTES-2(src), l_exc)
+	SUB	len, len, 1
+	jr	ra
+EXC(	 sb	t0, NBYTES-2(dst), s_exc_p1)
+done:
+	jr	ra
+	 nop
+	END(memcpy)
+
+l_exc_copy:
+	/*
+	 * Copy bytes from src until faulting load address (or until a
+	 * lb faults)
+	 *
+	 * When reached by a faulting LDFIRST/LDREST, THREAD_BUADDR($28)
+	 * may be more than a byte beyond the last address.
+	 * Hence, the lb below may get an exception.
+	 *
+	 * Assumes src < THREAD_BUADDR($28)
+	 */
+	LOAD	t0, TI_TASK($28)
+	 nop
+	LOAD	t0, THREAD_BUADDR(t0)
+1:
+EXC(	lb	t1, 0(src),	l_exc)
+	ADD	src, src, 1
+	sb	t1, 0(dst)	# can't fault -- we're copy_from_user
+	bne	src, t0, 1b
+	 ADD	dst, dst, 1
+l_exc:
+	LOAD	t0, TI_TASK($28)
+	 nop
+	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
+	 nop
+	SUB	len, AT, t0		# len number of uncopied bytes
+	/*
+	 * Here's where we rely on src and dst being incremented in tandem,
+	 *   See (3) above.
+	 * dst += (fault addr - src) to put dst at first byte to clear
+	 */
+	ADD	dst, t0			# compute start address in a1
+	SUB	dst, src
+	/*
+	 * Clear len bytes starting at dst.  Can't call __bzero because it
+	 * might modify len.  An inefficient loop for these rare times...
+	 */
+	beqz	len, done
+	 SUB	src, len, 1
+1:	sb	zero, 0(dst)
+	ADD	dst, dst, 1
+	bnez	src, 1b
+	 SUB	src, src, 1
+	jr	ra
+	 nop
+
+
+#define SEXC(n)				\
+s_exc_p ## n ## u:			\
+	jr	ra;			\
+	 ADD	len, len, n*NBYTES
+
+SEXC(16)
+SEXC(15)
+SEXC(14)
+SEXC(13)
+SEXC(12)
+SEXC(11)
+SEXC(10)
+SEXC(9)
+SEXC(8)
+SEXC(7)
+SEXC(6)
+SEXC(5)
+SEXC(4)
+SEXC(3)
+SEXC(2)
+SEXC(1)
+
+s_exc_p1:
+	jr	ra
+	 ADD	len, len, 1
+s_exc:
+	jr	ra
+	 nop
+
+	.align	5
+LEAF(memmove)
+	ADD	t0, a0, a2
+	ADD	t1, a1, a2
+	sltu	t0, a1, t0			# dst + len <= src -> memcpy
+	sltu	t1, a0, t1			# dst >= src + len -> memcpy
+	and	t0, t1
+	beqz	t0, __memcpy
+	 move	v0, a0				/* return value */
+	beqz	a2, r_out
+	END(memmove)
+
+	/* fall through to __rmemcpy */
+LEAF(__rmemcpy)					/* a0=dst a1=src a2=len */
+	 sltu	t0, a1, a0
+	beqz	t0, r_end_bytes_up		# src >= dst
+	 nop
+	ADD	a0, a2				# dst = dst + len
+	ADD	a1, a2				# src = src + len
+
+r_end_bytes:
+	lb	t0, -1(a1)
+	SUB	a2, a2, 0x1
+	sb	t0, -1(a0)
+	SUB	a1, a1, 0x1
+	bnez	a2, r_end_bytes
+	 SUB	a0, a0, 0x1
+
+r_out:
+	jr	ra
+	 move	a2, zero
+
+r_end_bytes_up:
+	lb	t0, (a1)
+	SUB	a2, a2, 0x1
+	sb	t0, (a0)
+	ADD	a1, a1, 0x1
+	bnez	a2, r_end_bytes_up
+	 ADD	a0, a0, 0x1
+
+	jr	ra
+	 move	a2, zero
+	END(__rmemcpy)
diff --git a/arch/mips/cavium-octeon/serial.c b/arch/mips/cavium-octeon/serial.c
new file mode 100644
index 0000000..8240728
--- /dev/null
+++ b/arch/mips/cavium-octeon/serial.c
@@ -0,0 +1,136 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ */
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
+#include <linux/tty.h>
+
+#include <asm/time.h>
+
+#include <asm/octeon/octeon.h>
+
+#ifdef CONFIG_GDB_CONSOLE
+#define DEBUG_UART 0
+#else
+#define DEBUG_UART 1
+#endif
+
+unsigned int octeon_serial_in(struct uart_port *up, int offset)
+{
+	int rv = cvmx_read_csr((uint64_t)(up->membase + (offset << 3)));
+	if (offset == UART_IIR && (rv & 0xf) == 7) {
+		/* Busy interrupt, read the USR (39) and try again. */
+		cvmx_read_csr((uint64_t)(up->membase + (39 << 3)));
+		rv = cvmx_read_csr((uint64_t)(up->membase + (offset << 3)));
+	}
+	return rv;
+}
+
+void octeon_serial_out(struct uart_port *up, int offset, int value)
+{
+	/*
+	 * If bits 6 or 7 of the OCTEON UART's LCR are set, it quits
+	 * working.
+	 */
+	if (offset == UART_LCR)
+		value &= 0x9f;
+	cvmx_write_csr((uint64_t)(up->membase + (offset << 3)), (u8)value);
+}
+
+/*
+ * Allocated in .bss, so it is all zeroed.
+ */
+#define OCTEON_MAX_UARTS 3
+static struct plat_serial8250_port octeon_uart8250_data[OCTEON_MAX_UARTS + 1];
+static struct platform_device octeon_uart8250_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev			= {
+		.platform_data	= octeon_uart8250_data,
+	},
+};
+
+static void __init octeon_uart_set_common(struct plat_serial8250_port *p)
+{
+	p->flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	p->type = PORT_OCTEON;
+	p->iotype = UPIO_MEM;
+	p->regshift = 3;	/* I/O addresses are every 8 bytes */
+	p->uartclk = mips_hpt_frequency;
+	p->serial_in = octeon_serial_in;
+	p->serial_out = octeon_serial_out;
+}
+
+static int __init octeon_serial_init(void)
+{
+	int enable_uart0;
+	int enable_uart1;
+	int enable_uart2;
+	struct plat_serial8250_port *p;
+
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	/*
+	 * If we are configured to run as the second of two kernels,
+	 * disable uart0 and enable uart1. Uart0 is owned by the first
+	 * kernel
+	 */
+	enable_uart0 = 0;
+	enable_uart1 = 1;
+#else
+	/*
+	 * We are configured for the first kernel. We'll enable uart0
+	 * if the bootloader told us to use 0, otherwise will enable
+	 * uart 1.
+	 */
+	enable_uart0 = (octeon_get_boot_uart() == 0);
+	enable_uart1 = (octeon_get_boot_uart() == 1);
+#ifdef CONFIG_KGDB
+	enable_uart1 = 1;
+#endif
+#endif
+
+	/* Right now CN52XX is the only chip with a third uart */
+	enable_uart2 = OCTEON_IS_MODEL(OCTEON_CN52XX);
+
+	p = octeon_uart8250_data;
+	if (enable_uart0) {
+		/* Add a ttyS device for hardware uart 0 */
+		octeon_uart_set_common(p);
+		p->membase = (void *) CVMX_MIO_UARTX_RBR(0);
+		p->mapbase = CVMX_MIO_UARTX_RBR(0) & ((1ull << 49) - 1);
+		p->irq = OCTEON_IRQ_UART0;
+		p++;
+	}
+
+	if (enable_uart1) {
+		/* Add a ttyS device for hardware uart 1 */
+		octeon_uart_set_common(p);
+		p->membase = (void *) CVMX_MIO_UARTX_RBR(1);
+		p->mapbase = CVMX_MIO_UARTX_RBR(1) & ((1ull << 49) - 1);
+		p->irq = OCTEON_IRQ_UART1;
+		p++;
+	}
+	if (enable_uart2) {
+		/* Add a ttyS device for hardware uart 2 */
+		octeon_uart_set_common(p);
+		p->membase = (void *) CVMX_MIO_UART2_RBR;
+		p->mapbase = CVMX_MIO_UART2_RBR & ((1ull << 49) - 1);
+		p->irq = OCTEON_IRQ_UART2;
+		p++;
+	}
+
+	BUG_ON(p > &octeon_uart8250_data[OCTEON_MAX_UARTS]);
+
+	return platform_device_register(&octeon_uart8250_device);
+}
+
+device_initcall(octeon_serial_init);
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
new file mode 100644
index 0000000..e085fed
--- /dev/null
+++ b/arch/mips/cavium-octeon/setup.c
@@ -0,0 +1,929 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2007 Cavium Networks
+ * Copyright (C) 2008 Wind River Systems
+ */
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/serial.h>
+#include <linux/types.h>
+#include <linux/string.h>	/* for memset */
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/time.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <linux/string.h>
+
+#include <asm/processor.h>
+#include <asm/reboot.h>
+#include <asm/smp-ops.h>
+#include <asm/system.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/bootinfo.h>
+#include <asm/sections.h>
+#include <asm/time.h>
+
+#include <asm/octeon/octeon.h>
+
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+extern void cvmx_interrupt_rsl_decode(void);
+extern int __cvmx_interrupt_ecc_report_single_bit_errors;
+extern void cvmx_interrupt_rsl_enable(void);
+#endif
+
+extern struct plat_smp_ops octeon_smp_ops;
+
+#ifdef CONFIG_PCI
+extern void pci_console_init(const char *arg);
+#endif
+
+#ifdef CONFIG_CAVIUM_RESERVE32
+extern uint64_t octeon_reserve32_memory;
+#endif
+static unsigned long long MAX_MEMORY = 512ull << 20;
+
+struct octeon_boot_descriptor *octeon_boot_desc_ptr;
+
+struct cvmx_bootinfo *octeon_bootinfo;
+EXPORT_SYMBOL(octeon_bootinfo);
+
+#ifdef CONFIG_CAVIUM_RESERVE32
+uint64_t octeon_reserve32_memory;
+EXPORT_SYMBOL(octeon_reserve32_memory);
+#endif
+
+static int octeon_uart;
+
+extern asmlinkage void handle_int(void);
+extern asmlinkage void plat_irq_dispatch(void);
+
+/**
+ * Return non zero if we are currently running in the Octeon simulator
+ *
+ * Returns
+ */
+int octeon_is_simulation(void)
+{
+	return octeon_bootinfo->board_type == CVMX_BOARD_TYPE_SIM;
+}
+EXPORT_SYMBOL(octeon_is_simulation);
+
+/**
+ * Return true if Octeon is in PCI Host mode. This means
+ * Linux can control the PCI bus.
+ *
+ * Returns Non zero if Octeon in host mode.
+ */
+int octeon_is_pci_host(void)
+{
+#ifdef CONFIG_PCI
+	return octeon_bootinfo->config_flags & CVMX_BOOTINFO_CFG_FLAG_PCI_HOST;
+#else
+	return 0;
+#endif
+}
+
+/**
+ * Get the clock rate of Octeon
+ *
+ * Returns Clock rate in HZ
+ */
+uint64_t octeon_get_clock_rate(void)
+{
+	if (octeon_is_simulation())
+		octeon_bootinfo->eclock_hz = 6000000;
+	return octeon_bootinfo->eclock_hz;
+}
+EXPORT_SYMBOL(octeon_get_clock_rate);
+
+/**
+ * Write to the LCD display connected to the bootbus. This display
+ * exists on most Cavium evaluation boards. If it doesn't exist, then
+ * this function doesn't do anything.
+ *
+ * @s:      String to write
+ */
+void octeon_write_lcd(const char *s)
+{
+	if (octeon_bootinfo->led_display_base_addr) {
+		void __iomem *lcd_address =
+			ioremap_nocache(octeon_bootinfo->led_display_base_addr,
+					8);
+		int i;
+		for (i = 0; i < 8; i++, s++) {
+			if (*s)
+				iowrite8(*s, lcd_address + i);
+			else
+				iowrite8(' ', lcd_address + i);
+		}
+		iounmap(lcd_address);
+	}
+}
+
+/**
+ * Return the console uart passed by the bootloader
+ *
+ * Returns uart   (0 or 1)
+ */
+int octeon_get_boot_uart(void)
+{
+	int uart;
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	uart = 1;
+#else
+	uart = (octeon_boot_desc_ptr->flags & OCTEON_BL_FLAG_CONSOLE_UART1) ?
+		1 : 0;
+#endif
+	return uart;
+}
+
+/**
+ * Get the coremask Linux was booted on.
+ *
+ * Returns Core mask
+ */
+int octeon_get_boot_coremask(void)
+{
+	return octeon_boot_desc_ptr->core_mask;
+}
+
+/**
+ * Check the hardware BIST results for a CPU
+ */
+void octeon_check_cpu_bist(void)
+{
+	const int coreid = cvmx_get_core_num();
+	unsigned long long mask;
+	unsigned long long bist_val;
+
+	/* Check BIST results for COP0 registers */
+	mask = 0x1f00000000ull;
+	bist_val = read_octeon_c0_icacheerr();
+	if (bist_val & mask)
+		pr_err("Core%d BIST Failure: CacheErr(icache) = 0x%llx\n",
+		       coreid, bist_val);
+
+	bist_val = read_octeon_c0_dcacheerr();
+	if (bist_val & 1)
+		pr_err("Core%d L1 Dcache parity error: "
+		       "CacheErr(dcache) = 0x%llx\n",
+		       coreid, bist_val);
+
+	mask = 0xfc00000000000000ull;
+	bist_val = read_c0_cvmmemctl();
+	if (bist_val & mask)
+		pr_err("Core%d BIST Failure: COP0_CVM_MEM_CTL = 0x%llx\n",
+		       coreid, bist_val);
+
+	write_octeon_c0_dcacheerr(0);
+}
+
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+/**
+ * Called on every core to setup the wired tlb entry needed
+ * if CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB is set.
+ *
+ */
+static void octeon_hal_setup_per_cpu_reserved32(void *unused)
+{
+	/*
+	 * The config has selected to wire the reserve32 memory for all
+	 * userspace applications. We need to put a wired TLB entry in for each
+	 * 512MB of reserve32 memory. We only handle double 256MB pages here,
+	 * so reserve32 must be multiple of 512MB.
+	 */
+	uint32_t size = CONFIG_CAVIUM_RESERVE32;
+	uint32_t entrylo0 =
+		0x7 | ((octeon_reserve32_memory & ((1ul << 40) - 1)) >> 6);
+	uint32_t entrylo1 = entrylo0 + (256 << 14);
+	uint32_t entryhi = (0x80000000UL - (CONFIG_CAVIUM_RESERVE32 << 20));
+	while (size >= 512) {
+#if 0
+		pr_info("CPU%d: Adding double wired TLB entry for 0x%lx\n",
+			smp_processor_id(), entryhi);
+#endif
+		add_wired_entry(entrylo0, entrylo1, entryhi, PM_256M);
+		entrylo0 += 512 << 14;
+		entrylo1 += 512 << 14;
+		entryhi += 512 << 20;
+		size -= 512;
+	}
+}
+#endif /* CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB */
+
+/**
+ * Called to release the named block which was used to made sure
+ * that nobody used the memory for something else during
+ * init. Now we'll free it so userspace apps can use this
+ * memory region with bootmem_alloc.
+ *
+ * This function is called only once from prom_free_prom_memory().
+ */
+void octeon_hal_setup_reserved32(void)
+{
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
+#endif
+}
+
+/**
+ * Reboot Octeon
+ *
+ * @command: Command to pass to the bootloader. Currently ignored.
+ */
+static void octeon_restart(char *command)
+{
+	/* Disable all watchdogs before soft reset. They don't get cleared */
+#ifdef CONFIG_SMP
+	int cpu;
+	for_each_online_cpu(cpu)
+		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
+#else
+	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+#endif
+
+	mb();
+	while (1)
+		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
+}
+
+
+/**
+ * Permanently stop a core.
+ *
+ * @arg: Ignored.
+ */
+static void octeon_kill_core(void *arg)
+{
+	mb();
+	if (octeon_is_simulation()) {
+		/* The simulator needs the watchdog to stop for dead cores */
+		cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
+		/* A break instruction causes the simulator stop a core */
+		asm volatile ("sync\nbreak");
+	}
+}
+
+
+/**
+ * Halt the system
+ */
+static void octeon_halt(void)
+{
+	smp_call_function(octeon_kill_core, NULL, 0);
+
+	switch (octeon_bootinfo->board_type) {
+	case CVMX_BOARD_TYPE_NAO38:
+		/* Driving a 1 to GPIO 12 shuts off this board */
+		cvmx_write_csr(CVMX_GPIO_BIT_CFGX(12), 1);
+		cvmx_write_csr(CVMX_GPIO_TX_SET, 0x1000);
+		break;
+	default:
+		octeon_write_lcd("PowerOff");
+		break;
+	}
+
+	octeon_kill_core(NULL);
+}
+
+#if 0
+/**
+ * Platform time init specifics.
+ * Returns
+ */
+void __init plat_time_init(void)
+{
+	/* Nothing special here, but we are required to have one */
+}
+
+#endif
+
+/**
+ * Handle all the error condition interrupts that might occur.
+ *
+ */
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+static irqreturn_t octeon_rlm_interrupt(int cpl, void *dev_id)
+{
+	cvmx_interrupt_rsl_decode();
+	return IRQ_HANDLED;
+}
+#endif
+
+/**
+ * Return a string representing the system type
+ *
+ * Returns
+ */
+const char *octeon_board_type_string(void)
+{
+	static char name[80];
+	sprintf(name, "%s (%s)",
+		cvmx_board_type_to_string(octeon_bootinfo->board_type),
+		octeon_model_get_string(read_c0_prid()));
+	return name;
+}
+
+const char *get_system_type(void)
+	__attribute__ ((alias("octeon_board_type_string")));
+
+void octeon_user_io_init(void)
+{
+	union octeon_cvmemctl cvmmemctl;
+	union cvmx_iob_fau_timeout fau_timeout;
+	union cvmx_pow_nw_tim nm_tim;
+	uint64_t cvmctl;
+
+	/* Get the current settings for CP0_CVMMEMCTL_REG */
+	cvmmemctl.u64 = read_c0_cvmmemctl();
+	/* R/W If set, marked write-buffer entries time out the same
+	 * as as other entries; if clear, marked write-buffer entries
+	 * use the maximum timeout. */
+	cvmmemctl.s.dismarkwblongto = 1;
+	/* R/W If set, a merged store does not clear the write-buffer
+	 * entry timeout state. */
+	cvmmemctl.s.dismrgclrwbto = 0;
+	/* R/W Two bits that are the MSBs of the resultant CVMSEG LM
+	 * word location for an IOBDMA. The other 8 bits come from the
+	 * SCRADDR field of the IOBDMA. */
+	cvmmemctl.s.iobdmascrmsb = 0;
+	/* R/W If set, SYNCWS and SYNCS only order marked stores; if
+	 * clear, SYNCWS and SYNCS only order unmarked
+	 * stores. SYNCWSMARKED has no effect when DISSYNCWS is
+	 * set. */
+	cvmmemctl.s.syncwsmarked = 0;
+	/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as SYNC. */
+	cvmmemctl.s.dissyncws = 0;
+	/* R/W If set, no stall happens on write buffer full. */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2))
+		cvmmemctl.s.diswbfst = 1;
+	else
+		cvmmemctl.s.diswbfst = 0;
+	/* R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with <48>==0 */
+	cvmmemctl.s.xkmemenas = 0;
+
+	/* R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==0 */
+	cvmmemctl.s.xkmemenau = 0;
+
+	/* R/W If set (and SX set), supervisor-level loads/stores can
+	 * use XKPHYS addresses with VA<48>==1 */
+	cvmmemctl.s.xkioenas = 0;
+
+	/* R/W If set (and UX set), user-level loads/stores can use
+	 * XKPHYS addresses with VA<48>==1 */
+	cvmmemctl.s.xkioenau = 0;
+
+	/* R/W If set, all stores act as SYNCW (NOMERGE must be set
+	 * when this is set) RW, reset to 0. */
+	cvmmemctl.s.allsyncw = 0;
+
+	/* R/W If set, no stores merge, and all stores reach the
+	 * coherent bus in order. */
+	cvmmemctl.s.nomerge = 0;
+	/* R/W Selects the bit in the counter used for DID time-outs 0
+	 * = 231, 1 = 230, 2 = 229, 3 = 214. Actual time-out is
+	 * between 1x and 2x this interval. For example, with
+	 * DIDTTO=3, expiration interval is between 16K and 32K. */
+	cvmmemctl.s.didtto = 0;
+	/* R/W If set, the (mem) CSR clock never turns off. */
+	cvmmemctl.s.csrckalwys = 0;
+	/* R/W If set, mclk never turns off. */
+	cvmmemctl.s.mclkalwys = 0;
+	/* R/W Selects the bit in the counter used for write buffer
+	 * flush time-outs (WBFLT+11) is the bit position in an
+	 * internal counter used to determine expiration. The write
+	 * buffer expires between 1x and 2x this interval. For
+	 * example, with WBFLT = 0, a write buffer expires between 2K
+	 * and 4K cycles after the write buffer entry is allocated. */
+	cvmmemctl.s.wbfltime = 0;
+	/* R/W If set, do not put Istream in the L2 cache. */
+	cvmmemctl.s.istrnol2 = 0;
+	/* R/W The write buffer threshold. */
+	cvmmemctl.s.wbthresh = 10;
+	/* R/W If set, CVMSEG is available for loads/stores in
+	 * kernel/debug mode. */
+#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
+	cvmmemctl.s.cvmsegenak = 1;
+#else
+	cvmmemctl.s.cvmsegenak = 0;
+#endif
+	/* R/W If set, CVMSEG is available for loads/stores in
+	 * supervisor mode. */
+	cvmmemctl.s.cvmsegenas = 0;
+	/* R/W If set, CVMSEG is available for loads/stores in user
+	 * mode. */
+	cvmmemctl.s.cvmsegenau = 0;
+	/* R/W Size of local memory in cache blocks, 54 (6912 bytes)
+	 * is max legal value. */
+	cvmmemctl.s.lmemsz = CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE;
+
+
+	if (smp_processor_id() == 0)
+		pr_notice("CVMSEG size: %d cache lines (%d bytes)\n",
+			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE,
+			  CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128);
+
+	write_c0_cvmmemctl(cvmmemctl.u64);
+
+	/* Move the performance counter interrupts to IRQ 6 */
+	cvmctl = read_c0_cvmctl();
+	cvmctl &= ~(7 << 7);
+	cvmctl |= 6 << 7;
+	write_c0_cvmctl(cvmctl);
+
+	/* Set a default for the hardware timeouts */
+	fau_timeout.u64 = 0;
+	fau_timeout.s.tout_val = 0xfff;
+	/* Disable tagwait FAU timeout */
+	fau_timeout.s.tout_enb = 0;
+	cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_timeout.u64);
+
+	nm_tim.u64 = 0;
+	/* 4096 cycles */
+	nm_tim.s.nw_tim = 3;
+	cvmx_write_csr(CVMX_POW_NW_TIM, nm_tim.u64);
+
+	write_octeon_c0_icacheerr(0);
+	write_c0_derraddr1(0);
+}
+
+/**
+ * Early entry point for arch setup
+ */
+void __init prom_init(void)
+{
+	struct cvmx_sysinfo *sysinfo;
+	const int coreid = cvmx_get_core_num();
+	int i;
+	int argc;
+	struct uart_port octeon_port;
+#ifdef CONFIG_CAVIUM_RESERVE32
+	int64_t addr = -1;
+#endif
+	/*
+	 * The bootloader passes a pointer to the boot descriptor in
+	 * $a3, this is available as fw_arg3.
+	 */
+	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)fw_arg3;
+	octeon_bootinfo =
+		cvmx_phys_to_ptr(octeon_boot_desc_ptr->cvmx_desc_vaddr);
+	cvmx_bootmem_init(cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr));
+
+	/*
+	 * Only enable the LED controller if we're running on a CN38XX, CN58XX,
+	 * or CN56XX. The CN30XX and CN31XX don't have an LED controller.
+	 */
+	if (!octeon_is_simulation() &&
+	    octeon_has_feature(OCTEON_FEATURE_LED_CONTROLLER)) {
+		cvmx_write_csr(CVMX_LED_EN, 0);
+		cvmx_write_csr(CVMX_LED_PRT, 0);
+		cvmx_write_csr(CVMX_LED_DBG, 0);
+		cvmx_write_csr(CVMX_LED_PRT_FMT, 0);
+		cvmx_write_csr(CVMX_LED_UDD_CNTX(0), 32);
+		cvmx_write_csr(CVMX_LED_UDD_CNTX(1), 32);
+		cvmx_write_csr(CVMX_LED_UDD_DATX(0), 0);
+		cvmx_write_csr(CVMX_LED_UDD_DATX(1), 0);
+		cvmx_write_csr(CVMX_LED_EN, 1);
+	}
+#ifdef CONFIG_CAVIUM_RESERVE32
+	/*
+	 * We need to temporarily allocate all memory in the reserve32
+	 * region. This makes sure the kernel doesn't allocate this
+	 * memory when it is getting memory from the
+	 * bootloader. Later, after the memory allocations are
+	 * complete, the reserve32 will be freed.
+	 */
+#ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
+	if (CONFIG_CAVIUM_RESERVE32 & 0x1ff)
+		pr_err("CAVIUM_RESERVE32 isn't a multiple of 512MB. "
+		       "This is required if CAVIUM_RESERVE32_USE_WIRED_TLB "
+		       "is set\n");
+	else
+		addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
+							0, 0, 512 << 20,
+							"CAVIUM_RESERVE32", 0);
+#else
+	/*
+	 * Allocate memory for RESERVED32 aligned on 2MB boundary. This
+	 * is in case we later use hugetlb entries with it.
+	 */
+	addr = cvmx_bootmem_phy_named_block_alloc(CONFIG_CAVIUM_RESERVE32 << 20,
+						0, 0, 2 << 20,
+						"CAVIUM_RESERVE32", 0);
+#endif
+	if (addr < 0)
+		pr_err("Failed to allocate CAVIUM_RESERVE32 memory area\n");
+	else
+		octeon_reserve32_memory = addr;
+#endif
+
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2
+	if (cvmx_read_csr(CVMX_L2D_FUS3) & (3ull << 34)) {
+		pr_info("Skipping L2 locking due to reduced L2 cache size\n");
+	} else {
+		uint32_t ebase = read_c0_ebase() & 0x3ffff000;
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_TLB
+		/* TLB refill */
+		cvmx_l2c_lock_mem_region(ebase, 0x100);
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_EXCEPTION
+		/* General exception */
+		cvmx_l2c_lock_mem_region(ebase + 0x180, 0x80);
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_LOW_LEVEL_INTERRUPT
+		/* Interrupt handler */
+		cvmx_l2c_lock_mem_region(ebase + 0x200, 0x80);
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_INTERRUPT
+		cvmx_l2c_lock_mem_region(__pa_symbol(handle_int), 0x100);
+		cvmx_l2c_lock_mem_region(__pa_symbol(plat_irq_dispatch), 0x80);
+#endif
+#ifdef CONFIG_CAVIUM_OCTEON_LOCK_L2_MEMCPY
+		cvmx_l2c_lock_mem_region(__pa_symbol(memcpy), 0x480);
+#endif
+	}
+#endif
+
+	sysinfo = cvmx_sysinfo_get();
+	memset(sysinfo, 0, sizeof(*sysinfo));
+	sysinfo->system_dram_size = octeon_bootinfo->dram_size << 20;
+	sysinfo->phy_mem_desc_ptr =
+		cvmx_phys_to_ptr(octeon_bootinfo->phy_mem_desc_addr);
+	sysinfo->core_mask = octeon_bootinfo->core_mask;
+	sysinfo->exception_base_addr = octeon_bootinfo->exception_base_addr;
+	sysinfo->cpu_clock_hz = octeon_bootinfo->eclock_hz;
+	sysinfo->dram_data_rate_hz = octeon_bootinfo->dclock_hz * 2;
+	sysinfo->board_type = octeon_bootinfo->board_type;
+	sysinfo->board_rev_major = octeon_bootinfo->board_rev_major;
+	sysinfo->board_rev_minor = octeon_bootinfo->board_rev_minor;
+	memcpy(sysinfo->mac_addr_base, octeon_bootinfo->mac_addr_base,
+	       sizeof(sysinfo->mac_addr_base));
+	sysinfo->mac_addr_count = octeon_bootinfo->mac_addr_count;
+	memcpy(sysinfo->board_serial_number,
+	       octeon_bootinfo->board_serial_number,
+	       sizeof(sysinfo->board_serial_number));
+	sysinfo->compact_flash_common_base_addr =
+		octeon_bootinfo->compact_flash_common_base_addr;
+	sysinfo->compact_flash_attribute_base_addr =
+		octeon_bootinfo->compact_flash_attribute_base_addr;
+	sysinfo->led_display_base_addr = octeon_bootinfo->led_display_base_addr;
+	sysinfo->dfa_ref_clock_hz = octeon_bootinfo->dfa_ref_clock_hz;
+	sysinfo->bootloader_config_flags = octeon_bootinfo->config_flags;
+
+
+	octeon_check_cpu_bist();
+
+	octeon_uart = octeon_get_boot_uart();
+
+	/*
+	 * Disable All CIU Interrupts. The ones we need will be
+	 * enabled later.  Read the SUM register so we know the write
+	 * completed.
+	 */
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2 + 1)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2 + 1)), 0);
+	cvmx_read_csr(CVMX_CIU_INTX_SUM0((coreid * 2)));
+
+#ifdef CONFIG_SMP
+	octeon_write_lcd("LinuxSMP");
+#else
+	octeon_write_lcd("Linux");
+#endif
+
+#ifdef CONFIG_CAVIUM_GDB
+	/*
+	 * When debugging the linux kernel, force the cores to enter
+	 * the debug exception handler to break in.
+	 */
+	if (octeon_get_boot_debug_flag()) {
+		cvmx_write_csr(CVMX_CIU_DINT, 1 << cvmx_get_core_num());
+		cvmx_read_csr(CVMX_CIU_DINT);
+	}
+#endif
+
+	/*
+	 * BIST should always be enabled when doing a soft reset. L2
+	 * Cache locking for instance is not cleared unless BIST is
+	 * enabled.  Unfortunately due to a chip errata G-200 for
+	 * Cn38XX and CN31XX, BIST msut be disabled on these parts.
+	 */
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2) ||
+	    OCTEON_IS_MODEL(OCTEON_CN31XX))
+		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 0);
+	else
+		cvmx_write_csr(CVMX_CIU_SOFT_BIST, 1);
+
+	/* Default to 64MB in the simulator to speed things up */
+	if (octeon_is_simulation())
+		MAX_MEMORY = 64ull << 20;
+
+	arcs_cmdline[0] = 0;
+	argc = octeon_boot_desc_ptr->argc;
+	for (i = 0; i < argc; i++) {
+		const char *arg =
+			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
+		if ((strncmp(arg, "MEM=", 4) == 0) ||
+		    (strncmp(arg, "mem=", 4) == 0)) {
+			sscanf(arg + 4, "%llu", &MAX_MEMORY);
+			MAX_MEMORY <<= 20;
+			if (MAX_MEMORY == 0)
+				MAX_MEMORY = 32ull << 30;
+		} else if (strcmp(arg, "ecc_verbose") == 0) {
+#ifdef CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
+			__cvmx_interrupt_ecc_report_single_bit_errors = 1;
+			pr_notice("Reporting of single bit ECC errors is "
+				  "turned on\n");
+#endif
+		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
+			   sizeof(arcs_cmdline) - 1) {
+			strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, arg);
+		}
+	}
+
+	if (strstr(arcs_cmdline, "console=") == NULL) {
+#ifdef CONFIG_GDB_CONSOLE
+		strcat(arcs_cmdline, " console=gdb");
+#else
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+		strcat(arcs_cmdline, " console=ttyS0,115200");
+#else
+		if (octeon_uart == 1)
+			strcat(arcs_cmdline, " console=ttyS1,115200");
+		else
+			strcat(arcs_cmdline, " console=ttyS0,115200");
+#endif
+#endif
+	}
+
+	if (octeon_is_simulation()) {
+		/*
+		 * The simulator uses a mtdram device pre filled with
+		 * the filesystem. Also specify the calibration delay
+		 * to avoid calculating it every time.
+		 */
+		strcat(arcs_cmdline, " rw root=1f00"
+		       " lpj=60176 slram=root,0x40000000,+1073741824");
+	}
+
+	mips_hpt_frequency = octeon_get_clock_rate();
+
+	octeon_init_cvmcount();
+
+	_machine_restart = octeon_restart;
+	_machine_halt = octeon_halt;
+
+	memset(&octeon_port, 0, sizeof(octeon_port));
+	/*
+	 * For early_serial_setup we don't set the port type or
+	 * UPF_FIXED_TYPE.
+	 */
+	octeon_port.flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ;
+	octeon_port.iotype = UPIO_MEM;
+	/* I/O addresses are every 8 bytes */
+	octeon_port.regshift = 3;
+	/* Clock rate of the chip */
+	octeon_port.uartclk = mips_hpt_frequency;
+	octeon_port.fifosize = 64;
+	octeon_port.mapbase = 0x0001180000000800ull + (1024 * octeon_uart);
+	octeon_port.membase = cvmx_phys_to_ptr(octeon_port.mapbase);
+	octeon_port.serial_in = octeon_serial_in;
+	octeon_port.serial_out = octeon_serial_out;
+#ifdef CONFIG_CAVIUM_OCTEON_2ND_KERNEL
+	octeon_port.line = 0;
+#else
+	octeon_port.line = octeon_uart;
+#endif
+	octeon_port.irq = 42 + octeon_uart;
+	early_serial_setup(&octeon_port);
+
+	octeon_user_io_init();
+	register_smp_ops(&octeon_smp_ops);
+}
+
+void __init plat_mem_setup(void)
+{
+	uint64_t mem_alloc_size;
+	uint64_t total;
+	int64_t memory;
+
+	total = 0;
+
+	/* First add the init memory we will be returning.  */
+	memory = __pa_symbol(&__init_begin) & PAGE_MASK;
+	mem_alloc_size = (__pa_symbol(&__init_end) & PAGE_MASK) - memory;
+	if (mem_alloc_size > 0) {
+		add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+		total += mem_alloc_size;
+	}
+
+	/*
+	 * The Mips memory init uses the first memory location for
+	 * some memory vectors. When SPARSEMEM is in use, it doesn't
+	 * verify that the size is big enough for the final
+	 * vectors. Making the smallest chuck 4MB seems to be enough
+	 * to consistantly work.
+	 */
+	mem_alloc_size = 4 << 20;
+	if (mem_alloc_size > MAX_MEMORY)
+		mem_alloc_size = MAX_MEMORY;
+
+	/*
+	 * When allocating memory, we want incrementing addresses from
+	 * bootmem_alloc so the code in add_memory_region can merge
+	 * regions next to each other.
+	 */
+	cvmx_bootmem_lock();
+	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
+		&& (total < MAX_MEMORY)) {
+#if defined(CONFIG_64BIT) || defined(CONFIG_64BIT_PHYS_ADDR)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
+						__pa_symbol(&__init_end), -1,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#elif defined(CONFIG_HIGHMEM)
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 1ull << 31,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#else
+		memory = cvmx_bootmem_phy_alloc(mem_alloc_size, 0, 512 << 20,
+						0x100000,
+						CVMX_BOOTMEM_FLAG_NO_LOCKING);
+#endif
+		if (memory >= 0) {
+			/*
+			 * This function automatically merges address
+			 * regions next to each other if they are
+			 * received in incrementing order.
+			 */
+			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			total += mem_alloc_size;
+		} else {
+			break;
+		}
+	}
+	cvmx_bootmem_unlock();
+
+#ifdef CONFIG_CAVIUM_RESERVE32
+	/*
+	 * Now that we've allocated the kernel memory it is safe to
+	 * free the reserved region. We free it here so that builtin
+	 * drivers can use the memory.
+	 */
+	if (octeon_reserve32_memory)
+		cvmx_bootmem_free_named("CAVIUM_RESERVE32");
+#endif /* CONFIG_CAVIUM_RESERVE32 */
+
+	if (total == 0)
+		panic("Unable to allocate memory from "
+		      "cvmx_bootmem_phy_alloc\n");
+}
+
+
+int prom_putchar(char c)
+{
+	uint64_t lsrval;
+
+	/* Spin until there is room */
+	do {
+		lsrval = cvmx_read_csr(CVMX_MIO_UARTX_LSR(octeon_uart));
+	} while ((lsrval & 0x20) == 0);
+
+	/* Write the byte */
+	cvmx_write_csr(CVMX_MIO_UARTX_THR(octeon_uart), c);
+	return 1;
+}
+
+void prom_free_prom_memory(void)
+{
+#ifdef CONFIG_CAVIUM_DECODE_RSL
+	cvmx_interrupt_rsl_enable();
+
+	/* Add an interrupt handler for general failures. */
+	if (request_irq(OCTEON_IRQ_RML, octeon_rlm_interrupt, IRQF_SHARED,
+			"RML/RSL", octeon_rlm_interrupt)) {
+		panic("Unable to request_irq(OCTEON_IRQ_RML)\n");
+	}
+#endif
+
+	/* This call is here so that it is performed after any TLB
+	   initializations. It needs to be after these in case the
+	   CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB option is set */
+	octeon_hal_setup_reserved32();
+}
+
+static struct octeon_cf_data octeon_cf_data;
+
+static int __init octeon_cf_device_init(void)
+{
+	union cvmx_mio_boot_reg_cfgx mio_boot_reg_cfg;
+	unsigned long base_ptr, region_base, region_size;
+	struct platform_device *pd;
+	struct resource cf_resources[3];
+	unsigned int num_resources;
+	int i;
+	int ret = 0;
+
+	/* Setup octeon-cf platform device if present. */
+	base_ptr = 0;
+	if (octeon_bootinfo->major_version == 1
+		&& octeon_bootinfo->minor_version >= 1) {
+		if (octeon_bootinfo->compact_flash_common_base_addr)
+			base_ptr =
+				octeon_bootinfo->compact_flash_common_base_addr;
+	} else {
+		base_ptr = 0x1d000800;
+	}
+
+	if (!base_ptr)
+		return ret;
+
+	/* Find CS0 region. */
+	for (i = 0; i < 8; i++) {
+		mio_boot_reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i));
+		region_base = mio_boot_reg_cfg.s.base << 16;
+		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
+		if (mio_boot_reg_cfg.s.en && base_ptr >= region_base
+		    && base_ptr < region_base + region_size)
+			break;
+	}
+	if (i >= 7) {
+		/* i and i + 1 are CS0 and CS1, both must be less than 8. */
+		goto out;
+	}
+	octeon_cf_data.base_region = i;
+	octeon_cf_data.is16bit = mio_boot_reg_cfg.s.width;
+	octeon_cf_data.base_region_bias = base_ptr - region_base;
+	memset(cf_resources, 0, sizeof(cf_resources));
+	num_resources = 0;
+	cf_resources[num_resources].flags	= IORESOURCE_MEM;
+	cf_resources[num_resources].start	= region_base;
+	cf_resources[num_resources].end	= region_base + region_size - 1;
+	num_resources++;
+
+
+	if (!(base_ptr & 0xfffful)) {
+		/*
+		 * Boot loader signals availability of DMA (true_ide
+		 * mode) by setting low order bits of base_ptr to
+		 * zero.
+		 */
+
+		/* Asume that CS1 immediately follows. */
+		mio_boot_reg_cfg.u64 =
+			cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(i + 1));
+		region_base = mio_boot_reg_cfg.s.base << 16;
+		region_size = (mio_boot_reg_cfg.s.size + 1) << 16;
+		if (!mio_boot_reg_cfg.s.en)
+			goto out;
+
+		cf_resources[num_resources].flags	= IORESOURCE_MEM;
+		cf_resources[num_resources].start	= region_base;
+		cf_resources[num_resources].end	= region_base + region_size - 1;
+		num_resources++;
+
+		octeon_cf_data.dma_engine = 0;
+		cf_resources[num_resources].flags	= IORESOURCE_IRQ;
+		cf_resources[num_resources].start	= OCTEON_IRQ_BOOTDMA;
+		cf_resources[num_resources].end	= OCTEON_IRQ_BOOTDMA;
+		num_resources++;
+	} else {
+		octeon_cf_data.dma_engine = -1;
+	}
+
+	pd = platform_device_alloc("pata_octeon_cf", -1);
+	if (!pd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pd->dev.platform_data = &octeon_cf_data;
+
+	ret = platform_device_add_resources(pd, cf_resources, num_resources);
+	if (ret)
+		goto fail;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		goto fail;
+
+	return ret;
+fail:
+	platform_device_put(pd);
+out:
+	return ret;
+}
+device_initcall(octeon_cf_device_init);
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
new file mode 100644
index 0000000..4eb93f1
--- /dev/null
+++ b/arch/mips/cavium-octeon/smp.c
@@ -0,0 +1,211 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+#include <asm/mmu_context.h>
+#include <asm/system.h>
+#include <asm/time.h>
+
+#include <asm/octeon/octeon.h>
+
+volatile unsigned long octeon_processor_boot = 0xff;
+volatile unsigned long octeon_processor_sp;
+volatile unsigned long octeon_processor_gp;
+
+static irqreturn_t mailbox_interrupt(int irq, void *dev_id)
+{
+	const int coreid = cvmx_get_core_num();
+	uint64_t action;
+
+	/* Load the mailbox register to figure out what we're supposed to do */
+	action = cvmx_read_csr(CVMX_CIU_MBOX_CLRX(coreid));
+
+	/* Clear the mailbox to clear the interrupt */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), action);
+
+	if (action & SMP_CALL_FUNCTION)
+		smp_call_function_interrupt();
+
+	/* Check if we've been told to flush the icache */
+	if (action & SMP_ICACHE_FLUSH)
+		asm volatile ("synci 0($0)\n");
+	return IRQ_HANDLED;
+}
+
+/**
+ * Cause the function described by call_data to be executed on the passed
+ * cpu.  When the function has finished, increment the finished field of
+ * call_data.
+ */
+void octeon_send_ipi_single(int cpu, unsigned int action)
+{
+	int coreid = cpu_logical_map(cpu);
+	/*
+	pr_info("SMP: Mailbox send cpu=%d, coreid=%d, action=%u\n", cpu,
+	       coreid, action);
+	*/
+	cvmx_write_csr(CVMX_CIU_MBOX_SETX(coreid), action);
+}
+
+static inline void octeon_send_ipi_mask(cpumask_t mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu_mask(i, mask)
+		octeon_send_ipi_single(i, action);
+}
+
+/**
+ * Detect available CPUs, populate phys_cpu_present_map
+ */
+static void octeon_smp_setup(void)
+{
+	const int coreid = cvmx_get_core_num();
+	int cpus;
+	int id;
+
+	int core_mask = octeon_get_boot_coremask();
+
+	cpus_clear(phys_cpu_present_map);
+	__cpu_number_map[coreid] = 0;
+	__cpu_logical_map[0] = coreid;
+	cpu_set(0, phys_cpu_present_map);
+
+	cpus = 1;
+	for (id = 0; id < 16; id++) {
+		if ((id != coreid) && (core_mask & (1 << id))) {
+			cpu_set(cpus, phys_cpu_present_map);
+			__cpu_number_map[id] = cpus;
+			__cpu_logical_map[cpus] = id;
+			cpus++;
+		}
+	}
+}
+
+/**
+ * Firmware CPU startup hook
+ *
+ */
+static void octeon_boot_secondary(int cpu, struct task_struct *idle)
+{
+	int count;
+
+	pr_info("SMP: Booting CPU%02d (CoreId %2d)...\n", cpu,
+		cpu_logical_map(cpu));
+
+	octeon_processor_sp = __KSTK_TOS(idle);
+	octeon_processor_gp = (unsigned long)(task_thread_info(idle));
+	octeon_processor_boot = cpu_logical_map(cpu);
+	mb();
+
+	count = 10000;
+	while (octeon_processor_sp && count) {
+		/* Waiting for processor to get the SP and GP */
+		udelay(1);
+		count--;
+	}
+	if (count == 0)
+		pr_err("Secondary boot timeout\n");
+}
+
+/**
+ * After we've done initial boot, this function is called to allow the
+ * board code to clean up state, if needed
+ */
+static void octeon_init_secondary(void)
+{
+	const int coreid = cvmx_get_core_num();
+	union cvmx_ciu_intx_sum0 interrupt_enable;
+
+	octeon_check_cpu_bist();
+	octeon_init_cvmcount();
+	/*
+	pr_info("SMP: CPU%d (CoreId %lu) started\n", cpu, coreid);
+	*/
+	/* Enable Mailbox interrupts to this core. These are the only
+	   interrupts allowed on line 3 */
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(coreid), 0xffffffff);
+	interrupt_enable.u64 = 0;
+	interrupt_enable.s.mbox = 0x3;
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2)), interrupt_enable.u64);
+	cvmx_write_csr(CVMX_CIU_INTX_EN0((coreid * 2 + 1)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2)), 0);
+	cvmx_write_csr(CVMX_CIU_INTX_EN1((coreid * 2 + 1)), 0);
+	/* Enable core interrupt processing for 2,3 and 7 */
+	set_c0_status(0x8c01);
+}
+
+/**
+ * Callout to firmware before smp_init
+ *
+ */
+void octeon_prepare_cpus(unsigned int max_cpus)
+{
+	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
+	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_SHARED,
+			"mailbox0", mailbox_interrupt)) {
+		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
+	}
+	if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_SHARED,
+			"mailbox1", mailbox_interrupt)) {
+		panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
+	}
+}
+
+/**
+ * Last chance for the board code to finish SMP initialization before
+ * the CPU is "online".
+ */
+static void octeon_smp_finish(void)
+{
+#ifdef CONFIG_CAVIUM_GDB
+	unsigned long tmp;
+	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
+	   to be not masked by this core so we know the signal is received by
+	   someone */
+	asm volatile ("dmfc0 %0, $22\n"
+		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
+#endif
+
+	octeon_user_io_init();
+
+	/* to generate the first CPU timer interrupt */
+	write_c0_compare(read_c0_count() + mips_hpt_frequency / HZ);
+}
+
+/**
+ * Hook for after all CPUs are online
+ */
+static void octeon_cpus_done(void)
+{
+#ifdef CONFIG_CAVIUM_GDB
+	unsigned long tmp;
+	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
+	   to be not masked by this core so we know the signal is received by
+	   someone */
+	asm volatile ("dmfc0 %0, $22\n"
+		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
+#endif
+}
+
+struct plat_smp_ops octeon_smp_ops = {
+	.send_ipi_single	= octeon_send_ipi_single,
+	.send_ipi_mask		= octeon_send_ipi_mask,
+	.init_secondary		= octeon_init_secondary,
+	.smp_finish		= octeon_smp_finish,
+	.cpus_done		= octeon_cpus_done,
+	.boot_secondary		= octeon_boot_secondary,
+	.smp_setup		= octeon_smp_setup,
+	.prepare_cpus		= octeon_prepare_cpus,
+};
diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
new file mode 100644
index 0000000..04ce6e6
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -0,0 +1,78 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004 Cavium Networks
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_CAVIUM_OCTEON_CPU_FEATURE_OVERRIDES_H
+
+#include <linux/types.h>
+#include <asm/mipsregs.h>
+
+/*
+ * Cavium Octeons are MIPS64v2 processors
+ */
+#define cpu_dcache_line_size()	128
+#define cpu_icache_line_size()	128
+
+
+#define cpu_has_4kex		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	0
+#define cpu_has_tx39_cache	0
+#define cpu_has_fpu		0
+#define cpu_has_counter		1
+#define cpu_has_watch		1
+#define cpu_has_divec		1
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+
+/*
+ * We should disable LL/SC on non SMP systems as it is faster to
+ * disable interrupts for atomic access than a LL/SC.  Unfortunatly we
+ * cannot as this breaks asm/futex.h
+ */
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	1
+#define cpu_has_dc_aliases	0
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_64bits		1
+#define cpu_has_octeon_cache	1
+#define cpu_has_saa		octeon_has_saa()
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	1
+#define cpu_has_dsp		0
+#define cpu_has_mipsmt		0
+#define cpu_has_userlocal	0
+#define cpu_has_vint		0
+#define cpu_has_veic		0
+#define ARCH_HAS_READ_CURRENT_TIMER 1
+#define ARCH_HAS_IRQ_PER_CPU	1
+#define ARCH_HAS_SPINLOCK_PREFETCH 1
+#define spin_lock_prefetch(x) prefetch(x)
+#define PREFETCH_STRIDE 128
+
+static inline int read_current_timer(unsigned long *result)
+{
+	asm volatile ("rdhwr %0,$31\n"
+#ifndef CONFIG_64BIT
+		      "\tsll %0, 0"
+#endif
+		      : "=r" (*result));
+	return 0;
+}
+
+static inline int octeon_has_saa(void)
+{
+	int id;
+	asm volatile ("mfc0 %0, $15,0" : "=r" (id));
+	return id >= 0x000d0300;
+}
+
+#endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
new file mode 100644
index 0000000..f30fce9
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -0,0 +1,64 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ *
+ * Similar to mach-generic/dma-coherence.h except
+ * plat_device_is_coherent hard coded to return 1.
+ *
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
+#define __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
+
+struct device;
+
+dma_addr_t octeon_map_dma_mem(struct device *, void *, size_t);
+void octeon_unmap_dma_mem(struct device *, dma_addr_t);
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+	size_t size)
+{
+	return octeon_map_dma_mem(dev, addr, size);
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+	struct page *page)
+{
+	return octeon_map_dma_mem(dev, page_address(page), PAGE_SIZE);
+}
+
+static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return dma_addr;
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+{
+	octeon_unmap_dma_mem(dev, dma_addr);
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	mb();
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 1;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return dma_addr == -1;
+}
+
+#endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
new file mode 100644
index 0000000..d32220f
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
@@ -0,0 +1,244 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#ifndef __OCTEON_IRQ_H__
+#define __OCTEON_IRQ_H__
+
+#define NR_IRQS OCTEON_IRQ_LAST
+#define MIPS_CPU_IRQ_BASE OCTEON_IRQ_SW0
+
+/* 0 - 7 represent the i8259 master */
+#define OCTEON_IRQ_I8259M0	0
+#define OCTEON_IRQ_I8259M1	1
+#define OCTEON_IRQ_I8259M2	2
+#define OCTEON_IRQ_I8259M3	3
+#define OCTEON_IRQ_I8259M4	4
+#define OCTEON_IRQ_I8259M5	5
+#define OCTEON_IRQ_I8259M6	6
+#define OCTEON_IRQ_I8259M7	7
+/* 8 - 15 represent the i8259 slave */
+#define OCTEON_IRQ_I8259S0	8
+#define OCTEON_IRQ_I8259S1	9
+#define OCTEON_IRQ_I8259S2	10
+#define OCTEON_IRQ_I8259S3	11
+#define OCTEON_IRQ_I8259S4	12
+#define OCTEON_IRQ_I8259S5	13
+#define OCTEON_IRQ_I8259S6	14
+#define OCTEON_IRQ_I8259S7	15
+/* 16 - 23 represent the 8 MIPS standard interrupt sources */
+#define OCTEON_IRQ_SW0		16
+#define OCTEON_IRQ_SW1		17
+#define OCTEON_IRQ_CIU0		18
+#define OCTEON_IRQ_CIU1		19
+#define OCTEON_IRQ_CIU4		20
+#define OCTEON_IRQ_5		21
+#define OCTEON_IRQ_PERF		22
+#define OCTEON_IRQ_TIMER	23
+/* 24 - 87 represent the sources in CIU_INTX_EN0 */
+#define OCTEON_IRQ_WORKQ0	24
+#define OCTEON_IRQ_WORKQ1	25
+#define OCTEON_IRQ_WORKQ2	26
+#define OCTEON_IRQ_WORKQ3	27
+#define OCTEON_IRQ_WORKQ4	28
+#define OCTEON_IRQ_WORKQ5	29
+#define OCTEON_IRQ_WORKQ6	30
+#define OCTEON_IRQ_WORKQ7	31
+#define OCTEON_IRQ_WORKQ8	32
+#define OCTEON_IRQ_WORKQ9	33
+#define OCTEON_IRQ_WORKQ10	34
+#define OCTEON_IRQ_WORKQ11	35
+#define OCTEON_IRQ_WORKQ12	36
+#define OCTEON_IRQ_WORKQ13	37
+#define OCTEON_IRQ_WORKQ14	38
+#define OCTEON_IRQ_WORKQ15	39
+#define OCTEON_IRQ_GPIO0	40
+#define OCTEON_IRQ_GPIO1	41
+#define OCTEON_IRQ_GPIO2	42
+#define OCTEON_IRQ_GPIO3	43
+#define OCTEON_IRQ_GPIO4	44
+#define OCTEON_IRQ_GPIO5	45
+#define OCTEON_IRQ_GPIO6	46
+#define OCTEON_IRQ_GPIO7	47
+#define OCTEON_IRQ_GPIO8	48
+#define OCTEON_IRQ_GPIO9	49
+#define OCTEON_IRQ_GPIO10	50
+#define OCTEON_IRQ_GPIO11	51
+#define OCTEON_IRQ_GPIO12	52
+#define OCTEON_IRQ_GPIO13	53
+#define OCTEON_IRQ_GPIO14	54
+#define OCTEON_IRQ_GPIO15	55
+#define OCTEON_IRQ_MBOX0	56
+#define OCTEON_IRQ_MBOX1	57
+#define OCTEON_IRQ_UART0	58
+#define OCTEON_IRQ_UART1	59
+#define OCTEON_IRQ_PCI_INT0	60
+#define OCTEON_IRQ_PCI_INT1	61
+#define OCTEON_IRQ_PCI_INT2	62
+#define OCTEON_IRQ_PCI_INT3	63
+#define OCTEON_IRQ_PCI_MSI0	64
+#define OCTEON_IRQ_PCI_MSI1	65
+#define OCTEON_IRQ_PCI_MSI2	66
+#define OCTEON_IRQ_PCI_MSI3	67
+#define OCTEON_IRQ_RESERVED68	68	/* Summary of CIU_INT_SUM1 */
+#define OCTEON_IRQ_TWSI		69
+#define OCTEON_IRQ_RML		70
+#define OCTEON_IRQ_TRACE	71
+#define OCTEON_IRQ_GMX_DRP0	72
+#define OCTEON_IRQ_GMX_DRP1	73
+#define OCTEON_IRQ_IPD_DRP	74
+#define OCTEON_IRQ_KEY_ZERO	75
+#define OCTEON_IRQ_TIMER0	76
+#define OCTEON_IRQ_TIMER1	77
+#define OCTEON_IRQ_TIMER2	78
+#define OCTEON_IRQ_TIMER3	79
+#define OCTEON_IRQ_USB0		80
+#define OCTEON_IRQ_PCM		81
+#define OCTEON_IRQ_MPI		82
+#define OCTEON_IRQ_TWSI2	83
+#define OCTEON_IRQ_POWIQ	84
+#define OCTEON_IRQ_IPDPPTHR	85
+#define OCTEON_IRQ_MII0		86
+#define OCTEON_IRQ_BOOTDMA	87
+/* 88 - 151 represent the sources in CIU_INTX_EN1 */
+#define OCTEON_IRQ_WDOG0	88
+#define OCTEON_IRQ_WDOG1	89
+#define OCTEON_IRQ_WDOG2	90
+#define OCTEON_IRQ_WDOG3	91
+#define OCTEON_IRQ_WDOG4	92
+#define OCTEON_IRQ_WDOG5	93
+#define OCTEON_IRQ_WDOG6	94
+#define OCTEON_IRQ_WDOG7	95
+#define OCTEON_IRQ_WDOG8	96
+#define OCTEON_IRQ_WDOG9	97
+#define OCTEON_IRQ_WDOG10	98
+#define OCTEON_IRQ_WDOG11	99
+#define OCTEON_IRQ_WDOG12	100
+#define OCTEON_IRQ_WDOG13	101
+#define OCTEON_IRQ_WDOG14	102
+#define OCTEON_IRQ_WDOG15	103
+#define OCTEON_IRQ_UART2	104
+#define OCTEON_IRQ_USB1		105
+#define OCTEON_IRQ_MII1		106
+#define OCTEON_IRQ_RESERVED107	107
+#define OCTEON_IRQ_RESERVED108	108
+#define OCTEON_IRQ_RESERVED109	109
+#define OCTEON_IRQ_RESERVED110	110
+#define OCTEON_IRQ_RESERVED111	111
+#define OCTEON_IRQ_RESERVED112	112
+#define OCTEON_IRQ_RESERVED113	113
+#define OCTEON_IRQ_RESERVED114	114
+#define OCTEON_IRQ_RESERVED115	115
+#define OCTEON_IRQ_RESERVED116	116
+#define OCTEON_IRQ_RESERVED117	117
+#define OCTEON_IRQ_RESERVED118	118
+#define OCTEON_IRQ_RESERVED119	119
+#define OCTEON_IRQ_RESERVED120	120
+#define OCTEON_IRQ_RESERVED121	121
+#define OCTEON_IRQ_RESERVED122	122
+#define OCTEON_IRQ_RESERVED123	123
+#define OCTEON_IRQ_RESERVED124	124
+#define OCTEON_IRQ_RESERVED125	125
+#define OCTEON_IRQ_RESERVED126	126
+#define OCTEON_IRQ_RESERVED127	127
+#define OCTEON_IRQ_RESERVED128	128
+#define OCTEON_IRQ_RESERVED129	129
+#define OCTEON_IRQ_RESERVED130	130
+#define OCTEON_IRQ_RESERVED131	131
+#define OCTEON_IRQ_RESERVED132	132
+#define OCTEON_IRQ_RESERVED133	133
+#define OCTEON_IRQ_RESERVED134	134
+#define OCTEON_IRQ_RESERVED135	135
+#define OCTEON_IRQ_RESERVED136	136
+#define OCTEON_IRQ_RESERVED137	137
+#define OCTEON_IRQ_RESERVED138	138
+#define OCTEON_IRQ_RESERVED139	139
+#define OCTEON_IRQ_RESERVED140	140
+#define OCTEON_IRQ_RESERVED141	141
+#define OCTEON_IRQ_RESERVED142	142
+#define OCTEON_IRQ_RESERVED143	143
+#define OCTEON_IRQ_RESERVED144	144
+#define OCTEON_IRQ_RESERVED145	145
+#define OCTEON_IRQ_RESERVED146	146
+#define OCTEON_IRQ_RESERVED147	147
+#define OCTEON_IRQ_RESERVED148	148
+#define OCTEON_IRQ_RESERVED149	149
+#define OCTEON_IRQ_RESERVED150	150
+#define OCTEON_IRQ_RESERVED151	151
+
+#ifdef CONFIG_PCI_MSI
+/* 152 - 215 represent the MSI interrupts 0-63 */
+#define OCTEON_IRQ_MSI_BIT0	152
+#define OCTEON_IRQ_MSI_BIT1	153
+#define OCTEON_IRQ_MSI_BIT2	154
+#define OCTEON_IRQ_MSI_BIT3	155
+#define OCTEON_IRQ_MSI_BIT4	156
+#define OCTEON_IRQ_MSI_BIT5	157
+#define OCTEON_IRQ_MSI_BIT6	158
+#define OCTEON_IRQ_MSI_BIT7	159
+#define OCTEON_IRQ_MSI_BIT8	160
+#define OCTEON_IRQ_MSI_BIT9	161
+#define OCTEON_IRQ_MSI_BIT10	162
+#define OCTEON_IRQ_MSI_BIT11	163
+#define OCTEON_IRQ_MSI_BIT12	164
+#define OCTEON_IRQ_MSI_BIT13	165
+#define OCTEON_IRQ_MSI_BIT14	166
+#define OCTEON_IRQ_MSI_BIT15	167
+#define OCTEON_IRQ_MSI_BIT16	168
+#define OCTEON_IRQ_MSI_BIT17	169
+#define OCTEON_IRQ_MSI_BIT18	170
+#define OCTEON_IRQ_MSI_BIT19	171
+#define OCTEON_IRQ_MSI_BIT20	172
+#define OCTEON_IRQ_MSI_BIT21	173
+#define OCTEON_IRQ_MSI_BIT22	174
+#define OCTEON_IRQ_MSI_BIT23	175
+#define OCTEON_IRQ_MSI_BIT24	176
+#define OCTEON_IRQ_MSI_BIT25	177
+#define OCTEON_IRQ_MSI_BIT26	178
+#define OCTEON_IRQ_MSI_BIT27	179
+#define OCTEON_IRQ_MSI_BIT28	180
+#define OCTEON_IRQ_MSI_BIT29	181
+#define OCTEON_IRQ_MSI_BIT30	182
+#define OCTEON_IRQ_MSI_BIT31	183
+#define OCTEON_IRQ_MSI_BIT32	184
+#define OCTEON_IRQ_MSI_BIT33	185
+#define OCTEON_IRQ_MSI_BIT34	186
+#define OCTEON_IRQ_MSI_BIT35	187
+#define OCTEON_IRQ_MSI_BIT36	188
+#define OCTEON_IRQ_MSI_BIT37	189
+#define OCTEON_IRQ_MSI_BIT38	190
+#define OCTEON_IRQ_MSI_BIT39	191
+#define OCTEON_IRQ_MSI_BIT40	192
+#define OCTEON_IRQ_MSI_BIT41	193
+#define OCTEON_IRQ_MSI_BIT42	194
+#define OCTEON_IRQ_MSI_BIT43	195
+#define OCTEON_IRQ_MSI_BIT44	196
+#define OCTEON_IRQ_MSI_BIT45	197
+#define OCTEON_IRQ_MSI_BIT46	198
+#define OCTEON_IRQ_MSI_BIT47	199
+#define OCTEON_IRQ_MSI_BIT48	200
+#define OCTEON_IRQ_MSI_BIT49	201
+#define OCTEON_IRQ_MSI_BIT50	202
+#define OCTEON_IRQ_MSI_BIT51	203
+#define OCTEON_IRQ_MSI_BIT52	204
+#define OCTEON_IRQ_MSI_BIT53	205
+#define OCTEON_IRQ_MSI_BIT54	206
+#define OCTEON_IRQ_MSI_BIT55	207
+#define OCTEON_IRQ_MSI_BIT56	208
+#define OCTEON_IRQ_MSI_BIT57	209
+#define OCTEON_IRQ_MSI_BIT58	210
+#define OCTEON_IRQ_MSI_BIT59	211
+#define OCTEON_IRQ_MSI_BIT60	212
+#define OCTEON_IRQ_MSI_BIT61	213
+#define OCTEON_IRQ_MSI_BIT62	214
+#define OCTEON_IRQ_MSI_BIT63	215
+
+#define OCTEON_IRQ_LAST         216
+#else
+#define OCTEON_IRQ_LAST         152
+#endif
+
+#endif
diff --git a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
new file mode 100644
index 0000000..0b2b5eb
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
@@ -0,0 +1,131 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2008 Cavium Networks, Inc
+ */
+#ifndef __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
+#define __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H
+
+
+#define CP0_CYCLE_COUNTER $9, 6
+#define CP0_CVMCTL_REG $9, 7
+#define CP0_CVMMEMCTL_REG $11,7
+#define CP0_PRID_REG $15, 0
+#define CP0_PRID_OCTEON_PASS1 0x000d0000
+#define CP0_PRID_OCTEON_CN30XX 0x000d0200
+
+.macro  kernel_entry_setup
+	# Registers set by bootloader:
+	# (only 32 bits set by bootloader, all addresses are physical
+	# addresses, and need to have the appropriate memory region set
+	# by the kernel
+	# a0 = argc
+	# a1 = argv (kseg0 compat addr)
+	# a2 = 1 if init core, zero otherwise
+	# a3 = address of boot descriptor block
+	.set push
+	.set arch=octeon
+	# Read the cavium mem control register
+	dmfc0   v0, CP0_CVMMEMCTL_REG
+	# Clear the lower 6 bits, the CVMSEG size
+	dins    v0, $0, 0, 6
+	ori     v0, CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE
+	dmtc0   v0, CP0_CVMMEMCTL_REG	# Write the cavium mem control register
+	dmfc0   v0, CP0_CVMCTL_REG	# Read the cavium control register
+#ifdef CONFIG_CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	# Disable unaligned load/store support but leave HW fixup enabled
+	or  v0, v0, 0x5001
+	xor v0, v0, 0x1001
+#else
+	# Disable unaligned load/store and HW fixup support
+	or  v0, v0, 0x5001
+	xor v0, v0, 0x5001
+#endif
+	# Read the processor ID register
+	mfc0 v1, CP0_PRID_REG
+	# Disable instruction prefetching (Octeon Pass1 errata)
+	or  v0, v0, 0x2000
+	# Skip reenable of prefetching for Octeon Pass1
+	beq v1, CP0_PRID_OCTEON_PASS1, skip
+	nop
+	# Reenable instruction prefetching, not on Pass1
+	xor v0, v0, 0x2000
+	# Strip off pass number off of processor id
+	srl v1, 8
+	sll v1, 8
+	# CN30XX needs some extra stuff turned off for better performance
+	bne v1, CP0_PRID_OCTEON_CN30XX, skip
+	nop
+	# CN30XX Use random Icache replacement
+	or  v0, v0, 0x400
+	# CN30XX Disable instruction prefetching
+	or  v0, v0, 0x2000
+skip:
+	# Write the cavium control register
+	dmtc0   v0, CP0_CVMCTL_REG
+	sync
+	# Flush dcache after config change
+	cache   9, 0($0)
+	# Get my core id
+	rdhwr   v0, $0
+	# Jump the master to kernel_entry
+	bne     a2, zero, octeon_main_processor
+	nop
+
+#ifdef CONFIG_SMP
+
+	#
+	# All cores other than the master need to wait here for SMP bootstrap
+	# to begin
+	#
+
+	# This is the variable where the next core to boot os stored
+	PTR_LA  t0, octeon_processor_boot
+octeon_spin_wait_boot:
+	# Get the core id of the next to be booted
+	LONG_L  t1, (t0)
+	# Keep looping if it isn't me
+	bne t1, v0, octeon_spin_wait_boot
+	nop
+	# Get my GP from the global variable
+	PTR_LA  t0, octeon_processor_gp
+	LONG_L  gp, (t0)
+	# Get my SP from the global variable
+	PTR_LA  t0, octeon_processor_sp
+	LONG_L  sp, (t0)
+	# Set the SP global variable to zero so the master knows we've started
+	LONG_S  zero, (t0)
+#ifdef __OCTEON__
+	syncw
+	syncw
+#else
+	sync
+#endif
+	# Jump to the normal Linux SMP entry point
+	j   smp_bootstrap
+	nop
+#else /* CONFIG_SMP */
+
+	#
+	# Someone tried to boot SMP with a non SMP kernel. All extra cores
+	# will halt here.
+	#
+octeon_wait_forever:
+	wait
+	b   octeon_wait_forever
+	nop
+
+#endif /* CONFIG_SMP */
+octeon_main_processor:
+	.set pop
+.endm
+
+/*
+ * Do SMP slave processor setup necessary before we can savely execute C code.
+ */
+	.macro  smp_slave_setup
+	.endm
+
+#endif /* __ASM_MACH_CAVIUM_OCTEON_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-cavium-octeon/war.h b/arch/mips/include/asm/mach-cavium-octeon/war.h
new file mode 100644
index 0000000..c4712d7
--- /dev/null
+++ b/arch/mips/include/asm/mach-cavium-octeon/war.h
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2008 Cavium Networks <support@caviumnetworks.com>
+ */
+#ifndef __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
+#define __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H
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
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_CAVIUM_OCTEON_WAR_H */
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
new file mode 100644
index 0000000..edc6760
--- /dev/null
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2008 Cavium Networks
+ */
+#ifndef __ASM_OCTEON_OCTEON_H
+#define __ASM_OCTEON_OCTEON_H
+
+#include "cvmx.h"
+
+extern uint64_t octeon_bootmem_alloc_range_phys(uint64_t size,
+						uint64_t alignment,
+						uint64_t min_addr,
+						uint64_t max_addr,
+						int do_locking);
+extern void *octeon_bootmem_alloc(uint64_t size, uint64_t alignment,
+				  int do_locking);
+extern void *octeon_bootmem_alloc_range(uint64_t size, uint64_t alignment,
+					uint64_t min_addr, uint64_t max_addr,
+					int do_locking);
+extern void *octeon_bootmem_alloc_named(uint64_t size, uint64_t alignment,
+					char *name);
+extern void *octeon_bootmem_alloc_named_range(uint64_t size, uint64_t min_addr,
+					      uint64_t max_addr, uint64_t align,
+					      char *name);
+extern void *octeon_bootmem_alloc_named_address(uint64_t size, uint64_t address,
+						char *name);
+extern int octeon_bootmem_free_named(char *name);
+extern void octeon_bootmem_lock(void);
+extern void octeon_bootmem_unlock(void);
+
+extern int octeon_is_simulation(void);
+extern int octeon_is_pci_host(void);
+extern int octeon_usb_is_ref_clk(void);
+extern uint64_t octeon_get_clock_rate(void);
+extern const char *octeon_board_type_string(void);
+extern const char *octeon_get_pci_interrupts(void);
+extern int octeon_get_southbridge_interrupt(void);
+extern int octeon_get_boot_coremask(void);
+extern int octeon_get_boot_num_arguments(void);
+extern const char *octeon_get_boot_argument(int arg);
+extern void octeon_hal_setup_reserved32(void);
+extern void octeon_user_io_init(void);
+struct octeon_cop2_state;
+extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
+extern void octeon_crypto_disable(struct octeon_cop2_state *state,
+				  unsigned long flags);
+
+extern void octeon_init_cvmcount(void);
+
+#define OCTEON_ARGV_MAX_ARGS	64
+#define OCTOEN_SERIAL_LEN	20
+
+struct octeon_boot_descriptor {
+	/* Start of block referenced by assembly code - do not change! */
+	uint32_t desc_version;
+	uint32_t desc_size;
+	uint64_t stack_top;
+	uint64_t heap_base;
+	uint64_t heap_end;
+	/* Only used by bootloader */
+	uint64_t entry_point;
+	uint64_t desc_vaddr;
+	/* End of This block referenced by assembly code - do not change! */
+	uint32_t exception_base_addr;
+	uint32_t stack_size;
+	uint32_t heap_size;
+	/* Argc count for application. */
+	uint32_t argc;
+	uint32_t argv[OCTEON_ARGV_MAX_ARGS];
+
+#define  BOOT_FLAG_INIT_CORE		(1 << 0)
+#define  OCTEON_BL_FLAG_DEBUG		(1 << 1)
+#define  OCTEON_BL_FLAG_NO_MAGIC	(1 << 2)
+	/* If set, use uart1 for console */
+#define  OCTEON_BL_FLAG_CONSOLE_UART1	(1 << 3)
+	/* If set, use PCI console */
+#define  OCTEON_BL_FLAG_CONSOLE_PCI	(1 << 4)
+	/* Call exit on break on serial port */
+#define  OCTEON_BL_FLAG_BREAK		(1 << 5)
+
+	uint32_t flags;
+	uint32_t core_mask;
+	/* DRAM size in megabyes. */
+	uint32_t dram_size;
+	/* physical address of free memory descriptor block. */
+	uint32_t phy_mem_desc_addr;
+	/* used to pass flags from app to debugger. */
+	uint32_t debugger_flags_base_addr;
+	/* CPU clock speed, in hz. */
+	uint32_t eclock_hz;
+	/* DRAM clock speed, in hz. */
+	uint32_t dclock_hz;
+	/* SPI4 clock in hz. */
+	uint32_t spi_clock_hz;
+	uint16_t board_type;
+	uint8_t board_rev_major;
+	uint8_t board_rev_minor;
+	uint16_t chip_type;
+	uint8_t chip_rev_major;
+	uint8_t chip_rev_minor;
+	char board_serial_number[OCTOEN_SERIAL_LEN];
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+	uint64_t cvmx_desc_vaddr;
+};
+
+union octeon_cvmemctl {
+	uint64_t u64;
+	struct {
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t tlbbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1cbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t l1dbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t dcmbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t ptgbist:1;
+		/* RO 1 = BIST fail, 0 = BIST pass */
+		uint64_t wbfbist:1;
+		/* Reserved */
+		uint64_t reserved:22;
+		/* R/W If set, marked write-buffer entries time out
+		 * the same as as other entries; if clear, marked
+		 * write-buffer entries use the maximum timeout. */
+		uint64_t dismarkwblongto:1;
+		/* R/W If set, a merged store does not clear the
+		 * write-buffer entry timeout state. */
+		uint64_t dismrgclrwbto:1;
+		/* R/W Two bits that are the MSBs of the resultant
+		 * CVMSEG LM word location for an IOBDMA. The other 8
+		 * bits come from the SCRADDR field of the IOBDMA. */
+		uint64_t iobdmascrmsb:2;
+		/* R/W If set, SYNCWS and SYNCS only order marked
+		 * stores; if clear, SYNCWS and SYNCS only order
+		 * unmarked stores. SYNCWSMARKED has no effect when
+		 * DISSYNCWS is set. */
+		uint64_t syncwsmarked:1;
+		/* R/W If set, SYNCWS acts as SYNCW and SYNCS acts as
+		 * SYNC. */
+		uint64_t dissyncws:1;
+		/* R/W If set, no stall happens on write buffer
+		 * full. */
+		uint64_t diswbfst:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==0 */
+		uint64_t xkmemenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==0 */
+		uint64_t xkmemenau:1;
+		/* R/W If set (and SX set), supervisor-level
+		 * loads/stores can use XKPHYS addresses with
+		 * VA<48>==1 */
+		uint64_t xkioenas:1;
+		/* R/W If set (and UX set), user-level loads/stores
+		 * can use XKPHYS addresses with VA<48>==1 */
+		uint64_t xkioenau:1;
+		/* R/W If set, all stores act as SYNCW (NOMERGE must
+		 * be set when this is set) RW, reset to 0. */
+		uint64_t allsyncw:1;
+		/* R/W If set, no stores merge, and all stores reach
+		 * the coherent bus in order. */
+		uint64_t nomerge:1;
+		/* R/W Selects the bit in the counter used for DID
+		 * time-outs 0 = 231, 1 = 230, 2 = 229, 3 =
+		 * 214. Actual time-out is between 1x and 2x this
+		 * interval. For example, with DIDTTO=3, expiration
+		 * interval is between 16K and 32K. */
+		uint64_t didtto:2;
+		/* R/W If set, the (mem) CSR clock never turns off. */
+		uint64_t csrckalwys:1;
+		/* R/W If set, mclk never turns off. */
+		uint64_t mclkalwys:1;
+		/* R/W Selects the bit in the counter used for write
+		 * buffer flush time-outs (WBFLT+11) is the bit
+		 * position in an internal counter used to determine
+		 * expiration. The write buffer expires between 1x and
+		 * 2x this interval. For example, with WBFLT = 0, a
+		 * write buffer expires between 2K and 4K cycles after
+		 * the write buffer entry is allocated. */
+		uint64_t wbfltime:3;
+		/* R/W If set, do not put Istream in the L2 cache. */
+		uint64_t istrnol2:1;
+		/* R/W The write buffer threshold. */
+		uint64_t wbthresh:4;
+		/* Reserved */
+		uint64_t reserved2:2;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * kernel/debug mode. */
+		uint64_t cvmsegenak:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * supervisor mode. */
+		uint64_t cvmsegenas:1;
+		/* R/W If set, CVMSEG is available for loads/stores in
+		 * user mode. */
+		uint64_t cvmsegenau:1;
+		/* R/W Size of local memory in cache blocks, 54 (6912
+		 * bytes) is max legal value. */
+		uint64_t lmemsz:6;
+	} s;
+};
+
+struct octeon_cf_data {
+	unsigned long	base_region_bias;
+	unsigned int	base_region;	/* The chip select region used by CF */
+	int		is16bit;	/* 0 - 8bit, !0 - 16bit */
+	int		dma_engine;	/* -1 for no DMA */
+};
+
+extern void octeon_write_lcd(const char *s);
+extern void octeon_check_cpu_bist(void);
+extern int octeon_get_boot_debug_flag(void);
+extern int octeon_get_boot_uart(void);
+
+struct uart_port;
+extern unsigned int octeon_serial_in(struct uart_port *, int);
+extern void octeon_serial_out(struct uart_port *, int, int);
+
+/**
+ * Write a 32bit value to the Octeon NPI register space
+ *
+ * @address: Address to write to
+ * @val:     Value to write
+ */
+static inline void octeon_npi_write32(uint64_t address, uint32_t val)
+{
+	cvmx_write64_uint32(address ^ 4, val);
+	cvmx_read64_uint32(address ^ 4);
+}
+
+
+/**
+ * Read a 32bit value from the Octeon NPI register space
+ *
+ * @address: Address to read
+ * Returns The result
+ */
+static inline uint32_t octeon_npi_read32(uint64_t address)
+{
+	return cvmx_read64_uint32(address ^ 4);
+}
+
+#endif /* __ASM_OCTEON_OCTEON_H */
diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
new file mode 100644
index 0000000..d523896
--- /dev/null
+++ b/arch/mips/kernel/octeon_switch.S
@@ -0,0 +1,506 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 1995, 1996, 1998, 1999, 2002, 2003 Ralf Baechle
+ * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 1994, 1995, 1996, by Andreas Busse
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2000 MIPS Technologies, Inc.
+ *    written by Carsten Langgaard, carstenl@mips.com
+ */
+#include <asm/asm.h>
+#include <asm/cachectl.h>
+#include <asm/fpregdef.h>
+#include <asm/mipsregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+#include <asm/asmmacro.h>
+
+/*
+ * Offset to the current process status flags, the first 32 bytes of the
+ * stack are not used.
+ */
+#define ST_OFF (_THREAD_SIZE - 32 - PT_SIZE + PT_STATUS)
+
+/*
+ * task_struct *resume(task_struct *prev, task_struct *next,
+ *                     struct thread_info *next_ti)
+ */
+	.align	7
+	LEAF(resume)
+	.set arch=octeon
+#ifndef CONFIG_CPU_HAS_LLSC
+	sw	zero, ll_bit
+#endif
+	mfc0	t1, CP0_STATUS
+	LONG_S	t1, THREAD_STATUS(a0)
+	cpu_save_nonscratch a0
+	LONG_S	ra, THREAD_REG31(a0)
+
+	/* check if we need to save COP2 registers */
+	PTR_L	t2, TASK_THREAD_INFO(a0)
+	LONG_L	t0, ST_OFF(t2)
+	bbit0	t0, 30, 1f
+
+	/* Disable COP2 in the stored process state */
+	li	t1, ST0_CU2
+	xor	t0, t1
+	LONG_S	t0, ST_OFF(t2)
+
+	/* Enable COP2 so we can save it */
+	mfc0	t0, CP0_STATUS
+	or	t0, t1
+	mtc0	t0, CP0_STATUS
+
+	/* Save COP2 */
+	daddu	a0, THREAD_CP2
+	jal octeon_cop2_save
+	dsubu	a0, THREAD_CP2
+
+	/* Disable COP2 now that we are done */
+	mfc0	t0, CP0_STATUS
+	li	t1, ST0_CU2
+	xor	t0, t1
+	mtc0	t0, CP0_STATUS
+
+1:
+#if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
+	/* Check if we need to store CVMSEG state */
+	mfc0	t0, $11,7 	/* CvmMemCtl */
+	bbit0	t0, 6, 3f	/* Is user access enabled? */
+
+	/* Store the CVMSEG state */
+	/* Extract the size of CVMSEG */
+	andi	t0, 0x3f
+	/* Multiply * (cache line size/sizeof(long)/2) */
+	sll	t0, 7-LONGLOG-1
+	li	t1, -32768 	/* Base address of CVMSEG */
+	LONG_ADDI t2, a0, THREAD_CVMSEG	/* Where to store CVMSEG to */
+	synciobdma
+2:
+	.set noreorder
+	LONG_L	t8, 0(t1)	/* Load from CVMSEG */
+	subu	t0, 1		/* Decrement loop var */
+	LONG_L	t9, LONGSIZE(t1)/* Load from CVMSEG */
+	LONG_ADDU t1, LONGSIZE*2 /* Increment loc in CVMSEG */
+	LONG_S	t8, 0(t2)	/* Store CVMSEG to thread storage */
+	LONG_ADDU t2, LONGSIZE*2 /* Increment loc in thread storage */
+	bnez	t0, 2b		/* Loop until we've copied it all */
+	 LONG_S	t9, -LONGSIZE(t2)/* Store CVMSEG to thread storage */
+	.set reorder
+
+	/* Disable access to CVMSEG */
+	mfc0	t0, $11,7 	/* CvmMemCtl */
+	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
+	mtc0	t0, $11,7 	/* CvmMemCtl */
+#endif
+3:
+	/*
+	 * The order of restoring the registers takes care of the race
+	 * updating $28, $29 and kernelsp without disabling ints.
+	 */
+	move	$28, a2
+	cpu_restore_nonscratch a1
+
+#if (_THREAD_SIZE - 32) < 0x8000
+	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
+#else
+	PTR_LI		t0, _THREAD_SIZE - 32
+	PTR_ADDU	t0, $28
+#endif
+	set_saved_sp	t0, t1, t2
+
+	mfc0	t1, CP0_STATUS		/* Do we really need this? */
+	li	a3, 0xff01
+	and	t1, a3
+	LONG_L	a2, THREAD_STATUS(a1)
+	nor	a3, $0, a3
+	and	a2, a3
+	or	a2, t1
+	mtc0	a2, CP0_STATUS
+	move	v0, a0
+	jr	ra
+	END(resume)
+
+/*
+ * void octeon_cop2_save(struct octeon_cop2_state *a0)
+ */
+	.align	7
+	LEAF(octeon_cop2_save)
+
+	dmfc0	t9, $9,7	/* CvmCtl register. */
+
+        /* Save the COP2 CRC state */
+	dmfc2	t0, 0x0201
+	dmfc2	t1, 0x0202
+	dmfc2	t2, 0x0200
+	sd	t0, OCTEON_CP2_CRC_IV(a0)
+	sd	t1, OCTEON_CP2_CRC_LENGTH(a0)
+	sd	t2, OCTEON_CP2_CRC_POLY(a0)
+	/* Skip next instructions if CvmCtl[NODFA_CP2] set */
+	bbit1	t9, 28, 1f
+
+	/* Save the LLM state */
+	dmfc2	t0, 0x0402
+	dmfc2	t1, 0x040A
+	sd	t0, OCTEON_CP2_LLM_DAT(a0)
+	sd	t1, OCTEON_CP2_LLM_DAT+8(a0)
+
+1:      bbit1	t9, 26, 3f	/* done if CvmCtl[NOCRYPTO] set */
+
+	/* Save the COP2 crypto state */
+        /* this part is mostly common to both pass 1 and later revisions */
+	dmfc2 	t0, 0x0084
+	dmfc2 	t1, 0x0080
+	dmfc2 	t2, 0x0081
+	dmfc2 	t3, 0x0082
+	sd	t0, OCTEON_CP2_3DES_IV(a0)
+	dmfc2 	t0, 0x0088
+	sd	t1, OCTEON_CP2_3DES_KEY(a0)
+	dmfc2 	t1, 0x0111                      /* only necessary for pass 1 */
+	sd	t2, OCTEON_CP2_3DES_KEY+8(a0)
+	dmfc2 	t2, 0x0102
+	sd	t3, OCTEON_CP2_3DES_KEY+16(a0)
+	dmfc2 	t3, 0x0103
+	sd	t0, OCTEON_CP2_3DES_RESULT(a0)
+	dmfc2 	t0, 0x0104
+	sd	t1, OCTEON_CP2_AES_INP0(a0)     /* only necessary for pass 1 */
+	dmfc2 	t1, 0x0105
+	sd	t2, OCTEON_CP2_AES_IV(a0)
+	dmfc2	t2, 0x0106
+	sd	t3, OCTEON_CP2_AES_IV+8(a0)
+	dmfc2 	t3, 0x0107
+	sd	t0, OCTEON_CP2_AES_KEY(a0)
+	dmfc2	t0, 0x0110
+	sd	t1, OCTEON_CP2_AES_KEY+8(a0)
+	dmfc2	t1, 0x0100
+	sd	t2, OCTEON_CP2_AES_KEY+16(a0)
+	dmfc2	t2, 0x0101
+	sd	t3, OCTEON_CP2_AES_KEY+24(a0)
+	mfc0	t3, $15,0 	/* Get the processor ID register */
+	sd	t0, OCTEON_CP2_AES_KEYLEN(a0)
+	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	sd	t1, OCTEON_CP2_AES_RESULT(a0)
+	sd	t2, OCTEON_CP2_AES_RESULT+8(a0)
+	/* Skip to the Pass1 version of the remainder of the COP2 state */
+	beq	t3, t0, 2f
+
+        /* the non-pass1 state when !CvmCtl[NOCRYPTO] */
+	dmfc2	t1, 0x0240
+	dmfc2	t2, 0x0241
+	dmfc2	t3, 0x0242
+	dmfc2	t0, 0x0243
+	sd	t1, OCTEON_CP2_HSH_DATW(a0)
+	dmfc2	t1, 0x0244
+	sd	t2, OCTEON_CP2_HSH_DATW+8(a0)
+	dmfc2	t2, 0x0245
+	sd	t3, OCTEON_CP2_HSH_DATW+16(a0)
+	dmfc2	t3, 0x0246
+	sd	t0, OCTEON_CP2_HSH_DATW+24(a0)
+	dmfc2	t0, 0x0247
+	sd	t1, OCTEON_CP2_HSH_DATW+32(a0)
+	dmfc2	t1, 0x0248
+	sd	t2, OCTEON_CP2_HSH_DATW+40(a0)
+	dmfc2	t2, 0x0249
+	sd	t3, OCTEON_CP2_HSH_DATW+48(a0)
+	dmfc2	t3, 0x024A
+	sd	t0, OCTEON_CP2_HSH_DATW+56(a0)
+	dmfc2	t0, 0x024B
+	sd	t1, OCTEON_CP2_HSH_DATW+64(a0)
+	dmfc2	t1, 0x024C
+	sd	t2, OCTEON_CP2_HSH_DATW+72(a0)
+	dmfc2	t2, 0x024D
+	sd	t3, OCTEON_CP2_HSH_DATW+80(a0)
+	dmfc2 	t3, 0x024E
+	sd	t0, OCTEON_CP2_HSH_DATW+88(a0)
+	dmfc2	t0, 0x0250
+	sd	t1, OCTEON_CP2_HSH_DATW+96(a0)
+	dmfc2	t1, 0x0251
+	sd	t2, OCTEON_CP2_HSH_DATW+104(a0)
+	dmfc2	t2, 0x0252
+	sd	t3, OCTEON_CP2_HSH_DATW+112(a0)
+	dmfc2	t3, 0x0253
+	sd	t0, OCTEON_CP2_HSH_IVW(a0)
+	dmfc2	t0, 0x0254
+	sd	t1, OCTEON_CP2_HSH_IVW+8(a0)
+	dmfc2	t1, 0x0255
+	sd	t2, OCTEON_CP2_HSH_IVW+16(a0)
+	dmfc2	t2, 0x0256
+	sd	t3, OCTEON_CP2_HSH_IVW+24(a0)
+	dmfc2	t3, 0x0257
+	sd	t0, OCTEON_CP2_HSH_IVW+32(a0)
+	dmfc2 	t0, 0x0258
+	sd	t1, OCTEON_CP2_HSH_IVW+40(a0)
+	dmfc2 	t1, 0x0259
+	sd	t2, OCTEON_CP2_HSH_IVW+48(a0)
+	dmfc2	t2, 0x025E
+	sd	t3, OCTEON_CP2_HSH_IVW+56(a0)
+	dmfc2	t3, 0x025A
+	sd	t0, OCTEON_CP2_GFM_MULT(a0)
+	dmfc2	t0, 0x025B
+	sd	t1, OCTEON_CP2_GFM_MULT+8(a0)
+	sd	t2, OCTEON_CP2_GFM_POLY(a0)
+	sd	t3, OCTEON_CP2_GFM_RESULT(a0)
+	sd	t0, OCTEON_CP2_GFM_RESULT+8(a0)
+	jr	ra
+
+2:      /* pass 1 special stuff when !CvmCtl[NOCRYPTO] */
+	dmfc2	t3, 0x0040
+	dmfc2	t0, 0x0041
+	dmfc2	t1, 0x0042
+	dmfc2	t2, 0x0043
+	sd	t3, OCTEON_CP2_HSH_DATW(a0)
+	dmfc2	t3, 0x0044
+	sd	t0, OCTEON_CP2_HSH_DATW+8(a0)
+	dmfc2	t0, 0x0045
+	sd	t1, OCTEON_CP2_HSH_DATW+16(a0)
+	dmfc2	t1, 0x0046
+	sd	t2, OCTEON_CP2_HSH_DATW+24(a0)
+	dmfc2	t2, 0x0048
+	sd	t3, OCTEON_CP2_HSH_DATW+32(a0)
+	dmfc2	t3, 0x0049
+	sd	t0, OCTEON_CP2_HSH_DATW+40(a0)
+	dmfc2	t0, 0x004A
+	sd	t1, OCTEON_CP2_HSH_DATW+48(a0)
+	sd	t2, OCTEON_CP2_HSH_IVW(a0)
+	sd	t3, OCTEON_CP2_HSH_IVW+8(a0)
+	sd	t0, OCTEON_CP2_HSH_IVW+16(a0)
+
+3:      /* pass 1 or CvmCtl[NOCRYPTO] set */
+	jr	ra
+	END(octeon_cop2_save)
+
+/*
+ * void octeon_cop2_restore(struct octeon_cop2_state *a0)
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_cop2_restore)
+        /* First cache line was prefetched before the call */
+        pref    4,  128(a0)
+	dmfc0	t9, $9,7	/* CvmCtl register. */
+
+        pref    4,  256(a0)
+	ld	t0, OCTEON_CP2_CRC_IV(a0)
+        pref    4,  384(a0)
+	ld	t1, OCTEON_CP2_CRC_LENGTH(a0)
+	ld	t2, OCTEON_CP2_CRC_POLY(a0)
+
+	/* Restore the COP2 CRC state */
+	dmtc2	t0, 0x0201
+	dmtc2 	t1, 0x1202
+	bbit1	t9, 28, 2f	/* Skip LLM if CvmCtl[NODFA_CP2] is set */
+	 dmtc2	t2, 0x4200
+
+	/* Restore the LLM state */
+	ld	t0, OCTEON_CP2_LLM_DAT(a0)
+	ld	t1, OCTEON_CP2_LLM_DAT+8(a0)
+	dmtc2	t0, 0x0402
+	dmtc2	t1, 0x040A
+
+2:
+	bbit1	t9, 26, done_restore	/* done if CvmCtl[NOCRYPTO] set */
+	 nop
+
+	/* Restore the COP2 crypto state common to pass 1 and pass 2 */
+	ld	t0, OCTEON_CP2_3DES_IV(a0)
+	ld	t1, OCTEON_CP2_3DES_KEY(a0)
+	ld	t2, OCTEON_CP2_3DES_KEY+8(a0)
+	dmtc2 	t0, 0x0084
+	ld	t0, OCTEON_CP2_3DES_KEY+16(a0)
+	dmtc2 	t1, 0x0080
+	ld	t1, OCTEON_CP2_3DES_RESULT(a0)
+	dmtc2 	t2, 0x0081
+	ld	t2, OCTEON_CP2_AES_INP0(a0) /* only really needed for pass 1 */
+	dmtc2	t0, 0x0082
+	ld	t0, OCTEON_CP2_AES_IV(a0)
+	dmtc2 	t1, 0x0098
+	ld	t1, OCTEON_CP2_AES_IV+8(a0)
+	dmtc2 	t2, 0x010A                  /* only really needed for pass 1 */
+	ld	t2, OCTEON_CP2_AES_KEY(a0)
+	dmtc2 	t0, 0x0102
+	ld	t0, OCTEON_CP2_AES_KEY+8(a0)
+	dmtc2	t1, 0x0103
+	ld	t1, OCTEON_CP2_AES_KEY+16(a0)
+	dmtc2	t2, 0x0104
+	ld	t2, OCTEON_CP2_AES_KEY+24(a0)
+	dmtc2	t0, 0x0105
+	ld	t0, OCTEON_CP2_AES_KEYLEN(a0)
+	dmtc2	t1, 0x0106
+	ld	t1, OCTEON_CP2_AES_RESULT(a0)
+	dmtc2	t2, 0x0107
+	ld	t2, OCTEON_CP2_AES_RESULT+8(a0)
+	mfc0	t3, $15,0 	/* Get the processor ID register */
+	dmtc2	t0, 0x0110
+	li	t0, 0x000d0000	/* This is the processor ID of Octeon Pass1 */
+	dmtc2	t1, 0x0100
+	bne	t0, t3, 3f	/* Skip the next stuff for non-pass1 */
+	 dmtc2	t2, 0x0101
+
+        /* this code is specific for pass 1 */
+	ld	t0, OCTEON_CP2_HSH_DATW(a0)
+	ld	t1, OCTEON_CP2_HSH_DATW+8(a0)
+	ld	t2, OCTEON_CP2_HSH_DATW+16(a0)
+	dmtc2	t0, 0x0040
+	ld	t0, OCTEON_CP2_HSH_DATW+24(a0)
+	dmtc2	t1, 0x0041
+	ld	t1, OCTEON_CP2_HSH_DATW+32(a0)
+	dmtc2	t2, 0x0042
+	ld	t2, OCTEON_CP2_HSH_DATW+40(a0)
+	dmtc2	t0, 0x0043
+	ld	t0, OCTEON_CP2_HSH_DATW+48(a0)
+	dmtc2	t1, 0x0044
+	ld	t1, OCTEON_CP2_HSH_IVW(a0)
+	dmtc2	t2, 0x0045
+	ld	t2, OCTEON_CP2_HSH_IVW+8(a0)
+	dmtc2	t0, 0x0046
+	ld	t0, OCTEON_CP2_HSH_IVW+16(a0)
+	dmtc2	t1, 0x0048
+	dmtc2	t2, 0x0049
+        b done_restore   /* unconditional branch */
+	 dmtc2	t0, 0x004A
+
+3:      /* this is post-pass1 code */
+	ld	t2, OCTEON_CP2_HSH_DATW(a0)
+	ld	t0, OCTEON_CP2_HSH_DATW+8(a0)
+	ld	t1, OCTEON_CP2_HSH_DATW+16(a0)
+	dmtc2	t2, 0x0240
+	ld	t2, OCTEON_CP2_HSH_DATW+24(a0)
+	dmtc2	t0, 0x0241
+	ld	t0, OCTEON_CP2_HSH_DATW+32(a0)
+	dmtc2	t1, 0x0242
+	ld	t1, OCTEON_CP2_HSH_DATW+40(a0)
+	dmtc2	t2, 0x0243
+	ld	t2, OCTEON_CP2_HSH_DATW+48(a0)
+	dmtc2	t0, 0x0244
+	ld	t0, OCTEON_CP2_HSH_DATW+56(a0)
+	dmtc2	t1, 0x0245
+	ld	t1, OCTEON_CP2_HSH_DATW+64(a0)
+	dmtc2	t2, 0x0246
+	ld	t2, OCTEON_CP2_HSH_DATW+72(a0)
+	dmtc2	t0, 0x0247
+	ld	t0, OCTEON_CP2_HSH_DATW+80(a0)
+	dmtc2	t1, 0x0248
+	ld	t1, OCTEON_CP2_HSH_DATW+88(a0)
+	dmtc2	t2, 0x0249
+	ld	t2, OCTEON_CP2_HSH_DATW+96(a0)
+	dmtc2	t0, 0x024A
+	ld	t0, OCTEON_CP2_HSH_DATW+104(a0)
+	dmtc2	t1, 0x024B
+	ld	t1, OCTEON_CP2_HSH_DATW+112(a0)
+	dmtc2	t2, 0x024C
+	ld	t2, OCTEON_CP2_HSH_IVW(a0)
+	dmtc2	t0, 0x024D
+	ld	t0, OCTEON_CP2_HSH_IVW+8(a0)
+	dmtc2	t1, 0x024E
+	ld	t1, OCTEON_CP2_HSH_IVW+16(a0)
+	dmtc2	t2, 0x0250
+	ld	t2, OCTEON_CP2_HSH_IVW+24(a0)
+	dmtc2	t0, 0x0251
+	ld	t0, OCTEON_CP2_HSH_IVW+32(a0)
+	dmtc2	t1, 0x0252
+	ld	t1, OCTEON_CP2_HSH_IVW+40(a0)
+	dmtc2	t2, 0x0253
+	ld	t2, OCTEON_CP2_HSH_IVW+48(a0)
+	dmtc2	t0, 0x0254
+	ld	t0, OCTEON_CP2_HSH_IVW+56(a0)
+	dmtc2	t1, 0x0255
+	ld	t1, OCTEON_CP2_GFM_MULT(a0)
+	dmtc2	t2, 0x0256
+	ld	t2, OCTEON_CP2_GFM_MULT+8(a0)
+	dmtc2	t0, 0x0257
+	ld	t0, OCTEON_CP2_GFM_POLY(a0)
+	dmtc2	t1, 0x0258
+	ld	t1, OCTEON_CP2_GFM_RESULT(a0)
+	dmtc2	t2, 0x0259
+	ld	t2, OCTEON_CP2_GFM_RESULT+8(a0)
+	dmtc2	t0, 0x025E
+	dmtc2	t1, 0x025A
+	dmtc2	t2, 0x025B
+
+done_restore:
+	jr	ra
+	 nop
+	END(octeon_cop2_restore)
+	.set pop
+
+/*
+ * void octeon_mult_save()
+ * sp is assumed to point to a struct pt_regs
+ *
+ * NOTE: This is called in SAVE_SOME in stackframe.h. It can only
+ *       safely modify k0 and k1.
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_mult_save)
+	dmfc0	k0, $9,7	/* CvmCtl register. */
+	bbit1	k0, 27, 1f	/* Skip CvmCtl[NOMUL] */
+	 nop
+
+	/* Save the multiplier state */
+	v3mulu	k0, $0, $0
+	v3mulu	k1, $0, $0
+	sd	k0, PT_MTP(sp)        /* PT_MTP    has P0 */
+	v3mulu	k0, $0, $0
+	sd	k1, PT_MTP+8(sp)      /* PT_MTP+8  has P1 */
+	ori	k1, $0, 1
+	v3mulu	k1, k1, $0
+	sd	k0, PT_MTP+16(sp)     /* PT_MTP+16 has P2 */
+	v3mulu	k0, $0, $0
+	sd	k1, PT_MPL(sp)        /* PT_MPL    has MPL0 */
+	v3mulu	k1, $0, $0
+	sd	k0, PT_MPL+8(sp)      /* PT_MPL+8  has MPL1 */
+	jr	ra
+	 sd	k1, PT_MPL+16(sp)     /* PT_MPL+16 has MPL2 */
+
+1:	/* Resume here if CvmCtl[NOMUL] */
+	jr	ra
+	END(octeon_mult_save)
+	.set pop
+
+/*
+ * void octeon_mult_restore()
+ * sp is assumed to point to a struct pt_regs
+ *
+ * NOTE: This is called in RESTORE_SOME in stackframe.h.
+ */
+	.align	7
+	.set push
+	.set noreorder
+	LEAF(octeon_mult_restore)
+	dmfc0	k1, $9,7		/* CvmCtl register. */
+	ld	v0, PT_MPL(sp)        	/* MPL0 */
+	ld	v1, PT_MPL+8(sp)      	/* MPL1 */
+	ld	k0, PT_MPL+16(sp)     	/* MPL2 */
+	bbit1	k1, 27, 1f		/* Skip CvmCtl[NOMUL] */
+	/* Normally falls through, so no time wasted here */
+	nop
+
+	/* Restore the multiplier state */
+	ld	k1, PT_MTP+16(sp)     	/* P2 */
+	MTM0	v0			/* MPL0 */
+	ld	v0, PT_MTP+8(sp)	/* P1 */
+	MTM1	v1			/* MPL1 */
+	ld	v1, PT_MTP(sp)   	/* P0 */
+	MTM2	k0			/* MPL2 */
+	MTP2	k1			/* P2 */
+	MTP1	v0			/* P1 */
+	jr	ra
+	 MTP0	v1			/* P0 */
+
+1:	/* Resume here if CvmCtl[NOMUL] */
+	jr	ra
+	 nop
+	END(octeon_mult_restore)
+	.set pop
+
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
new file mode 100644
index 0000000..44d01a0
--- /dev/null
+++ b/arch/mips/mm/c-octeon.c
@@ -0,0 +1,307 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2007 Cavium Networks
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/io.h>
+
+#include <asm/bcache.h>
+#include <asm/bootinfo.h>
+#include <asm/cacheops.h>
+#include <asm/cpu-features.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/r4kcache.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/war.h>
+
+#include <asm/octeon/octeon.h>
+
+unsigned long long cache_err_dcache[NR_CPUS];
+
+/**
+ * Octeon automatically flushes the dcache on tlb changes, so
+ * from Linux's viewpoint it acts much like a physically
+ * tagged cache. No flushing is needed
+ *
+ */
+static void octeon_flush_data_cache_page(unsigned long addr)
+{
+    /* Nothing to do */
+}
+
+static inline void octeon_local_flush_icache(void)
+{
+	asm volatile ("synci 0($0)");
+}
+
+/*
+ * Flush local I-cache for the specified range.
+ */
+static void local_octeon_flush_icache_range(unsigned long start,
+					    unsigned long end)
+{
+	octeon_local_flush_icache();
+}
+
+/**
+ * Flush caches as necessary for all cores affected by a
+ * vma. If no vma is supplied, all cores are flushed.
+ *
+ * @vma:    VMA to flush or NULL to flush all icaches.
+ */
+static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
+{
+	extern void octeon_send_ipi_single(int cpu, unsigned int action);
+#ifdef CONFIG_SMP
+	int cpu;
+	cpumask_t mask;
+#endif
+
+	mb();
+	octeon_local_flush_icache();
+#ifdef CONFIG_SMP
+	preempt_disable();
+	cpu = smp_processor_id();
+
+	/*
+	 * If we have a vma structure, we only need to worry about
+	 * cores it has been used on
+	 */
+	if (vma)
+		mask = vma->vm_mm->cpu_vm_mask;
+	else
+		mask = cpu_online_map;
+	cpu_clear(cpu, mask);
+	for_each_cpu_mask(cpu, mask)
+		octeon_send_ipi_single(cpu, SMP_ICACHE_FLUSH);
+
+	preempt_enable();
+#endif
+}
+
+
+/**
+ * Called to flush the icache on all cores
+ */
+static void octeon_flush_icache_all(void)
+{
+	octeon_flush_icache_all_cores(NULL);
+}
+
+
+/**
+ * Called to flush all memory associated with a memory
+ * context.
+ *
+ * @mm:     Memory context to flush
+ */
+static void octeon_flush_cache_mm(struct mm_struct *mm)
+{
+	/*
+	 * According to the R4K version of this file, CPUs without
+	 * dcache aliases don't need to do anything here
+	 */
+}
+
+
+/**
+ * Flush a range of kernel addresses out of the icache
+ *
+ */
+static void octeon_flush_icache_range(unsigned long start, unsigned long end)
+{
+	octeon_flush_icache_all_cores(NULL);
+}
+
+
+/**
+ * Flush the icache for a trampoline. These are used for interrupt
+ * and exception hooking.
+ *
+ * @addr:   Address to flush
+ */
+static void octeon_flush_cache_sigtramp(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	vma = find_vma(current->mm, addr);
+	octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Flush a range out of a vma
+ *
+ * @vma:    VMA to flush
+ * @start:
+ * @end:
+ */
+static void octeon_flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start, unsigned long end)
+{
+	if (vma->vm_flags & VM_EXEC)
+		octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Flush a specific page of a vma
+ *
+ * @vma:    VMA to flush page for
+ * @page:   Page to flush
+ * @pfn:
+ */
+static void octeon_flush_cache_page(struct vm_area_struct *vma,
+				    unsigned long page, unsigned long pfn)
+{
+	if (vma->vm_flags & VM_EXEC)
+		octeon_flush_icache_all_cores(vma);
+}
+
+
+/**
+ * Probe Octeon's caches
+ *
+ */
+static void __devinit probe_octeon(void)
+{
+	unsigned long icache_size;
+	unsigned long dcache_size;
+	unsigned int config1;
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	switch (c->cputype) {
+	case CPU_CAVIUM_OCTEON:
+		config1 = read_c0_config1();
+		c->icache.linesz = 2 << ((config1 >> 19) & 7);
+		c->icache.sets = 64 << ((config1 >> 22) & 7);
+		c->icache.ways = 1 + ((config1 >> 16) & 7);
+		c->icache.flags |= MIPS_CACHE_VTAG;
+		icache_size =
+			c->icache.sets * c->icache.ways * c->icache.linesz;
+		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
+		c->dcache.linesz = 128;
+		if (OCTEON_IS_MODEL(OCTEON_CN3XXX))
+			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
+		else
+			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
+		c->dcache.ways = 64;
+		dcache_size =
+			c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+		c->dcache.waybit = ffs(dcache_size / c->dcache.ways) - 1;
+		c->options |= MIPS_CPU_PREFETCH;
+		break;
+
+	default:
+		panic("Unsupported Cavium Networks CPU type\n");
+		break;
+	}
+
+	/* compute a couple of other cache variables */
+	c->icache.waysize = icache_size / c->icache.ways;
+	c->dcache.waysize = dcache_size / c->dcache.ways;
+
+	c->icache.sets = icache_size / (c->icache.linesz * c->icache.ways);
+	c->dcache.sets = dcache_size / (c->dcache.linesz * c->dcache.ways);
+
+	if (smp_processor_id() == 0) {
+		pr_notice("Primary instruction cache %ldkB, %s, %d way, "
+			  "%d sets, linesize %d bytes.\n",
+			  icache_size >> 10,
+			  cpu_has_vtag_icache ?
+				"virtually tagged" : "physically tagged",
+			  c->icache.ways, c->icache.sets, c->icache.linesz);
+
+		pr_notice("Primary data cache %ldkB, %d-way, %d sets, "
+			  "linesize %d bytes.\n",
+			  dcache_size >> 10, c->dcache.ways,
+			  c->dcache.sets, c->dcache.linesz);
+	}
+}
+
+
+/**
+ * Setup the Octeon cache flush routines
+ *
+ */
+void __devinit octeon_cache_init(void)
+{
+	extern unsigned long ebase;
+	extern char except_vec2_octeon;
+
+	memcpy((void *)(ebase + 0x100), &except_vec2_octeon, 0x80);
+	octeon_flush_cache_sigtramp(ebase + 0x100);
+
+	probe_octeon();
+
+	shm_align_mask = PAGE_SIZE - 1;
+
+	flush_cache_all			= octeon_flush_icache_all;
+	__flush_cache_all		= octeon_flush_icache_all;
+	flush_cache_mm			= octeon_flush_cache_mm;
+	flush_cache_page		= octeon_flush_cache_page;
+	flush_cache_range		= octeon_flush_cache_range;
+	flush_cache_sigtramp		= octeon_flush_cache_sigtramp;
+	flush_icache_all		= octeon_flush_icache_all;
+	flush_data_cache_page		= octeon_flush_data_cache_page;
+	flush_icache_range		= octeon_flush_icache_range;
+	local_flush_icache_range	= local_octeon_flush_icache_range;
+
+	build_clear_page();
+	build_copy_page();
+}
+
+/**
+ * Handle a cache error exception
+ */
+
+static void  cache_parity_error_octeon(int non_recoverable)
+{
+	unsigned long coreid = cvmx_get_core_num();
+	uint64_t icache_err = read_octeon_c0_icacheerr();
+
+	pr_err("Cache error exception:\n");
+	pr_err("cp0_errorepc == %lx\n", read_c0_errorepc());
+	if (icache_err & 1) {
+		pr_err("CacheErr (Icache) == %llx\n",
+		       (unsigned long long)icache_err);
+		write_octeon_c0_icacheerr(0);
+	}
+	if (cache_err_dcache[coreid] & 1) {
+		pr_err("CacheErr (Dcache) == %llx\n",
+		       (unsigned long long)cache_err_dcache[coreid]);
+		cache_err_dcache[coreid] = 0;
+	}
+
+	if (non_recoverable)
+		panic("Can't handle cache error: nested exception");
+}
+
+/**
+ * Called when the the exception is not recoverable
+ */
+
+asmlinkage void cache_parity_error_octeon_recoverable(void)
+{
+	cache_parity_error_octeon(0);
+}
+
+/**
+ * Called when the the exception is recoverable
+ */
+
+asmlinkage void cache_parity_error_octeon_non_recoverable(void)
+{
+	cache_parity_error_octeon(1);
+}
+
diff --git a/arch/mips/mm/cex-oct.S b/arch/mips/mm/cex-oct.S
new file mode 100644
index 0000000..3db8553
--- /dev/null
+++ b/arch/mips/mm/cex-oct.S
@@ -0,0 +1,70 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Cavium Networks
+ * Cache error handler
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+
+/*
+ * Handle cache error. Indicate to the second level handler whether
+ * the exception is recoverable.
+ */
+	LEAF(except_vec2_octeon)
+
+	.set    push
+	.set	mips64r2
+	.set	noreorder
+	.set	noat
+
+
+	/* due to an errata we need to read the COP0 CacheErr (Dcache)
+	 * before any cache/DRAM access	 */
+
+	rdhwr   k0, $0        /* get core_id */
+	PTR_LA  k1, cache_err_dcache
+	sll     k0, k0, 3
+	PTR_ADDU k1, k0, k1    /* k1 = &cache_err_dcache[core_id] */
+
+	dmfc0   k0, CP0_CACHEERR, 1
+	sd      k0, (k1)
+	dmtc0   $0, CP0_CACHEERR, 1
+
+        /* check whether this is a nested exception */
+	mfc0    k1, CP0_STATUS
+	andi    k1, k1, ST0_EXL
+	beqz    k1, 1f
+	 nop
+	j	cache_parity_error_octeon_non_recoverable
+	 nop
+
+	/* exception is recoverable */
+1:	j	handle_cache_err
+	 nop
+
+	.set    pop
+	END(except_vec2_octeon)
+
+ /* We need to jump to handle_cache_err so that the previous handler
+  * can fit within 0x80 bytes. We also move from 0xFFFFFFFFAXXXXXXX
+  * space (uncached) to the 0xFFFFFFFF8XXXXXXX space (cached).  */
+	LEAF(handle_cache_err)
+	.set    push
+        .set    noreorder
+        .set    noat
+
+	SAVE_ALL
+	KMODE
+	jal     cache_parity_error_octeon_recoverable
+	nop
+	j       ret_from_exception
+	nop
+
+	.set pop
+	END(handle_cache_err)
-- 
1.5.6.6
