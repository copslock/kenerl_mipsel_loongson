Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:33:05 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:60302 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011983AbaJUE3B3qPSw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:29:01 +0200
Received: by mail-pa0-f47.google.com with SMTP id kq14so527829pab.6
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r63esfB76ZWf1JHKTzjyIIfuX/R6h+2PbOmI3HY0+4M=;
        b=pcPekYNqPPzdHxkl72mJjtNhv1OAn8zQJ3oZm5H+Pk80sP5lYUP2D5zhI70BMKfy1+
         a/o43fxMBMWjM6rTCItwQmVrPMlu2zOHQ9OiVpPi79R2EXWV3iSzfXzhOYtecxiTqHI0
         MQ70wOeil4KIG8EPiZth1c6uQMSMAKn/6/O9tKZFJe852byqcNshhYmRMQblwcC9IlJ3
         Mq0s24JkSC/RRxhrhQ3f2QQ0tnwMQ12aIwe2r8UT5i8vEPdv8H+KBL/f7csV0Kngoh4B
         42eMJvObVXQ64J16Hqqeg/K9NodZ3xM/E2IRFXcwlKKX/fOTesQL02pxbyFyYbBRCQXK
         DtEg==
X-Received: by 10.68.222.70 with SMTP id qk6mr32208746pbc.65.1413865735084;
        Mon, 20 Oct 2014 21:28:55 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:54 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 15/17] MIPS: bcm3384: Initial commit of bcm3384 platform support
Date:   Mon, 20 Oct 2014 21:28:05 -0700
Message-Id: <1413865687-15255-16-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This supports SMP Linux running on the BCM3384 Zephyr (BMIPS5000)
application processor, with fully functional UART and USB 1.1/2.0.
Device Tree is used to configure the following items:

 - All peripherals
 - Early console base address
 - SMP or UP mode
 - MIPS counter frequency
 - Memory size / regions
 - DMA offset
 - Kernel command line

The DT-enabled bootloader and build instructions are posted at
https://github.com/Broadcom/aeolus

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  26 +++
 arch/mips/bcm3384/Makefile                         |   1 +
 arch/mips/bcm3384/Platform                         |   7 +
 arch/mips/bcm3384/dma.c                            |  81 +++++++++
 arch/mips/bcm3384/irq.c                            | 193 +++++++++++++++++++++
 arch/mips/bcm3384/setup.c                          |  97 +++++++++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/bcm3384.dtsi                    | 109 ++++++++++++
 arch/mips/boot/dts/bcm93384wvg.dts                 |  32 ++++
 arch/mips/configs/bcm3384_defconfig                |  78 +++++++++
 arch/mips/include/asm/mach-bcm3384/dma-coherence.h |  48 +++++
 arch/mips/include/asm/mach-bcm3384/war.h           |  24 +++
 13 files changed, 698 insertions(+)
 create mode 100644 arch/mips/bcm3384/Makefile
 create mode 100644 arch/mips/bcm3384/Platform
 create mode 100644 arch/mips/bcm3384/dma.c
 create mode 100644 arch/mips/bcm3384/irq.c
 create mode 100644 arch/mips/bcm3384/setup.c
 create mode 100644 arch/mips/boot/dts/bcm3384.dtsi
 create mode 100644 arch/mips/boot/dts/bcm93384wvg.dts
 create mode 100644 arch/mips/configs/bcm3384_defconfig
 create mode 100644 arch/mips/include/asm/mach-bcm3384/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bcm3384/war.h

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index f5e18bf..7c50721 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -3,6 +3,7 @@
 platforms += alchemy
 platforms += ar7
 platforms += ath79
+platforms += bcm3384
 platforms += bcm47xx
 platforms += bcm63xx
 platforms += cavium-octeon
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 38e02e1..1c277d5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -115,6 +115,32 @@ config ATH79
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
 
+config BCM3384
+	bool "Broadcom BCM3384 based boards"
+	select BOOT_RAW
+	select NO_EXCEPT_FILL
+	select USE_OF
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYNC_R4K
+	select COMMON_CLK
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_HAS_CPU_BMIPS5000
+	select SWAP_IO_SPACE
+	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	help
+	  Support for BCM3384 based boards.  BCM3384/BCM33843 is a cable modem
+	  chipset with a Linux application processor that is often used to
+	  provide Samba services, a CUPS print server, and/or advanced routing
+	  features.
+
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/mips/bcm3384/Makefile b/arch/mips/bcm3384/Makefile
new file mode 100644
index 0000000..a393955
--- /dev/null
+++ b/arch/mips/bcm3384/Makefile
@@ -0,0 +1 @@
+obj-y		+= setup.o irq.o dma.o
diff --git a/arch/mips/bcm3384/Platform b/arch/mips/bcm3384/Platform
new file mode 100644
index 0000000..8e1ca08
--- /dev/null
+++ b/arch/mips/bcm3384/Platform
@@ -0,0 +1,7 @@
+#
+# Broadcom BCM3384 boards
+#
+platform-$(CONFIG_BCM3384)	+= bcm3384/
+cflags-$(CONFIG_BCM3384)	+=					\
+		-I$(srctree)/arch/mips/include/asm/mach-bcm3384/
+load-$(CONFIG_BCM3384)		:= 0xffffffff80010000
diff --git a/arch/mips/bcm3384/dma.c b/arch/mips/bcm3384/dma.c
new file mode 100644
index 0000000..ea42012
--- /dev/null
+++ b/arch/mips/bcm3384/dma.c
@@ -0,0 +1,81 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014 Kevin Cernekee <cernekee@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <dma-coherence.h>
+
+/*
+ * BCM3384 has configurable address translation windows which allow the
+ * peripherals' DMA addresses to be different from the Zephyr-visible
+ * physical addresses.  e.g. usb_dma_addr = zephyr_pa ^ 0x08000000
+ *
+ * If our DT "memory" node has a "dma-xor-mask" property we will enable this
+ * translation using the provided offset.
+ */
+static u32 bcm3384_dma_xor_mask;
+static u32 bcm3384_dma_xor_limit = 0xffffffff;
+
+/*
+ * PCI collapses the memory hole at 0x10000000 - 0x1fffffff.
+ * On systems with a dma-xor-mask, this range is guaranteed to live above
+ * the dma-xor-limit.
+ */
+#define BCM3384_MEM_HOLE_PA	0x10000000
+#define BCM3384_MEM_HOLE_SIZE	0x10000000
+
+static dma_addr_t bcm3384_phys_to_dma(struct device *dev, phys_addr_t pa)
+{
+	if (dev && dev_is_pci(dev) &&
+	    pa >= (BCM3384_MEM_HOLE_PA + BCM3384_MEM_HOLE_SIZE))
+		return pa - BCM3384_MEM_HOLE_SIZE;
+	if (pa <= bcm3384_dma_xor_limit)
+		return pa ^ bcm3384_dma_xor_mask;
+	return pa;
+}
+
+dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size)
+{
+	return bcm3384_phys_to_dma(dev, virt_to_phys(addr));
+}
+
+dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page)
+{
+	return bcm3384_phys_to_dma(dev, page_to_phys(page));
+}
+
+unsigned long plat_dma_addr_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	if (dev && dev_is_pci(dev) &&
+	    dma_addr >= BCM3384_MEM_HOLE_PA)
+		return dma_addr + BCM3384_MEM_HOLE_SIZE;
+	if ((dma_addr ^ bcm3384_dma_xor_mask) <= bcm3384_dma_xor_limit)
+		return dma_addr ^ bcm3384_dma_xor_mask;
+	return dma_addr;
+}
+
+static int __init bcm3384_init_dma_xor(void)
+{
+	struct device_node *np = of_find_node_by_type(NULL, "memory");
+
+	if (!np)
+		return 0;
+
+	of_property_read_u32(np, "dma-xor-mask", &bcm3384_dma_xor_mask);
+	of_property_read_u32(np, "dma-xor-limit", &bcm3384_dma_xor_limit);
+
+	of_node_put(np);
+	return 0;
+}
+arch_initcall(bcm3384_init_dma_xor);
diff --git a/arch/mips/bcm3384/irq.c b/arch/mips/bcm3384/irq.c
new file mode 100644
index 0000000..0fb5134
--- /dev/null
+++ b/arch/mips/bcm3384/irq.c
@@ -0,0 +1,193 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Partially based on arch/mips/ralink/irq.c
+ *
+ * Copyright (C) 2009 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2014 Kevin Cernekee <cernekee@gmail.com>
+ */
+
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <asm/bmips.h>
+#include <asm/irq_cpu.h>
+#include <asm/mipsregs.h>
+
+/* INTC register offsets */
+#define INTC_REG_ENABLE		0x00
+#define INTC_REG_STATUS		0x04
+
+#define MAX_WORDS		2
+#define IRQS_PER_WORD		32
+
+struct bcm3384_intc {
+	int			n_words;
+	void __iomem		*reg[MAX_WORDS];
+	u32			enable[MAX_WORDS];
+	spinlock_t		lock;
+};
+
+static void bcm3384_intc_irq_unmask(struct irq_data *d)
+{
+	struct bcm3384_intc *priv = d->domain->host_data;
+	unsigned long flags;
+	int idx = d->hwirq / IRQS_PER_WORD;
+	int bit = d->hwirq % IRQS_PER_WORD;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->enable[idx] |= BIT(bit);
+	__raw_writel(priv->enable[idx], priv->reg[idx] + INTC_REG_ENABLE);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void bcm3384_intc_irq_mask(struct irq_data *d)
+{
+	struct bcm3384_intc *priv = d->domain->host_data;
+	unsigned long flags;
+	int idx = d->hwirq / IRQS_PER_WORD;
+	int bit = d->hwirq % IRQS_PER_WORD;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->enable[idx] &= ~BIT(bit);
+	__raw_writel(priv->enable[idx], priv->reg[idx] + INTC_REG_ENABLE);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static struct irq_chip bcm3384_intc_irq_chip = {
+	.name		= "INTC",
+	.irq_unmask	= bcm3384_intc_irq_unmask,
+	.irq_mask	= bcm3384_intc_irq_mask,
+	.irq_mask_ack	= bcm3384_intc_irq_mask,
+};
+
+unsigned int get_c0_compare_int(void)
+{
+	return CP0_LEGACY_COMPARE_IRQ;
+}
+
+static void bcm3384_intc_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain = irq_get_handler_data(irq);
+	struct bcm3384_intc *priv = domain->host_data;
+	unsigned long flags;
+	unsigned int idx;
+
+	for (idx = 0; idx < priv->n_words; idx++) {
+		unsigned long pending;
+		int hwirq;
+
+		spin_lock_irqsave(&priv->lock, flags);
+		pending = __raw_readl(priv->reg[idx] + INTC_REG_STATUS) &
+			  priv->enable[idx];
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
+			generic_handle_irq(irq_find_mapping(domain,
+					   hwirq + idx * IRQS_PER_WORD));
+		}
+	}
+}
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long pending =
+		(read_c0_status() & read_c0_cause() & ST0_IM) >> STATUSB_IP0;
+	int bit;
+
+	for_each_set_bit(bit, &pending, 8)
+		do_IRQ(MIPS_CPU_IRQ_BASE + bit);
+}
+
+static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &bcm3384_intc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = intc_map,
+};
+
+static int __init ioremap_one_pair(struct bcm3384_intc *priv,
+				   struct device_node *node,
+				   int idx)
+{
+	struct resource res;
+
+	if (of_address_to_resource(node, idx, &res))
+		return 0;
+
+	if (request_mem_region(res.start, resource_size(&res),
+			       res.name) < 0)
+		pr_err("Failed to request INTC register region\n");
+
+	priv->reg[idx] = ioremap_nocache(res.start, resource_size(&res));
+	if (!priv->reg[idx])
+		panic("Failed to ioremap INTC register range");
+
+	/* start up with everything masked before we hook the parent IRQ */
+	__raw_writel(0, priv->reg[idx] + INTC_REG_ENABLE);
+	priv->enable[idx] = 0;
+
+	return IRQS_PER_WORD;
+}
+
+static int __init intc_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *domain;
+	unsigned int parent_irq, n_irqs = 0;
+	struct bcm3384_intc *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		panic("Failed to allocate bcm3384_intc struct");
+
+	spin_lock_init(&priv->lock);
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		panic("Failed to get INTC IRQ");
+
+	n_irqs += ioremap_one_pair(priv, node, 0);
+	n_irqs += ioremap_one_pair(priv, node, 1);
+
+	if (!n_irqs)
+		panic("Failed to map INTC registers");
+
+	priv->n_words = n_irqs / IRQS_PER_WORD;
+	domain = irq_domain_add_linear(node, n_irqs, &irq_domain_ops, priv);
+	if (!domain)
+		panic("Failed to add irqdomain");
+
+	irq_set_chained_handler(parent_irq, bcm3384_intc_irq_handler);
+	irq_set_handler_data(parent_irq, domain);
+
+	return 0;
+}
+
+static struct of_device_id of_irq_ids[] __initdata = {
+	{ .compatible = "mti,cpu-interrupt-controller",
+	  .data = mips_cpu_intc_init },
+	{ .compatible = "brcm,bcm3384-intc",
+	  .data = intc_of_init },
+	{},
+};
+
+void __init arch_init_irq(void)
+{
+	bmips_tp1_irqs = 0;
+	of_irq_init(of_irq_ids);
+}
diff --git a/arch/mips/bcm3384/setup.c b/arch/mips/bcm3384/setup.c
new file mode 100644
index 0000000..d84b840
--- /dev/null
+++ b/arch/mips/bcm3384/setup.c
@@ -0,0 +1,97 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ * Copyright (C) 2014 Kevin Cernekee <cernekee@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/clk-provider.h>
+#include <linux/ioport.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/smp.h>
+#include <asm/addrspace.h>
+#include <asm/bmips.h>
+#include <asm/bootinfo.h>
+#include <asm/prom.h>
+#include <asm/smp-ops.h>
+#include <asm/time.h>
+
+void __init prom_init(void)
+{
+	register_bmips_smp_ops();
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
+const char *get_system_type(void)
+{
+	return "BCM3384";
+}
+
+void __init plat_time_init(void)
+{
+	struct device_node *np;
+	u32 freq;
+
+	np = of_find_node_by_name(NULL, "cpus");
+	if (!np)
+		panic("missing 'cpus' DT node");
+	if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
+		panic("missing 'mips-hpt-frequency' property");
+	of_node_put(np);
+
+	mips_hpt_frequency = freq;
+}
+
+void __init plat_mem_setup(void)
+{
+	void *dtb = __dtb_start;
+
+	set_io_port_base(0);
+	ioport_resource.start = 0;
+	ioport_resource.end = ~0;
+
+	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
+	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
+		dtb = phys_to_virt(fw_arg2);
+
+	__dt_setup_arch(dtb);
+
+	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+}
+
+void __init device_tree_init(void)
+{
+	struct device_node *np;
+
+	unflatten_and_copy_device_tree();
+
+	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
+	np = of_find_node_by_name(NULL, "cpus");
+	if (np && of_get_available_child_count(np) <= 1)
+		bmips_smp_enabled = 0;
+	of_node_put(np);
+}
+
+int __init plat_of_setup(void)
+{
+	return __dt_register_buses("brcm,bcm3384", "simple-bus");
+}
+
+arch_initcall(plat_of_setup);
+
+static int __init plat_dev_init(void)
+{
+	of_clk_init(NULL);
+	return 0;
+}
+
+device_initcall(plat_dev_init);
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index ca9c90e..4f49fa4 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_BCM3384)			+= bcm93384wvg.dtb
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
 dtb-$(CONFIG_DT_EASY50712)		+= easy50712.dtb
 dtb-$(CONFIG_DT_XLP_EVP)		+= xlp_evp.dtb
diff --git a/arch/mips/boot/dts/bcm3384.dtsi b/arch/mips/boot/dts/bcm3384.dtsi
new file mode 100644
index 0000000..21b074a
--- /dev/null
+++ b/arch/mips/boot/dts/bcm3384.dtsi
@@ -0,0 +1,109 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "brcm,bcm3384", "brcm,bcm33843";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* On BMIPS5000 this is 1/8th of the CPU core clock */
+		mips-hpt-frequency = <100000000>;
+
+		cpu@0 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu@1 {
+			compatible = "brcm,bmips5000";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		periph_clk: periph_clk@0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <54000000>;
+		};
+	};
+
+	aliases {
+		uart0 = &uart0;
+	};
+
+	cpu_intc: cpu_intc@0 {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	periph_intc: periph_intc@14e00038 {
+		compatible = "brcm,bcm3384-intc";
+		reg = <0x14e00038 0x8 0x14e00340 0x8>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpu_intc>;
+		interrupts = <4>;
+	};
+
+	zmips_intc: zmips_intc@104b0060 {
+		compatible = "brcm,bcm3384-intc";
+		reg = <0x104b0060 0x8>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&periph_intc>;
+		interrupts = <29>;
+	};
+
+	iop_intc: iop_intc@14e00058 {
+		compatible = "brcm,bcm3384-intc";
+		reg = <0x14e00058 0x8>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpu_intc>;
+		interrupts = <6>;
+	};
+
+	uart0: serial@14e00520 {
+		compatible = "brcm,bcm6345-uart";
+		reg = <0x14e00520 0x18>;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <2>;
+		clocks = <&periph_clk>;
+		status = "disabled";
+	};
+
+	ehci0: usb@15400300 {
+		compatible = "brcm,bcm3384-ehci", "generic-ehci";
+		reg = <0x15400300 0x100>;
+		big-endian;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <41>;
+		status = "disabled";
+	};
+
+	ohci0: usb@15400400 {
+		compatible = "brcm,bcm3384-ohci", "generic-ohci";
+		reg = <0x15400400 0x100>;
+		big-endian;
+		no-big-frame-no;
+		interrupt-parent = <&periph_intc>;
+		interrupts = <40>;
+		status = "disabled";
+	};
+};
diff --git a/arch/mips/boot/dts/bcm93384wvg.dts b/arch/mips/boot/dts/bcm93384wvg.dts
new file mode 100644
index 0000000..8317411
--- /dev/null
+++ b/arch/mips/boot/dts/bcm93384wvg.dts
@@ -0,0 +1,32 @@
+/dts-v1/;
+
+/include/ "bcm3384.dtsi"
+
+/ {
+	compatible = "brcm,bcm93384wvg", "brcm,bcm3384";
+	model = "Broadcom BCM93384WVG";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x04000000>;
+		dma-xor-mask = <0x08000000>;
+		dma-xor-limit = <0x0fffffff>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
diff --git a/arch/mips/configs/bcm3384_defconfig b/arch/mips/configs/bcm3384_defconfig
new file mode 100644
index 0000000..88711c2
--- /dev/null
+++ b/arch/mips/configs/bcm3384_defconfig
@@ -0,0 +1,78 @@
+CONFIG_BCM3384=y
+CONFIG_HIGHMEM=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+# CONFIG_SECCOMP is not set
+CONFIG_MIPS_O32_FP64_SUPPORT=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_NO_HZ=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_GZIP is not set
+CONFIG_EXPERT=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+CONFIG_CFG80211=y
+CONFIG_NL80211_TESTMODE=y
+CONFIG_MAC80211=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_MTD=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_BLK_DEV is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=y
+CONFIG_USB_USBNET=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_EARLYCON_FORCE=y
+CONFIG_SERIAL_BCM63XX=y
+CONFIG_SERIAL_BCM63XX_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+# CONFIG_DNOTIFY is not set
+CONFIG_FUSE_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_CIFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/include/asm/mach-bcm3384/dma-coherence.h b/arch/mips/include/asm/mach-bcm3384/dma-coherence.h
new file mode 100644
index 0000000..a3be8e5
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm3384/dma-coherence.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2006 Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2009 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_MACH_BCM3384_DMA_COHERENCE_H
+#define __ASM_MACH_BCM3384_DMA_COHERENCE_H
+
+struct device;
+
+extern dma_addr_t plat_map_dma_mem(struct device *dev, void *addr, size_t size);
+extern dma_addr_t plat_map_dma_mem_page(struct device *dev, struct page *page);
+extern unsigned long plat_dma_addr_to_phys(struct device *dev,
+	dma_addr_t dma_addr);
+
+static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
+	size_t size, enum dma_data_direction direction)
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
+static inline int plat_device_is_coherent(struct device *dev)
+{
+	return 0;
+}
+
+#endif /* __ASM_MACH_BCM3384_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-bcm3384/war.h b/arch/mips/include/asm/mach-bcm3384/war.h
new file mode 100644
index 0000000..59d7599
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm3384/war.h
@@ -0,0 +1,24 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_BCM3384_WAR_H
+#define __ASM_MIPS_MACH_BCM3384_WAR_H
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
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_BCM3384_WAR_H */
-- 
2.1.1
