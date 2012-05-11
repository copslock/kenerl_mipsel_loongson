Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 23:35:29 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:60540 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2EKVe6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 23:34:58 +0200
Received: by dadm1 with SMTP id m1so4112392dad.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=647PPkRHiAJsBOL0w7X4KYtnr88uXbspeufzy9r5Eew=;
        b=Lyye81oqOrh0FB9hxLoFYS0HjXd4hLUJKqW8wfLUKVyLNdNNjdq7AzwQCKl0pAJD1j
         E47121VY/L8QYSrSpz3uM5wSVamUuWRePm3JZFDEwhip9aRqFJ0jKK+zOTqa1DOCAsvL
         dqRLe/UJCEkXEsl7evyQsp9cU+OrptuoYwivYZStJAvUwRco4kySdD+tEs9dIniz8vgH
         u1ykOdPWZ2bHbak3qL3Pdebz/pnqNTgwBzkIZ6eLjMPox3Fx+P5YAVk+pqc/l0YZEgwO
         kjHaGb9RkBIsFI3TpSfyh2lGxP23OV2v1Qf9g4Z+rjWHwrSXGXe+6dDIahM/NY1JHfax
         jlhA==
Received: by 10.68.221.74 with SMTP id qc10mr35072506pbc.80.1336772092116;
        Fri, 11 May 2012 14:34:52 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ka5sm13880556pbb.37.2012.05.11.14.34.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 14:34:51 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BLYnmB017290;
        Fri, 11 May 2012 14:34:49 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BLYnFb017289;
        Fri, 11 May 2012 14:34:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
Date:   Fri, 11 May 2012 14:34:46 -0700
Message-Id: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Add the driver, link it into the kbuild system and provide device tree
binding documentation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/spi/spi-octeon.txt         |   33 ++
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-octeon.c                           |  369 ++++++++++++++++++++
 4 files changed, 410 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
 create mode 100644 drivers/spi/spi-octeon.c

diff --git a/Documentation/devicetree/bindings/spi/spi-octeon.txt b/Documentation/devicetree/bindings/spi/spi-octeon.txt
new file mode 100644
index 0000000..431add1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-octeon.txt
@@ -0,0 +1,33 @@
+Cavium, Inc. OCTEON SOC SPI master controller.
+
+Required properties:
+- compatible : "cavium,octeon-3010-spi"
+- reg : The register base for the controller.
+- interrupts : One interrupt, used by the controller.
+- #address-cells : <1>, as required by generic SPI binding.
+- #size-cells : <0>, also as required by generic SPI binding.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+	spi@1070000001000 {
+		compatible = "cavium,octeon-3010-spi";
+		reg = <0x10700 0x00001000 0x0 0x100>;
+		interrupts = <0 58>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eeprom@0 {
+			compatible = "st,m95256", "atmel,at25";
+			reg = <0>;
+			spi-max-frequency = <5000000>;
+			spi-cpha;
+			spi-cpol;
+
+			pagesize = <64>;
+			size = <32768>;
+			address-width = <16>;
+		};
+	};
+
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 00c0240..e1dd0d0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -228,6 +228,13 @@ config SPI_OC_TINY
 	help
 	  This is the driver for OpenCores tiny SPI master controller.
 
+config SPI_OCTEON
+	tristate "Cavium OCTEON SPI controller"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  SPI host driver for the hardware found on some Cavium OCTEON
+	  SOCs.
+
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
 	depends on ARCH_OMAP1
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9d75d21..c7f8b71 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
+obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
 obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
new file mode 100644
index 0000000..7207aaf
--- /dev/null
+++ b/drivers/spi/spi-octeon.c
@@ -0,0 +1,369 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/of_spi.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-mpi-defs.h>
+
+#define DRV_VERSION "2.0" /* Version 1 was the out-of-tree driver */
+#define DRV_DESCRIPTION "Cavium, Inc. OCTEON SPI bus driver"
+
+
+#define OCTEON_SPI_CFG 0
+#define OCTEON_SPI_STS 0x08
+#define OCTEON_SPI_TX 0x10
+#define OCTEON_SPI_DAT0 0x80
+
+#define OCTEON_SPI_MAX_BYTES 9
+
+#define OCTEON_SPI_MAX_CLOCK_HZ 16000000
+
+struct octeon_spi {
+	struct spi_master *my_master;
+	u64 register_base;
+	u64 last_cfg;
+	u64 cs_enax;
+};
+
+struct octeon_spi_setup {
+	u32 max_speed_hz;
+	u8 chip_select;
+	u8 mode;
+	u8 bits_per_word;
+};
+
+static void octeon_spi_wait_ready(struct octeon_spi *p)
+{
+	union cvmx_mpi_sts mpi_sts;
+	unsigned int loops = 0;
+
+	do {
+		if (loops++)
+			__delay(500);
+		mpi_sts.u64 = cvmx_read_csr(p->register_base + OCTEON_SPI_STS);
+	} while (mpi_sts.s.busy);
+}
+
+static int octeon_spi_do_transfer(struct octeon_spi *p,
+				  struct spi_message *msg,
+				  struct spi_transfer *xfer,
+				  bool last_xfer)
+{
+	union cvmx_mpi_cfg mpi_cfg;
+	union cvmx_mpi_tx mpi_tx;
+	unsigned int clkdiv;
+	unsigned int speed_hz;
+	int mode;
+	bool cpha, cpol;
+	int bits_per_word;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	int len;
+	int i;
+
+	struct octeon_spi_setup *msg_setup = spi_get_ctldata(msg->spi);
+
+	speed_hz = msg_setup->max_speed_hz;
+	mode = msg_setup->mode;
+	cpha = mode & SPI_CPHA;
+	cpol = mode & SPI_CPOL;
+	bits_per_word = msg_setup->bits_per_word;
+
+	if (xfer->speed_hz)
+		speed_hz = xfer->speed_hz;
+	if (xfer->bits_per_word)
+		bits_per_word = xfer->bits_per_word;
+
+	if (speed_hz > OCTEON_SPI_MAX_CLOCK_HZ)
+		speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
+
+	clkdiv = octeon_get_io_clock_rate() / (2 * speed_hz);
+
+	mpi_cfg.u64 = 0;
+
+	mpi_cfg.s.clkdiv = clkdiv;
+	mpi_cfg.s.cshi = (mode & SPI_CS_HIGH) ? 1 : 0;
+	mpi_cfg.s.lsbfirst = (mode & SPI_LSB_FIRST) ? 1 : 0;
+	mpi_cfg.s.wireor = (mode & SPI_3WIRE) ? 1 : 0;
+	mpi_cfg.s.idlelo = cpha != cpol;
+	mpi_cfg.s.cslate = cpha ? 1 : 0;
+	mpi_cfg.s.enable = 1;
+
+	if (msg_setup->chip_select < 4)
+		p->cs_enax |= 1ull << (12 + msg_setup->chip_select);
+	mpi_cfg.u64 |= p->cs_enax;
+
+	if (mpi_cfg.u64 != p->last_cfg) {
+		p->last_cfg = mpi_cfg.u64;
+		cvmx_write_csr(p->register_base + OCTEON_SPI_CFG, mpi_cfg.u64);
+	}
+	tx_buf = xfer->tx_buf;
+	rx_buf = xfer->rx_buf;
+	len = xfer->len;
+	while (len > OCTEON_SPI_MAX_BYTES) {
+		for (i = 0; i < OCTEON_SPI_MAX_BYTES; i++) {
+			u8 d;
+			if (tx_buf)
+				d = *tx_buf++;
+			else
+				d = 0;
+			cvmx_write_csr(p->register_base + OCTEON_SPI_DAT0 + (8 * i), d);
+		}
+		mpi_tx.u64 = 0;
+		mpi_tx.s.csid = msg_setup->chip_select;
+		mpi_tx.s.leavecs = 1;
+		mpi_tx.s.txnum = tx_buf ? OCTEON_SPI_MAX_BYTES : 0;
+		mpi_tx.s.totnum = OCTEON_SPI_MAX_BYTES;
+		cvmx_write_csr(p->register_base + OCTEON_SPI_TX, mpi_tx.u64);
+
+		octeon_spi_wait_ready(p);
+		if (rx_buf)
+			for (i = 0; i < OCTEON_SPI_MAX_BYTES; i++) {
+				u64 v = cvmx_read_csr(p->register_base + OCTEON_SPI_DAT0 + (8 * i));
+				*rx_buf++ = (u8)v;
+			}
+		len -= OCTEON_SPI_MAX_BYTES;
+	}
+
+	for (i = 0; i < len; i++) {
+		u8 d;
+		if (tx_buf)
+			d = *tx_buf++;
+		else
+			d = 0;
+		cvmx_write_csr(p->register_base + OCTEON_SPI_DAT0 + (8 * i), d);
+	}
+
+	mpi_tx.u64 = 0;
+	mpi_tx.s.csid = msg_setup->chip_select;
+	if (last_xfer)
+		mpi_tx.s.leavecs = xfer->cs_change;
+	else
+		mpi_tx.s.leavecs = !xfer->cs_change;
+	mpi_tx.s.txnum = tx_buf ? len : 0;
+	mpi_tx.s.totnum = len;
+	cvmx_write_csr(p->register_base + OCTEON_SPI_TX, mpi_tx.u64);
+
+	octeon_spi_wait_ready(p);
+	if (rx_buf)
+		for (i = 0; i < len; i++) {
+			u64 v = cvmx_read_csr(p->register_base + OCTEON_SPI_DAT0 + (8 * i));
+			*rx_buf++ = (u8)v;
+		}
+
+	if (xfer->delay_usecs)
+		udelay(xfer->delay_usecs);
+
+	return xfer->len;
+}
+
+static int octeon_spi_validate_bpw(struct spi_device *spi, u32 speed)
+{
+	switch (speed) {
+	case 8:
+		break;
+	default:
+		dev_err(&spi->dev, "Error: %d bits per word not supported\n",
+			speed);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int octeon_spi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *msg)
+{
+	struct octeon_spi *p = spi_master_get_devdata(master);
+	unsigned int total_len = 0;
+	int status = 0;
+	struct spi_transfer *xfer;
+
+	/*
+	 * We better have set the configuration via a call to .setup
+	 * before we get here.
+	 */
+	if (spi_get_ctldata(msg->spi) == NULL) {
+		status = -EINVAL;
+		goto err;
+	}
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->bits_per_word) {
+			status = octeon_spi_validate_bpw(msg->spi,
+							 xfer->bits_per_word);
+			if (status)
+				goto err;
+		}
+	}
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		bool last_xfer = &xfer->transfer_list == msg->transfers.prev;
+		int r = octeon_spi_do_transfer(p, msg, xfer, last_xfer);
+		if (r < 0) {
+			status = r;
+			goto err;
+		}
+		total_len += r;
+	}
+err:
+	msg->status = status;
+	msg->actual_length = total_len;
+	spi_finalize_current_message(master);
+	return status;
+}
+
+static struct octeon_spi_setup *octeon_spi_new_setup(struct spi_device *spi)
+{
+	struct octeon_spi_setup *setup = kzalloc(sizeof(*setup), GFP_KERNEL);
+	if (!setup)
+		return NULL;
+
+	setup->max_speed_hz = spi->max_speed_hz;
+	setup->chip_select = spi->chip_select;
+	setup->mode = spi->mode;
+	setup->bits_per_word = spi->bits_per_word;
+	return setup;
+}
+
+static int octeon_spi_setup(struct spi_device *spi)
+{
+	int r;
+	struct octeon_spi_setup *new_setup;
+	struct octeon_spi_setup *old_setup = spi_get_ctldata(spi);
+
+	r = octeon_spi_validate_bpw(spi, spi->bits_per_word);
+	if (r)
+		return r;
+
+	new_setup = octeon_spi_new_setup(spi);
+	if (!new_setup)
+		return -ENOMEM;
+
+	spi_set_ctldata(spi, new_setup);
+	kfree(old_setup);
+
+	return 0;
+}
+
+static void octeon_spi_cleanup(struct spi_device *spi)
+{
+	struct octeon_spi_setup *old_setup = spi_get_ctldata(spi);
+	spi_set_ctldata(spi, NULL);
+	kfree(old_setup);
+}
+
+static int octeon_spi_nop_transfer_hardware(struct spi_master *master)
+{
+	return 0;
+}
+
+static int __devinit octeon_spi_probe(struct platform_device *pdev)
+{
+
+	struct resource *res_mem;
+	struct spi_master *master;
+	struct octeon_spi *p;
+	int err = -ENOENT;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct octeon_spi));
+	if (!master)
+		return -ENOMEM;
+	p = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, p);
+	p->my_master = master;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "found no memory resource\n");
+		err = -ENXIO;
+		goto fail;
+	}
+	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
+				     resource_size(res_mem), res_mem->name)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		goto fail;
+	}
+	p->register_base = (u64)devm_ioremap(&pdev->dev, res_mem->start,
+					     resource_size(res_mem));
+
+	/* Dynamic bus numbering */
+	master->bus_num = -1;
+	master->num_chipselect = 4;
+	master->mode_bits = SPI_CPHA |
+			    SPI_CPOL |
+			    SPI_CS_HIGH |
+			    SPI_LSB_FIRST |
+			    SPI_3WIRE;
+
+	master->setup = octeon_spi_setup;
+	master->cleanup = octeon_spi_cleanup;
+	master->prepare_transfer_hardware = octeon_spi_nop_transfer_hardware;
+	master->transfer_one_message = octeon_spi_transfer_one_message;
+	master->unprepare_transfer_hardware = octeon_spi_nop_transfer_hardware;
+
+	master->dev.of_node = pdev->dev.of_node;
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(&pdev->dev, "register master failed: %d\n", err);
+		goto fail;
+	}
+
+	dev_info(&pdev->dev, "Version " DRV_VERSION "\n");
+
+	return 0;
+fail:
+	spi_master_put(master);
+	return err;
+}
+
+static int __devexit octeon_spi_remove(struct platform_device *pdev)
+{
+	struct octeon_spi *p = platform_get_drvdata(pdev);
+	struct spi_master *master = p->my_master;
+
+	spi_unregister_master(master);
+
+	/* Clear the CSENA* and put everything in a known state. */
+	cvmx_write_csr(p->register_base + OCTEON_SPI_CFG, 0);
+	spi_master_put(master);
+	return 0;
+}
+
+static struct of_device_id octeon_spi_match[] = {
+	{
+		.compatible = "cavium,octeon-3010-spi",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_spi_match);
+
+static struct platform_driver octeon_spi_driver = {
+	.driver = {
+		.name		= "spi-octeon",
+		.owner		= THIS_MODULE,
+		.of_match_table = octeon_spi_match,
+	},
+	.probe		= octeon_spi_probe,
+	.remove		= __exit_p(octeon_spi_remove),
+};
+
+module_platform_driver(octeon_spi_driver);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
-- 
1.7.2.3
