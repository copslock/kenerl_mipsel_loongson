Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 23:56:45 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:55050 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023529AbZEDW42 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 23:56:28 +0100
X-IronPort-AV: E=Sophos;i="4.40,293,1238976000"; 
   d="scan'208";a="180713028"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 04 May 2009 22:56:17 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n44MuG48020569;
	Mon, 4 May 2009 15:56:16 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n44MuGdL014043;
	Mon, 4 May 2009 22:56:16 GMT
Date:	Mon, 4 May 2009 15:56:16 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] mips:powertv: Base files for Cisco Powertv platform
	(resend)
Message-ID: <20090504225616.GA22321@cuplxvomd02.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=270104; t=1241477777; x=1242341777;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=201/3]=20mips=3Apowertv=3A=20Base=20file
	s=20for=20Cisco=20Powertv=20platform=0A=09(resend)
	|Sender:=20;
	bh=zdnVT0CjGUx6Igui7a1cPeGcIzUuGcw8ISJlILfLG/g=;
	b=f0IcxqciPsnS4t9jEBcR5Ior9Iu5+cNNDgG8Px85p2CIpMlb1dIqHeQRyQ
	Wxo3nOCibu2xpP7dsTpP4L0PQT0YTfNdM9GsAxUMKgxyt8z91w//PnJd4zs2
	B/TOnQ9YqN;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Adds the C and header source files for the Cisco PowerTV platform.

History
v2	Check clocksource function to correspond to changed prototype.
v1	First release

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/mips/include/asm/mach-powertv/asic.h          |  124 +
 arch/mips/include/asm/mach-powertv/asic_regs.h     |  136 +
 arch/mips/include/asm/mach-powertv/dma-coherence.h |  123 +
 arch/mips/include/asm/mach-powertv/interrupts.h    |  234 ++
 arch/mips/include/asm/mach-powertv/war.h           |   27 +
 arch/mips/powertv/Kconfig                          |   17 +
 arch/mips/powertv/Makefile                         |   37 +
 arch/mips/powertv/asic/Kconfig                     |   24 +
 arch/mips/powertv/asic/Makefile                    |   24 +
 arch/mips/powertv/asic/asic_devices.c              | 2902 +++++++++++++++++++
 arch/mips/powertv/asic/asic_int.c                  |  146 +
 arch/mips/powertv/asic/irq_asic.c                  |  115 +
 arch/mips/powertv/cevt-powertv.c                   |  247 ++
 arch/mips/powertv/cmdline.c                        |   51 +
 arch/mips/powertv/csrc-powertv.c                   |   84 +
 arch/mips/powertv/init.c                           |  127 +
 arch/mips/powertv/init.h                           |   10 +
 arch/mips/powertv/memory.c                         |  183 ++
 arch/mips/powertv/pci/Makefile                     |   26 +
 arch/mips/powertv/pci/fixup-powertv.c              |   14 +
 arch/mips/powertv/pci/pci.c                        |   35 +
 arch/mips/powertv/pci/pciemod.c                    | 2921 ++++++++++++++++++++
 arch/mips/powertv/pci/pcieregs.h                   |  333 +++
 arch/mips/powertv/pci/powertv-pci.h                |   12 +
 arch/mips/powertv/powertv-clock.h                  |   10 +
 arch/mips/powertv/powertv_setup.c                  |  351 +++
 arch/mips/powertv/reset.c                          |   69 +
 arch/mips/powertv/reset.h                          |    8 +
 arch/mips/powertv/time.c                           |   47 +
 29 files changed, 8437 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-powertv/asic.h b/arch/mips/include/asm/mach-powertv/asic.h
new file mode 100644
index 0000000..4240e4e
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic.h
@@ -0,0 +1,124 @@
+#ifndef _ASM_ASIC_H
+#define _ASM_ASIC_H
+
+#include <asm/mach-powertv/asic_regs.h>
+
+#define DVR_CAPABLE     (1<<0)
+#define PCIE_CAPABLE    (1<<1)
+#define FFS_CAPABLE     (1<<2)
+#define DISPLAY_CAPABLE (1<<3)
+
+/* Platform Family types
+ * For compitability, the new value must be added in the end */
+enum tFamilyType {
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
+extern void powertv_platform_init(void);
+extern void platform_alloc_bootmem(void);
+extern enum tAsicType platform_get_asic(void);
+extern enum tFamilyType platform_get_family(void);
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
+/*
+ * The bus addresses are different than the physical addresses that
+ * the processor sees by an offset. This offset varies by ASIC
+ * version. Define a variable to hold the offset and some macros to
+ * make the conversion simpler. */
+extern unsigned long gPhysToBusOffset;
+
+#ifdef CONFIG_HIGHMEM
+/*
+ * TODO: We will use the hard code for conversion between physical and
+ * bus until the bootloader releases their device tree to us.
+ */
+#define phys_to_bus(x) (((x) < 0x20000000) ? ((x) + gPhysToBusOffset) : (x))
+#define bus_to_phys(x) (((x) < 0x60000000) ? ((x) - gPhysToBusOffset) : (x))
+#else
+#define phys_to_bus(x) ((x) + gPhysToBusOffset)
+#define bus_to_phys(x) ((x) - gPhysToBusOffset)
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
+	return !((phys_t)addr & (phys_t) ~0x1fffffffULL);
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
+	bus_ram_base = gPhysToBusOffset + phys_ram_base;
+
+	return addr >= bus_ram_base &&
+		addr < (bus_ram_base + 256 * 1024 * 1024);
+}
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
+enum eSys_RebootType {
+	kSys_UnknownReboot          = 0x00,	/* Unknown reboot cause */
+	kSys_DavicChange            = 0x01,	/* Reboot due to change in DAVIC
+						* mode */
+	kSys_UserReboot             = 0x02,	/* Reboot initiated by user */
+	kSys_SystemReboot           = 0x03,	/* Reboot initiated by OS */
+	kSys_TrapReboot             = 0x04,	/* Reboot due to a CPU trap */
+	kSys_SilentReboot           = 0x05,	/* Silent reboot */
+	kSys_BootLdrReboot          = 0x06,	/* Bootloader reboot */
+	kSys_PowerUpReboot          = 0x07,	/* Power on bootup.  Older
+						 * drivers may report as
+						 * userReboot. */
+	kSys_CodeChange             = 0x08,	/* Reboot to take code change.
+						 * Older drivers may report as
+						 * userReboot. */
+	kSys_HardwareReset          = 0x09,	/* HW Watchdog or front-panel
+						 * reset button reset.  Older
+						 * drivers may report as
+						 * userReboot. */
+	kSys_WatchdogInterrupt      = 0x0A	/* Pre-watchdog interrupt */
+};
+
+#endif /* _ASM_ASIC_H */
diff --git a/arch/mips/include/asm/mach-powertv/asic_regs.h b/arch/mips/include/asm/mach-powertv/asic_regs.h
new file mode 100644
index 0000000..8bdbec2
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/asic_regs.h
@@ -0,0 +1,136 @@
+
+#ifndef __ASIC_H_
+#define __ASIC_H_
+#include <linux/io.h>
+
+/* ASIC types */
+enum tAsicType {
+	ASIC_UNKNOWN,
+	ASIC_ZEUS,
+	ASIC_CALLIOPE,
+	ASIC_CRONUS,
+	ASIC_CRONUSLITE,
+	ASICS
+};
+
+/* hardcoded values read from Chip Version registers */
+#define CRONUS_10           0x0B4C1C20
+#define CRONUS_11           0x0B4C1C21
+#define CRONUSLITE_10       0x0B4C1C40
+
+#define NAND_FLASH_BASE     0x03000000
+#define ZEUS_IO_BASE        0x09000000
+#define CALLIOPE_IO_BASE    0x08000000
+#define CRONUS_IO_BASE      0x09000000
+#define ASIC_IO_SIZE        0x01000000
+
+/* ASIC register enumeration */
+struct tRegisterMap {          /* ==ZEUS==  ==CALLIOPE== */
+	int EIC_SLOW0_STRT_ADD;
+	int EIC_CFG_BITS;
+	int EIC_READY_STATUS;   /* 0x00004c    0x80004c */
+
+	int CHIPVER3;       /* 0x280800    0xA00800 */
+	int CHIPVER2;       /* 0x280804    0xA00804 */
+	int CHIPVER1;       /* 0x280808    0xA00808 */
+	int CHIPVER0;       /* 0x28080c    0xA0080c */
+
+	int UART1_INTSTAT;   /* 0x281800    0xA01800 */
+	int UART1_INTEN;     /* 0x281804    0xA01804 */
+	int UART1_CONFIG1;   /* 0x281808    0xA01808 */
+	int UART1_CONFIG2;   /* 0x28180C    0xA0180C */
+	int UART1_DIVISORHI; /* 0x281810    0xA01810 */
+	int UART1_DIVISORLO; /* 0x281814    0xA01814 */
+	int UART1_DATA;      /* 0x281818    0xA01818 */
+	int UART1_STATUS;    /* 0x28181C    0xA0181C */
+
+	int Int_Stat_3;     /* 0x282800    0xA02800 */
+	int Int_Stat_2;     /* 0x282804    0xA02804 */
+	int Int_Stat_1;     /* 0x282808    0xA02808 */
+	int Int_Stat_0;     /* 0x28280c    0xA0280c */
+	int Int_Config;     /* 0x282810    0xA02810 */
+	int Int_Int_Scan;   /* 0x282818    0xA02818 */
+	int Ien_Int_3;      /* 0x282830    0xA02830 */
+	int Ien_Int_2;      /* 0x282834    0xA02834 */
+	int Ien_Int_1;      /* 0x282838    0xA02838 */
+	int Ien_Int_0;      /* 0x28283c    0xA0283c */
+	int Int_Level_3_3;      /* 0x282880    0xA02880 */
+	int Int_Level_3_2;      /* 0x282884    0xA02884 */
+	int Int_Level_3_1;      /* 0x282888    0xA02888 */
+	int Int_Level_3_0;      /* 0x28288c    0xA0288c */
+	int Int_Level_2_3;      /* 0x282890    0xA02890 */
+	int Int_Level_2_2;      /* 0x282894    0xA02894 */
+	int Int_Level_2_1;      /* 0x282898    0xA02898 */
+	int Int_Level_2_0;      /* 0x28289c    0xA0289c */
+	int Int_Level_1_3;      /* 0x2828a0    0xA028a0 */
+	int Int_Level_1_2;      /* 0x2828a4    0xA028a4 */
+	int Int_Level_1_1;      /* 0x2828a8    0xA028a8 */
+	int Int_Level_1_0;      /* 0x2828ac    0xA028ac */
+	int Int_Level_0_3;      /* 0x2828b0    0xA028b0 */
+	int Int_Level_0_2;      /* 0x2828b4    0xA028b4 */
+	int Int_Level_0_1;      /* 0x2828b8    0xA028b8 */
+	int Int_Level_0_0;      /* 0x2828bc    0xA028bc */
+	int Int_Docsis_En;      /* 0x2828F4    0xA028F4 */
+
+	int MIPS_PLL_SETUP;     /* 0x1a0000    0x980000 */
+	int USB_FS;         /* 0x1a0018    0x980030 */
+	int Test_Bus;       /* 0x1a0238    0x9800CC */
+	int USB2_OHCI_IntMask;  /* 0x1e000c    0x9A000c */
+	int USB2_Strap;     /* 0x1e0014    0x9A0014 */
+	int EHCI_HCAPBASE;         /* 0x1FFE00    0x9BFE00 */
+	int OHCI_HcRevision;       /* 0x1FFC00    0x9BFC00 */
+	int BCM1_BS_LMI_STEER;     /* 0x2C0008    0x9E0004 */
+	int USB2_Control;          /* 0x2c01a0    0x9E0054 */
+	int USB2_STBUS_OBC;        /* 0x1FFF00    0x9BFF00 */
+	int USB2_STBUS_MESS_SIZE;  /* 0x1FFF04    0x9BFF04 */
+	int USB2_STBUS_CHUNK_SIZE; /* 0x1FFF08    0x9BFF08 */
+
+	int PCIe_Regs;      /* 0x200000    0x000000 */
+	int Free_Running_Ctr_Hi;    /* 0x282C10    0xA02C10 */
+	int Free_Running_Ctr_Lo;    /* 0x282C14    0xA02C14 */
+	int GPIO_DOUT;      /* 0x282c20    0xA02c20 */
+	int GPIO_DIN;       /* 0x282c24    0xA02c24 */
+	int GPIO_DIR;       /* 0x282c2c    0xA02c2c */
+	int Watchdog;       /* 0x282c30    0xA02c30 */
+	int Front_Panel;        /* 0x283800    0x000000 */
+
+	int REGISTER_MAPS;
+};
+
+extern enum tAsicType        gAsic;
+extern const struct tRegisterMap   *gRegisterMap;
+extern unsigned long        gAsicPhyBase;   /* Physical address of ASIC */
+extern unsigned long        pAsicBase;  /* Virtual address of ASIC */
+
+/*
+ * Macros to interface to registers through their ioremapped address
+ * asic_reg_offset	Returns the offset of a given register from the start
+ *			of the ASIC address space
+ * asic_reg_phys_addr	Returns the physical address of the given register
+ * asic_reg_addr	Returns the iomapped virtual address of the given
+ *			register.
+ */
+#define asic_reg_offset(x)  (gRegisterMap->x)
+#define asic_reg_phys_addr(x)   (gAsicPhyBase + asic_reg_offset(x))
+#define asic_reg_addr(x)    ((unsigned int *) (pAsicBase + asic_reg_offset(x)))
+
+/*
+ * The asic_reg macro is gone. It should be replaced by either asic_read or
+ * asic_write, as appropriate.
+ */
+
+#define	asic_read(x)		_asic_read(asic_reg_addr(x))
+#define	asic_write(v, x)	_asic_write(v, asic_reg_addr(x))
+
+static inline unsigned int _asic_read(unsigned int *addr)
+{
+	return readl(addr);
+}
+
+static inline void _asic_write(unsigned int value, unsigned int *addr)
+{
+	writel(value, addr);
+}
+
+extern void asic_irq_init(void);
+#endif
diff --git a/arch/mips/include/asm/mach-powertv/dma-coherence.h b/arch/mips/include/asm/mach-powertv/dma-coherence.h
new file mode 100644
index 0000000..b39f945
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/dma-coherence.h
@@ -0,0 +1,123 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Version from mach-generic modified to support PowerTV port
+ *
+ * Copyright (C) 2006  Ralf Baechle <ralf@linux-mips.org>
+ *
+ */
+#ifndef __ASM_MACH_GENERIC_DMA_COHERENCE_H
+#define __ASM_MACH_GENERIC_DMA_COHERENCE_H
+
+#include <linux/sched.h>
+#include <linux/version.h>
+#include <asm/mach-powertv/asic.h>
+
+struct device;
+
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
+#endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-powertv/interrupts.h b/arch/mips/include/asm/mach-powertv/interrupts.h
new file mode 100644
index 0000000..c37df64
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/interrupts.h
@@ -0,0 +1,234 @@
+#ifndef	_INTERRUPTS_H_
+#define	_INTERRUPTS_H_
+
+
+/*************************************************************
+ * \brief Defines for all of the interrupt lines
+ *************************************************************/
+
+#define kIBase 0
+
+/*------------- Register: Int_Stat_3 */
+/* 126 unused (bit 31) */
+#define kIrq_ASC2Video		(kIBase+126)	/* ASC 2 Video Interrupt */
+#define kIrq_ASC1Video		(kIBase+125)	/* ASC 1 Video Interrupt */
+#define kIrq_COMMS_BlockWd	(kIBase+124)	/* ASC 1 Video Interrupt */
+#define kIrq_FDMA_Mailbox	(kIBase+123)	/* FDMA Mailbox Output */
+#define kIrq_FDMA_GP		(kIBase+122)	/* FDMA GP Output */
+#define kIrq_MipsPIC		(kIBase+121)	/* MIPS Performance Counter
+						 * Interrupt */
+#define kIrq_MipsTimer		(kIBase+120)	/* MIPS Timer Interrupt */
+#define kIrq_Memory_Protect	(kIBase+119)	/* Memory Protection Interrupt
+						 * -- Ored by glue logic inside
+						 *  SPARC ILC (see
+						 *  INT_MEM_PROT_STAT, below,
+						 *  for individual interrupts)
+						 */
+/* 118 unused (bit 22) */
+#define kIrq_SBAG		(kIBase+117)	/* SBAG Interrupt -- Ored by
+						 * glue logic inside SPARC ILC
+						 * (see INT_SBAG_STAT, below,
+						 * for individual interrupts) */
+#define kIrq_QamB_FEC		(kIBase+116)	/* QAM  B FEC Interrupt */
+#define kIrq_QamA_FEC		(kIBase+115)	/* QAM A FEC Interrupt */
+/* 114 unused 	(bit 18) */
+#define kIrq_Mailbox		(kIBase+113)	/* Mailbox Debug Interrupt  --
+						 * Ored by glue logic inside
+						 * SPARC ILC (see
+						 * INT_MAILBOX_STAT, below, for
+						 * individual interrupts) */
+#define kIrq_FuseStat1		(kIBase+112)	/* Fuse Status 1 */
+#define kIrq_FuseStat2		(kIBase+111)	/* Fuse Status 2 */
+#define kIrq_FuseStat3		(kIBase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define kIrq_Blitter		(kIBase+110)	/* Blitter Interrupt / Fuse
+						 * Status 3 */
+#define kIrq_AVC1_PP0		(kIBase+109)	/* AVC Decoder #1 PP0
+						 * Interrupt */
+#define kIrq_AVC1_PP1		(kIBase+108)	/* AVC Decoder #1 PP1
+						 * Interrupt */
+#define kIrq_AVC1_MBE		(kIBase+107)	/* AVC Decoder #1 MBE
+						 * Interrupt */
+#define kIrq_AVC2_PP0		(kIBase+106)	/* AVC Decoder #2 PP0
+						 * Interrupt */
+#define kIrq_AVC2_PP1		(kIBase+105)	/* AVC Decoder #2 PP1
+						 * Interrupt */
+#define kIrq_AVC2_MBE		(kIBase+104)	/* AVC Decoder #2 MBE
+						 * Interrupt */
+#define kIrq_ZbugSpi		(kIBase+103)	/* Zbug SPI Slave Interrupt */
+#define kIrq_QAM_MOD2		(kIBase+102)	/* QAM Modulator 2 DMA
+						 * Interrupt */
+#define kIrq_IrRx		(kIBase+101)	/* IR RX 2 Interrupt */
+#define kIrq_AudDsp2		(kIBase+100)	/* Audio DSP #2 Interrupt */
+#define kIrq_AudDsp1		(kIBase+99)	/* Audio DSP #1 Interrupt */
+#define kIrq_Docsis		(kIBase+98)	/* DOCSIS Debug Interrupt */
+#define kIrq_SdDVP1		(kIBase+97)	/* SD DVP #1 Interrupt */
+#define kIrq_SdDVP2		(kIBase+96)	/* SD DVP #2 Interrupt */
+/*------------- Register: Int_Stat_2 */
+#define kIrq_HdDVP		(kIBase+95)	/* HD DVP Interrupt */
+#define kIrq_PreWatchdog	(kIBase+94)	/* Watchdog Pre-Interrupt */
+#define kIrq_Timer2		(kIBase+93)	/* Programmable Timer
+						 * Interrupt 2 */
+#define kIrq_1394		(kIBase+92)	/* 1394 Firewire Interrupt */
+#define kIrq_USBOHCI		(kIBase+91)	/* USB 2.0 OHCI Interrupt */
+#define kIrq_USBEHCI		(kIBase+90)	/* USB 2.0 EHCI Interrupt */
+#define kIrq_PCIExp		(kIBase+89)	/* PCI Express 0 Interrupt */
+#define kIrq_PCIExp0		(kIBase+89)	/* PCI Express 0 Interrupt */
+#define kIrq_AFE1		(kIBase+88)	/* AFE 1 Interrupt */
+#define kIrq_SATA		(kIBase+87)	/* SATA 1 Interrupt */
+#define kIrq_SATA1		(kIBase+87)	/* SATA 1 Interrupt */
+#define kIrq_DTCP		(kIBase+86)	/* DTCP Interrupt */
+#define kIrq_PCIExp1		(kIBase+85)	/* PCI Express 1 Interrupt */
+/* 84 unused 	(bit 20) */
+/* 83 unused 	(bit 19) */
+/* 82 unused 	(bit 18) */
+#define kIrq_SATA2		(kIBase+81)	/* SATA2 Interrupt */
+#define kIrq_Uart2		(kIBase+80)	/* UART2 Interrupt */
+#define kIrq_LegacyUSB		(kIBase+79)	/* Legacy USB Host ISR (1.1
+						 * Host module) */
+#define kIrq_POD		(kIBase+78)	/* POD Interrupt */
+#define kIrq_SlaveUSB		(kIBase+77)	/* Slave USB */
+#define kIrq_Denc1		(kIBase+76)	/* DENC #1 VTG Interrupt */
+#define kIrq_VbiVTG		(kIBase+75)	/* VBI VTG Interrupt */
+#define kIrq_AFE2		(kIBase+74)	/* AFE 2 Interrupt */
+#define kIrq_Denc2		(kIBase+73)	/* DENC #2 VTG Interrupt */
+#define kIrq_ASC2		(kIBase+72)	/* ASC #2 Interrupt */
+#define kIrq_ASC1		(kIBase+71)	/* ASC #1 Interrupt */
+#define kIrq_ModDMA		(kIBase+70)	/* Modulator DMA Interrupt */
+#define kIrq_ByteEng1		(kIBase+69)	/* Byte Engine Interrupt [1] */
+#define kIrq_ByteEng0		(kIBase+68)	/* Byte Engine Interrupt [0] */
+/* 67 unused 	(bit 03) */
+/* 66 unused 	(bit 02) */
+/* 65 unused 	(bit 01) */
+/* 64 unused 	(bit 00) */
+/*------------- Register: Int_Stat_1 */
+/* 63 unused 	(bit 31) */
+/* 62 unused 	(bit 30) */
+/* 61 unused 	(bit 29) */
+/* 60 unused 	(bit 28) */
+/* 59 unused 	(bit 27) */
+/* 58 unused 	(bit 26) */
+/* 57 unused 	(bit 25) */
+/* 56 unused 	(bit 24) */
+#define kIrq_BufDMA_Mem2Mem	(kIBase+55)	/* BufDMA Memory to Memory
+						 * Interrupt */
+#define kIrq_BufDMA_USBTransmit	(kIBase+54)	/* BufDMA USB Transmit
+						 * Interrupt */
+#define kIrq_BufDMA_QPSKPODTransmit (kIBase+53)	/* BufDMA QPSK/POD Tramsit
+						 * Interrupt */
+#define kIrq_BufDMA_TransmitError (kIBase+52)	/* BufDMA Transmit Error
+						 * Interrupt */
+#define kIrq_BufDMA_USBRecv	(kIBase+51)	/* BufDMA USB Receive
+						 * Interrupt */
+#define kIrq_BufDMA_QPSKPODRecv	(kIBase+50)	/* BufDMA QPSK/POD Receive
+						 * Interrupt */
+#define kIrq_BufDMA_RecvError	(kIBase+49)	/* BufDMA Receive Error
+						 * Interrupt */
+#define kIrq_QAMDMA_TransmitPlay (kIBase+48)	/* QAMDMA Transmit/Play
+						 * Interrupt */
+#define kIrq_QAMDMA_TransmitError (kIBase+47)	/* QAMDMA Transmit Error
+						 * Interrupt */
+#define kIrq_QAMDMA_Recv2High	(kIBase+46)	/* QAMDMA Receive 2 High
+						 * (Chans 63-32) */
+#define kIrq_QAMDMA_Recv2Low	(kIBase+45)	/* QAMDMA Receive 2 Low
+						 * (Chans 31-0) */
+#define kIrq_QAMDMA_Recv1High	(kIBase+44)	/* QAMDMA Receive 1 High
+						 * (Chans 63-32) */
+#define kIrq_QAMDMA_Recv1Low	(kIBase+43)	/* QAMDMA Receive 1 Low
+						 * (Chans 31-0) */
+#define kIrq_QAMDMA_RecvError	(kIBase+42)	/* QAMDMA Receive Error
+						 * Interrupt */
+#define kIrq_MPEGSplice		(kIBase+41)	/* MPEG Splice Interrupt */
+#define kIrq_DeinterlaceRdy	(kIBase+40)	/* Deinterlacer Frame Ready
+						 * Interrupt */
+#define kIrq_ExtIn0		(kIBase+39)	/* External Interrupt irq_in0 */
+#define kIrq_Gpio3		(kIBase+38)	/* GP I/O IRQ 3 - From GP I/O
+						 * Module */
+#define kIrq_Gpio2		(kIBase+37)	/* GP I/O IRQ 2 - From GP I/O
+						 * Module (ABE_intN) */
+#define kIrq_PCRCmplt1		(kIBase+36)	/* PCR Capture Complete  or
+						 * Discontinuity 1 */
+#define kIrq_PCRCmplt2		(kIBase+35)	/* PCR Capture Complete or
+						 * Discontinuity 2 */
+#define kIrq_ParsePEIErr	(kIBase+34)	/* PID Parser Error Detect
+						 * (PEI) */
+#define kIrq_ParseContErr	(kIBase+33)	/* PID Parser continuity error
+						 * detect */
+#define kIrq_DS1Framer		(kIBase+32)	/* DS1 Framer Interrupt */
+/*------------- Register: Int_Stat_0 */
+#define kIrq_Gpio1		(kIBase+31)	/* GP I/O IRQ 1 - From GP I/O
+						 * Module */
+#define kIrq_Gpio0		(kIBase+30)	/* GP I/O IRQ 0 - From GP I/O
+						 * Module */
+#define kIrq_QpskOutAloha	(kIBase+29)	/* QPSK Output Slotted Aloha
+						 * (chan 3) Transmission
+						 * Completed OK */
+#define kIrq_QpskOutTdma	(kIBase+28)	/* QPSK Output TDMA (chan 2)
+						 * Transmission Completed OK */
+#define kIrq_QpskOutReserve	(kIBase+27)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * Completed OK */
+#define kIrq_QpskOutAlohaErr	(kIBase+26)	/* QPSK Output Slotted Aloha
+						 * (chan 3)Transmission
+						 * completed with Errors. */
+#define kIrq_QpskOutTdmaErr	(kIBase+25)	/* QPSK Output TDMA (chan 2)
+						 * Transmission completed with
+						 * Errors. */
+#define kIrq_QpskOutRsrvErr	(kIBase+24)	/* QPSK Output Reservation
+						 * (chan 1) Transmission
+						 * completed with Errors */
+#define kIrq_AlohaFail		(kIBase+23)	/* Unsuccessful Resend of Aloha
+						 * for N times. Aloha retry
+						 * timeout for channel 3. */
+#define kIrq_Timer1		(kIBase+22)	/* Programmable Timer
+						 * Interrupt */
+#define kIrq_Keyboard		(kIBase+21)	/* Keyboard Module Interrupt */
+#define kIrq_I2c		(kIBase+20)	/* I2C Module Interrupt */
+#define kIrq_Spi		(kIBase+19)	/* SPI Module Interrupt */
+#define kIrq_IRBlaster		(kIBase+18)	/* IR Blaster Interrupt */
+#define kIrq_SpliceDetect	(kIBase+17)	/* PID Key Change Interrupt or
+						 * Splice Detect Interrupt */
+#define kIrq_SeMicro		(kIBase+16)	/* Secure Micro I/F Module
+						 * Interrupt */
+#define kIrq_Uart1		(kIBase+15)	/* UART Interrupt */
+#define kIrq_IRrecv		(kIBase+14)	/* IR Receiver Interrupt */
+#define kIrq_HostInt1		(kIBase+13)	/* Host-to-Host Interrupt 1 */
+#define kIrq_HostInt0		(kIBase+12)	/* Host-to-Host Interrupt 0 */
+#define kIrq_QpskHECErr		(kIBase+11)	/* QPSK HEC Error Interrupt */
+#define kIrq_QpskCRCErr		(kIBase+10)	/* QPSK AAL-5 CRC Error
+						 * Interrupt */
+/* 9 unused 	(bit 09) */
+/* 8 unused 	(bit 08) */
+#define kIrq_PSICRCErr		(kIBase+7) 	/* QAM PSI CRC Error
+						 * Interrupt */
+#define kIrq_PSILengthErr	(kIBase+6) 	/* QAM PSI Length Error
+						 * Interrupt */
+#define kIrq_ESFForward		(kIBase+5) 	/* ESF Interrupt Mark From
+						 * Forward Path Reference -
+						 * every 3ms when forward Mbits
+						 * and forward slot control
+						 * bytes are updated. */
+#define kIrq_ESFReverse		(kIBase+4) 	/* ESF Interrupt Mark from
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
+#define kIrq_AlohaTimeout	(kIBase+3) 	/* Slotted-Aloha timeout on
+						 * Channel 1. */
+#define kIrq_Reservation	(kIBase+2) 	/* Partial (or Incremental)
+						 * Reservation Message Completed
+						 * or Slotted aloha verify for
+						 * channel 1. */
+#define kIrq_Aloha3		(kIBase+1) 	/* Slotted-Aloha Message Verify
+						 * Interrupt or Reservation
+						 * increment completed for
+						 * channel 3. */
+#define kIrq_MpegD		(kIBase+0) 	/* MPEG Decoder Interrupt */
+#endif	/* _INTERRUPTS_H_ */
+
diff --git a/arch/mips/include/asm/mach-powertv/war.h b/arch/mips/include/asm/mach-powertv/war.h
new file mode 100644
index 0000000..2f4a155
--- /dev/null
+++ b/arch/mips/include/asm/mach-powertv/war.h
@@ -0,0 +1,27 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * This version for the PowerTV platform copied from the Malta version.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_MIPS_WAR_H
+#define __ASM_MIPS_MACH_MIPS_WAR_H
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
+#endif /* __ASM_MIPS_MACH_MIPS_WAR_H */
diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
new file mode 100644
index 0000000..ada1732
--- /dev/null
+++ b/arch/mips/powertv/Kconfig
@@ -0,0 +1,17 @@
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
+	  and must be exactly two characters long.
+
diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
new file mode 100644
index 0000000..87886e0
--- /dev/null
+++ b/arch/mips/powertv/Makefile
@@ -0,0 +1,37 @@
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
+#
+# Carsten Langgaard, carstenl@mips.com
+# Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
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
+# Makefile for the MIPS Malta specific kernel interface routines
+# under Linux.
+#
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
index 0000000..48b85ea
--- /dev/null
+++ b/arch/mips/powertv/asic/Kconfig
@@ -0,0 +1,24 @@
+config MIN_RUNTIME_RESOURCES
+	bool "Support for minimum runtime resources"
+	depends on POWERTV
+	help
+	  Enables support for minimizing the number of (SA asic) runtime
+	  resources that are preallocated by the kernel.
+
+config MIN_RUNTIME_DOCSIS
+	bool "Support for minimum DOCSIS resource"
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated DOCSIS resource.
+
+config MIN_RUNTIME_PMEM
+	bool "Support for minimum PMEM resource"
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated Memory resource.
+
+config MIN_RUNTIME_TFTP
+	bool "Support for minimum TFTP resource"
+	depends on MIN_RUNTIME_RESOURCES
+	help
+	  Enables support for the preallocated TFTP resource.
diff --git a/arch/mips/powertv/asic/Makefile b/arch/mips/powertv/asic/Makefile
new file mode 100644
index 0000000..52d4336
--- /dev/null
+++ b/arch/mips/powertv/asic/Makefile
@@ -0,0 +1,24 @@
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
+obj-y	:=
+
+obj-$(CONFIG_POWERTV)	+=	irq_asic.o asic_devices.o asic_int.o
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
new file mode 100644
index 0000000..2e67979
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -0,0 +1,2902 @@
+/****************************************************************************
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
+ * See Also:
+ *
+ * Project:      SA explorer settops
+ *
+ * Compiler:
+ *
+ * Author:       Ken Eppinett
+ *               David Schleef <ds@schleef.org>
+ *
+ * Description:  Defines the platform resources for the SA settop.
+ *
+ * NOTE: The bootloader allocates persistent memory at an address which is
+ * 16 MiB below the end of the highest address in KSEG0. All fixed
+ * address memory reservations must avoid this region.
+ *
+ *****************************************************************************
+ * History:
+ * Rev Level     Date         Name       ECN#      Description
+ *----------------------------------------------------------------------------
+ * 1.0                     Eppinett                initial version
+ ****************************************************************************/
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
+/******************************************************************************
+ * Forward Prototypes
+ *****************************************************************************/
+static void pmem_setup_resource(void);
+
+/******************************************************************************
+ * Global Variables
+ *****************************************************************************/
+enum tAsicType gAsic;
+
+unsigned int        gPlatformFeatures;
+unsigned int        gPlatformFamily;
+const struct tRegisterMap  *gRegisterMap;
+EXPORT_SYMBOL(gRegisterMap);			/* Exported for testing */
+unsigned long       gAsicPhyBase;
+unsigned long       pAsicBase;
+EXPORT_SYMBOL(pAsicBase);			/* Exported for testing */
+struct resource     *gpResources;
+static bool usb_configured;
+
+/*
+ * Don't recommend to use it directly, it is usually used by kernel internally.
+ * Portable code should be using interfaces such as ioremp, dma_map_single, etc.
+ */
+unsigned long       gPhysToBusOffset;
+EXPORT_SYMBOL(gPhysToBusOffset);
+
+static const struct tRegisterMap zeus_register_map = {
+	.EIC_SLOW0_STRT_ADD = 0x000000,
+	.EIC_CFG_BITS = 0x000038,
+	.EIC_READY_STATUS = 0x00004c,
+
+	.CHIPVER3 = 0x280800,
+	.CHIPVER2 = 0x280804,
+	.CHIPVER1 = 0x280808,
+	.CHIPVER0 = 0x28080c,
+
+	/* The registers of IRBlaster */
+	.UART1_INTSTAT = 0x281800,
+	.UART1_INTEN = 0x281804,
+	.UART1_CONFIG1 = 0x281808,
+	.UART1_CONFIG2 = 0x28180C,
+	.UART1_DIVISORHI = 0x281810,
+	.UART1_DIVISORLO = 0x281814,
+	.UART1_DATA = 0x281818,
+	.UART1_STATUS = 0x28181C,
+
+	.Int_Stat_3 = 0x282800,
+	.Int_Stat_2 = 0x282804,
+	.Int_Stat_1 = 0x282808,
+	.Int_Stat_0 = 0x28280c,
+	.Int_Config = 0x282810,
+	.Int_Int_Scan = 0x282818,
+	.Ien_Int_3 = 0x282830,
+	.Ien_Int_2 = 0x282834,
+	.Ien_Int_1 = 0x282838,
+	.Ien_Int_0 = 0x28283c,
+	.Int_Level_3_3 = 0x282880,
+	.Int_Level_3_2 = 0x282884,
+	.Int_Level_3_1 = 0x282888,
+	.Int_Level_3_0 = 0x28288c,
+	.Int_Level_2_3 = 0x282890,
+	.Int_Level_2_2 = 0x282894,
+	.Int_Level_2_1 = 0x282898,
+	.Int_Level_2_0 = 0x28289c,
+	.Int_Level_1_3 = 0x2828a0,
+	.Int_Level_1_2 = 0x2828a4,
+	.Int_Level_1_1 = 0x2828a8,
+	.Int_Level_1_0 = 0x2828ac,
+	.Int_Level_0_3 = 0x2828b0,
+	.Int_Level_0_2 = 0x2828b4,
+	.Int_Level_0_1 = 0x2828b8,
+	.Int_Level_0_0 = 0x2828bc,
+	.Int_Docsis_En = 0x2828F4,
+
+	.MIPS_PLL_SETUP = 0x1a0000,
+	.USB_FS = 0x1a0018,
+	.Test_Bus = 0x1a0238,
+	.USB2_OHCI_IntMask = 0x1e000c,
+	.USB2_Strap = 0x1e0014,
+	.EHCI_HCAPBASE = 0x1FFE00,
+	.OHCI_HcRevision = 0x1FFC00,
+	.BCM1_BS_LMI_STEER = 0x2C0008,
+	.USB2_Control = 0x2c01a0,
+	.USB2_STBUS_OBC = 0x1FFF00,
+	.USB2_STBUS_MESS_SIZE = 0x1FFF04,
+	.USB2_STBUS_CHUNK_SIZE = 0x1FFF08,
+
+	.PCIe_Regs = 0x200000,
+	.Free_Running_Ctr_Hi = 0x282C10,
+	.Free_Running_Ctr_Lo = 0x282C14,
+	.GPIO_DOUT = 0x282c20,
+	.GPIO_DIN = 0x282c24,
+	.GPIO_DIR = 0x282c2C,
+	.Watchdog = 0x282c30,
+	.Front_Panel = 0x283800,
+};
+
+static const struct tRegisterMap calliope_register_map = {
+	.EIC_SLOW0_STRT_ADD = 0x800000,
+	.EIC_CFG_BITS = 0x800038,
+	.EIC_READY_STATUS = 0x80004c,
+
+	.CHIPVER3 = 0xA00800,
+	.CHIPVER2 = 0xA00804,
+	.CHIPVER1 = 0xA00808,
+	.CHIPVER0 = 0xA0080c,
+
+	/* The registers of IRBlaster */
+	.UART1_INTSTAT = 0xA01800,
+	.UART1_INTEN = 0xA01804,
+	.UART1_CONFIG1 = 0xA01808,
+	.UART1_CONFIG2 = 0xA0180C,
+	.UART1_DIVISORHI = 0xA01810,
+	.UART1_DIVISORLO = 0xA01814,
+	.UART1_DATA = 0xA01818,
+	.UART1_STATUS = 0xA0181C,
+
+	.Int_Stat_3 = 0xA02800,
+	.Int_Stat_2 = 0xA02804,
+	.Int_Stat_1 = 0xA02808,
+	.Int_Stat_0 = 0xA0280c,
+	.Int_Config = 0xA02810,
+	.Int_Int_Scan = 0xA02818,
+	.Ien_Int_3 = 0xA02830,
+	.Ien_Int_2 = 0xA02834,
+	.Ien_Int_1 = 0xA02838,
+	.Ien_Int_0 = 0xA0283c,
+	.Int_Level_3_3 = 0xA02880,
+	.Int_Level_3_2 = 0xA02884,
+	.Int_Level_3_1 = 0xA02888,
+	.Int_Level_3_0 = 0xA0288c,
+	.Int_Level_2_3 = 0xA02890,
+	.Int_Level_2_2 = 0xA02894,
+	.Int_Level_2_1 = 0xA02898,
+	.Int_Level_2_0 = 0xA0289c,
+	.Int_Level_1_3 = 0xA028a0,
+	.Int_Level_1_2 = 0xA028a4,
+	.Int_Level_1_1 = 0xA028a8,
+	.Int_Level_1_0 = 0xA028ac,
+	.Int_Level_0_3 = 0xA028b0,
+	.Int_Level_0_2 = 0xA028b4,
+	.Int_Level_0_1 = 0xA028b8,
+	.Int_Level_0_0 = 0xA028bc,
+	.Int_Docsis_En = 0xA028F4,
+
+	.MIPS_PLL_SETUP = 0x980000,
+	.USB_FS = 0x980030,     	/* -default 72800028- */
+	.Test_Bus = 0x9800CC,
+	.USB2_OHCI_IntMask = 0x9A000c,
+	.USB2_Strap = 0x9A0014,
+	.EHCI_HCAPBASE = 0x9BFE00,
+	.OHCI_HcRevision = 0x9BFC00,
+	.BCM1_BS_LMI_STEER = 0x9E0004,
+	.USB2_Control = 0x9E0054,
+	.USB2_STBUS_OBC = 0x9BFF00,
+	.USB2_STBUS_MESS_SIZE = 0x9BFF04,
+	.USB2_STBUS_CHUNK_SIZE = 0x9BFF08,
+
+	.PCIe_Regs = 0x000000,      	/* -doesn't exist- */
+	.Free_Running_Ctr_Hi = 0xA02C10,
+	.Free_Running_Ctr_Lo = 0xA02C14,
+	.GPIO_DOUT = 0xA02c20,
+	.GPIO_DIN = 0xA02c24,
+	.GPIO_DIR = 0xA02c2C,
+	.Watchdog = 0xA02c30,
+	.Front_Panel = 0x000000,    	/* -not used- */
+};
+
+static const struct tRegisterMap cronus_register_map = {
+	.EIC_SLOW0_STRT_ADD = 0x000000,
+	.EIC_CFG_BITS = 0x000038,
+	.EIC_READY_STATUS = 0x00004C,
+
+	.CHIPVER3 = 0x2A0800,
+	.CHIPVER2 = 0x2A0804,
+	.CHIPVER1 = 0x2A0808,
+	.CHIPVER0 = 0x2A080C,
+
+	/* The registers of IRBlaster */
+	.UART1_INTSTAT = 0x2A1800,
+	.UART1_INTEN = 0x2A1804,
+	.UART1_CONFIG1 = 0x2A1808,
+	.UART1_CONFIG2 = 0x2A180C,
+	.UART1_DIVISORHI = 0x2A1810,
+	.UART1_DIVISORLO = 0x2A1814,
+	.UART1_DATA = 0x2A1818,
+	.UART1_STATUS = 0x2A181C,
+
+	.Int_Stat_3 = 0x2A2800,
+	.Int_Stat_2 = 0x2A2804,
+	.Int_Stat_1 = 0x2A2808,
+	.Int_Stat_0 = 0x2A280C,
+	.Int_Config = 0x2A2810,
+	.Int_Int_Scan = 0x2A2818,
+	.Ien_Int_3 = 0x2A2830,
+	.Ien_Int_2 = 0x2A2834,
+	.Ien_Int_1 = 0x2A2838,
+	.Ien_Int_0 = 0x2A283C,
+	.Int_Level_3_3 = 0x2A2880,
+	.Int_Level_3_2 = 0x2A2884,
+	.Int_Level_3_1 = 0x2A2888,
+	.Int_Level_3_0 = 0x2A288C,
+	.Int_Level_2_3 = 0x2A2890,
+	.Int_Level_2_2 = 0x2A2894,
+	.Int_Level_2_1 = 0x2A2898,
+	.Int_Level_2_0 = 0x2A289C,
+	.Int_Level_1_3 = 0x2A28A0,
+	.Int_Level_1_2 = 0x2A28A4,
+	.Int_Level_1_1 = 0x2A28A8,
+	.Int_Level_1_0 = 0x2A28AC,
+	.Int_Level_0_3 = 0x2A28B0,
+	.Int_Level_0_2 = 0x2A28B4,
+	.Int_Level_0_1 = 0x2A28B8,
+	.Int_Level_0_0 = 0x2A28BC,
+	.Int_Docsis_En = 0x2A28F4,
+
+	.MIPS_PLL_SETUP = 0x1C0000,
+	.USB_FS = 0x1C0018,
+	.Test_Bus = 0x1C00CC,
+	.USB2_OHCI_IntMask = 0x20000C,
+	.USB2_Strap = 0x200014,
+	.EHCI_HCAPBASE = 0x21FE00,
+	.OHCI_HcRevision = 0x1E0000,
+	.BCM1_BS_LMI_STEER = 0x2E0008,
+	.USB2_Control = 0x2E004C,
+	.USB2_STBUS_OBC = 0x21FF00,
+	.USB2_STBUS_MESS_SIZE = 0x21FF04,
+	.USB2_STBUS_CHUNK_SIZE = 0x21FF08,
+
+	.PCIe_Regs = 0x220000,
+	.Free_Running_Ctr_Hi = 0x2A2C10,
+	.Free_Running_Ctr_Lo = 0x2A2C14,
+	.GPIO_DOUT = 0x2A2C20,
+	.GPIO_DIN = 0x2A2C24,
+	.GPIO_DIR = 0x2A2C2C,
+	.Watchdog = 0x2A2C30,
+	.Front_Panel = 0x2A3800,
+};
+
+/******************************************************************************
+ * DVR_CAPABLE RESOURCES
+ *****************************************************************************/
+struct resource dvr_zeus_resources[] =
+{
+	/**********************************************************************
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00c00000 - 1,	/* 12 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,	/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "ITFS",
+		.start  = 0x00000000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x0018DFFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+/******************************************************************************
+ * NON_DVR_CAPABLE ZEUS RESOURCES
+ *****************************************************************************/
+struct resource non_dvr_zeus_resources[] =
+{
+	/**********************************************************************
+	 * VIDEO1 / LX1
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Sysaudio Driver
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * STAVEM driver/STAPI
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DOCSIS Subsystem
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x40100000,
+		.end    = 0x407fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * GHW HAL Driver
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x46900000,
+		.end    = 0x47700000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * multi com buffer area
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x47900000,
+		.end    = 0x47920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DMA Ring buffer
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit0
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 *********************************************************************/
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * PMEM
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Smartcard
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 *
+	 * End of Resource marker
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+/******************************************************************************
+ * NON_DVR_CAPABLE CALLIOPE RESOURCES
+ *****************************************************************************/
+struct resource non_dvr_calliope_resources[] =
+{
+	/**********************************************************************
+	 * VIDEO / LX1
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Sysaudio Driver
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * STAVEM driver/STAPI
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00600000 - 1,	/* 6 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DOCSIS Subsystem
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x22000000,
+		.end    = 0x22700000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * GHW HAL Driver
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * multi com buffer area
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DMA Ring buffer (don't need recording buffers)
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit0
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 *********************************************************************/
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,	/* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * PMEM
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Smartcard
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 * Synopsys GMAC Memory Region
+	 *********************************************************************/
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 *
+	 */
+	/*
+	 * End of Resource marker
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+struct resource non_dvr_vz_calliope_resources[] =
+{
+	/**********************************************************************
+	 * VIDEO / LX1
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Sysaudio Driver
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * STAVEM driver/STAPI
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20300000,
+		.end    = 0x20620000-1,  /*3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * GHW HAL Driver
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20300000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * multi com buffer area
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23900000,
+		.end    = 0x23920000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DMA Ring buffer
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit0
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * PMEM
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Smartcard
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 * Synopsys GMAC Memory Region
+	 *********************************************************************/
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+
+/*
+ * NOTES:
+ *
+ * There are two things to be done on CRONUS platforms when we try to reserve
+ * the space of HIGHMEM for a specific device.
+ *
+ * 1. "IORESOURCE_MEM" flag can't be used anymore, it should be changed to
+ *    "IORESOURCE_IO".
+ *
+ * 2. For the kernel with HIGHMEM support, we have to do some work in the
+ *    memory configuration (in memory.c) since we don't make any actual
+ *    reservation which has "IORESOURCE_IO" flag through bootmem allocator.
+ *
+ * TODO: Find a solution to make it working easily.
+ */
+
+static struct resource non_dvr_vze_calliope_resources[] __initdata =
+{
+	/**********************************************************************
+	 * VIDEO / LX1
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Sysaudio Driver
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * STAVEM driver/STAPI
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x20396000,
+		.end    = 0x206B6000 - 1,		/* 3.125 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * GHW HAL Driver
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x20100000,
+		.end    = 0x20396000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * multi com buffer area
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x206B6000,
+		.end    = 0x206D6000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DMA Ring buffer
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit0
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * PMEM
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Smartcard
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE+0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Synopsys GMAC Memory Region
+	 *********************************************************************/
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+static struct resource non_dvr_vzf_calliope_resources[] __initdata =
+{
+	/**********************************************************************
+	 * VIDEO / LX1
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Sysaudio Driver
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * STAVEM driver/STAPI
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x00000000,
+		.end    = 0x00480000 - 1,  /* 4.5 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * GHW HAL Driver
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x22700000,
+		.end    = 0x23500000 - 1, /* 14 MB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * multi com buffer area
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x23700000,
+		.end    = 0x23720000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * DMA Ring buffer (don't need recording buffers)
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit0
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Display bins buffer for unit1
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,  /* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 *********************************************************************/
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x00000000,
+		.end    = 0x002c4c00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * PMEM
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Smartcard
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x00000000,
+		.end    = 0x2800 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Synopsys GMAC Memory Region
+	 *********************************************************************/
+	{
+		.name   = "GMAC",
+		.start  = 0x00000000,
+		.end    = 0x00010000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*********************************************************************
+	 * End of Resource marker
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+/******************************************************************************
+ * DVR_CAPABLE CRONUS RESOURCES
+ *****************************************************************************/
+struct resource dvr_cronus_resources[] =
+{
+	/**********************************************************************
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x00280000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * ITFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "ITFS",
+		.start  = 0x64180000,
+		/* 815,104 bytes each for 2 ITFS partitions. */
+		.end    = 0x6430DFFF,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+/******************************************************************************
+ * NON_DVR_CAPABLE CRONUSLITE RESOURCES
+ *****************************************************************************/
+struct resource non_dvr_cronuslite_resources[] =
+{
+	/**********************************************************************
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x63B80000 - 1,  /* 6 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x63B83000,
+		.end    = 0x63B84000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 *********************************************************************/
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x63B84000,
+		.end    = 0x63E48C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x63B80000,
+		.end    = 0x63B82800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * NAND Flash
+	 *********************************************************************/
+	{
+		.name   = "NandFlash",
+		.start  = NAND_FLASH_BASE,
+		.end    = NAND_FLASH_BASE + 0x400 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
+
+/******************************************************************************
+ * NON_DVR_CAPABLE CRONUS RESOURCES
+ *****************************************************************************/
+struct resource non_dvr_cronus_resources[] =
+{
+	/**********************************************************************
+	 *
+	 * VIDEO1 / LX1
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
+	 *
+	 * VIDEO2 / LX2
+	 *
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
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
+	/**********************************************************************
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
+	 *********************************************************************/
+	{
+		.name   = "AVMEMPartition0",
+		.start  = 0x63580000,
+		.end    = 0x64180000 - 1,  /* 12 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * DOCSIS Subsystem
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "Docsis",
+		.start  = 0x62000000,
+		.end    = 0x62700000 - 1,	/* 7 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * GHW HAL Driver
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  GraphicsHeap - PowerTV Graphics Heap
+	 *
+	 *********************************************************************/
+	{
+		.name   = "GraphicsHeap",
+		.start  = 0x62700000,
+		.end    = 0x63500000 - 1,	/* 14 MB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * multi com buffer area
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "MulticomSHM",
+		.start  = 0x26000000,
+		.end    = 0x26020000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * DMA Ring buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Docsis -
+	 *
+	 *********************************************************************/
+	{
+		.name   = "BMM_Buffer",
+		.start  = 0x00000000,
+		.end    = 0x000AA000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer for unit0
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit0
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins0",
+		.start  = 0x00000000,
+		.end    = 0x00000FFF,		/* 4 KB total */
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Display bins buffer
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Display Bins for unit1
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DisplayBins1",
+		.start  = 0x64AD4000,
+		.end    = 0x64AD5000 - 1,  /* 4 KB total */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * AVFS: player HAL memory
+	 *
+	 *
+	 *********************************************************************/
+	{
+		.name   = "AvfsDmaMem",
+		.start  = 0x6430E000,
+		.end    = 0x645D2C00 - 1,  /* 945K * 3 for playback */
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * PMEM
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Persistent memory for diagnostics.
+	 *
+	 *********************************************************************/
+	{
+		.name   = "DiagPersistentMemory",
+		.start  = 0x00000000,
+		.end    = 0x10000 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	/**********************************************************************
+	 *
+	 * Smartcard
+	 *
+	 * This driver requires:
+	 *
+	 * Arbitrary Based Buffers:
+	 *  Read and write buffers for Internal/External cards
+	 *
+	 *********************************************************************/
+	{
+		.name   = "SmartCardInfo",
+		.start  = 0x64AD1000,
+		.end    = 0x64AD3800 - 1,
+		.flags  = IORESOURCE_IO,
+	},
+	/**********************************************************************
+	 *
+	 * KAVNET
+	 *    NP Reset Vector - must be of the form xxCxxxxx
+	 *	   NP Image - must be video bank 1
+	 *	   NP IPC - must be video bank 2
+	 *********************************************************************/
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
+	/**********************************************************************
+	 * Add other resources here
+	 */
+	/*
+	 * End of Resource marker
+	 *
+	 *********************************************************************/
+	{
+		.flags  = 0,
+	},
+};
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
+		.start  = kIrq_USBEHCI,
+		.end    = kIrq_USBEHCI,
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
+		.start  = kIrq_USBOHCI,
+		.end    = kIrq_USBOHCI,
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
+	asic_write(val, USB_FS);
+	asic_write(val | (en_prg<<4), USB_FS);
+	asic_write(val | (en_prg<<4) | pwr, USB_FS);
+}
+
+/*
+ * \brief platform_get_family() determine major platform family type.
+ *
+ * \param     none
+ *
+ * \return    family type; -1 if none
+ *
+ */
+enum tFamilyType platform_get_family(void)
+{
+#define BOOTLDRFAMILY(byte1, byte0) (((byte1) << 8) | (byte0))
+
+	unsigned short bootldrFamily;
+	static enum tFamilyType family = -1;
+	static int firstTime = 1;
+
+	if (firstTime) {
+		firstTime = 0;
+
+#ifdef CONFIG_BOOTLOADER_DRIVER
+		bootldrFamily = (unsigned short) kbldr_GetSWFamily();
+#else
+#if defined(CONFIG_BOOTLOADER_FAMILY)
+		bootldrFamily = (unsigned short) BOOTLDRFAMILY(
+			CONFIG_BOOTLOADER_FAMILY[0],
+			CONFIG_BOOTLOADER_FAMILY[1]);
+#else
+#error "Unknown Bootloader Family"
+#endif
+#endif
+
+		pr_info("Bootloader Family = 0x%04X\n", bootldrFamily);
+
+		switch (bootldrFamily) {
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
+
+#undef BOOTLDRFAMILY
+}
+EXPORT_SYMBOL(platform_get_family);
+
+/*
+ * \brief platform_get_asic() determine the ASIC type.
+ *
+ * \param     none
+ *
+ * \return    ASIC type; ASIC_UNKNOWN if none
+ *
+ */
+enum tAsicType platform_get_asic(void)
+{
+	return gAsic;
+}
+EXPORT_SYMBOL(platform_get_asic);
+
+/*
+ * \brief platform_configure_usb() usb configuration based on platform type.
+ *
+ * \param     int divide_by_3 divide clock setting by 3
+ *
+ * \return    none
+ *
+ */
+static void platform_configure_usb(void)
+{
+	int divide_by_3;
+
+	if (usb_configured)
+		return;
+
+	switch (gAsic) {
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
+		pr_err("Unknown ASIC type: %d\n", gAsic);
+		divide_by_3 = 0;
+		break;
+	}
+
+	/* Set up PLL for USB */
+	fs_update(0x0000, 0x11, 0x02, divide_by_3);
+	/* turn on USB power */
+	asic_write(0, USB2_Strap);
+	/* Enable all OHCI interrupts */
+	asic_write(0x00000803, USB2_Control);
+	/* USB2_STBUS_OBC store32/load32 */
+	asic_write(3, USB2_STBUS_OBC);
+	/* USB2_STBUS_MESS_SIZE 2 packets */
+	asic_write(1, USB2_STBUS_MESS_SIZE);
+	/* USB2_STBUS_CHUNK_SIZE 2 packets */
+	asic_write(1, USB2_STBUS_CHUNK_SIZE);
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
+/*
+ * \brief configure_platform() configuration based on platform type.
+ *
+ * \param     none
+ *
+ * \return    none
+ *
+ */
+void __init configure_platform(void)
+{
+	gPlatformFamily = platform_get_family();
+
+	switch (gPlatformFamily) {
+	case FAMILY_1500:
+	case FAMILY_1500VZE:
+	case FAMILY_1500VZF:
+		gPlatformFeatures = FFS_CAPABLE;
+		gAsic = ASIC_CALLIOPE;
+		gAsicPhyBase = CALLIOPE_IO_BASE;
+		gRegisterMap = &calliope_register_map;
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+
+		if (gPlatformFamily == FAMILY_1500VZE) {
+			gpResources = non_dvr_vze_calliope_resources;
+			pr_info("Platform: 1500/Vz Class E - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else if (gPlatformFamily == FAMILY_1500VZF) {
+			gpResources = non_dvr_vzf_calliope_resources;
+			pr_info("Platform: 1500/Vz Class F - "
+				"CALLIOPE, NON_DVR_CAPABLE\n");
+		} else {
+			gpResources = non_dvr_calliope_resources;
+			pr_info("Platform: 1500/RNG100 - CALLIOPE, "
+				"NON_DVR_CAPABLE\n");
+		}
+		break;
+
+	case FAMILY_4500:
+		gPlatformFeatures = FFS_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		gAsic = ASIC_ZEUS;
+		gAsicPhyBase = ZEUS_IO_BASE;
+		gRegisterMap = &zeus_register_map;
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+		gpResources = non_dvr_zeus_resources;
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
+		gPlatformFeatures = FFS_CAPABLE | DISPLAY_CAPABLE;
+		gAsicPhyBase = CRONUS_IO_BASE;   /* same as Cronus */
+		gRegisterMap = &cronus_register_map;   /* same as Cronus */
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+		gpResources = non_dvr_cronuslite_resources;
+
+		/* ASIC version will determine if this is a real CronusLite or
+		 * Castrati(Cronus) */
+		chipversion  = asic_read(CHIPVER3) << 24;
+		chipversion |= asic_read(CHIPVER2) << 16;
+		chipversion |= asic_read(CHIPVER1) << 8;
+		chipversion |= asic_read(CHIPVER0);
+
+		if ((chipversion == CRONUS_10) || (chipversion == CRONUS_11))
+			gAsic = ASIC_CRONUS;
+		else
+			gAsic = ASIC_CRONUSLITE;
+
+		pr_info("Platform: 4600 - %s, NON_DVR_CAPABLE, "
+			"chipversion=0x%08X\n",
+			(gAsic == ASIC_CRONUS) ? "CRONUS" : "CRONUS LITE",
+			chipversion);
+		break;
+	}
+	case FAMILY_4600VZA:
+		gPlatformFeatures = FFS_CAPABLE | DISPLAY_CAPABLE;
+		gAsic = ASIC_CRONUS;
+		gAsicPhyBase = CRONUS_IO_BASE;
+		gRegisterMap = &cronus_register_map;
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+		gpResources = non_dvr_cronus_resources;
+
+		pr_info("Platform: Vz Class A - CRONUS, NON_DVR_CAPABLE\n");
+		break;
+
+	case FAMILY_8500:
+	case FAMILY_8500RNG:
+		gPlatformFeatures = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		gAsic = ASIC_ZEUS;
+		gAsicPhyBase = ZEUS_IO_BASE;
+		gRegisterMap = &zeus_register_map;
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+		gpResources = dvr_zeus_resources;
+		break;
+
+	case FAMILY_8600:
+	case FAMILY_8600VZB:
+		gPlatformFeatures = DVR_CAPABLE | PCIE_CAPABLE |
+			DISPLAY_CAPABLE;
+		gAsic = ASIC_CRONUS;
+		gAsicPhyBase = CRONUS_IO_BASE;
+		gRegisterMap = &cronus_register_map;
+		pAsicBase = (unsigned long)ioremap_nocache(gAsicPhyBase,
+			ASIC_IO_SIZE);
+		gpResources = dvr_cronus_resources;
+
+		pr_info("Platform: 8600/Vz Class B - CRONUS, "
+			"DVR_CAPABLE\n");
+		break;
+
+	default:
+		gPlatformFeatures = 0;
+		gAsic = ASIC_UNKNOWN;
+		gAsicPhyBase = 0;
+		gRegisterMap = NULL;
+		gpResources = NULL;
+
+		pr_crit("Platform:  UNKNOWN PLATFORM\n");
+		break;
+	}
+
+	platform_configure_usb();
+
+	switch (gAsic) {
+	case ASIC_ZEUS:
+		gPhysToBusOffset = 0x30000000;
+		break;
+	case ASIC_CALLIOPE:
+		gPhysToBusOffset = 0x10000000;
+		break;
+	case ASIC_CRONUSLITE:
+		/* Fall through */
+	case ASIC_CRONUS:
+		/*
+		 * TODO: We suppose 0x10000000 aliases into 0x20000000-
+		 * 0x2XXXXXXX. If 0x10000000 aliases into 0x60000000-
+		 * 0x6XXXXXXX, the offset should be 0x50000000, not 0x10000000.
+		 */
+		gPhysToBusOffset = 0x10000000;
+		break;
+	default:
+		gPhysToBusOffset = 0x00000000;
+		break;
+	}
+}
+
+/*
+ * \brief platform_devices_init() sets up USB device resourse.
+ *
+ * \param     none
+ *
+ * \return    none
+ *
+ */
+static int __init platform_devices_init(void)
+{
+	pr_crit("%s: ----- Initializing USB resources -----\n", __func__);
+
+	asic_resource.start = gAsicPhyBase;
+	asic_resource.end += asic_resource.start;
+
+	ehci_resources[0].start = asic_reg_phys_addr(EHCI_HCAPBASE);
+	ehci_resources[0].end += ehci_resources[0].start;
+
+	ohci_resources[0].start = asic_reg_phys_addr(OHCI_HcRevision);
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
+	for (i = 0; gpResources[i].flags != 0; i++) {
+		int size = gpResources[i].end - gpResources[i].start + 1;
+		if ((gpResources[i].start != 0) &&
+			((gpResources[i].flags & IORESOURCE_MEM) != 0)) {
+			reserve_bootmem(bus_to_phys(gpResources[i].start),
+				size, 0);
+			total += gpResources[i].end - gpResources[i].start + 1;
+			pr_info("reserve resource %s at %08x (%u bytes)\n",
+				gpResources[i].name, gpResources[i].start,
+				gpResources[i].end - gpResources[i].start + 1);
+		}
+	}
+
+	/* Loop through assigning addresses for those that are left */
+	for (i = 0; gpResources[i].flags != 0; i++) {
+		int size = gpResources[i].end - gpResources[i].start + 1;
+		if ((gpResources[i].start == 0) &&
+			((gpResources[i].flags & IORESOURCE_MEM) != 0)) {
+			void *mem = alloc_bootmem_pages(size);
+
+			if (mem == NULL)
+				pr_err("Unable to allocate bootmem pages "
+					"for %s\n", gpResources[i].name);
+
+			else {
+				gpResources[i].start =
+					phys_to_bus(virt_to_phys(mem));
+				gpResources[i].end =
+					gpResources[i].start + size - 1;
+				total += size;
+				pr_info("allocate resource %s at %08x "
+						"(%u bytes)\n",
+					gpResources[i].name,
+					gpResources[i].start, size);
+			}
+		}
+	}
+
+	pr_info("Total Platform driver memory allocation: 0x%08x\n", total);
+
+	/* indicate resources that are platform I/O related */
+	for (i = 0; gpResources[i].flags != 0; i++) {
+		if ((gpResources[i].start != 0) &&
+			((gpResources[i].flags & IORESOURCE_IO) != 0)) {
+			pr_info("reserved platform resource %s at %08x\n",
+				gpResources[i].name, gpResources[i].start);
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
+/*
+ * \brief asic_resource_get() retreives parameters used for allocating
+ * a platform resource.
+ *
+ * \param name - string to match resource
+ *
+ * \return    resource ptr
+ *
+ * CANNOT BE NAMED platform_resource_get is this function name is already
+ * declared
+ */
+struct resource *asic_resource_get(const char *name)
+{
+	int i;
+
+	for (i = 0; gpResources[i].flags != 0; i++) {
+		if (strcmp(gpResources[i].name, name) == 0)
+			return &gpResources[i];
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(asic_resource_get);
+
+/*
+ * \brief platform_release_memory() .
+ *
+ * \param ptr -  pointer to resource
+ * \param size - size of resource
+ *
+ * \return    resource ptr
+ *
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
+	return (gPlatformFeatures & DVR_CAPABLE) != 0;
+}
+
+int platform_supports_ffs(void)
+{
+	return (gPlatformFeatures & FFS_CAPABLE) != 0;
+}
+
+int platform_supports_pcie(void)
+{
+	return (gPlatformFeatures & PCIE_CAPABLE) != 0;
+}
+
+int platform_supports_display(void)
+{
+	return (gPlatformFeatures & DISPLAY_CAPABLE) != 0;
+}
diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
new file mode 100644
index 0000000..94b6ca9
--- /dev/null
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -0,0 +1,146 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2001 Ralf Baechle
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
+ * Routines for generic manipulation of the interrupts found on the MIPS
+ * Malta board.
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
+static DEFINE_SPINLOCK(mips_irq_lock);
+
+static inline int get_int(void)
+{
+	unsigned long flags;
+	int irq;
+
+	spin_lock_irqsave(&mips_irq_lock, flags);
+
+	irq = (asic_read(Int_Int_Scan) >> 4) - 1;
+
+	if (irq == 0 || irq >= NR_IRQS)
+		irq = -1;
+
+	spin_unlock_irqrestore(&mips_irq_lock, flags);
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
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+	return -clz(pending) + 31 - CAUSEB_IP;
+#else
+	unsigned int a0 = 7;
+	unsigned int t0;
+
+	t0 = pending & 0xf000;
+	t0 = t0 < 1;
+	t0 = t0 << 2;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0xc000;
+	t0 = t0 < 1;
+	t0 = t0 << 1;
+	a0 = a0 - t0;
+	pending = pending << t0;
+
+	t0 = pending & 0x8000;
+	t0 = t0 < 1;
+	a0 = a0 - t0;
+
+	return a0;
+#endif
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
index 0000000..693abab
--- /dev/null
+++ b/arch/mips/powertv/asic/irq_asic.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright (C) 2005 Scientific Atlanta
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
+		asic_write(asic_read(Ien_Int_0) | enable_bit, Ien_Int_0);
+		break;
+	case 1:
+		asic_write(asic_read(Ien_Int_1) | enable_bit, Ien_Int_1);
+		break;
+	case 2:
+		asic_write(asic_read(Ien_Int_2) | enable_bit, Ien_Int_2);
+		break;
+	case 3:
+		asic_write(asic_read(Ien_Int_3) | enable_bit, Ien_Int_3);
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
+		asic_write(asic_read(Ien_Int_0) & disable_mask, Ien_Int_0);
+		break;
+	case 1:
+		asic_write(asic_read(Ien_Int_1) & disable_mask, Ien_Int_1);
+		break;
+	case 2:
+		asic_write(asic_read(Ien_Int_2) & disable_mask, Ien_Int_2);
+		break;
+	case 3:
+		asic_write(asic_read(Ien_Int_3) & disable_mask, Ien_Int_3);
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
+	asic_write(0, Ien_Int_0);
+	asic_write(0, Ien_Int_1);
+	asic_write(0, Ien_Int_2);
+	asic_write(0, Ien_Int_3);
+
+	asic_write(0x0fffffff, Int_Level_3_3);
+	asic_write(0xffffffff, Int_Level_3_2);
+	asic_write(0xffffffff, Int_Level_3_1);
+	asic_write(0xffffffff, Int_Level_3_0);
+	asic_write(0xffffffff, Int_Level_2_3);
+	asic_write(0xffffffff, Int_Level_2_2);
+	asic_write(0xffffffff, Int_Level_2_1);
+	asic_write(0xffffffff, Int_Level_2_0);
+	asic_write(0xffffffff, Int_Level_1_3);
+	asic_write(0xffffffff, Int_Level_1_2);
+	asic_write(0xffffffff, Int_Level_1_1);
+	asic_write(0xffffffff, Int_Level_1_0);
+	asic_write(0xffffffff, Int_Level_0_3);
+	asic_write(0xffffffff, Int_Level_0_2);
+	asic_write(0xffffffff, Int_Level_0_1);
+	asic_write(0xffffffff, Int_Level_0_0);
+
+	asic_write(0xf, Int_Int_Scan);
+
+	/*
+	 * Initialize interrupt handlers.
+	 */
+	for (i = 0; i < NR_IRQS; i++)
+		set_irq_chip_and_handler(i, &asic_irq_chip, handle_level_irq);
+}
diff --git a/arch/mips/powertv/cevt-powertv.c b/arch/mips/powertv/cevt-powertv.c
new file mode 100644
index 0000000..cecbf40
--- /dev/null
+++ b/arch/mips/powertv/cevt-powertv.c
@@ -0,0 +1,247 @@
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
+#ifdef CONFIG_MIPS_MT_SMTC
+	{
+	unsigned long flags, vpflags;
+	local_irq_save(flags);
+	vpflags = dvpe();
+#endif
+	cnt = read_c0_count();
+	cnt += delta;
+	write_c0_compare(cnt);
+	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
+#ifdef CONFIG_MIPS_MT_SMTC
+	evpe(vpflags);
+	local_irq_restore(flags);
+	}
+#endif
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
+#ifdef CONFIG_MIPS_MT_SMTC
+		if (cpu_data[cpu].vpe_id)
+			return IRQ_HANDLED;
+		cpu = 0;
+#endif
+		cd = &per_cpu(mips_clockevent_device, cpu);
+		cd->event_handler(cd);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction c0_compare_irqaction = {
+	.handler = c0_compare_interrupt,
+#ifdef CONFIG_MIPS_MT_SMTC
+	.flags = IRQF_DISABLED,
+#else
+	.flags = IRQF_DISABLED | IRQF_PERCPU,
+#endif
+	.name = "timer",
+};
+
+#ifdef CONFIG_MIPS_MT_SMTC
+DEFINE_PER_CPU(struct clock_event_device, smtc_dummy_clockevent_device);
+
+static void smtc_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+}
+
+static void mips_broadcast(cpumask_t mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu_mask(cpu, mask)
+		smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
+}
+
+static void setup_smtc_dummy_clockevent_device(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+
+	cd = &per_cpu(smtc_dummy_clockevent_device, cpu);
+
+	cd->name		= "SMTC";
+	cd->features		= CLOCK_EVT_FEAT_DUMMY;
+
+	/* Calculate the min / max delta */
+	cd->mult		= 0;
+	cd->shift		= 0;
+	cd->max_delta_ns	= 0;
+	cd->min_delta_ns	= 0;
+
+	cd->rating		= 200;
+	cd->irq			= 17;
+	cd->cpumask		= cpumask_of_cpu(cpu);
+
+	cd->set_mode		= smtc_set_mode;
+
+	cd->broadcast		= mips_broadcast;
+
+	clockevents_register_device(cd);
+}
+#endif
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
+#ifdef CONFIG_MIPS_MT_SMTC
+	setup_smtc_dummy_clockevent_device();
+
+	/*
+	 * On SMTC we only register VPE0's compare interrupt as clockevent
+	 * device.
+	 */
+	if (cpu)
+		return 0;
+#endif
+
+	irq = kIrq_MipsTimer;
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
+#ifdef CONFIG_MIPS_MT_SMTC
+	cd->cpumask		= CPU_MASK_ALL;
+#else
+	cd->cpumask		= get_cpu_mask(cpu);
+#endif
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
+#ifdef CONFIG_MIPS_MT_SMTC
+#define CPUCTR_IMASKBIT (0x100 << cp0_compare_irq)
+	setup_irq_smtc(irq, &c0_compare_irqaction, CPUCTR_IMASKBIT);
+#else
+	setup_irq(irq, &c0_compare_irqaction);
+#endif
+
+	return 0;
+}
diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
new file mode 100644
index 0000000..ee570a1
--- /dev/null
+++ b/arch/mips/powertv/cmdline.c
@@ -0,0 +1,51 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
index 0000000..c032660
--- /dev/null
+++ b/arch/mips/powertv/csrc-powertv.c
@@ -0,0 +1,84 @@
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
+	pll_reg = asic_read(MIPS_PLL_SETUP);
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
+void __init powertv_clocksource_init(void)
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
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
new file mode 100644
index 0000000..6d7b229
--- /dev/null
+++ b/arch/mips/powertv/init.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
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
index 0000000..763472e
--- /dev/null
+++ b/arch/mips/powertv/init.h
@@ -0,0 +1,10 @@
+/*
+ * Definitions from powertv init.c file
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
index 0000000..a57972f
--- /dev/null
+++ b/arch/mips/powertv/memory.c
@@ -0,0 +1,183 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
+ * PROM library functions for acquiring/using memory descriptors given to
+ * us from the YAMON.
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
+#define	KIBIBYTE(n)		((n) * 1024)	/* Number of kibibytes */
+#define	MEBIBYTE(n)		((n) * KIBIBYTE(1024)) /* Number of mebibytes */
+#define	DEFAULT_MEMSIZE		MEBIBYTE(256)	/* If no memsize provided */
+#define	LOW_MEM_MAX		MEBIBYTE(252)	/* Max usable low mem */
+#define	RES_BOOTLDR_MEMSIZE	MEBIBYTE(1)	/* Memory reserved for bldr */
+#define	BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
+#define	PHYS_MEM_START		0x10000000	/* Start of physical memory */
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
index 0000000..7bf9f8c
--- /dev/null
+++ b/arch/mips/powertv/pci/Makefile
@@ -0,0 +1,26 @@
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
+obj-y	:=
+
+obj-$(CONFIG_PCI)	+= pci.o fixup-powertv.o pciemod.o
+
+
diff --git a/arch/mips/powertv/pci/fixup-powertv.c b/arch/mips/powertv/pci/fixup-powertv.c
new file mode 100644
index 0000000..a75a9ab
--- /dev/null
+++ b/arch/mips/powertv/pci/fixup-powertv.c
@@ -0,0 +1,14 @@
+#include <linux/init.h>
+#include <linux/pci.h>
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
diff --git a/arch/mips/powertv/pci/pci.c b/arch/mips/powertv/pci/pci.c
new file mode 100644
index 0000000..3358b5f
--- /dev/null
+++ b/arch/mips/powertv/pci/pci.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
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
+ * MIPS boards specific PCI support.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <asm/mips-boards/generic.h>
+#include "powertv-pci.h"
+
+void __init mips_pcibios_init(void)
+{
+	asic_pcie_init();
+}
diff --git a/arch/mips/powertv/pci/pciemod.c b/arch/mips/powertv/pci/pciemod.c
new file mode 100644
index 0000000..f152fc5
--- /dev/null
+++ b/arch/mips/powertv/pci/pciemod.c
@@ -0,0 +1,2921 @@
+/* -----------------------------------------------------------------------------
+ *                            PCIE Module
+ *
+ * Copyright (C) 2000-2009 Scientific-Atlanta, Inc.
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
+ * -----------------------------------------------------------------------------
+ *
+ * File Name:    pciemod.c
+ *
+ * Project:      NGP
+ *
+ * Compiler:     gnu C (gcc)
+ *
+ * Author(s):    Tom Haman
+ *
+ * Description:  Routines implementing kernel PCIE Module.
+ *
+ * Documents:    PCIE Software Design Document
+ *
+ * NOTES:
+ *
+ * -----------------------------------------------------------------------------
+ * History:
+ * Rev Level    Date    Name         ECN#    Description
+ * -----------------------------------------------------------------------------
+ * 1.00       03/27/06  Tom Haman    ---    Initial version for NGP (Zeus)
+ * -----------------------------------------------------------------------------
+ */
+
+
+/*platform and compile/usage definitions */
+#define DEBUG         1
+#define LOADABLE      0
+
+#ifndef SA8KG5
+#define SA8KG5        1
+#endif
+
+#ifndef qDebug
+#define qDebug        DEBUG
+#endif
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/proc_fs.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+
+/* SA includes */
+#include <asm/mach-powertv/asic.h>
+#include <asm/mach-powertv/asic_regs.h>
+#include <asm/mach-powertv/interrupts.h>
+
+#include "pcieregs.h"
+
+
+
+/******************************************************************************
+ ******************************************************************************
+ * these items would normally be in SA driver include files but since we are
+ * in the low level Kernel, they are defined here
+ ******************************************************************************
+ ******************************************************************************
+ * FROM "SAKernel.h"
+ */
+enum {
+	SA_OFF,
+	SA_FATAL,
+	SA_SEVERE,
+	SA_INFO,
+	SA_NOISE
+} eSa_LogLevels;
+
+#define SA_LOG_TO_PRINT  1
+
+#if ((defined(DEBUG) && DEBUG) || (defined(qDebug) && qDebug))
+#define SAPRINT(level, destflags, fmt...) do {	\
+		if ((level <= LogLevel) && ((destflags) & SA_LOG_TO_PRINT)) \
+			printk(fmt); \
+	} while (0)
+#else
+#define SAPRINT(level, destflags, fmt...) do {} while (0)
+#endif
+
+MODULE_AUTHOR("Tom Haman");
+MODULE_DESCRIPTION("PCIE Module");
+MODULE_LICENSE("GPL");
+
+/* File ID info  (DO NOT EDIT) */
+const char PCIE_ident[] = "SA-Drv-Ident %name: %, %version: %, "
+	"%instance: %, %date_created: %, %created_by: %";
+
+/*******************************************************************************
+ *******************************************************************************
+ *   LOADABLE Elements
+ *******************************************************************************
+ ******************************************************************************/
+#if LOADABLE
+/*Module Parameters */
+module_param(LogLevel, int, S_IRUGO);
+MODULE_PARM_DESC(LogLevel, "Module debug log level");
+#endif /*LOADABLE */
+
+/*******************************************************************************
+ *******************************************************************************
+ *   KERNEL Elements
+ *******************************************************************************
+ ******************************************************************************/
+/*---------- Defines ------------ */
+#define pcieModule_Name         "pcie"
+
+/*---------- Variables ------------ */
+static struct proc_dir_entry *PCIE_pProc;	/* proc directory entry */
+static        int             LogLevel            = SA_INFO;
+static        struct tPCIERegs      *PCIE_RegsPtr;
+static        int             PCIE_irqrequest_pcie;
+static        u32             PCIE_initialized;
+static        u32            *timerptr;
+static        spinlock_t      PCIE_lock;
+
+/*---------- Non Private Module Prototypes ------------ */
+static int  __init pcie_Init(void);
+static void __exit pcie_Finalize(void);
+static int asic_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
+	int where, int size, u32 *val);
+static int asic_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
+	int where, int size, u32 val);
+
+/*---------- Private Module Prototypes ------------ */
+static irqreturn_t asic_pcie_process_interrupt(int irq, void *dev_id);
+static u32 pcie_rc_cfg_read32(u32 type, u32 busnum, u32 devnum, u32 func_num,
+	u32 reg_num, u32 *dataptr);
+static u32 pcie_rc_cfg_write32(u32 type, u32 busnum, u32 devnum, u32 func_num,
+	u32 reg_num, u32 *dataptr);
+static void pcie_DumpRegs(void);
+static int pcie_dumpcapability(int busnumber, int dev, int fn, int ptr);
+static int pcie_dumpextendedcapability(int busnumber, int dev, int fn, int ptr);
+static void pcie_delay(u32 ms);
+static int pcie_reset_ethernet(void) ;
+static void pcie_uSecDelay(u32 us);
+
+/*proc */
+static int pcie_WriteProc(struct file *pfile, const char __user *pbuff,
+	unsigned long bytecnt, void *data);
+static int pcie_ReadProc(char *page, char **start, off_t off, int pageSize,
+	int *eof, void *data);
+
+/*interrupt */
+static u32 intdata[4];
+static int intcountslow[32], intcountshigh[32];
+
+/*---------- Structures ----------- */
+static struct pci_ops asic_pci_ops = {
+	.read  = asic_pcie_read_config,
+	.write = asic_pcie_write_config
+};
+
+static struct resource asic_mem_resource = {
+	.name	      = "ZEUS PCI MEM",
+	.flags	    = IORESOURCE_MEM,
+	.start      = 0x08000000UL,
+	.end        = 0x083FFFFFUL,
+
+};
+
+static struct resource asic_io_resource = {
+	.name	  = "ASIC PCI I/O",
+	.start  = 0x08400000UL,
+	.end    = 0x087FFFFFUL,
+	.flags	= IORESOURCE_IO,
+};
+
+struct pci_controller asic_controller = {
+	.pci_ops	    = &asic_pci_ops,
+	.io_resource	= &asic_io_resource,
+	.mem_resource	= &asic_mem_resource,
+	.io_offset	  = 0x00000000UL,
+	.mem_offset   = 0x00000000UL
+};
+
+
+/* VFD-SPI registers */
+struct tFPanel_regs {
+	u32   rSVFDControl;        /* control register */
+	u32   rSVFDStart;          /* start register */
+	u32   rSVFDFifo;           /* Fifo register */
+	u32   rSVFDKeyData;        /* key data register */
+	u32   rSVFDManReadData;    /* manual read data register */
+	u32   rSVFDReadCmd;        /* read command register */
+	u32   rSVFDStatus;         /* status register */
+	u32   rSVFDIntStat;        /* interrupt status register */
+	u32   rSVFDIntEnable;      /* interrupt enable register */
+};
+
+/*---------- Constants ------------ */
+
+/*---------- Externals ------------ */
+
+/*---------- Temporary Fixes ------------ */
+static inline u8 fix_readb(u8 *addr)
+{
+	u32 temp = (u32)addr ^ 3;
+	u8 *ptr;
+	ptr = (u8 *)temp;
+	return readb(ptr);
+}
+static inline u16 fix_readw(u16 *addr)
+{
+	u32 temp = (u32)addr ^ 2;
+	u16 *ptr;
+	ptr = (u16 *)temp;
+	return readw(ptr);
+}
+static inline u32 fix_readl(u32 *addr)
+{
+	return readl(addr);
+}
+
+static inline void fix_writeb(u8 val, u8 *addr)
+{
+	u32 temp = (u32)addr ^ 3;
+	u8 *ptr;
+	ptr = (u8 *)temp;
+	writeb(val, ptr);
+}
+static inline void fix_writew(u16 val, u16 *addr)
+{
+	u32 temp = (u32)addr ^ 2;
+	u16 *ptr;
+	ptr = (u16 *)temp;
+	writew(val, ptr);
+}
+static inline void fix_writel(u32 val, u32 *addr)
+{
+	writel(val, addr);
+}
+
+/* Convenience functions for performing logical operations on device
+ * registers */
+static void writel_or(u32 v, u32 *addr)
+{
+	writel(readl(addr) | v, addr);
+}
+
+static void writel_and(u32 v, u32 *addr)
+{
+	writel(readl(addr) & v, addr);
+}
+
+
+#ifdef PCIE_PLL_FIX
+
+	static struct tTBRegs  *TB_RegsPtr;
+	static unsigned int scr_data_in[kSCR_DEPTH];
+
+
+/*******************************************************************************
+ * asic_pcie_reset
+ *
+ * If the box is a Zeus 1.0 box and the PHY layer's PLL has not acheived lock,
+ * then load the PLL with the correct value and then reset it. There is no way
+ * to reset the PHY layer by a conventional register command. Therefore, this
+ * backdoor method using the testbus to control the jtag port has been used.
+ * PCIe PHY layer to be reset after new PLL value has been loaded.
+ *
+ *
+ ******************************************************************************/
+void asic_shift_clk(void)
+{
+	/* clock low */
+	writel_and(0xFFFFFFFD, &TB_RegsPtr->TEST_BUS_GPIO);
+	pcie_uSecDelay(20);
+	/* clock high */
+	writel_or(0x2, &TB_RegsPtr->TEST_BUS_GPIO);
+	pcie_uSecDelay(20);
+}
+
+
+void asic_shift_in(void)
+{
+	int i;
+
+	writel_or(0x30, &TB_RegsPtr->TEST_BUS_GPIO); /* Set SCR_OPCODE to a 3 */
+	for (i = kSCR_DEPTH-1; i >= 0; i--) {
+		if (scr_data_in[i])
+				/* Set SCR_IN high */
+			writel_or(0x4, &TB_RegsPtr->TEST_BUS_GPIO);
+		else
+			/* Set SCR_IN lo */
+			writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);
+		asic_shift_clk();
+	}
+	/* Set SCR_OPCODE to 2'b10 */
+	writel_and(0xFFFFFFEF, &TB_RegsPtr->TEST_BUS_GPIO);
+	asic_shift_clk();
+	/* Set SCR_OPCODE to zero */
+	writel_and(0xFFFFFFCF, &TB_RegsPtr->TEST_BUS_GPIO);
+}
+
+void asic_phy_reset(void)
+{
+	int i;
+
+	/* Enable OEs  */
+	writel_or(0x17 | 0x107F00, &TB_RegsPtr->TEST_BUS_GPIO_CTL);
+	/* Set lower bits to zero */
+	writel_and(0xFFFFF80, &TB_RegsPtr->TEST_BUS_GPIO);
+	/* Set mode bit */
+	writel_or(0x8, &TB_RegsPtr->TEST_BUS_GPIO);
+
+	for (i = kSCR_DEPTH-1; i >= 0; i--)
+		scr_data_in[i] = 0;
+
+	scr_data_in[kSCR_DEPTH-93] = 1;
+	scr_data_in[kSCR_DEPTH-94] = 1;
+
+	asic_shift_in();
+
+	/* Clear mode bit */
+	writel_and(0xFFFFFFF7, &TB_RegsPtr->TEST_BUS_GPIO);
+
+}
+
+void asic_write_jtag(unsigned int tms, unsigned int tdi)
+{
+	/* drive bit 13 low (clk) */
+	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);
+
+	if (tms)            /* set tms */
+		writel_or(0x2, &TB_RegsPtr->TEST_BUS_GPIO);
+	else     /* clear tms */
+		writel_and(0xFFFFFFFD, &TB_RegsPtr->TEST_BUS_GPIO);
+
+	if (tdi)            /* set tdi */
+		writel_or(0x4, &TB_RegsPtr->TEST_BUS_GPIO);
+	else     /* clear tdi */
+		writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);
+
+	pcie_uSecDelay(20);
+	/* drive bit 13 high (clk) */
+	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);
+	pcie_uSecDelay(20);
+}
+
+
+void asic_setup_jtag(unsigned int value)
+
+{
+	int i;
+
+	writel(0x17 | 0x300600, &TB_RegsPtr->TEST_BUS_GPIO_CTL);
+
+	/*Select Controller 0 */
+	/* drive bit 12, 13, 1, 2 low */
+	writel_and(0xFFFFCFF9, &TB_RegsPtr->TEST_BUS_GPIO);
+	pcie_uSecDelay(20);
+	writel_or(0x00000004, &TB_RegsPtr->TEST_BUS_GPIO);       /* tdI = 1 */
+	pcie_uSecDelay(20);
+	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);       /* CLK = 1 */
+	pcie_uSecDelay(20);
+	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);      /* CLK = 0  */
+	pcie_uSecDelay(20);
+	writel_or(0x00001000, &TB_RegsPtr->TEST_BUS_GPIO);       /* trstn = 1 */
+	writel_and(0xFFFFFFFB, &TB_RegsPtr->TEST_BUS_GPIO);      /* tdi = 0  */
+	pcie_uSecDelay(20);
+	writel_or(0x00002000, &TB_RegsPtr->TEST_BUS_GPIO);       /* CLK = 1 */
+	pcie_uSecDelay(20);
+	writel_and(0xFFFFDFFF, &TB_RegsPtr->TEST_BUS_GPIO);      /* CLK = 0  */
+
+	asic_write_jtag(1, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 1);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(0, 0);
+	asic_write_jtag(0, 0);
+
+	for (i = 0; i < 28 ; i++)
+		asic_write_jtag(0, 0);
+
+	asic_write_jtag(0, value);
+	for (i = 0; i < 75 ; i++)
+		asic_write_jtag(0, 0);
+
+	asic_write_jtag(1, 0);
+	asic_write_jtag(1, 0);
+	asic_write_jtag(0, 0);
+}
+
+void asic_pcie_reset(void)
+{
+	asic_setup_jtag(1);
+	asic_phy_reset();
+	asic_setup_jtag(0);
+}
+
+#endif
+
+
+/*******************************************************************************
+ *******************************************************************************
+ *   PCIE General Interface
+ *******************************************************************************
+ *******************************************************************************
+ *******************************************************************************
+ * asic_pcie_init
+ *
+ * This API is called at power up and therefore must be exposed to other
+ * modules.
+ *
+ * Parameters - None
+ *
+ * Return Value - 0 or error
+ *
+ * Description:
+ * asic_pcie_init initializes the ASIC' PCI Express registers, obtains an IRQ
+ * from the Linux Kernel and registers the controller with the PCI System
+ * Software.
+ ******************************************************************************/
+int asic_pcie_init(void)
+{
+	unsigned int timeout_count;
+	int i;
+
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT,
+		"%s:%s:asic_pcie_init called.\n", pcieModule_Name,
+		__func__);
+
+	if (!platform_supports_pcie())
+		return -1;
+
+	/*init spinlock */
+	spin_lock_init(&PCIE_lock);
+
+	/*map ASIC LS timer register */
+	timerptr = (u32 *) (asic_reg_addr(Free_Running_Ctr_Lo));
+	if (timerptr == 0) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to get timer register mapping\n",
+			pcieModule_Name, __func__);
+		return -1;
+	}
+
+	/*map the registers */
+	PCIE_RegsPtr = (struct tPCIERegs *)(asic_reg_addr(PCIe_Regs));
+
+	if (PCIE_RegsPtr == 0) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to get register mapping\n",
+			pcieModule_Name, __func__);
+		return -1;
+	}
+
+	/*--------------- Hw initialization begins here ------------------- */
+	/*reset ethernet chip */
+	if (pcie_reset_ethernet() == -1) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to reset ethernet chip\n",
+			pcieModule_Name, __func__);
+		return -1;
+	}
+
+#ifdef PCIE_PLL_FIX
+	/* if PCIE_PLL_FIX is defined, then apply workaround to allow
+	 * PCIe PHY layer to be reset after new PLL value has been loaded.
+	 * subsequent versions of Zeus will have proper PLL default value
+	 * set so that this will not be necessary. */
+
+	TB_RegsPtr = (struct tTBRegs *)(asic_reg_addr(Test_Bus));
+
+	if (TB_RegsPtr == 0) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to get TESTBUS register mapping\n",
+			pcieModule_Name, __func__);
+		return -1;
+	}
+
+	{
+		int asicVersion;
+
+		/* read CHIPVER0 Zeus register */
+		asicVersion = (int)asic_read(CHIPVER0);
+
+		/* if Zeus 1.0 */
+		if (asicVersion == 0x11) {
+			/* if PLL is not locked, then apply workaround */
+			if  ((readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK) &
+				kPCIX_PHY_READ_BACK_Ready) == 0) {
+				SAPRINT(SA_INFO, SA_LOG_TO_PRINT,
+					"%s:%s:Applying PCIe PHY PLL "
+					"workaround\n", pcieModule_Name,
+					__func__);
+
+				/* load correct PHY PLL value */
+				writel(0x19232300,
+					&PCIE_RegsPtr->PCIX_PHY_CONT_DATA1);
+
+				/* reset PHY layer */
+				pcie_delay(10);
+				asic_pcie_reset();
+			}
+		}
+	}
+#endif
+
+
+	/* Check PLL Lock  */
+	timeout_count = 0;
+	while  ((readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK) &
+		kPCIX_PHY_READ_BACK_PllLock) == 0) {
+		timeout_count += 1;
+		if (timeout_count == 1000)
+			break;
+		pcie_delay(1);
+	}
+
+	if (readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK) &
+		kPCIX_PHY_READ_BACK_PllLock)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s:%s: PLL lock.\n",
+			pcieModule_Name, __func__);
+	else {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: PLL NOT LOCKED.\n", pcieModule_Name,
+			__func__);
+		PCIE_RegsPtr = 0;
+		return -1;
+	}
+
+	/* Check PHY Ready */
+	timeout_count = 0;
+	while  ((readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK)
+		& kPCIX_PHY_READ_BACK_Ready)
+		== 0) {
+		timeout_count += 1;
+		if (timeout_count == 1000)
+			break;
+		pcie_delay(1);
+	}
+
+
+	if (readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK) &
+		kPCIX_PHY_READ_BACK_Ready)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT,
+			"%s:%s: PHY ready.\n", pcieModule_Name, __func__);
+	else {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT, "%s:%s: PHY not ready.\n",
+			pcieModule_Name, __func__);
+		PCIE_RegsPtr = 0;
+		return -1;
+	}
+
+	/* set port link control. Set link to be x1. (Zeus undocumented
+	 * register) */
+	writel_and(0x0000FFFF, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[452]);
+	writel_or(0x00010000, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[452]);
+
+	/*All is well with the PHY, Set the control register */
+	writel(kPCIX_CTL1_PCIE_FUNC0 | kPCIX_CTL1_PCIE_ROOT_COMPLEX |
+		kPCIX_CTL1_PCIE_SEL_CLOCK, &PCIE_RegsPtr->PCIX_CTL1);
+
+	writel_or(kPCIX_CTL1_PCIE_LTSSM, &PCIE_RegsPtr->PCIX_CTL1);
+	pcie_delay(100);
+
+	/* verify data link layer up */
+	timeout_count = 0;
+	while ((readl(&PCIE_RegsPtr->PCIX_RDLH_LINK) &
+		kPCIX_RDLH_LINK_RdlhUp) == 0) {
+		timeout_count += 1;
+		if (timeout_count == 1000)
+			break;
+		pcie_delay(1);
+	}
+
+
+	if (readl(&PCIE_RegsPtr->PCIX_RDLH_LINK) & kPCIX_RDLH_LINK_RdlhUp)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT,
+			"%s:%s: Data Link Layer up.\n", pcieModule_Name,
+			__func__);
+	else {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: Data Link Layer not available.\n",
+			pcieModule_Name, __func__);
+		PCIE_RegsPtr = 0;
+		return -1;
+	}
+
+	/* Going to map target space, map 8M, Zeus spec says we have 16 meg but
+	 * can only get to 8M because of register limitations
+	 * (limit to 8MB because HW only carries 23 bits)
+	 * Memory Space from 0x08000000 - 0x083FFFFF */
+	writel(0x00000000, &PCIE_RegsPtr->PCIX_T3TARG_BASE0);
+	/* 4 MB at PCIe add 0x08000000, Zeus add = 0x08000000  */
+	writel(0x08000000 | 0x16, &PCIE_RegsPtr->PCIX_T3TARG_WIN0);
+
+	/* I/O Space from 0x08400000 - 0x087FFFFF  (ORed bit 23 is I/O enable */
+	writel(0x00400000 | 0x00800000, &PCIE_RegsPtr->PCIX_T3TARG_BASE1);
+	/* 4 MB at PCIe add 0x08400000, Zeus add = 0x08400000  */
+	writel(0x08400000 | 0x16, &PCIE_RegsPtr->PCIX_T3TARG_WIN1);
+
+	/* T3 init config */
+	writel(0x00000000, &PCIE_RegsPtr->PCIX_ACC_BAR0[4]);   /* Reset BAR 0 */
+	writel(0x00000000, &PCIE_RegsPtr->PCIX_ACC_BAR0[5]);   /* Reset BAR 1 */
+
+	/* BAR0 - Zeus space at 0x00000000 in PCIe space */
+	writel(0x40000000, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[4]);
+	/* BAR1 - Unused */
+	writel(0x0, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[5]);
+	/* Mem Limit/Mem Base (0x00000000 - 0x00000000) */
+	writel(0x00000000, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[8]);
+	/* Bus Master/Memory Enable */
+	writel_or(0x6, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[1]);
+
+	/* map all of memory for PCIE */
+	/*0x00000000 - 0x7FFFFFFFF)  */
+	writel(0x00000000 | 31, &PCIE_RegsPtr->PCIX_FUNC0_USERBAR0);
+
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s: PCIE Bus num %d, device num = %d\n.\n",
+		pcieModule_Name, __func__, PCIE_RegsPtr->PCIX_CFG_PBUS_NUM,
+		PCIE_RegsPtr->PCIX_CFG_PBUS_DEVNUM);
+
+
+	writel(0, &PCIE_RegsPtr->PCIX_CLIENT0_TLPTC);
+	writel(1, &PCIE_RegsPtr->PCIX_CLIENT0_TLPATTR);
+	writel(0, &PCIE_RegsPtr->PCIX_CLIENT0_TLPFUN);
+
+	/*clear the interrupt counters */
+	for (i = 0; i < 32; i++) {
+		intcountslow[i] = 0;
+		intcountshigh[i] = 0;
+	}
+
+	/*unmask the interrupts that we care about (overall interrupt enable
+	 * will be set when IRQ requested) */
+	writel(~(kPCIX_IntLow_cfg_sys_err_rc0 |
+		kPCIX_IntLow_radm_cpl_timeout       |
+		kPCIX_IntLow_cfg_aer_rc_err_int0    |
+		kPCIX_IntLow_radm_inta_asserted     |
+		kPCIX_IntLow_radm_intb_asserted     |
+		kPCIX_IntLow_radm_intc_asserted     |
+		kPCIX_IntLow_radm_intd_asserted     |
+		kPCIX_IntLow_radm_correctable_err   |
+		kPCIX_IntLow_radm_nonfatal_err      |
+		kPCIX_IntLow_radm_pm_pme            |
+		kPCIX_IntLow_radm_cpl_dllp_abort    |
+		kPCIX_IntLow_radm_cpl_tlp_abort     |
+		kPCIX_IntLow_radm_cpl_ecrc_err      |
+		kPCIX_IntLow_radm_fatal_err),
+		&PCIE_RegsPtr->PCIX_MASKRISE_LOW);
+
+	writel(~(kPCIX_IntHigh_radm_inta_deasserted  |
+		kPCIX_IntHigh_radm_intb_deasserted  |
+		kPCIX_IntHigh_radm_intc_deasserted  |
+		kPCIX_IntHigh_radm_pm_to_ack        |
+		kPCIX_IntHigh_radm_cpl_error_int    |
+		kPCIX_IntHigh_radm_intd_deasserted),
+		&PCIE_RegsPtr->PCIX_MASKRISE_HIGH);
+
+	/*register controller */
+#if !LOADABLE
+	register_pci_controller(&asic_controller);
+#endif   /*!LOADABLE */
+
+	PCIE_initialized = 1;
+	return 0;
+}
+EXPORT_SYMBOL(asic_pcie_init);
+
+
+
+
+/*******************************************************************************
+ * asic_pcie_read_config
+ *
+ * This API is called to read PCI Express Configuration Space registers. It is
+ * exposed to the PCI System Software.
+ *
+ * Parameters:
+ * 	*bus - pointer to pci_bus structure
+ * 	devfn - device function number
+ * 	where - configuration space register number
+ * 	size - byte, word, or doubleword
+ * 	*val - pointer to memory where read data is to be stored
+ *
+ * Return Value:
+ * returns: PCIBIOS_SUCCESSFUL if successful otherwise
+ * PCIBIOS_BAD_REGISTER_NUMBER or -1
+ *
+ * Description:
+ * asic_pcie_read_config is called to read PCI Express Space Configuration
+ * registers. Configuration reads may be for byte, word or double word accesses.
+ *
+ *
+ ******************************************************************************/
+int asic_pcie_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+	int size, u32 *val)
+{
+	u32 data           = 0;
+	u32 rtn            = 0;
+	unsigned long flags = 0;
+	int offset         = where & 3;
+	u32 type;
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:asic_pcie_read_config called (%x, %x, %x, %x).\n",
+		pcieModule_Name, __func__, bus->number, devfn, where, size);
+
+	if (PCIE_initialized == 0)
+		return -1;
+
+	/*error checks */
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	spin_lock_irqsave(&PCIE_lock, flags);
+
+	if (bus->number == 255) {
+		/*root complex, only one device and function in root complex */
+		if (devfn == 0)
+			/*read the 32 bits directly */
+			data = readl(&PCIE_RegsPtr->
+				PCIX_CFG_SPACE_FUNC0[where >> 2]);
+		else
+			data = 0xFFFFFFFF;
+	} else {
+		/* For now only one bus, and one device on that bus and one
+		 * function on that device (0, 0, 0).  If we can ever get the
+		 * ethernet chip to not respond to everything we can lose this
+		 * check */
+		if ((bus->number == 0) && (devfn == 0)) {
+			/*not root complex, type 0 or 1 msg */
+			if (bus->number == 0)
+				type = kPCIE_RC_CFG_SETUP1_TYPE0;
+			else
+				type = kPCIE_RC_CFG_SETUP1_TYPE1;
+
+			/*read 32 bits of data      */
+			rtn = pcie_rc_cfg_read32(type, bus->number,
+				PCI_SLOT(devfn), PCI_FUNC(devfn), where & ~0x3,
+				&data);
+		} else
+			data = 0xFFFFFFFF;
+	}
+
+	/*check for error */
+	if (rtn == -1) {
+		spin_unlock_irqrestore(&PCIE_lock, flags);
+		return PCIBIOS_SET_FAILED;
+	}
+
+	/*right justify the data */
+	switch (size) {
+	case 1:
+		if (offset == 3)
+			*val = (data >> 24) & 0xFF;
+		if (offset == 2)
+			*val = (data >> 16) & 0xFF;
+		if (offset == 1)
+			*val = (data >>  8) & 0xFF;
+		if (offset == 0)
+			*val =  data        & 0xFF;
+		break;
+
+	case 2:
+		if (offset == 2)
+			*val = (data >> 16) & 0xFFFF;
+		if (offset == 0)
+			*val =  data        & 0xFFFF;
+		break;
+
+	case 4:
+		*val = data;
+		break;
+	}
+
+
+	spin_unlock_irqrestore(&PCIE_lock, flags);
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:  READ  PCI data %8x from bus %8x device %8x function "
+		"%8x register %8x size %d\n", pcieModule_Name, __func__,
+		*val, bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), where,
+		size);
+
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+
+
+/*******************************************************************************
+ * asic_pcie_write_config
+ *
+ * Parameters:
+ * 	*bus - pointer to pci_bus structure
+ * 	devfn - device function number
+ * 	where - configuration space register number
+ * 	size - byte, word, or doubleword
+ * 	val - data to be written
+ *
+ * Return Value:
+ * returns: PCIBIOS_SUCCESSFUL if successful otherwise
+ * PCIBIOS_BAD_REGISTER_NUMBER or -1
+ *
+ * Description:
+ * asic_pcie_write_config is called to write PCI Express Configuration Space
+ * registers. Configuration writes may be for byte, word or double word
+ * accesses.
+ ******************************************************************************/
+int asic_pcie_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+	int size, u32 val)
+{
+	u32 data           = 0;
+	u32 rtn            = 0;
+	unsigned long flags = 0;
+	int offset         = where & 3;
+	u32 type;
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:asic_pcie_write_config called (%x, %x, %x, %x, %x).\n",
+		pcieModule_Name, __func__, bus->number, devfn, where, size,
+		val);
+
+	if (PCIE_initialized == 0)
+		return -1;
+
+	/*error checks */
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	spin_lock_irqsave(&PCIE_lock, flags);
+
+	if (bus->number == 255) {
+		/* root complex, only one device and function in root complex */
+		if (devfn != 0) {
+			spin_unlock_irqrestore(&PCIE_lock, flags);
+			return PCIBIOS_SET_FAILED;
+		}
+
+		/*read the register first */
+		data = readl(&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[where >> 2]);
+
+		/*clear old value or in the new one */
+		switch (size) {
+		case 1:
+			val = val & 0xFF;
+			if (offset == 3)
+				data = (data & 0x00FFFFFF) | (val << 24);
+			if (offset == 2)
+				data = (data & 0xFF00FFFF) | (val << 16);
+			if (offset == 1)
+				data = (data & 0xFFFF00FF) | (val <<  8);
+			if (offset == 0)
+				data = (data & 0xFFFFFF00) |  val       ;
+			break;
+
+		case 2:
+			val = val & 0xFFFF;
+			if (offset == 2)
+				data = (data & 0x0000FFFF) | (val << 16);
+			if (offset == 0)
+				data = (data & 0xFFFF0000) |  val       ;
+			break;
+
+		case 4:
+			data = val;
+			break;
+		}
+
+		/*write the new 32 bits */
+		writel(data, &PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[where >> 2]);
+	} else {
+		/*not root complex, type 0 or 1 msg */
+		if (bus->number == 0)
+			type = kPCIE_RC_CFG_SETUP1_TYPE0;
+		else
+			type = kPCIE_RC_CFG_SETUP1_TYPE1;
+
+
+		/*read the register first */
+		rtn = pcie_rc_cfg_read32(type, bus->number, PCI_SLOT(devfn),
+			PCI_FUNC(devfn), where & ~0x3, &data);
+
+		/*check for error */
+		if (rtn == -1) {
+			spin_unlock_irqrestore(&PCIE_lock, flags);
+			return PCIBIOS_SET_FAILED;
+		}
+
+		/*clear old value or in the new one */
+		switch (size) {
+		case 1:
+			val = val & 0xFF;
+			if (offset == 3)
+				data = (data & 0x00FFFFFF) | (val << 24);
+			if (offset == 2)
+				data = (data & 0xFF00FFFF) | (val << 16);
+			if (offset == 1)
+				data = (data & 0xFFFF00FF) | (val <<  8);
+			if (offset == 0)
+				data = (data & 0xFFFFFF00) |  val       ;
+			break;
+
+		case 2:
+			val = val & 0xFFFF;
+			if (offset == 2)
+				data = (data & 0x0000FFFF) | (val << 16);
+			if (offset == 0)
+				data = (data & 0xFFFF0000) |  val       ;
+			break;
+
+		case 4:
+			data = val;
+			break;
+		}
+
+		/*write the new 32 bits */
+		pcie_rc_cfg_write32(type, bus->number, PCI_SLOT(devfn),
+			PCI_FUNC(devfn), where & ~0x3, &data);
+	}
+
+	spin_unlock_irqrestore(&PCIE_lock, flags);
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s: WROTE PCI data %8x to   bus %8x device %8x function "
+		"%8x register %8x size %d\n", pcieModule_Name, __func__,
+		val, bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), where,
+		size);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+
+
+/*******************************************************************************
+ * asic_pcie_process_interrupt
+ *
+ * Parameters:
+ * 	Irq - interrupt number
+ * 	tbd - pointer to controller specific data (specifics tbd)
+ * 	pointer to register contents prior to interrupt
+ *
+ * Return Value:
+ * returns: IRQ_HANDLED or IRQ_NONE
+ *
+ * Description:
+ * asic_pcie_process_interrupt is called to process PCI Express interrupts.
+ *
+ ******************************************************************************/
+static irqreturn_t asic_pcie_process_interrupt(int irq, void *dev_id)
+{
+	int i;
+	u32 bit;
+
+	if (PCIE_initialized == 0)
+		return IRQ_NONE;
+
+	/*disable all pcie interrupts */
+	writel_and(~kPCIX_CTL1_PCI_ENAB_INTS, &PCIE_RegsPtr->PCIX_CTL1);
+
+	/*save the system data */
+	intdata[0] = (u32)irq;
+	intdata[1] = (u32)dev_id;
+
+	/*save interrupts pending */
+	intdata[2] = readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_LOW);
+	intdata[3] = readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_HIGH);
+
+	/*clear the pending interrupts (pulse high then low) */
+	writel(intdata[2], &PCIE_RegsPtr->PCIX_CLRRISE_LOW);
+	writel(0, &PCIE_RegsPtr->PCIX_CLRRISE_LOW);
+	writel(intdata[3], &PCIE_RegsPtr->PCIX_CLRRISE_HIGH);
+	writel(0, &PCIE_RegsPtr->PCIX_CLRRISE_HIGH);
+
+	/*adjust interrupt counters */
+	bit = 0x01;
+	for (i = 0; i < 32; i++) {
+		if (intdata[2] & bit)
+			intcountslow[i]++;
+		if (intdata[3] & bit)
+			intcountshigh[i]++;
+		bit = bit << 1;
+	}
+
+	/*enable all pcie interrupts */
+	writel_or(kPCIX_CTL1_PCI_ENAB_INTS, &PCIE_RegsPtr->PCIX_CTL1);
+
+
+	return IRQ_HANDLED;
+}
+
+
+
+/*******************************************************************************
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
+ ******************************************************************************/
+int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:asic_pcie_map_irq called(%x, %x, %x).\n",
+		pcieModule_Name, __func__, (u32)dev, slot, pin);
+
+	return kIrq_PCIExp;
+}
+EXPORT_SYMBOL(asic_pcie_map_irq);
+
+
+
+/*******************************************************************************
+ * pcie_rc_cfg_read32
+ *
+ * Read 32 bit value from non RC config space
+ *
+ * Parameters:
+ *  type - type 0 or 1 header
+ * 	busnum - bus number
+ * 	devnum - device number
+ *  func_num - function number
+ *  reg_num - register number
+ *  *dataptr - pointer to where data value should be stored
+ *
+ * Return Value: 0 success -1 error
+ *
+ ******************************************************************************/
+u32 pcie_rc_cfg_read32(u32 type, u32 busnum, u32 devnum, u32 func_num,
+	u32 reg_num, u32 *dataptr)
+{
+
+	unsigned int temp;
+	unsigned int stat;
+	u32 rtn = 0;
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:pcie_rc_cfg_read32 called (%x, %x, %x, %x, %x, %x).\n",
+		pcieModule_Name, __func__, type, busnum, devnum, func_num,
+		reg_num, *dataptr);
+
+	/*enter RC mode */
+	writel_and(~kPCIX_CTL1_PCIE_TLP_ENABLE, &PCIE_RegsPtr->PCIX_CTL1);
+	writel(1, &PCIE_RegsPtr->PCIE_RC_CFG_MODE);
+
+	/*setup for read */
+	temp = (reg_num) | (func_num<<16) | (devnum<<19) | (busnum<<24);
+	writel(temp, &PCIE_RegsPtr->PCIE_RC_CFG_SETUP2);
+	writel(kPCIE_RC_CFG_SETUP1_CFG_ENAB_ALL_BYTES | (type<<2) |
+		kPCIE_RC_CFG_SETUP1_CFG_READ,
+		&PCIE_RegsPtr->PCIE_RC_CFG_SETUP1);
+
+	/*read and wait for completion */
+	stat = readl(&PCIE_RegsPtr->PCIE_RC_CFG_STAT);
+	while ((stat & 6) == 0)
+			stat = readl(&PCIE_RegsPtr->PCIE_RC_CFG_STAT);
+
+	/*successful? */
+	if (stat & 4) {
+			SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+				"%s:%s:pcie_rc_cfg_read32 timeout.\n",
+				pcieModule_Name, __func__);
+			rtn = -1;
+	}
+
+	*dataptr = readl(&PCIE_RegsPtr->PCIE_RC_CFG_CPL_DATA);
+
+	/* leave RC config mode      */
+	writel(0, &PCIE_RegsPtr->PCIE_RC_CFG_MODE);
+	writel_or(kPCIX_CTL1_PCIE_TLP_ENABLE, &PCIE_RegsPtr->PCIX_CTL1);
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:pcie_rc_cfg_read32 read %x.\n", pcieModule_Name,
+		__func__, *dataptr);
+	return rtn;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_rc_cfg_write32
+ *
+ * Write 32 bit value from non RC config space
+ *
+ * Parameters:
+ *  type - type 0 or 1 header
+ * 	busnum - bus number
+ * 	devnum - device number
+ *  func_num - function number
+ *  reg_num - register number (word based!)
+ *  *dataptr - pointer to where data value should be stored
+
+ * Return Value: 0 success -1 error
+ *
+ ******************************************************************************/
+u32 pcie_rc_cfg_write32(u32 type, u32 busnum, u32 devnum, u32 func_num,
+	u32 reg_num, u32 *dataptr)
+{
+
+	unsigned int temp;
+	u32 rtn = 0;
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+		"%s:%s:pcie_rc_cfg_write32 called (%x, %x, %x, %x, %x, %x).\n",
+		pcieModule_Name, __func__, type, busnum, devnum, func_num,
+		reg_num, *dataptr);
+
+	/*enter RC mode */
+	writel_and(~kPCIX_CTL1_PCIE_TLP_ENABLE, &PCIE_RegsPtr->PCIX_CTL1);
+	writel(1, &PCIE_RegsPtr->PCIE_RC_CFG_MODE);
+
+	/*setup for write */
+	temp = (reg_num) | (func_num<<16) | (devnum<<19) | (busnum<<24);
+	writel(temp, &PCIE_RegsPtr->PCIE_RC_CFG_SETUP2);
+	writel(*dataptr, &PCIE_RegsPtr->PCIE_RC_CFG_WRITE_DATA);
+
+	/*write the data */
+	writel(kPCIE_RC_CFG_SETUP1_CFG_ENAB_ALL_BYTES | (type<<2) |
+		kPCIE_RC_CFG_SETUP1_CFG_WRITE,
+		&PCIE_RegsPtr->PCIE_RC_CFG_SETUP1);
+
+	/* leave RC config mode      */
+	writel(0, &PCIE_RegsPtr->PCIE_RC_CFG_MODE);
+	writel_or(kPCIX_CTL1_PCIE_TLP_ENABLE, &PCIE_RegsPtr->PCIX_CTL1);
+
+	return rtn;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_uSecDelay
+ *
+ * delay number of us passed
+ *
+ * Parameters:
+ *  us - number of microseconds
+ *
+ * Return Value: none
+ *
+ ******************************************************************************/
+static void pcie_uSecDelay(u32 us)
+{
+	u32 start, stop, adder;
+
+	/*check for no delay */
+	if (us == 0)
+		return;
+
+	/*read timer and calculate end time */
+	start = *timerptr;
+	stop  = start + (us * 3); /* rounded down from 3.375 */
+	adder = 0;
+
+	/*check for wrap */
+	if (stop < start) {
+		stop += 0x7FFFFFFF;
+		adder = 0x7FFFFFFF;
+	}
+
+loop:
+	if (stop > (*timerptr + adder))
+		goto loop;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_delay
+ *
+ * delay number of ms passed
+ *
+ * Parameters:
+ *  ms - number of milliseconds
+ *
+ * Return Value: none
+ *
+ ******************************************************************************/
+static void pcie_delay(u32 ms)
+{
+	u32 start, stop, adder;
+
+	/*check for no delay */
+	if (ms == 0)
+		return;
+
+	/*read timer and calculate end time */
+	start = *timerptr;
+	stop  = start + (ms * 3375);
+	adder = 0;
+
+	/*check for wrap */
+	if (stop < start) {
+		stop += 0x7FFFFFFF;
+		adder = 0x7FFFFFFF;
+	}
+
+loop:
+	if (stop > (*timerptr + adder))
+		goto loop;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_reset_ethernet
+ *
+ * reset ethernet chip
+ *
+ * Parameters: none
+ *
+ * Return Value: -1 error, otherwise 0
+ *
+ ******************************************************************************/
+static int pcie_reset_ethernet(void)
+{
+	/* virtual pointer to register region */
+	struct tFPanel_regs  *pFPanelRegs;
+
+	/*Map VFD registers for ethernet reset line */
+	pFPanelRegs = (struct tFPanel_regs *)(asic_reg_addr(Front_Panel));
+	if (pFPanelRegs == 0) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to remap reset register\n",
+			pcieModule_Name, __func__);
+		return -1;
+	}
+
+	writel(0x45, &pFPanelRegs->rSVFDFifo);
+	writel(0x107, &pFPanelRegs->rSVFDFifo);
+	writel(0x1, &pFPanelRegs->rSVFDStart);
+
+	pcie_delay(140);
+
+	writel(0x45, &pFPanelRegs->rSVFDFifo);
+	writel(0x10F, &pFPanelRegs->rSVFDFifo);
+	writel(0x1, &pFPanelRegs->rSVFDStart);
+
+	return 0;
+}
+
+
+
+
+/*******************************************************************************
+ *******************************************************************************
+ *   DEBUG/INFORMATION Elements
+ *******************************************************************************
+ *******************************************************************************
+ *******************************************************************************
+ * pcie_Init
+ *
+ * API Type - Kernel public
+ *
+ * Parameters - None
+ *
+ * Return Value - 0 or error
+ *
+ * Description:
+ * This is expected to be called from the Linux kernel during module
+ * installation. It has no functionality except to init the global semaphore
+ *
+ ******************************************************************************/
+static int __init pcie_Init(void)
+{
+#if LOADABLE
+	int status = 0;
+
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s:%s:pcie_Init called.\n",
+		pcieModule_Name, __func__);
+
+	if (!platform_supports_pcie())
+		return -1;
+
+	/*init asic PCIE */
+	status = asic_pcie_init();
+	if (status != 0) {
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s:pcie_Init failed.\n", pcieModule_Name,
+			__func__);
+		return -EADDRINUSE;
+	}
+#else
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s:%s:pcie_Init called.\n",
+		pcieModule_Name, __func__);
+
+	if (!platform_supports_pcie())
+		return -1;
+
+#endif  /*LOADABLE */
+
+
+	if (PCIE_initialized == 0)
+		return -1;
+
+
+	/*request the IRQ and enable interrupts if successful */
+	PCIE_irqrequest_pcie =
+		request_irq(kIrq_PCIExp, asic_pcie_process_interrupt,
+		IRQF_SHARED, "PCIE Interrupt", (void *)PCIE_RegsPtr);
+
+	if (PCIE_irqrequest_pcie != 0)
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT,
+			"%s:%s: failed to get IRQ (%x)\n", pcieModule_Name,
+			__func__, PCIE_irqrequest_pcie);
+	else {
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s:%s: Got IRQ (%x)\n",
+			pcieModule_Name, __func__, PCIE_irqrequest_pcie);
+
+		/*enable interrupts */
+		writel_or(kPCIX_CTL1_PCI_ENAB_INTS, &PCIE_RegsPtr->PCIX_CTL1);
+	}
+
+
+
+
+	/*Proc stuff */
+	PCIE_pProc = create_proc_entry(pcieModule_Name, S_IRUGO | S_IWUGO,
+		NULL);
+
+	if (PCIE_pProc != NULL) {
+		PCIE_pProc->read_proc = pcie_ReadProc;
+		PCIE_pProc->write_proc = pcie_WriteProc;
+	} else
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT, "%s:%s: proc not created\n",
+			 pcieModule_Name, __func__);
+
+	return 0;
+}
+module_init(pcie_Init);
+
+
+/*******************************************************************************
+ * pcie_Finalize
+ *
+ * API Type - Kernel public.
+ *
+ * Parameters - None
+ *
+ * Return Value - None
+ *
+ * Description:
+ * This is expected to be called from the Linux kernel when the module is
+ * unloaded. It has no functionality.
+ *
+ ******************************************************************************/
+static void __exit pcie_Finalize(void)
+{
+
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s:%s:pcie_Finalize called.\n",
+		pcieModule_Name, __func__);
+
+	/*free IRQ */
+	if (PCIE_irqrequest_pcie == 0)
+		free_irq(kIrq_PCIExp, 0);
+
+	/*remove proc entry */
+	if (PCIE_pProc != NULL)
+		remove_proc_entry(pcieModule_Name, NULL);
+}
+module_exit(pcie_Finalize);
+
+
+
+
+/*******************************************************************************
+ * pcie_WriteProc
+ *
+ * pfile     - pointer to the return buffer
+ * pbuff     - not used
+ * bytecnt   - not used
+ * pdata     - length of the return buffer
+ *
+ * bytes filled in the return buffer
+ *
+ ******************************************************************************/
+static int pcie_WriteProc(struct file *pfile, const char __user *pbuff,
+	unsigned long bytecnt, void *data)
+{
+	u8 buffer[65];
+	int cnt;
+	u32 addr;
+	u32 *ioaddr;
+	int i, stat, index;
+	struct pci_bus pseudobus;
+	int busnumber, dev, fn, where, size, val;
+	int rtn;
+	int saveloglevel;
+	int rval, wval;
+	u8  byte;
+	u8  *byteptr;
+	u16 word;
+	u16 *wordptr;
+	u32 dword;
+	u32 *dwordptr;
+	u32 savemem;
+	u32 led;
+	struct tFPanel_regs  *pFPanelRegs;
+
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT, "%s: pcie WriteProc \n",
+		pcieModule_Name);
+
+	/* get the buffer count, but limit it to 64 chars */
+	cnt = (bytecnt < 64) ? bytecnt : 64;
+
+	memset(buffer, 0, 65);
+
+	/* get the users buffer */
+	stat = copy_from_user(buffer, pbuff, cnt);
+	if (stat < 0)
+		return stat;
+
+	pr_info("STRING= %s \n", buffer);
+
+	/* if its the log level command then change the level */
+	if (!strncmp(buffer, "LogLevel=", 8)) {
+		sscanf(buffer, "LogLevel=%d", &LogLevel);
+
+		SAPRINT(SA_NOISE, SA_LOG_TO_PRINT,
+			"%s: Noise log \n", pcieModule_Name);
+		SAPRINT(SA_INFO,  SA_LOG_TO_PRINT, "%s: Info log \n",
+			pcieModule_Name);
+		SAPRINT(SA_SEVERE, SA_LOG_TO_PRINT, "%s: Severe log \n",
+			 pcieModule_Name);
+		SAPRINT(SA_FATAL, SA_LOG_TO_PRINT, "%s: Fatal log \n",
+			pcieModule_Name);
+
+		return cnt;
+	}
+
+	/*set VFD ledn (ethernet reset is led4 (bit 3) */
+	if (!strncmp(buffer, "Z=", 2)) {
+		sscanf(buffer, "Z=%x", &led);
+		pFPanelRegs = (struct tFPanel_regs *)
+			(asic_reg_addr(Front_Panel));
+		writel(0x45, &pFPanelRegs->rSVFDFifo);
+		writel(0x100 | led, &pFPanelRegs->rSVFDFifo);
+		writel(0x1, &pFPanelRegs->rSVFDStart);
+		pr_info("set Led to %x\n", led);
+		return cnt;
+	}
+
+	/*reset ethernet  */
+	if (!strncmp(buffer, "z=", 2)) {
+		pcie_reset_ethernet();
+		return cnt;
+	}
+
+	/*read register */
+	if (!strncmp(buffer, "R=", 2)) {
+		ioaddr = (u32 *)PCIE_RegsPtr;
+		sscanf(buffer, "R=%x", &index);
+		pr_info("Data at PCIe[%x]= %x\n", index, ioaddr[index]);
+		return cnt;
+	}
+
+	/*write register */
+	if (!strncmp(buffer, "W=", 2)) {
+		ioaddr = (u32 *)PCIE_RegsPtr;
+		sscanf(buffer, "W=%x %x", &index, &val);
+		pr_info("Writing data at PCIe[%x] to %x\n", index, val);
+		ioaddr[index] = val;
+		return cnt;
+	}
+
+	/*dump specific range of registers */
+	if (!strncmp(buffer, "D=", 2)) {
+		ioaddr = (u32 *)PCIE_RegsPtr;
+		saveloglevel =  LogLevel;
+		LogLevel = SA_OFF;
+		sscanf(buffer, "D=%x %x", &index, &val);
+		for (i = 0; i < val; i++) {
+			pr_info("Data at PCIe[%x] %x\n", index,
+				ioaddr[index]);
+			index++;
+		}
+		LogLevel = saveloglevel;
+		return cnt;
+	}
+
+	/*dump all registers */
+	if (!strncmp(buffer, "d=", 2)) {
+		pcie_DumpRegs();
+		return cnt;
+	}
+
+	/*interrupt counters */
+	if (!strncmp(buffer, "N=", 2)) {
+		for (i = 0; i < 32; i++) {
+			if (intcountslow[i] != 0)
+				pr_info("Interrupt count low %d is %x\n", i,
+					intcountslow[i]);
+		}
+		for (i = 0; i < 32; i++) {
+			if (intcountshigh[i] != 0)
+				pr_info("Interrupt count high %d is %x\n", i,
+					intcountshigh[i]);
+		}
+		return cnt;
+	}
+
+	/*read config word */
+	if (!strncmp(buffer, "I=", 2)) {
+		sscanf(buffer, "I=%d %d %d %x %d", &busnumber, &dev, &fn,
+			&where, &size);
+		pseudobus.number = busnumber;
+		rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn),
+			where, size, &val);
+		if (rtn == PCIBIOS_SUCCESSFUL)
+			pr_info("Data at bus %d device %d function %d register "
+				"%x (size %d) was %x\n", busnumber, dev, fn,
+				where, size, (u32)val);
+		else
+			pr_err("asic_pcie_read_config failed (%d).\n", rtn);
+		return cnt;
+	}
+
+	/*write config word */
+	if (!strncmp(buffer, "O=", 2)) {
+		sscanf(buffer, "O=%d %d %d %x %d %x", &busnumber, &dev, &fn,
+			&where, &size, &val);
+		pseudobus.number = busnumber;
+		rtn = asic_pcie_write_config(&pseudobus, PCI_DEVFN(dev, fn),
+			where, size, val);
+		if (rtn == PCIBIOS_SUCCESSFUL)
+			pr_info("Data written to bus %d device %d function %d "
+				"register %x (size %d) was %x\n", busnumber,
+				dev, fn, where, size, (u32)val);
+		else
+			pr_err("asic_pcie_write_config failed (%d).\n", rtn);
+		return cnt;
+	}
+
+	/*enumerate bus */
+	if (!strncmp(buffer, "E=", 2)) {
+		saveloglevel =  LogLevel;
+		LogLevel = SA_OFF;
+		sscanf(buffer, "E=%d", &busnumber);
+		pseudobus.number = busnumber;
+		for (dev = 0; dev < 32; dev++) {
+			rtn = asic_pcie_read_config(&pseudobus,
+				PCI_DEVFN(dev, 0), 0, 4, &val);
+			if (rtn == PCIBIOS_SUCCESSFUL)
+				pr_info("Data at bus %d device %d function 0 "
+					"register 0 (size 4) was %x\n",
+					busnumber, dev, (u32)val);
+			else
+				pr_err("asic_pcie_read_config failed (%d).\n",
+					rtn);
+		}
+		LogLevel = saveloglevel;
+		return cnt;
+	}
+
+	/*dump Config area */
+	if (!strncmp(buffer, "C=", 2)) {
+		saveloglevel =  LogLevel;
+		LogLevel = SA_OFF;
+		sscanf(buffer, "C=%d %d %d", &busnumber, &dev, &fn);
+		pseudobus.number = busnumber;
+		where = 0;
+		pr_info("\n");
+		for (where = 0; where < 4096; where = where+4) {
+			if ((where & 0x1F) == 0x00)
+				pr_info("\n%08x ", where);
+			rtn = asic_pcie_read_config(&pseudobus,
+				PCI_DEVFN(dev, fn), where, 4, &val);
+			if (rtn == PCIBIOS_SUCCESSFUL)
+				pr_info(" %08x", (u32)val);
+			else
+				pr_info(" xxxxxxxx");
+		}
+		pr_info("\n");
+		LogLevel = saveloglevel;
+		return cnt;
+	}
+
+	/*dump Config area */
+	if (!strncmp(buffer, "S=", 2)) {
+		int ptr;
+
+		saveloglevel =  LogLevel;
+		LogLevel = SA_OFF;
+		sscanf(buffer, "S=%d %d %d", &busnumber, &dev, &fn);
+		pseudobus.number = busnumber;
+		pr_info("Header:\n");
+		for (where = 0; where < 64; where = where+4) {
+			if ((where & 0x1F) == 0x00)
+				pr_info("\n%08x ", where);
+			rtn = asic_pcie_read_config(&pseudobus,
+				PCI_DEVFN(dev, fn), where, 4, &val);
+			if (rtn == PCIBIOS_SUCCESSFUL)
+				pr_info(" %08x", (u32)val);
+			else
+				pr_info(" xxxxxxxx");
+		}
+
+		/*follow the capabilities */
+		rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn),
+			0x34, 1, &ptr);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			LogLevel = saveloglevel;
+			return cnt;
+		}
+
+		if (ptr != 0) {
+			while ((ptr != 0x100) && ((ptr & 0x03) == 0))
+				ptr = pcie_dumpcapability(busnumber, dev, fn,
+					ptr);
+
+			/*follow the extended capabilities */
+			ptr = 0x100;
+			while ((ptr != 0x1000) && ((ptr & 0x03) == 0))
+				ptr = pcie_dumpextendedcapability(busnumber,
+					dev, fn, ptr);
+		}
+
+		pr_info("\n");
+		LogLevel = saveloglevel;
+		return cnt;
+	}
+
+	/*Root Complex R/W test */
+	if (!strncmp(buffer, "T=", 2)) {
+		pr_info("Root Complex R/W test\n");
+		pseudobus.number = 255;
+
+		/*save old value */
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x20, 4, &val);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Setup failed\n");
+			return cnt;
+		}
+
+		/* bytewise test */
+		wval = 0x10;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x20, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x20, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_info("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x32;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x21, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x21, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x40;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x22, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x22, 1,
+			&rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x65;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x23, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x23, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+
+		/* 16 bit test */
+		wval = 0x9870;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x20, 2, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x20, 2,
+			&rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0xCBA0;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x22, 2, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x22, 2, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		/* 32 bit test */
+		wval = 0x77605540;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x20, 4, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x20, 4, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+
+		/*restore original value */
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x20, 4,
+			val);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Restore failed\n");
+			return cnt;
+		}
+
+
+		pr_info("Test passed\n");
+
+		return cnt;
+	}
+
+	/*Endpoint R/W test */
+	if (!strncmp(buffer, "t=", 2)) {
+		pr_info("Endpoint R/W test\n");
+
+		pseudobus.number = 0;
+
+		/*save old value */
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x14, 4, &val);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Setup failed\n");
+			return cnt;
+		}
+
+
+		/* bytewise test */
+		wval = 0x10;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x14, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x14, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x32;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x15, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x15, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x40;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x16, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x16, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0x65;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x17, 1, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x17, 1, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+
+
+		/* 16 bit test */
+		wval = 0x9870;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x14, 2, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x14, 2, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+		wval = 0xCBA0;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x16, 2, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x16, 2, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+
+
+		/* 32 bit test */
+		wval = 0x77605540;
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x14, 4, wval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Write failed\n");
+			return cnt;
+		}
+		rtn = asic_pcie_read_config(&pseudobus, 0, 0x14, 4, &rval);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Read failed\n");
+			return cnt;
+		}
+		if (wval != rval) {
+			pr_err("Test failed (%x, %x)\n", wval, rval);
+			return cnt;
+		}
+
+
+		/*restore original value */
+		rtn = asic_pcie_write_config(&pseudobus, 0, 0x20, 4, val);
+		if (rtn != PCIBIOS_SUCCESSFUL) {
+			pr_err("Restore failed\n");
+			return cnt;
+		}
+
+
+		pr_info("Test passed\n");
+
+		return cnt;
+	}
+
+
+	/*Byte Order Memory Mapped Register test */
+	if (!strncmp(buffer, "M=", 2)) {
+		pr_info("Byte Order Memory Mapped Register test\n");
+
+		byteptr  = (u8 *)ioremap_nocache(0x8000000, 1024);
+		wordptr  = (u16 *)byteptr;
+		dwordptr = (u32 *)byteptr;
+
+		if (byteptr == 0) {
+			pr_err("Test failed. Unable to remap memory\n");
+			return cnt;
+		}
+
+		/*TEST1 */
+		/*read memory mapped register as byte, word, and dword */
+		byte = fix_readb(byteptr+0x11B);
+		word = fix_readw(wordptr+0x08D);
+		dword = fix_readl(dwordptr+0x046);
+
+		if ((byte != 0xB7) || ((word & 0xFF00) != 0xB700) ||
+			((dword & 0xFF000000) != 0xB7000000)) {
+			iounmap(byteptr);
+			pr_err("Test failed. byte= %x  word= %x  dword= %x\n",
+				byte, word, dword);
+			return cnt;
+		}
+
+
+		/*TEST2 */
+		/*seve original contents */
+		savemem = fix_readl(dwordptr + 0x3);
+
+
+		/*write as a long */
+		fix_writel(0x11223344, dwordptr + 0x03);
+
+		/*read as bytes */
+		byte = fix_readb(byteptr + 0x0C);
+		if (byte != 0x44) {
+			pr_err("Test Failed. Byte 0x11 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0D);
+		if (byte != 0x33) {
+			pr_err("Test Failed. Byte 0x22 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0E);
+		if (byte != 0x22) {
+			pr_err("Test Failed. Byte 0x33 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0F);
+		if (byte != 0x11) {
+			pr_err("Test Failed. Byte 0x44 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as words */
+		word = fix_readw(wordptr + 0x06);
+		if (word != 0x3344) {
+			pr_err("Test Failed. Word 0x1122 (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		word = fix_readw(wordptr + 0x07);
+		if (word != 0x1122) {
+			pr_err("Test Failed. Word 0x3344 (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as a long */
+		dword = fix_readl(dwordptr + 0x03);
+		if (dword != 0x11223344) {
+			pr_err("Test Failed. Dword 0x11223344 (%x)\n", dword);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+
+		/*write as two words */
+		fix_writew(0x8899, wordptr + 0x06);
+		fix_writew(0x6677, wordptr + 0x07);
+
+		/*read as bytes */
+		byte = fix_readb(byteptr + 0x0C);
+		if (byte != 0x99) {
+			pr_err("Test Failed. Byte 0x88 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0D);
+		if (byte != 0x88) {
+			pr_err("Test Failed. Byte 0x99 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0E);
+		if (byte != 0x77) {
+			pr_err("Test Failed. Byte 0x66 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0F);
+		if (byte != 0x66) {
+			pr_err("Test Failed. Byte 0x77 (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as words */
+		word = fix_readw(wordptr + 0x06);
+		if (word != 0x8899) {
+			pr_err("Test Failed. Word 0x8899 (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		word = fix_readw(wordptr + 0x07);
+		if (word != 0x6677) {
+			pr_err("Test Failed. Word 0x6677 (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as a long */
+		dword = fix_readl(dwordptr + 0x03);
+		if (dword != 0x66778899) {
+			pr_err("Test Failed. Dword 0x88996677 (%x)\n", dword);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+
+		/*write as four bytes */
+		fix_writeb(0xFF, byteptr + 0x0C);
+		fix_writeb(0xEE, byteptr + 0x0D);
+		fix_writeb(0xDD, byteptr + 0x0E);
+		fix_writeb(0xCC, byteptr + 0x0F);
+
+		/*read as bytes */
+		byte = fix_readb(byteptr + 0x0C);
+		if (byte != 0xFF) {
+			pr_err("Test Failed. Byte 0xFF (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0D);
+		if (byte != 0xEE) {
+			pr_err("Test Failed. Byte 0xEE (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0E);
+		if (byte != 0xDD) {
+			pr_err("Test Failed. Byte 0xDD (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		byte = fix_readb(byteptr + 0x0F);
+		if (byte != 0xCC) {
+			pr_err("Test Failed. Byte 0xCC (%x)\n", byte);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as words */
+		word = fix_readw(wordptr + 0x06);
+		if (word != 0xEEFF) {
+			pr_err("Test Failed. Word 0xFFEE (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+		word = fix_readw(wordptr + 0x07);
+		if (word != 0xCCDD) {
+			pr_err("Test Failed. Word 0xDDCC (%x)\n", word);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+		/*read as a long */
+		dword = fix_readl(dwordptr + 0x03);
+		if (dword != 0xCCDDEEFF) {
+			pr_err("Test Failed. Dword 0xCCDDEEFF (%x)\n", dword);
+			iounmap(byteptr);
+			fix_writel(savemem, dwordptr + 0x03);
+			return cnt;
+		}
+
+
+		/*restore test location */
+		fix_writel(savemem, dwordptr + 0x03);
+
+
+		iounmap(byteptr);
+
+		pr_info("Test passed\n");
+
+		return cnt;
+	}
+
+	/*Memory Mapped Register dump */
+	if (!strncmp(buffer, "H=", 2)) {
+		dwordptr  = (u32 *)ioremap_nocache(0x8000000, 16384);
+		if (dwordptr == 0) {
+			pr_err("Failed. Unable to remap memory\n");
+			return cnt;
+		}
+
+		sscanf(buffer, "H=%x %x", &addr, &val);
+		addr = (addr + (u32)dwordptr) & 0xFFFFFFE0;
+		val |= 0xF;
+		pr_info("dump %x words of memory from %x\n", val, addr);
+
+		for (i = 0; i < val; i++) {
+			if ((addr & 0x1F) == 0x00)
+				pr_info("\n%08x ", addr);
+			dword = fix_readl((u32 *)addr);
+			pr_info(" %08x", (u32)dword);
+			addr += 4;
+		}
+		pr_info("\n");
+
+		iounmap(dwordptr);
+		return cnt;
+	}
+
+
+	return cnt;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_ReadProc is called to dump HW registers
+ *
+ * page   - not used
+ * start  - not used
+ * off    - not used
+ * count  - not used
+ * eof    - not used
+ * data   - not used
+ *
+ * return - 0 or error if not enabled
+ *
+ *
+ ******************************************************************************/
+static int pcie_ReadProc(char *page, char **start, off_t off, int pageSize,
+	int *eof, void *data)
+{
+	SAPRINT(SA_NOISE, SA_LOG_TO_PRINT, "%s: pcie ReadProc \n",
+		pcieModule_Name);
+
+	return 0;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_dumpcapability is called to dump a PCI capability structure
+ *
+ * bus - bus number
+ * dev - device number
+ * fun - function number
+ * ptr - pointer to beginning of device structure
+ *
+ * return - 0 or pointer to next capability structure
+ *
+ *
+ ******************************************************************************/
+int pcie_dumpcapability(int busnumber, int dev, int fn, int ptr)
+{
+	struct pci_bus pseudobus;
+	int id, nextptr;
+	int rtn, val, where;
+	int dumpptr;
+
+	pseudobus.number = busnumber;
+
+	/*read id */
+	rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn), ptr, 1,
+		&id);
+	if (rtn != PCIBIOS_SUCCESSFUL)
+		return 0;
+
+	/*read nextptr */
+	rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn), ptr+1, 1,
+		&nextptr);
+	if (rtn != PCIBIOS_SUCCESSFUL)
+		return 0;
+	if (nextptr == 0)
+		nextptr = 0x100;
+
+	pr_info("\nID= %x", id);
+
+	dumpptr = ptr & 0xFFFFFFF0;
+	if (ptr != dumpptr) {
+		pr_info("\n%08x ", dumpptr);
+		for (where = dumpptr; where < ptr; where = where+4)
+			pr_info(" xxxxxxxx");
+	}
+
+	for (where = ptr; where < nextptr; where = where+4) {
+		if ((where & 0xF) == 0x00)
+			pr_info("\n%08x ", where);
+		rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn),
+			where, 4, &val);
+		if (rtn == PCIBIOS_SUCCESSFUL)
+			pr_info(" %08x", (u32)val);
+		else
+			pr_info(" xxxxxxxx");
+	}
+	return nextptr;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_dumpextendedcapability is called to dump an extended PCI capability structure
+ *
+ * bus - bus number
+ * dev - device number
+ * fun - function number
+ * ptr - pointer to beginning of device structure
+ *
+ * return - 0 or pointer to next capability structure
+ *
+ *
+ ******************************************************************************/
+int pcie_dumpextendedcapability(int busnumber, int dev, int fn, int ptr)
+{
+	struct pci_bus pseudobus;
+	int id, nextptr;
+	int rtn, val, where;
+
+	pseudobus.number = busnumber;
+
+	/*read id */
+	rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn), ptr, 2,
+		&id);
+	if (rtn != PCIBIOS_SUCCESSFUL)
+		return 0;
+
+	/*read nextptr */
+	rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn), ptr+2, 2,
+		&nextptr);
+	if (rtn != PCIBIOS_SUCCESSFUL)
+		return 0;
+	nextptr = nextptr >> 4;
+	if (nextptr == 0)
+		nextptr = 0x1000;
+
+	pr_info("\nExID= %x", id);
+
+	for (where = ptr; where < nextptr; where = where+4) {
+		if ((where & 0xF) == 0x00)
+			pr_info("\n%08x ", where);
+		rtn = asic_pcie_read_config(&pseudobus, PCI_DEVFN(dev, fn),
+			where, 4, &val);
+		if (rtn == PCIBIOS_SUCCESSFUL)
+			pr_info(" %08x", (u32)val);
+		else
+			pr_info(" xxxxxxxx");
+	}
+	return nextptr;
+}
+
+
+
+
+/*******************************************************************************
+ * pcie_DumpRegs
+ *
+ * API Type - pcie private
+ *
+ * Parameters - none
+ *
+ * Return Value - none
+ *
+ * Description:
+ * Dups all registers
+ *
+ ******************************************************************************/
+void pcie_DumpRegs()
+{
+int i;
+
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "%s: pcie_DumpRegs \n",
+		pcieModule_Name);
+
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[i],
+			readl(&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC0[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC1[i],
+			readl(&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC1[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC2[i],
+			readl(&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC2[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC3[i],
+			readl(&PCIE_RegsPtr->PCIX_CFG_SPACE_FUNC3[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_ACC_BAR0[i],
+			readl(&PCIE_RegsPtr->PCIX_ACC_BAR0[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_ACC_BAR1[i],
+			readl(&PCIE_RegsPtr->PCIX_ACC_BAR1[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_ACC_BAR2[i],
+			readl(&PCIE_RegsPtr->PCIX_ACC_BAR2[i]));
+	for (i = 0; i < 1024; i++)
+		SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+			(u32)&PCIE_RegsPtr->PCIX_ACC_BAR3[i],
+			readl(&PCIE_RegsPtr->PCIX_ACC_BAR3[i]));
+
+
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CTL1,
+		readl(&PCIE_RegsPtr->PCIX_CTL1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_TRGT0_EN,
+		readl(&PCIE_RegsPtr->PCIX_TRGT0_EN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_ADDR_ALIGN_EN,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_ADDR_ALIGN_EN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLPREQID,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLPREQID));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLP_ADEOT,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLP_ADEOT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLPTC,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLPTC));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLPEP,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLPEP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLPATTR,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLPATTR));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT0_TLPFUN,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT0_TLPFUN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT1_ADDR_ALIGN_EN,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT1_ADDR_ALIGN_EN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_APP_UNLOCK,
+		readl(&PCIE_RegsPtr->PCIX_APP_UNLOCK));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT1_TLP_BADEOT,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT1_TLP_BADEOT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_APPREQ,
+		readl(&PCIE_RegsPtr->PCIX_APPREQ));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLIENT1_TLPEP,
+		readl(&PCIE_RegsPtr->PCIX_CLIENT1_TLPEP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MEMRD_LOCKEN,
+		readl(&PCIE_RegsPtr->PCIX_MEMRD_LOCKEN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_SYSCMD,
+		readl(&PCIE_RegsPtr->PCIX_SYSCMD));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PHYCFG,
+		readl(&PCIE_RegsPtr->PCIX_PHYCFG));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_OUTBAND_PWRUP,
+		readl(&PCIE_RegsPtr->PCIX_OUTBAND_PWRUP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_SYSINT,
+		readl(&PCIE_RegsPtr->PCIX_SYSINT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_SYSATTEN,
+		readl(&PCIE_RegsPtr->PCIX_SYSATTEN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLEAR_RST,
+		readl(&PCIE_RegsPtr->PCIX_CLEAR_RST));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_SOFT_RST,
+		readl(&PCIE_RegsPtr->PCIX_SOFT_RST));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MASKRISE_LOW,
+		readl(&PCIE_RegsPtr->PCIX_MASKRISE_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MASKRISE_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_MASKRISE_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRRISE_LOW,
+		readl(&PCIE_RegsPtr->PCIX_CLRRISE_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRRISE_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_CLRRISE_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSKFALL,
+		readl(&PCIE_RegsPtr->PCIX_MSKFALL));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRFALL,
+		readl(&PCIE_RegsPtr->PCIX_CLRFALL));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSKLEV,
+		readl(&PCIE_RegsPtr->PCIX_MSKLEV));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRLEV,
+		readl(&PCIE_RegsPtr->PCIX_CLRLEV));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_ABORT,
+		readl(&PCIE_RegsPtr->PCIX_ABORT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_APPINIT,
+		readl(&PCIE_RegsPtr->PCIX_APPINIT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC0_USERBAR0,
+		readl(&PCIE_RegsPtr->PCIX_FUNC0_USERBAR0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC0_USERBAR2,
+		readl(&PCIE_RegsPtr->PCIX_FUNC0_USERBAR2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC0_USERBAR4,
+		readl(&PCIE_RegsPtr->PCIX_FUNC0_USERBAR4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC0_USEREXP,
+		readl(&PCIE_RegsPtr->PCIX_FUNC0_USEREXP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC1_USERBAR0,
+		readl(&PCIE_RegsPtr->PCIX_FUNC1_USERBAR0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC1_USERBAR2,
+		readl(&PCIE_RegsPtr->PCIX_FUNC1_USERBAR2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC1_USERBAR4,
+		readl(&PCIE_RegsPtr->PCIX_FUNC1_USERBAR4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC1_USEREXP,
+		readl(&PCIE_RegsPtr->PCIX_FUNC1_USEREXP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC2_USERBAR0,
+		readl(&PCIE_RegsPtr->PCIX_FUNC2_USERBAR0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC2_USERBAR2,
+		readl(&PCIE_RegsPtr->PCIX_FUNC2_USERBAR2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC2_USERBAR4,
+		readl(&PCIE_RegsPtr->PCIX_FUNC2_USERBAR4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC2_USEREXP,
+		readl(&PCIE_RegsPtr->PCIX_FUNC2_USEREXP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC3_USERBAR0,
+		readl(&PCIE_RegsPtr->PCIX_FUNC3_USERBAR0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC3_USERBAR2,
+		readl(&PCIE_RegsPtr->PCIX_FUNC3_USERBAR2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC3_USERBAR4,
+		readl(&PCIE_RegsPtr->PCIX_FUNC3_USERBAR4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FUNC3_USEREXP,
+		readl(&PCIE_RegsPtr->PCIX_FUNC3_USEREXP));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_BASE0,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_BASE0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_BASE1,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_BASE1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_BASE2,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_BASE2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_BASE3,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_BASE3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_WIN0,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_WIN0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_WIN1,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_WIN1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_WIN2,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_WIN2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_T3TARG_WIN3,
+		readl(&PCIE_RegsPtr->PCIX_T3TARG_WIN3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_MODE,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_MODE));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_SETUP1,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_SETUP1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_SETUP2,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_SETUP2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_WRITE_DATA,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_WRITE_DATA));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_STAT,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_STAT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_CPL_DATA,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_CPL_DATA));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIE_RC_CFG_CPLID,
+		readl(&PCIE_RegsPtr->PCIE_RC_CFG_CPLID));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RISING_EVENT_LOW,
+		readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RISING_EVENT_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FALLING_EVENT,
+		readl(&PCIE_RegsPtr->PCIX_FALLING_EVENT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_LEVEL_EVENT,
+		readl(&PCIE_RegsPtr->PCIX_LEVEL_EVENT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PHY_CONT_DATA1,
+		readl(&PCIE_RegsPtr->PCIX_PHY_CONT_DATA1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PHY_CONT_DATA2,
+		readl(&PCIE_RegsPtr->PCIX_PHY_CONT_DATA2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PHY_READ_BACK,
+		readl(&PCIE_RegsPtr->PCIX_PHY_READ_BACK));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_APPS_PM,
+		readl(&PCIE_RegsPtr->PCIX_APPS_PM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_INT_EN,
+		readl(&PCIE_RegsPtr->PCIX_INT_EN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MASKRISE_LOW2,
+		readl(&PCIE_RegsPtr->PCIX_MASKRISE_LOW2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MASKRISE_HIGH2,
+		readl(&PCIE_RegsPtr->PCIX_MASKRISE_HIGH2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRRISE_LOW2,
+		readl(&PCIE_RegsPtr->PCIX_CLRRISE_LOW2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRRISE_HIGH2,
+		readl(&PCIE_RegsPtr->PCIX_CLRRISE_HIGH2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSKFALL2,
+		readl(&PCIE_RegsPtr->PCIX_MSKFALL2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRFALL2,
+		readl(&PCIE_RegsPtr->PCIX_CLRFALL2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSKLEV2,
+		readl(&PCIE_RegsPtr->PCIX_MSKLEV2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CLRLEV2,
+		readl(&PCIE_RegsPtr->PCIX_CLRLEV2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RISING_EVENT_LOW2,
+		readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_LOW2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RISING_EVENT_HIGH2,
+		readl(&PCIE_RegsPtr->PCIX_RISING_EVENT_HIGH2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_FALLING_EVENT2,
+		readl(&PCIE_RegsPtr->PCIX_FALLING_EVENT2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_LEVEL_EVENT2,
+		readl(&PCIE_RegsPtr->PCIX_LEVEL_EVENT2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_PBUS_NUM,
+		readl(&PCIE_RegsPtr->PCIX_CFG_PBUS_NUM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_PBUS_DEVNUM,
+		readl(&PCIE_RegsPtr->PCIX_CFG_PBUS_DEVNUM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PMSTAT,
+		readl(&PCIE_RegsPtr->PCIX_PMSTAT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM,
+		readl(&PCIE_RegsPtr->PCIX_RADM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSI_EN1,
+		readl(&PCIE_RegsPtr->PCIX_MSI_EN1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIADDR1_LOW,
+		readl(&PCIE_RegsPtr->PCIX_MSIADDR1_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIADDR1_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_MSIADDR1_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIDATA1,
+		readl(&PCIE_RegsPtr->PCIX_MSIDATA1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSI_EN2,
+		readl(&PCIE_RegsPtr->PCIX_MSI_EN2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIADDR2_LOW,
+		readl(&PCIE_RegsPtr->PCIX_MSIADDR2_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIADDR2_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_MSIADDR2_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIDATA2,
+		readl(&PCIE_RegsPtr->PCIX_MSIDATA2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_TESTBUS,
+		readl(&PCIE_RegsPtr->PCIX_TESTBUS));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIX_ADDR_LOW,
+		readl(&PCIE_RegsPtr->PCIX_MSIX_ADDR_LOW));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIX_ADDR_HIGH,
+		readl(&PCIE_RegsPtr->PCIX_MSIX_ADDR_HIGH));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIXDATA,
+		readl(&PCIE_RegsPtr->PCIX_MSIXDATA));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_MSIX_EN,
+		readl(&PCIE_RegsPtr->PCIX_MSIX_EN));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_AER_INT_MSGNUM,
+		readl(&PCIE_RegsPtr->PCIX_AER_INT_MSGNUM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CAP_INT_MSTNUM,
+		readl(&PCIE_RegsPtr->PCIX_CAP_INT_MSTNUM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_EMLCONT,
+		readl(&PCIE_RegsPtr->PCIX_EMLCONT));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_PHY_CONT0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_PHY_CONT0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_1,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_4,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_5,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_5));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_6,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_6));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_START_7,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_START_7));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_4,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_5,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_5));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_6,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_6));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_7,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR0_LIMIT_7));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_1,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_4,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_5,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_5));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_6,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_6));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_START_7,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_START_7));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_1,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_4,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_4));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_5,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_5));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_6,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_6));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_7,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BAR1_LIMIT_7));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_1,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_START_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_0,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_1,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_2,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_3,
+		readl(&PCIE_RegsPtr->PCIX_CFG_EXP_ROM_LIMIT_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_XLMH_STATE,
+		readl(&PCIE_RegsPtr->PCIX_XLMH_STATE));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RDLH_LINK,
+		readl(&PCIE_RegsPtr->PCIX_RDLH_LINK));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_BUS_MSTR,
+		readl(&PCIE_RegsPtr->PCIX_CFG_BUS_MSTR));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_MEM,
+		readl(&PCIE_RegsPtr->PCIX_CFG_MEM));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_MSI,
+		readl(&PCIE_RegsPtr->PCIX_CFG_MSI));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_MAX,
+		readl(&PCIE_RegsPtr->PCIX_CFG_MAX));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_PM_CURST,
+		readl(&PCIE_RegsPtr->PCIX_PM_CURST));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_MSGCTL,
+		readl(&PCIE_RegsPtr->PCIX_RADM_MSGCTL));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_MSGPAY,
+		readl(&PCIE_RegsPtr->PCIX_RADM_MSGPAY));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_PWR,
+		readl(&PCIE_RegsPtr->PCIX_RADM_PWR));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_CORR,
+		readl(&PCIE_RegsPtr->PCIX_RADM_CORR));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RTLH_UPD,
+		readl(&PCIE_RegsPtr->PCIX_RTLH_UPD));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RTLD_DATA,
+		readl(&PCIE_RegsPtr->PCIX_RTLD_DATA));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CXPL_DEBUGLO,
+		readl(&PCIE_RegsPtr->PCIX_CXPL_DEBUGLO));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CXPL_DEBUGHI,
+		readl(&PCIE_RegsPtr->PCIX_CXPL_DEBUGHI));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_CPL_0,
+		readl(&PCIE_RegsPtr->PCIX_RADM_CPL_0));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_CPL_1,
+		readl(&PCIE_RegsPtr->PCIX_RADM_CPL_1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_CPL_2,
+		readl(&PCIE_RegsPtr->PCIX_RADM_CPL_2));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_RADM_CPL_3,
+		readl(&PCIE_RegsPtr->PCIX_RADM_CPL_3));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_CFG_RCB,
+		readl(&PCIE_RegsPtr->PCIX_CFG_RCB));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_VEN_MSG_STAT1,
+		readl(&PCIE_RegsPtr->PCIX_VEN_MSG_STAT1));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_VEN_MSG_DATALO,
+		readl(&PCIE_RegsPtr->PCIX_VEN_MSG_DATALO));
+	SAPRINT(SA_INFO, SA_LOG_TO_PRINT, "register at %8x = %8x\n",
+		(u32)&PCIE_RegsPtr->PCIX_VEN_MSG_DATAHI,
+		readl(&PCIE_RegsPtr->PCIX_VEN_MSG_DATAHI));
+}
+
diff --git a/arch/mips/powertv/pci/pcieregs.h b/arch/mips/powertv/pci/pcieregs.h
new file mode 100644
index 0000000..3200256
--- /dev/null
+++ b/arch/mips/powertv/pci/pcieregs.h
@@ -0,0 +1,333 @@
+/* ----------------------------------------------------------------------------
+ *                            PCIE Module
+ *
+ * Copyright (C) 2000-2009 Scientific-Atlanta, Inc.
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
+ * ----------------------------------------------------------------------------
+ *
+ * File Name:    pcieregs.h
+ *
+ * Project:      NGP
+ *
+ * Compiler:     gnu C (gcc)
+ *
+ * Author(s):    Tom Haman
+ *
+ * Description:  This header file defines the registers for the PCIE
+ *               section of the Zeus Asic.
+ *
+ * Documents:    PCIE Software Design Document
+ *
+ * NOTES:
+ *
+ * ----------------------------------------------------------------------------
+ * History:
+ * Rev Level    Date    Name         ECN#    Description
+ * ----------------------------------------------------------------------------
+ * 1.00       02/15/06  Tom Haman     ---    Initial version for NGP (Zeus)
+ * ----------------------------------------------------------------------------
+ */
+
+#ifndef _PCIE_REGS_H_
+#define  _PCIE_REGS_H_
+
+#define PCIE_PLL_FIX
+#ifdef PCIE_PLL_FIX
+/* if PCIE_PLL_FIX is defined, then apply workaround to allow
+ * PCIe PHY layer to be reset after new PLL value has been loaded.
+ * subsequent versions of Zeus will have proper PLL default value
+ * set so that this will not be necessary. */
+
+/* TESTBUS Registers */
+#define kSCR_DEPTH 640
+
+struct tTBRegs {
+	u32 TEST_BUS_GPIO_CTL;	/* 091A0238 */
+	u32 TEST_BUS_GPIO;	/* 091A023C */
+};
+#endif
+
+/* PCIE Registers, Offsets and Bit Definitions */
+struct tPCIERegs {
+	u32 PCIX_CFG_SPACE_FUNC0[1024]; /*09200000 thru 09200FFF */
+	u32 PCIX_CFG_SPACE_FUNC1[1024]; /*09201000 thru 09201FFF */
+	u32 PCIX_CFG_SPACE_FUNC2[1024]; /*09202000 thru 09202FFF */
+	u32 PCIX_CFG_SPACE_FUNC3[1024]; /*09203000 thru 09203FFF */
+
+	u32 filler1[4096];		/*09204000 thru 09207FFF */
+
+	u32 PCIX_ACC_BAR0[1024];	/*09208000 thru 09208FFF */
+	u32 PCIX_ACC_BAR1[1024];	/*09209000 thru 09209FFF */
+	u32 PCIX_ACC_BAR2[1024];	/*0920A000 thru 0920AFFF */
+	u32 PCIX_ACC_BAR3[1024];	/*0920B000 thru 0920BFFF */
+
+	u32 filler2[4096];		/*0920C000 thru 0920FFFF */
+
+	u32 PCIX_CTL1;			/*09210000 */
+	u32 PCIX_TRGT0_EN;		/*09210004 */
+	u32 PCIX_CLIENT0_ADDR_ALIGN_EN; /*09210008 */
+	u32 PCIX_CLIENT0_TLPREQID;	/*0921000C */
+	u32 PCIX_CLIENT0_TLP_ADEOT;	/*09210010 */
+	u32 PCIX_CLIENT0_TLPTC;		/*09210014 */
+	u32 PCIX_CLIENT0_TLPEP;		/*09210018 */
+	u32 PCIX_CLIENT0_TLPATTR;	/*0921001C */
+	u32 PCIX_CLIENT0_TLPFUN;	/*09210020 */
+	u32 PCIX_CLIENT1_ADDR_ALIGN_EN; /*09210024 */
+	u32 PCIX_APP_UNLOCK;		/*09210028 */
+	u32 PCIX_CLIENT1_TLP_BADEOT;	/*0921002C */
+	u32 PCIX_APPREQ;		/*09210030 */
+	u32 PCIX_CLIENT1_TLPEP;		/*09210034 */
+	u32 PCIX_MEMRD_LOCKEN;		/*09210038 */
+	u32 PCIX_SYSCMD;		/*0921003C */
+	u32 PCIX_PHYCFG;		/*09210040 */
+	u32 PCIX_OUTBAND_PWRUP;		/*09210044 */
+	u32 PCIX_SYSINT;		/*09210048 */
+	u32 PCIX_SYSATTEN;		/*0921004C */
+	u32 PCIX_CLEAR_RST;		/*09210050 */
+	u32 PCIX_SOFT_RST;		/*09210054 */
+	u32 PCIX_MASKRISE_LOW;		/*09210058 */
+	u32 PCIX_MASKRISE_HIGH;		/*0921005C */
+	u32 PCIX_CLRRISE_LOW;		/*09210060 */
+	u32 PCIX_CLRRISE_HIGH;		/*09210064 */
+	u32 PCIX_MSKFALL;		/*09210068 */
+	u32 PCIX_CLRFALL;		/*0921006C */
+	u32 PCIX_MSKLEV;		/*09210070 */
+	u32 PCIX_CLRLEV;		/*09210074 */
+	u32 PCIX_ABORT;			/*09210078 */
+	u32 PCIX_APPINIT;		/*0921007C */
+	u32 PCIX_FUNC0_USERBAR0;	/*09210080 */
+	u32 PCIX_FUNC0_USERBAR2;	/*09210084 */
+	u32 PCIX_FUNC0_USERBAR4;	/*09210088 */
+	u32 PCIX_FUNC0_USEREXP;		/*0921008C */
+	u32 PCIX_FUNC1_USERBAR0;	/*09210090 */
+	u32 PCIX_FUNC1_USERBAR2;	/*09210094 */
+	u32 PCIX_FUNC1_USERBAR4;	/*09210098 */
+	u32 PCIX_FUNC1_USEREXP;		/*0921009C */
+	u32 PCIX_FUNC2_USERBAR0;	/*092100A0 */
+	u32 PCIX_FUNC2_USERBAR2;	/*092100A4 */
+	u32 PCIX_FUNC2_USERBAR4;	/*092100A8 */
+	u32 PCIX_FUNC2_USEREXP;		/*092100AC */
+	u32 PCIX_FUNC3_USERBAR0;	/*092100B0 */
+	u32 PCIX_FUNC3_USERBAR2;	/*092100B4 */
+	u32 PCIX_FUNC3_USERBAR4;	/*092100B8 */
+	u32 PCIX_FUNC3_USEREXP;		/*092100BC */
+	u32 PCIX_T3TARG_BASE0;		/*092100C0 */
+	u32 PCIX_T3TARG_BASE1;		/*092100C4 */
+	u32 PCIX_T3TARG_BASE2;		/*092100C8 */
+	u32 PCIX_T3TARG_BASE3;		/*092100CC */
+	u32 PCIX_T3TARG_WIN0;		/*092100D0 */
+	u32 PCIX_T3TARG_WIN1;		/*092100D4 */
+	u32 PCIX_T3TARG_WIN2;		/*092100D8 */
+	u32 PCIX_T3TARG_WIN3;		/*092100DC */
+	u32 filler3[8];			/*092100E0 thru 092100FF */
+	u32 PCIE_RC_CFG_MODE;		/*09210100 */
+	u32 PCIE_RC_CFG_SETUP1;		/*09210104 */
+	u32 PCIE_RC_CFG_SETUP2;		/*09210108 */
+	u32 PCIE_RC_CFG_WRITE_DATA;	/*0921010C */
+	u32 PCIE_RC_CFG_STAT;		/*09210110 */
+	u32 PCIE_RC_CFG_CPL_DATA;	/*09210114 */
+	u32 PCIE_RC_CFG_CPLID;		/*09210118 */
+	u32 filler4;			/*0921011C */
+	u32 PCIX_RISING_EVENT_LOW;	/*09210120 */
+	u32 PCIX_RISING_EVENT_HIGH;	/*09210124 */
+	u32 PCIX_FALLING_EVENT;		/*09210128 */
+	u32 PCIX_LEVEL_EVENT;		/*0921012C */
+	u32 PCIX_PHY_CONT_DATA1;	/*09210130 */
+	u32 PCIX_PHY_CONT_DATA2;	/*09210134 */
+	u32 PCIX_PHY_READ_BACK;		/*09210138 */
+	u32 PCIX_APPS_PM;		/*0921013C */
+	u32 PCIX_INT_EN;		/*09210140 */
+	u32 PCIX_MASKRISE_LOW2;		/*09210144 */
+	u32 PCIX_MASKRISE_HIGH2;	/*09210148 */
+	u32 PCIX_CLRRISE_LOW2;		/*0921014C */
+	u32 PCIX_CLRRISE_HIGH2;		/*09210150 */
+	u32 PCIX_MSKFALL2;		/*09210154 */
+	u32 PCIX_CLRFALL2;		/*09210158 */
+	u32 PCIX_MSKLEV2;		/*0921015C */
+	u32 PCIX_CLRLEV2;		/*09210160 */
+	u32 PCIX_RISING_EVENT_LOW2;	/*09210164 */
+	u32 PCIX_RISING_EVENT_HIGH2;	/*09210168 */
+	u32 PCIX_FALLING_EVENT2;	/*0921016C */
+	u32 PCIX_LEVEL_EVENT2;		/*09210170 */
+	u32 PCIX_CFG_PBUS_NUM;		/*09210174 */
+	u32 PCIX_CFG_PBUS_DEVNUM;	/*09210178 */
+	u32 PCIX_PMSTAT;		/*0921017C */
+	u32 PCIX_RADM;			/*09210180 */
+	u32 PCIX_MSI_EN1;		/*09210184 */
+	u32 PCIX_MSIADDR1_LOW;		/*09210188 */
+	u32 PCIX_MSIADDR1_HIGH;		/*0921018C */
+	u32 PCIX_MSIDATA1;		/*09210190 */
+	u32 PCIX_MSI_EN2;		/*09210194 */
+	u32 PCIX_MSIADDR2_LOW;		/*09210198 */
+	u32 PCIX_MSIADDR2_HIGH;		/*0921019C */
+	u32 PCIX_MSIDATA2;		/*092101A0 */
+	u32 PCIX_TESTBUS;		/*092101A4 */
+	u32 PCIX_MSIX_ADDR_LOW;		/*092101A8 */
+	u32 PCIX_MSIX_ADDR_HIGH;	/*092101AC */
+	u32 PCIX_MSIXDATA;		/*092101B0 */
+	u32 PCIX_MSIX_EN;		/*092101B4 */
+	u32 PCIX_AER_INT_MSGNUM;	/*092101B8 */
+	u32 PCIX_CAP_INT_MSTNUM;	/*092101BC */
+	u32 PCIX_EMLCONT;		/*092101C0 */
+	u32 filler5[143];		/*092101C4 thru 092103FF */
+	u32 PCIX_CFG_PHY_CONT0;		/*09210400 */
+	u32 filler6[3];			/*09210404 thru 0921040F */
+	u32 PCIX_CFG_BAR0_START_0;	/*09210410 */
+	u32 PCIX_CFG_BAR0_START_1;	/*09210414 */
+	u32 PCIX_CFG_BAR0_START_2;	/*09210418 */
+	u32 PCIX_CFG_BAR0_START_3;	/*0921041C */
+	u32 PCIX_CFG_BAR0_START_4;	/*09210420 */
+	u32 PCIX_CFG_BAR0_START_5;	/*09210424 */
+	u32 PCIX_CFG_BAR0_START_6;	/*09210428 */
+	u32 PCIX_CFG_BAR0_START_7;	/*0921042C */
+	u32 PCIX_CFG_BAR0_LIMIT_0;	/*09210430 */
+	u32 filler7;			/*09210434 */
+	u32 PCIX_CFG_BAR0_LIMIT_2;	/*09210438 */
+	u32 PCIX_CFG_BAR0_LIMIT_3;	/*0921043C */
+	u32 PCIX_CFG_BAR0_LIMIT_4;	/*09210440 */
+	u32 PCIX_CFG_BAR0_LIMIT_5;	/*09210444 */
+	u32 PCIX_CFG_BAR0_LIMIT_6;	/*09210448 */
+	u32 PCIX_CFG_BAR0_LIMIT_7;	/*0921044C */
+	u32 PCIX_CFG_BAR1_START_0;	/*09210450 */
+	u32 PCIX_CFG_BAR1_START_1;	/*09210454 */
+	u32 PCIX_CFG_BAR1_START_2;	/*09210458 */
+	u32 PCIX_CFG_BAR1_START_3;	/*0921045C */
+	u32 PCIX_CFG_BAR1_START_4;	/*09210460 */
+	u32 PCIX_CFG_BAR1_START_5;	/*09210464 */
+	u32 PCIX_CFG_BAR1_START_6;	/*09210468 */
+	u32 PCIX_CFG_BAR1_START_7;	/*0921046C */
+	u32 PCIX_CFG_BAR1_LIMIT_0;	/*09210470 */
+	u32 PCIX_CFG_BAR1_LIMIT_1;	/*09210474 */
+	u32 PCIX_CFG_BAR1_LIMIT_2;	/*09210478 */
+	u32 PCIX_CFG_BAR1_LIMIT_3;	/*0921047C */
+	u32 PCIX_CFG_BAR1_LIMIT_4;	/*09210480 */
+	u32 PCIX_CFG_BAR1_LIMIT_5;	/*09210484 */
+	u32 PCIX_CFG_BAR1_LIMIT_6;	/*09210488 */
+	u32 PCIX_CFG_BAR1_LIMIT_7;	/*0921048C */
+	u32 PCIX_CFG_EXP_ROM_START_0;	/*09210490 */
+	u32 PCIX_CFG_EXP_ROM_START_1;	/*09210494 */
+	u32 PCIX_CFG_EXP_ROM_START_2;	/*09210498 */
+	u32 PCIX_CFG_EXP_ROM_START_3;	/*0921049C */
+	u32 PCIX_CFG_EXP_ROM_LIMIT_0;	/*092104A0 */
+	u32 PCIX_CFG_EXP_ROM_LIMIT_1;	/*092104A4 */
+	u32 PCIX_CFG_EXP_ROM_LIMIT_2;	/*092104A8 */
+	u32 PCIX_CFG_EXP_ROM_LIMIT_3;	/*092104AC */
+	u32 PCIX_XLMH_STATE;		/*092104B0 */
+	u32 PCIX_RDLH_LINK;		/*092104B4 */
+	u32 PCIX_CFG_BUS_MSTR;		/*092104B8 */
+	u32 PCIX_CFG_MEM;		/*092104BC */
+	u32 PCIX_CFG_MSI;		/*092104C0 */
+	u32 PCIX_CFG_MAX;		/*092104C4 */
+	u32 filler8;			/*092104C8 */
+	u32 PCIX_PM_CURST;		/*092104CC */
+	u32 PCIX_RADM_MSGCTL;		/*092104D0 */
+	u32 PCIX_RADM_MSGPAY;		/*092104D4 */
+	u32 PCIX_RADM_PWR;		/*092104D8 */
+	u32 filler9[2];			/*092104DC thru 092104E0 */
+	u32 PCIX_RADM_CORR;		/*092104E4 */
+	u32 PCIX_RTLH_UPD;		/*092104E8 */
+	u32 PCIX_RTLD_DATA;		/*092104EC */
+	u32 PCIX_CXPL_DEBUGLO;		/*092104F0 */
+	u32 PCIX_CXPL_DEBUGHI;		/*092104F4 */
+	u32 PCIX_RADM_CPL_0;		/*092104F8 */
+	u32 PCIX_RADM_CPL_1;		/*092104FC */
+	u32 PCIX_RADM_CPL_2;		/*09210500 */
+	u32 PCIX_RADM_CPL_3;		/*09210504 */
+	u32 PCIX_CFG_RCB;		/*09210508 */
+	u32 filler10[7872];		/*0921050C thru 09218000 */
+	u32 PCIX_VEN_MSG_STAT1;		/*0921800C */
+	u32 PCIX_VEN_MSG_DATALO;	/*09218010 */
+	u32 PCIX_VEN_MSG_DATAHI;	/*09218014 */
+};
+
+/*PCIX_PHY_READ_BACK bits */
+#define kPCIX_PHY_READ_BACK_PllLock       0x01
+#define kPCIX_PHY_READ_BACK_Ready         0x02
+
+/*PCIX_CTL1 bits */
+#define kPCIX_CTL1_PCIE_TLP_ENABLE        0x0002
+#define kPCIX_CTL1_PCIE_FUNC0             0x0040
+#define kPCIX_CTL1_PCIE_ROOT_COMPLEX      0x0010
+#define kPCIX_CTL1_PCIE_SEL_CLOCK         0x1000
+#define kPCIX_CTL1_PCIE_LTSSM             0x0400
+#define kPCIX_CTL1_PCI_ENAB_INTS          0x0800
+
+/*PCIX_RDLH_LINK bits */
+#define kPCIX_RDLH_LINK_RdlhUp            0x01
+
+/*PCIE_RC_CFG_SETUP1 */
+#define kPCIE_RC_CFG_SETUP1_CFG_ENAB_ALL_BYTES 0x78
+#define kPCIE_RC_CFG_SETUP1_CFG_READ           0x01
+#define kPCIE_RC_CFG_SETUP1_CFG_WRITE          0x03
+#define kPCIE_RC_CFG_SETUP1_TYPE0              0x00
+#define kPCIE_RC_CFG_SETUP1_TYPE1              0x01
+
+/*Interrupt bits */
+#define kPCIX_IntLow_cfg_sys_err_rc3             0x80000000
+#define kPCIX_IntLow_cfg_sys_err_rc2             0x40000000
+#define kPCIX_IntLow_cfg_sys_err_rc1             0x20000000
+#define kPCIX_IntLow_cfg_sys_err_rc0             0x10000000
+#define kPCIX_IntLow_radm_cpl_hv                 0x08000000
+#define kPCIX_IntLow_radm_cpl_dllp_abort         0x04000000
+#define kPCIX_IntLow_radm_cpl_tlp_abort          0x02000000
+#define kPCIX_IntLow_radm_cpl_ecrc_err           0x01000000
+#define kPCIX_IntLow_radm_cpl_eot                0x00800000
+#define kPCIX_IntLow_radm_cpl_last               0x00400000
+#define kPCIX_IntLow_radm_cpl_timeout            0x00200000
+#define kPCIX_IntLow_radm_trgt1_hv               0x00100000
+#define kPCIX_IntLow_radm_trgt1_eot              0x00080000
+#define kPCIX_IntLow_training_rst_n              0x00040000
+#define kPCIX_IntLow_rtlh_rfc_upd                0x00020000
+#define kPCIX_IntLow_pm_xtlh_block_tlp           0x00010000
+#define kPCIX_IntLow_cfg_aer_rc_err_int3         0x00008000
+#define kPCIX_IntLow_cfg_aer_rc_err_int2         0x00004000
+#define kPCIX_IntLow_cfg_aer_rc_err_int1         0x00002000
+#define kPCIX_IntLow_cfg_aer_rc_err_int0         0x00001000
+#define kPCIX_IntLow_rdlh_link_up                0x00000800
+#define kPCIX_IntLow_radm_vendor_msg             0x00000400
+#define kPCIX_IntLow_radm_msg_unlock             0x00000200
+#define kPCIX_IntLow_radm_inta_asserted          0x00000100
+#define kPCIX_IntLow_radm_intb_asserted          0x00000080
+#define kPCIX_IntLow_radm_intc_asserted          0x00000040
+#define kPCIX_IntLow_radm_intd_asserted          0x00000020
+#define kPCIX_IntLow_radm_correctable_err        0x00000010
+#define kPCIX_IntLow_radm_nonfatal_err           0x00000008
+#define kPCIX_IntLow_radm_fatal_err              0x00000004
+#define kPCIX_IntLow_radm_att_button_pressed     0x00000002
+#define kPCIX_IntLow_radm_pm_pme                 0x00000001
+
+#define kPCIX_IntHigh_radm_pm_to_ack             0x00020000
+#define kPCIX_IntHigh_xmlh_link_up               0x00010000
+#define kPCIX_IntHigh_wake_n                     0x00008000
+#define kPCIX_IntHigh_cfg_bus_master_en3         0x00004000
+#define kPCIX_IntHigh_cfg_bus_master_en2         0x00002000
+#define kPCIX_IntHigh_cfg_bus_master_en1         0x00001000
+#define kPCIX_IntHigh_cfg_bus_master_en0         0x00000800
+#define kPCIX_IntHigh_radm_inta_deasserted       0x00000400
+#define kPCIX_IntHigh_radm_intb_deasserted       0x00000200
+#define kPCIX_IntHigh_radm_intc_deasserted       0x00000100
+#define kPCIX_IntHigh_radm_intd_deasserted       0x00000080
+#define kPCIX_IntHigh_radm_att_ind_on            0x00000040
+#define kPCIX_IntHigh_radm_att_ind_blink         0x00000020
+#define kPCIX_IntHigh_radm_att_ind_off           0x00000010
+#define kPCIX_IntHigh_radm_pwr_ind_on            0x00000008
+#define kPCIX_IntHigh_radm_pwr_ind_blink         0x00000004
+#define kPCIX_IntHigh_radm_pwr_ind_off           0x00000002
+#define kPCIX_IntHigh_radm_cpl_error_int         0x00000001
+
+#endif	/* _PCIE_REGS_H_ */
+
diff --git a/arch/mips/powertv/pci/powertv-pci.h b/arch/mips/powertv/pci/powertv-pci.h
new file mode 100644
index 0000000..98c087e
--- /dev/null
+++ b/arch/mips/powertv/pci/powertv-pci.h
@@ -0,0 +1,12 @@
+/*
+ * Local definitions for the powertv PCI code
+ */
+
+#ifndef	_POWERTV_PCI_H_
+#define	_POWERTV_PCI_H_
+extern int asic_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
+extern int asic_pcie_init(void);
+extern int asic_pcie_init(void);
+
+extern int LogLevel;
+#endif
diff --git a/arch/mips/powertv/powertv-clock.h b/arch/mips/powertv/powertv-clock.h
new file mode 100644
index 0000000..6f8c17b
--- /dev/null
+++ b/arch/mips/powertv/powertv-clock.h
@@ -0,0 +1,10 @@
+/*
+ * Definitions for clocks
+ */
+
+#ifndef _POWERTV_CLOCK_H
+#define _POWERTV_CLOCK_H
+extern int powertv_clockevent_init(void);
+extern void powertv_clocksource_init(void);
+extern unsigned int mips_get_pll_freq(void);
+#endif
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
new file mode 100644
index 0000000..f19f36f
--- /dev/null
+++ b/arch/mips/powertv/powertv_setup.c
@@ -0,0 +1,351 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
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
+#define	VAL(n)		STR(n)
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
+#define	LONG_L		"ld	"
+#define	PTR_ADDIU	"daddiu	"
+#define	REG_SIZE	"8"		/* In bytes */
+#endif
+
+#ifdef CONFIG_32BIT
+#define PTR_LA		"la	"
+#define LONG_S		"sw	"
+#define	LONG_L		"lw	"
+#define	PTR_ADDIU	"addiu	"
+#define	REG_SIZE	"4"		/* In bytes */
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
+	mips_pcibios_init();
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
+static int panic_handler (struct notifier_block *notifier_block,
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
+#define	NUM_RANDOM_BYTES		2
+#define	NON_SCIATL_OUI_BITS		0xc0u
+#define	MAC_ADDR_LOCALLY_MANAGED	(1 << 1)
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
+		addr[0] = NON_SCIATL_OUI_BITS | MAC_ADDR_LOCALLY_MANAGED;
+
+		/* Get some bytes of random address information */
+		get_random_bytes(&addr[1], NUM_RANDOM_BYTES);
+
+		/* Copy over the NIC-specific bits of the RF MAC address */
+		for (i = 1 + NUM_RANDOM_BYTES; i < ETH_ALEN; i++)
+			addr[i] = rfmac[i];
+	}
+#undef	NON_RANDOM_BYTES
+#undef	NON_SCIATL_OUI_BITS
+#undef	MAC_ADDR_LOCALLY_MANAGED
+}
diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
new file mode 100644
index 0000000..9756090
--- /dev/null
+++ b/arch/mips/powertv/reset.c
@@ -0,0 +1,69 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
+	writel(0x1, asic_reg_addr(Watchdog));
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
+	writel(0x1, asic_reg_addr(Watchdog));
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
index 0000000..79211ce
--- /dev/null
+++ b/arch/mips/powertv/reset.h
@@ -0,0 +1,8 @@
+/*
+ * Definitions from powertv reset.c file
+ */
+
+#ifndef _POWERTV_RESET_H
+#define _POWERTV_RESET_H
+extern void mips_reboot_setup(void);
+#endif
diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
new file mode 100644
index 0000000..b5806e5
--- /dev/null
+++ b/arch/mips/powertv/time.c
@@ -0,0 +1,47 @@
+/*
+ * Carsten Langgaard, carstenl@mips.com
+ * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <linux/hardirq.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+#include <linux/cpu.h>
+#include <linux/time.h>
+
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+
+#include "powertv-clock.h"
+
+void __init plat_time_init(void)
+{
+	powertv_clocksource_init();
+	powertv_clockevent_init();
+}
