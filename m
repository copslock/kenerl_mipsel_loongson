Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 22:36:13 +0200 (CEST)
Received: from smtp-out-103.synserver.de ([212.40.185.103]:1035 "EHLO
        smtp-out-103.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831922Ab3EWUeRKHosN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 22:34:17 +0200
Received: (qmail 9259 invoked by uid 0); 23 May 2013 20:34:09 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 8636
Received: from ppp-188-174-34-169.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [188.174.34.169]
  by 217.119.54.87 with SMTP; 23 May 2013 20:34:09 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] MIPS: jz4740: Remove custom DMA API
Date:   Thu, 23 May 2013 22:36:27 +0200
Message-Id: <1369341387-19147-7-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1369341387-19147-1-git-send-email-lars@metafoo.de>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Now that all users of the custom jz4740 DMA API have been converted to use
the dmaengine API instead we can remove the custom API and move all the code
talking to the hardware to the dmaengine driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/dma.h |  56 ------
 arch/mips/jz4740/Makefile               |   2 +-
 arch/mips/jz4740/dma.c                  | 307 --------------------------------
 drivers/dma/dma-jz4740.c                | 268 +++++++++++++++++++++++-----
 4 files changed, 229 insertions(+), 404 deletions(-)
 delete mode 100644 arch/mips/jz4740/dma.c

diff --git a/arch/mips/include/asm/mach-jz4740/dma.h b/arch/mips/include/asm/mach-jz4740/dma.h
index 98b4e7c..509cd58 100644
--- a/arch/mips/include/asm/mach-jz4740/dma.h
+++ b/arch/mips/include/asm/mach-jz4740/dma.h
@@ -16,8 +16,6 @@
 #ifndef __ASM_MACH_JZ4740_DMA_H__
 #define __ASM_MACH_JZ4740_DMA_H__
 
-struct jz4740_dma_chan;
-
 enum jz4740_dma_request_type {
 	JZ4740_DMA_TYPE_AUTO_REQUEST	= 8,
 	JZ4740_DMA_TYPE_UART_TRANSMIT	= 20,
@@ -33,58 +31,4 @@ enum jz4740_dma_request_type {
 	JZ4740_DMA_TYPE_SLCD		= 30,
 };
 
-enum jz4740_dma_width {
-	JZ4740_DMA_WIDTH_32BIT	= 0,
-	JZ4740_DMA_WIDTH_8BIT	= 1,
-	JZ4740_DMA_WIDTH_16BIT	= 2,
-};
-
-enum jz4740_dma_transfer_size {
-	JZ4740_DMA_TRANSFER_SIZE_4BYTE	= 0,
-	JZ4740_DMA_TRANSFER_SIZE_1BYTE	= 1,
-	JZ4740_DMA_TRANSFER_SIZE_2BYTE	= 2,
-	JZ4740_DMA_TRANSFER_SIZE_16BYTE = 3,
-	JZ4740_DMA_TRANSFER_SIZE_32BYTE = 4,
-};
-
-enum jz4740_dma_flags {
-	JZ4740_DMA_SRC_AUTOINC = 0x2,
-	JZ4740_DMA_DST_AUTOINC = 0x1,
-};
-
-enum jz4740_dma_mode {
-	JZ4740_DMA_MODE_SINGLE	= 0,
-	JZ4740_DMA_MODE_BLOCK	= 1,
-};
-
-struct jz4740_dma_config {
-	enum jz4740_dma_width src_width;
-	enum jz4740_dma_width dst_width;
-	enum jz4740_dma_transfer_size transfer_size;
-	enum jz4740_dma_request_type request_type;
-	enum jz4740_dma_flags flags;
-	enum jz4740_dma_mode mode;
-};
-
-typedef void (*jz4740_dma_complete_callback_t)(struct jz4740_dma_chan *, int, void *);
-
-struct jz4740_dma_chan *jz4740_dma_request(void *dev, const char *name);
-void jz4740_dma_free(struct jz4740_dma_chan *dma);
-
-void jz4740_dma_configure(struct jz4740_dma_chan *dma,
-	const struct jz4740_dma_config *config);
-
-
-void jz4740_dma_enable(struct jz4740_dma_chan *dma);
-void jz4740_dma_disable(struct jz4740_dma_chan *dma);
-
-void jz4740_dma_set_src_addr(struct jz4740_dma_chan *dma, dma_addr_t src);
-void jz4740_dma_set_dst_addr(struct jz4740_dma_chan *dma, dma_addr_t dst);
-void jz4740_dma_set_transfer_count(struct jz4740_dma_chan *dma, uint32_t count);
-
-uint32_t jz4740_dma_get_residue(const struct jz4740_dma_chan *dma);
-
-void jz4740_dma_set_complete_cb(struct jz4740_dma_chan *dma,
-	jz4740_dma_complete_callback_t cb);
-
 #endif	/* __ASM_JZ4740_DMA_H__ */
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 63bad0e..28e5535 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y += prom.o irq.o time.o reset.o setup.o dma.o \
+obj-y += prom.o irq.o time.o reset.o setup.o \
 	gpio.o clock.o platform.o timer.o serial.o
 
 obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
diff --git a/arch/mips/jz4740/dma.c b/arch/mips/jz4740/dma.c
deleted file mode 100644
index 0e34b97..0000000
--- a/arch/mips/jz4740/dma.c
+++ /dev/null
@@ -1,307 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC DMA support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/clk.h>
-#include <linux/interrupt.h>
-
-#include <linux/dma-mapping.h>
-#include <asm/mach-jz4740/dma.h>
-#include <asm/mach-jz4740/base.h>
-
-#define JZ_REG_DMA_SRC_ADDR(x)		(0x00 + (x) * 0x20)
-#define JZ_REG_DMA_DST_ADDR(x)		(0x04 + (x) * 0x20)
-#define JZ_REG_DMA_TRANSFER_COUNT(x)	(0x08 + (x) * 0x20)
-#define JZ_REG_DMA_REQ_TYPE(x)		(0x0C + (x) * 0x20)
-#define JZ_REG_DMA_STATUS_CTRL(x)	(0x10 + (x) * 0x20)
-#define JZ_REG_DMA_CMD(x)		(0x14 + (x) * 0x20)
-#define JZ_REG_DMA_DESC_ADDR(x)		(0x18 + (x) * 0x20)
-
-#define JZ_REG_DMA_CTRL			0x300
-#define JZ_REG_DMA_IRQ			0x304
-#define JZ_REG_DMA_DOORBELL		0x308
-#define JZ_REG_DMA_DOORBELL_SET		0x30C
-
-#define JZ_DMA_STATUS_CTRL_NO_DESC		BIT(31)
-#define JZ_DMA_STATUS_CTRL_DESC_INV		BIT(6)
-#define JZ_DMA_STATUS_CTRL_ADDR_ERR		BIT(4)
-#define JZ_DMA_STATUS_CTRL_TRANSFER_DONE	BIT(3)
-#define JZ_DMA_STATUS_CTRL_HALT			BIT(2)
-#define JZ_DMA_STATUS_CTRL_COUNT_TERMINATE	BIT(1)
-#define JZ_DMA_STATUS_CTRL_ENABLE		BIT(0)
-
-#define JZ_DMA_CMD_SRC_INC			BIT(23)
-#define JZ_DMA_CMD_DST_INC			BIT(22)
-#define JZ_DMA_CMD_RDIL_MASK			(0xf << 16)
-#define JZ_DMA_CMD_SRC_WIDTH_MASK		(0x3 << 14)
-#define JZ_DMA_CMD_DST_WIDTH_MASK		(0x3 << 12)
-#define JZ_DMA_CMD_INTERVAL_LENGTH_MASK		(0x7 << 8)
-#define JZ_DMA_CMD_BLOCK_MODE			BIT(7)
-#define JZ_DMA_CMD_DESC_VALID			BIT(4)
-#define JZ_DMA_CMD_DESC_VALID_MODE		BIT(3)
-#define JZ_DMA_CMD_VALID_IRQ_ENABLE		BIT(2)
-#define JZ_DMA_CMD_TRANSFER_IRQ_ENABLE		BIT(1)
-#define JZ_DMA_CMD_LINK_ENABLE			BIT(0)
-
-#define JZ_DMA_CMD_FLAGS_OFFSET 22
-#define JZ_DMA_CMD_RDIL_OFFSET 16
-#define JZ_DMA_CMD_SRC_WIDTH_OFFSET 14
-#define JZ_DMA_CMD_DST_WIDTH_OFFSET 12
-#define JZ_DMA_CMD_TRANSFER_SIZE_OFFSET 8
-#define JZ_DMA_CMD_MODE_OFFSET 7
-
-#define JZ_DMA_CTRL_PRIORITY_MASK	(0x3 << 8)
-#define JZ_DMA_CTRL_HALT		BIT(3)
-#define JZ_DMA_CTRL_ADDRESS_ERROR	BIT(2)
-#define JZ_DMA_CTRL_ENABLE		BIT(0)
-
-
-static void __iomem *jz4740_dma_base;
-static spinlock_t jz4740_dma_lock;
-
-static inline uint32_t jz4740_dma_read(size_t reg)
-{
-	return readl(jz4740_dma_base + reg);
-}
-
-static inline void jz4740_dma_write(size_t reg, uint32_t val)
-{
-	writel(val, jz4740_dma_base + reg);
-}
-
-static inline void jz4740_dma_write_mask(size_t reg, uint32_t val, uint32_t mask)
-{
-	uint32_t val2;
-	val2 = jz4740_dma_read(reg);
-	val2 &= ~mask;
-	val2 |= val;
-	jz4740_dma_write(reg, val2);
-}
-
-struct jz4740_dma_chan {
-	unsigned int id;
-	void *dev;
-	const char *name;
-
-	enum jz4740_dma_flags flags;
-	uint32_t transfer_shift;
-
-	jz4740_dma_complete_callback_t complete_cb;
-
-	unsigned used:1;
-};
-
-#define JZ4740_DMA_CHANNEL(_id) { .id = _id }
-
-struct jz4740_dma_chan jz4740_dma_channels[] = {
-	JZ4740_DMA_CHANNEL(0),
-	JZ4740_DMA_CHANNEL(1),
-	JZ4740_DMA_CHANNEL(2),
-	JZ4740_DMA_CHANNEL(3),
-	JZ4740_DMA_CHANNEL(4),
-	JZ4740_DMA_CHANNEL(5),
-};
-
-struct jz4740_dma_chan *jz4740_dma_request(void *dev, const char *name)
-{
-	unsigned int i;
-	struct jz4740_dma_chan *dma = NULL;
-
-	spin_lock(&jz4740_dma_lock);
-
-	for (i = 0; i < ARRAY_SIZE(jz4740_dma_channels); ++i) {
-		if (!jz4740_dma_channels[i].used) {
-			dma = &jz4740_dma_channels[i];
-			dma->used = 1;
-			break;
-		}
-	}
-
-	spin_unlock(&jz4740_dma_lock);
-
-	if (!dma)
-		return NULL;
-
-	dma->dev = dev;
-	dma->name = name;
-
-	return dma;
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_request);
-
-void jz4740_dma_configure(struct jz4740_dma_chan *dma,
-	const struct jz4740_dma_config *config)
-{
-	uint32_t cmd;
-
-	switch (config->transfer_size) {
-	case JZ4740_DMA_TRANSFER_SIZE_2BYTE:
-		dma->transfer_shift = 1;
-		break;
-	case JZ4740_DMA_TRANSFER_SIZE_4BYTE:
-		dma->transfer_shift = 2;
-		break;
-	case JZ4740_DMA_TRANSFER_SIZE_16BYTE:
-		dma->transfer_shift = 4;
-		break;
-	case JZ4740_DMA_TRANSFER_SIZE_32BYTE:
-		dma->transfer_shift = 5;
-		break;
-	default:
-		dma->transfer_shift = 0;
-		break;
-	}
-
-	cmd = config->flags << JZ_DMA_CMD_FLAGS_OFFSET;
-	cmd |= config->src_width << JZ_DMA_CMD_SRC_WIDTH_OFFSET;
-	cmd |= config->dst_width << JZ_DMA_CMD_DST_WIDTH_OFFSET;
-	cmd |= config->transfer_size << JZ_DMA_CMD_TRANSFER_SIZE_OFFSET;
-	cmd |= config->mode << JZ_DMA_CMD_MODE_OFFSET;
-	cmd |= JZ_DMA_CMD_TRANSFER_IRQ_ENABLE;
-
-	jz4740_dma_write(JZ_REG_DMA_CMD(dma->id), cmd);
-	jz4740_dma_write(JZ_REG_DMA_STATUS_CTRL(dma->id), 0);
-	jz4740_dma_write(JZ_REG_DMA_REQ_TYPE(dma->id), config->request_type);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_configure);
-
-void jz4740_dma_set_src_addr(struct jz4740_dma_chan *dma, dma_addr_t src)
-{
-	jz4740_dma_write(JZ_REG_DMA_SRC_ADDR(dma->id), src);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_set_src_addr);
-
-void jz4740_dma_set_dst_addr(struct jz4740_dma_chan *dma, dma_addr_t dst)
-{
-	jz4740_dma_write(JZ_REG_DMA_DST_ADDR(dma->id), dst);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_set_dst_addr);
-
-void jz4740_dma_set_transfer_count(struct jz4740_dma_chan *dma, uint32_t count)
-{
-	count >>= dma->transfer_shift;
-	jz4740_dma_write(JZ_REG_DMA_TRANSFER_COUNT(dma->id), count);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_set_transfer_count);
-
-void jz4740_dma_set_complete_cb(struct jz4740_dma_chan *dma,
-	jz4740_dma_complete_callback_t cb)
-{
-	dma->complete_cb = cb;
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_set_complete_cb);
-
-void jz4740_dma_free(struct jz4740_dma_chan *dma)
-{
-	dma->dev = NULL;
-	dma->complete_cb = NULL;
-	dma->used = 0;
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_free);
-
-void jz4740_dma_enable(struct jz4740_dma_chan *dma)
-{
-	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id),
-			JZ_DMA_STATUS_CTRL_NO_DESC | JZ_DMA_STATUS_CTRL_ENABLE,
-			JZ_DMA_STATUS_CTRL_HALT | JZ_DMA_STATUS_CTRL_NO_DESC |
-			JZ_DMA_STATUS_CTRL_ENABLE);
-
-	jz4740_dma_write_mask(JZ_REG_DMA_CTRL,
-			JZ_DMA_CTRL_ENABLE,
-			JZ_DMA_CTRL_HALT | JZ_DMA_CTRL_ENABLE);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_enable);
-
-void jz4740_dma_disable(struct jz4740_dma_chan *dma)
-{
-	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id), 0,
-			JZ_DMA_STATUS_CTRL_ENABLE);
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_disable);
-
-uint32_t jz4740_dma_get_residue(const struct jz4740_dma_chan *dma)
-{
-	uint32_t residue;
-	residue = jz4740_dma_read(JZ_REG_DMA_TRANSFER_COUNT(dma->id));
-	return residue << dma->transfer_shift;
-}
-EXPORT_SYMBOL_GPL(jz4740_dma_get_residue);
-
-static void jz4740_dma_chan_irq(struct jz4740_dma_chan *dma)
-{
-	(void) jz4740_dma_read(JZ_REG_DMA_STATUS_CTRL(dma->id));
-
-	jz4740_dma_write_mask(JZ_REG_DMA_STATUS_CTRL(dma->id), 0,
-		JZ_DMA_STATUS_CTRL_ENABLE | JZ_DMA_STATUS_CTRL_TRANSFER_DONE);
-
-	if (dma->complete_cb)
-		dma->complete_cb(dma, 0, dma->dev);
-}
-
-static irqreturn_t jz4740_dma_irq(int irq, void *dev_id)
-{
-	uint32_t irq_status;
-	unsigned int i;
-
-	irq_status = readl(jz4740_dma_base + JZ_REG_DMA_IRQ);
-
-	for (i = 0; i < 6; ++i) {
-		if (irq_status & (1 << i))
-			jz4740_dma_chan_irq(&jz4740_dma_channels[i]);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int jz4740_dma_init(void)
-{
-	struct clk *clk;
-	unsigned int ret;
-
-	jz4740_dma_base = ioremap(JZ4740_DMAC_BASE_ADDR, 0x400);
-
-	if (!jz4740_dma_base)
-		return -EBUSY;
-
-	spin_lock_init(&jz4740_dma_lock);
-
-	clk = clk_get(NULL, "dma");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		printk(KERN_ERR "JZ4740 DMA: Failed to request clock: %d\n",
-				ret);
-		goto err_iounmap;
-	}
-
-	ret = request_irq(JZ4740_IRQ_DMAC, jz4740_dma_irq, 0, "DMA", NULL);
-	if (ret) {
-		printk(KERN_ERR "JZ4740 DMA: Failed to request irq: %d\n", ret);
-		goto err_clkput;
-	}
-
-	clk_prepare_enable(clk);
-
-	return 0;
-
-err_clkput:
-	clk_put(clk);
-
-err_iounmap:
-	iounmap(jz4740_dma_base);
-	return ret;
-}
-arch_initcall(jz4740_dma_init);
diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index 210bac0..a57cfdc 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -22,11 +22,83 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/irq.h>
+#include <linux/clk.h>
 
 #include <asm/mach-jz4740/dma.h>
 
 #include "virt-dma.h"
 
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
+#define JZ_DMA_CTRL_PRIORITY_MASK		(0x3 << 8)
+#define JZ_DMA_CTRL_HALT			BIT(3)
+#define JZ_DMA_CTRL_ADDRESS_ERROR		BIT(2)
+#define JZ_DMA_CTRL_ENABLE			BIT(0)
+
+enum jz4740_dma_width {
+	JZ4740_DMA_WIDTH_32BIT	= 0,
+	JZ4740_DMA_WIDTH_8BIT	= 1,
+	JZ4740_DMA_WIDTH_16BIT	= 2,
+};
+
+enum jz4740_dma_transfer_size {
+	JZ4740_DMA_TRANSFER_SIZE_4BYTE	= 0,
+	JZ4740_DMA_TRANSFER_SIZE_1BYTE	= 1,
+	JZ4740_DMA_TRANSFER_SIZE_2BYTE	= 2,
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
 struct jz4740_dma_sg {
 	dma_addr_t addr;
 	unsigned int len;
@@ -44,9 +116,10 @@ struct jz4740_dma_desc {
 
 struct jz4740_dmaengine_chan {
 	struct virt_dma_chan vchan;
-	struct jz4740_dma_chan *jz_chan;
+	unsigned int id;
 
 	struct dma_slave_config config;
+	unsigned int transfer_shift;
 
 	struct jz4740_dma_desc *desc;
 	unsigned int next_sg;
@@ -54,10 +127,19 @@ struct jz4740_dmaengine_chan {
 
 struct jz4740_dma_dev {
 	struct dma_device ddev;
+	void __iomem *base;
+	struct clk *clk;
 
 	struct jz4740_dmaengine_chan chan[6];
 };
 
+static struct jz4740_dma_dev *jz4740_dma_chan_get_dev(
+	struct jz4740_dmaengine_chan *chan)
+{
+	return container_of(chan->vchan.chan.device, struct jz4740_dma_dev,
+		ddev);
+}
+
 static struct jz4740_dmaengine_chan *to_jz4740_dma_chan(struct dma_chan *c)
 {
 	return container_of(c, struct jz4740_dmaengine_chan, vchan.chan);
@@ -68,6 +150,29 @@ static struct jz4740_dma_desc *to_jz4740_dma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct jz4740_dma_desc, vdesc);
 }
 
+static inline uint32_t jz4740_dma_read(struct jz4740_dma_dev *dmadev,
+	unsigned int reg)
+{
+	return readl(dmadev->base + reg);
+}
+
+static inline void jz4740_dma_write(struct jz4740_dma_dev *dmadev,
+	unsigned reg, uint32_t val)
+{
+	writel(val, dmadev->base + reg);
+}
+
+static inline void jz4740_dma_write_mask(struct jz4740_dma_dev *dmadev,
+	unsigned int reg, uint32_t val, uint32_t mask)
+{
+	uint32_t tmp;
+
+	tmp = jz4740_dma_read(dmadev, reg);
+	tmp &= ~mask;
+	tmp |= val;
+	jz4740_dma_write(dmadev, reg, tmp);
+}
+
 static struct jz4740_dma_desc *jz4740_dma_alloc_desc(unsigned int num_sgs)
 {
 	return kzalloc(sizeof(struct jz4740_dma_desc) +
@@ -106,30 +211,60 @@ static int jz4740_dma_slave_config(struct dma_chan *c,
 	const struct dma_slave_config *config)
 {
 	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
-	struct jz4740_dma_config jzcfg;
+	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
+	enum jz4740_dma_width src_width;
+	enum jz4740_dma_width dst_width;
+	enum jz4740_dma_transfer_size transfer_size;
+	enum jz4740_dma_flags flags;
+	uint32_t cmd;
 
 	switch (config->direction) {
 	case DMA_MEM_TO_DEV:
-		jzcfg.flags = JZ4740_DMA_SRC_AUTOINC;
-		jzcfg.transfer_size = jz4740_dma_maxburst(config->dst_maxburst);
+		flags = JZ4740_DMA_SRC_AUTOINC;
+		transfer_size = jz4740_dma_maxburst(config->dst_maxburst);
 		break;
 	case DMA_DEV_TO_MEM:
-		jzcfg.flags = JZ4740_DMA_DST_AUTOINC;
-		jzcfg.transfer_size = jz4740_dma_maxburst(config->src_maxburst);
+		flags = JZ4740_DMA_DST_AUTOINC;
+		transfer_size = jz4740_dma_maxburst(config->src_maxburst);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-
-	jzcfg.src_width = jz4740_dma_width(config->src_addr_width);
-	jzcfg.dst_width = jz4740_dma_width(config->dst_addr_width);
-	jzcfg.mode = JZ4740_DMA_MODE_SINGLE;
-	jzcfg.request_type = config->slave_id;
+	src_width = jz4740_dma_width(config->src_addr_width);
+	dst_width = jz4740_dma_width(config->dst_addr_width);
 
 	chan->config = *config;
 
-	jz4740_dma_configure(chan->jz_chan, &jzcfg);
+	switch (transfer_size) {
+	case JZ4740_DMA_TRANSFER_SIZE_2BYTE:
+		chan->transfer_shift = 1;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_4BYTE:
+		chan->transfer_shift = 2;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_16BYTE:
+		chan->transfer_shift = 4;
+		break;
+	case JZ4740_DMA_TRANSFER_SIZE_32BYTE:
+		chan->transfer_shift = 5;
+		break;
+	default:
+		chan->transfer_shift = 0;
+		break;
+	}
+
+	cmd = flags << JZ_DMA_CMD_FLAGS_OFFSET;
+	cmd |= src_width << JZ_DMA_CMD_SRC_WIDTH_OFFSET;
+	cmd |= dst_width << JZ_DMA_CMD_DST_WIDTH_OFFSET;
+	cmd |= transfer_size << JZ_DMA_CMD_TRANSFER_SIZE_OFFSET;
+	cmd |= JZ4740_DMA_MODE_SINGLE << JZ_DMA_CMD_MODE_OFFSET;
+	cmd |= JZ_DMA_CMD_TRANSFER_IRQ_ENABLE;
+
+	jz4740_dma_write(dmadev, JZ_REG_DMA_CMD(chan->id), cmd);
+	jz4740_dma_write(dmadev, JZ_REG_DMA_STATUS_CTRL(chan->id), 0);
+	jz4740_dma_write(dmadev, JZ_REG_DMA_REQ_TYPE(chan->id),
+		config->slave_id);
 
 	return 0;
 }
@@ -137,11 +272,13 @@ static int jz4740_dma_slave_config(struct dma_chan *c,
 static int jz4740_dma_terminate_all(struct dma_chan *c)
 {
 	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
+	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
-	jz4740_dma_disable(chan->jz_chan);
+	jz4740_dma_write_mask(dmadev, JZ_REG_DMA_STATUS_CTRL(chan->id), 0,
+			JZ_DMA_STATUS_CTRL_ENABLE);
 	chan->desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
@@ -168,10 +305,12 @@ static int jz4740_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 
 static int jz4740_dma_start_transfer(struct jz4740_dmaengine_chan *chan)
 {
+	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
 	struct virt_dma_desc *vdesc;
 	struct jz4740_dma_sg *sg;
 
-	jz4740_dma_disable(chan->jz_chan);
+	jz4740_dma_write_mask(dmadev, JZ_REG_DMA_STATUS_CTRL(chan->id), 0,
+			JZ_DMA_STATUS_CTRL_ENABLE);
 
 	if (!chan->desc) {
 		vdesc = vchan_next_desc(&chan->vchan);
@@ -187,26 +326,35 @@ static int jz4740_dma_start_transfer(struct jz4740_dmaengine_chan *chan)
 	sg = &chan->desc->sg[chan->next_sg];
 
 	if (chan->desc->direction == DMA_MEM_TO_DEV) {
-		jz4740_dma_set_src_addr(chan->jz_chan, sg->addr);
-		jz4740_dma_set_dst_addr(chan->jz_chan, chan->config.dst_addr);
+		jz4740_dma_write(dmadev, JZ_REG_DMA_SRC_ADDR(chan->id),
+			sg->addr);
+		jz4740_dma_write(dmadev, JZ_REG_DMA_DST_ADDR(chan->id),
+			chan->config.dst_addr);
 	} else {
-		jz4740_dma_set_src_addr(chan->jz_chan, chan->config.src_addr);
-		jz4740_dma_set_dst_addr(chan->jz_chan, sg->addr);
+		jz4740_dma_write(dmadev, JZ_REG_DMA_SRC_ADDR(chan->id),
+			chan->config.src_addr);
+		jz4740_dma_write(dmadev, JZ_REG_DMA_DST_ADDR(chan->id),
+			sg->addr);
 	}
-	jz4740_dma_set_transfer_count(chan->jz_chan, sg->len);
+	jz4740_dma_write(dmadev, JZ_REG_DMA_TRANSFER_COUNT(chan->id),
+			sg->len >> chan->transfer_shift);
 
 	chan->next_sg++;
 
-	jz4740_dma_enable(chan->jz_chan);
+	jz4740_dma_write_mask(dmadev, JZ_REG_DMA_STATUS_CTRL(chan->id),
+			JZ_DMA_STATUS_CTRL_NO_DESC | JZ_DMA_STATUS_CTRL_ENABLE,
+			JZ_DMA_STATUS_CTRL_HALT | JZ_DMA_STATUS_CTRL_NO_DESC |
+			JZ_DMA_STATUS_CTRL_ENABLE);
+
+	jz4740_dma_write_mask(dmadev, JZ_REG_DMA_CTRL,
+			JZ_DMA_CTRL_ENABLE,
+			JZ_DMA_CTRL_HALT | JZ_DMA_CTRL_ENABLE);
 
 	return 0;
 }
 
-static void jz4740_dma_complete_cb(struct jz4740_dma_chan *jz_chan, int error,
-	void *devid)
+static void jz4740_dma_chan_irq(struct jz4740_dmaengine_chan *chan)
 {
-	struct jz4740_dmaengine_chan *chan = devid;
-
 	spin_lock(&chan->vchan.lock);
 	if (chan->desc) {
 		if (chan->desc && chan->desc->cyclic) {
@@ -222,6 +370,28 @@ static void jz4740_dma_complete_cb(struct jz4740_dma_chan *jz_chan, int error,
 	spin_unlock(&chan->vchan.lock);
 }
 
+static irqreturn_t jz4740_dma_irq(int irq, void *devid)
+{
+	struct jz4740_dma_dev *dmadev = devid;
+	uint32_t irq_status;
+	unsigned int i;
+
+	irq_status = readl(dmadev->base + JZ_REG_DMA_IRQ);
+
+	for (i = 0; i < 6; ++i) {
+		if (irq_status & (1 << i)) {
+			jz4740_dma_write_mask(dmadev,
+				JZ_REG_DMA_STATUS_CTRL(i), 0,
+				JZ_DMA_STATUS_CTRL_ENABLE |
+				JZ_DMA_STATUS_CTRL_TRANSFER_DONE);
+
+			jz4740_dma_chan_irq(&dmadev->chan[i]);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void jz4740_dma_issue_pending(struct dma_chan *c)
 {
 	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
@@ -293,7 +463,8 @@ static struct dma_async_tx_descriptor *jz4740_dma_prep_dma_cyclic(
 static size_t jz4740_dma_desc_residue(struct jz4740_dmaengine_chan *chan,
 	struct jz4740_dma_desc *desc, unsigned int next_sg)
 {
-	size_t residue = 0;
+	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
+	unsigned int residue, count;
 	unsigned int i;
 
 	residue = 0;
@@ -301,8 +472,11 @@ static size_t jz4740_dma_desc_residue(struct jz4740_dmaengine_chan *chan,
 	for (i = next_sg; i < desc->num_sgs; i++)
 		residue += desc->sg[i].len;
 
-	if (next_sg != 0)
-		residue += jz4740_dma_get_residue(chan->jz_chan);
+	if (next_sg != 0) {
+		count = jz4740_dma_read(dmadev,
+			JZ_REG_DMA_TRANSFER_COUNT(chan->id));
+		residue += count << chan->transfer_shift;
+	}
 
 	return residue;
 }
@@ -337,24 +511,12 @@ static enum dma_status jz4740_dma_tx_status(struct dma_chan *c,
 
 static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
 {
-	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
-
-	chan->jz_chan = jz4740_dma_request(chan, NULL);
-	if (!chan->jz_chan)
-		return -EBUSY;
-
-	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
-
 	return 0;
 }
 
 static void jz4740_dma_free_chan_resources(struct dma_chan *c)
 {
-	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
-
-	vchan_free_chan_resources(&chan->vchan);
-	jz4740_dma_free(chan->jz_chan);
-	chan->jz_chan = NULL;
+	vchan_free_chan_resources(to_virt_chan(c));
 }
 
 static void jz4740_dma_desc_free(struct virt_dma_desc *vdesc)
@@ -368,7 +530,9 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	struct jz4740_dma_dev *dmadev;
 	struct dma_device *dd;
 	unsigned int i;
+	struct resource *res;
 	int ret;
+	int irq;
 
 	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
 	if (!dmadev)
@@ -376,6 +540,17 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 
 	dd = &dmadev->ddev;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmadev->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dmadev->base))
+		return PTR_ERR(dmadev->base);
+
+	dmadev->clk = clk_get(&pdev->dev, "dma");
+	if (IS_ERR(dmadev->clk))
+		return PTR_ERR(dmadev->clk);
+
+	clk_prepare_enable(dmadev->clk);
+
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
 	dd->device_alloc_chan_resources = jz4740_dma_alloc_chan_resources;
@@ -391,6 +566,7 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 
 	for (i = 0; i < dd->chancnt; i++) {
 		chan = &dmadev->chan[i];
+		chan->id = i;
 		chan->vchan.desc_free = jz4740_dma_desc_free;
 		vchan_init(&chan->vchan, dd);
 	}
@@ -399,16 +575,28 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	irq = platform_get_irq(pdev, 0);
+	ret = request_irq(irq, jz4740_dma_irq, 0, dev_name(&pdev->dev), dmadev);
+	if (ret)
+		goto err_unregister;
+
 	platform_set_drvdata(pdev, dmadev);
 
 	return 0;
+
+err_unregister:
+	dma_async_device_unregister(dd);
+	return ret;
 }
 
 static int jz4740_dma_remove(struct platform_device *pdev)
 {
 	struct jz4740_dma_dev *dmadev = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
 
+	free_irq(irq, dmadev);
 	dma_async_device_unregister(&dmadev->ddev);
+	clk_disable_unprepare(dmadev->clk);
 
 	return 0;
 }
-- 
1.8.2.1
