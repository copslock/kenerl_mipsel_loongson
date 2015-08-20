Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 10:44:25 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.138]:54341 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010932AbbHTIoUwYu0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 10:44:20 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.131])
        by regular1.263xmail.com (Postfix) with SMTP id AAAB75661;
        Thu, 20 Aug 2015 16:44:14 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id E50A7443;
        Thu, 20 Aug 2015 16:44:08 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <ccbdcd1c686b99754762d9c31bc704dc>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 240931FDZKF;
        Thu, 20 Aug 2015 16:44:12 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v6 1/9] mmc: dw_mmc: Add external dma interface support
Date:   Thu, 20 Aug 2015 16:43:53 +0800
Message-Id: <1440060233-26244-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1440060204-26203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440060204-26203-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

DesignWare MMC Controller can supports two types of DMA
mode: external dma and internal dma. We get a RK312x platform
integrated dw_mmc and ARM pl330 dma controller. This patch add
edmac ops to support these platforms. I've tested it on RK31xx
platform with edmac mode and RK3288 platform with idmac mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- add trans_mode condition for IDMAC initialization
  suggested by Heiko
- re-test my patch on rk3188 platform and update commit msg
- update performance of pio vs edmac in cover letter

Changes in v5:
- add the title of cover letter
- fix typo of comment
- add macro for reading HCON register
- add "Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>" for exynos_defconfig patch
- add "Acked-by: Vineet Gupta <vgupta@synopsys.com>" for axs10x_defconfig patch
- add "Acked-by: Govindraj Raja <govindraj.raja@imgtec.com>" and
  "Acked-by: Ralf Baechle <ralf@linux-mips.org>" for pistachio_defconfig patch
- add "Acked-by: Joachim Eastwood <manabian@gmail.com>" for lpc18xx_defconfig patch
- add "Acked-by: Wei Xu <xuwei5@hisilicon.com>" for hisi_defconfig patch
- rebase on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" for merging easily

Changes in v4:
- remove "host->trans_mode" and use "host->use_dma" to indicate
  transfer mode.
- remove all bt-bindings' changes since we don't need new properities.
- check transfer mode at runtime by reading HCON reg
- spilt defconfig changes for each sub-architecture
- fix the title of cover letter
- reuse some code for reducing code size

Changes in v3:
- choose transfer mode at runtime
- remove all CONFIG_MMC_DW_IDMAC config option
- add supports-idmac property for some platforms

Changes in v2:
- Fix typo of dev_info msg
- remove unused dmach from declaration of dw_mci_dma_slave

 drivers/mmc/host/Kconfig        |  11 +-
 drivers/mmc/host/dw_mmc-pltfm.c |   2 +
 drivers/mmc/host/dw_mmc.c       | 264 ++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/dw_mmc.h       |   5 +
 include/linux/mmc/dw_mmc.h      |  27 +++-
 5 files changed, 242 insertions(+), 67 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6a0f9c7..a86c0eb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -607,15 +607,7 @@ config MMC_DW
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-	  PIO and external DMA modes.
-
-config MMC_DW_IDMAC
-	bool "Internal DMAC interface"
-	depends on MMC_DW
-	help
-	  This selects support for the internal DMAC block within the Synopsys
-	  Designware Mobile Storage IP block. This disables the external DMA
-	  interface.
+	  PIO, internal DMA mode and external DMA modes.
 
 config MMC_DW_PLTFM
 	tristate "Synopsys Designware MCI Support as platform device"
@@ -644,7 +636,6 @@ config MMC_DW_K3
 	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
 	depends on MMC_DW
 	select MMC_DW_PLTFM
-	select MMC_DW_IDMAC
 	help
 	  This selects support for Hisilicon K3 SoC specific extensions to the
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ec6dbcd..7e1d13b 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->pdata = pdev->dev.platform_data;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* Get registers' physical base address */
+	host->phy_regs = (void *)(regs->start);
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fcbf552..f943619 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -56,7 +56,6 @@
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	400000		/* unit: HZ */
 
-#ifdef CONFIG_MMC_DW_IDMAC
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
 				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
@@ -102,7 +101,6 @@ struct idmac_desc {
 
 /* Each descriptor can transfer up to 4KB of data in chained mode */
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
-#endif /* CONFIG_MMC_DW_IDMAC */
 
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
@@ -407,7 +405,6 @@ static int dw_mci_get_dma_dir(struct mmc_data *data)
 		return DMA_FROM_DEVICE;
 }
 
-#ifdef CONFIG_MMC_DW_IDMAC
 static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
@@ -445,12 +442,21 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 	mci_writel(host, BMOD, temp);
 }
 
-static void dw_mci_idmac_complete_dma(struct dw_mci *host)
+static void dw_mci_dmac_complete_dma(void *arg)
 {
+	struct dw_mci *host = arg;
 	struct mmc_data *data = host->data;
 
 	dev_vdbg(host->dev, "DMA complete\n");
 
+	if (host->use_dma == TRANS_MODE_EDMAC)
+		if (data && (data->flags & MMC_DATA_READ))
+			/* Invalidate cache after read */
+			dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
+					    data->sg,
+					    data->sg_len,
+					    DMA_FROM_DEVICE);
+
 	host->dma_ops->cleanup(host);
 
 	/*
@@ -564,7 +570,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 	wmb(); /* drain writebuffer */
 }
 
-static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
+static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 {
 	u32 temp;
 
@@ -589,6 +595,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 
 	/* Start it running */
 	mci_writel(host, PLDMND, 1);
+
+	return 0;
 }
 
 static int dw_mci_idmac_init(struct dw_mci *host)
@@ -669,10 +677,112 @@ static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
 	.init = dw_mci_idmac_init,
 	.start = dw_mci_idmac_start_dma,
 	.stop = dw_mci_idmac_stop_dma,
-	.complete = dw_mci_idmac_complete_dma,
+	.complete = dw_mci_dmac_complete_dma,
+	.cleanup = dw_mci_dma_cleanup,
+};
+
+static void dw_mci_edmac_stop_dma(struct dw_mci *host)
+{
+	dmaengine_terminate_all(host->dms->ch);
+}
+
+static int dw_mci_edmac_start_dma(struct dw_mci *host,
+					    unsigned int sg_len)
+{
+	struct dma_slave_config cfg;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct scatterlist *sgl = host->data->sg;
+	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	u32 sg_elems = host->data->sg_len;
+	u32 fifoth_val;
+	u32 fifo_offset = host->fifo_reg - host->regs;
+	int ret = 0;
+
+	/* Set external dma config: burst size, burst width */
+	cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
+	cfg.src_addr = cfg.dst_addr;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	/* Match burst msize with external dma config */
+	fifoth_val = mci_readl(host, FIFOTH);
+	cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
+	cfg.src_maxburst = cfg.dst_maxburst;
+
+	if (host->data->flags & MMC_DATA_WRITE)
+		cfg.direction = DMA_MEM_TO_DEV;
+	else /* MMC_DATA_READ */
+		cfg.direction = DMA_DEV_TO_MEM;
+
+	ret = dmaengine_slave_config(host->dms->ch, &cfg);
+	if (ret) {
+		dev_err(host->dev, "Failed to config edmac.\n");
+		return -EBUSY;
+	}
+
+	desc = dmaengine_prep_slave_sg(host->dms->ch, sgl,
+				       sg_len, cfg.direction,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(host->dev, "Can't prepare slave sg.\n");
+		return -EBUSY;
+	}
+
+	/* Set dw_mci_dmac_complete_dma as callback */
+	desc->callback = dw_mci_dmac_complete_dma;
+	desc->callback_param = (void *)host;
+	dmaengine_submit(desc);
+
+	/* Flush cache before write */
+	if (host->data->flags & MMC_DATA_WRITE)
+		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
+				       sg_elems, DMA_TO_DEVICE);
+
+	dma_async_issue_pending(host->dms->ch);
+
+	return 0;
+}
+
+static int dw_mci_edmac_init(struct dw_mci *host)
+{
+	/* Request external dma channel */
+	host->dms = kzalloc(sizeof(struct dw_mci_dma_slave), GFP_KERNEL);
+	if (!host->dms)
+		return -ENOMEM;
+
+	host->dms->ch = dma_request_slave_channel(host->dev, "rx-tx");
+	if (!host->dms->ch) {
+		dev_err(host->dev,
+			"Failed to get external DMA channel %d\n",
+			host->dms->ch->chan_id);
+		kfree(host->dms);
+		host->dms = NULL;
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void dw_mci_edmac_exit(struct dw_mci *host)
+{
+	if (host->dms) {
+		if (host->dms->ch) {
+			dma_release_channel(host->dms->ch);
+			host->dms->ch = NULL;
+		}
+		kfree(host->dms);
+		host->dms = NULL;
+	}
+}
+
+static const struct dw_mci_dma_ops dw_mci_edmac_ops = {
+	.init = dw_mci_edmac_init,
+	.exit = dw_mci_edmac_exit,
+	.start = dw_mci_edmac_start_dma,
+	.stop = dw_mci_edmac_stop_dma,
+	.complete = dw_mci_dmac_complete_dma,
 	.cleanup = dw_mci_dma_cleanup,
 };
-#endif /* CONFIG_MMC_DW_IDMAC */
 
 static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 				   struct mmc_data *data,
@@ -752,7 +862,6 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 {
-#ifdef CONFIG_MMC_DW_IDMAC
 	unsigned int blksz = data->blksz;
 	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 fifo_width = 1 << host->data_shift;
@@ -760,6 +869,10 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
 	int idx = ARRAY_SIZE(mszs) - 1;
 
+	/* pio should ship this scenario */
+	if (!host->use_dma)
+		return;
+
 	tx_wmark = (host->fifo_depth) / 2;
 	tx_wmark_invers = host->fifo_depth - tx_wmark;
 
@@ -788,7 +901,6 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 done:
 	fifoth_val = SDMMC_SET_FIFOTH(msize, rx_wmark, tx_wmark);
 	mci_writel(host, FIFOTH, fifoth_val);
-#endif
 }
 
 static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
@@ -850,10 +962,12 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 
 	host->using_dma = 1;
 
-	dev_vdbg(host->dev,
-		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
-		 (unsigned long)host->sg_cpu, (unsigned long)host->sg_dma,
-		 sg_len);
+	if (host->use_dma == TRANS_MODE_IDMAC)
+		dev_vdbg(host->dev,
+			 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
+			 (unsigned long)host->sg_cpu,
+			 (unsigned long)host->sg_dma,
+			 sg_len);
 
 	/*
 	 * Decide the MSIZE and RX/TX Watermark.
@@ -875,7 +989,11 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 	mci_writel(host, INTMASK, temp);
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
-	host->dma_ops->start(host, sg_len);
+	if (host->dma_ops->start(host, sg_len)) {
+		/* We can't do DMA */
+		dev_err(host->dev, "%s: failed to start DMA.\n", __func__);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -2343,15 +2461,17 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 
 	}
 
-#ifdef CONFIG_MMC_DW_IDMAC
-	/* Handle DMA interrupts */
+	if (host->use_dma != TRANS_MODE_IDMAC)
+		return IRQ_HANDLED;
+
+	/* Handle IDMA interrupts */
 	if (host->dma_64bit_address == 1) {
 		pending = mci_readl(host, IDSTS64);
 		if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
 			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
 							SDMMC_IDMAC_INT_RI);
 			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
-			host->dma_ops->complete(host);
+			host->dma_ops->complete((void *)host);
 		}
 	} else {
 		pending = mci_readl(host, IDSTS);
@@ -2359,10 +2479,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
 							SDMMC_IDMAC_INT_RI);
 			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
-			host->dma_ops->complete(host);
+			host->dma_ops->complete((void *)host);
 		}
 	}
-#endif
 
 	return IRQ_HANDLED;
 }
@@ -2471,13 +2590,21 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		goto err_host_allocated;
 
 	/* Useful defaults if platform data is unset. */
-	if (host->use_dma) {
+	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65536;
 		mmc->max_seg_size = 0x1000;
 		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
+	} else if (host->use_dma == TRANS_MODE_EDMAC) {
+			mmc->max_segs = 64;
+			mmc->max_blk_size = 65536;
+			mmc->max_blk_count = 65535;
+			mmc->max_req_size =
+					mmc->max_blk_size * mmc->max_blk_count;
+			mmc->max_seg_size = mmc->max_req_size;
 	} else {
+		/* TRANS_MODE_PIO */
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
 		mmc->max_blk_count = 512;
@@ -2517,35 +2644,66 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 static void dw_mci_init_dma(struct dw_mci *host)
 {
 	int addr_config;
-	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
-	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
-
-	if (addr_config == 1) {
-		/* host supports IDMAC in 64-bit address mode */
-		host->dma_64bit_address = 1;
-		dev_info(host->dev, "IDMAC supports 64-bit address mode.\n");
-		if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
-			dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
-	} else {
-		/* host supports IDMAC in 32-bit address mode */
-		host->dma_64bit_address = 0;
-		dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
-	}
+	int trans_mode;
+	struct device *dev = host->dev;
+	struct device_node *np = dev->of_node;
 
-	/* Alloc memory for sg translation */
-	host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
-					  &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu) {
-		dev_err(host->dev, "%s: could not alloc DMA memory\n",
-			__func__);
+	/* Check tansfer mode */
+	trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
+	if (trans_mode == 0) {
+		trans_mode = TRANS_MODE_IDMAC;
+	} else if (trans_mode == 1 || trans_mode == 2) {
+		trans_mode = TRANS_MODE_EDMAC;
+	} else {
+		trans_mode = TRANS_MODE_PIO;
 		goto no_dma;
 	}
 
 	/* Determine which DMA interface to use */
-#ifdef CONFIG_MMC_DW_IDMAC
-	host->dma_ops = &dw_mci_idmac_ops;
-	dev_info(host->dev, "Using internal DMA controller.\n");
-#endif
+	if (trans_mode == TRANS_MODE_IDMAC) {
+		/*
+		* Check ADDR_CONFIG bit in HCON to find
+		* IDMAC address bus width
+		*/
+		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
+
+		if (addr_config == 1) {
+			/* host supports IDMAC in 64-bit address mode */
+			host->dma_64bit_address = 1;
+			dev_info(host->dev,
+				 "IDMAC supports 64-bit address mode.\n");
+			if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
+				dma_set_coherent_mask(host->dev,
+						      DMA_BIT_MASK(64));
+		} else {
+			/* host supports IDMAC in 32-bit address mode */
+			host->dma_64bit_address = 0;
+			dev_info(host->dev,
+				 "IDMAC supports 32-bit address mode.\n");
+		}
+
+		/* Alloc memory for sg translation */
+		host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
+						   &host->sg_dma, GFP_KERNEL);
+		if (!host->sg_cpu) {
+			dev_err(host->dev,
+				"%s: could not alloc DMA memory\n",
+				__func__);
+			goto no_dma;
+		}
+
+		host->dma_ops = &dw_mci_idmac_ops;
+		dev_info(host->dev, "Using internal DMA controller.\n");
+	} else {
+		/* TRANS_MODE_EDMAC: check dma bindings again */
+		if ((of_property_count_strings(np, "dma-names") < 0) ||
+		    (!of_find_property(np, "dmas", NULL))) {
+			trans_mode = TRANS_MODE_PIO;
+			goto no_dma;
+		}
+		host->dma_ops = &dw_mci_edmac_ops;
+		dev_info(host->dev, "Using external DMA controller.\n");
+	}
 
 	if (!host->dma_ops)
 		goto no_dma;
@@ -2562,12 +2720,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
 		goto no_dma;
 	}
 
-	host->use_dma = 1;
+	host->use_dma = trans_mode;
 	return;
 
 no_dma:
 	dev_info(host->dev, "Using PIO mode.\n");
-	host->use_dma = 0;
+	host->use_dma = trans_mode;
 }
 
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
@@ -2650,10 +2808,9 @@ static bool dw_mci_reset(struct dw_mci *host)
 		}
 	}
 
-#if IS_ENABLED(CONFIG_MMC_DW_IDMAC)
-	/* It is also recommended that we reset and reprogram idmac */
-	dw_mci_idmac_reset(host);
-#endif
+	if (host->use_dma == TRANS_MODE_IDMAC)
+		/* It is also recommended that we reset and reprogram idmac */
+		dw_mci_idmac_reset(host);
 
 	ret = true;
 
@@ -2890,7 +3047,7 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
 	 */
-	i = (mci_readl(host, HCON) >> 7) & 0x7;
+	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
@@ -2972,7 +3129,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->pdata->num_slots)
 		host->num_slots = host->pdata->num_slots;
 	else
-		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
+		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
 
 	/*
 	 * Enable interrupts for command done, data over, data empty,
@@ -3067,6 +3224,9 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
+	if (host->use_dma && host->dma_ops->exit)
+		host->dma_ops->exit(host);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 8ce4674..c453e94 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -148,6 +148,11 @@
 #define SDMMC_SET_FIFOTH(m, r, t)	(((m) & 0x7) << 28 | \
 					 ((r) & 0xFFF) << 16 | \
 					 ((t) & 0xFFF))
+/* HCON register defines */
+#define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
+#define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
+#define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
+#define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
 /* Internal DMAC interrupt defines */
 #define SDMMC_IDMAC_INT_AI		BIT(9)
 #define SDMMC_IDMAC_INT_NI		BIT(8)
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index c846f42..6a2b83c 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -16,6 +16,7 @@
 
 #include <linux/scatterlist.h>
 #include <linux/mmc/core.h>
+#include <linux/dmaengine.h>
 
 #define MAX_MCI_SLOTS	2
 
@@ -40,6 +41,17 @@ enum {
 
 struct mmc_data;
 
+enum {
+	TRANS_MODE_PIO = 0,
+	TRANS_MODE_IDMAC,
+	TRANS_MODE_EDMAC
+};
+
+struct dw_mci_dma_slave {
+	struct dma_chan *ch;
+	enum dma_transfer_direction direction;
+};
+
 /**
  * struct dw_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
@@ -154,11 +166,16 @@ struct dw_mci {
 	dma_addr_t		sg_dma;
 	void			*sg_cpu;
 	const struct dw_mci_dma_ops	*dma_ops;
-#ifdef CONFIG_MMC_DW_IDMAC
+	/* For idmac */
 	unsigned int		ring_size;
-#else
+
+	/* For edmac */
+	struct dw_mci_dma_slave *dms;
+	/* Registers's physical base address */
+	void                    *phy_regs;
+
 	struct dw_mci_dma_data	*dma_data;
-#endif
+
 	u32			cmd_status;
 	u32			data_status;
 	u32			stop_cmdr;
@@ -212,8 +229,8 @@ struct dw_mci {
 struct dw_mci_dma_ops {
 	/* DMA Ops */
 	int (*init)(struct dw_mci *host);
-	void (*start)(struct dw_mci *host, unsigned int sg_len);
-	void (*complete)(struct dw_mci *host);
+	int (*start)(struct dw_mci *host, unsigned int sg_len);
+	void (*complete)(void *host);
 	void (*stop)(struct dw_mci *host);
 	void (*cleanup)(struct dw_mci *host);
 	void (*exit)(struct dw_mci *host);
-- 
2.3.7
