Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:12:06 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34393 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026126AbcDFML3O1ky4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:29 +0200
Received: by mail-pa0-f67.google.com with SMTP id hb4so3931394pac.1;
        Wed, 06 Apr 2016 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8V5Zxsi04+zD2wv/winsdYSV4M251qsfTOT/t7vxCUw=;
        b=Y6W11Nt6XX0z5l2YF2qsryoXnoG3wzTsWZslz1Vs8Ofx9GWPjDWAK34UqPuCBWvo6Z
         t6Lb2Jr2kyKvIVyn2ZTTFwRDQ6wNBiySkoq/e++QNvZqFYHpCaiNIwMBeB19yVE6qHjS
         ossX/uqwmNq2gcUyWu8vyv7e791xW+6Vgp5kpen9/qxszqLbHjiIQ3yLp6qwDYWa03wu
         QwF8hiliAT8+g2PrqbxuBn7J3iOLSrsDyWltRs2A/6uPq1u3zKms3UxWg0vtURDUC0k2
         5eYejn2OMs0SBQkHPvLNWm8mvwrdXrEfrRsNM5SBBj/sbauBKFrMrWgm/OB1w6C8iaNZ
         8rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8V5Zxsi04+zD2wv/winsdYSV4M251qsfTOT/t7vxCUw=;
        b=S6eNZ8X0xkmNdCJcv8idXlSuCRoi6/GfJjUbVffzYU98s5fS3wM7UyEpnTT1zQNt04
         aKdwdxokaPZlDOsoyeENXyRfYmHKE7P1IaCN7eV+t7441k7bB0Jh1NXFRqrnFsFy1rBu
         FOhVqBVSV5UZFDMj9h/ZBY/4rGZPMVOgiz9yIOR4+SCrdJn+emdttsLsONfrBwbeloPT
         TVpkh47cNnDB0OKJIjCGDJ5HZu9nfZATAlC0lOoaF6R0bgqRr9i++5UxieStSPxAml4C
         /gF69FLSFiT5koUAd6KGy8eCaOFao9pg6at2j9Ln3qnyILDOTcXStZLIsCS6ud+A2mMm
         JorA==
X-Gm-Message-State: AD7BkJJbJo83Xp6APkv70n+p1G1pLIIpev7FcdPmoE8x+wJxnuPUgJU8nR2OCdgWGc3O4Q==
X-Received: by 10.66.249.41 with SMTP id yr9mr70564112pac.86.1459944683260;
        Wed, 06 Apr 2016 05:11:23 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.11.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:22 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 3/7] dmaengine: Loongson1: add Loongson1 dmaengine driver
Date:   Wed,  6 Apr 2016 20:09:33 +0800
Message-Id: <1459944577-6423-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
References: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch adds DMA Engine driver for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/dma/Kconfig         |   9 +
 drivers/dma/Makefile        |   1 +
 drivers/dma/loongson1-dma.c | 546 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 556 insertions(+)
 create mode 100644 drivers/dma/loongson1-dma.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d96d87c..835d212 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -527,6 +527,15 @@ config ZX_DMA
 	help
 	  Support the DMA engine for ZTE ZX296702 platform devices.
 
+config DMA_LOONGSON1
+	tristate "Loongson1 DMA support"
+	depends on MACH_LOONGSON32
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  This selects support for the DMA controller in Loongson1 SoCs,
+	  and is required by Loongson1 NAND Flash and AC97 support.
+
 
 # driver files
 source "drivers/dma/bestcomm/Kconfig"
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 6084127..b0eceb0 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_TI_DMA_CROSSBAR) += ti-dma-crossbar.o
 obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx296702_dma.o
+obj-$(CONFIG_DMA_LOONGSON1) += loongson1-dma.o
 
 obj-y += qcom/
 obj-y += xilinx/
diff --git a/drivers/dma/loongson1-dma.c b/drivers/dma/loongson1-dma.c
new file mode 100644
index 0000000..687eed7
--- /dev/null
+++ b/drivers/dma/loongson1-dma.c
@@ -0,0 +1,546 @@
+/*
+ * DMA Driver for Loongson 1 SoC
+ *
+ * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/dmapool.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dma.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+/* Loongson 1 DMA Register Definitions */
+#define DMA_CTRL		0x0
+
+/* DMA Control Register Bits */
+#define DMA_STOP		BIT(4)
+#define DMA_START		BIT(3)
+#define ASK_VALID		BIT(2)
+
+#define DMA_ADDR_MASK		(0xffffffc0)
+
+/* DMA H/W Descriptor Bits */
+#define NEXT_EN			BIT(0)
+
+/* DMA Command Register Bits */
+#define DMA_RAM2DEV		BIT(12)
+#define DMA_TRANS_OVER		BIT(3)
+#define DMA_SINGLE_TRANS_OVER	BIT(2)
+#define DMA_INT			BIT(1)
+#define DMA_INT_MASK		BIT(0)
+
+struct ls1x_dma_hwdesc {
+	u32 next;		/* next descriptor address */
+	u32 saddr;		/* memory DMA address */
+	u32 daddr;		/* device DMA address */
+	u32 length;
+	u32 stride;
+	u32 cycles;
+	u32 cmd;
+	u32 phys;		/* used by driver */
+} __aligned(64);
+
+struct ls1x_dma_desc {
+	struct virt_dma_desc vdesc;
+	struct ls1x_dma_chan *chan;
+
+	enum dma_transfer_direction dir;
+	enum dma_transaction_type type;
+
+	unsigned int nr_descs;	/* number of descriptors */
+	unsigned int nr_done;	/* number of completed descriptors */
+	struct ls1x_dma_hwdesc *desc[0];	/* DMA coherent descriptors */
+};
+
+struct ls1x_dma_chan {
+	struct virt_dma_chan vchan;
+	unsigned int id;
+	void __iomem *reg_base;
+	unsigned int irq;
+	struct dma_pool *desc_pool;
+
+	struct dma_slave_config config;
+
+	struct ls1x_dma_desc *dma_desc;
+	unsigned int curr_hwdesc;
+};
+
+struct ls1x_dma {
+	struct dma_device dma_dev;
+	struct clk *clk;
+	void __iomem *reg_base;
+
+	unsigned int nr_dma_chans;
+	struct ls1x_dma_chan dma_chan[0];
+};
+
+#define to_ls1x_dma_chan(chan)		\
+	container_of(chan, struct ls1x_dma_chan, vchan.chan)
+
+#define to_ls1x_dma_desc(vdesc)		\
+	container_of(vdesc, struct ls1x_dma_desc, vdesc)
+
+/* macros for registers read/write */
+#define chan_writel(chan, off, val)	\
+	__raw_writel((val), (chan)->reg_base + (off))
+
+#define chan_readl(chan, off)		\
+	__raw_readl((chan)->reg_base + (off))
+
+bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+	unsigned int chan_id = *(unsigned int *)param;
+
+	if (chan_id == dma_chan->id)
+		return true;
+	else
+		return false;
+}
+
+static void ls1x_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+
+	vchan_free_chan_resources(&dma_chan->vchan);
+	dma_pool_destroy(dma_chan->desc_pool);
+	dma_chan->desc_pool = NULL;
+}
+
+static int ls1x_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+
+	if (dma_chan->desc_pool)
+		return 0;
+
+	dma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
+					      chan->device->dev,
+					      sizeof(struct ls1x_dma_hwdesc),
+					      __alignof__(struct
+							  ls1x_dma_hwdesc), 0);
+	if (!dma_chan->desc_pool) {
+		dev_err(&chan->dev->device,
+			"failed to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct ls1x_dma_desc *dma_desc = to_ls1x_dma_desc(vdesc);
+	int i;
+
+	for (i = 0; i < dma_desc->nr_descs; i++)
+		dma_pool_free(dma_desc->chan->desc_pool, dma_desc->desc[i],
+			      dma_desc->desc[i]->phys);
+	kfree(dma_desc);
+}
+
+static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *dma_chan,
+						 int sg_len)
+{
+	struct ls1x_dma_desc *dma_desc;
+	struct dma_chan *chan = &dma_chan->vchan.chan;
+	dma_addr_t desc_phys;
+	int i;
+
+	dma_desc =
+	    kzalloc(sizeof(struct ls1x_dma_desc) +
+		    sg_len * sizeof(struct ls1x_dma_hwdesc *), GFP_NOWAIT);
+	if (!dma_desc) {
+		dev_err(&chan->dev->device,
+			"failed to allocate DMA descriptor\n");
+		return NULL;
+	}
+
+	for (i = 0; i < sg_len; i++) {
+		dma_desc->desc[i] = dma_pool_alloc(dma_chan->desc_pool,
+						   GFP_NOWAIT, &desc_phys);
+		if (!dma_desc->desc[i])
+			goto err;
+
+		/*memorize the physical address of descriptor */
+		dma_desc->desc[i]->phys = desc_phys;
+	}
+	dma_desc->chan = dma_chan;
+	dma_desc->nr_descs = sg_len;
+	dma_desc->nr_done = 0;
+
+	return dma_desc;
+err:
+	dev_err(&chan->dev->device, "failed to allocate H/W DMA descriptor\n");
+
+	while (--i >= 0)
+		dma_pool_free(dma_chan->desc_pool, dma_desc->desc[i],
+			      dma_desc->desc[i]->phys);
+	kfree(dma_desc);
+
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+ls1x_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		       unsigned int sg_len,
+		       enum dma_transfer_direction direction,
+		       unsigned long flags, void *context)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+	struct dma_slave_config *config = &dma_chan->config;
+	struct ls1x_dma_desc *dma_desc;
+	struct scatterlist *sg;
+	unsigned int dev_addr, bus_width, cmd, i;
+
+	if (!is_slave_direction(direction)) {
+		dev_err(&chan->dev->device, "invalid DMA direction\n");
+		return NULL;
+	}
+
+	dev_dbg(&chan->dev->device, "sg_len=%d, dir=%s, flags=0x%lx\n", sg_len,
+		direction == DMA_MEM_TO_DEV ? "to device" : "from device",
+		flags);
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		dev_addr = config->dst_addr;
+		bus_width = config->dst_addr_width;
+		cmd = DMA_RAM2DEV | DMA_INT;
+		break;
+	case DMA_DEV_TO_MEM:
+		dev_addr = config->src_addr;
+		bus_width = config->src_addr_width;
+		cmd = DMA_INT;
+		break;
+	default:
+		dev_err(&chan->dev->device,
+			"unsupported DMA transfer mode: %d\n", direction);
+		return NULL;
+	}
+
+	/*allocate DMA descriptors */
+	dma_desc = ls1x_dma_alloc_desc(dma_chan, sg_len);
+	if (!dma_desc)
+		return NULL;
+	dma_desc->dir = direction;
+	dma_desc->type = DMA_SLAVE;
+
+	/*config DMA descriptors */
+	for_each_sg(sgl, sg, sg_len, i) {
+		dma_addr_t buf_addr = sg_dma_address(sg);
+		size_t buf_len = sg_dma_len(sg);
+
+		if (!IS_ALIGNED(buf_addr, 4 * bus_width)) {
+			dev_err(&chan->dev->device,
+				"buf_addr is not aligned on %d-byte boundary\n",
+				4 * bus_width);
+			ls1x_dma_free_desc(&dma_desc->vdesc);
+			return NULL;
+		}
+
+		if (!IS_ALIGNED(buf_len, bus_width))
+			dev_warn(&chan->dev->device,
+				 "buf_len is not aligned on %d-byte boundary\n",
+				 bus_width);
+
+		dma_desc->desc[i]->saddr = buf_addr;
+		dma_desc->desc[i]->daddr = dev_addr;
+		dma_desc->desc[i]->length = buf_len / bus_width;
+		dma_desc->desc[i]->stride = 0;
+		dma_desc->desc[i]->cycles = 1;
+		dma_desc->desc[i]->cmd = cmd;
+		dma_desc->desc[i]->next =
+		    sg_is_last(sg) ? 0 : dma_desc->desc[i + 1]->phys;
+
+		dev_dbg(&chan->dev->device,
+			"desc=%p, saddr=%08x, daddr=%08x, length=%u\n",
+			&dma_desc->desc[i], buf_addr, dev_addr, buf_len);
+	}
+
+	return vchan_tx_prep(&dma_chan->vchan, &dma_desc->vdesc, flags);
+}
+
+static int ls1x_dma_slave_config(struct dma_chan *chan,
+				 struct dma_slave_config *config)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+
+	memcpy(&dma_chan->config, config, sizeof(struct dma_slave_config));
+
+	return 0;
+}
+
+static int ls1x_dma_terminate_all(struct dma_chan *chan)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&dma_chan->vchan.lock, flags);
+
+	chan_writel(dma_chan, DMA_CTRL,
+		    chan_readl(dma_chan, DMA_CTRL) | DMA_STOP);
+	dma_chan->dma_desc = NULL;
+	vchan_get_all_descriptors(&dma_chan->vchan, &head);
+
+	spin_unlock_irqrestore(&dma_chan->vchan.lock, flags);
+
+	vchan_dma_desc_free_list(&dma_chan->vchan, &head);
+
+	return 0;
+}
+
+static size_t ls1x_dma_desc_residue(struct ls1x_dma_desc *dma_desc,
+				    unsigned int next_sg)
+{
+	struct ls1x_dma_chan *dma_chan = dma_desc->chan;
+	struct dma_slave_config *config = &dma_chan->config;
+	unsigned int i, bus_width, bytes = 0;
+
+	if (dma_desc->dir == DMA_MEM_TO_DEV)
+		bus_width = config->dst_addr_width;
+	else
+		bus_width = config->src_addr_width;
+
+	for (i = next_sg; i < dma_desc->nr_descs; i++)
+		bytes += dma_desc->desc[i]->length * bus_width;
+
+	return bytes;
+}
+
+static enum dma_status ls1x_dma_tx_status(struct dma_chan *chan,
+					  dma_cookie_t cookie,
+					  struct dma_tx_state *txstate)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+	struct ls1x_dma_desc *dma_desc = dma_chan->dma_desc;
+	struct virt_dma_desc *vdesc;
+	enum dma_status status;
+	unsigned int residue = 0;
+	unsigned long flags;
+
+	status = dma_cookie_status(chan, cookie, txstate);
+	if ((status == DMA_COMPLETE) || !txstate)
+		return status;
+
+	spin_lock_irqsave(&dma_chan->vchan.lock, flags);
+
+	vdesc = vchan_find_desc(&dma_chan->vchan, cookie);
+	if (vdesc)
+		/* not yet processed */
+		residue = ls1x_dma_desc_residue(to_ls1x_dma_desc(vdesc), 0);
+	else if (cookie == dma_chan->dma_desc->vdesc.tx.cookie)
+		/* in progress */
+		residue = ls1x_dma_desc_residue(dma_desc, dma_desc->nr_done);
+	else
+		residue = 0;
+
+	spin_unlock_irqrestore(&dma_chan->vchan.lock, flags);
+
+	dma_set_residue(txstate, residue);
+
+	return status;
+}
+
+static void ls1x_trigger_dma(struct ls1x_dma_chan *dma_chan)
+{
+	struct dma_chan *chan = &dma_chan->vchan.chan;
+	struct ls1x_dma_desc *dma_desc;
+	struct virt_dma_desc *vdesc;
+	unsigned int val;
+
+	vdesc = vchan_next_desc(&dma_chan->vchan);
+	if (!vdesc) {
+		dev_warn(&chan->dev->device, "No pending descriptor\n");
+		return;
+	}
+	dma_chan->dma_desc = dma_desc = to_ls1x_dma_desc(vdesc);
+
+	dev_dbg(&chan->dev->device, "cookie=%d, %u descs, starting desc=%p\n",
+		chan->cookie, dma_desc->nr_descs, &dma_desc->desc[0]);
+
+	val = dma_desc->desc[0]->phys & DMA_ADDR_MASK;
+	val |= dma_chan->id;
+	val |= DMA_START;
+	chan_writel(dma_chan, DMA_CTRL, val);
+}
+
+static void ls1x_dma_issue_pending(struct dma_chan *chan)
+{
+	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dma_chan->vchan.lock, flags);
+
+	if (vchan_issue_pending(&dma_chan->vchan) && !dma_chan->dma_desc)
+		ls1x_trigger_dma(dma_chan);
+
+	spin_unlock_irqrestore(&dma_chan->vchan.lock, flags);
+}
+
+static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
+{
+	struct ls1x_dma_chan *dma_chan = data;
+	struct dma_chan *chan = &dma_chan->vchan.chan;
+
+	dev_dbg(&chan->dev->device, "DMA IRQ %d on channel %d\n", irq,
+		dma_chan->id);
+	if (!dma_chan->dma_desc) {
+		dev_warn(&chan->dev->device,
+			 "DMA IRQ with no active descriptor on channel %d\n",
+			 dma_chan->id);
+		return IRQ_NONE;
+	}
+
+	spin_lock(&dma_chan->vchan.lock);
+
+	if (dma_chan->dma_desc->type == DMA_CYCLIC) {
+		vchan_cyclic_callback(&dma_chan->dma_desc->vdesc);
+	} else {
+		list_del(&dma_chan->dma_desc->vdesc.node);
+		vchan_cookie_complete(&dma_chan->dma_desc->vdesc);
+		dma_chan->dma_desc = NULL;
+	}
+
+	spin_unlock(&dma_chan->vchan.lock);
+	return IRQ_HANDLED;
+}
+
+static int ls1x_dma_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct plat_ls1x_dma *pdata = dev_get_platdata(dev);
+	struct dma_device *dma_dev;
+	struct ls1x_dma *dma;
+	struct ls1x_dma_chan *dma_chan;
+	struct resource *res;
+	int i, ret;
+
+	/*initialize DMA device */
+	dma =
+	    devm_kzalloc(dev,
+			 sizeof(struct ls1x_dma) +
+			 pdata->nr_channels * sizeof(struct ls1x_dma_chan),
+			 GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -EINVAL;
+	}
+
+	dma->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dma->reg_base))
+		return PTR_ERR(dma->reg_base);
+
+	dma_dev = &dma->dma_dev;
+
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	dma_dev->dev = dev;
+	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	dma_dev->device_alloc_chan_resources = ls1x_dma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = ls1x_dma_free_chan_resources;
+	dma_dev->device_prep_slave_sg = ls1x_dma_prep_slave_sg;
+	dma_dev->device_config = ls1x_dma_slave_config;
+	dma_dev->device_terminate_all = ls1x_dma_terminate_all;
+	dma_dev->device_tx_status = ls1x_dma_tx_status;
+	dma_dev->device_issue_pending = ls1x_dma_issue_pending;
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	/*initialize DMA channels */
+	for (i = 0; i < pdata->nr_channels; i++) {
+		dma_chan = &dma->dma_chan[i];
+		dma_chan->id = i;
+		dma_chan->reg_base = dma->reg_base;
+
+		dma_chan->irq = platform_get_irq(pdev, i);
+		if (dma_chan->irq < 0) {
+			dev_err(dev, "failed to get IRQ: %d\n", dma_chan->irq);
+			return -EINVAL;
+		}
+
+		ret =
+		    devm_request_irq(dev, dma_chan->irq, ls1x_dma_irq_handler,
+				     IRQF_SHARED, dev_name(dev), dma_chan);
+		if (ret) {
+			dev_err(dev, "failed to request IRQ %u!\n",
+				dma_chan->irq);
+			return -EINVAL;
+		}
+
+		dma_chan->vchan.desc_free = ls1x_dma_free_desc;
+		vchan_init(&dma_chan->vchan, dma_dev);
+	}
+	dma->nr_dma_chans = i;
+
+	dma->clk = devm_clk_get(dev, pdev->name);
+	if (IS_ERR(dma->clk)) {
+		dev_err(dev, "failed to get %s clock\n", pdev->name);
+		return PTR_ERR(dma->clk);
+	}
+	clk_prepare_enable(dma->clk);
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret) {
+		dev_err(dev, "failed to register DMA device\n");
+		clk_disable_unprepare(dma->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, dma);
+	dev_info(dev, "Loongson1 DMA driver registered\n");
+	for (i = 0; i < pdata->nr_channels; i++) {
+		dma_chan = &dma->dma_chan[i];
+		dev = &dma_chan->vchan.chan.dev->device;
+		dev_info(dev, "channel %d at 0x%p (irq %d)\n", dma_chan->id,
+			 dma_chan->reg_base, dma_chan->irq);
+	}
+
+	return 0;
+}
+
+static int ls1x_dma_remove(struct platform_device *pdev)
+{
+	struct ls1x_dma *dma = platform_get_drvdata(pdev);
+
+	dma_async_device_unregister(&dma->dma_dev);
+	clk_disable_unprepare(dma->clk);
+	return 0;
+}
+
+static struct platform_driver ls1x_dma_driver = {
+	.probe	= ls1x_dma_probe,
+	.remove	= ls1x_dma_remove,
+	.driver	= {
+		.name	= "ls1x-dma",
+	},
+};
+
+module_platform_driver(ls1x_dma_driver);
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 DMA driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
