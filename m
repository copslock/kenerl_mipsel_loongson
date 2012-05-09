Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2012 21:07:26 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:55646 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901341Ab2EITHS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 May 2012 21:07:18 +0200
Received: by dadm1 with SMTP id m1so774382dad.36
        for <linux-mips@linux-mips.org>; Wed, 09 May 2012 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tKiS/ELIZS0FewLFVOgftGx1NuAZJaL1cJc5X8HJq6g=;
        b=IJk8bphmDfq6fVGDqyo9QgAw9mf5Rer6Mtn0Q/BplYyMdrQ4FDFJrNJPYcZvOfWsDO
         r+rJakWr8FojFPTqLHSHahT6nz9khqw5hXW3HfDvU++Y/U2m7sHZnIcYbrLAX5tV5w42
         e8QSz2iVV8+jZSNFTDOEL8nxbAFyKIjfm/VEiYBBxCdEGrjsIxhrwxxW7HCRfWZsU1fs
         SroEMcIrTqBBPhbveezTHZioaQToZN58mxd6yDW4IE2icnN3oAy/2HilkTaOgL2dORoT
         4cBGwpX0rap93lzaOcgy/bke28yMtQVgV8aZmVAU+CBxt6GqGJ7lj+Ml5DOYRKSrv+Et
         mlBw==
Received: by 10.68.194.230 with SMTP id hz6mr1388285pbc.128.1336590431520;
        Wed, 09 May 2012 12:07:11 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rj4sm6946662pbc.30.2012.05.09.12.07.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 May 2012 12:07:10 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q49J78i4010413;
        Wed, 9 May 2012 12:07:08 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q49J76bB010411;
        Wed, 9 May 2012 12:07:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH RFC] mmc: Add host driver for OCTEON MMC controller.
Date:   Wed,  9 May 2012 12:07:05 -0700
Message-Id: <1336590425-10381-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The OCTEON MMC controller is currently found on cn61XX and cnf71XX
devices.  Device parameters are configured from device tree data.

Currenly supported are eMMC, MMC and SD devices.

Signed-off-by: David Daney <david.daney@cavium.com>
---

This patch depends on:
http://www.linux-mips.org/archives/linux-mips/2012-04/msg00198.html

Which isn't merged yet, so for the time being this remains an RFC.
However, once Ralf merges the prerequisite, we could consider merging
this one as well.

 .../devicetree/bindings/mmc/octeon-mmc.txt         |   51 +
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/octeon_mmc.c                      | 1107 ++++++++++++++++++++
 4 files changed, 1169 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
 create mode 100644 drivers/mmc/host/octeon_mmc.c

diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
new file mode 100644
index 0000000..86f1fe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
@@ -0,0 +1,51 @@
+* OCTEON SD/MMC Host Controller
+
+This controller is present on some members of the Cavium OCTEON SoC
+family, provide an interface for eMMC, MMC and SD devices.  There is a
+single controller that may have several "slots" connected.  These
+slots appear as children of the main controller node.
+
+Required properties:
+- compatible : Should be "cavium,octeon-6130-mmc"
+- reg : Two entries:
+	1) The base address of the MMC controller register bank.
+	2) The base address of the MMC DMA engine register bank.
+- interrupts : Two entries:
+	1) The MMC controller interrupt line.
+	2) The MMC DMA engine interrupt line.
+- #address-cells : Must be <1>
+- #size-cells : Must be <0>
+
+Required properties of child nodes:
+- compatible : Should be "cavium,octeon-6130-mmc-slot".
+- reg : The slot number.
+- cavium,bus-max-width : The number of data lines present in the slot.
+- spi-max-frequency : The maximum operating frequency of the slot.
+
+Optional properties of child nodes:
+- cd-gpios : Specify GPIOs for card detection
+- wp-gpios : Specify GPIOs for write protection
+- power-gpios : Specify GPIOs for power control
+
+Example:
+	mmc@1180000002000 {
+		compatible = "cavium,octeon-6130-mmc";
+		reg = <0x11800 0x00002000 0x0 0x100>,
+		      <0x11800 0x00000168 0x0 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* EMM irq, DMA irq */
+		interrupts = <1 19>, <0 63>;
+
+		/* The board only has a single MMC slot */
+		mmc-slot@0 {
+			compatible = "cavium,octeon-6130-mmc-slot";
+			reg = <0>;
+			spi-max-frequency = <20000000>;
+			/* bus width can be 1, 4 or 8 */
+			cavium,bus-max-width = <8>;
+			cd-gpios = <&gpio 9 0>;
+			wp-gpios = <&gpio 10 0>;
+			power-gpios = <&gpio 8 0>;
+		};
+	};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2bc06e7..37de129 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -229,6 +229,16 @@ config MMC_SDHCI_S3C_DMA
 
 	  YMMV.
 
+config MMC_OCTEON
+	tristate "Cavium OCTEON Multimedia Card Interface support"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This selects Cavium OCTEON Multimedia card Interface.
+	  If you have an OCTEON board with a Multimedia Card slot,
+	  say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 3e7e26d..f58f49c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
 obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
 obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
+obj-$(CONFIG_MMC_OCTEON)	+= octeon_mmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o
 obj-$(CONFIG_MMC_AT91)		+= at91_mci.o
diff --git a/drivers/mmc/host/octeon_mmc.c b/drivers/mmc/host/octeon_mmc.c
new file mode 100644
index 0000000..cb4243d
--- /dev/null
+++ b/drivers/mmc/host/octeon_mmc.c
@@ -0,0 +1,1107 @@
+/*
+ * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 Cavium Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/scatterlist.h>
+#include <linux/interrupt.h>
+#include <linux/of_gpio.h>
+#include <linux/blkdev.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+
+#include <asm/byteorder.h>
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-mio-defs.h>
+
+#define DRV_NAME	"octeon_mmc"
+#define DRV_VERSION	"1.0"
+
+#define OCTEON_MAX_MMC			4
+
+#define OCT_MIO_NDF_DMA_CFG		0x00
+#define OCT_MIO_NDF_DMA_INT		0x08
+#define OCT_MIO_NDF_DMA_INT_EN		0x10
+
+#define OCT_MIO_EMM_CFG			0x00
+#define OCT_MIO_EMM_SWITCH		0x48
+#define OCT_MIO_EMM_DMA			0x50
+#define OCT_MIO_EMM_CMD			0x58
+#define OCT_MIO_EMM_RSP_STS		0x60
+#define OCT_MIO_EMM_RSP_LO		0x68
+#define OCT_MIO_EMM_RSP_HI		0x70
+#define OCT_MIO_EMM_INT			0x78
+#define OCT_MIO_EMM_INT_EN		0x80
+#define OCT_MIO_EMM_WDOG		0x88
+#define OCT_MIO_EMM_STS_MASK		0x98
+#define OCT_MIO_EMM_RCA			0xa0
+#define OCT_MIO_EMM_BUF_IDX		0xe0
+#define OCT_MIO_EMM_BUF_DAT		0xe8
+
+struct octeon_mmc_host {
+	spinlock_t		lock;
+	u64	base;
+	u64	ndf_base;
+	u64	last_emm_switch;
+
+	struct mmc_request	*current_req;
+	struct sg_mapping_iter smi;
+	int sg_idx;
+	bool dma_active;
+
+	struct semaphore mmc_serializer;
+
+	struct platform_device	*pdev;
+
+	struct octeon_mmc_slot	*slot[OCTEON_MAX_MMC];
+};
+
+struct octeon_mmc_slot {
+	struct mmc_host         *mmc;
+	struct octeon_mmc_host	*host;
+
+	unsigned int		clock;
+	unsigned int		sclock;
+
+	int			bus_width;
+	int			bus_id;
+	int			ro_gpio;
+	int			cd_gpio;
+	int			power_gpio;
+	bool			cd_gpio_active_low;
+	bool			ro_gpio_active_low;
+	bool			power_gpio_active_low;
+};
+
+struct octeon_mmc_cr_type {
+	u8 ctype;
+	u8 rtype;
+};
+
+/*
+ * The OCTEON MMC host hardware assumes that all commands have fixed
+ * command and response types.  These are correct if MMC devices are
+ * being used.  However, non-MMC devices like SD use command and
+ * response types that are unexpected by the host hardware.
+ *
+ * The command and response types can be overridden by supplying an
+ * XOR value that is applied to the type.  We calculate the XOR value
+ * from the values in this table and the flags passed from the MMC
+ * core.
+ */
+static struct octeon_mmc_cr_type octeon_mmc_cr_types[] = {
+	{0, 0},		/* CMD0 */
+	{0, 3},		/* CMD1 */
+	{0, 2},		/* CMD2 */
+	{0, 1},		/* CMD3 */
+	{0, 0},		/* CMD4 */
+	{0, 1},		/* CMD5 */
+	{0, 1},		/* CMD6 */
+	{0, 1},		/* CMD7 */
+	{1, 1},		/* CMD8 */
+	{0, 2},		/* CMD9 */
+	{0, 2},		/* CMD10 */
+	{1, 1},		/* CMD11 */
+	{0, 1},		/* CMD12 */
+	{0, 1},		/* CMD13 */
+	{1, 1},		/* CMD14 */
+	{0, 0},		/* CMD15 */
+	{0, 1},		/* CMD16 */
+	{1, 1},		/* CMD17 */
+	{1, 1},		/* CMD18 */
+	{3, 1},		/* CMD19 */
+	{2, 1},		/* CMD20 */
+	{0, 0},		/* CMD21 */
+	{0, 0},		/* CMD22 */
+	{0, 1},		/* CMD23 */
+	{2, 1},		/* CMD24 */
+	{2, 1},		/* CMD25 */
+	{2, 1},		/* CMD26 */
+	{2, 1},		/* CMD27 */
+	{0, 1},		/* CMD28 */
+	{0, 1},		/* CMD29 */
+	{1, 1},		/* CMD30 */
+	{1, 1},		/* CMD31 */
+	{0, 0},		/* CMD32 */
+	{0, 0},		/* CMD33 */
+	{0, 0},		/* CMD34 */
+	{0, 1},		/* CMD35 */
+	{0, 1},		/* CMD36 */
+	{0, 0},		/* CMD37 */
+	{0, 1},		/* CMD38 */
+	{0, 4},		/* CMD39 */
+	{0, 5},		/* CMD40 */
+	{0, 0},		/* CMD41 */
+	{2, 1},		/* CMD42 */
+	{0, 0},		/* CMD43 */
+	{0, 0},		/* CMD44 */
+	{0, 0},		/* CMD45 */
+	{0, 0},		/* CMD46 */
+	{0, 0},		/* CMD47 */
+	{0, 0},		/* CMD48 */
+	{0, 0},		/* CMD49 */
+	{0, 0},		/* CMD50 */
+	{0, 0},		/* CMD51 */
+	{0, 0},		/* CMD52 */
+	{0, 0},		/* CMD53 */
+	{0, 0},		/* CMD54 */
+	{0, 1},		/* CMD55 */
+	{0xff, 0xff},	/* CMD56 */
+	{0, 0},		/* CMD57 */
+	{0, 0},		/* CMD58 */
+	{0, 0},		/* CMD59 */
+	{0, 0},		/* CMD60 */
+	{0, 0},		/* CMD61 */
+	{0, 0},		/* CMD62 */
+	{0, 0}		/* CMD63 */
+};
+
+struct octeon_mmc_cr_mods {
+	u8 ctype_xor;
+	u8 rtype_xor;
+};
+
+static struct octeon_mmc_cr_mods octeon_mmc_get_cr_mods(struct mmc_command *cmd)
+{
+	struct octeon_mmc_cr_type *cr;
+	u8 desired_ctype, hardware_ctype;
+	u8 desired_rtype, hardware_rtype;
+	struct octeon_mmc_cr_mods r;
+
+	cr = octeon_mmc_cr_types + (cmd->opcode & 0x3f);
+	hardware_ctype = cr->ctype;
+	hardware_rtype = cr->rtype;
+	if (cmd->opcode == 56) { /* CMD56 GEN_CMD */
+		hardware_ctype = (cmd->arg & 1) ? 1 : 2;
+	}
+
+	switch (mmc_cmd_type(cmd)) {
+	case MMC_CMD_ADTC:
+		desired_ctype = (cmd->data->flags & MMC_DATA_WRITE) ? 2 : 1;
+		break;
+	case MMC_CMD_AC:
+	case MMC_CMD_BC:
+	case MMC_CMD_BCR:
+		desired_ctype = 0;
+		break;
+	}
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_NONE:
+		desired_rtype = 0;
+		break;
+	case MMC_RSP_R1:/* MMC_RSP_R5, MMC_RSP_R6, MMC_RSP_R7 */
+	case MMC_RSP_R1B:
+		desired_rtype = 1;
+		break;
+	case MMC_RSP_R2:
+		desired_rtype = 2;
+		break;
+	case MMC_RSP_R3: /* MMC_RSP_R4 */
+		desired_rtype = 3;
+		break;
+	}
+	r.ctype_xor = desired_ctype ^ hardware_ctype;
+	r.rtype_xor = desired_rtype ^ hardware_rtype;
+	return r;
+}
+
+static bool octeon_mmc_switch_val_changed(struct octeon_mmc_slot *slot,
+					  u64 new_val)
+{
+	/* Match BUS_ID, HS_TIMING, BUS_WIDTH, POWER_CLASS, CLK_HI, CLK_LO */
+	u64 m = 0x3001070fffffffffull;
+	return (slot->host->last_emm_switch & m) != (new_val & m);
+}
+
+static unsigned int octeon_mmc_timeout_to_wdog(struct octeon_mmc_slot *slot,
+					       unsigned int ns)
+{
+	u64 bt = (u64)slot->clock * (u64)ns;
+	return (unsigned int)(bt / 1000000000);
+}
+
+static void octeon_mmc_dma_next(struct octeon_mmc_host	*host)
+{
+	struct scatterlist *sg;
+	struct mmc_data *data;
+	union cvmx_mio_ndf_dma_cfg dma_cfg;
+	u64 dma_int_en;
+
+	data = host->current_req->data;
+	sg = data->sg + host->sg_idx;
+
+	dma_cfg.u64 = 0;
+	dma_cfg.s.en = 1;
+	dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+#ifdef __LITTLE_ENDIAN
+	dma_cfg.s.endian = 1;
+#endif
+	dma_cfg.s.size = (sg->length / 8) - 1;
+	dma_cfg.s.adr = sg_phys(sg);
+
+	host->sg_idx++;
+
+	if (host->sg_idx >= host->current_req->data->sg_len)
+		dma_int_en = 0;
+	else
+		dma_int_en = 1;
+
+	cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_INT_EN, dma_int_en);
+	cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_CFG, dma_cfg.u64);
+
+}
+
+static irqreturn_t octeon_mmc_dma_interrupt(int irq, void *dev_id)
+{
+	struct octeon_mmc_host *host = dev_id;
+	unsigned long flags;
+
+	pr_debug("Got interrupt: NDF_DMA_INT\n");
+	spin_lock_irqsave(&host->lock, flags);
+	/* Clear any pending irqs */
+	cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_INT, 1);
+
+	if (!host->current_req || !host->current_req->data) {
+		pr_err("ERROR: no current_req for octeon_mmc_dma_interrupt\n");
+		goto out;
+	}
+
+	if (host->sg_idx < host->current_req->data->sg_len)
+		octeon_mmc_dma_next(host);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return IRQ_RETVAL(1);
+}
+
+static irqreturn_t octeon_mmc_interrupt(int irq, void *dev_id)
+{
+	struct octeon_mmc_host *host = dev_id;
+	union cvmx_mio_emm_int emm_int;
+	struct mmc_request	*req;
+	bool host_done;
+	union cvmx_mio_emm_rsp_sts rsp_sts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	emm_int.u64 = cvmx_read_csr(host->base + OCT_MIO_EMM_INT);
+	req = host->current_req;
+	cvmx_write_csr(host->base + OCT_MIO_EMM_INT, emm_int.u64);
+
+	pr_debug("Got interrupt: EMM_INT = 0x%llx\n", emm_int.u64);
+
+	if (!req)
+		goto out;
+
+	rsp_sts.u64 = cvmx_read_csr(host->base + OCT_MIO_EMM_RSP_STS);
+	pr_debug("octeon_mmc_interrupt  MIO_EMM_RSP_STS 0x%llx\n", rsp_sts.u64);
+
+	if (!host->dma_active && emm_int.s.buf_done && req->cmd->data &&
+	    ((rsp_sts.u64 >> 7) & 3) == 1) {
+		/* Read */
+		int dbuf = rsp_sts.s.dbuf;
+		struct sg_mapping_iter *smi = &host->smi;
+		unsigned int bytes_xfered = 0;
+		u64 dat = 0;
+		int shift = -1;
+
+		/* Auto inc from offset zero */
+		cvmx_write_csr(host->base + OCT_MIO_EMM_BUF_IDX, (u64)(0x10000 | (dbuf << 6)));
+
+		for (;;) {
+			if (smi->consumed >= smi->length) {
+				if (!sg_miter_next(smi))
+					break;
+				smi->consumed = 0;
+			}
+			if (shift < 0) {
+				dat = cvmx_read_csr(host->base + OCT_MIO_EMM_BUF_DAT);
+				shift = 56;
+			}
+
+			while (smi->consumed < smi->length && shift >= 0) {
+				*(u8 *)(smi->addr) = (dat >> shift) & 0xff;
+				bytes_xfered++;
+				smi->addr++;
+				smi->consumed++;
+				shift -= 8;
+			}
+		}
+		sg_miter_stop(smi);
+		req->cmd->data->bytes_xfered = bytes_xfered;
+		req->cmd->data->error = 0;
+	}
+	host_done = emm_int.s.cmd_done || emm_int.s.dma_done ||
+		emm_int.s.cmd_err || emm_int.s.dma_err;
+	if (host_done && req->done) {
+		if (rsp_sts.u64 & (7ull << 13))
+			req->cmd->error = -EILSEQ;
+		else
+			req->cmd->error = 0;
+
+		if (host->dma_active && req->cmd->data) {
+			req->cmd->data->error = 0;
+			req->cmd->data->bytes_xfered = req->cmd->data->blocks * req->cmd->data->blksz;
+		}
+		if (rsp_sts.s.rsp_val) {
+			u64 rsp_hi;
+			u64 rsp_lo = cvmx_read_csr(host->base + OCT_MIO_EMM_RSP_LO);
+
+			switch (rsp_sts.s.rsp_type) {
+			case 1:
+			case 3:
+				req->cmd->resp[0] = (rsp_lo >> 8) & 0xffffffff;
+				req->cmd->resp[1] = 0;
+				req->cmd->resp[2] = 0;
+				req->cmd->resp[3] = 0;
+				break;
+			case 2:
+				req->cmd->resp[3] = rsp_lo & 0xffffffff;
+				req->cmd->resp[2] = (rsp_lo >> 32) & 0xffffffff;
+				rsp_hi = cvmx_read_csr(host->base + OCT_MIO_EMM_RSP_HI);
+				req->cmd->resp[1] = rsp_hi & 0xffffffff;
+				req->cmd->resp[0] = (rsp_hi >> 32) & 0xffffffff;
+				break;
+			default:
+				pr_debug("octeon_mmc_interrupt unhandled rsp_val %d\n",
+					 rsp_sts.s.rsp_type);
+				break;
+			}
+			pr_debug("octeon_mmc_interrupt  resp %08x %08x %08x %08x\n",
+				 req->cmd->resp[0], req->cmd->resp[1],
+				 req->cmd->resp[2], req->cmd->resp[3]);
+		}
+		if (emm_int.s.dma_err && rsp_sts.s.dma_pend) {
+			/* Try to clean up failed DMA */
+			union cvmx_mio_emm_dma emm_dma;
+			emm_dma.u64 = 0;
+			emm_dma.s.dma_val = 1;
+			emm_dma.s.dat_null = 1;
+			emm_dma.s.bus_id = rsp_sts.s.bus_id;
+			cvmx_write_csr(host->base + OCT_MIO_EMM_DMA,
+				       emm_dma.u64);
+		}
+
+		host->current_req = NULL;
+		req->done(req);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+	if (host_done)
+		up(&host->mmc_serializer);
+out:
+	return IRQ_RETVAL(emm_int.u64 != 0);
+}
+
+static void octeon_mmc_dma_request(struct mmc_host *mmc,
+				   struct mmc_request *mrq)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	struct mmc_command *cmd;
+	struct mmc_data *data;
+	union cvmx_mio_emm_int emm_int;
+	union cvmx_mio_emm_dma emm_dma;
+	unsigned long flags;
+
+	cmd = mrq->cmd;
+	if (mrq->data == NULL || mrq->data->sg == NULL || !mrq->data->sg_len ||
+	    mrq->stop == NULL || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
+		pr_err("Error: octeon_mmc_dma_request no data\n");
+		cmd->error = -EINVAL;
+		if (mrq->done)
+			mrq->done(mrq);
+		return;
+	}
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the host block at a time. */
+	down(&host->mmc_serializer);
+
+	data = mrq->data;
+
+	if (data->timeout_ns) {
+		cvmx_write_csr(host->base + OCT_MIO_EMM_WDOG,
+			       octeon_mmc_timeout_to_wdog(slot, data->timeout_ns));
+		pr_debug("OCT_MIO_EMM_WDOG %llu\n",
+			 cvmx_read_csr(host->base + OCT_MIO_EMM_WDOG));
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+	WARN_ON(host->current_req);
+	host->current_req = mrq;
+
+	host->sg_idx = 0;
+
+	/* Clear any pending irqs */
+	cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_INT, 1);
+
+	octeon_mmc_dma_next(host);
+	emm_dma.u64 = 0;
+	emm_dma.s.bus_id = slot->bus_id;
+	emm_dma.s.dma_val = 1;
+	emm_dma.s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
+	emm_dma.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
+	if (mmc_card_mmc(mmc->card) ||
+	    (mmc_card_sd(mmc->card) &&
+	     (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
+		emm_dma.s.multi = 1;
+	emm_dma.s.block_cnt = data->blocks;
+	emm_dma.s.card_addr = cmd->arg;
+
+	emm_int.u64 = 0;
+	emm_int.s.dma_done = 1;
+	emm_int.s.cmd_err = 1;
+	emm_int.s.dma_err = 1;
+	/* Clear the bit. */
+	cvmx_write_csr(host->base + OCT_MIO_EMM_INT, emm_int.u64);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_INT_EN, emm_int.u64);
+	host->dma_active = true;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	cvmx_write_csr(host->base + OCT_MIO_EMM_STS_MASK, 0xe4f90080ull);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_STS_MASK, 0);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_DMA, emm_dma.u64);
+	pr_debug("Send the dma command: %llx\n", emm_dma.u64);
+}
+
+static void octeon_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	struct mmc_command *cmd;
+	union cvmx_mio_emm_int emm_int;
+	union cvmx_mio_emm_cmd emm_cmd;
+	struct octeon_mmc_cr_mods mods;
+	unsigned long flags;
+
+	cmd = mrq->cmd;
+
+	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK || cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		octeon_mmc_dma_request(mmc, mrq);
+		return;
+	}
+
+	mods = octeon_mmc_get_cr_mods(cmd);
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the host block at a time. */
+	down(&host->mmc_serializer);
+
+	spin_lock_irqsave(&host->lock, flags);
+	WARN_ON(host->current_req);
+	host->current_req = mrq;
+
+	emm_int.u64 = 0;
+	emm_int.s.cmd_done = 1;
+	emm_int.s.cmd_err = 1;
+	if (cmd->data) {
+		pr_debug("command has data\n");
+		cmd->error = -EINPROGRESS;
+		if (cmd->data->flags & MMC_DATA_READ) {
+			emm_int.s.buf_done = 1;
+			sg_miter_start(&host->smi, mrq->cmd->data->sg,
+				       mrq->cmd->data->sg_len, SG_MITER_ATOMIC | SG_MITER_TO_SG);
+		} else {
+			struct sg_mapping_iter *smi = &host->smi;
+			unsigned int bytes_xfered = 0;
+			u64 dat = 0;
+			int shift = 56;
+			/* Copy data to the xmit buffer before issuing the command */
+			sg_miter_start(smi, mrq->cmd->data->sg,
+				       mrq->cmd->data->sg_len, SG_MITER_TO_SG);
+			/* Auto inc from offset zero, dbuf zero */
+			cvmx_write_csr(host->base + OCT_MIO_EMM_BUF_IDX, 0x10000ull);
+
+			for (;;) {
+				if (smi->consumed >= smi->length) {
+					if (!sg_miter_next(smi))
+						break;
+					smi->consumed = 0;
+				}
+
+				while (smi->consumed < smi->length && shift >= 0) {
+					dat |= (u64)(*(u8 *)(smi->addr)) << shift;
+					bytes_xfered++;
+					smi->addr++;
+					smi->consumed++;
+					shift -= 8;
+				}
+				if (shift < 0) {
+					cvmx_write_csr(host->base + OCT_MIO_EMM_BUF_DAT, dat);
+					shift = 56;
+					dat = 0;
+				}
+			}
+			sg_miter_stop(smi);
+			cmd->data->bytes_xfered = bytes_xfered;
+			cmd->data->error = 0;
+		}
+		if (cmd->data->timeout_ns) {
+			cvmx_write_csr(host->base + OCT_MIO_EMM_WDOG,
+				       octeon_mmc_timeout_to_wdog(slot, cmd->data->timeout_ns));
+			pr_debug("OCT_MIO_EMM_WDOG %llu\n",
+				 cvmx_read_csr(host->base + OCT_MIO_EMM_WDOG));
+		}
+	} else {
+		cvmx_write_csr(host->base + OCT_MIO_EMM_WDOG,
+			       ((u64)slot->clock * 850ull) / 1000ull);
+		pr_debug("OCT_MIO_EMM_WDOG %llu\n",
+			 cvmx_read_csr(host->base + OCT_MIO_EMM_WDOG));
+	}
+	/* Clear the bit. */
+	cvmx_write_csr(host->base + OCT_MIO_EMM_INT, emm_int.u64);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_INT_EN, emm_int.u64);
+	host->dma_active = false;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	emm_cmd.u64 = 0;
+	emm_cmd.s.cmd_val = 1;
+	emm_cmd.s.ctype_xor = mods.ctype_xor;
+	emm_cmd.s.rtype_xor = mods.rtype_xor;
+	if (mmc_cmd_type(cmd) == MMC_CMD_ADTC)
+		emm_cmd.s.offset = 64 - ((cmd->data->blksz * cmd->data->blocks) / 8);
+	emm_cmd.s.bus_id = slot->bus_id;
+	emm_cmd.s.cmd_idx = cmd->opcode;
+	emm_cmd.s.arg = cmd->arg;
+	cvmx_write_csr(host->base + OCT_MIO_EMM_STS_MASK, 0);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_CMD, emm_cmd.u64);
+	pr_debug("Send the command: %llx\n", emm_cmd.u64);
+
+}
+
+static void octeon_mmc_reset_bus(struct octeon_mmc_slot *slot, int preserve)
+{
+	union cvmx_mio_emm_cfg emm_cfg;
+	union cvmx_mio_emm_switch emm_switch;
+	u64 wdog = 0;
+
+	emm_cfg.u64 = cvmx_read_csr(slot->host->base + OCT_MIO_EMM_CFG);
+	if (preserve) {
+		emm_switch.u64 = cvmx_read_csr(slot->host->base + OCT_MIO_EMM_SWITCH);
+		wdog = cvmx_read_csr(slot->host->base + OCT_MIO_EMM_WDOG);
+	}
+
+	/* Reset the bus */
+	emm_cfg.u64 &= ~(1 << slot->bus_id);
+	cvmx_write_csr(slot->host->base + OCT_MIO_EMM_CFG, emm_cfg.u64);
+	msleep(10);  /* Wait 10ms */
+	emm_cfg.u64 |= 1 << slot->bus_id;
+	cvmx_write_csr(slot->host->base + OCT_MIO_EMM_CFG, emm_cfg.u64);
+
+	msleep(10);
+
+	/* Restore switch settings */
+	if (preserve) {
+		emm_switch.s.switch_exe = 0;
+		emm_switch.s.switch_err0 = 0;
+		emm_switch.s.switch_err1 = 0;
+		emm_switch.s.switch_err2 = 0;
+		slot->host->last_emm_switch = emm_switch.u64;
+		cvmx_write_csr(slot->host->base + OCT_MIO_EMM_SWITCH,
+			       emm_switch.u64);
+		msleep(10);
+		cvmx_write_csr(slot->host->base + OCT_MIO_EMM_WDOG, wdog);
+	} else {
+		slot->host->last_emm_switch = 0;
+	}
+}
+
+static void octeon_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct octeon_mmc_slot	*slot;
+	struct octeon_mmc_host	*host;
+	int bus_width;
+	int clock;
+	int hs_timing;
+	int power_class = 10;
+	int clk_period;
+	int timeout = 2000;
+	union cvmx_mio_emm_switch emm_switch;
+	union cvmx_mio_emm_rsp_sts emm_sts;
+
+	slot = mmc_priv(mmc);
+	host = slot->host;
+
+	/* Only a single user of the host block at a time. */
+	down(&host->mmc_serializer);
+
+	pr_debug("Calling set_ios: slot: clk = 0x%x, bus_width = %d\n",
+		 slot->clock, slot->bus_width);
+	pr_debug("Calling set_ios: ios: clk = 0x%x, vdd = %u, bus_width = %u, power_mode = %u, timing = %u\n",
+		 ios->clock, ios->vdd, ios->bus_width, ios->power_mode,
+		 ios->timing);
+	pr_debug("Calling set_ios: mmc: caps = 0x%lx, bus_width = %d\n",
+		 mmc->caps, mmc->ios.bus_width);
+
+	/*
+	 * Reset the chip on each power off
+	 */
+	if (ios->power_mode == MMC_POWER_OFF) {
+		octeon_mmc_reset_bus(slot, 1);
+		if (slot->power_gpio >= 0)
+			gpio_set_value_cansleep(slot->power_gpio,
+						slot->power_gpio_active_low ? 1 : 0);
+	} else {
+		if (slot->power_gpio >= 0)
+			gpio_set_value_cansleep(slot->power_gpio,
+						slot->power_gpio_active_low ? 0 : 1);
+	}
+
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_8:
+		bus_width = 2;
+		break;
+	case MMC_BUS_WIDTH_4:
+		bus_width = 1;
+		break;
+	case MMC_BUS_WIDTH_1:
+		bus_width = 0;
+		break;
+	default:
+		pr_debug("unknown bus width %d\n", ios->bus_width);
+		bus_width = 0;
+		break;
+	}
+	hs_timing = (ios->timing == MMC_TIMING_MMC_HS);
+	if (ios->clock) {
+		slot->clock = ios->clock;
+		slot->bus_width = bus_width;
+
+		clock = slot->clock;
+
+		if (clock > 52000000)
+			clock = 50000000;
+
+		clk_period = (octeon_get_io_clock_rate() + clock - 1) / (2 * clock);
+
+		emm_switch.u64 = 0;
+		emm_switch.s.bus_id = slot->bus_id;
+		emm_switch.s.hs_timing = hs_timing;
+		emm_switch.s.bus_width = bus_width;
+		emm_switch.s.power_class = power_class;
+		emm_switch.s.clk_hi = clk_period;
+		emm_switch.s.clk_lo = clk_period;
+
+		if (!octeon_mmc_switch_val_changed(slot, emm_switch.u64)) {
+			pr_debug("No change from 0x%llx mio_emm_switch, returning.\n",
+				 emm_switch.u64);
+			goto out;
+		}
+
+		pr_debug("Writing 0x%llx to mio_emm_wdog\n",
+			 ((u64)clock * 850ull) / 1000ull);
+		cvmx_write_csr(host->base + OCT_MIO_EMM_WDOG,
+			       ((u64)clock * 850ull) / 1000ull);
+		pr_debug("Writing 0x%llx to mio_emm_switch\n", emm_switch.u64);
+		cvmx_write_csr(host->base + OCT_MIO_EMM_SWITCH, emm_switch.u64);
+		slot->host->last_emm_switch = emm_switch.u64;
+
+		do {
+			emm_sts.u64 = cvmx_read_csr(host->base + OCT_MIO_EMM_RSP_STS);
+			if (!emm_sts.s.switch_val)
+				break;
+			udelay(100);
+		} while (timeout-- > 0);
+
+		if (timeout <= 0) {
+			pr_debug("%s: switch command timed out, status=0x%llx\n",
+				 __func__, emm_sts.u64);
+			goto out;
+		}
+	}
+out:
+	up(&host->mmc_serializer);
+}
+
+static int octeon_mmc_get_ro(struct mmc_host *mmc)
+{
+	struct octeon_mmc_slot	*slot = mmc_priv(mmc);
+
+	if (slot->ro_gpio >= 0) {
+		int pin = gpio_get_value_cansleep(slot->ro_gpio);
+		if (pin < 0)
+			return pin;
+		if (slot->ro_gpio_active_low)
+			pin = !pin;
+		return pin;
+	} else {
+		return -ENOSYS;
+	}
+}
+
+static int octeon_mmc_get_cd(struct mmc_host *mmc)
+{
+	struct octeon_mmc_slot	*slot = mmc_priv(mmc);
+
+	if (slot->cd_gpio >= 0) {
+		int pin = gpio_get_value_cansleep(slot->cd_gpio);
+		if (pin < 0)
+			return pin;
+		if (slot->cd_gpio_active_low)
+			pin = !pin;
+		return pin;
+	} else {
+		return -ENOSYS;
+	}
+}
+
+static const struct mmc_host_ops octeon_mmc_ops = {
+	.request        = octeon_mmc_request,
+	.set_ios        = octeon_mmc_set_ios,
+	.get_ro		= octeon_mmc_get_ro,
+	.get_cd		= octeon_mmc_get_cd,
+};
+
+static void octeon_mmc_set_clock(struct octeon_mmc_slot *slot,
+				 unsigned int clock)
+{
+	struct mmc_host *mmc = slot->mmc;
+	clock = min(clock, mmc->f_max);
+	clock = max(clock, mmc->f_min);
+	slot->clock = clock;
+}
+
+static int octeon_mmc_initlowlevel(struct octeon_mmc_slot *slot, int id,
+			int bus_width)
+{
+	union cvmx_mio_emm_switch emm_switch;
+	struct octeon_mmc_host *host = slot->host;
+
+	octeon_mmc_reset_bus(slot, 0);
+
+	octeon_mmc_set_clock(slot, 400000);
+
+	/* Program initial clock speed and power */
+	emm_switch.u64 = 0;
+	emm_switch.s.bus_id = id;
+	emm_switch.s.power_class = 10;
+	emm_switch.s.clk_hi = (slot->sclock / slot->clock) / 2;
+	emm_switch.s.clk_lo = (slot->sclock / slot->clock) / 2;
+	slot->host->last_emm_switch = emm_switch.u64;
+	cvmx_write_csr(host->base + OCT_MIO_EMM_SWITCH, emm_switch.u64);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_WDOG,
+		       ((u64)slot->clock * 850ull) / 1000ull);
+	cvmx_write_csr(host->base + OCT_MIO_EMM_STS_MASK, 0xe4f90080ull);
+
+	return 0;
+}
+
+static int __devinit octeon_init_slot(struct octeon_mmc_host *host, int id,
+				      int bus_width, int max_freq,
+				      int ro_gpio, int cd_gpio, int power_gpio,
+				      bool ro_low, bool cd_low, bool power_low)
+{
+	struct mmc_host *mmc;
+	struct octeon_mmc_slot *slot;
+	int ret;
+
+	/*
+	 * Allocate MMC structue
+	 */
+	mmc = mmc_alloc_host(sizeof(struct octeon_mmc_slot), &host->pdev->dev);
+	if (!mmc) {
+		pr_debug("alloc host failed\n");
+		return -ENOMEM;
+	}
+
+	slot = mmc_priv(mmc);
+	slot->mmc = mmc;
+	slot->host = host;
+	slot->ro_gpio = ro_gpio;
+	slot->cd_gpio = cd_gpio;
+	slot->power_gpio = power_gpio;
+	slot->ro_gpio_active_low = ro_low;
+	slot->cd_gpio_active_low = cd_low;
+	slot->power_gpio_active_low = power_low;
+
+	if (slot->ro_gpio >= 0)
+		gpio_direction_input(slot->ro_gpio);
+	if (slot->cd_gpio >= 0)
+		gpio_direction_input(slot->cd_gpio);
+	if (slot->power_gpio >= 0)
+		gpio_direction_output(slot->power_gpio,
+				      slot->power_gpio_active_low ? 1 : 0);
+
+	/*
+	 * Set up host parameters.
+	 */
+	mmc->ops = &octeon_mmc_ops;
+	mmc->f_min = 400000;
+	mmc->f_max = max_freq;
+	mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+		    MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
+		    MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
+			 MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
+			 MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
+
+	mmc->max_segs = 64;
+	mmc->max_seg_size = (1 << 23) - 8;
+	mmc->max_req_size = mmc->max_seg_size;
+	mmc->max_blk_size = 512;
+	mmc->max_blk_count = mmc->max_req_size / 512;
+
+
+	slot->clock = mmc->f_min;
+	slot->sclock = octeon_get_io_clock_rate();
+
+	slot->bus_width = bus_width;
+	slot->bus_id = id;
+
+	/* Initialize MMC Block. */
+	octeon_mmc_initlowlevel(slot, id, bus_width);
+
+	host->slot[id] = slot;
+	ret = mmc_add_host(mmc);
+	pr_debug("mmc_add_host returned %d\n", ret);
+
+	return 0;
+}
+
+static int __devinit octeon_mmc_probe(struct platform_device *pdev)
+{
+	union cvmx_mio_emm_cfg emm_cfg;
+	struct octeon_mmc_host *host;
+	struct resource	*res;
+	int mmc_irq, dma_irq;
+	int ret = 0;
+	struct device_node *node;
+	int found = 0;
+
+	mmc_irq = platform_get_irq(pdev, 0);
+	if (mmc_irq < 0)
+		return mmc_irq;
+
+	dma_irq = platform_get_irq(pdev, 1);
+	if (dma_irq < 0)
+		return dma_irq;
+
+	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	if (!host) {
+		dev_err(&pdev->dev, "devm_kzalloc failed\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	host->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource is missing\n");
+		ret = -ENXIO;
+		goto err;
+	}
+	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
+				     res->name)) {
+		dev_err(&pdev->dev, "request_mem_region 0 failed\n");
+		goto err;
+	}
+
+	host->base = (u64)devm_ioremap(&pdev->dev, res->start,
+				       resource_size(res));
+	if (!host->base) {
+		dev_err(&pdev->dev, "Platform resource0 is missing\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource1 is missing\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
+				     res->name)) {
+		dev_err(&pdev->dev, "request_mem_region 1 failed\n");
+		goto err;
+	}
+	host->ndf_base = (u64)devm_ioremap(&pdev->dev, res->start,
+					   resource_size(res));
+	if (!host->ndf_base) {
+		dev_err(&pdev->dev, "Platform resource0 is missing\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, mmc_irq, octeon_mmc_interrupt,
+			       0, DRV_NAME, host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error: devm_request_irq %d\n", mmc_irq);
+		goto err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, dma_irq, octeon_mmc_dma_interrupt,
+			       IRQF_SHARED, DRV_NAME, host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error: devm_request_irq %d\n", dma_irq);
+		goto err;
+	}
+
+
+	spin_lock_init(&host->lock);
+	sema_init(&host->mmc_serializer, 1);
+
+	platform_set_drvdata(pdev, host);
+
+	node = of_get_next_child(pdev->dev.of_node, NULL);
+	while (node) {
+		int size;
+		const __be32 *data;
+		found = 0;
+
+		data = of_get_property(node, "reg", &size);
+		if (data) {
+			enum of_gpio_flags f;
+			int ro_gpio, cd_gpio, power_gpio;
+			bool ro_low, cd_low, power_low;
+			int bus_width, max_freq;
+			int slot = be32_to_cpu(*data);
+			data = of_get_property(node,
+					       "cavium,bus-max-width",
+					       &size);
+			if (!data || size != 4) {
+				pr_info("Bus width not found for slot %d\n",
+					slot);
+				bus_width = 8;
+			} else {
+				bus_width = be32_to_cpup(data);
+				switch (bus_width) {
+				case 1:
+				case 4:
+				case 8:
+					break;
+				default:
+					bus_width = 8;
+					break;
+				}
+			}
+			data = of_get_property(node,
+					       "spi-max-frequency",
+					       &size);
+			if (!data || size != 4) {
+				max_freq = 52000000;
+				pr_info("no spi-max-frequency for slot %d, defautling to %d\n",
+					slot, max_freq);
+			} else {
+				max_freq = be32_to_cpup(data);
+			}
+
+			ro_gpio = of_get_named_gpio_flags(node, "wp-gpios", 0, &f);
+			ro_low = (ro_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
+			cd_gpio = of_get_named_gpio_flags(node, "cd-gpios", 0, &f);
+			cd_low = (cd_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
+			power_gpio = of_get_named_gpio_flags(node, "power-gpios", 0, &f);
+			power_low = (power_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
+
+			ret = octeon_init_slot(host, slot, bus_width, max_freq,
+					       ro_gpio, cd_gpio, power_gpio,
+					       ro_low, cd_low, power_low);
+			pr_debug("init slot %d, ret = %d\n", slot, ret);
+			if (ret)
+				goto err;
+		}
+		node = of_get_next_child(pdev->dev.of_node, node);
+	}
+
+	return ret;
+
+err:
+	/* Disable MMC controller */
+	emm_cfg.s.bus_ena = 0;
+	cvmx_write_csr(host->base + OCT_MIO_EMM_CFG, emm_cfg.u64);
+	return ret;
+}
+
+static int __devexit octeon_mmc_remove(struct platform_device *pdev)
+{
+	union cvmx_mio_ndf_dma_int ndf_dma_int;
+	union cvmx_mio_ndf_dma_cfg ndf_dma_cfg;
+	struct octeon_mmc_host *host = platform_get_drvdata(pdev);
+
+	if (host) {
+		/* Reset bus_id */
+		ndf_dma_cfg.u64 = cvmx_read_csr(host->ndf_base + OCT_MIO_NDF_DMA_CFG);
+		ndf_dma_cfg.s.en = 0;
+		cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_CFG,
+			       ndf_dma_cfg.u64);
+
+		/* Disable the interrupt */
+		ndf_dma_int.u64 = 0;
+		cvmx_write_csr(host->ndf_base + OCT_MIO_NDF_DMA_INT,
+			       ndf_dma_int.u64);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct of_device_id octeon_mmc_match[] = {
+	{
+		.compatible = "cavium,octeon-6130-mmc",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_mmc_match);
+
+static struct platform_driver octeon_mmc_driver = {
+	.probe		= octeon_mmc_probe,
+	.remove		= __devexit_p(octeon_mmc_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = octeon_mmc_match,
+	},
+};
+
+static int __init octeon_mmc_init(void)
+{
+	int ret;
+
+	pr_debug("calling octeon_mmc_init\n");
+
+	ret = platform_driver_register(&octeon_mmc_driver);
+	pr_debug("driver probe returned %d\n", ret);
+
+	if (ret)
+		pr_err("%s: Failed to register driver\n", DRV_NAME);
+
+	return ret;
+}
+
+static void __exit octeon_mmc_cleanup(void)
+{
+	/* Unregister MMC driver */
+	platform_driver_unregister(&octeon_mmc_driver);
+}
+
+module_init(octeon_mmc_init);
+module_exit(octeon_mmc_cleanup);
+
+MODULE_AUTHOR("Cavium Inc. <support@caviumn.com>");
+MODULE_DESCRIPTION("low-level driver for Cavium OCTEON MMC/SSD card");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
-- 
1.7.2.3
