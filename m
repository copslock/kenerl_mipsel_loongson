Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 07:13:13 +0200 (CEST)
Received: from smtp-out-037.synserver.de ([212.40.180.37]:1031 "HELO
        smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1492118Ab0FSFJx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 07:09:53 +0200
Received: (qmail 14375 invoked by uid 0); 19 Jun 2010 05:09:53 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 13414
Received: from d024024.adsl.hansenet.de (HELO localhost.localdomain) [80.171.24.24]
  by 217.119.54.77 with SMTP; 19 Jun 2010 05:09:52 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 09/26] MIPS: JZ4740: Add DMA support.
Date:   Sat, 19 Jun 2010 07:08:14 +0200
Message-Id: <1276924111-11158-10-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
X-archive-position: 27183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13376

This patch adds support for DMA transfers on JZ4740 SoCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/dma.h |   90 ++++++++++
 arch/mips/jz4740/dma.c                  |  289 +++++++++++++++++++++++++++++++
 2 files changed, 379 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-jz4740/dma.h
 create mode 100644 arch/mips/jz4740/dma.c

diff --git a/arch/mips/include/asm/mach-jz4740/dma.h b/arch/mips/include/asm/mach-jz4740/dma.h
new file mode 100644
index 0000000..a3be121
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4740/dma.h
@@ -0,0 +1,90 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ7420/JZ4740 DMA definitions
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef __ASM_MACH_JZ4740_DMA_H__
+#define __ASM_MACH_JZ4740_DMA_H__
+
+struct jz4740_dma_chan;
+
+enum jz4740_dma_request_type {
+	JZ4740_DMA_TYPE_AUTO_REQUEST	= 8,
+	JZ4740_DMA_TYPE_UART_TRANSMIT	= 20,
+	JZ4740_DMA_TYPE_UART_RECEIVE	= 21,
+	JZ4740_DMA_TYPE_SPI_TRANSMIT	= 22,
+	JZ4740_DMA_TYPE_SPI_RECEIVE	= 23,
+	JZ4740_DMA_TYPE_AIC_TRANSMIT	= 24,
+	JZ4740_DMA_TYPE_AIC_RECEIVE	= 25,
+	JZ4740_DMA_TYPE_MMC_TRANSMIT	= 26,
+	JZ4740_DMA_TYPE_MMC_RECEIVE	= 27,
+	JZ4740_DMA_TYPE_TCU		= 28,
+	JZ4740_DMA_TYPE_SADC		= 29,
+	JZ4740_DMA_TYPE_SLCD		= 30,
+};
+
+enum jz4740_dma_width {
+	JZ4740_DMA_WIDTH_32BIT	= 0,
+	JZ4740_DMA_WIDTH_8BIT	= 1,
+	JZ4740_DMA_WIDTH_16BIT	= 2,
+};
+
+enum jz4740_dma_transfer_size {
+	JZ4740_DMA_TRANSFER_SIZE_4BYTE  = 0,
+	JZ4740_DMA_TRANSFER_SIZE_1BYTE  = 1,
+	JZ4740_DMA_TRANSFER_SIZE_2BYTE  = 2,
+	JZ4740_DMA_TRANSFER_SIZE_16BYTE = 3,
+	JZ4740_DMA_TRANSFER_SIZE_32BYTE = 4,
+};
+
+enum jz4740_dma_flags {
+	JZ4740_DMA_SRC_AUTOINC = 0x2,
+	JZ4740_DMA_DST_AUTOINC = 0x1,
+};
+
+enum jz4740_dma_mode {
+	JZ4740_DMA_MODE_SINGLE	= 0,
+	JZ4740_DMA_MODE_BLOCK	= 1,
+};
+
+struct jz4740_dma_config {
+	enum jz4740_dma_width src_width;
+	enum jz4740_dma_width dst_width;
+	enum jz4740_dma_transfer_size transfer_size;
+	enum jz4740_dma_request_type request_type;
+	enum jz4740_dma_flags flags;
+	enum jz4740_dma_mode mode;
+};
+
+typedef void (*jz4740_dma_complete_callback_t)(struct jz4740_dma_chan *, int, void *);
+
+struct jz4740_dma_chan *jz4740_dma_request(void *dev, const char *name);
+void jz4740_dma_free(struct jz4740_dma_chan *dma);
+
+void jz4740_dma_configure(struct jz4740_dma_chan *dma,
+	const struct jz4740_dma_config *config);
+
+
+void jz4740_dma_enable(struct jz4740_dma_chan *dma);
+void jz4740_dma_disable(struct jz4740_dma_chan *dma);
+
+void jz4740_dma_set_src_addr(struct jz4740_dma_chan *dma, dma_addr_t src);
+void jz4740_dma_set_dst_addr(struct jz4740_dma_chan *dma, dma_addr_t dst);
+void jz4740_dma_set_transfer_count(struct jz4740_dma_chan *dma, uint32_t count);
+
+uint32_t jz4740_dma_get_residue(const struct jz4740_dma_chan *dma);
+
+void jz4740_dma_set_complete_cb(struct jz4740_dma_chan *dma,
+	jz4740_dma_complete_callback_t cb);
+
+#endif  /* __ASM_JZ4740_DMA_H__ */
diff --git a/arch/mips/jz4740/dma.c b/arch/mips/jz4740/dma.c
new file mode 100644
index 0000000..5ebe75a
--- /dev/null
+++ b/arch/mips/jz4740/dma.c
@@ -0,0 +1,289 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 SoC DMA support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+#include <linux/dma-mapping.h>
+#include <asm/mach-jz4740/dma.h>
+#include <asm/mach-jz4740/base.h>
+
+#define JZ_REG_DMA_SRC_ADDR(x)		(0x00 + (x) * 0x20)
+#define JZ_REG_DMA_DST_ADDR(x)		(0x04 + (x) * 0x20)
+#define JZ_REG_DMA_TRANSFER_COUNT(x)	(0x08 + (x) * 0x20)
+#define JZ_REG_DMA_REQ_TYPE(x)		(0x0C + (x) * 0x20)
+#define JZ_REG_DMA_STATUS_CTRL(x)	(0x10 + (x) * 0x20)
+#define JZ_REG_DMA_CMD(x)		(0x14 + (x) * 0x20)
+#define JZ_REG_DMA_DESC_ADDR(x)		(0x18 + (x) * 0x20)
+
+#define JZ_REG_DMA_CTRL			0x300
+#define JZ_REG_DMA_IRQ			0x304
+#define JZ_REG_DMA_DOORBELL		0x308
+#define JZ_REG_DMA_DOORBELL_SET		0x30C
+
+#define JZ_DMA_STATUS_CTRL_NO_DESC		BIT(31)
+#define JZ_DMA_STATUS_CTRL_DESC_INV		BIT(6)
+#define JZ_DMA_STATUS_CTRL_ADDR_ERR		BIT(4)
+#define JZ_DMA_STATUS_CTRL_TRANSFER_DONE	BIT(3)
+#define JZ_DMA_STATUS_CTRL_HALT			BIT(2)
+#define JZ_DMA_STATUS_CTRL_COUNT_TERMINATE	BIT(1)
+#define JZ_DMA_STATUS_CTRL_ENABLE		BIT(0)
+
+#define JZ_DMA_CMD_SRC_INC			BIT(23)
+#define JZ_DMA_CMD_DST_INC			BIT(22)
+#define JZ_DMA_CMD_RDIL_MASK			(0xf << 16)
+#define JZ_DMA_CMD_SRC_WIDTH_MASK		(0x3 << 14)
+#define JZ_DMA_CMD_DST_WIDTH_MASK		(0x3 << 12)
+#define JZ_DMA_CMD_INTERVAL_LENGTH_MASK		(0x7 << 8)
+#define JZ_DMA_CMD_BLOCK_MODE			BIT(7)
+#define JZ_DMA_CMD_DESC_VALID			BIT(4)
+#define JZ_DMA_CMD_DESC_VALID_MODE		BIT(3)
+#define JZ_DMA_CMD_VALID_IRQ_ENABLE		BIT(2)
+#define JZ_DMA_CMD_TRANSFER_IRQ_ENABLE		BIT(1)
+#define JZ_DMA_CMD_LINK_ENABLE			BIT(0)
+
+#define JZ_DMA_CMD_FLAGS_OFFSET 22
+#define JZ_DMA_CMD_RDIL_OFFSET 16
+#define JZ_DMA_CMD_SRC_WIDTH_OFFSET 14
+#define JZ_DMA_CMD_DST_WIDTH_OFFSET 12
+#define JZ_DMA_CMD_TRANSFER_SIZE_OFFSET 8
+#define JZ_DMA_CMD_MODE_OFFSET 7
+
+#define JZ_DMA_CTRL_PRIORITY_MASK	(0x3 << 8)
+#define JZ_DMA_CTRL_HALT		BIT(3)
+#define JZ_DMA_CTRL_ADDRESS_ERROR	BIT(2)
+#define JZ_DMA_CTRL_ENABLE		BIT(0)
+
+
+static void __iomem *jz4740_dma_base;
+static spinlock_t jz4740_dma_lock;
+
+static inline uint32_t jz4740_dma_read(size_t reg)
+{
+	return readl(jz4740_dma_base + reg);
+}
+
+static inline void jz4740_dma_write(size_t reg, uint32_t val)
+{
+	writel(val, jz4740_dma_base + reg);
+}
+
+static inline void jz4740_dma_write_mask(size_t reg, uint32_t val, uint32_t mask)
+{
+	uint32_t val2;
+	val2 = jz4740_dma_read(reg);
+	val2 &= ~mask;
+	val2 |= val;
+	jz4740_dma_write(reg, val2);
+}
+
+struct jz4740_dma_chan {
+	unsigned int id;
+	void *dev;
+	const char *name;
+
+	enum jz4740_dma_flags flags;
+	uint32_t transfer_shift;
+
+	jz4740_dma_complete_callback_t complete_cb;
+
+	unsigned used:1;
+};
+
+#define JZ4740_DMA_CHANNEL(_id) { .id = _id }
+
+struct jz4740_dma_chan jz4740_dma_channels[] = {
+	JZ4740_DMA_CHANNEL(0),
+	JZ4740_DMA_CHANNEL(1),
+	JZ4740_DMA_CHANNEL(2),
+	JZ4740_DMA_CHANNEL(3),
+	JZ4740_DMA_CHANNEL(4),
+	JZ4740_DMA_CHANNEL(5),
+};
+
+struct jz4740_dma_chan *jz4740_dma_request(void *dev, const char *name)
+{
+	unsigned int i;
+	struct jz4740_dma_chan *dma = NULL;
+
+	spin_lock(&jz4740_dma_lock);
+
+	for (i = 0; i < ARRAY_SIZE(jz4740_dma_channels); ++i) {
+		if (!jz4740_dma_channels[i].used) {
+			dma = &jz4740_dma_channels[i];
+			dma->used = 1;
+			break;
+		}
+	}
+
+	spin_unlock(&jz4740_dma_lock);
+
+	if (!dma)
+		return NULL;
+
+	dma->dev = dev;
+	dma->name = name;
+
+	return dma;
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_request);
+
+void jz4740_dma_configure(struct jz4740_dma_chan *dma,
+	const struct jz4740_dma_config *config)
+{
+	uint32_t cmd;
+
+	switch (config->transfer_size) {
+	case JZ4740_DMA_TRANSFER_SIZE_2BYTE:
+		dma->transfer_shift = 1;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_4BYTE:
+		dma->transfer_shift = 2;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_16BYTE:
+		dma->transfer_shift = 4;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_32BYTE:
+		dma->transfer_shift = 5;
+		break;
+	default:
+		dma->transfer_shift = 0;
+		break;
+	}
+
+	cmd = config->flags << JZ_DMA_CMD_FLAGS_OFFSET;
+	cmd |= config->src_width << JZ_DMA_CMD_SRC_WIDTH_OFFSET;
+	cmd |= config->dst_width << JZ_DMA_CMD_DST_WIDTH_OFFSET;
+	cmd |= config->transfer_size << JZ_DMA_CMD_TRANSFER_SIZE_OFFSET;
+	cmd |= config->mode << JZ_DMA_CMD_MODE_OFFSET;
+	cmd |= JZ_DMA_CMD_TRANSFER_IRQ_ENABLE;
+
+	jz4740_dma_write(JZ_REG_DMA_CMD(dma->id), cmd);
+	jz4740_dma_write(JZ_REG_DMA_STATUS_CTRL(dma->id), 0);
+	jz4740_dma_write(JZ_REG_DMA_REQ_TYPE(dma->id), config->request_type);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_configure);
+
+void jz4740_dma_set_src_addr(struct jz4740_dma_chan *dma, dma_addr_t src)
+{
+	jz4740_dma_write(JZ_REG_DMA_SRC_ADDR(dma->id), src);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_set_src_addr);
+
+void jz4740_dma_set_dst_addr(struct jz4740_dma_chan *dma, dma_addr_t dst)
+{
+	jz4740_dma_write(JZ_REG_DMA_DST_ADDR(dma->id), dst);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_set_dst_addr);
+
+void jz4740_dma_set_transfer_count(struct jz4740_dma_chan *dma, uint32_t count)
+{
+	count >>= dma->transfer_shift;
+	jz4740_dma_write(JZ_REG_DMA_TRANSFER_COUNT(dma->id), count);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_set_transfer_count);
+
+void jz4740_dma_set_complete_cb(struct jz4740_dma_chan *dma,
+	jz4740_dma_complete_callback_t cb)
+{
+	dma->complete_cb = cb;
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_set_complete_cb);
+
+void jz4740_dma_free(struct jz4740_dma_chan *dma)
+{
+	dma->dev = NULL;
+	dma->complete_cb = NULL;
+	dma->used = 0;
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_free);
+
+void jz4740_dma_enable(struct jz4740_dma_chan *dma)
+{
+	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id),
+			JZ_DMA_STATUS_CTRL_NO_DESC | JZ_DMA_STATUS_CTRL_ENABLE,
+			JZ_DMA_STATUS_CTRL_HALT | JZ_DMA_STATUS_CTRL_NO_DESC |
+			JZ_DMA_STATUS_CTRL_ENABLE);
+
+	jz4740_dma_write_mask(JZ_REG_DMA_CTRL,
+			JZ_DMA_CTRL_ENABLE,
+			JZ_DMA_CTRL_HALT | JZ_DMA_CTRL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_enable);
+
+void jz4740_dma_disable(struct jz4740_dma_chan *dma)
+{
+	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id), 0,
+			JZ_DMA_STATUS_CTRL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_disable);
+
+uint32_t jz4740_dma_get_residue(const struct jz4740_dma_chan *dma)
+{
+	uint32_t residue;
+	residue = jz4740_dma_read(JZ_REG_DMA_TRANSFER_COUNT(dma->id));
+	return residue << dma->transfer_shift;
+}
+EXPORT_SYMBOL_GPL(jz4740_dma_get_residue);
+
+static void jz4740_dma_chan_irq(struct jz4740_dma_chan *dma)
+{
+	uint32_t status;
+
+	status = jz4740_dma_read(JZ_REG_DMA_STATUS_CTRL(dma->id));
+
+	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id), 0,
+		JZ_DMA_STATUS_CTRL_ENABLE | JZ_DMA_STATUS_CTRL_TRANSFER_DONE);
+
+	if (dma->complete_cb)
+		dma->complete_cb(dma, 0, dma->dev);
+}
+
+static irqreturn_t jz4740_dma_irq(int irq, void *dev_id)
+{
+	uint32_t irq_status;
+	unsigned int i;
+
+	irq_status = readl(jz4740_dma_base + JZ_REG_DMA_IRQ);
+
+	for (i = 0; i < 6; ++i) {
+		if (irq_status & (1 << i))
+			jz4740_dma_chan_irq(&jz4740_dma_channels[i]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int jz4740_dma_init(void)
+{
+	unsigned int ret;
+
+	jz4740_dma_base = ioremap(JZ4740_DMAC_BASE_ADDR, 0x400);
+
+	if (!jz4740_dma_base)
+		return -EBUSY;
+
+	spin_lock_init(&jz4740_dma_lock);
+
+	ret = request_irq(JZ4740_IRQ_DMAC, jz4740_dma_irq, 0, "DMA", NULL);
+
+	if (ret)
+		printk(KERN_ERR "JZ4740 DMA: Failed to request irq: %d\n", ret);
+
+	return ret;
+}
+arch_initcall(jz4740_dma_init);
-- 
1.5.6.5
