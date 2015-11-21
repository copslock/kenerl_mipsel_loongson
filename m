Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 01:17:50 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:24052 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013070AbbKUARBFc2Ix (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2015 01:17:01 +0100
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Fri, 20 Nov 2015
 17:16:52 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 20 Nov 2015
 17:23:19 -0700
From:   Joshua Henderson <joshua.henderson@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Corneliu Doban <cdoban@broadcom.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        yangbo lu <yangbo.lu@freescale.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Andy Green <andy.green@linaro.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 11/14] mmc: sdhci-pic32: Add PIC32 SDHC host controller driver
Date:   Fri, 20 Nov 2015 17:17:23 -0700
Message-ID: <1448065205-15762-12-git-send-email-joshua.henderson@microchip.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

From: Andrei Pistirica <andrei.pistirica@microchip.com>

This driver supports the SDHCI host controller found on the PIC32 in DMA
or PIO mode.

Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
---
 drivers/mmc/host/Kconfig       |   11 ++
 drivers/mmc/host/Makefile      |    1 +
 drivers/mmc/host/sdhci-pic32.c |  354 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-pic32.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index af71de5..75aaed1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -784,3 +784,14 @@ config MMC_MTK
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
 	  This is needed if support for any SD/SDIO/MMC devices is required.
 	  If unsure, say N.
+
+config MMC_SDHCI_MICROCHIP_PIC32
+        tristate "Microchip PIC32MZDA SDHCI support"
+        depends on MMC_SDHCI && PIC32MZDA
+        help
+          This selects the Secure Digital Host Controller Interface (SDHCI)
+          for PIC32MZDA platform.
+
+          If you have a controller with this interface, say Y or M here.
+
+          If unsure, say N.
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 3595f83..af918d2 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
 obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
+obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
new file mode 100644
index 0000000..7ff23a9
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -0,0 +1,354 @@
+/*
+ * Support of SDHCI platform devices for Microchip PIC32.
+ *
+ * Copyright (C) 2015 Microchip
+ * Andrei Pistirica, Paul Thacker
+ *
+ * Inspired by sdhci-pltfm.c
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/mmc/host.h>
+#include <linux/io.h>
+#include "sdhci.h"
+#include <linux/platform_data/sdhci-pic32.h>
+
+#define PIC32_MMC_OCR (MMC_VDD_32_33 | MMC_VDD_33_34)
+
+#define SDH_SHARED_BUS_CTRL		0x000000E0
+#define SDH_SHARED_BUS_NR_CLK_PINS_MASK	0x7
+#define SDH_SHARED_BUS_NR_IRQ_PINS_MASK	0x30
+#define SDH_SHARED_BUS_CLK_PINS		0x10
+#define SDH_SHARED_BUS_IRQ_PINS		0x14
+#define SDH_CAPS_SDH_SLOT_TYPE_MASK	0xC0000000
+#define SDH_SLOT_TYPE_REMOVABLE		0x0
+#define SDH_SLOT_TYPE_EMBEDDED		0x1
+#define SDH_SLOT_TYPE_SHARED_BUS	0x2
+#define SDHCI_CTRL_CDSSEL		0x80
+#define SDHCI_CTRL_CDTLVL		0x40
+
+#define ADMA_FIFO_RD_THSHLD	512
+#define ADMA_FIFO_WR_THSHLD	512
+
+#define DEV_NAME "pic32-sdhci"
+
+struct pic32_sdhci_pdata {
+	struct platform_device	*pdev;
+	struct clk *sys_clk;
+	struct clk *base_clk;
+	bool support_vsel;
+	bool piomode;
+};
+
+unsigned int pic32_sdhci_get_max_clock(struct sdhci_host *host)
+{
+	struct pic32_sdhci_pdata *sdhci_pdata = sdhci_priv(host);
+	unsigned int clk_rate = clk_get_rate(sdhci_pdata->base_clk);
+	struct platform_device *pdev = sdhci_pdata->pdev;
+
+	dev_dbg(&pdev->dev, "Sdhc max clock rate: %u\n", clk_rate);
+	return clk_rate;
+}
+
+unsigned int pic32_sdhci_get_min_clock(struct sdhci_host *host)
+{
+	struct pic32_sdhci_pdata *sdhci_pdata = sdhci_priv(host);
+	unsigned int clk_rate = clk_get_rate(sdhci_pdata->base_clk);
+	struct platform_device *pdev = sdhci_pdata->pdev;
+
+	dev_dbg(&pdev->dev, "Sdhc min clock rate: %u\n", clk_rate);
+	return clk_rate;
+}
+
+void pic32_sdhci_set_bus_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	if (width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl |= SDHCI_CTRL_8BITBUS;
+	} else {
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl &= ~SDHCI_CTRL_8BITBUS;
+		if (width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
+	/*
+	 * SDHC will not work if JTAG is not Connected.As a workaround fix,
+	 * set Card Detect Signal Selection bit in SDHC Host Control
+	 * register and clear Card Detect Test Level bit in SDHC Host
+	 * Control register.
+	 */
+	ctrl &= ~SDHCI_CTRL_CDTLVL;
+	ctrl |= SDHCI_CTRL_CDSSEL;
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
+static unsigned int pic32_sdhci_get_ro(struct sdhci_host *host)
+{
+	/*
+	 * The SDHCI_WRITE_PROTECT bit is unstable on current hardware so we
+	 * can't depend on its value in any way.
+	 */
+	return 0;
+}
+
+static const struct sdhci_ops pic32_sdhci_ops = {
+	.get_max_clock = pic32_sdhci_get_max_clock,
+	.get_min_clock = pic32_sdhci_get_min_clock,
+	.set_clock = sdhci_set_clock,
+	.set_bus_width = pic32_sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.get_ro = pic32_sdhci_get_ro,
+};
+
+void pic32_sdhci_shared_bus(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	u32 bus = readl(host->ioaddr + SDH_SHARED_BUS_CTRL);
+	u32 clk_pins = (bus & SDH_SHARED_BUS_NR_CLK_PINS_MASK) >> 0;
+	u32 irq_pins = (bus & SDH_SHARED_BUS_NR_IRQ_PINS_MASK) >> 4;
+
+	/* select first clock */
+	if (clk_pins & 0x1)
+		bus |= (0x1 << SDH_SHARED_BUS_CLK_PINS);
+
+	/* select first interrupt */
+	if (irq_pins & 0x1)
+		bus |= (0x1 << SDH_SHARED_BUS_IRQ_PINS);
+
+	writel(bus, host->ioaddr + SDH_SHARED_BUS_CTRL);
+}
+
+static int pic32_sdhci_probe_platform(struct platform_device *pdev,
+				      struct pic32_sdhci_pdata *pdata)
+{
+	int ret = 0;
+	u32 caps_slot_type;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+
+	/* Check card slot connected on shared bus. */
+	host->caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
+	caps_slot_type = (host->caps & SDH_CAPS_SDH_SLOT_TYPE_MASK) >> 30;
+	if (caps_slot_type == SDH_SLOT_TYPE_SHARED_BUS)
+		pic32_sdhci_shared_bus(pdev);
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static inline int
+sdhci_pic32_probe_dts(struct platform_device *pdev,
+		      struct pic32_sdhci_pdata *boarddata)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	if (of_find_property(np, "no-1-8-v", NULL))
+		boarddata->support_vsel = true;
+	else
+		boarddata->support_vsel = false;
+
+	if (of_find_property(np, "piomode", NULL))
+		boarddata->piomode = true;
+	else
+		boarddata->piomode = false;
+
+	return 0;
+}
+#else
+static inline int
+sdhci_pic32_probe_dts(struct platform_device *pdev,
+		      struct pic32_sdhci_pdata *boarddata)
+{
+	return -ENODEV;
+}
+#endif
+
+int pic32_sdhci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sdhci_host *host;
+	struct resource *iomem;
+	struct pic32_sdhci_pdata *sdhci_pdata;
+	struct pic32_sdhci_platform_data *plat_data;
+	unsigned int clk_rate = 0;
+	int ret;
+	struct pinctrl *pinctrl;
+
+	host = sdhci_alloc_host(dev, sizeof(*sdhci_pdata));
+	if (IS_ERR(host)) {
+		ret = PTR_ERR(host);
+		dev_err(&pdev->dev, "cannot allocate memory for sdhci\n");
+		goto err;
+	}
+
+	sdhci_pdata = sdhci_priv(host);
+	sdhci_pdata->pdev = pdev;
+	platform_set_drvdata(pdev, host);
+
+	if (sdhci_pic32_probe_dts(pdev, sdhci_pdata) < 0) {
+		ret = -EINVAL;
+		dev_err(&pdev->dev, "no device tree information %d\n", ret);
+		goto err_host1;
+	}
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host->ioaddr = devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(host->ioaddr)) {
+		ret = PTR_ERR(host->ioaddr);
+		dev_err(&pdev->dev, "unable to map iomem: %d\n", ret);
+		goto err_host;
+	}
+
+	if (!sdhci_pdata->piomode) {
+		plat_data = pdev->dev.platform_data;
+		if (plat_data && plat_data->setup_dma) {
+			ret = plat_data->setup_dma(ADMA_FIFO_RD_THSHLD,
+						   ADMA_FIFO_WR_THSHLD);
+			if (ret)
+				goto err_host;
+		}
+	}
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		dev_warn(&pdev->dev, "No pinctrl provided %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			goto err_host;
+	}
+
+	host->ops = &pic32_sdhci_ops;
+	host->irq = platform_get_irq(pdev, 0);
+
+	sdhci_pdata->sys_clk = devm_clk_get(&pdev->dev, "sys_clk");
+	if (IS_ERR(sdhci_pdata->sys_clk)) {
+		ret = PTR_ERR(sdhci_pdata->sys_clk);
+		dev_err(&pdev->dev, "Error getting clock\n");
+		goto err_host;
+	}
+
+	/* Enable clock when available! */
+	ret = clk_prepare_enable(sdhci_pdata->sys_clk);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Error enabling clock\n");
+		goto err_host;
+	}
+
+	/* SDH CLK enable */
+	sdhci_pdata->base_clk = devm_clk_get(&pdev->dev, "base_clk");
+	if (IS_ERR(sdhci_pdata->base_clk)) {
+		ret = PTR_ERR(sdhci_pdata->base_clk);
+		dev_err(&pdev->dev, "Error getting clock\n");
+		goto err_host;
+	}
+
+	/* Enable clock when available! */
+	ret = clk_prepare_enable(sdhci_pdata->base_clk);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Error enabling clock\n");
+		goto err_host;
+	}
+
+	clk_rate = clk_get_rate(sdhci_pdata->base_clk);
+	dev_dbg(&pdev->dev, "base clock at: %u\n", clk_rate);
+	clk_rate = clk_get_rate(sdhci_pdata->sys_clk);
+	dev_dbg(&pdev->dev, "sys clock at: %u\n", clk_rate);
+
+	if (sdhci_pdata->support_vsel)
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+
+	if (sdhci_pdata->piomode)
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA |
+			SDHCI_QUIRK_BROKEN_DMA;
+
+	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
+	host->mmc->ocr_avail = PIC32_MMC_OCR;
+
+	ret = pic32_sdhci_probe_platform(pdev, sdhci_pdata);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to probe platform!\n");
+		goto err_host;
+	}
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_dbg(&pdev->dev, "error adding host\n");
+		goto err_host;
+	}
+
+	dev_info(&pdev->dev, "Successfully added sdhci host\n");
+	return 0;
+
+err_host:
+	devm_iounmap(&pdev->dev, host->ioaddr);
+err_host1:
+	sdhci_free_host(host);
+err:
+	dev_err(&pdev->dev, "pic32-sdhci probe failed: %d\n", ret);
+	return ret;
+}
+
+static int pic32_sdhci_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct pic32_sdhci_pdata *sdhci_pdata = sdhci_priv(host);
+	int dead = 0;
+	u32 scratch;
+
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+
+	sdhci_remove_host(host, dead);
+	clk_disable_unprepare(sdhci_pdata->base_clk);
+	clk_disable_unprepare(sdhci_pdata->sys_clk);
+	devm_iounmap(&pdev->dev, host->ioaddr);
+	sdhci_free_host(host);
+
+	return 0;
+}
+
+static const struct of_device_id pic32_sdhci_id_table[] = {
+	{ .compatible = "microchip,pic32-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
+
+static struct platform_driver pic32_sdhci_driver = {
+	.driver = {
+		.name	= DEV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
+	},
+	.probe		= pic32_sdhci_probe,
+	.remove		= pic32_sdhci_remove,
+};
+
+module_platform_driver(pic32_sdhci_driver);
+
+MODULE_DESCRIPTION("Microchip PIC32 SDHCI driver");
+MODULE_AUTHOR("Pistirica Sorin Andrei & Sandeep Sheriker");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
