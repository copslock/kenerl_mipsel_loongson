Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:12:27 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34423 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026119AbcDFMLgCJv44 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:36 +0200
Received: by mail-pa0-f67.google.com with SMTP id hb4so3931597pac.1;
        Wed, 06 Apr 2016 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=enn2+Q/mN3CamjPSe7INdl1l2c2hF1rrcBmc9RRvAYM=;
        b=nReuFqHlo6Ko1vbsRmWs5TduCXBJlDTL9CzTRtt2ESjf8rCe3rOWwGOTiXHX3xVSl+
         vdidXYCzuV63u0Sj11gNLJ3B4AyCIrD/tfxOfA1Pb5DV+MbF6R9F1aQF/ct8pZDkNoCS
         YEuBvTw5DK9RRmcPhALSvt5V/lAB6X3sgMkaZ/WHA3zT3YCwpE3OWqCNWoS6fQJz3NYu
         9bAJ1aM2EkoK3AKAOT7Fc8IEOfaEDWNNENFhOBJedrhW0xXBxjSEFVj1YwaknSh5nH/W
         Q3S82sItwqW9WhQpw5z0hpfz4bbT3qYvpeWV4IzgZnNCGzW2yNp+vUqAJaUKZ0MkdGQA
         ElIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=enn2+Q/mN3CamjPSe7INdl1l2c2hF1rrcBmc9RRvAYM=;
        b=X6GRvgC2lWmuhLttnG+ffrxf+AFQLp3pVSqOJwDtjn3zRsz8Lzt55ztCdc2cHQGpLy
         pXbQnSyRhKIEJsHgXKIjfKa9ECelc64yJJDLiIBhQloTssO72ILcBlnhrGCdeIJi0Q7Q
         fKdqMLSVHn7E9kT9QWPxE09DmYjv2JuSktlPhn+DvWEeIcVuQ7sXP0nnAGEfTBejB1M1
         5V6NvanRuwnWnStXKeZ25/gBGhPSZl/2vGZu1yirHc4hikADtI4VS6mhc4nO0zktsrL5
         1xac/BzkichrS175QqyNPAOBxyZnlRxGsRpVsMNsTXMv/KK9CKv/ifuVNbNiq7y+hN6g
         gPGQ==
X-Gm-Message-State: AD7BkJKPY6/r8rzabTvwMAJmQ70ebxeW6XUnOjfpsW3Wz1iIv1I3VyYOVqUGPLqJJY4OjA==
X-Received: by 10.66.132.37 with SMTP id or5mr70549510pab.144.1459944689984;
        Wed, 06 Apr 2016 05:11:29 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.11.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:28 -0700 (PDT)
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
Subject: [PATCH 4/7] mtd: nand: add Loongson1 NAND driver
Date:   Wed,  6 Apr 2016 20:09:34 +0800
Message-Id: <1459944577-6423-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
References: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52901
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

This patch adds NAND driver for Loongson1B.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/mtd/nand/Kconfig          |   8 +
 drivers/mtd/nand/Makefile         |   1 +
 drivers/mtd/nand/loongson1_nand.c | 522 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 531 insertions(+)
 create mode 100644 drivers/mtd/nand/loongson1_nand.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index f05e0e9..d90f545 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -563,4 +563,12 @@ config MTD_NAND_QCOM
 	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
 	  controller. This controller is found on IPQ806x SoC.
 
+config MTD_NAND_LOONGSON1
+	tristate "Support for Loongson1 SoC NAND controller"
+	depends on MACH_LOONGSON32
+	select DMADEVICES
+	select DMA_LOONGSON1
+	help
+		Enables support for NAND Flash on Loongson1 SoC based boards.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index f553353..0310c0b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -57,5 +57,6 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
 obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
+obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o
diff --git a/drivers/mtd/nand/loongson1_nand.c b/drivers/mtd/nand/loongson1_nand.c
new file mode 100644
index 0000000..68a0514
--- /dev/null
+++ b/drivers/mtd/nand/loongson1_nand.c
@@ -0,0 +1,522 @@
+/*
+ * NAND Flash Driver for Loongson 1 SoC
+ *
+ * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/sizes.h>
+
+#include <nand.h>
+
+/* Loongson 1 NAND Register Definitions */
+#define NAND_CMD		0x0
+#define NAND_ADDRL		0x4
+#define NAND_ADDRH		0x8
+#define NAND_TIMING		0xc
+#define NAND_IDL		0x10
+#define NAND_IDH		0x14
+#define NAND_STATUS		0x14
+#define NAND_PARAM		0x18
+#define NAND_OP_NUM		0x1c
+#define NAND_CS_RDY		0x20
+
+#define NAND_DMA_ADDR		0x40
+
+/* NAND Command Register Bits */
+#define OP_DONE			BIT(10)
+#define OP_SPARE		BIT(9)
+#define OP_MAIN			BIT(8)
+#define CMD_STATUS		BIT(7)
+#define CMD_RESET		BIT(6)
+#define CMD_READID		BIT(5)
+#define BLOCKS_ERASE		BIT(4)
+#define CMD_ERASE		BIT(3)
+#define CMD_WRITE		BIT(2)
+#define CMD_READ		BIT(1)
+#define CMD_VALID		BIT(0)
+
+#define	LS1X_NAND_TIMEOUT	20
+
+/* macros for registers read/write */
+#define nand_readl(nand, off)		\
+	__raw_readl((nand)->reg_base + (off))
+
+#define nand_writel(nand, off, val)	\
+	__raw_writel((val), (nand)->reg_base + (off))
+
+#define set_cmd(nand, ctrl)		\
+	nand_writel(nand, NAND_CMD, ctrl)
+
+#define start_nand(nand)		\
+	nand_writel(nand, NAND_CMD, nand_readl(nand, NAND_CMD) | CMD_VALID)
+
+struct ls1x_nand {
+	struct platform_device *pdev;
+	struct nand_chip chip;
+
+	struct clk *clk;
+	void __iomem *reg_base;
+
+	int cmd_val;
+
+	char datareg[8];
+	char *data_ptr;
+
+	/* DMA stuff */
+	unsigned char *dma_buf;
+	unsigned int buf_off;
+	unsigned int buf_len;
+
+	/* DMA Engine stuff */
+	unsigned int dma_chan_id;
+	struct dma_chan *dma_chan;
+	dma_cookie_t dma_cookie;
+	struct completion dma_complete;
+	void __iomem *dma_desc;
+};
+
+static void dma_callback(void *data)
+{
+	struct ls1x_nand *nand = (struct ls1x_nand *)data;
+	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(nand->dma_chan, nand->dma_cookie, &state);
+	if (likely(status == DMA_COMPLETE))
+		dev_dbg(mtd->dev.parent, "DMA complete with cookie=%d\n",
+			nand->dma_cookie);
+	else
+		dev_err(mtd->dev.parent, "DMA error with cookie=%d\n",
+			nand->dma_cookie);
+
+	complete(&nand->dma_complete);
+}
+
+static int setup_dma(struct ls1x_nand *nand)
+{
+	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
+	struct dma_slave_config cfg;
+	dma_cap_mask_t mask;
+	int ret;
+
+	/* allocate DMA buffer */
+	nand->dma_buf = devm_kzalloc(mtd->dev.parent,
+				     mtd->writesize + mtd->oobsize, GFP_KERNEL);
+	if (!nand->dma_buf) {
+		dev_err(mtd->dev.parent, "failed to allocate DMA buffer\n");
+		return -ENOMEM;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	nand->dma_chan = dma_request_channel(mask, ls1x_dma_filter_fn,
+					     &nand->dma_chan_id);
+	if (!nand->dma_chan) {
+		dev_err(mtd->dev.parent, "failed to request DMA channel\n");
+		return -EBUSY;
+	}
+	dev_info(mtd->dev.parent, "got %s for %s access\n",
+		 dma_chan_name(nand->dma_chan), dev_name(mtd->dev.parent));
+
+	cfg.src_addr = CPHYSADDR(nand->reg_base + NAND_DMA_ADDR);
+	cfg.dst_addr = CPHYSADDR(nand->reg_base + NAND_DMA_ADDR);
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ret = dmaengine_slave_config(nand->dma_chan, &cfg);
+	if (ret) {
+		dev_err(mtd->dev.parent, "failed to config DMA channel\n");
+		dma_release_channel(nand->dma_chan);
+		return ret;
+	}
+
+	init_completion(&nand->dma_complete);
+
+	return 0;
+}
+
+static int start_dma(struct ls1x_nand *nand, unsigned int len, bool is_write)
+{
+	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
+	struct dma_chan *chan = nand->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	enum dma_data_direction data_dir =
+	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	enum dma_transfer_direction xfer_dir =
+	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dma_addr_t dma_addr;
+	int ret;
+
+	dma_addr =
+	    dma_map_single(chan->device->dev, nand->dma_buf, len, data_dir);
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+		dev_err(mtd->dev.parent, "failed to map DMA buffer\n");
+		return -ENXIO;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, dma_addr, len, xfer_dir,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(mtd->dev.parent,
+			"failed to prepare DMA descriptor\n");
+		ret = PTR_ERR(desc);
+		goto err;
+	}
+	desc->callback = dma_callback;
+	desc->callback_param = nand;
+
+	nand->dma_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(nand->dma_cookie);
+	if (ret) {
+		dev_err(mtd->dev.parent,
+			"failed to submit DMA descriptor\n");
+		goto err;
+	}
+
+	dev_dbg(mtd->dev.parent, "issue DMA with cookie=%d\n",
+		nand->dma_cookie);
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_timeout(&nand->dma_complete,
+					  msecs_to_jiffies(LS1X_NAND_TIMEOUT));
+	if (ret <= 0) {
+		dev_err(mtd->dev.parent, "DMA timeout\n");
+		dmaengine_terminate_all(chan);
+		ret = -EIO;
+	}
+	ret = 0;
+err:
+	dma_unmap_single(chan->device->dev, dma_addr, len, data_dir);
+
+	return ret;
+}
+
+static void ls1x_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+}
+
+static int ls1x_nand_dev_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+
+	if (nand_readl(nand, NAND_CMD) & OP_DONE)
+		return 1;
+
+	return 0;
+}
+
+static uint8_t ls1x_nand_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+
+	return *(nand->data_ptr++);
+}
+
+static void ls1x_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+
+	int real_len = min_t(size_t, len, nand->buf_len - nand->buf_off);
+
+	memcpy(buf, nand->dma_buf + nand->buf_off, real_len);
+	nand->buf_off += real_len;
+}
+
+static void ls1x_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+				int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+
+	int real_len = min_t(size_t, len, nand->buf_len - nand->buf_off);
+
+	memcpy(nand->dma_buf + nand->buf_off, buf, real_len);
+	nand->buf_off += real_len;
+}
+
+static inline void set_addr_len(struct mtd_info *mtd, unsigned int command,
+				int column, int page_addr)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+	int page_shift, addr_low, addr_high;
+
+	if (command == NAND_CMD_ERASE1)
+		page_shift = chip->page_shift;
+	else
+		page_shift = chip->page_shift + 1;
+
+	addr_low = page_addr << page_shift;
+
+	if (column != -1) {
+		if (command == NAND_CMD_READOOB)
+			column += mtd->writesize;
+		addr_low += column;
+		nand->buf_off = 0;
+	}
+
+	addr_high =
+	    page_addr >> (sizeof(page_addr) * BITS_PER_BYTE - page_shift);
+
+	if (command == NAND_CMD_ERASE1)
+		nand->buf_len = 1;
+	else
+		nand->buf_len = mtd->writesize + mtd->oobsize - column;
+
+	nand_writel(nand, NAND_ADDRL, addr_low);
+	nand_writel(nand, NAND_ADDRH, addr_high);
+	nand_writel(nand, NAND_OP_NUM, nand->buf_len);
+}
+
+static void ls1x_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
+			      int column, int page_addr)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand *nand = nand_get_controller_data(chip);
+
+	dev_dbg(mtd->dev.parent, "cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
+		command, column, page_addr);
+
+	if (command == NAND_CMD_RNDOUT) {
+		nand->buf_off = column;
+		return;
+	}
+
+	/*set address, buffer length and buffer offset */
+	if (column != -1 || page_addr != -1)
+		set_addr_len(mtd, command, column, page_addr);
+
+	/*prepare NAND command */
+	switch (command) {
+	case NAND_CMD_RESET:
+		nand->cmd_val = CMD_RESET;
+		break;
+	case NAND_CMD_STATUS:
+		nand->cmd_val = CMD_STATUS;
+		break;
+	case NAND_CMD_READID:
+		nand->cmd_val = CMD_READID;
+		break;
+	case NAND_CMD_READ0:
+		nand->cmd_val = OP_SPARE | OP_MAIN | CMD_READ;
+		break;
+	case NAND_CMD_READOOB:
+		nand->cmd_val = OP_SPARE | CMD_READ;
+		break;
+	case NAND_CMD_ERASE1:
+		nand->cmd_val = CMD_ERASE;
+		break;
+	case NAND_CMD_PAGEPROG:
+		break;
+	case NAND_CMD_SEQIN:
+		if (column < mtd->writesize)
+			nand->cmd_val = OP_SPARE | OP_MAIN | CMD_WRITE;
+		else
+			nand->cmd_val = OP_SPARE | CMD_WRITE;
+	default:
+		return;
+	}
+
+	/*set NAND command */
+	set_cmd(nand, nand->cmd_val);
+	/*trigger NAND operation */
+	start_nand(nand);
+	/*trigger DMA for R/W operation */
+	if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
+		start_dma(nand, nand->buf_len, false);
+	else if (command == NAND_CMD_PAGEPROG)
+		start_dma(nand, nand->buf_len, true);
+	nand_wait_ready(mtd);
+
+	if (command == NAND_CMD_STATUS) {
+		nand->datareg[0] = (char)(nand_readl(nand, NAND_STATUS) >> 8);
+		/*work around hardware bug for invalid STATUS */
+		nand->datareg[0] |= 0xc0;
+		nand->data_ptr = nand->datareg;
+	} else if (command == NAND_CMD_READID) {
+		nand->datareg[0] = (char)(nand_readl(nand, NAND_IDH));
+		nand->datareg[1] = (char)(nand_readl(nand, NAND_IDL) >> 24);
+		nand->datareg[2] = (char)(nand_readl(nand, NAND_IDL) >> 16);
+		nand->datareg[3] = (char)(nand_readl(nand, NAND_IDL) >> 8);
+		nand->datareg[4] = (char)(nand_readl(nand, NAND_IDL));
+		nand->data_ptr = nand->datareg;
+	}
+
+	nand->cmd_val = 0;
+}
+
+static void nand_hw_init(struct ls1x_nand *nand, int hold_cycle,
+			  int wait_cycle)
+{
+	struct nand_chip *chip = &nand->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int chipsize = (int)(chip->chipsize >> 20);
+	int cell_size = 0x0;
+
+	switch (chipsize) {
+	case SZ_128:		/*128M */
+		cell_size = 0x0;
+		break;
+	case SZ_256:		/*256M */
+		cell_size = 0x1;
+		break;
+	case SZ_512:		/*512M */
+		cell_size = 0x2;
+		break;
+	case SZ_1K:		/*1G */
+		cell_size = 0x3;
+		break;
+	case SZ_2K:		/*2G */
+		cell_size = 0x4;
+		break;
+	case SZ_4K:		/*4G */
+		cell_size = 0x5;
+		break;
+	case SZ_8K:		/*8G */
+		cell_size = 0x6;
+		break;
+	case SZ_16K:		/*16G */
+		cell_size = 0x7;
+		break;
+	default:
+		dev_warn(mtd->dev.parent, "unsupported chip size: %d MB\n",
+			 chipsize);
+	}
+
+	nand_writel(nand, NAND_TIMING, (hold_cycle << 8) | wait_cycle);
+	nand_writel(nand, NAND_PARAM,
+		    (nand_readl(nand, NAND_PARAM) & 0xfffff0ff) | (cell_size <<
+								   8));
+}
+
+static int ls1x_nand_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct plat_ls1x_nand *pdata = dev_get_platdata(dev);
+	struct ls1x_nand *nand;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct resource *res;
+	int ret = 0;
+
+	if (!pdata) {
+		dev_err(dev, "platform data missing\n");
+		return -EINVAL;
+	}
+
+	nand = devm_kzalloc(dev, sizeof(struct ls1x_nand), GFP_KERNEL);
+	if (!nand)
+		return -ENOMEM;
+	nand->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	nand->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(nand->reg_base))
+		return PTR_ERR(nand->reg_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dev, "failed to get DMA information\n");
+		return -ENXIO;
+	}
+	nand->dma_chan_id = res->start;
+
+	nand->clk = devm_clk_get(dev, pdev->name);
+	if (IS_ERR(nand->clk)) {
+		dev_err(dev, "failed to get %s clock\n", pdev->name);
+		return PTR_ERR(nand->clk);
+	}
+	clk_prepare_enable(nand->clk);
+
+	chip = &nand->chip;
+	chip->read_byte		= ls1x_nand_read_byte;
+	chip->read_buf		= ls1x_nand_read_buf;
+	chip->write_buf		= ls1x_nand_write_buf;
+	chip->select_chip	= ls1x_nand_select_chip;
+	chip->dev_ready		= ls1x_nand_dev_ready;
+	chip->cmdfunc		= ls1x_nand_cmdfunc;
+	chip->options		= NAND_NO_SUBPAGE_WRITE;
+	chip->ecc.mode		= NAND_ECC_SOFT;
+	nand_set_controller_data(chip, nand);
+
+	mtd = nand_to_mtd(chip);
+	mtd->name = "ls1x-nand";
+	mtd->owner = THIS_MODULE;
+	mtd->dev.parent = dev;
+
+	ret = nand_scan_ident(mtd, 1, NULL);
+	if (ret)
+		goto err;
+
+	nand_hw_init(nand, pdata->hold_cycle, pdata->wait_cycle);
+
+	ret = setup_dma(nand);
+	if (ret)
+		goto err;
+
+	ret = nand_scan_tail(mtd);
+	if (ret)
+		goto err;
+
+	ret = mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
+	if (ret) {
+		dev_err(dev, "failed to register MTD device: %d\n", ret);
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, nand);
+	dev_info(dev, "Loongson1 NAND driver registered\n");
+
+	return 0;
+err:
+	clk_disable_unprepare(nand->clk);
+
+	return ret;
+}
+
+static int ls1x_nand_remove(struct platform_device *pdev)
+{
+	struct ls1x_nand *nand = platform_get_drvdata(pdev);
+
+	if (nand->dma_chan)
+		dma_release_channel(nand->dma_chan);
+	nand_release(nand_to_mtd(&nand->chip));
+	clk_disable_unprepare(nand->clk);
+
+	return 0;
+}
+
+static struct platform_driver ls1x_nand_driver = {
+	.probe	= ls1x_nand_probe,
+	.remove	= ls1x_nand_remove,
+	.driver	= {
+		.name	= "ls1x-nand",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(ls1x_nand_driver);
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 NAND Flash driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
