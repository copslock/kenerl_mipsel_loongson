Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 17:48:32 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60548 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491099Ab1EIPs1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 17:48:27 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V3 1/3] MIPS: lantiq: add DMA support
Date:   Mon,  9 May 2011 17:49:56 +0200
Message-Id: <1304956198-20426-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304956198-20426-1-git-send-email-blogic@openwrt.org>
References: <1304956198-20426-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds support for the DMA engine found inside the XWAY family of
SoCs. The engine has 5 ports and 20 channels.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org

---

Changes in V2
* use spinlocks

Changes in V3
* dma is not a platform device

 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 +-
 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h  |   60 +++++
 arch/mips/lantiq/xway/Makefile                     |    2 +-
 arch/mips/lantiq/xway/dma.c                        |  253 ++++++++++++++++++++
 4 files changed, 316 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
 create mode 100644 arch/mips/lantiq/xway/dma.c

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 343e82c..4827afb 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -86,7 +86,8 @@
 #define LTQ_PPE32_SIZE		0x40000
 
 /* DMA */
-#define LTQ_DMA_BASE_ADDR	0xBE104100
+#define LTQ_DMA_BASE_ADDR	0x1E104100
+#define LTQ_DMA_SIZE		0x800
 
 /* PCI */
 #define PCI_CR_BASE_ADDR	0x1E105400
diff --git a/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
new file mode 100644
index 0000000..872943a
--- /dev/null
+++ b/arch/mips/include/asm/mach-lantiq/xway/xway_dma.h
@@ -0,0 +1,60 @@
+/*
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms of the GNU General Public License version 2 as published
+ *   by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *   Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#ifndef LTQ_DMA_H__
+#define LTQ_DMA_H__
+
+#define LTQ_DESC_SIZE		0x08	/* each descriptor is 64bit */
+#define LTQ_DESC_NUM		0x40	/* 64 descriptors / channel */
+
+#define LTQ_DMA_OWN		BIT(31)	/* owner bit */
+#define LTQ_DMA_C		BIT(30) /* complete bit */
+#define LTQ_DMA_SOP		BIT(29) /* start of packet */
+#define LTQ_DMA_EOP		BIT(28) /* end of packet */
+#define LTQ_DMA_TX_OFFSET(x)	((x & 0x1f) << 23) /* data bytes offset */
+#define LTQ_DMA_RX_OFFSET(x)	((x & 0x7) << 23) /* data bytes offset */
+#define LTQ_DMA_SIZE_MASK	(0xffff) /* the size field is 16 bit */
+
+struct ltq_dma_desc {
+	u32 ctl;
+	u32 addr;
+};
+
+struct ltq_dma_channel {
+	int nr;				/* the channel number */
+	int irq;			/* the mapped irq */
+	int desc;			/* the current descriptor */
+	struct ltq_dma_desc *desc_base;	/* the descriptor base */
+	int phys;			/* physical addr */
+};
+
+enum {
+	DMA_PORT_ETOP = 0,
+	DMA_PORT_DEU,
+};
+
+extern void ltq_dma_enable_irq(struct ltq_dma_channel *ch);
+extern void ltq_dma_disable_irq(struct ltq_dma_channel *ch);
+extern void ltq_dma_ack_irq(struct ltq_dma_channel *ch);
+extern void ltq_dma_open(struct ltq_dma_channel *ch);
+extern void ltq_dma_close(struct ltq_dma_channel *ch);
+extern void ltq_dma_alloc_tx(struct ltq_dma_channel *ch);
+extern void ltq_dma_alloc_rx(struct ltq_dma_channel *ch);
+extern void ltq_dma_free(struct ltq_dma_channel *ch);
+extern void ltq_dma_init_port(int p);
+
+#endif
diff --git a/arch/mips/lantiq/xway/Makefile b/arch/mips/lantiq/xway/Makefile
index a021def..d88a3e8 100644
--- a/arch/mips/lantiq/xway/Makefile
+++ b/arch/mips/lantiq/xway/Makefile
@@ -1,4 +1,4 @@
-obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o
+obj-y := pmu.o ebu.o reset.o gpio.o gpio_stp.o gpio_ebu.o devices.o dma.o
 
 obj-$(CONFIG_SOC_XWAY) += clk-xway.o prom-xway.o
 obj-$(CONFIG_SOC_AMAZON_SE) += clk-ase.o prom-ase.o
diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
new file mode 100644
index 0000000..4278a45
--- /dev/null
+++ b/arch/mips/lantiq/xway/dma.c
@@ -0,0 +1,253 @@
+/*
+ *   This program is free software; you can redistribute it and/or modify it
+ *   under the terms of the GNU General Public License version 2 as published
+ *   by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *   Copyright (C) 2011 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+
+#include <lantiq_soc.h>
+#include <xway_dma.h>
+
+#define LTQ_DMA_CTRL		0x10
+#define LTQ_DMA_CPOLL		0x14
+#define LTQ_DMA_CS		0x18
+#define LTQ_DMA_CCTRL		0x1C
+#define LTQ_DMA_CDBA		0x20
+#define LTQ_DMA_CDLEN		0x24
+#define LTQ_DMA_CIS		0x28
+#define LTQ_DMA_CIE		0x2C
+#define LTQ_DMA_PS		0x40
+#define LTQ_DMA_PCTRL		0x44
+#define LTQ_DMA_IRNEN		0xf4
+
+#define DMA_DESCPT		BIT(3)		/* descriptor complete irq */
+#define DMA_TX			BIT(8)		/* TX channel direction */
+#define DMA_CHAN_ON		BIT(0)		/* channel on / off bit */
+#define DMA_PDEN		BIT(6)		/* enable packet drop */
+#define DMA_CHAN_RST		BIT(1)		/* channel on / off bit */
+#define DMA_RESET		BIT(0)		/* channel on / off bit */
+#define DMA_IRQ_ACK		0x7e		/* IRQ status register */
+#define DMA_POLL		BIT(31)		/* turn on channel polling */
+#define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
+#define DMA_2W_BURST		BIT(1)		/* 2 word burst length */
+#define DMA_MAX_CHANNEL		20		/* the soc has 20 channels */
+#define DMA_ETOP_ENDIANESS	(0xf << 8) /* endianess swap etop channels */
+#define DMA_WEIGHT	(BIT(17) | BIT(16))	/* default channel wheight */
+
+#define ltq_dma_r32(x)			ltq_r32(ltq_dma_membase + (x))
+#define ltq_dma_w32(x, y)		ltq_w32(x, ltq_dma_membase + (y))
+#define ltq_dma_w32_mask(x, y, z)	ltq_w32_mask(x, y, \
+						ltq_dma_membase + (z))
+
+static struct resource ltq_dma_resource = {
+	.name	= "dma",
+	.start	= LTQ_DMA_BASE_ADDR,
+	.end	= LTQ_DMA_BASE_ADDR + LTQ_DMA_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+static void __iomem *ltq_dma_membase;
+
+void
+ltq_dma_enable_irq(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_enable_irq);
+
+void
+ltq_dma_disable_irq(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32_mask(1 << ch->nr, 0, LTQ_DMA_IRNEN);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_disable_irq);
+
+void
+ltq_dma_ack_irq(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32(DMA_IRQ_ACK, LTQ_DMA_CIS);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_ack_irq);
+
+void
+ltq_dma_open(struct ltq_dma_channel *ch)
+{
+	unsigned long flag;
+
+	local_irq_save(flag);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32_mask(0, DMA_CHAN_ON, LTQ_DMA_CCTRL);
+	ltq_dma_enable_irq(ch);
+	local_irq_restore(flag);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_open);
+
+void
+ltq_dma_close(struct ltq_dma_channel *ch)
+{
+	unsigned long flag;
+
+	local_irq_save(flag);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
+	ltq_dma_disable_irq(ch);
+	local_irq_restore(flag);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_close);
+
+static void
+ltq_dma_alloc(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	ch->desc = 0;
+	ch->desc_base = dma_alloc_coherent(NULL,
+				LTQ_DESC_NUM * LTQ_DESC_SIZE,
+				&ch->phys, GFP_ATOMIC);
+	memset(ch->desc_base, 0, LTQ_DESC_NUM * LTQ_DESC_SIZE);
+
+	local_irq_save(flags);
+	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
+	ltq_dma_w32(ch->phys, LTQ_DMA_CDBA);
+	ltq_dma_w32(LTQ_DESC_NUM, LTQ_DMA_CDLEN);
+	ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
+	wmb();
+	ltq_dma_w32_mask(0, DMA_CHAN_RST, LTQ_DMA_CCTRL);
+	while (ltq_dma_r32(LTQ_DMA_CCTRL) & DMA_CHAN_RST)
+		;
+	local_irq_restore(flags);
+}
+
+void
+ltq_dma_alloc_tx(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	ltq_dma_alloc(ch);
+
+	local_irq_save(flags);
+	ltq_dma_w32(DMA_DESCPT, LTQ_DMA_CIE);
+	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
+	ltq_dma_w32(DMA_WEIGHT | DMA_TX, LTQ_DMA_CCTRL);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_alloc_tx);
+
+void
+ltq_dma_alloc_rx(struct ltq_dma_channel *ch)
+{
+	unsigned long flags;
+
+	ltq_dma_alloc(ch);
+
+	local_irq_save(flags);
+	ltq_dma_w32(DMA_DESCPT, LTQ_DMA_CIE);
+	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
+	ltq_dma_w32(DMA_WEIGHT, LTQ_DMA_CCTRL);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_alloc_rx);
+
+void
+ltq_dma_free(struct ltq_dma_channel *ch)
+{
+	if (!ch->desc_base)
+		return;
+	ltq_dma_close(ch);
+	dma_free_coherent(NULL, LTQ_DESC_NUM * LTQ_DESC_SIZE,
+		ch->desc_base, ch->phys);
+}
+EXPORT_SYMBOL_GPL(ltq_dma_free);
+
+void
+ltq_dma_init_port(int p)
+{
+	ltq_dma_w32(p, LTQ_DMA_PS);
+	switch (p) {
+	case DMA_PORT_ETOP:
+		/*
+		 * Tell the DMA engine to swap the endianess of data frames and
+		 * drop packets if the channel arbitration fails.
+		 */
+		ltq_dma_w32_mask(0, DMA_ETOP_ENDIANESS | DMA_PDEN,
+			LTQ_DMA_PCTRL);
+		break;
+
+	case DMA_PORT_DEU:
+		ltq_dma_w32((DMA_2W_BURST << 4) | (DMA_2W_BURST << 2),
+			LTQ_DMA_PCTRL);
+		break;
+
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(ltq_dma_init_port);
+
+int __init
+ltq_dma_init(void)
+{
+	int i;
+
+	/* insert and request the memory region */
+	if (insert_resource(&iomem_resource, &ltq_dma_resource) < 0)
+		panic("Failed to insert dma memory\n");
+
+	if (request_mem_region(ltq_dma_resource.start,
+			resource_size(&ltq_dma_resource), "dma") < 0)
+		panic("Failed to request dma memory\n");
+
+	/* remap dma register range */
+	ltq_dma_membase = ioremap_nocache(ltq_dma_resource.start,
+				resource_size(&ltq_dma_resource));
+	if (!ltq_dma_membase)
+		panic("Failed to remap dma memory\n");
+
+	/* power up and reset the dma engine */
+	ltq_pmu_enable(PMU_DMA);
+	ltq_dma_w32_mask(0, DMA_RESET, LTQ_DMA_CTRL);
+
+	/* disable all interrupts */
+	ltq_dma_w32(0, LTQ_DMA_IRNEN);
+
+	/* reset/configure each channel */
+	for (i = 0; i < DMA_MAX_CHANNEL; i++) {
+		ltq_dma_w32(i, LTQ_DMA_CS);
+		ltq_dma_w32(DMA_CHAN_RST, LTQ_DMA_CCTRL);
+		ltq_dma_w32(DMA_POLL | DMA_CLK_DIV4, LTQ_DMA_CPOLL);
+		ltq_dma_w32_mask(DMA_CHAN_ON, 0, LTQ_DMA_CCTRL);
+	}
+	return 0;
+}
+
+postcore_initcall(ltq_dma_init);
-- 
1.7.2.3
