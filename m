Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:21:50 +0100 (CET)
Received: from mail-la0-f53.google.com ([209.85.215.53]:64944 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011812AbaJ1XTMMaGD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:12 +0100
Received: by mail-la0-f53.google.com with SMTP id mc6so1547026lab.26
        for <multiple recipients>; Tue, 28 Oct 2014 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wW5X+a1UYXy5Y1Bkw1P/7rGnqV+x+urqDHInDYIyj7I=;
        b=iV0tGCh2yOAHjZ/CfkHyziYO08Ej8+QZtSffEVfhHCZQUByg/iAfu2xuXhC3lz6e3J
         anU1lGC1Z5v1YlVlZBilkjLhF1R3k9BqGsfhBEzDCMdht1gqWEqJRtMld7IdgTcCKRMF
         aRvR5LR8rQtVTbl6b5JsfYomJ5IlYJButx1zho5T2UWl4oI7CQXAOBEIR8ibAX1kZE2L
         VN3ItrFP5UoEQfvVSuvXhM4ql8zG3WAYBtE/pw740lfNsjpNHXJ+VQg/a+5HyaHptycR
         wYB/+08gObs9TB8iLGm7cAsb3FUnmj8716E/dgw3DTFY/8QRKVRvfOkCbGO1AdvYbY7S
         o/WA==
X-Received: by 10.152.203.139 with SMTP id kq11mr7412784lac.63.1414538344527;
        Tue, 28 Oct 2014 16:19:04 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.19.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:19:03 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 10/13] MIPS: ath25: add AR2315 PCI host controller driver
Date:   Wed, 29 Oct 2014 03:18:47 +0400
Message-Id: <1414538330-5548-11-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add PCI host controller driver and DMA address calculation hook.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since RFC:
  - use dynamic IRQ numbers allocation

Changes since v1:
  - rename MIPS machine ar231x -> ath25

Changes since v2:
  - fix a typo inside the PCI controller features description
  - add state container instead of set of static variables
  - truely remap the PCI controller MMR (avoid KSEG1ADDR usage)
  - pass memory regions via platform device resources
  - move AHB related configuration to arch code
  - move PCI related stuff from the common header to PCI host driver
  - use irq_domain

 arch/mips/ath25/Kconfig                          |   7 +
 arch/mips/ath25/ar2315.c                         |  57 +++
 arch/mips/include/asm/mach-ath25/dma-coherence.h |  24 +-
 arch/mips/pci/Makefile                           |   1 +
 arch/mips/pci/pci-ar2315.c                       | 511 +++++++++++++++++++++++
 5 files changed, 597 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/pci/pci-ar2315.c

diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
index ca3dde4..fc19dd5 100644
--- a/arch/mips/ath25/Kconfig
+++ b/arch/mips/ath25/Kconfig
@@ -7,3 +7,10 @@ config SOC_AR2315
 	bool "Atheros AR2315+ SoC support"
 	depends on ATH25
 	default y
+
+config PCI_AR2315
+	bool "Atheros AR2315 PCI controller support"
+	depends on SOC_AR2315
+	select HW_HAS_PCI
+	select PCI
+	default y
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 52805b7..f024789 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
@@ -133,6 +134,10 @@ static void ar2315_irq_dispatch(void)
 
 	if (pending & CAUSEF_IP3)
 		do_IRQ(AR2315_IRQ_WLAN0);
+#ifdef CONFIG_PCI_AR2315
+	else if (pending & CAUSEF_IP5)
+		do_IRQ(AR2315_IRQ_LCBUS_PCI);
+#endif
 	else if (pending & CAUSEF_IP2)
 		do_IRQ(AR2315_IRQ_MISC);
 	else if (pending & CAUSEF_IP7)
@@ -296,10 +301,62 @@ void __init ar2315_plat_mem_setup(void)
 	_machine_restart = ar2315_restart;
 }
 
+#ifdef CONFIG_PCI_AR2315
+static struct resource ar2315_pci_res[] = {
+	{
+		.name = "ar2315-pci-ctrl",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_PCI_BASE,
+		.end = AR2315_PCI_BASE + AR2315_PCI_SIZE - 1,
+	},
+	{
+		.name = "ar2315-pci-ext",
+		.flags = IORESOURCE_MEM,
+		.start = AR2315_PCI_EXT_BASE,
+		.end = AR2315_PCI_EXT_BASE + AR2315_PCI_EXT_SIZE - 1,
+	},
+	{
+		.name = "ar2315-pci",
+		.flags = IORESOURCE_IRQ,
+		.start = AR2315_IRQ_LCBUS_PCI,
+		.end = AR2315_IRQ_LCBUS_PCI,
+	},
+};
+#endif
+
 void __init ar2315_arch_init(void)
 {
 	unsigned irq = irq_create_mapping(ar2315_misc_irq_domain,
 					  AR2315_MISC_IRQ_UART0);
 
 	ath25_serial_setup(AR2315_UART0_BASE, irq, ar2315_apb_frequency());
+
+#ifdef CONFIG_PCI_AR2315
+	if (ath25_soc == ATH25_SOC_AR2315) {
+		/* Reset PCI DMA logic */
+		ar2315_rst_reg_mask(AR2315_RESET, 0, AR2315_RESET_PCIDMA);
+		msleep(20);
+		ar2315_rst_reg_mask(AR2315_RESET, AR2315_RESET_PCIDMA, 0);
+		msleep(20);
+
+		/* Configure endians */
+		ar2315_rst_reg_mask(AR2315_ENDIAN_CTL, 0, AR2315_CONFIG_PCIAHB |
+				    AR2315_CONFIG_PCIAHB_BRIDGE);
+
+		/* Configure as PCI host with DMA */
+		ar2315_rst_reg_write(AR2315_PCICLK, AR2315_PCICLK_PLLC_CLKM |
+				  (AR2315_PCICLK_IN_FREQ_DIV_6 <<
+				   AR2315_PCICLK_DIV_S));
+		ar2315_rst_reg_mask(AR2315_AHB_ARB_CTL, 0, AR2315_ARB_PCI);
+		ar2315_rst_reg_mask(AR2315_IF_CTL, AR2315_IF_PCI_CLK_MASK |
+				    AR2315_IF_MASK, AR2315_IF_PCI |
+				    AR2315_IF_PCI_HOST | AR2315_IF_PCI_INTR |
+				    (AR2315_IF_PCI_CLK_OUTPUT_CLK <<
+				     AR2315_IF_PCI_CLK_SHIFT));
+
+		platform_device_register_simple("ar2315-pci", -1,
+						ar2315_pci_res,
+						ARRAY_SIZE(ar2315_pci_res));
+	}
+#endif
 }
diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
index 8b3d0cc..d8009c9 100644
--- a/arch/mips/include/asm/mach-ath25/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ath25/dma-coherence.h
@@ -12,22 +12,40 @@
 
 #include <linux/device.h>
 
+/*
+ * We need some arbitrary non-zero value to be programmed to the BAR1 register
+ * of PCI host controller to enable DMA. The same value should be used as the
+ * offset to calculate the physical address of DMA buffer for PCI devices.
+ */
+#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
+
+static inline dma_addr_t ath25_dev_offset(struct device *dev)
+{
+#ifdef CONFIG_PCI
+	extern struct bus_type pci_bus_type;
+
+	if (dev && dev->bus == &pci_bus_type)
+		return AR2315_PCI_HOST_SDRAM_BASEADDR;
+#endif
+	return 0;
+}
+
 static inline dma_addr_t
 plat_map_dma_mem(struct device *dev, void *addr, size_t size)
 {
-	return virt_to_phys(addr);
+	return virt_to_phys(addr) + ath25_dev_offset(dev);
 }
 
 static inline dma_addr_t
 plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
-	return page_to_phys(page);
+	return page_to_phys(page) + ath25_dev_offset(dev);
 }
 
 static inline unsigned long
 plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
-	return dma_addr;
+	return dma_addr - ath25_dev_offset(dev);
 }
 
 static inline void
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 6523d55..ab6c857 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_PCI_AR2315)	+= pci-ar2315.o
 obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
 obj-$(CONFIG_PCI_AR724X)	+= pci-ar724x.o
 obj-$(CONFIG_MIPS_PCI_VIRTIO)	+= pci-virtio-guest.o
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
new file mode 100644
index 0000000..bd2b3b6
--- /dev/null
+++ b/arch/mips/pci/pci-ar2315.c
@@ -0,0 +1,511 @@
+/*
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/**
+ * Both AR2315 and AR2316 chips have PCI interface unit, which supports DMA
+ * and interrupt. PCI interface supports MMIO access method, but does not
+ * seem to support I/O ports.
+ *
+ * Read/write operation in the region 0x80000000-0xBFFFFFFF causes
+ * a memory read/write command on the PCI bus. 30 LSBs of address on
+ * the bus are taken from memory read/write request and 2 MSBs are
+ * determined by PCI unit configuration.
+ *
+ * To work with the configuration space instead of memory is necessary set
+ * the CFG_SEL bit in the PCI_MISC_CONFIG register.
+ *
+ * Devices on the bus can perform DMA requests via chip BAR1. PCI host
+ * controller BARs are programmend as if an external device is programmed.
+ * Which means that during configuration, IDSEL pin of the chip should be
+ * asserted.
+ *
+ * We know (and support) only one board that uses the PCI interface -
+ * Fonera 2.0g (FON2202). It has a USB EHCI controller connected to the
+ * AR2315 PCI bus. IDSEL pin of USB controller is connected to AD[13] line
+ * and IDSEL pin of AR2315 is connected to AD[16] line.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <asm/paccess.h>
+
+/*
+ * PCI Bus Interface Registers
+ */
+#define AR2315_PCI_1MS_REG		0x0008
+
+#define AR2315_PCI_1MS_MASK		0x3FFFF	/* # of AHB clk cycles in 1ms */
+
+#define AR2315_PCI_MISC_CONFIG		0x000c
+
+#define AR2315_PCIMISC_TXD_EN	0x00000001	/* Enable TXD for fragments */
+#define AR2315_PCIMISC_CFG_SEL	0x00000002	/* Mem or Config cycles */
+#define AR2315_PCIMISC_GIG_MASK	0x0000000C	/* bits 31-30 for pci req */
+#define AR2315_PCIMISC_RST_MODE	0x00000030
+#define AR2315_PCIRST_INPUT	0x00000000	/* 4:5=0 rst is input */
+#define AR2315_PCIRST_LOW	0x00000010	/* 4:5=1 rst to GND */
+#define AR2315_PCIRST_HIGH	0x00000020	/* 4:5=2 rst to VDD */
+#define AR2315_PCIGRANT_EN	0x00000000	/* 6:7=0 early grant en */
+#define AR2315_PCIGRANT_FRAME	0x00000040	/* 6:7=1 grant waits 4 frame */
+#define AR2315_PCIGRANT_IDLE	0x00000080	/* 6:7=2 grant waits 4 idle */
+#define AR2315_PCIGRANT_GAP	0x00000000	/* 6:7=2 grant waits 4 idle */
+#define AR2315_PCICACHE_DIS	0x00001000	/* PCI external access cache
+						 * disable */
+
+#define AR2315_PCI_OUT_TSTAMP		0x0010
+
+#define AR2315_PCI_UNCACHE_CFG		0x0014
+
+#define AR2315_PCI_IN_EN		0x0100
+
+#define AR2315_PCI_IN_EN0	0x01	/* Enable chain 0 */
+#define AR2315_PCI_IN_EN1	0x02	/* Enable chain 1 */
+#define AR2315_PCI_IN_EN2	0x04	/* Enable chain 2 */
+#define AR2315_PCI_IN_EN3	0x08	/* Enable chain 3 */
+
+#define AR2315_PCI_IN_DIS		0x0104
+
+#define AR2315_PCI_IN_DIS0	0x01	/* Disable chain 0 */
+#define AR2315_PCI_IN_DIS1	0x02	/* Disable chain 1 */
+#define AR2315_PCI_IN_DIS2	0x04	/* Disable chain 2 */
+#define AR2315_PCI_IN_DIS3	0x08	/* Disable chain 3 */
+
+#define AR2315_PCI_IN_PTR		0x0200
+
+#define AR2315_PCI_OUT_EN		0x0400
+
+#define AR2315_PCI_OUT_EN0	0x01	/* Enable chain 0 */
+
+#define AR2315_PCI_OUT_DIS		0x0404
+
+#define AR2315_PCI_OUT_DIS0	0x01	/* Disable chain 0 */
+
+#define AR2315_PCI_OUT_PTR		0x0408
+
+/* PCI interrupt status (write one to clear) */
+#define AR2315_PCI_ISR			0x0500
+
+#define AR2315_PCI_INT_TX	0x00000001	/* Desc In Completed */
+#define AR2315_PCI_INT_TXOK	0x00000002	/* Desc In OK */
+#define AR2315_PCI_INT_TXERR	0x00000004	/* Desc In ERR */
+#define AR2315_PCI_INT_TXEOL	0x00000008	/* Desc In End-of-List */
+#define AR2315_PCI_INT_RX	0x00000010	/* Desc Out Completed */
+#define AR2315_PCI_INT_RXOK	0x00000020	/* Desc Out OK */
+#define AR2315_PCI_INT_RXERR	0x00000040	/* Desc Out ERR */
+#define AR2315_PCI_INT_RXEOL	0x00000080	/* Desc Out EOL */
+#define AR2315_PCI_INT_TXOOD	0x00000200	/* Desc In Out-of-Desc */
+#define AR2315_PCI_INT_DESCMASK	0x0000FFFF	/* Desc Mask */
+#define AR2315_PCI_INT_EXT	0x02000000	/* Extern PCI INTA */
+#define AR2315_PCI_INT_ABORT	0x04000000	/* PCI bus abort event */
+
+/* PCI interrupt mask */
+#define AR2315_PCI_IMR			0x0504
+
+/* Global PCI interrupt enable */
+#define AR2315_PCI_IER			0x0508
+
+#define AR2315_PCI_IER_DISABLE		0x00	/* disable pci interrupts */
+#define AR2315_PCI_IER_ENABLE		0x01	/* enable pci interrupts */
+
+#define AR2315_PCI_HOST_IN_EN		0x0800
+#define AR2315_PCI_HOST_IN_DIS		0x0804
+#define AR2315_PCI_HOST_IN_PTR		0x0810
+#define AR2315_PCI_HOST_OUT_EN		0x0900
+#define AR2315_PCI_HOST_OUT_DIS		0x0904
+#define AR2315_PCI_HOST_OUT_PTR		0x0908
+
+/*
+ * PCI interrupts, which share IP5
+ * Keep ordered according to AR2315_PCI_INT_XXX bits
+ */
+#define AR2315_PCI_IRQ_EXT		25
+#define AR2315_PCI_IRQ_ABORT		26
+#define AR2315_PCI_IRQ_COUNT		27
+
+/* Arbitrary size of memory region to access the configuration space */
+#define AR2315_PCI_CFG_SIZE	0x00100000
+
+#define AR2315_PCI_HOST_SLOT	3
+#define AR2315_PCI_HOST_DEVID	((0xff18 << 16) | PCI_VENDOR_ID_ATHEROS)
+
+/* ??? access BAR */
+#define AR2315_PCI_HOST_MBAR0		0x10000000
+/* RAM access BAR */
+#define AR2315_PCI_HOST_MBAR1		AR2315_PCI_HOST_SDRAM_BASEADDR
+/* ??? access BAR */
+#define AR2315_PCI_HOST_MBAR2		0x30000000
+
+struct ar2315_pci_ctrl {
+	void __iomem *cfg_mem;
+	void __iomem *mmr_mem;
+	unsigned irq;
+	unsigned irq_ext;
+	struct irq_domain *domain;
+	struct pci_controller pci_ctrl;
+	struct resource mem_res;
+	struct resource io_res;
+};
+
+static inline struct ar2315_pci_ctrl *ar2315_pci_bus_to_apc(struct pci_bus *bus)
+{
+	struct pci_controller *hose = bus->sysdata;
+
+	return container_of(hose, struct ar2315_pci_ctrl, pci_ctrl);
+}
+
+static inline u32 ar2315_pci_reg_read(struct ar2315_pci_ctrl *apc, u32 reg)
+{
+	return __raw_readl(apc->mmr_mem + reg);
+}
+
+static inline void ar2315_pci_reg_write(struct ar2315_pci_ctrl *apc, u32 reg,
+					u32 val)
+{
+	__raw_writel(val, apc->mmr_mem + reg);
+}
+
+static inline void ar2315_pci_reg_mask(struct ar2315_pci_ctrl *apc, u32 reg,
+				       u32 mask, u32 val)
+{
+	u32 ret = ar2315_pci_reg_read(apc, reg);
+
+	ret &= ~mask;
+	ret |= val;
+	ar2315_pci_reg_write(apc, reg, ret);
+}
+
+static int ar2315_pci_cfg_access(struct ar2315_pci_ctrl *apc, unsigned devfn,
+				 int where, int size, u32 *ptr, bool write)
+{
+	int func = PCI_FUNC(devfn);
+	int dev = PCI_SLOT(devfn);
+	u32 addr = (1 << (13 + dev)) | (func << 8) | (where & ~3);
+	u32 mask = 0xffffffff >> 8 * (4 - size);
+	u32 sh = (where & 3) * 8;
+	u32 value, isr;
+
+	/* Prevent access past the remapped area */
+	if (addr >= AR2315_PCI_CFG_SIZE || dev > 18)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* Clear pending errors */
+	ar2315_pci_reg_write(apc, AR2315_PCI_ISR, AR2315_PCI_INT_ABORT);
+	/* Select Configuration access */
+	ar2315_pci_reg_mask(apc, AR2315_PCI_MISC_CONFIG, 0,
+			    AR2315_PCIMISC_CFG_SEL);
+
+	mb();	/* PCI must see space change before we begin */
+
+	value = __raw_readl(apc->cfg_mem + addr);
+
+	isr = ar2315_pci_reg_read(apc, AR2315_PCI_ISR);
+
+	if (isr & AR2315_PCI_INT_ABORT)
+		goto exit_err;
+
+	if (write) {
+		value = (value & ~(mask << sh)) | *ptr << sh;
+		__raw_writel(value, apc->cfg_mem + addr);
+		isr = ar2315_pci_reg_read(apc, AR2315_PCI_ISR);
+		if (isr & AR2315_PCI_INT_ABORT)
+			goto exit_err;
+	} else {
+		*ptr = (value >> sh) & mask;
+	}
+
+	goto exit;
+
+exit_err:
+	ar2315_pci_reg_write(apc, AR2315_PCI_ISR, AR2315_PCI_INT_ABORT);
+	if (!write)
+		*ptr = 0xffffffff;
+
+exit:
+	/* Select Memory access */
+	ar2315_pci_reg_mask(apc, AR2315_PCI_MISC_CONFIG, AR2315_PCIMISC_CFG_SEL,
+			    0);
+
+	return isr & AR2315_PCI_INT_ABORT ? PCIBIOS_DEVICE_NOT_FOUND :
+					    PCIBIOS_SUCCESSFUL;
+}
+
+static inline int ar2315_pci_local_cfg_rd(struct ar2315_pci_ctrl *apc,
+					  unsigned devfn, int where, u32 *val)
+{
+	return ar2315_pci_cfg_access(apc, devfn, where, sizeof(u32), val,
+				     false);
+}
+
+static inline int ar2315_pci_local_cfg_wr(struct ar2315_pci_ctrl *apc,
+					  unsigned devfn, int where, u32 val)
+{
+	return ar2315_pci_cfg_access(apc, devfn, where, sizeof(u32), &val,
+				     true);
+}
+
+static int ar2315_pci_cfg_read(struct pci_bus *bus, unsigned devfn, int where,
+			       int size, u32 *value)
+{
+	struct ar2315_pci_ctrl *apc = ar2315_pci_bus_to_apc(bus);
+
+	if (PCI_SLOT(devfn) == AR2315_PCI_HOST_SLOT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return ar2315_pci_cfg_access(apc, devfn, where, size, value, false);
+}
+
+static int ar2315_pci_cfg_write(struct pci_bus *bus, unsigned devfn, int where,
+				int size, u32 value)
+{
+	struct ar2315_pci_ctrl *apc = ar2315_pci_bus_to_apc(bus);
+
+	if (PCI_SLOT(devfn) == AR2315_PCI_HOST_SLOT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return ar2315_pci_cfg_access(apc, devfn, where, size, &value, true);
+}
+
+static struct pci_ops ar2315_pci_ops = {
+	.read	= ar2315_pci_cfg_read,
+	.write	= ar2315_pci_cfg_write,
+};
+
+static int ar2315_pci_host_setup(struct ar2315_pci_ctrl *apc)
+{
+	unsigned devfn = PCI_DEVFN(AR2315_PCI_HOST_SLOT, 0);
+	int res;
+	u32 id;
+
+	res = ar2315_pci_local_cfg_rd(apc, devfn, PCI_VENDOR_ID, &id);
+	if (res != PCIBIOS_SUCCESSFUL || id != AR2315_PCI_HOST_DEVID)
+		return -ENODEV;
+
+	/* Program MBARs */
+	ar2315_pci_local_cfg_wr(apc, devfn, PCI_BASE_ADDRESS_0,
+				AR2315_PCI_HOST_MBAR0);
+	ar2315_pci_local_cfg_wr(apc, devfn, PCI_BASE_ADDRESS_1,
+				AR2315_PCI_HOST_MBAR1);
+	ar2315_pci_local_cfg_wr(apc, devfn, PCI_BASE_ADDRESS_2,
+				AR2315_PCI_HOST_MBAR2);
+
+	/* Run */
+	ar2315_pci_local_cfg_wr(apc, devfn, PCI_COMMAND, PCI_COMMAND_MEMORY |
+				PCI_COMMAND_MASTER | PCI_COMMAND_SPECIAL |
+				PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
+				PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK);
+
+	return 0;
+}
+
+static void ar2315_pci_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	struct ar2315_pci_ctrl *apc = irq_get_handler_data(irq);
+	u32 pending = ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
+		      ar2315_pci_reg_read(apc, AR2315_PCI_IMR);
+	unsigned pci_irq = 0;
+
+	if (pending)
+		pci_irq = irq_find_mapping(apc->domain, __ffs(pending));
+
+	if (pci_irq)
+		generic_handle_irq(pci_irq);
+	else
+		spurious_interrupt();
+}
+
+static void ar2315_pci_irq_mask(struct irq_data *d)
+{
+	struct ar2315_pci_ctrl *apc = irq_data_get_irq_chip_data(d);
+
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IMR, BIT(d->hwirq), 0);
+}
+
+static void ar2315_pci_irq_mask_ack(struct irq_data *d)
+{
+	struct ar2315_pci_ctrl *apc = irq_data_get_irq_chip_data(d);
+	u32 m = BIT(d->hwirq);
+
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IMR, m, 0);
+	ar2315_pci_reg_write(apc, AR2315_PCI_ISR, m);
+}
+
+static void ar2315_pci_irq_unmask(struct irq_data *d)
+{
+	struct ar2315_pci_ctrl *apc = irq_data_get_irq_chip_data(d);
+
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IMR, 0, BIT(d->hwirq));
+}
+
+static struct irq_chip ar2315_pci_irq_chip = {
+	.name = "AR2315-PCI",
+	.irq_mask = ar2315_pci_irq_mask,
+	.irq_mask_ack = ar2315_pci_irq_mask_ack,
+	.irq_unmask = ar2315_pci_irq_unmask,
+};
+
+static int ar2315_pci_irq_map(struct irq_domain *d, unsigned irq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &ar2315_pci_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, d->host_data);
+	return 0;
+}
+
+static struct irq_domain_ops ar2315_pci_irq_domain_ops = {
+	.map = ar2315_pci_irq_map,
+};
+
+static void ar2315_pci_irq_init(struct ar2315_pci_ctrl *apc)
+{
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IER, AR2315_PCI_IER_ENABLE, 0);
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IMR, (AR2315_PCI_INT_ABORT |
+			    AR2315_PCI_INT_EXT), 0);
+
+	apc->irq_ext = irq_create_mapping(apc->domain, AR2315_PCI_IRQ_EXT);
+
+	irq_set_chained_handler(apc->irq, ar2315_pci_irq_handler);
+	irq_set_handler_data(apc->irq, apc);
+
+	/* Clear any pending Abort or external Interrupts
+	 * and enable interrupt processing */
+	ar2315_pci_reg_write(apc, AR2315_PCI_ISR, AR2315_PCI_INT_ABORT |
+						  AR2315_PCI_INT_EXT);
+	ar2315_pci_reg_mask(apc, AR2315_PCI_IER, 0, AR2315_PCI_IER_ENABLE);
+}
+
+static int ar2315_pci_probe(struct platform_device *pdev)
+{
+	struct ar2315_pci_ctrl *apc;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, err;
+
+	apc = devm_kzalloc(dev, sizeof(*apc), GFP_KERNEL);
+	if (!apc)
+		return -ENOMEM;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+	apc->irq = irq;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "ar2315-pci-ctrl");
+	apc->mmr_mem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(apc->mmr_mem))
+		return PTR_ERR(apc->mmr_mem);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "ar2315-pci-ext");
+	if (!res)
+		return -EINVAL;
+
+	apc->mem_res.name = "AR2315 PCI mem space";
+	apc->mem_res.parent = res;
+	apc->mem_res.start = res->start;
+	apc->mem_res.end = res->end;
+	apc->mem_res.flags = IORESOURCE_MEM;
+
+	/* Remap PCI config space */
+	apc->cfg_mem = devm_ioremap_nocache(dev, res->start,
+					    AR2315_PCI_CFG_SIZE);
+	if (!apc->cfg_mem) {
+		dev_err(dev, "failed to remap PCI config space\n");
+		return -ENOMEM;
+	}
+
+	/* Reset the PCI bus by setting bits 5-4 in PCI_MCFG */
+	ar2315_pci_reg_mask(apc, AR2315_PCI_MISC_CONFIG,
+			    AR2315_PCIMISC_RST_MODE,
+			    AR2315_PCIRST_LOW);
+	msleep(100);
+
+	/* Bring the PCI out of reset */
+	ar2315_pci_reg_mask(apc, AR2315_PCI_MISC_CONFIG,
+			    AR2315_PCIMISC_RST_MODE,
+			    AR2315_PCIRST_HIGH | AR2315_PCICACHE_DIS | 0x8);
+
+	ar2315_pci_reg_write(apc, AR2315_PCI_UNCACHE_CFG,
+			     0x1E | /* 1GB uncached */
+			     (1 << 5) | /* Enable uncached */
+			     (0x2 << 30) /* Base: 0x80000000 */);
+	ar2315_pci_reg_read(apc, AR2315_PCI_UNCACHE_CFG);
+
+	msleep(500);
+
+	err = ar2315_pci_host_setup(apc);
+	if (err)
+		return err;
+
+	apc->domain = irq_domain_add_linear(NULL, AR2315_PCI_IRQ_COUNT,
+					    &ar2315_pci_irq_domain_ops, apc);
+	if (!apc->domain) {
+		dev_err(dev, "failed to add IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	ar2315_pci_irq_init(apc);
+
+	/* PCI controller does not support I/O ports */
+	apc->io_res.name = "AR2315 IO space";
+	apc->io_res.start = 0;
+	apc->io_res.end = 0;
+	apc->io_res.flags = IORESOURCE_IO,
+
+	apc->pci_ctrl.pci_ops = &ar2315_pci_ops;
+	apc->pci_ctrl.mem_resource = &apc->mem_res,
+	apc->pci_ctrl.io_resource = &apc->io_res,
+
+	register_pci_controller(&apc->pci_ctrl);
+
+	dev_info(dev, "register PCI controller\n");
+
+	return 0;
+}
+
+static struct platform_driver ar2315_pci_driver = {
+	.probe = ar2315_pci_probe,
+	.driver = {
+		.name = "ar2315-pci",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init ar2315_pci_init(void)
+{
+	return platform_driver_register(&ar2315_pci_driver);
+}
+arch_initcall(ar2315_pci_init);
+
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct ar2315_pci_ctrl *apc = ar2315_pci_bus_to_apc(dev->bus);
+
+	return slot ? 0 : apc->irq_ext;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
-- 
1.8.5.5
