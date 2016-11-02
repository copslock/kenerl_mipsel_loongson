Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2016 02:52:38 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34603 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993301AbcKBBwbQ5GEe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2016 02:52:31 +0100
Received: by mail-pf0-f196.google.com with SMTP id y68so202064pfb.1
        for <linux-mips@linux-mips.org>; Tue, 01 Nov 2016 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4Ht4pr0G+uhUn5C84mfDeJd7TKPsHXMvKnvKSBDU/98=;
        b=N9dJ+pGOemLkDj9vcXeAsPRmJnzIzMuRnlPqmBnAGenQs47BYUVui+f31+Pc7gl9UD
         Nin05j8dv0qTF1MTeLYQHzQSENdeQRTjj9Slxn9JcPnz3kN2/B5/wKn32Qzd+B5CYLJO
         TxNFSI/XVsSyhrRi5qZInbJu1noDwPnimDqbSBIesQRWVqk8U4EHn1lmQ7JlZQCmGCSg
         53kq7w4Z2uxPdobg1KCMbGqVpSFQ4Wd0/qQMNaHXpzZ3+x8HUMb7BkFrDtptUD0ABGSO
         VMT5htJ+qIZBVqu4puonqW0gR5v5nc7ETx8khRC6FX639sb9KoK421DbPoiu5TFBl01W
         W4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Ht4pr0G+uhUn5C84mfDeJd7TKPsHXMvKnvKSBDU/98=;
        b=anLeb8EVKj844y8cFrTQRzM1AZEkzEfgliV3Tg2jaz+67sl2BusrBfUSNEkG3yu/ry
         j5U0dNelvoMhxKhbUJjYL/NcrRoN1Ij3YZDttg1HQQyATpzLB319CoFLqAoI/fMDktVN
         F009nR82VHb3kWDDceUmwdsW/FH4iZfxYgnGrGC/ziFCIxNqiZDUW4xt7jPo2bL4Y7o6
         6glLdQFtg5jHujtSMZ+m4ETu8gJWijxJqv4Zle2KyopzYGewEC9iCXaS7xiaqV1/sbjV
         6nC1OX5wkEDbUf2Njda0IgcRi8Dlb1Ga3oeWDvIdVgMVPrgY+o6LlhxnBSh1VNvTHZtR
         KvQA==
X-Gm-Message-State: ABUngvfzLIgYJi7P4bpItIgMlc/im2hJZbUTBa/ik8og7KI6ljsgP9yireON2TfP9o2qWQ==
X-Received: by 10.98.213.7 with SMTP id d7mr2068577pfg.3.1478051544754;
        Tue, 01 Nov 2016 18:52:24 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 131sm3090403pfx.92.2016.11.01.18.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 18:52:23 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V4] mtd: nand: add Loongson1 NAND driver
Date:   Wed,  2 Nov 2016 09:52:06 +0800
Message-Id: <1478051526-7216-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55649
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
v4:
   Retrieve the controller from nand_hw_control.
v3:
   Replace __raw_readl/__raw_writel with readl/writel.
   Split ls1x_nand into two structures: ls1x_nand_chip and
   ls1x_nand_controller.
V2:
   Modify the dependency in Kconfig due to the changes of DMA
   module.
---
 drivers/mtd/nand/Kconfig          |   8 +
 drivers/mtd/nand/Makefile         |   1 +
 drivers/mtd/nand/loongson1_nand.c | 571 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 580 insertions(+)
 create mode 100644 drivers/mtd/nand/loongson1_nand.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7b7a887..2a815c7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -569,4 +569,12 @@ config MTD_NAND_MTK
 	  Enables support for NAND controller on MTK SoCs.
 	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
 
+config MTD_NAND_LOONGSON1
+	tristate "Support for Loongson1 SoC NAND controller"
+	depends on MACH_LOONGSON32
+	select DMADEVICES
+	select LOONGSON1_DMA
+	help
+		Enables support for NAND Flash on Loongson1 SoC based boards.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index cafde6f..04f65a6 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -58,5 +58,6 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_nand.o mtk_ecc.o
+obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o
diff --git a/drivers/mtd/nand/loongson1_nand.c b/drivers/mtd/nand/loongson1_nand.c
new file mode 100644
index 0000000..e3999ea
--- /dev/null
+++ b/drivers/mtd/nand/loongson1_nand.c
@@ -0,0 +1,571 @@
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
+#define NAND_RDY		BIT(10)
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
+#define nand_readl(nandc, off)		\
+	readl((nandc)->reg_base + (off))
+
+#define nand_writel(nandc, off, val)	\
+	writel((val), (nandc)->reg_base + (off))
+
+#define set_cmd(nandc, ctrl)		\
+	nand_writel(nandc, NAND_CMD, ctrl)
+
+#define start_nand(nandc)		\
+	nand_writel(nandc, NAND_CMD, nand_readl(nandc, NAND_CMD) | CMD_VALID)
+
+struct ls1x_nand_chip {
+	struct nand_chip chip;
+	struct plat_ls1x_nand *pdata;
+};
+
+struct ls1x_nand_controller {
+	struct nand_hw_control controller;
+	struct clk *clk;
+	void __iomem *reg_base;
+
+	int cmd_ctrl;
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
+static inline struct ls1x_nand_chip *to_ls1x_nand_chip(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct ls1x_nand_chip, chip);
+}
+
+static struct ls1x_nand_controller *
+to_ls1x_nand_controller(struct nand_hw_control *ctrl)
+{
+	return container_of(ctrl, struct ls1x_nand_controller, controller);
+}
+
+static void dma_callback(void *data)
+{
+	struct mtd_info *mtd = (struct mtd_info *)data;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status =
+	    dmaengine_tx_status(nandc->dma_chan, nandc->dma_cookie, &state);
+	if (likely(status == DMA_COMPLETE))
+		dev_dbg(mtd->dev.parent, "DMA complete with cookie=%d\n",
+			nandc->dma_cookie);
+	else
+		dev_err(mtd->dev.parent, "DMA error with cookie=%d\n",
+			nandc->dma_cookie);
+
+	complete(&nandc->dma_complete);
+}
+
+static int setup_dma(struct mtd_info *mtd)
+{
+	struct ls1x_nand_chip *nand = to_ls1x_nand_chip(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+	struct dma_slave_config cfg;
+	dma_cap_mask_t mask;
+	int ret;
+
+	if (!nand->pdata->dma_filter) {
+		dev_err(mtd->dev.parent, "no DMA filter\n");
+		return -ENOENT;
+	}
+
+	/* allocate DMA buffer */
+	nandc->dma_buf = devm_kzalloc(mtd->dev.parent,
+				      mtd->writesize + mtd->oobsize,
+				      GFP_KERNEL);
+	if (!nandc->dma_buf)
+		return -ENOMEM;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	nandc->dma_chan = dma_request_channel(mask, nand->pdata->dma_filter,
+					      &nandc->dma_chan_id);
+	if (!nandc->dma_chan) {
+		dev_err(mtd->dev.parent, "failed to request DMA channel\n");
+		return -EBUSY;
+	}
+	dev_info(mtd->dev.parent, "got %s for %s access\n",
+		 dma_chan_name(nandc->dma_chan), dev_name(mtd->dev.parent));
+
+	cfg.src_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
+	cfg.dst_addr = CPHYSADDR(nandc->reg_base + NAND_DMA_ADDR);
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	ret = dmaengine_slave_config(nandc->dma_chan, &cfg);
+	if (ret) {
+		dev_err(mtd->dev.parent, "failed to config DMA channel\n");
+		dma_release_channel(nandc->dma_chan);
+		return ret;
+	}
+
+	init_completion(&nandc->dma_complete);
+
+	return 0;
+}
+
+static int start_dma(struct mtd_info *mtd, unsigned int len, bool is_write)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+	struct dma_chan *chan = nandc->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	enum dma_data_direction data_dir =
+	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	enum dma_transfer_direction xfer_dir =
+	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dma_addr_t dma_addr;
+	int ret;
+
+	dma_addr =
+	    dma_map_single(chan->device->dev, nandc->dma_buf, len, data_dir);
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+		dev_err(mtd->dev.parent, "failed to map DMA buffer\n");
+		return -ENXIO;
+	}
+
+	desc = dmaengine_prep_slave_single(chan, dma_addr, len, xfer_dir,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(mtd->dev.parent, "failed to prepare DMA descriptor\n");
+		ret = PTR_ERR(desc);
+		goto err;
+	}
+	desc->callback = dma_callback;
+	desc->callback_param = mtd;
+
+	nandc->dma_cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(nandc->dma_cookie);
+	if (ret) {
+		dev_err(mtd->dev.parent, "failed to submit DMA descriptor\n");
+		goto err;
+	}
+
+	dev_dbg(mtd->dev.parent, "issue DMA with cookie=%d\n",
+		nandc->dma_cookie);
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_timeout(&nandc->dma_complete,
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
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	if (nand_readl(nandc, NAND_CMD) & NAND_RDY)
+		return 1;
+
+	return 0;
+}
+
+static uint8_t ls1x_nand_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	return *(nandc->data_ptr++);
+}
+
+static void ls1x_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	memcpy(buf, nandc->dma_buf + nandc->buf_off, len);
+	nandc->buf_off += len;
+}
+
+static void ls1x_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+				int len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	memcpy(nandc->dma_buf + nandc->buf_off, buf, len);
+	nandc->buf_off += len;
+}
+
+static inline void set_addr_len(struct mtd_info *mtd, unsigned int command,
+				int column, int page_addr)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
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
+		nandc->buf_off = 0;
+	}
+
+	addr_high =
+	    page_addr >> (sizeof(page_addr) * BITS_PER_BYTE - page_shift);
+
+	if (command == NAND_CMD_ERASE1)
+		nandc->buf_len = 1;
+	else
+		nandc->buf_len = mtd->writesize + mtd->oobsize - column;
+
+	nand_writel(nandc, NAND_ADDRL, addr_low);
+	nand_writel(nandc, NAND_ADDRH, addr_high);
+	nand_writel(nandc, NAND_OP_NUM, nandc->buf_len);
+}
+
+static void ls1x_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
+			      int column, int page_addr)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	dev_dbg(mtd->dev.parent, "cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
+		command, column, page_addr);
+
+	if (command == NAND_CMD_RNDOUT) {
+		nandc->buf_off = column;
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
+		nandc->cmd_ctrl = CMD_RESET;
+		break;
+	case NAND_CMD_STATUS:
+		nandc->cmd_ctrl = CMD_STATUS;
+		break;
+	case NAND_CMD_READID:
+		nandc->cmd_ctrl = CMD_READID;
+		break;
+	case NAND_CMD_READ0:
+		nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_READ;
+		break;
+	case NAND_CMD_READOOB:
+		nandc->cmd_ctrl = OP_SPARE | CMD_READ;
+		break;
+	case NAND_CMD_ERASE1:
+		nandc->cmd_ctrl = CMD_ERASE;
+		break;
+	case NAND_CMD_PAGEPROG:
+		break;
+	case NAND_CMD_SEQIN:
+		if (column < mtd->writesize)
+			nandc->cmd_ctrl = OP_SPARE | OP_MAIN | CMD_WRITE;
+		else
+			nandc->cmd_ctrl = OP_SPARE | CMD_WRITE;
+	default:
+		return;
+	}
+
+	/*set NAND command */
+	set_cmd(nandc, nandc->cmd_ctrl);
+	/*trigger NAND operation */
+	start_nand(nandc);
+	/*trigger DMA for R/W operation */
+	if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
+		start_dma(mtd, nandc->buf_len, false);
+	else if (command == NAND_CMD_PAGEPROG)
+		start_dma(mtd, nandc->buf_len, true);
+	nand_wait_ready(mtd);
+
+	if (command == NAND_CMD_STATUS) {
+		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_STATUS) >> 8);
+		/*work around hardware bug for invalid STATUS */
+		nandc->datareg[0] |= 0xc0;
+		nandc->data_ptr = nandc->datareg;
+	} else if (command == NAND_CMD_READID) {
+		nandc->datareg[0] = (char)(nand_readl(nandc, NAND_IDH));
+		nandc->datareg[1] = (char)(nand_readl(nandc, NAND_IDL) >> 24);
+		nandc->datareg[2] = (char)(nand_readl(nandc, NAND_IDL) >> 16);
+		nandc->datareg[3] = (char)(nand_readl(nandc, NAND_IDL) >> 8);
+		nandc->datareg[4] = (char)(nand_readl(nandc, NAND_IDL));
+		nandc->data_ptr = nandc->datareg;
+	}
+
+	nandc->cmd_ctrl = 0;
+}
+
+static void ls1x_nand_hw_init(struct mtd_info *mtd, int hold_cycle,
+			      int wait_cycle)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
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
+	nand_writel(nandc, NAND_TIMING, (hold_cycle << 8) | wait_cycle);
+	nand_writel(nandc, NAND_PARAM,
+		    (nand_readl(nandc, NAND_PARAM) & 0xfffff0ff) | (cell_size <<
+								    8));
+}
+
+static int ls1x_nand_init(struct platform_device *pdev,
+			  struct ls1x_nand_controller *nandc)
+{
+	struct device *dev = &pdev->dev;
+	struct ls1x_nand_chip *nand;
+	struct plat_ls1x_nand *pdata;
+	struct nand_chip *chip;
+	struct mtd_info *mtd;
+	int ret = 0;
+
+	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
+	if (!nand)
+		return -ENOMEM;
+
+	pdata = dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "platform data missing\n");
+		return -EINVAL;
+	}
+	nand->pdata = pdata;
+
+	chip = &nand->chip;
+	chip->read_byte		= ls1x_nand_read_byte;
+	chip->read_buf		= ls1x_nand_read_buf;
+	chip->write_buf		= ls1x_nand_write_buf;
+	chip->select_chip	= ls1x_nand_select_chip;
+	chip->dev_ready		= ls1x_nand_dev_ready;
+	chip->cmdfunc		= ls1x_nand_cmdfunc;
+	chip->options		= NAND_NO_SUBPAGE_WRITE;
+	chip->controller	= &nandc->controller;
+	chip->ecc.mode		= NAND_ECC_SOFT;
+	chip->ecc.algo		= NAND_ECC_HAMMING;
+
+	mtd = nand_to_mtd(chip);
+	mtd->name = "ls1x-nand";
+	mtd->owner = THIS_MODULE;
+	mtd->dev.parent = dev;
+
+	ret = nand_scan_ident(mtd, 1, NULL);
+	if (ret)
+		return ret;
+
+	ls1x_nand_hw_init(mtd, pdata->hold_cycle, pdata->wait_cycle);
+
+	ret = setup_dma(mtd);
+	if (ret)
+		return ret;
+
+	ret = nand_scan_tail(mtd);
+	if (ret) {
+		dma_release_channel(nandc->dma_chan);
+		return ret;
+	}
+
+	ret = mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
+	if (ret) {
+		dev_err(dev, "failed to register MTD device: %d\n", ret);
+		dma_release_channel(nandc->dma_chan);
+	}
+
+	platform_set_drvdata(pdev, mtd);
+	return ret;
+}
+
+static int ls1x_nand_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ls1x_nand_controller *nandc;
+	struct resource *res;
+	int ret;
+
+	nandc = devm_kzalloc(dev, sizeof(*nandc), GFP_KERNEL);
+	if (!nandc)
+		return -ENOMEM;
+	nand_hw_control_init(&nandc->controller);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	nandc->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(nandc->reg_base))
+		return PTR_ERR(nandc->reg_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		dev_err(dev, "failed to get DMA information\n");
+		return -ENXIO;
+	}
+	nandc->dma_chan_id = res->start;
+
+	nandc->clk = devm_clk_get(dev, pdev->name);
+	if (IS_ERR(nandc->clk)) {
+		dev_err(dev, "failed to get %s clock\n", pdev->name);
+		return PTR_ERR(nandc->clk);
+	}
+	clk_prepare_enable(nandc->clk);
+
+	ret = ls1x_nand_init(pdev, nandc);
+	if (ret) {
+		clk_disable_unprepare(nandc->clk);
+		return ret;
+	}
+
+	dev_info(dev, "Loongson1 NAND driver registered\n");
+	return 0;
+}
+
+static int ls1x_nand_remove(struct platform_device *pdev)
+{
+	struct mtd_info *mtd = platform_get_drvdata(pdev);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct ls1x_nand_controller *nandc =
+	    to_ls1x_nand_controller(chip->controller);
+
+	if (nandc->dma_chan)
+		dma_release_channel(nandc->dma_chan);
+	nand_release(mtd);
+	clk_disable_unprepare(nandc->clk);
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
2.7.3
