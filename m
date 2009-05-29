Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 19:31:46 +0100 (BST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:54534 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024743AbZE2Sau (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 19:30:50 +0100
X-IronPort-AV: E=Sophos;i="4.41,272,1241395200"; 
   d="scan'208";a="78336837"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-5.cisco.com with ESMTP; 29 May 2009 18:30:38 +0000
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n4TIUb3D010966;
	Fri, 29 May 2009 11:30:37 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n4TIUbaj006416;
	Fri, 29 May 2009 18:30:37 GMT
Date:	Fri, 29 May 2009 11:30:37 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv platform,
	v3 
Message-ID: <20090529183037.GA12464@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=158011; t=1243621838; x=1244485838;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=201/3]=20mips=3Apowertv=3A=20Base=20file
	s=20for=20Cisco=20Powertv=20platform,=0A=09v3=20
	|Sender:=20;
	bh=FUjf1KFhfNlx1PhcjWFF1rjRf6Mn5iasEJUmNhwZN5k=;
	b=OYmT1Yup9xjZ1TK/emRP4B/9RBogyQyfBGhsOOy7esq4Cpv28GX0wRf1f0
	vaOsk3YxShqh4oipEU1Q/6v020WDBJqUzintaDYq/Lt9n5K2AbFzvzywKv1T
	zgeNHv3EE7;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Adds the C and header source files for the Cisco PowerTV platform.

Thanks to David Daney and, especially, to Paul Gortmaker for their comments.

History
v3	Added ioremap.h file. Removed usage of MIPS_MT as it doesn't apply
	to the 24K processor. Support PowerTV-specific 48-bit clocksource.
	Moved CEVT_POWERTV and CSRC_POWERTV to arch/mips/powertv/Kconfig from
	arch/mips/Kconfig. Split out ASIC- and model-dependent files. Many,
	many style changes to conform to kernel code style.
v2	Check clocksource function to correspond to changed prototype.
v1	First release

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h          |  109 +++
 arch/mips/include/asm/mach-powertv/asic_regs.h     |  146 ++++
 arch/mips/include/asm/mach-powertv/dma-coherence.h |  124 ++++
 arch/mips/include/asm/mach-powertv/interrupts.h    |  253 +++++++
 arch/mips/include/asm/mach-powertv/ioremap.h       |   92 +++
 arch/mips/include/asm/mach-powertv/war.h           |   28 +
 arch/mips/powertv/Kconfig                          |   33 +
 arch/mips/powertv/Makefile                         |   40 ++
 arch/mips/powertv/asic/Kconfig                     |   28 +
 arch/mips/powertv/asic/Makefile                    |   35 +
 arch/mips/powertv/asic/asic-calliope.c             |   99 +++
 arch/mips/powertv/asic/asic-cronus.c               |   99 +++
 arch/mips/powertv/asic/asic-zeus.c                 |   99 +++
 arch/mips/powertv/asic/asic_devices.c              |  713 ++++++++++++++++++++
 arch/mips/powertv/asic/asic_int.c                  |  125 ++++
 arch/mips/powertv/asic/irq_asic.c                  |  116 ++++
 arch/mips/powertv/asic/prealloc-calliope.c         |  642 ++++++++++++++++++
 arch/mips/powertv/asic/prealloc-cronus.c           |  625 +++++++++++++++++
 arch/mips/powertv/asic/prealloc-cronuslite.c       |  298 ++++++++
 arch/mips/powertv/asic/prealloc-zeus.c             |  471 +++++++++++++
 arch/mips/powertv/cevt-powertv.c                   |  165 +++++
 arch/mips/powertv/cmdline.c                        |   52 ++
 arch/mips/powertv/csrc-powertv.c                   |  180 +++++
 arch/mips/powertv/init.c                           |  128 ++++
 arch/mips/powertv/init.h                           |   30 +
 arch/mips/powertv/memory.c                         |  184 +++++
 arch/mips/powertv/pci/Makefile                     |   28 +
 arch/mips/powertv/pci/fixup-powertv.c              |   36 +
 arch/mips/powertv/pci/powertv-pci.h                |   31 +
 arch/mips/powertv/powertv-clock.h                  |   30 +
 arch/mips/powertv/powertv_setup.c                  |  351 ++++++++++
 arch/mips/powertv/reset.c                          |   70 ++
 arch/mips/powertv/reset.h                          |   28 +
 arch/mips/powertv/time.c                           |   30 +
 34 files changed, 5518 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
new file mode 100644
index 0000000..fd02c4d
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -0,0 +1,109 @@
+/*
+ *				asic.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef _ASM_MACH_POWERTV_ASIC_H
+#define _ASM_MACH_POWERTV_ASIC_H
+
+#include <linux/ioport.h>
+#include <asm/mach-powertv/asic_regs.h>
+
+#define DVR_CAPABLE     (1<<0)
+#define PCIE_CAPABLE    (1<<1)
+#define FFS_CAPABLE     (1<<2)
+#define DISPLAY_CAPABLE (1<<3)
+
+/* Platform Family types
+ * For compitability, the new value must be added in the end */
+enum family_type {
+	FAMILY_8500,
+	FAMILY_8500RNG,
+	FAMILY_4500,
+	FAMILY_1500,
+	FAMILY_8600,
+	FAMILY_4600,
+	FAMILY_4600VZA,
+	FAMILY_8600VZB,
+	FAMILY_1500VZE,
+	FAMILY_1500VZF,
+	FAMILIES
+};
+
+/* Register maps for each ASIC */
+extern const struct register_map calliope_register_map;
+extern const struct register_map cronus_register_map;
+extern const struct register_map zeus_register_map;
+
+extern struct resource dvr_cronus_resources[];
+extern struct resource dvr_zeus_resources[];
+extern struct resource non_dvr_calliope_resources[];
+extern struct resource non_dvr_cronus_resources[];
+extern struct resource non_dvr_cronuslite_resources[];
+extern struct resource non_dvr_vz_calliope_resources[];
+extern struct resource non_dvr_vze_calliope_resources[];
+extern struct resource non_dvr_vzf_calliope_resources[];
+extern struct resource non_dvr_zeus_resources[];
+
+extern void powertv_platform_init(void);
+extern void platform_alloc_bootmem(void);
+extern enum asic_type platform_get_asic(void);
+extern enum family_type platform_get_family(void);
+extern int platform_supports_dvr(void);
+extern int platform_supports_ffs(void);
+extern int platform_supports_pcie(void);
+extern int platform_supports_display(void);
+extern void configure_platform(void);
+extern void platform_configure_usb_ehci(void);
+extern void platform_unconfigure_usb_ehci(void);
+extern void platform_configure_usb_ohci(void);
+extern void platform_unconfigure_usb_ohci(void);
+
+/* Platform Resources */
+#define ASIC_RESOURCE_GET_EXISTS 1
+extern struct resource *asic_resource_get(const char *name);
+extern void platform_release_memory(void *baddr, int size);
+
+/* Reboot Cause */
+extern void set_reboot_cause(char code, unsigned int data, unsigned int data2);
+extern void set_locked_reboot_cause(char code, unsigned int data,
+	unsigned int data2);
+
+enum sys_reboot_type {
+	sys_unknown_reboot = 0x00,	/* Unknown reboot cause */
+	sys_davic_change = 0x01,	/* Reboot due to change in DAVIC
+					 * mode */
+	sys_user_reboot = 0x02,		/* Reboot initiated by user */
+	sys_system_reboot = 0x03,	/* Reboot initiated by OS */
+	sys_trap_reboot = 0x04,		/* Reboot due to a CPU trap */
+	sys_silent_reboot = 0x05,	/* Silent reboot */
+	sys_boot_ldr_reboot = 0x06,	/* Bootloader reboot */
+	sys_power_up_reboot = 0x07,	/* Power on bootup.  Older
+					 * drivers may report as
+					 * userReboot. */
+	sys_code_change = 0x08,		/* Reboot to take code change.
+					 * Older drivers may report as
+					 * userReboot. */
+	sys_hardware_reset = 0x09,	/* HW watchdog or front-panel
+					 * reset button reset.  Older
+					 * drivers may report as
+					 * userReboot. */
+	sys_watchdogInterrupt = 0x0A	/* Pre-watchdog interrupt */
+};
+
+#endif /* _ASM_MACH_POWERTV_ASIC_H */
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
new file mode 100644
index 0000000..32e7391
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -0,0 +1,146 @@
+/*
+ *				asic_regs.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __ASM_MACH_POWERTV_ASIC_H_
+#define __ASM_MACH_POWERTV_ASIC_H_
+#include <linux/io.h>
+
+/* ASIC types */
+enum asic_type {
+	ASIC_UNKNOWN,
+	ASIC_ZEUS,
+	ASIC_CALLIOPE,
+	ASIC_CRONUS,
+	ASIC_CRONUSLITE,
+	ASICS
+};
+
+/* hardcoded values read from Chip Version registers */
+#define CRONUS_10	0x0B4C1C20
+#define CRONUS_11	0x0B4C1C21
+#define CRONUSLITE_10	0x0B4C1C40
+
+#define NAND_FLASH_BASE	0x03000000
+#define ZEUS_IO_BASE	0x09000000
+#define CALLIOPE_IO_BASE	0x08000000
+#define CRONUS_IO_BASE	0x09000000
+#define ASIC_IO_SIZE	0x01000000
+
+/* ASIC register enumeration */
+struct register_map {
+	u32 eic_slow0_strt_add;
+	u32 eic_cfg_bits;
+	u32 eic_ready_status;
+
+	u32 chipver3;
+	u32 chipver2;
+	u32 chipver1;
+	u32 chipver0;
+
+	u32 uart1_intstat;
+	u32 uart1_inten;
+	u32 uart1_config1;
+	u32 uart1_config2;
+	u32 uart1_divisorhi;
+	u32 uart1_divisorlo;
+	u32 uart1_data;
+	u32 uart1_status;
+
+	u32 int_stat_3;
+	u32 int_stat_2;
+	u32 int_stat_1;
+	u32 int_stat_0;
+	u32 int_config;
+	u32 int_int_scan;
+	u32 ien_int_3;
+	u32 ien_int_2;
+	u32 ien_int_1;
+	u32 ien_int_0;
+	u32 int_level_3_3;
+	u32 int_level_3_2;
+	u32 int_level_3_1;
+	u32 int_level_3_0;
+	u32 int_level_2_3;
+	u32 int_level_2_2;
+	u32 int_level_2_1;
+	u32 int_level_2_0;
+	u32 int_level_1_3;
+	u32 int_level_1_2;
+	u32 int_level_1_1;
+	u32 int_level_1_0;
+	u32 int_level_0_3;
+	u32 int_level_0_2;
+	u32 int_level_0_1;
+	u32 int_level_0_0;
+	u32 int_docsis_en;
+
+	u32 mips_pll_setup;
+	u32 usb_fs;
+	u32 test_bus;
+	u32 usb2_ohci_int_mask;
+	u32 usb2_strap;
+	u32 ehci_hcapbase;
+	u32 ohci_hc_revision;
+	u32 bcm1_bs_lmi_steer;
+	u32 usb2_control;
+	u32 usb2_stbus_obc;
+	u32 usb2_stbus_mess_size;
+	u32 usb2_stbus_chunk_size;
+
+	u32 pcie_regs;
+	u32 tim_ch;
+	u32 tim_cl;
+	u32 gpio_dout;
+	u32 gpio_din;
+	u32 gpio_dir;
+	u32 watchdog;
+	u32 front_panel;
+
+	u32 register_maps;
+};
+
+extern enum asic_type asic;
+extern const struct register_map *register_map;
+extern unsigned long asic_phy_base;	/* Physical address of ASIC */
+extern unsigned long asic_base;		/* Virtual address of ASIC */
+
+/*
+ * Macros to interface to registers through their ioremapped address
+ * asic_reg_offset	Returns the offset of a given register from the start
+ *			of the ASIC address space
+ * asic_reg_phys_addr	Returns the physical address of the given register
+ * asic_reg_addr	Returns the iomapped virtual address of the given
+ *			register.
+ */
+#define asic_reg_offset(x)	(register_map->x)
+#define asic_reg_phys_addr(x)	(asic_phy_base + asic_reg_offset(x))
+#define asic_reg_addr(x) \
+	((unsigned int *) (asic_base + asic_reg_offset(x)))
+
+/*
+ * The asic_reg macro is gone. It should be replaced by either asic_read or
+ * asic_write, as appropriate.
+ */
+
+#define asic_read(x)		readl(asic_reg_addr(x))
+#define asic_write(v, x)	writel(v, asic_reg_addr(x))
+
+extern void asic_irq_init(void);
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
new file mode 100644
index 0000000..da31ffb
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -0,0 +1,124 @@
+/*
+ *				dma-coherence.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Version from mach-generic modified to support PowerTV port
+ * Portions Copyright (C) 2009  Cisco Systems, Inc.
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ */
+
+#ifndef __ASM_MACH_POWERTV_DMA_COHERENCE_H
+#define __ASM_MACH_POWERTV_DMA_COHERENCE_H
+
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <linux/device.h>
+#include <asm/mach-powertv/asic.h>
+
+static inline bool is_kseg2(void *addr)
+{
+	return (unsigned long)addr >= KSEG2;
+}
+
+static inline unsigned long virt_to_phys_from_pte(void *addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *ptep, pte;
+
+	unsigned long virt_addr = (unsigned long)addr;
+	unsigned long phys_addr = 0UL;
+
+	/* get the page global directory. */
+	pgd = pgd_offset_k(virt_addr);
+
+	if (!pgd_none(*pgd)) {
+		/* get the page upper directory */
+		pud = pud_offset(pgd, virt_addr);
+		if (!pud_none(*pud)) {
+			/* get the page middle directory */
+			pmd = pmd_offset(pud, virt_addr);
+			if (!pmd_none(*pmd)) {
+				/* get a pointer to the page table entry */
+				ptep = pte_offset(pmd, virt_addr);
+				pte = *ptep;
+				/* check for a valid page */
+				if (pte_present(pte)) {
+					/* get the physical address the page is
+					 * refering to */
+					phys_addr = (unsigned long)
+						page_to_phys(pte_page(pte));
+					/* add the offset within the page */
+					phys_addr |= (virt_addr & ~PAGE_MASK);
+				}
+			}
+		}
+	}
+
+	return phys_addr;
+}
+
+static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
+	size_t size)
+{
+	if (is_kseg2(addr))
+		return phys_to_bus(virt_to_phys_from_pte(addr));
+	else
+		return phys_to_bus(virt_to_phys(addr));
+}
+
+static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
+	struct page *page)
+{
+	return phys_to_bus(page_to_phys(page));
+}
+
+static inline unsigned long plat_dma_addr_to_phys(dma_addr_t dma_addr)
+{
+	return bus_to_phys(dma_addr);
+}
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr)
+{
+}
+
+static inline int plat_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * we fall back to GFP_DMA when the mask isn't all 1s,
+	 * so we can't guarantee allocations that must be
+	 * within a tighter range than GFP_DMA..
+	 */
+	if (mask < DMA_BIT_MASK(24))
+		return 0;
+
+	return 1;
+}
+
+static inline void plat_extra_sync_for_device(struct device *dev)
+{
+	return;
+}
+
+static inline int plat_dma_mapping_error(struct device *dev,
+					 dma_addr_t dma_addr)
+{
+	return 0;
+}
+
+static inline int plat_device_is_coherent(struct device *dev)
+{
+#ifdef CONFIG_DMA_COHERENT
+	return 1;
+#endif
+#ifdef CONFIG_DMA_NONCOHERENT
+	return 0;
+#endif
+}
+
+#endif /* __ASM_MACH_POWERTV_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-powertv/interrupts.h b/arch/mips/include/asm/mach-powertv/interrupts.h
new file mode 100644
index 0000000..e5a92d1
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/interrupts.h
@@ -0,0 +1,253 @@
+/*
+ *				interrupts.h
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef	_ASM_MACH_POWERTV_INTERRUPTS_H_
+#define _ASM_MACH_POWERTV_INTERRUPTS_H_
+
+/*
+ * Defines for all of the interrupt lines
+ */
+
+#define ibase 0
+
+/*------------- Register: int_stat_3 */
+/* 126 unused (bit 31) */
+#define irq_asc2video		(ibase+126)	/* ASC 2 Video Interrupt */
+#define irq_asc1video		(ibase+125)	/* ASC 1 Video Interrupt */
+#define irq_comms_block_wd	(ibase+124)	/* ASC 1 Video Interrupt */
+#define irq_fdma_mailbox	(ibase+123)	/* FDMA Mailbox Output */
+#define irq_fdma_gp		(ibase+122)	/* FDMA GP Output */
+#define irq_mips_pic		(ibase+121)	/* MIPS Performance Counter
+						 * Interrupt */
+#define irq_mips_timer		(ibase+120)	/* MIPS Timer Interrupt */
+#define irq_memory_protect	(ibase+119)	/* Memory Protection Interrupt
+						 * -- Ored by glue logic inside
+						 *  SPARC ILC (see
+						 *  INT_MEM_PROT_STAT, below,
+						 *  for individual interrupts)
+						 */
+/* 118 unused (bit 22) */
+#define irq_sbag		(ibase+117)	/* SBAG Interrupt -- Ored by
+						 * glue logic inside SPARC ILC
+						 * (see INT_SBAG_STAT, below,
+						 * for individual interrupts) */
+#define irq_qam_b_fec		(ibase+116)	/* QAM  B FEC Interrupt */
+#define irq_qam_a_fec		(ibase+115)	/* QAM A FEC Interrupt */
+/* 114 unused 	(bit 18) */
+#define irq_mailbox		(ibase+113)	/* Mailbox Debug Interrupt  --
+						 * Ored by glue logic inside
+						 * SPARC ILC (see
+						 * INT_MAILBOX_STAT, below, for
+						 * individual interrupts) */
+#define irq_fuse_stat1		(ibase+112)	/* Fuse Status 1 */
+#define irq_fuse_stat2		(ibase+111)	/* Fuse Status 2 */
+#define irq_fuse_stat3		(ibase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define irq_blitter		(ibase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define irq_avc1_pp0		(ibase+109)	/* AVC Decoder #1 PP0
+						 * Interrupt */
+#define irq_avc1_pp1		(ibase+108)	/* AVC Decoder #1 PP1
+						 * Interrupt */
+#define irq_avc1_mbe		(ibase+107)	/* AVC Decoder #1 MBE
+						 * Interrupt */
+#define irq_avc2_pp0		(ibase+106)	/* AVC Decoder #2 PP0
+						 * Interrupt */
+#define irq_avc2_pp1		(ibase+105)	/* AVC Decoder #2 PP1
+						 * Interrupt */
+#define irq_avc2_mbe		(ibase+104)	/* AVC Decoder #2 MBE
+						 * Interrupt */
+#define irq_zbug_spi		(ibase+103)	/* Zbug SPI Slave Interrupt */
+#define irq_qam_mod2		(ibase+102)	/* QAM Modulator 2 DMA
+						 * Interrupt */
+#define irq_ir_rx		(ibase+101)	/* IR RX 2 Interrupt */
+#define irq_aud_dsp2		(ibase+100)	/* Audio DSP #2 Interrupt */
+#define irq_aud_dsp1		(ibase+99)	/* Audio DSP #1 Interrupt */
+#define irq_docsis		(ibase+98)	/* DOCSIS Debug Interrupt */
+#define irq_sd_dvp1		(ibase+97)	/* SD DVP #1 Interrupt */
+#define irq_sd_dvp2		(ibase+96)	/* SD DVP #2 Interrupt */
+/*------------- Register: int_stat_2 */
+#define irq_hd_dvp		(ibase+95)	/* HD DVP Interrupt */
+#define kIrq_Prewatchdog	(ibase+94)	/* watchdog Pre-Interrupt */
+#define irq_timer2		(ibase+93)	/* Programmable Timer
+						 * Interrupt 2 */
+#define irq_1394		(ibase+92)	/* 1394 Firewire Interrupt */
+#define irq_usbohci		(ibase+91)	/* USB 2.0 OHCI Interrupt */
+#define irq_usbehci		(ibase+90)	/* USB 2.0 EHCI Interrupt */
+#define irq_pciexp		(ibase+89)	/* PCI Express 0 Interrupt */
+#define irq_pciexp0		(ibase+89)	/* PCI Express 0 Interrupt */
+#define irq_afe1		(ibase+88)	/* AFE 1 Interrupt */
+#define irq_sata		(ibase+87)	/* SATA 1 Interrupt */
+#define irq_sata1		(ibase+87)	/* SATA 1 Interrupt */
+#define irq_dtcp		(ibase+86)	/* DTCP Interrupt */
+#define irq_pciexp1		(ibase+85)	/* PCI Express 1 Interrupt */
+/* 84 unused 	(bit 20) */
+/* 83 unused 	(bit 19) */
+/* 82 unused 	(bit 18) */
+#define irq_sata2		(ibase+81)	/* SATA2 Interrupt */
+#define irq_uart2		(ibase+80)	/* UART2 Interrupt */
+#define irq_legacy_usb		(ibase+79)	/* Legacy USB Host ISR (1.1
+						 * Host module) */
+#define irq_pod			(ibase+78)	/* POD Interrupt */
+#define irq_slave_usb		(ibase+77)	/* Slave USB */
+#define irq_denc1		(ibase+76)	/* DENC #1 VTG Interrupt */
+#define irq_vbi_vtg		(ibase+75)	/* VBI VTG Interrupt */
+#define irq_afe2		(ibase+74)	/* AFE 2 Interrupt */
+#define irq_denc2		(ibase+73)	/* DENC #2 VTG Interrupt */
+#define irq_asc2		(ibase+72)	/* ASC #2 Interrupt */
+#define irq_asc1		(ibase+71)	/* ASC #1 Interrupt */
+#define irq_mod_dma		(ibase+70)	/* Modulator DMA Interrupt */
+#define irq_byte_eng1		(ibase+69)	/* Byte Engine Interrupt [1] */
+#define irq_byte_eng0		(ibase+68)	/* Byte Engine Interrupt [0] */
+/* 67 unused 	(bit 03) */
+/* 66 unused 	(bit 02) */
+/* 65 unused 	(bit 01) */
+/* 64 unused 	(bit 00) */
+/*------------- Register: int_stat_1 */
+/* 63 unused 	(bit 31) */
+/* 62 unused 	(bit 30) */
+/* 61 unused 	(bit 29) */
+/* 60 unused 	(bit 28) */
+/* 59 unused 	(bit 27) */
+/* 58 unused 	(bit 26) */
+/* 57 unused 	(bit 25) */
+/* 56 unused 	(bit 24) */
+#define irq_buf_dma_mem2mem	(ibase+55)	/* BufDMA Memory to Memory
+						 * Interrupt */
+#define irq_buf_dma_usbtransmit	(ibase+54)	/* BufDMA USB Transmit
+						 * Interrupt */
+#define irq_buf_dma_qpskpodtransmit (ibase+53)	/* BufDMA QPSK/POD Tramsit
+						 * Interrupt */
+#define irq_buf_dma_transmit_error (ibase+52)	/* BufDMA Transmit Error
+						 * Interrupt */
+#define irq_buf_dma_usbrecv	(ibase+51)	/* BufDMA USB Receive
+						 * Interrupt */
+#define irq_buf_dma_qpskpodrecv	(ibase+50)	/* BufDMA QPSK/POD Receive
+						 * Interrupt */
+#define irq_buf_dma_recv_error	(ibase+49)	/* BufDMA Receive Error
+						 * Interrupt */
+#define irq_qamdma_transmit_play (ibase+48)	/* QAMDMA Transmit/Play
+						 * Interrupt */
+#define irq_qamdma_transmit_error (ibase+47)	/* QAMDMA Transmit Error
+						 * Interrupt */
+#define irq_qamdma_recv2high	(ibase+46)	/* QAMDMA Receive 2 High
+						 * (Chans 63-32) */
+#define irq_qamdma_recv2low	(ibase+45)	/* QAMDMA Receive 2 Low
+						 * (Chans 31-0) */
+#define irq_qamdma_recv1high	(ibase+44)	/* QAMDMA Receive 1 High
+						 * (Chans 63-32) */
+#define irq_qamdma_recv1low	(ibase+43)	/* QAMDMA Receive 1 Low
+						 * (Chans 31-0) */
+#define irq_qamdma_recv_error	(ibase+42)	/* QAMDMA Receive Error
+						 * Interrupt */
+#define irq_mpegsplice		(ibase+41)	/* MPEG Splice Interrupt */
+#define irq_deinterlace_rdy	(ibase+40)	/* Deinterlacer Frame Ready
+						 * Interrupt */
+#define irq_ext_in0		(ibase+39)	/* External Interrupt irq_in0 */
+#define irq_gpio3		(ibase+38)	/* GP I/O IRQ 3 - From GP I/O
+						 * Module */
+#define irq_gpio2		(ibase+37)	/* GP I/O IRQ 2 - From GP I/O
+						 * Module (ABE_intN) */
+#define irq_pcrcmplt1		(ibase+36)	/* PCR Capture Complete  or
+						 * Discontinuity 1 */
+#define irq_pcrcmplt2		(ibase+35)	/* PCR Capture Complete or
+						 * Discontinuity 2 */
+#define irq_parse_peierr	(ibase+34)	/* PID Parser Error Detect
+						 * (PEI) */
+#define irq_parse_cont_err	(ibase+33)	/* PID Parser continuity error
+						 * detect */
+#define irq_ds1framer		(ibase+32)	/* DS1 Framer Interrupt */
+/*------------- Register: int_stat_0 */
+#define irq_gpio1		(ibase+31)	/* GP I/O IRQ 1 - From GP I/O
+						 * Module */
+#define irq_gpio0		(ibase+30)	/* GP I/O IRQ 0 - From GP I/O
+						 * Module */
+#define irq_qpsk_out_aloha	(ibase+29)	/* QPSK Output Slotted Aloha
+						 * (chan 3) Transmission
+						 * Completed OK */
+#define irq_qpsk_out_tdma	(ibase+28)	/* QPSK Output TDMA (chan 2)
+						 * Transmission Completed OK */
+#define irq_qpsk_out_reserve	(ibase+27)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * Completed OK */
+#define irq_qpsk_out_aloha_err	(ibase+26)	/* QPSK Output Slotted Aloha
+						 * (chan 3)Transmission
+						 * completed with Errors. */
+#define irq_qpsk_out_tdma_err	(ibase+25)	/* QPSK Output TDMA (chan 2)
+						 * Transmission completed with
+						 * Errors. */
+#define irq_qpsk_out_rsrv_err	(ibase+24)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * completed with Errors */
+#define irq_aloha_fail		(ibase+23)	/* Unsuccessful Resend of Aloha
+						 * for N times. Aloha retry
+						 * timeout for channel 3. */
+#define irq_timer1		(ibase+22)	/* Programmable Timer
+						 * Interrupt */
+#define irq_keyboard		(ibase+21)	/* Keyboard Module Interrupt */
+#define irq_i2c			(ibase+20)	/* I2C Module Interrupt */
+#define irq_spi			(ibase+19)	/* SPI Module Interrupt */
+#define irq_irblaster		(ibase+18)	/* IR Blaster Interrupt */
+#define irq_splice_detect	(ibase+17)	/* PID Key Change Interrupt or
+						 * Splice Detect Interrupt */
+#define irq_se_micro		(ibase+16)	/* Secure Micro I/F Module
+						 * Interrupt */
+#define irq_uart1		(ibase+15)	/* UART Interrupt */
+#define irq_irrecv		(ibase+14)	/* IR Receiver Interrupt */
+#define irq_host_int1		(ibase+13)	/* Host-to-Host Interrupt 1 */
+#define irq_host_int0		(ibase+12)	/* Host-to-Host Interrupt 0 */
+#define irq_qpsk_hecerr		(ibase+11)	/* QPSK HEC Error Interrupt */
+#define irq_qpsk_crcerr		(ibase+10)	/* QPSK AAL-5 CRC Error
+						 * Interrupt */
+/* 9 unused 	(bit 09) */
+/* 8 unused 	(bit 08) */
+#define irq_psicrcerr		(ibase+7) 	/* QAM PSI CRC Error
+						 * Interrupt */
+#define irq_psilength_err	(ibase+6) 	/* QAM PSI Length Error
+						 * Interrupt */
+#define irq_esfforward		(ibase+5) 	/* ESF Interrupt Mark From
+						 * Forward Path Reference -
+						 * every 3ms when forward Mbits
+						 * and forward slot control
+						 * bytes are updated. */
+#define irq_esfreverse		(ibase+4) 	/* ESF Interrupt Mark from
+						 * Reverse Path Reference -
+						 * delayed from forward mark by
+						 * the ranging delay plus a
+						 * fixed amount. When reverse
+						 * Mbits and reverse slot
+						 * control bytes are updated.
+						 * Occurs every 3ms for 3.0M and
+						 * 1.554 M upstream rates and
+						 * every 6 ms for 256K upstream
+						 * rate. */
+#define irq_aloha_timeout	(ibase+3) 	/* Slotted-Aloha timeout on
+						 * Channel 1. */
+#define irq_reservation		(ibase+2) 	/* Partial (or Incremental)
+						 * Reservation Message Completed
+						 * or Slotted aloha verify for
+						 * channel 1. */
+#define irq_aloha3		(ibase+1) 	/* Slotted-Aloha Message Verify
+						 * Interrupt or Reservation
+						 * increment completed for
+						 * channel 3. */
+#define irq_mpeg_d		(ibase+0) 	/* MPEG Decoder Interrupt */
+#endif	/* _ASM_MACH_POWERTV_INTERRUPTS_H_ */
+
diff --git a/arch/mips/include/asm/mach-powertv/ioremap.h b/arch/mips/include/asm/mach-powertv/ioremap.h
new file mode 100644
index 0000000..1d3be37
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/ioremap.h
@@ -0,0 +1,92 @@
+/*
+ *				ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ * Portions Copyright (C)  Cisco Systems, Inc.
+ */
+#ifndef __ASM_MACH_POWERTV_IOREMAP_H
+#define __ASM_MACH_POWERTV_IOREMAP_H
+
+#include <linux/types.h>
+
+#define LOW_MEM_BOUNDARY_PHYS	0x20000000
+#define LOW_MEM_BOUNDARY_MASK	(~(LOW_MEM_BOUNDARY_PHYS - 1))
+
+/*
+ * The bus addresses are different than the physical addresses that
+ * the processor sees by an offset. This offset varies by ASIC
+ * version. Define a variable to hold the offset and some macros to
+ * make the conversion simpler. */
+extern unsigned long phys_to_bus_offset;
+
+#ifdef CONFIG_HIGHMEM
+#define MEM_GAP_PHYS		0x60000000
+/*
+ * TODO: We will use the hard code for conversion between physical and
+ * bus until the bootloader releases their device tree to us.
+ */
+#define phys_to_bus(x) (((x) < LOW_MEM_BOUNDARY_PHYS) ? \
+	((x) + phys_to_bus_offset) : (x))
+#define bus_to_phys(x) (((x) < MEM_GAP_PHYS_ADDR) ? \
+	((x) - phys_to_bus_offset) : (x))
+#else
+#define phys_to_bus(x) ((x) + phys_to_bus_offset)
+#define bus_to_phys(x) ((x) - phys_to_bus_offset)
+#endif
+
+/*
+ * Determine whether the address we are given is for an ASIC device
+ * Params:  addr    Address to check
+ * Returns: Zero if the address is not for ASIC devices, non-zero
+ *      if it is.
+ */
+static inline int asic_is_device_addr(phys_t addr)
+{
+	return !((phys_t)addr & (phys_t) LOW_MEM_BOUNDARY_MASK);
+}
+
+/*
+ * Determine whether the address we are given is external RAM mappable
+ * into KSEG1.
+ * Params:  addr    Address to check
+ * Returns: Zero if the address is not for external RAM and
+ */
+static inline int asic_is_lowmem_ram_addr(phys_t addr)
+{
+	/*
+	 * The RAM always starts at the following address in the processor's
+	 * physical address space
+	 */
+	static const phys_t phys_ram_base = 0x10000000;
+	phys_t bus_ram_base;
+
+	bus_ram_base = phys_to_bus_offset + phys_ram_base;
+
+	return addr >= bus_ram_base &&
+		addr < (bus_ram_base + (LOW_MEM_BOUNDARY_PHYS - phys_ram_base));
+}
+
+/*
+ * Allow physical addresses to be fixed up to help peripherals located
+ * outside the low 32-bit range -- generic pass-through version.
+ */
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+static inline void __iomem *plat_ioremap(phys_t offset, unsigned long size,
+	unsigned long flags)
+{
+	return NULL;
+}
+
+static inline int plat_iounmap(const volatile void __iomem *addr)
+{
+	return 0;
+}
+#endif /* __ASM_MACH_POWERTV_IOREMAP_H */
diff --git a/arch/mips/include/asm/mach-powertv/war.h b/arch/mips/include/asm/mach-powertv/war.h
new file mode 100644
index 0000000..7ac05ec
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/war.h
@@ -0,0 +1,28 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This version for the PowerTV platform copied from the Malta version.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ */
+#ifndef __ASM_MACH_POWERTV_WAR_H
+#define __ASM_MACH_POWERTV_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	1
+#define MIPS_CACHE_SYNC_WAR		1
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	1
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MACH_POWERTV_WAR_H */
diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
new file mode 100644
index 0000000..fc9171e
--- /dev/null
+++ b/arch/mips/powertv/Kconfig
@@ -0,0 +1,33 @@
+source "arch/mips/powertv/asic/Kconfig"
+
+config BOOTLOADER_DRIVER
+	bool "PowerTV Bootloader Driver Support"
+	default n
+	depends on POWERTV
+	help
+	  Use this option if you want to load bootloader driver.
+
+config BOOTLOADER_FAMILY
+	string "POWERTV Bootloader Family string"
+	default "85"
+	depends on POWERTV && !BOOTLOADER_DRIVER
+	help
+	  This value should be specified when the bootloader driver is disabled
+	  and must be exactly two characters long. Families supported are:
+	    R1 - RNG-100  R2 - RNG-200
+	    A1 - Class A  B1 - Class B
+	    E1 - Class E  F1 - Class F
+	    44 - 45xx     46 - 46xx
+	    85 - 85xx     86 - 86xx
+
+#
+# Flag for POWERTV clock source.
+#
+config CEVT_POWERTV
+	bool
+
+#
+# Flag for POWERTV clock event.
+#
+config CSRC_POWERTV
+	bool
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
new file mode 100644
index 0000000..145d065
--- /dev/null
+++ b/arch/mips/powertv/Makefile
@@ -0,0 +1,40 @@
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+# Portions copyright (C)  2009 Cisco Systems, Inc.
+#
+# This program is free software; you can distribute it and/or modify it
+# under the terms of the GNU General Public License (Version 2) as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+# for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+#
+# Makefile for the Cisco PowerTV-specific kernel interface routines
+# under Linux.
+#
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_POWERTV)	+=	cmdline.o \
+				init.o \
+				memory.o \
+				reset.o \
+				time.o \
+				powertv_setup.o \
+				asic/ \
+				pci/
+
+obj-$(CONFIG_CEVT_POWERTV)	+=	cevt-powertv.o
+obj-$(CONFIG_CSRC_POWERTV)	+=	csrc-powertv.o
diff --git a/arch/mips/powertv/asic/Kconfig b/arch/mips/powertv/asic/Kconfig
new file mode 100644
index 0000000..2016bfe
--- /dev/null
+++ b/arch/mips/powertv/asic/Kconfig
@@ -0,0 +1,28 @@
+config MIN_RUNTIME_RESOURCES
+	bool "Support for minimum runtime resources"
+	default n
+	depends on POWERTV
+	help
+	  Enables support for minimizing the number of (SA asic) runtime
+	  resources that are preallocated by the kernel.
+
+config MIN_RUNTIME_DOCSIS
+	bool "Support for minimum DOCSIS resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated DOCSIS resource.
+
+config MIN_RUNTIME_PMEM
+	bool "Support for minimum PMEM resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated Memory resource.
+
+config MIN_RUNTIME_TFTP
+	bool "Support for minimum TFTP resource"
+	default y
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated TFTP resource.
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
new file mode 100644
index 0000000..873d079
--- /dev/null
+++ b/arch/mips/powertv/asic/Makefile
@@ -0,0 +1,35 @@
+# *****************************************************************************
+#                          Make file for PowerTV Asic related files
+#
+# Copyright (C) 2009  Scientific-Atlanta, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# *****************************************************************************
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_POWERTV)	+=	asic-calliope.o \
+				asic-cronus.o \
+				asic-zeus.o \
+				asic_devices.o \
+				asic_int.o \
+				irq_asic.o \
+				prealloc-calliope.o \
+				prealloc-cronus.o \
+				prealloc-cronuslite.o \
+				prealloc-zeus.o
diff --git a/arch/mips/powertv/asic/asic-calliope.c b/arch/mips/powertv/asic/asic-calliope.c
new file mode 100644
index 0000000..3bc890b
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-calliope.c
@@ -0,0 +1,99 @@
+/*
+ *                   		asic-calliope.c
+ *
+ * Locations of devices in the Calliope ASIC.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map calliope_register_map = {
+	.eic_slow0_strt_add = 0x800000,
+	.eic_cfg_bits = 0x800038,
+	.eic_ready_status = 0x80004c,
+
+	.chipver3 = 0xA00800,
+	.chipver2 = 0xA00804,
+	.chipver1 = 0xA00808,
+	.chipver0 = 0xA0080c,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0xA01800,
+	.uart1_inten = 0xA01804,
+	.uart1_config1 = 0xA01808,
+	.uart1_config2 = 0xA0180C,
+	.uart1_divisorhi = 0xA01810,
+	.uart1_divisorlo = 0xA01814,
+	.uart1_data = 0xA01818,
+	.uart1_status = 0xA0181C,
+
+	.int_stat_3 = 0xA02800,
+	.int_stat_2 = 0xA02804,
+	.int_stat_1 = 0xA02808,
+	.int_stat_0 = 0xA0280c,
+	.int_config = 0xA02810,
+	.int_int_scan = 0xA02818,
+	.ien_int_3 = 0xA02830,
+	.ien_int_2 = 0xA02834,
+	.ien_int_1 = 0xA02838,
+	.ien_int_0 = 0xA0283c,
+	.int_level_3_3 = 0xA02880,
+	.int_level_3_2 = 0xA02884,
+	.int_level_3_1 = 0xA02888,
+	.int_level_3_0 = 0xA0288c,
+	.int_level_2_3 = 0xA02890,
+	.int_level_2_2 = 0xA02894,
+	.int_level_2_1 = 0xA02898,
+	.int_level_2_0 = 0xA0289c,
+	.int_level_1_3 = 0xA028a0,
+	.int_level_1_2 = 0xA028a4,
+	.int_level_1_1 = 0xA028a8,
+	.int_level_1_0 = 0xA028ac,
+	.int_level_0_3 = 0xA028b0,
+	.int_level_0_2 = 0xA028b4,
+	.int_level_0_1 = 0xA028b8,
+	.int_level_0_0 = 0xA028bc,
+	.int_docsis_en = 0xA028F4,
+
+	.mips_pll_setup = 0x980000,
+	.usb_fs = 0x980030,     	/* -default 72800028- */
+	.test_bus = 0x9800CC,
+	.usb2_ohci_int_mask = 0x9A000c,
+	.usb2_strap = 0x9A0014,
+	.ehci_hcapbase = 0x9BFE00,
+	.ohci_hc_revision = 0x9BFC00,
+	.bcm1_bs_lmi_steer = 0x9E0004,
+	.usb2_control = 0x9E0054,
+	.usb2_stbus_obc = 0x9BFF00,
+	.usb2_stbus_mess_size = 0x9BFF04,
+	.usb2_stbus_chunk_size = 0x9BFF08,
+
+	.pcie_regs = 0x000000,      	/* -doesn't exist- */
+	.tim_ch = 0xA02C10,
+	.tim_cl = 0xA02C14,
+	.gpio_dout = 0xA02c20,
+	.gpio_din = 0xA02c24,
+	.gpio_dir = 0xA02c2C,
+	.watchdog = 0xA02c30,
+	.front_panel = 0x000000,    	/* -not used- */
+};
diff --git a/arch/mips/powertv/asic/asic-cronus.c b/arch/mips/powertv/asic/asic-cronus.c
new file mode 100644
index 0000000..5c2979e
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-cronus.c
@@ -0,0 +1,99 @@
+/*
+ *                   		asic-cronus.c
+ *
+ * Locations of devices in the Cronus ASIC
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map cronus_register_map = {
+	.eic_slow0_strt_add = 0x000000,
+	.eic_cfg_bits = 0x000038,
+	.eic_ready_status = 0x00004C,
+
+	.chipver3 = 0x2A0800,
+	.chipver2 = 0x2A0804,
+	.chipver1 = 0x2A0808,
+	.chipver0 = 0x2A080C,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0x2A1800,
+	.uart1_inten = 0x2A1804,
+	.uart1_config1 = 0x2A1808,
+	.uart1_config2 = 0x2A180C,
+	.uart1_divisorhi = 0x2A1810,
+	.uart1_divisorlo = 0x2A1814,
+	.uart1_data = 0x2A1818,
+	.uart1_status = 0x2A181C,
+
+	.int_stat_3 = 0x2A2800,
+	.int_stat_2 = 0x2A2804,
+	.int_stat_1 = 0x2A2808,
+	.int_stat_0 = 0x2A280C,
+	.int_config = 0x2A2810,
+	.int_int_scan = 0x2A2818,
+	.ien_int_3 = 0x2A2830,
+	.ien_int_2 = 0x2A2834,
+	.ien_int_1 = 0x2A2838,
+	.ien_int_0 = 0x2A283C,
+	.int_level_3_3 = 0x2A2880,
+	.int_level_3_2 = 0x2A2884,
+	.int_level_3_1 = 0x2A2888,
+	.int_level_3_0 = 0x2A288C,
+	.int_level_2_3 = 0x2A2890,
+	.int_level_2_2 = 0x2A2894,
+	.int_level_2_1 = 0x2A2898,
+	.int_level_2_0 = 0x2A289C,
+	.int_level_1_3 = 0x2A28A0,
+	.int_level_1_2 = 0x2A28A4,
+	.int_level_1_1 = 0x2A28A8,
+	.int_level_1_0 = 0x2A28AC,
+	.int_level_0_3 = 0x2A28B0,
+	.int_level_0_2 = 0x2A28B4,
+	.int_level_0_1 = 0x2A28B8,
+	.int_level_0_0 = 0x2A28BC,
+	.int_docsis_en = 0x2A28F4,
+
+	.mips_pll_setup = 0x1C0000,
+	.usb_fs = 0x1C0018,
+	.test_bus = 0x1C00CC,
+	.usb2_ohci_int_mask = 0x20000C,
+	.usb2_strap = 0x200014,
+	.ehci_hcapbase = 0x21FE00,
+	.ohci_hc_revision = 0x1E0000,
+	.bcm1_bs_lmi_steer = 0x2E0008,
+	.usb2_control = 0x2E004C,
+	.usb2_stbus_obc = 0x21FF00,
+	.usb2_stbus_mess_size = 0x21FF04,
+	.usb2_stbus_chunk_size = 0x21FF08,
+
+	.pcie_regs = 0x220000,
+	.tim_ch = 0x2A2C10,
+	.tim_cl = 0x2A2C14,
+	.gpio_dout = 0x2A2C20,
+	.gpio_din = 0x2A2C24,
+	.gpio_dir = 0x2A2C2C,
+	.watchdog = 0x2A2C30,
+	.front_panel = 0x2A3800,
+};
diff --git a/arch/mips/powertv/asic/asic-zeus.c b/arch/mips/powertv/asic/asic-zeus.c
new file mode 100644
index 0000000..ec95abd
--- /dev/null
+++ b/arch/mips/powertv/asic/asic-zeus.c
@@ -0,0 +1,99 @@
+/*
+ *                   		asic-zeus.c
+ *
+ * Locations of devices in the Zeus ASIC
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ */
+
+#include <asm/mach-powertv/asic.h>
+
+const struct register_map zeus_register_map = {
+	.eic_slow0_strt_add = 0x000000,
+	.eic_cfg_bits = 0x000038,
+	.eic_ready_status = 0x00004c,
+
+	.chipver3 = 0x280800,
+	.chipver2 = 0x280804,
+	.chipver1 = 0x280808,
+	.chipver0 = 0x28080c,
+
+	/* The registers of IRBlaster */
+	.uart1_intstat = 0x281800,
+	.uart1_inten = 0x281804,
+	.uart1_config1 = 0x281808,
+	.uart1_config2 = 0x28180C,
+	.uart1_divisorhi = 0x281810,
+	.uart1_divisorlo = 0x281814,
+	.uart1_data = 0x281818,
+	.uart1_status = 0x28181C,
+
+	.int_stat_3 = 0x282800,
+	.int_stat_2 = 0x282804,
+	.int_stat_1 = 0x282808,
+	.int_stat_0 = 0x28280c,
+	.int_config = 0x282810,
+	.int_int_scan = 0x282818,
+	.ien_int_3 = 0x282830,
+	.ien_int_2 = 0x282834,
+	.ien_int_1 = 0x282838,
+	.ien_int_0 = 0x28283c,
+	.int_level_3_3 = 0x282880,
+	.int_level_3_2 = 0x282884,
+	.int_level_3_1 = 0x282888,
+	.int_level_3_0 = 0x28288c,
+	.int_level_2_3 = 0x282890,
+	.int_level_2_2 = 0x282894,
+	.int_level_2_1 = 0x282898,
+	.int_level_2_0 = 0x28289c,
+	.int_level_1_3 = 0x2828a0,
+	.int_level_1_2 = 0x2828a4,
+	.int_level_1_1 = 0x2828a8,
+	.int_level_1_0 = 0x2828ac,
+	.int_level_0_3 = 0x2828b0,
+	.int_level_0_2 = 0x2828b4,
+	.int_level_0_1 = 0x2828b8,
+	.int_level_0_0 = 0x2828bc,
+	.int_docsis_en = 0x2828F4,
+
+	.mips_pll_setup = 0x1a0000,
+	.usb_fs = 0x1a0018,
+	.test_bus = 0x1a0238,
+	.usb2_ohci_int_mask = 0x1e000c,
+	.usb2_strap = 0x1e0014,
+	.ehci_hcapbase = 0x1FFE00,
+	.ohci_hc_revision = 0x1FFC00,
+	.bcm1_bs_lmi_steer = 0x2C0008,
+	.usb2_control = 0x2c01a0,
+	.usb2_stbus_obc = 0x1FFF00,
+	.usb2_stbus_mess_size = 0x1FFF04,
+	.usb2_stbus_chunk_size = 0x1FFF08,
+
+	.pcie_regs = 0x200000,
+	.tim_ch = 0x282C10,
+	.tim_cl = 0x282C14,
+	.gpio_dout = 0x282c20,
+	.gpio_din = 0x282c24,
+	.gpio_dir = 0x282c2C,
+	.watchdog = 0x282c30,
+	.front_panel = 0x283800,
+};
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
new file mode 100644
index 0000000..842e2fc
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -0,0 +1,713 @@
+/*
+ *                   ASIC Device List Intialization
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *****************************************************************************
+ *
+ * File Name:    asic_devices.c
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ *
+ * NOTE: The bootloader allocates persistent memory at an address which is
+ * 16 MiB below the end of the highest address in KSEG0. All fixed
+ * address memory reservations must avoid this region.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/resource.h>
+#include <linux/serial_reg.h>
+#include <linux/io.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <asm/page.h>
+#include <linux/swap.h>
+#include <linux/highmem.h>
+
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/interrupts.h>
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+#include <asm/mach-powertv/kbldr.h>
+#endif
+
+#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
+
+/*
+ * Forward Prototypes
+ */
+static void pmem_setup_resource(void);
+
+/*
+ * Global Variables
+ */
+enum asic_type asic;
+
+unsigned int platform_features;
+unsigned int platform_family;
+const struct register_map  *register_map;
+EXPORT_SYMBOL(register_map);			/* Exported for testing */
+unsigned long asic_phy_base;
+unsigned long asic_base;
+EXPORT_SYMBOL(asic_base);			/* Exported for testing */
+struct resource *gp_resources;
+static bool usb_configured;
+
+/*
+ * Don't recommend to use it directly, it is usually used by kernel internally.
+ * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
+ */
+unsigned long phys_to_bus_offset;
+EXPORT_SYMBOL(phys_to_bus_offset);
+
+/*
+ *
+ * IO Resource Definition
+ *
+ */
+
+struct resource asic_resource = {
+	.name  = "ASIC Resource",
+	.start = 0,
+	.end   = ASIC_IO_SIZE,
+	.flags = IORESOURCE_MEM,
+};
+
+/*
+ *
+ * USB Host Resource Definition
+ *
+ */
+
+static struct resource ehci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbehci,
+		.end    = irq_usbehci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = 0xffffffffULL;
+
+static struct platform_device ehci_device = {
+	.name = "powertv-ehci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ehci_resources,
+	.dev = {
+		.dma_mask = &ehci_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+
+static struct resource ohci_resources[] = {
+	{
+		.parent = &asic_resource,
+		.start  = 0,
+		.end    = 0xff,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = irq_usbohci,
+		.end    = irq_usbohci,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 ohci_dmamask = 0xffffffffULL;
+
+static struct platform_device ohci_device = {
+	.name = "powertv-ohci",
+	.id = 0,
+	.num_resources = 2,
+	.resource = ohci_resources,
+	.dev = {
+		.dma_mask = &ohci_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+
+static struct platform_device *platform_devices[] = {
+	&ehci_device,
+	&ohci_device,
+};
+
+/*
+ *
+ * Platform Configuration and Device Initialization
+ *
+ */
+static void __init fs_update(int pe, int md, int sdiv, int disable_div_by_3)
+{
+	int en_prg, byp, pwr, nsb, val;
+	int sout;
+
+	sout = 1;
+	en_prg = 1;
+	byp = 0;
+	nsb = 1;
+	pwr = 1;
+
+	val = ((sdiv << 29) | (md << 24) | (pe<<8) | (sout<<3) | (byp<<2) |
+		(nsb<<1) | (disable_div_by_3<<5));
+
+	asic_write(val, usb_fs);
+	asic_write(val | (en_prg<<4), usb_fs);
+	asic_write(val | (en_prg<<4) | pwr, usb_fs);
+}
+
+/*
+ * platform_get_family - determine major platform family type.
+ *
+ * Returns family type; -1 if none
+ *
+ */
+enum family_type platform_get_family(void)
+{
+	unsigned short bootldr_family;
+	static enum family_type family = -1;
+	static int first_time = 1;
+
+	if (first_time) {
+		first_time = 0;
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+		bootldr_family = (unsigned short) kbldr_GetSWFamily();
+#else
+#if defined(CONFIG_BOOTLOADER_FAMILY)
+		bootldr_family = (unsigned short) BOOTLDRFAMILY(
+			CONFIG_BOOTLOADER_FAMILY[0],
+			CONFIG_BOOTLOADER_FAMILY[1]);
+#else
+#error "Unknown Bootloader Family"
+#endif
+#endif
+
+		pr_info("Bootloader Family = 0x%04X\n", bootldr_family);
+
+		switch (bootldr_family) {
+		case BOOTLDRFAMILY('R', '1'):
+			family = FAMILY_1500;
+			break;
+		case BOOTLDRFAMILY('4', '4'):
+			family = FAMILY_4500;
+			break;
+		case BOOTLDRFAMILY('4', '6'):
+			family = FAMILY_4600;
+			break;
+		case BOOTLDRFAMILY('A', '1'):
+			family = FAMILY_4600VZA;
+			break;
+		case BOOTLDRFAMILY('8', '5'):
+			family = FAMILY_8500;
+			break;
+		case BOOTLDRFAMILY('R', '2'):
+			family = FAMILY_8500RNG;
+			break;
+		case BOOTLDRFAMILY('8', '6'):
+			family = FAMILY_8600;
+			break;
+		case BOOTLDRFAMILY('B', '1'):
+			family = FAMILY_8600VZB;
+			break;
+		case BOOTLDRFAMILY('E', '1'):
+			family = FAMILY_1500VZE;
+			break;
+		case BOOTLDRFAMILY('F', '1'):
+			family = FAMILY_1500VZF;
+			break;
+		default:
+			family = -1;
+		}
+	}
+
+	return family;
+}
+EXPORT_SYMBOL(platform_get_family);
+
+/*
+ * platform_get_asic - determine the ASIC type.
+ *
+ * \param     none
+ *
+ * \return    ASIC type; ASIC_UNKNOWN if none
+ *
+ */
+enum asic_type platform_get_asic(void)
+{
+	return asic;
+}
+EXPORT_SYMBOL(platform_get_asic);
+
+/**
+ * platform_configure_usb - usb configuration based on platform type.
+ * @divide_by_3: Non-zero to divide clock setting by 3
+ */
+static void platform_configure_usb(void)
+{
+	int divide_by_3;
+
+	if (usb_configured)
+		return;
+
+	switch (asic) {
+	case ASIC_ZEUS:
+	case ASIC_CRONUS:
+	case ASIC_CRONUSLITE:
+		divide_by_3 = 0;
+		break;
+
+	case ASIC_CALLIOPE:
+		divide_by_3 = 1;
+		break;
+
+	default:
+		pr_err("Unknown ASIC type: %d\n", asic);
+		divide_by_3 = 0;
+		break;
+	}
+
+	/* Set up PLL for USB */
+	fs_update(0x0000, 0x11, 0x02, divide_by_3);
+	/* turn on USB power */
+	asic_write(0, usb2_strap);
+	/* Enable all OHCI interrupts */
+	asic_write(0x00000803, usb2_control);
+	/* usb2_stbus_obc store32/load32 */
+	asic_write(3, usb2_stbus_obc);
+	/* usb2_stbus_mess_size 2 packets */
+	asic_write(1, usb2_stbus_mess_size);
+	/* usb2_stbus_chunk_size 2 packets */
+	asic_write(1, usb2_stbus_chunk_size);
+
+	usb_configured = true;
+}
+
+/*
+ * Set up the USB EHCI interface
+ */
+void platform_configure_usb_ehci()
+{	platform_configure_usb();
+}
+
+/*
+ * Set up the USB OHCI interface
+ */
+void platform_configure_usb_ohci()
+{	platform_configure_usb();
+}
+
+/*
+ * Shut the USB EHCI interface down--currently a NOP
+ */
+void platform_unconfigure_usb_ehci()
+{
+}
+
+/*
+ * Shut the USB OHCI interface down--currently a NOP
+ */
+void platform_unconfigure_usb_ohci()
+{
+}
+
+/**
+ * configure_platform - configuration based on platform type.
+ */
+void __init configure_platform(void)
+{
+	platform_family = platform_get_family();
+
+	switch (platform_family) {
+	case FAMILY_1500:
+	case FAMILY_1500VZE:
+	case FAMILY_1500VZF:
+		platform_features = FFS_CAPABLE;
+		asic = ASIC_CALLIOPE;
+		asic_phy_base = CALLIOPE_IO_BASE;
+		register_map = &calliope_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+
+		if (platform_family == FAMILY_1500VZE) {
+			gp_resources = non_dvr_vze_calliope_resources;
+			pr_info("Platform: 1500/Vz Class E - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else if (platform_family == FAMILY_1500VZF) {
+			gp_resources = non_dvr_vzf_calliope_resources;
+			pr_info("Platform: 1500/Vz Class F - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else {
+			gp_resources = non_dvr_calliope_resources;
+			pr_info("Platform: 1500/RNG100 - CALLIOPE, "
+				"NON_DVR_CAPABLE\n");
+		}
+		break;
+
+	case FAMILY_4500:
+		platform_features = FFS_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_ZEUS;
+		asic_phy_base = ZEUS_IO_BASE;
+		register_map = &zeus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_zeus_resources;
+
+		pr_info("Platform: 4500 - ZEUS, NON_DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_4600:
+	{
+		unsigned int chipversion = 0;
+
+		/* The settop has PCIE but it isn't used, so don't advertise
+		 * it*/
+		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
+		asic_phy_base = CRONUS_IO_BASE;   /* same as Cronus */
+		register_map = &cronus_register_map;   /* same as Cronus */
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_cronuslite_resources;
+
+		/* ASIC version will determine if this is a real CronusLite or
+		 * Castrati(Cronus) */
+		chipversion  = asic_read(chipver3) << 24;
+		chipversion |= asic_read(chipver2) << 16;
+		chipversion |= asic_read(chipver1) << 8;
+		chipversion |= asic_read(chipver0);
+
+		if ((chipversion == CRONUS_10) || (chipversion == CRONUS_11))
+			asic = ASIC_CRONUS;
+		else
+			asic = ASIC_CRONUSLITE;
+
+		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
+			"chipversion=0x%08X\n",
+			(asic == ASIC_CRONUS) ? "CRONUS" : "CRONUS LITE",
+			chipversion);
+		break;
+	}
+	case FAMILY_4600VZA:
+		platform_features = FFS_CAPABLE | DISPLAY_CAPABLE;
+		asic = ASIC_CRONUS;
+		asic_phy_base = CRONUS_IO_BASE;
+		register_map = &cronus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = non_dvr_cronus_resources;
+
+		pr_info("Platform: Vz Class A - CRONUS, NON_DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_8500:
+	case FAMILY_8500RNG:
+		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_ZEUS;
+		asic_phy_base = ZEUS_IO_BASE;
+		register_map = &zeus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = dvr_zeus_resources;
+		break;
+
+	case FAMILY_8600:
+	case FAMILY_8600VZB:
+		platform_features = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		asic = ASIC_CRONUS;
+		asic_phy_base = CRONUS_IO_BASE;
+		register_map = &cronus_register_map;
+		asic_base = (unsigned long)ioremap_nocache(asic_phy_base,
+			ASIC_IO_SIZE);
+		gp_resources = dvr_cronus_resources;
+
+		pr_info("Platform: 8600/Vz Class B - CRONUS, "
+			"DVR_CAPABLE\n");
+		break;
+
+	default:
+		platform_features = 0;
+		asic = ASIC_UNKNOWN;
+		asic_phy_base = 0;
+		register_map = NULL;
+		gp_resources = NULL;
+
+		pr_crit("Platform:  UNKNOWN PLATFORM\n");
+		break;
+	}
+
+	platform_configure_usb();
+
+	switch (asic) {
+	case ASIC_ZEUS:
+		phys_to_bus_offset = 0x30000000;
+		break;
+	case ASIC_CALLIOPE:
+		phys_to_bus_offset = 0x10000000;
+		break;
+	case ASIC_CRONUSLITE:
+		/* Fall through */
+	case ASIC_CRONUS:
+		/*
+		 * TODO: We suppose 0x10000000 aliases into 0x20000000-
+		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
+		 * 0x6XXXXXXX, the offset should be 0x50000000, not 0x10000000.
+		 */
+		phys_to_bus_offset = 0x10000000;
+		break;
+	default:
+		phys_to_bus_offset = 0x00000000;
+		break;
+	}
+}
+
+/**
+ * platform_devices_init - sets up USB device resourse.
+ */
+static int __init platform_devices_init(void)
+{
+	pr_notice("%s: ----- Initializing USB resources -----\n", __func__);
+
+	asic_resource.start = asic_phy_base;
+	asic_resource.end += asic_resource.start;
+
+	ehci_resources[0].start = asic_reg_phys_addr(ehci_hcapbase);
+	ehci_resources[0].end += ehci_resources[0].start;
+
+	ohci_resources[0].start = asic_reg_phys_addr(ohci_hc_revision);
+	ohci_resources[0].end += ohci_resources[0].start;
+
+	set_io_port_base(0);
+
+	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+
+	return 0;
+}
+
+arch_initcall(platform_devices_init);
+
+/*
+ *
+ * BOOTMEM ALLOCATION
+ *
+ */
+/*
+ * Allocates/reserves the Platform memory resources early in the boot process.
+ * This ignores any resources that are designated IORESOURCE_IO
+ */
+void __init platform_alloc_bootmem(void)
+{
+	int i;
+	int total = 0;
+
+	/* Get persistent memory data from command line before allocating
+	 * resources. This need to happen before normal command line parsing
+	 * has been done */
+	pmem_setup_resource();
+
+	/* Loop through looking for resources that want a particular address */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		int size = gp_resources[i].end - gp_resources[i].start + 1;
+		if ((gp_resources[i].start != 0) &&
+			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
+			reserve_bootmem(bus_to_phys(gp_resources[i].start),
+				size, 0);
+			total += gp_resources[i].end -
+				gp_resources[i].start + 1;
+			pr_info("reserve resource %s at %08x (%u bytes)\n",
+				gp_resources[i].name, gp_resources[i].start,
+				gp_resources[i].end -
+					gp_resources[i].start + 1);
+		}
+	}
+
+	/* Loop through assigning addresses for those that are left */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		int size = gp_resources[i].end - gp_resources[i].start + 1;
+		if ((gp_resources[i].start == 0) &&
+			((gp_resources[i].flags & IORESOURCE_MEM) != 0)) {
+			void *mem = alloc_bootmem_pages(size);
+
+			if (mem == NULL)
+				pr_err("Unable to allocate bootmem pages "
+					"for %s\n", gp_resources[i].name);
+
+			else {
+				gp_resources[i].start =
+					phys_to_bus(virt_to_phys(mem));
+				gp_resources[i].end =
+					gp_resources[i].start + size - 1;
+				total += size;
+				pr_info("allocate resource %s at %08x "
+						"(%u bytes)\n",
+					gp_resources[i].name,
+					gp_resources[i].start, size);
+			}
+		}
+	}
+
+	pr_info("Total Platform driver memory allocation: 0x%08x\n", total);
+
+	/* indicate resources that are platform I/O related */
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		if ((gp_resources[i].start != 0) &&
+			((gp_resources[i].flags & IORESOURCE_IO) != 0)) {
+			pr_info("reserved platform resource %s at %08x\n",
+				gp_resources[i].name, gp_resources[i].start);
+		}
+	}
+}
+
+/*
+ *
+ * PERSISTENT MEMORY (PMEM) CONFIGURATION
+ *
+ */
+static unsigned long pmemaddr __initdata;
+
+static int __init early_param_pmemaddr(char *p)
+{
+	pmemaddr = (unsigned long)simple_strtoul(p, NULL, 0);
+	return 0;
+}
+early_param("pmemaddr", early_param_pmemaddr);
+
+static long pmemlen __initdata;
+
+static int __init early_param_pmemlen(char *p)
+{
+/* TODO: we can use this code when and if the bootloader ever changes this */
+#if 0
+	pmemlen = (unsigned long)simple_strtoul(p, NULL, 0);
+#else
+	pmemlen = 0x20000;
+#endif
+	return 0;
+}
+early_param("pmemlen", early_param_pmemlen);
+
+/*
+ * Set up persistent memory. If we were given values, we patch the array of
+ * resources. Otherwise, persistent memory may be allocated anywhere at all.
+ */
+static void __init pmem_setup_resource(void)
+{
+	struct resource *resource;
+	resource = asic_resource_get("DiagPersistentMemory");
+
+	if (resource && pmemaddr && pmemlen) {
+		/* The address provided by bootloader is in kseg0. Convert to
+		 * a bus address. */
+		resource->start = phys_to_bus(pmemaddr - 0x80000000);
+		resource->end = resource->start + pmemlen - 1;
+
+		pr_info("persistent memory: start=0x%x  end=0x%x\n",
+			resource->start, resource->end);
+	}
+}
+
+/*
+ *
+ * RESOURCE ACCESS FUNCTIONS
+ *
+ */
+
+/**
+ * asic_resource_get - retrieves parameters for a platform resource.
+ * @name:	string to match resource
+ *
+ * Returns a pointer to a struct resource corresponding to the given name.
+ *
+ * CANNOT BE NAMED platform_resource_get, which would be the obvious choice,
+ * as this function name is already declared
+ */
+struct resource *asic_resource_get(const char *name)
+{
+	int i;
+
+	for (i = 0; gp_resources[i].flags != 0; i++) {
+		if (strcmp(gp_resources[i].name, name) == 0)
+			return &gp_resources[i];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(asic_resource_get);
+
+/**
+ * platform_release_memory - release pre-allocated memory
+ * @ptr:	pointer to memory to release
+ * @size:	size of resource
+ *
+ * This must only be called for memory allocated or reserved via the boot
+ * memory allocator.
+ */
+void platform_release_memory(void *ptr, int size)
+{
+	unsigned long addr;
+	unsigned long end;
+
+	addr = ((unsigned long)ptr + (PAGE_SIZE - 1)) & PAGE_MASK;
+	end = ((unsigned long)ptr + size) & PAGE_MASK;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(__va(addr)));
+		init_page_count(virt_to_page(__va(addr)));
+		free_page((unsigned long)__va(addr));
+	}
+}
+EXPORT_SYMBOL(platform_release_memory);
+
+/*
+ *
+ * FEATURE AVAILABILITY FUNCTIONS
+ *
+ */
+int platform_supports_dvr(void)
+{
+	return (platform_features & DVR_CAPABLE) != 0;
+}
+
+int platform_supports_ffs(void)
+{
+	return (platform_features & FFS_CAPABLE) != 0;
+}
+
+int platform_supports_pcie(void)
+{
+	return (platform_features & PCIE_CAPABLE) != 0;
+}
+
+int platform_supports_display(void)
+{
+	return (platform_features & DISPLAY_CAPABLE) != 0;
+}
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
new file mode 100644
index 0000000..ba60bd6
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -0,0 +1,125 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
+ * Portions copyright (C) 2009  Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Routines for generic manipulation of the interrupts found on the PowerTV
+ * platform.
+ *
+ * The interrupt controller is located in the South Bridge a PIIX4 device
+ * with two internal 82C95 interrupt controllers.
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/kernel.h>
+#include <linux/random.h>
+
+#include <asm/irq_cpu.h>
+#include <linux/io.h>
+#include <asm/irq_regs.h>
+#include <asm/mips-boards/generic.h>
+
+#include <asm/mach-powertv/asic_regs.h>
+
+static DEFINE_SPINLOCK(asic_irq_lock);
+
+static inline int get_int(void)
+{
+	unsigned long flags;
+	int irq;
+
+	spin_lock_irqsave(&asic_irq_lock, flags);
+
+	irq = (asic_read(int_int_scan) >> 4) - 1;
+
+	if (irq == 0 || irq >= NR_IRQS)
+		irq = -1;
+
+	spin_unlock_irqrestore(&asic_irq_lock, flags);
+
+	return irq;
+}
+
+static void asic_irqdispatch(void)
+{
+	int irq;
+
+	irq = get_int();
+	if (irq < 0)
+		return;  /* interrupt has already been cleared */
+
+	do_IRQ(irq);
+}
+
+static inline int clz(unsigned long x)
+{
+	__asm__(
+	"	.set	push					\n"
+	"	.set	mips32					\n"
+	"	clz	%0, %1					\n"
+	"	.set	pop					\n"
+	: "=r" (x)
+	: "r" (x));
+
+	return x;
+}
+
+/*
+ * Version of ffs that only looks at bits 12..15.
+ */
+static inline unsigned int irq_ffs(unsigned int pending)
+{
+	return -clz(pending) + 31 - CAUSEB_IP;
+}
+
+/*
+ * TODO: check how it works under EIC mode.
+ */
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
+	int irq;
+
+	irq = irq_ffs(pending);
+
+	if (irq == CAUSEF_IP3)
+		asic_irqdispatch();
+	else if (irq >= 0)
+		do_IRQ(irq);
+	else
+		spurious_interrupt();
+}
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	asic_irq_init();
+
+	/*
+	 * Initialize interrupt exception vectors.
+	 */
+	if (cpu_has_veic || cpu_has_vint) {
+		int nvec = cpu_has_veic ? 64 : 8;
+		for (i = 0; i < nvec; i++)
+			set_vi_handler(i, asic_irqdispatch);
+	}
+}
diff --git a/arch/mips/powertv/asic/irq_asic.c b/arch/mips/powertv/asic/irq_asic.c
new file mode 100644
index 0000000..b54d244
--- /dev/null
+++ b/arch/mips/powertv/asic/irq_asic.c
@@ -0,0 +1,116 @@
+/*
+ * Portions copyright (C) 2005-2009 Scientific Atlanta
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * Modified from arch/mips/kernel/irq-rm7000.c:
+ * Copyright (C) 2003 Ralf Baechle
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+#include <asm/system.h>
+
+#include <asm/mach-powertv/asic_regs.h>
+
+static inline void unmask_asic_irq(unsigned int irq)
+{
+	unsigned long enable_bit;
+
+	enable_bit = (1 << (irq & 0x1f));
+
+	switch (irq >> 5) {
+	case 0:
+		asic_write(asic_read(ien_int_0) | enable_bit, ien_int_0);
+		break;
+	case 1:
+		asic_write(asic_read(ien_int_1) | enable_bit, ien_int_1);
+		break;
+	case 2:
+		asic_write(asic_read(ien_int_2) | enable_bit, ien_int_2);
+		break;
+	case 3:
+		asic_write(asic_read(ien_int_3) | enable_bit, ien_int_3);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void mask_asic_irq(unsigned int irq)
+{
+	unsigned long disable_mask;
+
+	disable_mask = ~(1 << (irq & 0x1f));
+
+	switch (irq >> 5) {
+	case 0:
+		asic_write(asic_read(ien_int_0) & disable_mask, ien_int_0);
+		break;
+	case 1:
+		asic_write(asic_read(ien_int_1) & disable_mask, ien_int_1);
+		break;
+	case 2:
+		asic_write(asic_read(ien_int_2) & disable_mask, ien_int_2);
+		break;
+	case 3:
+		asic_write(asic_read(ien_int_3) & disable_mask, ien_int_3);
+		break;
+	default:
+		BUG();
+	}
+}
+
+static struct irq_chip asic_irq_chip = {
+	.name = "ASIC Level",
+	.ack = mask_asic_irq,
+	.mask = mask_asic_irq,
+	.mask_ack = mask_asic_irq,
+	.unmask = unmask_asic_irq,
+	.eoi = unmask_asic_irq,
+};
+
+void __init asic_irq_init(void)
+{
+	int i;
+
+	/* set priority to 0 */
+	write_c0_status(read_c0_status() & ~(0x0000fc00));
+
+	asic_write(0, ien_int_0);
+	asic_write(0, ien_int_1);
+	asic_write(0, ien_int_2);
+	asic_write(0, ien_int_3);
+
+	asic_write(0x0fffffff, int_level_3_3);
+	asic_write(0xffffffff, int_level_3_2);
+	asic_write(0xffffffff, int_level_3_1);
+	asic_write(0xffffffff, int_level_3_0);
+	asic_write(0xffffffff, int_level_2_3);
+	asic_write(0xffffffff, int_level_2_2);
+	asic_write(0xffffffff, int_level_2_1);
+	asic_write(0xffffffff, int_level_2_0);
+	asic_write(0xffffffff, int_level_1_3);
+	asic_write(0xffffffff, int_level_1_2);
+	asic_write(0xffffffff, int_level_1_1);
+	asic_write(0xffffffff, int_level_1_0);
+	asic_write(0xffffffff, int_level_0_3);
+	asic_write(0xffffffff, int_level_0_2);
+	asic_write(0xffffffff, int_level_0_1);
+	asic_write(0xffffffff, int_level_0_0);
+
+	asic_write(0xf, int_int_scan);
+
+	/*
+	 * Initialize interrupt handlers.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		set_irq_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
+}
diff --git a/arch/mips/powertv/asic/prealloc-calliope.c b/arch/mips/powertv/asic/prealloc-calliope.c
new file mode 100644
index 0000000..6823c4c
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-calliope.c
@@ -0,0 +1,642 @@
+/*
+ *                   		prealloc-calliope.c
+ *
+ * Memory pre-allocations for Calliope boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * NON_DVR_CAPABLE CALLIOPE RESOURCES
+ */
+struct resource non_dvr_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",     	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1,	/*2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",   /*8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x26700000 - 1, /*~36.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DOCSIS Subsystem
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x22000000,
+		.end    = 0x22700000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer (don't need recording buffers)
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 *
+	 */
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
+};
+
+struct resource non_dvr_vz_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1, /*2 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x22202000,
+		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20300000,
+		.end    = 0x20620000-1,  /*3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20300000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23900000,
+		.end    = 0x23920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
+};
+
+struct resource non_dvr_vze_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x22000000,
+		.end    = 0x22200000 - 1,	/*2  Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8k block ST231a monitor */
+		.start  = 0x22200000,
+		.end    = 0x22202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x22202000,
+		.end    = 0x22C20B85 - 1,	/* 10.12 Meg */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20396000,
+		.end    = 0x206B6000 - 1,		/* 3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20396000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x206B6000,
+		.end    = 0x206D6000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
+};
+
+struct resource non_dvr_vzf_calliope_resources[] __initdata =
+{
+	/*
+	 * VIDEO / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/*Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x24200000 - 1,	/*2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/*8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24202000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		/* ~19.4 (21.5MiB - (2MiB + 8KiB)) */
+		.end    = 0x25580000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00480000 - 1,  /* 4.5 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1, /* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer (don't need recording buffers)
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit1
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Synopsys GMAC Memory Region
+	 */
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
+};
diff --git a/arch/mips/powertv/asic/prealloc-cronus.c b/arch/mips/powertv/asic/prealloc-cronus.c
new file mode 100644
index 0000000..b433efd
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-cronus.c
@@ -0,0 +1,625 @@
+/*
+ *                   		prealloc-cronus.c
+ *
+ * Memory pre-allocations for Cronus boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * DVR_CAPABLE CRONUS RESOURCES
+ */
+struct resource dvr_cronus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "ITFS",
+		.start  = 0x64180000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x6430DFFF,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		/* (945K * 8) = (128K *3) 5 playbacks / 3 server */
+		.end    = 0x64AD0000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "AvfsFileSys",
+		.start  = 0x64AD0000,
+		.end    = 0x64AD1000 - 1,  /* 4K */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 */
+	{
+		.flags  = 0,
+	},
+};
+
+/*
+ * NON_DVR_CAPABLE CRONUS RESOURCES
+ */
+struct resource non_dvr_cronus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x24000000,
+		.end    = 0x241FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x24200000,
+		.end    = 0x24201FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x24202000,
+		.end    = 0x25FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 */
+	{
+		.flags  = 0,
+	},
+};
diff --git a/arch/mips/powertv/asic/prealloc-cronuslite.c b/arch/mips/powertv/asic/prealloc-cronuslite.c
new file mode 100644
index 0000000..5bba999
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-cronuslite.c
@@ -0,0 +1,298 @@
+/*
+ *                   		prealloc-cronuslite.c
+ *
+ * Memory pre-allocations for Cronus Lite boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * NON_DVR_CAPABLE CRONUSLITE RESOURCES
+ */
+struct resource non_dvr_cronuslite_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x60000000,
+		.end    = 0x601FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x60200000,
+		.end    = 0x60201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x60202000,
+		.end    = 0x61FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x63B80000 - 1,  /* 6 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x63B83000,
+		.end    = 0x63B84000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x63B84000,
+		.end    = 0x63E48C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x63B80000,
+		.end    = 0x63B82800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 */
+	{
+		.name   = "NP_Reset_Vector",
+		.start  = 0x27c00000,
+		.end    = 0x27c01000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_Image",
+		.start  = 0x27020000,
+		.end    = 0x27060000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "NP_IPC",
+		.start  = 0x63500000,
+		.end    = 0x63580000 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 */
+	{
+		.flags  = 0,
+	},
+};
diff --git a/arch/mips/powertv/asic/prealloc-zeus.c b/arch/mips/powertv/asic/prealloc-zeus.c
new file mode 100644
index 0000000..3205954
--- /dev/null
+++ b/arch/mips/powertv/asic/prealloc-zeus.c
@@ -0,0 +1,471 @@
+/*
+ *                   		prealloc-zeus.c
+ *
+ * Memory pre-allocations for Zeus boxes.
+ *
+ * Copyright (C) 2005-2009 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ */
+
+#include <linux/init.h>
+#include <asm/mach-powertv/asic.h>
+
+/*
+ * DVR_CAPABLE RESOURCES
+ */
+struct resource dvr_zeus_resources[] __initdata =
+{
+	/*
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x20000000,
+		.end    = 0x201FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x20200000,
+		.end    = 0x20201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x20202000,
+		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 */
+	{
+		.name   = "ST231bImage",	/* Delta-Mu 2 image and ram */
+		.start  = 0x30000000,
+		.end    = 0x301FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231bMonitor",	/* 8KiB block ST231b monitor */
+		.start  = 0x30200000,
+		.end    = 0x30201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory2",
+		.start  = 0x30202000,
+		.end    = 0x31FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 *
+	 * Sysaudio Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  DSP_Image_Buff - DSP code and data images (1MB)
+	 *  ADSC_CPU_PCM_Buff - ADSC CPU PCM buffer (40KB)
+	 *  ADSC_AUX_Buff - ADSC AUX buffer (16KB)
+	 *  ADSC_Main_Buff - ADSC Main buffer (16KB)
+	 *
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * STAVEM driver/STAPI
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  This memory area is used for allocating buffers for Video decoding
+	 *  purposes.  Allocation/De-allocation within this buffer is managed
+	 *  by the STAVMEM driver of the STAPI.  They could be Decimated
+	 *  Picture Buffers, Intermediate Buffers, as deemed necessary for
+	 *  video decoding purposes, for any video decoders on Zeus.
+	 *
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00c00000 - 1,	/* 12 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 */
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "ITFS",
+		.start  = 0x00000000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x0018DFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		/* (945K * 8) = (128K * 3) 5 playbacks / 3 server */
+		.end    = 0x007c2000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "AvfsFileSys",
+		.start  = 0x00000000,
+		.end    = 0x00001000 - 1,  /* 4K */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 */
+	{
+		.flags  = 0,
+	},
+};
+
+/*
+ * NON_DVR_CAPABLE ZEUS RESOURCES
+ */
+struct resource non_dvr_zeus_resources[] __initdata =
+{
+	/*
+	 * VIDEO1 / LX1
+	 */
+	{
+		.name   = "ST231aImage",	/* Delta-Mu 1 image and ram */
+		.start  = 0x20000000,
+		.end    = 0x201FFFFF,		/* 2MiB */
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "ST231aMonitor",	/* 8KiB block ST231a monitor */
+		.start  = 0x20200000,
+		.end    = 0x20201FFF,
+		.flags  = IORESOURCE_IO,
+	},
+	{
+		.name   = "MediaMemory1",
+		.start  = 0x20202000,
+		.end    = 0x21FFFFFF, /*~29.9MiB (32MiB - (2MiB + 8KiB)) */
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Sysaudio Driver
+	 */
+	{
+		.name   = "DSP_Image_Buff",
+		.start  = 0x00000000,
+		.end    = 0x000FFFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_CPU_PCM_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00009FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_AUX_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.name   = "ADSC_Main_Buff",
+		.start  = 0x00000000,
+		.end    = 0x00003FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * STAVEM driver/STAPI
+	 */
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DOCSIS Subsystem
+	 */
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * GHW HAL Driver
+	 */
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * multi com buffer area
+	 */
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * DMA Ring buffer
+	 */
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Display bins buffer for unit0
+	 */
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 */
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * PMEM
+	 */
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * Smartcard
+	 */
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/*
+	 * NAND Flash
+	 */
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/*
+	 * Add other resources here
+	 *
+	 * End of Resource marker
+	 */
+	{
+		.flags  = 0,
+	},
+};
diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
new file mode 100644
index 0000000..ef7768d
--- /dev/null
+++ b/arch/mips/powertv/cevt-powertv.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2008 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+/*
+ * The file comes from kernel/cevt-r4k.c
+ */
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/version.h>
+
+#include <asm/smtc_ipi.h>
+#include <asm/time.h>			/* Not included in linux/time.h */
+
+#include <asm/mach-powertv/interrupts.h>
+#include "powertv-clock.h"
+
+static int mips_next_event(unsigned long delta,
+	struct clock_event_device *evt)
+{
+	unsigned int cnt;
+	int res;
+
+	cnt = read_c0_count();
+	cnt += delta;
+	write_c0_compare(cnt);
+	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
+	return res;
+}
+
+static void mips_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+	/* Nothing to do ...  */
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
+static int cp0_timer_irq_installed;
+
+/*
+ * Timer ack for an R4k-compatible timer of a known frequency.
+ */
+static void c0_timer_ack(void)
+{
+	write_c0_compare(read_c0_compare());
+}
+
+#ifndef CONFIG_SEPARATE_PCI_TI
+/*
+ * Possibly handle a performance counter interrupt.
+ * Return true if the timer interrupt should not be checked
+ */
+static inline int handle_perf_irq(int r2)
+{
+	/*
+	 * The performance counter overflow interrupt may be shared with the
+	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
+	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
+	 * and we can't reliably determine if a counter interrupt has also
+	 * happened (!r2) then don't check for a timer interrupt.
+	 */
+	return (cp0_perfcount_irq < 0) &&
+		perf_irq() == IRQ_HANDLED &&
+		!r2;
+}
+#endif
+
+static irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
+{
+	const int r2 = cpu_has_mips_r2;
+	struct clock_event_device *cd;
+	int cpu = smp_processor_id();
+
+#ifndef CONFIG_SEPARATE_PCI_TI
+	/*
+	 * Suckage alert:
+	 * Before R2 of the architecture there was no way to see if a
+	 * performance counter interrupt was pending, so we have to run
+	 * the performance counter interrupt handler anyway.
+	 */
+	if (handle_perf_irq(r2))
+		return IRQ_HANDLED;
+#endif
+
+	/*
+	 * The same applies to performance counter interrupts.  But with the
+	 * above we now know that the reason we got here must be a timer
+	 * interrupt.  Being the paranoiacs we are we check anyway.
+	 */
+	if (!r2 || (read_c0_cause() & (1 << 30))) {
+		c0_timer_ack();
+		cd = &per_cpu(mips_clockevent_device, cpu);
+		cd->event_handler(cd);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction c0_compare_irqaction = {
+	.handler = c0_compare_interrupt,
+	.flags = IRQF_DISABLED | IRQF_PERCPU,
+	.name = "timer",
+};
+
+static void mips_event_handler(struct clock_event_device *dev)
+{
+}
+
+int __cpuinit powertv_clockevent_init(void)
+{
+	uint64_t mips_freq = mips_hpt_frequency;
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+	unsigned int irq;
+
+	if (!cpu_has_counter || !mips_hpt_frequency)
+		return -ENXIO;
+
+
+	irq = irq_mips_timer;
+
+	cd = &per_cpu(mips_clockevent_device, cpu);
+
+	cd->name		= "MIPS";
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
+
+	/* Calculate the min / max delta */
+	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
+	cd->shift		= 32;
+	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+
+	cd->rating		= 300;
+	cd->irq			= irq;
+	cd->cpumask		= get_cpu_mask(cpu);
+
+	cd->set_next_event	= mips_next_event;
+	cd->set_mode		= mips_set_mode;
+	cd->event_handler	= mips_event_handler;
+
+	clockevents_register_device(cd);
+
+	if (cp0_timer_irq_installed)
+		return 0;
+
+	cp0_timer_irq_installed = 1;
+
+	setup_irq(irq, &c0_compare_irqaction);
+
+	return 0;
+}
diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
new file mode 100644
index 0000000..98d73cb
--- /dev/null
+++ b/arch/mips/powertv/cmdline.c
@@ -0,0 +1,52 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Kernel command line creation using the prom monitor (YAMON) argc/argv.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+
+#include "init.h"
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension.
+ */
+#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
+
+char * __init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void  __init prom_init_cmdline(void)
+{
+	int len;
+
+	if (prom_argc != 1)
+		return;
+
+	len = strlen(arcs_cmdline);
+
+	arcs_cmdline[len] = ' ';
+
+	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
+		COMMAND_LINE_SIZE - len - 1);
+}
diff --git a/arch/mips/powertv/csrc-powertv.c b/arch/mips/powertv/csrc-powertv.c
new file mode 100644
index 0000000..a27c16c
--- /dev/null
+++ b/arch/mips/powertv/csrc-powertv.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (C) 2008 Scientific-Atlanta, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+/*
+ * The file comes from kernel/csrc-r4k.c
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>			/* Not included in linux/time.h */
+
+#include <asm/mach-powertv/asic_regs.h>
+#include "powertv-clock.h"
+
+/* MIPS PLL Register Definitions */
+#define PLL_GET_M(x)		(((x) >> 8) & 0x000000FF)
+#define PLL_GET_N(x)		(((x) >> 16) & 0x000000FF)
+#define PLL_GET_P(x)		(((x) >> 24) & 0x00000007)
+
+/*
+ * returns:  Clock frequency in kHz
+ */
+unsigned int __init mips_get_pll_freq(void)
+{
+	unsigned int pll_reg, m, n, p;
+	unsigned int fin = 54000; /* Base frequency in kHz */
+	unsigned int fout;
+
+	/* Read PLL register setting */
+	pll_reg = asic_read(mips_pll_setup);
+	m = PLL_GET_M(pll_reg);
+	n = PLL_GET_N(pll_reg);
+	p = PLL_GET_P(pll_reg);
+	pr_info("MIPS PLL Register:0x%x  M=%d  N=%d  P=%d\n", pll_reg, m, n, p);
+
+	/* Calculate clock frequency = (2 * N * 54MHz) / (M * (2**P)) */
+	fout = ((2 * n * fin) / (m * (0x01 << p)));
+
+	pr_info("MIPS Clock Freq=%d kHz\n", fout);
+
+	return fout;
+}
+
+static cycle_t c0_hpt_read(struct clocksource *cs)
+{
+	return read_c0_count();
+}
+
+static struct clocksource clocksource_mips = {
+	.name		= "powertv-counter",
+	.read		= c0_hpt_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init powertv_c0_hpt_clocksource_init(void)
+{
+	unsigned int pll_freq = mips_get_pll_freq();
+
+	pr_info("CPU frequency %d.%02d MHz\n", pll_freq / 1000,
+		(pll_freq % 1000) * 100 / 1000);
+
+	mips_hpt_frequency = pll_freq / 2 * 1000;
+
+	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
+
+	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
+
+	clocksource_register(&clocksource_mips);
+}
+
+/**
+ * struct tim_c - free running counter
+ * @hi:	High 16 bits of the counter
+ * @lo:	Low 32 bits of the counter
+ *
+ * Lays out the structure of the free running counter in memory. This counter
+ * increments at a rate of 27 MHz/8 on all platforms.
+ */
+struct tim_c {
+	unsigned int hi;
+	unsigned int lo;
+};
+
+static struct tim_c *tim_c;
+
+static cycle_t tim_c_read(struct clocksource *cs)
+{
+	unsigned int hi;
+	unsigned int next_hi;
+	unsigned int lo;
+
+	hi = readl(&tim_c->hi);
+
+	for (;;) {
+		lo = readl(&tim_c->lo);
+		next_hi = readl(&tim_c->hi);
+		if (next_hi == hi)
+			break;
+		hi = next_hi;
+	}
+
+pr_crit("%s: read %llx\n", __func__, ((u64) hi << 32) | lo);
+	return ((u64) hi << 32) | lo;
+}
+
+#define TIM_C_SIZE		48		/* # bits in the timer */
+
+static struct clocksource clocksource_tim_c = {
+	.name		= "powertv-tim_c",
+	.read		= tim_c_read,
+	.mask		= CLOCKSOURCE_MASK(TIM_C_SIZE),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/**
+ * powertv_tim_c_clocksource_init - set up a clock source for the TIM_C clock
+ *
+ * The hard part here is coming up with a constant k and shift s such that
+ * the 48-bit TIM_C value multiplied by k doesn't overflow and that value,
+ * when shifted right by s, yields the corresponding number of nanoseconds.
+ * We know that TIM_C counts at 27 MHz/8, so each cycle corresponds to
+ * 1 / (27,000,000/8) seconds. Multiply that by a billion and you get the
+ * number of nanoseconds. Since the TIM_C value has 48 bits and the math is
+ * done in 64 bits, avoiding an overflow means that k must be less than
+ * 64 - 48 = 16 bits.
+ */
+static void __init powertv_tim_c_clocksource_init(void)
+{
+	int			prescale;
+	unsigned long		dividend;
+	unsigned long		k;
+	int			s;
+	const int		max_k_bits = (64 - 48) - 1;
+	const unsigned long	billion = 1000000000;
+	const unsigned long	counts_per_second = 27000000 / 8;
+
+	prescale = BITS_PER_LONG - ilog2(billion) - 1;
+	dividend = billion << prescale;
+	k = dividend / counts_per_second;
+	s = ilog2(k) - max_k_bits;
+
+	if (s < 0)
+		s = prescale;
+
+	else {
+		k >>= s;
+		s += prescale;
+	}
+
+	clocksource_tim_c.mult = k;
+	clocksource_tim_c.shift = s;
+	clocksource_tim_c.rating = 200;
+
+	clocksource_register(&clocksource_tim_c);
+	tim_c = (struct tim_c *) asic_reg_addr(tim_ch);
+}
+
+/**
+ powertv_clocksource_init - initialize all clocksources
+ */
+void __init powertv_clocksource_init(void)
+{
+	powertv_c0_hpt_clocksource_init();
+	powertv_tim_c_clocksource_init();
+}
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
new file mode 100644
index 0000000..5f4e4c3
--- /dev/null
+++ b/arch/mips/powertv/init.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * PROM library initialisation code.
+ */
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+
+#include <asm/mips-boards/prom.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mach-powertv/asic.h>
+
+#include "init.h"
+
+int prom_argc;
+int *_prom_argv, *_prom_envp;
+unsigned long _prom_memsize;
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension, if running in 64-bit mode.
+ */
+#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
+
+char *prom_getenv(char *envname)
+{
+	char *result = NULL;
+
+	if (_prom_envp != NULL) {
+		/*
+		 * Return a pointer to the given environment variable.
+		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
+		 * in the PROM structures are only 32-bit, so we need some
+		 * workarounds, if we are running in 64-bit mode.
+		 */
+		int i, index = 0;
+
+		i = strlen(envname);
+
+		while (prom_envp(index)) {
+			if (strncmp(envname, prom_envp(index), i) == 0) {
+				result = prom_envp(index + 1);
+				break;
+			}
+			index += 2;
+		}
+	}
+
+	return result;
+}
+
+/* TODO: Verify on linux-mips mailing list that the following two  */
+/* functions are correct                                           */
+/* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
+/* BootROM exception vectors. Flush their cache entries. test it.  */
+
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa80) :
+		(void *)(CAC_BASE + 0x380);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00000;
+#else
+#error NMI exception handler address not defined
+#endif
+}
+
+static void __init mips_ejtag_setup(void)
+{
+	void *base;
+
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+		(void *)(CAC_BASE + 0xa00) :
+		(void *)(CAC_BASE + 0x300);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00480;
+#else
+#error EJTAG exception handler address not defined
+#endif
+}
+
+void __init prom_init(void)
+{
+	prom_argc = fw_arg0;
+	_prom_argv = (int *) fw_arg1;
+	_prom_envp = (int *) fw_arg2;
+	_prom_memsize = (unsigned long) fw_arg3;
+
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	pr_info("\nLINUX started...\n");
+	prom_init_cmdline();
+	configure_platform();
+	prom_meminit();
+
+#ifndef CONFIG_BOOTLOADER_DRIVER
+	pr_info("\nBootloader driver isn't loaded...\n");
+#endif
+}
diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
new file mode 100644
index 0000000..332cfed
--- /dev/null
+++ b/arch/mips/powertv/init.h
@@ -0,0 +1,30 @@
+/*
+ *				init.h
+ *
+ * Definitions from powertv init.c file
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_INIT_H
+#define _POWERTV_INIT_H
+extern int prom_argc;
+extern int *_prom_argv;
+extern unsigned long _prom_memsize;
+#endif
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
new file mode 100644
index 0000000..4ef689c
--- /dev/null
+++ b/arch/mips/powertv/memory.c
@@ -0,0 +1,184 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Apparently originally from arch/mips/malta-memory.c. Modified to work
+ * with the PowerTV bootloader.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <asm/mips-boards/prom.h>
+
+#include "init.h"
+
+/* Memory constants */
+#define KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
+#define MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+#define DEFAULT_MEMSIZE		MEBIBYTE(256)	/* If no memsize provided */
+#define LOW_MEM_MAX		MEBIBYTE(252)	/* Max usable low mem */
+#define RES_BOOTLDR_MEMSIZE	MEBIBYTE(1)	/* Memory reserved for bldr */
+#define BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
+#define PHYS_MEM_START		0x10000000	/* Start of physical memory */
+
+unsigned long ptv_memsize;
+
+void __init prom_meminit(void)
+{
+	char *memsize_str;
+	unsigned long memsize = 0;
+	unsigned int physend;
+	char cmdline[CL_SIZE], *ptr;
+	int low_mem;
+	int high_mem;
+
+	/* Check the command line first for a memsize directive */
+	strcpy(cmdline, arcs_cmdline);
+	ptr = strstr(cmdline, "memsize=");
+	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " memsize=");
+
+	if (ptr) {
+		memsize = memparse(ptr + 8, &ptr);
+	} else {
+		/* otherwise look in the environment */
+		memsize_str = prom_getenv("memsize");
+
+		if (memsize_str != NULL) {
+			pr_info("prom memsize = %s\n", memsize_str);
+			memsize = simple_strtol(memsize_str, NULL, 0);
+		}
+
+		if (memsize == 0) {
+			if (_prom_memsize != 0) {
+				memsize = _prom_memsize;
+				pr_info("_prom_memsize = 0x%lx\n", memsize);
+				/* add in memory that the bootloader doesn't
+				 * report */
+				memsize += BOOT_MEM_SIZE;
+			} else {
+				memsize = DEFAULT_MEMSIZE;
+				pr_info("Memsize not passed by bootloader, "
+					"defaulting to 0x%lx\n", memsize);
+			}
+		}
+	}
+
+	/* Store memsize for diagnostic purposes */
+	ptv_memsize = memsize;
+
+	physend = PFN_ALIGN(&_end) - 0x80000000;
+	if (memsize > LOW_MEM_MAX) {
+		low_mem = LOW_MEM_MAX;
+		high_mem = memsize - low_mem;
+	} else {
+		low_mem = memsize;
+		high_mem = 0;
+	}
+
+/*
+ * TODO: We will use the hard code for memory configuration until
+ * the bootloader releases their device tree to us.
+ */
+	/*
+	 * Add the memory reserved for use by the bootloader to the
+	 * memory map.
+	 */
+	add_memory_region(PHYS_MEM_START, RES_BOOTLDR_MEMSIZE,
+		BOOT_MEM_RESERVED);
+#ifdef CONFIG_HIGHMEM_256_128
+	/*
+	 * Add memory in low for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		LOW_MEM_MAX - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved for reset vector.
+	 */
+	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
+	/*
+	 * Add the memory reserved.
+	 */
+	add_memory_region(0x20000000, MEBIBYTE(1024 + 75), BOOT_MEM_RESERVED);
+	/*
+	 * Add memory in high for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 *
+	 * 75MB is reserved for devices which are using the memory in high.
+	 */
+	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
+		BOOT_MEM_RAM);
+#elif defined CONFIG_HIGHMEM_128_128
+	/*
+	 * Add memory in low for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		MEBIBYTE(128) - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved.
+	 */
+	add_memory_region(PHYS_MEM_START + MEBIBYTE(128),
+		MEBIBYTE(128 + 1024 + 75), BOOT_MEM_RESERVED);
+	/*
+	 * Add memory in high for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 *
+	 * 75MB is reserved for devices which are using the memory in high.
+	 */
+	add_memory_region(0x60000000 + MEBIBYTE(75), MEBIBYTE(128 - 75),
+		BOOT_MEM_RAM);
+#else
+	/* Add low memory regions for either:
+	 *   - no-highmemory configuration case -OR-
+	 *   - highmemory "HIGHMEM_LOWBANK_ONLY" case
+	 */
+	/*
+	 * Add memory for general use by the kernel and its friends
+	 * (like drivers, applications, etc).
+	 */
+	add_memory_region(PHYS_MEM_START + RES_BOOTLDR_MEMSIZE,
+		low_mem - RES_BOOTLDR_MEMSIZE, BOOT_MEM_RAM);
+	/*
+	 * Add the memory reserved for reset vector.
+	 */
+	add_memory_region(0x1fc00000, MEBIBYTE(4), BOOT_MEM_RESERVED);
+#endif
+}
+
+void __init prom_free_prom_memory(void)
+{
+	unsigned long addr;
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+	}
+}
diff --git a/arch/mips/powertv/pci/Makefile b/arch/mips/powertv/pci/Makefile
new file mode 100644
index 0000000..9249164
--- /dev/null
+++ b/arch/mips/powertv/pci/Makefile
@@ -0,0 +1,28 @@
+# *****************************************************************************
+#                          Make file for PowerTV PCI driver
+#
+# Copyright (C) 2009  Scientific-Atlanta, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# *****************************************************************************
+
+EXTRA_CFLAGS += -Wall -Werror
+
+obj-y	:=
+
+obj-$(CONFIG_PCI)	+= fixup-powertv.o
+
+
diff --git a/arch/mips/powertv/pci/fixup-powertv.c b/arch/mips/powertv/pci/fixup-powertv.c
new file mode 100644
index 0000000..726bc2e
--- /dev/null
+++ b/arch/mips/powertv/pci/fixup-powertv.c
@@ -0,0 +1,36 @@
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/mach-powertv/interrupts.h>
+#include "powertv-pci.h"
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return asic_pcie_map_irq(dev, slot, pin);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/*
+ * asic_pcie_map_irq
+ *
+ * Parameters:
+ * *dev - pointer to a pci_dev structure  (not used)
+ * slot - slot number  (not used)
+ * pin - pin number  (not used)
+ *
+ * Return Value:
+ * Returns: IRQ number (always the PCI Express IRQ number)
+ *
+ * Description:
+ * asic_pcie_map_irq will return the IRQ number of the PCI Express interrupt.
+ *
+ */
+int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return irq_pciexp;
+}
+EXPORT_SYMBOL(asic_pcie_map_irq);
diff --git a/arch/mips/powertv/pci/powertv-pci.h b/arch/mips/powertv/pci/powertv-pci.h
new file mode 100644
index 0000000..1b5886b
--- /dev/null
+++ b/arch/mips/powertv/pci/powertv-pci.h
@@ -0,0 +1,31 @@
+/*
+ *				powertv-pci.c
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+/*
+ * Local definitions for the powertv PCI code
+ */
+
+#ifndef _POWERTV_PCI_POWERTV_PCI_H_
+#define _POWERTV_PCI_POWERTV_PCI_H_
+extern int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+extern int asic_pcie_init(void);
+extern int asic_pcie_init(void);
+
+extern int log_level;
+#endif
diff --git a/arch/mips/powertv/powertv-clock.h b/arch/mips/powertv/powertv-clock.h
new file mode 100644
index 0000000..5c1f093
--- /dev/null
+++ b/arch/mips/powertv/powertv-clock.h
@@ -0,0 +1,30 @@
+/*
+ *				powertv-clock.h
+ *
+ * Definitions for clocks
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_POWERTV_CLOCK_H
+#define _POWERTV_POWERTV_CLOCK_H
+extern int powertv_clockevent_init(void);
+extern void powertv_clocksource_init(void);
+extern unsigned int mips_get_pll_freq(void);
+#endif
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
new file mode 100644
index 0000000..bd8ebf1
--- /dev/null
+++ b/arch/mips/powertv/powertv_setup.c
@@ -0,0 +1,351 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/screen_info.h>
+#include <linux/notifier.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/ctype.h>
+
+#include <linux/cpu.h>
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/dma.h>
+#include <linux/time.h>
+#include <asm/traps.h>
+#include <asm/asm-offsets.h>
+#include "reset.h"
+
+#define VAL(n)		STR(n)
+
+/*
+ * Macros for loading addresses and storing registers:
+ * PTR_LA	Load the address into a register
+ * LONG_S	Store the full width of the given register.
+ * LONG_L	Load the full width of the given register
+ * PTR_ADDIU	Add a constant value to a register used as a pointer
+ * REG_SIZE	Number of 8-bit bytes in a full width register
+ */
+#ifdef CONFIG_64BIT
+#warning TODO: 64-bit code needs to be verified
+#define PTR_LA		"dla	"
+#define LONG_S		"sd	"
+#define LONG_L		"ld	"
+#define PTR_ADDIU	"daddiu	"
+#define REG_SIZE	"8"		/* In bytes */
+#endif
+
+#ifdef CONFIG_32BIT
+#define PTR_LA		"la	"
+#define LONG_S		"sw	"
+#define LONG_L		"lw	"
+#define PTR_ADDIU	"addiu	"
+#define REG_SIZE	"4"		/* In bytes */
+#endif
+
+static struct pt_regs die_regs;
+static bool have_die_regs;
+
+static void register_panic_notifier(void);
+static int panic_handler(struct notifier_block *notifier_block,
+	unsigned long event, void *cause_string);
+
+const char *get_system_type(void)
+{
+	return "PowerTV";
+}
+
+void __init plat_mem_setup(void)
+{
+	panic_on_oops = 1;
+	register_panic_notifier();
+
+#if 0
+	mips_pcibios_init();
+#endif
+	mips_reboot_setup();
+}
+
+/*
+ * Install a panic notifier for platform-specific diagnostics
+ */
+static void register_panic_notifier()
+{
+	static struct notifier_block panic_notifier = {
+		.notifier_call = panic_handler,
+		.next = NULL,
+		.priority	= INT_MAX
+	};
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
+}
+
+static int panic_handler(struct notifier_block *notifier_block,
+	unsigned long event, void *cause_string)
+{
+	struct pt_regs	my_regs;
+
+	/* Save all of the registers */
+	{
+		unsigned long	at, v0, v1; /* Must be on the stack */
+
+		/* Start by saving $at and v0 on the stack. We use $at
+		 * ourselves, but it looks like the compiler may use v0 or v1
+		 * to load the address of the pt_regs structure. We'll come
+		 * back later to store the registers in the pt_regs
+		 * structure. */
+		__asm__ __volatile__ (
+			".set	noat\n"
+			LONG_S		"$at, %[at]\n"
+			LONG_S		"$2, %[v0]\n"
+			LONG_S		"$3, %[v1]\n"
+		:
+			[at] "=m" (at),
+			[v0] "=m" (v0),
+			[v1] "=m" (v1)
+		:
+		:	"at"
+		);
+
+		__asm__ __volatile__ (
+			".set	noat\n"
+			"move		$at, %[pt_regs]\n"
+
+			/* Argument registers */
+			LONG_S		"$4, " VAL(PT_R4) "($at)\n"
+			LONG_S		"$5, " VAL(PT_R5) "($at)\n"
+			LONG_S		"$6, " VAL(PT_R6) "($at)\n"
+			LONG_S		"$7, " VAL(PT_R7) "($at)\n"
+
+			/* Temporary regs */
+			LONG_S		"$8, " VAL(PT_R8) "($at)\n"
+			LONG_S		"$9, " VAL(PT_R9) "($at)\n"
+			LONG_S		"$10, " VAL(PT_R10) "($at)\n"
+			LONG_S		"$11, " VAL(PT_R11) "($at)\n"
+			LONG_S		"$12, " VAL(PT_R12) "($at)\n"
+			LONG_S		"$13, " VAL(PT_R13) "($at)\n"
+			LONG_S		"$14, " VAL(PT_R14) "($at)\n"
+			LONG_S		"$15, " VAL(PT_R15) "($at)\n"
+
+			/* "Saved" registers */
+			LONG_S		"$16, " VAL(PT_R16) "($at)\n"
+			LONG_S		"$17, " VAL(PT_R17) "($at)\n"
+			LONG_S		"$18, " VAL(PT_R18) "($at)\n"
+			LONG_S		"$19, " VAL(PT_R19) "($at)\n"
+			LONG_S		"$20, " VAL(PT_R20) "($at)\n"
+			LONG_S		"$21, " VAL(PT_R21) "($at)\n"
+			LONG_S		"$22, " VAL(PT_R22) "($at)\n"
+			LONG_S		"$23, " VAL(PT_R23) "($at)\n"
+
+			/* Add'l temp regs */
+			LONG_S		"$24, " VAL(PT_R24) "($at)\n"
+			LONG_S		"$25, " VAL(PT_R25) "($at)\n"
+
+			/* Kernel temp regs */
+			LONG_S		"$26, " VAL(PT_R26) "($at)\n"
+			LONG_S		"$27, " VAL(PT_R27) "($at)\n"
+
+			/* Global pointer, stack pointer, frame pointer and
+			 * return address */
+			LONG_S		"$gp, " VAL(PT_R28) "($at)\n"
+			LONG_S		"$sp, " VAL(PT_R29) "($at)\n"
+			LONG_S		"$fp, " VAL(PT_R30) "($at)\n"
+			LONG_S		"$ra, " VAL(PT_R31) "($at)\n"
+
+			/* Now we can get the $at and v0 registers back and
+			 * store them */
+			LONG_L		"$8, %[at]\n"
+			LONG_S		"$8, " VAL(PT_R1) "($at)\n"
+			LONG_L		"$8, %[v0]\n"
+			LONG_S		"$8, " VAL(PT_R2) "($at)\n"
+			LONG_L		"$8, %[v1]\n"
+			LONG_S		"$8, " VAL(PT_R3) "($at)\n"
+		:
+		:
+			[at] "m" (at),
+			[v0] "m" (v0),
+			[v1] "m" (v1),
+			[pt_regs] "r" (&my_regs)
+		:	"at", "t0"
+		);
+
+		/* Set the current EPC value to be the current location in this
+		 * function */
+		__asm__ __volatile__ (
+			".set	noat\n"
+		"1:\n"
+			PTR_LA		"$at, 1b\n"
+			LONG_S		"$at, %[cp0_epc]\n"
+		:
+			[cp0_epc] "=m" (my_regs.cp0_epc)
+		:
+		:	"at"
+		);
+
+		my_regs.cp0_cause = read_c0_cause();
+		my_regs.cp0_status = read_c0_status();
+	}
+
+#ifdef CONFIG_DIAGNOSTICS
+	failure_report((char *) cause_string,
+		have_die_regs ? &die_regs : &my_regs);
+	have_die_regs = false;
+#else
+	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
+		"zzzz... \n");
+#endif
+
+	return NOTIFY_DONE;
+}
+
+/**
+ * Platform-specific handling of oops
+ * @str:	Pointer to the oops string
+ * @regs:	Pointer to the oops registers
+ * All we do here is to save the registers for subsequent printing through
+ * the panic notifier.
+ */
+void platform_die(const char *str, const struct pt_regs *regs)
+{
+	/* If we already have saved registers, don't overwrite them as they
+	 * they apply to the initial fault */
+
+	if (!have_die_regs) {
+		have_die_regs = true;
+		die_regs = *regs;
+	}
+}
+
+/* Information about the RF MAC address, if one was supplied on the
+ * command line. */
+static bool have_rfmac;
+static u8 rfmac[ETH_ALEN];
+
+static int rfmac_param(char *p)
+{
+	u8	*q;
+	bool	is_high_nibble;
+	int	c;
+
+	/* Skip a leading "0x", if present */
+	if (*p == '0' && *(p+1) == 'x')
+		p += 2;
+
+	q = rfmac;
+	is_high_nibble = true;
+
+	for (c = (unsigned char) *p++;
+		isxdigit(c) && q - rfmac < ETH_ALEN;
+		c = (unsigned char) *p++) {
+		int	nibble;
+
+		nibble = (isdigit(c) ? (c - '0') :
+			(isupper(c) ? c - 'A' + 10 : c - 'a' + 10));
+
+		if (is_high_nibble)
+			*q = nibble << 4;
+		else
+			*q++ |= nibble;
+
+		is_high_nibble = !is_high_nibble;
+	}
+
+	/* If we parsed all the way to the end of the parameter value and
+	 * parsed all ETH_ALEN bytes, we have a usable RF MAC address */
+	have_rfmac = (c == '\0' && q - rfmac == ETH_ALEN);
+
+	return 0;
+}
+
+early_param("rfmac", rfmac_param);
+
+/*
+ * Generate an Ethernet MAC address that has a good chance of being unique.
+ * @addr:	Pointer to six-byte array containing the Ethernet address
+ * Generates an Ethernet MAC address that is highly likely to be unique for
+ * this particular system on a network with other systems of the same type.
+ *
+ * The problem we are solving is that, when random_ether_addr() is used to
+ * generate MAC addresses at startup, there isn't much entropy for the random
+ * number generator to use and the addresses it produces are fairly likely to
+ * be the same as those of other identical systems on the same local network.
+ * This is true even for relatively small numbers of systems (for the reason
+ * why, see the Wikipedia entry for "Birthday problem" at:
+ *	http://en.wikipedia.org/wiki/Birthday_problem
+ *
+ * The good news is that we already have a MAC address known to be unique, the
+ * RF MAC address. The bad news is that this address is already in use on the
+ * RF interface. Worse, the obvious trick, taking the RF MAC address and
+ * turning on the locally managed bit, has already been used for other devices.
+ * Still, this does give us something to work with.
+ *
+ * The approach we take is:
+ * 1.	If we can't get the RF MAC Address, just call random_ether_addr.
+ * 2.	Use the 24-bit NIC-specific bits of the RF MAC address as the last 24
+ *	bits of the new address. This is very likely to be unique, except for
+ *	the current box.
+ * 3.	To avoid using addresses already on the current box, we set the top
+ *	six bits of the address with a value different from any currently
+ *	registered Scientific Atlanta organizationally unique identifyer
+ *	(OUI). This avoids duplication with any addresses on the system that
+ *	were generated from valid Scientific Atlanta-registered address by
+ *	simply flipping the locally managed bit.
+ * 4.	We aren't generating a multicast address, so we leave the multicast
+ *	bit off. Since we aren't using a registered address, we have to set
+ *	the locally managed bit.
+ * 5.	We then randomly generate the remaining 16-bits. This does two
+ *	things:
+ *	a.	It allows us to call this function for more than one device
+ *		in this system
+ *	b.	It ensures that things will probably still work even if
+ *		some device on the device network has a locally managed
+ *		address that matches the top six bits from step 2.
+ */
+void platform_random_ether_addr(u8 addr[ETH_ALEN])
+{
+	const int num_random_bytes = 2;
+	const unsigned char non_sciatl_oui_bits = 0xc0u;
+	const unsigned char mac_addr_locally_managed = (1 << 1);
+
+	if (!have_rfmac) {
+		pr_warning("rfmac not available on command line; "
+			"generating random MAC address\n");
+		random_ether_addr(addr);
+	}
+
+	else {
+		int	i;
+
+		/* Set the first byte to something that won't match a Scientific
+		 * Atlanta OUI, is locally managed, and isn't a multicast
+		 * address */
+		addr[0] = non_sciatl_oui_bits | mac_addr_locally_managed;
+
+		/* Get some bytes of random address information */
+		get_random_bytes(&addr[1], num_random_bytes);
+
+		/* Copy over the NIC-specific bits of the RF MAC address */
+		for (i = 1 + num_random_bytes; i < ETH_ALEN; i++)
+			addr[i] = rfmac[i];
+	}
+}
diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
new file mode 100644
index 0000000..ec8fe80
--- /dev/null
+++ b/arch/mips/powertv/reset.c
@@ -0,0 +1,70 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ * ########################################################################
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * ########################################################################
+ *
+ */
+#include <linux/pm.h>
+
+#include <linux/io.h>
+#include <asm/reboot.h>			/* Not included by linux/reboot.h */
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+#include <asm/mach-powertv/kbldr.h>
+#endif
+
+#include <asm/mach-powertv/asic_regs.h>
+#include "reset.h"
+
+static void mips_machine_restart(char *command);
+static void mips_machine_halt(void);
+
+static void mips_machine_restart(char *command)
+{
+#ifdef CONFIG_BOOTLOADER_DRIVER
+	/*
+	 * Call the bootloader's reset function to ensure
+	 * that persistent data is flushed before hard reset
+	 */
+	kbldr_SetCauseAndReset();
+#else
+	writel(0x1, asic_reg_addr(watchdog));
+#endif
+}
+
+static void mips_machine_halt(void)
+{
+#ifdef CONFIG_BOOTLOADER_DRIVER
+	/*
+	 * Call the bootloader's reset function to ensure
+	 * that persistent data is flushed before hard reset
+	 */
+	kbldr_SetCauseAndReset();
+#else
+	writel(0x1, asic_reg_addr(watchdog));
+#endif
+}
+
+void mips_reboot_setup(void)
+{
+	_machine_restart = mips_machine_restart;
+	_machine_halt = mips_machine_halt;
+	pm_power_off = mips_machine_halt;
+}
diff --git a/arch/mips/powertv/reset.h b/arch/mips/powertv/reset.h
new file mode 100644
index 0000000..93d58b9
--- /dev/null
+++ b/arch/mips/powertv/reset.h
@@ -0,0 +1,28 @@
+/*
+ *				reset.h
+ *
+ * Definitions from powertv reset.c file
+ *
+ * Copyright (C) 2009  Cisco Systems, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: David VomLehn
+ */
+
+#ifndef _POWERTV_POWERTV_RESET_H
+#define _POWERTV_POWERTV_RESET_H
+extern void mips_reboot_setup(void);
+#endif
diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
new file mode 100644
index 0000000..1e3e54e
--- /dev/null
+++ b/arch/mips/powertv/time.c
@@ -0,0 +1,30 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+ * Portions copyright (C) 2009 Cisco Systems, Inc.
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Setting up the clock on the MIPS boards.
+ */
+
+#include <asm/time.h>
+
+#include "powertv-clock.h"
+
+void __init plat_time_init(void)
+{
+	powertv_clocksource_init();
+	powertv_clockevent_init();
+}
