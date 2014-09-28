Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:35:11 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64840 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010020AbaI1SbeP0Nu3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:34 +0200
Received: by mail-lb0-f177.google.com with SMTP id w7so21249lbi.22
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ybiVjQO3RoEFQmbACEF981NYjbBkFveDUTGawLoeNc=;
        b=denBzr2IfZlfpG52UqjwuIufPcVR1dKWHTCVAR82QTFPIecKCzRyRm8SxvNUKPufyy
         epoX6kwuuyQZowAepNMGvCKaPdW5p6lh5VLz8wli+b7OYXRK9g4iY2cX8cOel32TtvFT
         ynX2nJ52LkghGEJN1GkIKV2GOEE0oFxkerbrK3F8iTXwXHaf/T0hHZy3JVkX+SuyuEqJ
         VVU3cNBAdtdCfnIrQBknR/ycmFBDXbAMqaAO7nS8gC+g4qL5JSPu0s4itmpja3Fc9Bwu
         T8XUwB8grZXtq18R8YnaSox9m8eLu6IquRb5gPXo8RkSucuX3r/8TcvxvJnfR0Vi1rUX
         6LFw==
X-Received: by 10.152.19.225 with SMTP id i1mr34302887lae.21.1411929088843;
        Sun, 28 Sep 2014 11:31:28 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:28 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 14/16] MIPS: ar231x: add AR2315 PCI host controller driver
Date:   Sun, 28 Sep 2014 22:33:13 +0400
Message-Id: <1411929195-23775-15-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42865
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

 arch/mips/ar231x/Kconfig                          |   7 +
 arch/mips/ar231x/ar2315.c                         |   9 +
 arch/mips/include/asm/mach-ar231x/ar2315_regs.h   |  23 ++
 arch/mips/include/asm/mach-ar231x/dma-coherence.h |  18 +-
 arch/mips/pci/Makefile                            |   1 +
 arch/mips/pci/pci-ar2315.c                        | 353 ++++++++++++++++++++++
 6 files changed, 408 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/pci/pci-ar2315.c

diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
index 88ca061..f4bf354 100644
--- a/arch/mips/ar231x/Kconfig
+++ b/arch/mips/ar231x/Kconfig
@@ -9,3 +9,10 @@ config SOC_AR2315
 	depends on AR231X
 	select GPIO_AR2315
 	default y
+
+config PCI_AR2315
+	bool "Atheros AR2315 PCI controller support"
+	depends on SOC_AR2315
+	select HW_HAS_PCI
+	select PCI
+	default y
diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index dab9992..0d50718 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -108,6 +108,10 @@ static void ar2315_irq_dispatch(void)
 
 	if (pending & CAUSEF_IP3)
 		do_IRQ(AR2315_IRQ_WLAN0);
+#ifdef CONFIG_PCI_AR2315
+	else if (pending & CAUSEF_IP5)
+		do_IRQ(AR2315_IRQ_LCBUS_PCI);
+#endif
 	else if (pending & CAUSEF_IP2)
 		do_IRQ(AR2315_IRQ_MISC);
 	else if (pending & CAUSEF_IP7)
@@ -371,5 +375,10 @@ void __init ar2315_arch_init(void)
 
 	ar231x_serial_setup(AR2315_UART0, ar2315_misc_irq_base +
 			    AR2315_MISC_IRQ_UART0, ar2315_apb_frequency());
+
+#ifdef CONFIG_PCI_AR2315
+	if (ar231x_devtype == DEV_TYPE_AR2315)
+		platform_device_register_simple("ar2315-pci", -1, NULL, 0);
+#endif
 }
 
diff --git a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
index ab64560..b620ec4 100644
--- a/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
+++ b/arch/mips/include/asm/mach-ar231x/ar2315_regs.h
@@ -38,6 +38,15 @@
 #define AR2315_MISC_IRQ_COUNT		9
 
 /*
+ * PCI interrupts, which share IP5
+ * Keep ordered according to AR2315_PCI_INT_XXX bits
+ */
+#define AR2315_PCI_IRQ_EXT		0
+#define AR2315_PCI_IRQ_ABORT		1
+#define AR2315_PCI_IRQ_COUNT		2
+#define AR2315_PCI_IRQ_SHIFT		25	/* in AR2315_PCI_INT_STATUS */
+
+/*
  * Address map
  */
 #define AR2315_SPI_READ		0x08000000	/* SPI flash */
@@ -554,4 +563,18 @@
 #define AR2315_IRCFG_SEQ_END_WIN_THRESH	0x001f0000
 #define AR2315_IRCFG_NUM_BACKOFF_WORDS	0x01e00000
 
+/*
+ * We need some arbitrary non-zero value to be programmed to the BAR1 register
+ * of PCI host controller to enable DMA. The same value should be used as the
+ * offset to calculate the physical address of DMA buffer for PCI devices.
+ */
+#define AR2315_PCI_HOST_SDRAM_BASEADDR	0x20000000
+
+/* ??? access BAR */
+#define AR2315_PCI_HOST_MBAR0		0x10000000
+/* RAM access BAR */
+#define AR2315_PCI_HOST_MBAR1		AR2315_PCI_HOST_SDRAM_BASEADDR
+/* ??? access BAR */
+#define AR2315_PCI_HOST_MBAR2		0x30000000
+
 #endif /* __ASM_MACH_AR231X_AR2315_REGS_H */
diff --git a/arch/mips/include/asm/mach-ar231x/dma-coherence.h b/arch/mips/include/asm/mach-ar231x/dma-coherence.h
index ed32240..90065c1 100644
--- a/arch/mips/include/asm/mach-ar231x/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ar231x/dma-coherence.h
@@ -11,23 +11,35 @@
 #define __ASM_MACH_AR231X_DMA_COHERENCE_H
 
 #include <linux/device.h>
+#include <ar2315_regs.h>
+
+static inline dma_addr_t ar231x_dev_offset(struct device *dev)
+{
+#ifdef CONFIG_PCI
+	extern struct bus_type pci_bus_type;
+
+	if (dev && dev->bus == &pci_bus_type)
+		return AR2315_PCI_HOST_SDRAM_BASEADDR;
+#endif
+	return 0;
+}
 
 static inline dma_addr_t
 plat_map_dma_mem(struct device *dev, void *addr, size_t size)
 {
-	return virt_to_phys(addr);
+	return virt_to_phys(addr) + ar231x_dev_offset(dev);
 }
 
 static inline dma_addr_t
 plat_map_dma_mem_page(struct device *dev, struct page *page)
 {
-	return page_to_phys(page);
+	return page_to_phys(page) + ar231x_dev_offset(dev);
 }
 
 static inline unsigned long
 plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
-	return dma_addr;
+	return dma_addr - ar231x_dev_offset(dev);
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
index 0000000..cfbb7a1
--- /dev/null
+++ b/arch/mips/pci/pci-ar2315.c
@@ -0,0 +1,353 @@
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
+ * and IDSEL pin of AR125 is connected to AD[16] line.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <asm/paccess.h>
+#include <ar231x_platform.h>
+#include <ar231x.h>
+#include <ar2315_regs.h>
+
+/* Arbitrary size of memory region to access the configuration space */
+#define AR2315_PCI_CFG_SIZE	0x00100000
+
+#define AR2315_PCI_HOST_SLOT	3
+#define AR2315_PCI_HOST_DEVID	((0xff18 << 16) | PCI_VENDOR_ID_ATHEROS)
+
+static void __iomem *ar2315_pci_cfg_mem;
+static unsigned ar2315_pci_irq_base;
+
+static int ar2315_pci_cfg_access(int devfn, int where, int size, u32 *ptr,
+				 bool write)
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
+	ar231x_write_reg(AR2315_PCI_ISR, AR2315_PCI_INT_ABORT);
+	/* Select Configuration access */
+	ar231x_mask_reg(AR2315_PCI_MISC_CONFIG, 0, AR2315_PCIMISC_CFG_SEL);
+
+	mb();	/* PCI must see space change before we begin */
+
+	value = __raw_readl(ar2315_pci_cfg_mem + addr);
+
+	isr = ar231x_read_reg(AR2315_PCI_ISR);
+	if (isr & AR2315_PCI_INT_ABORT)
+		goto exit_err;
+
+	if (write) {
+		value = (value & ~(mask << sh)) | *ptr << sh;
+		__raw_writel(value, ar2315_pci_cfg_mem + addr);
+		isr = ar231x_read_reg(AR2315_PCI_ISR);
+		if (isr & AR2315_PCI_INT_ABORT)
+			goto exit_err;
+	} else {
+		*ptr = (value >> sh) & mask;
+	}
+
+	goto exit;
+
+exit_err:
+	ar231x_write_reg(AR2315_PCI_ISR, AR2315_PCI_INT_ABORT);
+	if (!write)
+		*ptr = 0xffffffff;
+
+exit:
+	/* Select Memory access */
+	ar231x_mask_reg(AR2315_PCI_MISC_CONFIG, AR2315_PCIMISC_CFG_SEL, 0);
+
+	return isr & AR2315_PCI_INT_ABORT ? PCIBIOS_DEVICE_NOT_FOUND :
+					    PCIBIOS_SUCCESSFUL;
+}
+
+static inline int ar2315_pci_local_cfg_rd(unsigned devfn, int where, u32 *val)
+{
+	return ar2315_pci_cfg_access(devfn, where, sizeof(u32), val, false);
+}
+
+static inline int ar2315_pci_local_cfg_wr(unsigned devfn, int where, u32 val)
+{
+	return ar2315_pci_cfg_access(devfn, where, sizeof(u32), &val, true);
+}
+
+static int ar2315_pci_cfg_read(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *value)
+{
+	if (PCI_SLOT(devfn) == AR2315_PCI_HOST_SLOT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return ar2315_pci_cfg_access(devfn, where, size, value, 0);
+}
+
+static int ar2315_pci_cfg_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 value)
+{
+	if (PCI_SLOT(devfn) == AR2315_PCI_HOST_SLOT)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return ar2315_pci_cfg_access(devfn, where, size, &value, 1);
+}
+
+static struct pci_ops ar2315_pci_ops = {
+	.read	= ar2315_pci_cfg_read,
+	.write	= ar2315_pci_cfg_write,
+};
+
+static struct resource ar2315_mem_resource = {
+	.name	= "ar2315-pci-mem",
+	.start	= AR2315_PCIEXT,
+	.end	= AR2315_PCIEXT + AR2315_PCIEXT_SZ - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+/* PCI controller does not support I/O ports */
+static struct resource ar2315_io_resource = {
+	.name	= "ar2315-pci-io",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct pci_controller ar2315_pci_controller = {
+	.pci_ops	= &ar2315_pci_ops,
+	.mem_resource	= &ar2315_mem_resource,
+	.io_resource	= &ar2315_io_resource,
+	.mem_offset     = 0x00000000UL,
+	.io_offset      = 0x00000000UL,
+};
+
+static int ar2315_pci_host_setup(void)
+{
+	unsigned devfn = PCI_DEVFN(AR2315_PCI_HOST_SLOT, 0);
+	int res;
+	u32 id;
+
+	res = ar2315_pci_local_cfg_rd(devfn, PCI_VENDOR_ID, &id);
+	if (res != PCIBIOS_SUCCESSFUL || id != AR2315_PCI_HOST_DEVID)
+		return -ENODEV;
+
+	/* Program MBARs */
+	ar2315_pci_local_cfg_wr(devfn, PCI_BASE_ADDRESS_0,
+				AR2315_PCI_HOST_MBAR0);
+	ar2315_pci_local_cfg_wr(devfn, PCI_BASE_ADDRESS_1,
+				AR2315_PCI_HOST_MBAR1);
+	ar2315_pci_local_cfg_wr(devfn, PCI_BASE_ADDRESS_2,
+				AR2315_PCI_HOST_MBAR2);
+
+	/* Run */
+	ar2315_pci_local_cfg_wr(devfn, PCI_COMMAND, PCI_COMMAND_MEMORY |
+				PCI_COMMAND_MASTER | PCI_COMMAND_SPECIAL |
+				PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY |
+				PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK);
+
+	return 0;
+}
+
+static void ar2315_pci_irq_handler(unsigned irq, struct irq_desc *desc)
+{
+	u32 pending = ar231x_read_reg(AR2315_PCI_ISR) &
+		      ar231x_read_reg(AR2315_PCI_IMR);
+
+	if (pending & AR2315_PCI_INT_EXT)
+		generic_handle_irq(ar2315_pci_irq_base + AR2315_PCI_IRQ_EXT);
+	else if (pending & AR2315_PCI_INT_ABORT)
+		generic_handle_irq(ar2315_pci_irq_base + AR2315_PCI_IRQ_ABORT);
+	else
+		spurious_interrupt();
+}
+
+static void ar2315_pci_irq_mask(struct irq_data *d)
+{
+	u32 m = 1 << (d->irq - ar2315_pci_irq_base + AR2315_PCI_IRQ_SHIFT);
+
+	ar231x_mask_reg(AR2315_PCI_IMR, m, 0);
+}
+
+static void ar2315_pci_irq_mask_ack(struct irq_data *d)
+{
+	u32 m = 1 << (d->irq - ar2315_pci_irq_base + AR2315_PCI_IRQ_SHIFT);
+
+	ar231x_mask_reg(AR2315_PCI_IMR, m, 0);
+	ar231x_write_reg(AR2315_PCI_ISR, m);
+}
+
+static void ar2315_pci_irq_unmask(struct irq_data *d)
+{
+	u32 m = 1 << (d->irq - ar2315_pci_irq_base + AR2315_PCI_IRQ_SHIFT);
+
+	ar231x_mask_reg(AR2315_PCI_IMR, 0, m);
+}
+
+static struct irq_chip ar2315_pci_irq_chip = {
+	.name = "AR2315-PCI",
+	.irq_mask = ar2315_pci_irq_mask,
+	.irq_mask_ack = ar2315_pci_irq_mask_ack,
+	.irq_unmask = ar2315_pci_irq_unmask,
+};
+
+static void ar2315_pci_irq_init(void)
+{
+	unsigned i;
+
+	ar231x_mask_reg(AR2315_PCI_IER, AR2315_PCI_IER_ENABLE, 0);
+	ar231x_mask_reg(AR2315_PCI_IMR, (AR2315_PCI_INT_ABORT |
+			 AR2315_PCI_INT_EXT), 0);
+
+	for (i = 0; i < AR2315_PCI_IRQ_COUNT; ++i) {
+		unsigned irq = ar2315_pci_irq_base + i;
+
+		irq_set_chip_and_handler(irq, &ar2315_pci_irq_chip,
+					 handle_level_irq);
+	}
+
+	irq_set_chained_handler(AR2315_IRQ_LCBUS_PCI, ar2315_pci_irq_handler);
+
+	/* Clear any pending Abort or external Interrupts
+	 * and enable interrupt processing */
+	ar231x_write_reg(AR2315_PCI_ISR, (AR2315_PCI_INT_ABORT |
+			 AR2315_PCI_INT_EXT));
+	ar231x_mask_reg(AR2315_PCI_IER, 0, AR2315_PCI_IER_ENABLE);
+}
+
+static int ar2315_pci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	u32 reg;
+	int res;
+
+	/* Remap PCI config space */
+	ar2315_pci_cfg_mem = devm_ioremap_nocache(dev, AR2315_PCIEXT,
+						  AR2315_PCI_CFG_SIZE);
+	if (!ar2315_pci_cfg_mem) {
+		dev_err(dev, "failed to remap PCI config space\n");
+		return -ENOMEM;
+	}
+
+	/* Reset PCI DMA logic */
+	reg = ar231x_mask_reg(AR2315_RESET, 0, AR2315_RESET_PCIDMA);
+	msleep(20);
+	reg &= ~AR2315_RESET_PCIDMA;
+	ar231x_write_reg(AR2315_RESET, reg);
+	msleep(20);
+
+	ar231x_mask_reg(AR2315_ENDIAN_CTL, 0,
+			AR2315_CONFIG_PCIAHB | AR2315_CONFIG_PCIAHB_BRIDGE);
+
+	ar231x_write_reg(AR2315_PCICLK, AR2315_PCICLK_PLLC_CLKM |
+			 (AR2315_PCICLK_IN_FREQ_DIV_6 << AR2315_PCICLK_DIV_S));
+	ar231x_mask_reg(AR2315_AHB_ARB_CTL, 0, AR2315_ARB_PCI);
+	ar231x_mask_reg(AR2315_IF_CTL, AR2315_IF_PCI_CLK_MASK | AR2315_IF_MASK,
+			AR2315_IF_PCI | AR2315_IF_PCI_HOST |
+			AR2315_IF_PCI_INTR | (AR2315_IF_PCI_CLK_OUTPUT_CLK <<
+					      AR2315_IF_PCI_CLK_SHIFT));
+
+	/* Reset the PCI bus by setting bits 5-4 in PCI_MCFG */
+	ar231x_mask_reg(AR2315_PCI_MISC_CONFIG, AR2315_PCIMISC_RST_MODE,
+			AR2315_PCIRST_LOW);
+	msleep(100);
+
+	/* Bring the PCI out of reset */
+	ar231x_mask_reg(AR2315_PCI_MISC_CONFIG, AR2315_PCIMISC_RST_MODE,
+			AR2315_PCIRST_HIGH | AR2315_PCICACHE_DIS | 0x8);
+
+	ar231x_write_reg(AR2315_PCI_UNCACHE_CFG,
+			 0x1E | /* 1GB uncached */
+			 (1 << 5) | /* Enable uncached */
+			 (0x2 << 30) /* Base: 0x80000000 */);
+	ar231x_read_reg(AR2315_PCI_UNCACHE_CFG);
+
+	msleep(500);
+
+	res = ar2315_pci_host_setup();
+	if (res)
+		return res;
+
+	res = irq_alloc_descs(-1, 0, AR2315_PCI_IRQ_COUNT, 0);
+	if (res < 0) {
+		dev_err(dev, "failed to allocate PCI IRQ numbers\n");
+		return res;
+	}
+	ar2315_pci_irq_base = res;
+
+	ar2315_pci_irq_init();
+
+	register_pci_controller(&ar2315_pci_controller);
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
+	return ar2315_pci_irq_base + AR2315_PCI_IRQ_EXT;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
-- 
1.8.5.5
