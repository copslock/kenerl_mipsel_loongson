Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 14:12:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51447 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024580AbZESNMX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 May 2009 14:12:23 +0100
Received: from localhost.localdomain (p4136-ipad203funabasi.chiba.ocn.ne.jp [222.146.83.136])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3591DABC4; Tue, 19 May 2009 22:12:16 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add TXx9 AC link controller driver (v3)
Date:	Tue, 19 May 2009 22:12:15 +0900
Message-Id: <1242738735-8408-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch adds support for the integrated ACLC of the TXx9 family.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Changes since v2:
* register DAI driver as a platform driver
* use platform device to obtain irq/mem/dma resources.

 sound/soc/Kconfig                 |    1 +
 sound/soc/Makefile                |    1 +
 sound/soc/txx9/Kconfig            |   29 +++
 sound/soc/txx9/Makefile           |   11 +
 sound/soc/txx9/txx9aclc-ac97.c    |  255 ++++++++++++++++++++++
 sound/soc/txx9/txx9aclc-generic.c |   98 +++++++++
 sound/soc/txx9/txx9aclc.c         |  430 +++++++++++++++++++++++++++++++++++++
 sound/soc/txx9/txx9aclc.h         |   83 +++++++
 8 files changed, 908 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/txx9/Kconfig
 create mode 100644 sound/soc/txx9/Makefile
 create mode 100644 sound/soc/txx9/txx9aclc-ac97.c
 create mode 100644 sound/soc/txx9/txx9aclc-generic.c
 create mode 100644 sound/soc/txx9/txx9aclc.c
 create mode 100644 sound/soc/txx9/txx9aclc.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 3d2bb6f..85e985a 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -33,6 +33,7 @@ source "sound/soc/omap/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/txx9/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 0237879..6039b0d 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SND_SOC)	+= omap/
 obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= s3c24xx/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/txx9/Kconfig b/sound/soc/txx9/Kconfig
new file mode 100644
index 0000000..ebc9327
--- /dev/null
+++ b/sound/soc/txx9/Kconfig
@@ -0,0 +1,29 @@
+##
+## TXx9 ACLC
+##
+config SND_SOC_TXX9ACLC
+	tristate "SoC Audio for TXx9"
+	depends on HAS_TXX9_ACLC && TXX9_DMAC
+	help
+	  This option enables support for the AC Link Controllers in TXx9 SoC.
+
+config HAS_TXX9_ACLC
+	bool
+
+config SND_SOC_TXX9ACLC_AC97
+	tristate
+	select AC97_BUS
+	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
+
+
+##
+## Boards
+##
+config SND_SOC_TXX9ACLC_GENERIC
+	tristate "Generic TXx9 ACLC sound machine"
+	depends on SND_SOC_TXX9ACLC
+	select SND_SOC_TXX9ACLC_AC97
+	select SND_SOC_AC97_CODEC
+	help
+	  This is a generic AC97 sound machine for use in TXx9 based systems.
diff --git a/sound/soc/txx9/Makefile b/sound/soc/txx9/Makefile
new file mode 100644
index 0000000..551f16c
--- /dev/null
+++ b/sound/soc/txx9/Makefile
@@ -0,0 +1,11 @@
+# Platform
+snd-soc-txx9aclc-objs := txx9aclc.o
+snd-soc-txx9aclc-ac97-objs := txx9aclc-ac97.o
+
+obj-$(CONFIG_SND_SOC_TXX9ACLC) += snd-soc-txx9aclc.o
+obj-$(CONFIG_SND_SOC_TXX9ACLC_AC97) += snd-soc-txx9aclc-ac97.o
+
+# Machine
+snd-soc-txx9aclc-generic-objs := txx9aclc-generic.o
+
+obj-$(CONFIG_SND_SOC_TXX9ACLC_GENERIC) += snd-soc-txx9aclc-generic.o
diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
new file mode 100644
index 0000000..0f83bdb
--- /dev/null
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -0,0 +1,255 @@
+/*
+ * TXx9 ACLC AC97 driver
+ *
+ * Copyright (C) 2009 Atsushi Nemoto
+ *
+ * Based on RBTX49xx patch from CELF patch archive.
+ * (C) Copyright TOSHIBA CORPORATION 2004-2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include "txx9aclc.h"
+
+#define AC97_DIR	\
+	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
+
+#define AC97_RATES	\
+	SNDRV_PCM_RATE_8000_48000
+
+#ifdef __BIG_ENDIAN
+#define AC97_FMTS	SNDRV_PCM_FMTBIT_S16_BE
+#else
+#define AC97_FMTS	SNDRV_PCM_FMTBIT_S16_LE
+#endif
+
+static DECLARE_WAIT_QUEUE_HEAD(ac97_waitq);
+
+/* REVISIT: How to find txx9aclc_soc_device from snd_ac97? */
+static struct txx9aclc_soc_device *txx9aclc_soc_dev;
+
+static int txx9aclc_regready(struct txx9aclc_soc_device *dev)
+{
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+
+	return __raw_readl(drvdata->base + ACINTSTS) & ACINT_REGACCRDY;
+}
+
+/* AC97 controller reads codec register */
+static unsigned short txx9aclc_ac97_read(struct snd_ac97 *ac97,
+					 unsigned short reg)
+{
+	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	void __iomem *base = drvdata->base;
+	u32 dat;
+
+	if (!(__raw_readl(base + ACINTSTS) & ACINT_CODECRDY(ac97->num)))
+		return 0xffff;
+	reg |= ac97->num << 7;
+	dat = (reg << ACREGACC_REG_SHIFT) | ACREGACC_READ;
+	__raw_writel(dat, base + ACREGACC);
+	__raw_writel(ACINT_REGACCRDY, base + ACINTEN);
+	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(dev), HZ)) {
+		__raw_writel(ACINT_REGACCRDY, base + ACINTDIS);
+		dev_err(dev->soc_dev.dev, "ac97 read timeout (reg %#x)\n", reg);
+		dat = 0xffff;
+		goto done;
+	}
+	dat = __raw_readl(base + ACREGACC);
+	if (((dat >> ACREGACC_REG_SHIFT) & 0xff) != reg) {
+		dev_err(dev->soc_dev.dev, "reg mismatch %x with %x\n",
+			dat, reg);
+		dat = 0xffff;
+		goto done;
+	}
+	dat = (dat >> ACREGACC_DAT_SHIFT) & 0xffff;
+done:
+	__raw_writel(ACINT_REGACCRDY, base + ACINTDIS);
+	return dat;
+}
+
+/* AC97 controller writes to codec register */
+static void txx9aclc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+				unsigned short val)
+{
+	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	void __iomem *base = drvdata->base;
+
+	__raw_writel(((reg | (ac97->num << 7)) << ACREGACC_REG_SHIFT) |
+		     (val << ACREGACC_DAT_SHIFT),
+		     base + ACREGACC);
+	__raw_writel(ACINT_REGACCRDY, base + ACINTEN);
+	if (!wait_event_timeout(ac97_waitq, txx9aclc_regready(dev), HZ)) {
+		dev_err(dev->soc_dev.dev,
+			"ac97 write timeout (reg %#x)\n", reg);
+	}
+	__raw_writel(ACINT_REGACCRDY, base + ACINTDIS);
+}
+
+static void txx9aclc_ac97_cold_reset(struct snd_ac97 *ac97)
+{
+	struct txx9aclc_soc_device *dev = txx9aclc_soc_dev;
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	void __iomem *base = drvdata->base;
+	u32 ready = ACINT_CODECRDY(ac97->num) | ACINT_REGACCRDY;
+
+	__raw_writel(ACCTL_ENLINK, base + ACCTLDIS);
+	mmiowb();
+	udelay(1);
+	__raw_writel(ACCTL_ENLINK, base + ACCTLEN);
+	/* wait for primary codec ready status */
+	__raw_writel(ready, base + ACINTEN);
+	if (!wait_event_timeout(ac97_waitq,
+				(__raw_readl(base + ACINTSTS) & ready) == ready,
+				HZ)) {
+		dev_err(&ac97->dev, "primary codec is not ready "
+			"(status %#x)\n",
+			__raw_readl(base + ACINTSTS));
+	}
+	__raw_writel(ACINT_REGACCRDY, base + ACINTSTS);
+	__raw_writel(ready, base + ACINTDIS);
+}
+
+/* AC97 controller operations */
+struct snd_ac97_bus_ops soc_ac97_ops = {
+	.read		= txx9aclc_ac97_read,
+	.write		= txx9aclc_ac97_write,
+	.reset		= txx9aclc_ac97_cold_reset,
+};
+EXPORT_SYMBOL_GPL(soc_ac97_ops);
+
+static irqreturn_t txx9aclc_ac97_irq(int irq, void *dev_id)
+{
+	struct txx9aclc_plat_drvdata *drvdata = dev_id;
+	void __iomem *base = drvdata->base;
+
+	__raw_writel(__raw_readl(base + ACINTMSTS), base + ACINTDIS);
+	wake_up(&ac97_waitq);
+	return IRQ_HANDLED;
+}
+
+static int txx9aclc_ac97_probe(struct platform_device *pdev,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct txx9aclc_soc_device *dev =
+		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
+
+	dev->aclc_pdev = to_platform_device(dai->dev);
+	txx9aclc_soc_dev = dev;
+	return 0;
+}
+
+static void txx9aclc_ac97_remove(struct platform_device *pdev,
+				 struct snd_soc_dai *dai)
+{
+	struct platform_device *aclc_pdev = to_platform_device(dai->dev);
+	struct txx9aclc_plat_drvdata *drvdata = platform_get_drvdata(aclc_pdev);
+
+	/* disable AC-link */
+	__raw_writel(ACCTL_ENLINK, drvdata->base + ACCTLDIS);
+	txx9aclc_soc_dev = NULL;
+}
+
+struct snd_soc_dai txx9aclc_ac97_dai = {
+	.name			= "txx9aclc_ac97",
+	.ac97_control		= 1,
+	.probe			= txx9aclc_ac97_probe,
+	.remove			= txx9aclc_ac97_remove,
+	.playback = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+	.capture = {
+		.rates		= AC97_RATES,
+		.formats	= AC97_FMTS,
+		.channels_min	= 2,
+		.channels_max	= 2,
+	},
+};
+EXPORT_SYMBOL_GPL(txx9aclc_ac97_dai);
+
+static int __devinit txx9aclc_ac97_dev_probe(struct platform_device *pdev)
+{
+	struct txx9aclc_plat_drvdata *drvdata;
+	struct resource *r;
+	int err;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -EBUSY;
+
+	if (!devm_request_mem_region(&pdev->dev, r->start, resource_size(r),
+				     dev_name(&pdev->dev)))
+		return -EBUSY;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, drvdata);
+	drvdata->physbase = r->start;
+	if (sizeof(drvdata->physbase) > sizeof(r->start) &&
+	    r->start >= TXX9_DIRECTMAP_BASE &&
+	    r->start < TXX9_DIRECTMAP_BASE + 0x400000)
+		drvdata->physbase |= 0xf00000000ull;
+	drvdata->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
+	if (!drvdata->base)
+		return -EBUSY;
+	err = devm_request_irq(&pdev->dev, irq, txx9aclc_ac97_irq,
+			       IRQF_DISABLED, dev_name(&pdev->dev), drvdata);
+	if (err < 0)
+		return err;
+
+	txx9aclc_ac97_dai.dev = &pdev->dev;
+	return snd_soc_register_dai(&txx9aclc_ac97_dai);
+}
+
+static int __devexit txx9aclc_ac97_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&txx9aclc_ac97_dai);
+	return 0;
+}
+
+static struct platform_driver txx9aclc_ac97_driver = {
+	.probe		= txx9aclc_ac97_dev_probe,
+	.remove		= __devexit_p(txx9aclc_ac97_dev_remove),
+	.driver		= {
+		.name	= "txx9aclc-ac97",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init txx9aclc_ac97_init(void)
+{
+	return platform_driver_register(&txx9aclc_ac97_driver);
+}
+
+static void __exit txx9aclc_ac97_exit(void)
+{
+	platform_driver_unregister(&txx9aclc_ac97_driver);
+}
+
+module_init(txx9aclc_ac97_init);
+module_exit(txx9aclc_ac97_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("TXx9 ACLC AC97 driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/txx9/txx9aclc-generic.c b/sound/soc/txx9/txx9aclc-generic.c
new file mode 100644
index 0000000..3175de9
--- /dev/null
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -0,0 +1,98 @@
+/*
+ * Generic TXx9 ACLC machine driver
+ *
+ * Copyright (C) 2009 Atsushi Nemoto
+ *
+ * Based on RBTX49xx patch from CELF patch archive.
+ * (C) Copyright TOSHIBA CORPORATION 2004-2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This is a very generic AC97 sound machine driver for boards which
+ * have (AC97) audio at ACLC (e.g. RBTX49XX boards).
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include "../codecs/ac97.h"
+#include "txx9aclc.h"
+
+static struct snd_soc_dai_link txx9aclc_generic_dai = {
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &txx9aclc_ac97_dai,
+	.codec_dai = &ac97_dai,
+};
+
+static struct snd_soc_card txx9aclc_generic_card = {
+	.name		= "Generic TXx9 ACLC Audio",
+	.platform	= &txx9aclc_soc_platform,
+	.dai_link	= &txx9aclc_generic_dai,
+	.num_links	= 1,
+};
+
+static struct txx9aclc_soc_device txx9aclc_generic_soc_device = {
+	.soc_dev = {
+		.card		= &txx9aclc_generic_card,
+		.codec_dev	= &soc_codec_dev_ac97,
+	},
+};
+
+static int __init txx9aclc_generic_probe(struct platform_device *pdev)
+{
+	struct txx9aclc_soc_device *dev = &txx9aclc_generic_soc_device;
+	struct platform_device *soc_pdev;
+	int ret;
+
+	soc_pdev = platform_device_alloc("soc-audio", -1);
+	if (!soc_pdev)
+		return -ENOMEM;
+	platform_set_drvdata(soc_pdev, &dev->soc_dev);
+	dev->soc_dev.dev = &soc_pdev->dev;
+	ret = platform_device_add(soc_pdev);
+	if (ret) {
+		platform_device_put(soc_pdev);
+		return ret;
+	}
+	platform_set_drvdata(pdev, soc_pdev);
+	return 0;
+}
+
+static int __exit txx9aclc_generic_remove(struct platform_device *pdev)
+{
+	struct platform_device *soc_pdev = platform_get_drvdata(pdev);
+
+	platform_device_unregister(soc_pdev);
+	return 0;
+}
+
+static struct platform_driver txx9aclc_generic_driver = {
+	.remove = txx9aclc_generic_remove,
+	.driver = {
+		.name = "txx9aclc-generic",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init txx9aclc_generic_init(void)
+{
+	return platform_driver_probe(&txx9aclc_generic_driver,
+				     txx9aclc_generic_probe);
+}
+
+static void __exit txx9aclc_generic_exit(void)
+{
+	platform_driver_unregister(&txx9aclc_generic_driver);
+}
+
+module_init(txx9aclc_generic_init);
+module_exit(txx9aclc_generic_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("Generic TXx9 ACLC ALSA SoC audio driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
new file mode 100644
index 0000000..fa33661
--- /dev/null
+++ b/sound/soc/txx9/txx9aclc.c
@@ -0,0 +1,430 @@
+/*
+ * Generic TXx9 ACLC platform driver
+ *
+ * Copyright (C) 2009 Atsushi Nemoto
+ *
+ * Based on RBTX49xx patch from CELF patch archive.
+ * (C) Copyright TOSHIBA CORPORATION 2004-2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "txx9aclc.h"
+
+static const struct snd_pcm_hardware txx9aclc_pcm_hardware = {
+	/*
+	 * REVISIT: SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID
+	 * needs more works for noncoherent MIPS.
+	 */
+	.info		  = SNDRV_PCM_INFO_INTERLEAVED |
+			    SNDRV_PCM_INFO_BATCH |
+			    SNDRV_PCM_INFO_PAUSE,
+#ifdef __BIG_ENDIAN
+	.formats	  = SNDRV_PCM_FMTBIT_S16_BE,
+#else
+	.formats	  = SNDRV_PCM_FMTBIT_S16_LE,
+#endif
+	.period_bytes_min = 1024,
+	.period_bytes_max = 8 * 1024,
+	.periods_min	  = 2,
+	.periods_max	  = 4096,
+	.buffer_bytes_max = 32 * 1024,
+};
+
+static int txx9aclc_pcm_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct txx9aclc_dmadata *dmadata = runtime->private_data;
+	int ret;
+
+	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(socdev->dev,
+		"runtime->dma_area = %#lx dma_addr = %#lx dma_bytes = %zd "
+		"runtime->min_align %ld\n",
+		(unsigned long)runtime->dma_area,
+		(unsigned long)runtime->dma_addr, runtime->dma_bytes,
+		runtime->min_align);
+	dev_dbg(socdev->dev,
+		"periods %d period_bytes %d stream %d\n",
+		params_periods(params), params_period_bytes(params),
+		substream->stream);
+
+	dmadata->substream = substream;
+	dmadata->pos = 0;
+	return 0;
+}
+
+static int txx9aclc_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int txx9aclc_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct txx9aclc_dmadata *dmadata = runtime->private_data;
+
+	dmadata->dma_addr = runtime->dma_addr;
+	dmadata->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+	dmadata->period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	if (dmadata->buffer_bytes == dmadata->period_bytes) {
+		dmadata->frag_bytes = dmadata->period_bytes >> 1;
+		dmadata->frags = 2;
+	} else {
+		dmadata->frag_bytes = dmadata->period_bytes;
+		dmadata->frags = dmadata->buffer_bytes / dmadata->period_bytes;
+	}
+	dmadata->frag_count = 0;
+	dmadata->pos = 0;
+	return 0;
+}
+
+static void txx9aclc_dma_complete(void *arg)
+{
+	struct txx9aclc_dmadata *dmadata = arg;
+	unsigned long flags;
+
+	/* dma completion handler cannot submit new operations */
+	spin_lock_irqsave(&dmadata->dma_lock, flags);
+	if (dmadata->frag_count >= 0) {
+		dmadata->dmacount--;
+		BUG_ON(dmadata->dmacount < 0);
+		tasklet_schedule(&dmadata->tasklet);
+	}
+	spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+}
+
+static struct dma_async_tx_descriptor *
+txx9aclc_dma_submit(struct txx9aclc_dmadata *dmadata, dma_addr_t buf_dma_addr)
+{
+	struct dma_chan *chan = dmadata->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, pfn_to_page(PFN_DOWN(buf_dma_addr)),
+		    dmadata->frag_bytes, buf_dma_addr & (PAGE_SIZE - 1));
+	sg_dma_address(&sg) = buf_dma_addr;
+	desc = chan->device->device_prep_slave_sg(chan, &sg, 1,
+		dmadata->substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		DMA_TO_DEVICE : DMA_FROM_DEVICE,
+		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
+		return NULL;
+	}
+	desc->callback = txx9aclc_dma_complete;
+	desc->callback_param = dmadata;
+	desc->tx_submit(desc);
+	return desc;
+}
+
+#define NR_DMA_CHAIN		2
+
+static void txx9aclc_dma_tasklet(unsigned long data)
+{
+	struct txx9aclc_dmadata *dmadata = (struct txx9aclc_dmadata *)data;
+	struct dma_chan *chan = dmadata->dma_chan;
+	struct dma_async_tx_descriptor *desc;
+	struct snd_pcm_substream *substream = dmadata->substream;
+	u32 ctlbit = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		ACCTL_AUDODMA : ACCTL_AUDIDMA;
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmadata->dma_lock, flags);
+	if (dmadata->frag_count < 0) {
+		struct txx9aclc_soc_device *dev =
+			container_of(dmadata, struct txx9aclc_soc_device,
+				     dmadata[substream->stream]);
+		struct txx9aclc_plat_drvdata *drvdata =
+			txx9aclc_get_plat_drvdata(dev);
+		void __iomem *base = drvdata->base;
+
+		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+		chan->device->device_terminate_all(chan);
+		/* first time */
+		for (i = 0; i < NR_DMA_CHAIN; i++) {
+			desc = txx9aclc_dma_submit(dmadata,
+				dmadata->dma_addr + i * dmadata->frag_bytes);
+			if (!desc)
+				return;
+		}
+		dmadata->dmacount = NR_DMA_CHAIN;
+		chan->device->device_issue_pending(chan);
+		spin_lock_irqsave(&dmadata->dma_lock, flags);
+		__raw_writel(ctlbit, base + ACCTLEN);
+		dmadata->frag_count = NR_DMA_CHAIN % dmadata->frags;
+		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+		return;
+	}
+	BUG_ON(dmadata->dmacount >= NR_DMA_CHAIN);
+	while (dmadata->dmacount < NR_DMA_CHAIN) {
+		dmadata->dmacount++;
+		spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+		desc = txx9aclc_dma_submit(dmadata,
+			dmadata->dma_addr +
+			dmadata->frag_count * dmadata->frag_bytes);
+		if (!desc)
+			return;
+		chan->device->device_issue_pending(chan);
+
+		spin_lock_irqsave(&dmadata->dma_lock, flags);
+		dmadata->frag_count++;
+		dmadata->frag_count %= dmadata->frags;
+		dmadata->pos += dmadata->frag_bytes;
+		dmadata->pos %= dmadata->buffer_bytes;
+		if ((dmadata->frag_count * dmadata->frag_bytes) %
+		    dmadata->period_bytes == 0)
+			snd_pcm_period_elapsed(substream);
+	}
+	spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+}
+
+static int txx9aclc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct txx9aclc_soc_device *dev =
+		container_of(rtd->socdev, struct txx9aclc_soc_device, soc_dev);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	void __iomem *base = drvdata->base;
+	unsigned long flags;
+	int ret = 0;
+	u32 ctlbit = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		ACCTL_AUDODMA : ACCTL_AUDIDMA;
+
+	spin_lock_irqsave(&dmadata->dma_lock, flags);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dmadata->frag_count = -1;
+		tasklet_schedule(&dmadata->tasklet);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		__raw_writel(ctlbit, base + ACCTLDIS);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		__raw_writel(ctlbit, base + ACCTLEN);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	spin_unlock_irqrestore(&dmadata->dma_lock, flags);
+	return ret;
+}
+
+static snd_pcm_uframes_t
+txx9aclc_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
+
+	return bytes_to_frames(substream->runtime, dmadata->pos);
+}
+
+static int txx9aclc_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct txx9aclc_soc_device *dev =
+		container_of(rtd->socdev, struct txx9aclc_soc_device, soc_dev);
+	struct txx9aclc_dmadata *dmadata = &dev->dmadata[substream->stream];
+	int ret;
+
+	ret = snd_soc_set_runtime_hwparams(substream, &txx9aclc_pcm_hardware);
+	if (ret)
+		return ret;
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+	substream->runtime->private_data = dmadata;
+	return 0;
+}
+
+static int txx9aclc_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct txx9aclc_dmadata *dmadata = substream->runtime->private_data;
+	struct dma_chan *chan = dmadata->dma_chan;
+
+	dmadata->frag_count = -1;
+	chan->device->device_terminate_all(chan);
+	return 0;
+}
+
+static struct snd_pcm_ops txx9aclc_pcm_ops = {
+	.open		= txx9aclc_pcm_open,
+	.close		= txx9aclc_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= txx9aclc_pcm_hw_params,
+	.hw_free	= txx9aclc_pcm_hw_free,
+	.prepare	= txx9aclc_pcm_prepare,
+	.trigger	= txx9aclc_pcm_trigger,
+	.pointer	= txx9aclc_pcm_pointer,
+};
+
+static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static int txx9aclc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+			    struct snd_pcm *pcm)
+{
+	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+		card->dev, 64 * 1024, 4 * 1024 * 1024);
+}
+
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct txx9aclc_dmadata *dmadata = param;
+	char devname[BUS_ID_SIZE + 2];
+
+	sprintf(devname, "%s.%d", dmadata->dma_res->name,
+		(int)dmadata->dma_res->start);
+	if (strcmp(dev_name(chan->device->dev), devname) == 0) {
+		chan->private = &dmadata->dma_slave;
+		return true;
+	}
+	return false;
+}
+
+static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
+			     struct txx9aclc_dmadata *dmadata)
+{
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	struct txx9dmac_slave *ds = &dmadata->dma_slave;
+	dma_cap_mask_t mask;
+
+	spin_lock_init(&dmadata->dma_lock);
+
+	ds->reg_width = sizeof(u32);
+	if (dmadata->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ds->tx_reg = drvdata->physbase + ACAUDODAT;
+		ds->rx_reg = 0;
+	} else {
+		ds->tx_reg = 0;
+		ds->rx_reg = drvdata->physbase + ACAUDIDAT;
+	}
+
+	/* Try to grab a DMA channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	dmadata->dma_chan = dma_request_channel(mask, filter, dmadata);
+	if (!dmadata->dma_chan) {
+		dev_err(dev->soc_dev.dev,
+			"DMA channel for %s is not available\n",
+			dmadata->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			"playback" : "capture");
+		return -EBUSY;
+	}
+	tasklet_init(&dmadata->tasklet, txx9aclc_dma_tasklet,
+		     (unsigned long)dmadata);
+	return 0;
+}
+
+static int txx9aclc_pcm_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct txx9aclc_soc_device *dev =
+		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
+	struct resource *r;
+	int i;
+	int ret;
+
+	dev->dmadata[0].stream = SNDRV_PCM_STREAM_PLAYBACK;
+	dev->dmadata[1].stream = SNDRV_PCM_STREAM_CAPTURE;
+	for (i = 0; i < 2; i++) {
+		r = platform_get_resource(dev->aclc_pdev, IORESOURCE_DMA, i);
+		if (!r) {
+			ret = -EBUSY;
+			goto exit;
+		}
+		dev->dmadata[i].dma_res = r;
+		ret = txx9aclc_dma_init(dev, &dev->dmadata[i]);
+		if (ret)
+			goto exit;
+	}
+	return 0;
+
+exit:
+	for (i = 0; i < 2; i++) {
+		if (dev->dmadata[i].dma_chan)
+			dma_release_channel(dev->dmadata[i].dma_chan);
+		dev->dmadata[i].dma_chan = NULL;
+	}
+	return ret;
+}
+
+static int txx9aclc_pcm_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct txx9aclc_soc_device *dev =
+		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
+	struct txx9aclc_plat_drvdata *drvdata = txx9aclc_get_plat_drvdata(dev);
+	void __iomem *base = drvdata->base;
+	int i;
+
+	/* disable all FIFO DMAs */
+	__raw_writel(ACCTL_AUDODMA | ACCTL_AUDIDMA, base + ACCTLDIS);
+	/* dummy R/W to clear pending DMAREQ if any */
+	__raw_writel(__raw_readl(base + ACAUDIDAT), base + ACAUDODAT);
+
+	for (i = 0; i < 2; i++) {
+		struct txx9aclc_dmadata *dmadata = &dev->dmadata[i];
+		struct dma_chan *chan = dmadata->dma_chan;
+		if (chan) {
+			dmadata->frag_count = -1;
+			chan->device->device_terminate_all(chan);
+			dma_release_channel(chan);
+		}
+		dev->dmadata[i].dma_chan = NULL;
+	}
+	return 0;
+}
+
+struct snd_soc_platform txx9aclc_soc_platform = {
+	.name		= "txx9aclc-audio",
+	.probe		= txx9aclc_pcm_probe,
+	.remove		= txx9aclc_pcm_remove,
+	.pcm_ops 	= &txx9aclc_pcm_ops,
+	.pcm_new	= txx9aclc_pcm_new,
+	.pcm_free	= txx9aclc_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(txx9aclc_soc_platform);
+
+static int __init txx9aclc_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&txx9aclc_soc_platform);
+}
+
+static void __exit txx9aclc_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&txx9aclc_soc_platform);
+}
+
+module_init(txx9aclc_soc_platform_init);
+module_exit(txx9aclc_soc_platform_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("TXx9 ACLC Audio DMA driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/txx9/txx9aclc.h b/sound/soc/txx9/txx9aclc.h
new file mode 100644
index 0000000..6769aab
--- /dev/null
+++ b/sound/soc/txx9/txx9aclc.h
@@ -0,0 +1,83 @@
+/*
+ * TXx9 SoC AC Link Controller
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __TXX9ACLC_H
+#define __TXX9ACLC_H
+
+#include <linux/interrupt.h>
+#include <asm/txx9/dmac.h>
+
+#define ACCTLEN			0x00	/* control enable */
+#define ACCTLDIS		0x04	/* control disable */
+#define   ACCTL_ENLINK		0x00000001	/* enable/disable AC-link */
+#define   ACCTL_AUDODMA		0x00000100	/* AUDODMA enable/disable */
+#define   ACCTL_AUDIDMA		0x00001000	/* AUDIDMA enable/disable */
+#define   ACCTL_AUDOEHLT	0x00010000	/* AUDO error halt
+						   enable/disable */
+#define   ACCTL_AUDIEHLT	0x00100000	/* AUDI error halt
+						   enable/disable */
+#define ACREGACC		0x08	/* codec register access */
+#define   ACREGACC_DAT_SHIFT	0	/* data field */
+#define   ACREGACC_REG_SHIFT	16	/* address field */
+#define   ACREGACC_CODECID_SHIFT	24	/* CODEC ID field */
+#define   ACREGACC_READ		0x80000000	/* CODEC read */
+#define   ACREGACC_WRITE	0x00000000	/* CODEC write */
+#define ACINTSTS		0x10	/* interrupt status */
+#define ACINTMSTS		0x14	/* interrupt masked status */
+#define ACINTEN			0x18	/* interrupt enable */
+#define ACINTDIS		0x1c	/* interrupt disable */
+#define   ACINT_CODECRDY(n)	(0x00000001 << (n))	/* CODECn ready */
+#define   ACINT_REGACCRDY	0x00000010	/* ACREGACC ready */
+#define   ACINT_AUDOERR		0x00000100	/* AUDO underrun error */
+#define   ACINT_AUDIERR		0x00001000	/* AUDI overrun error */
+#define ACDMASTS		0x80	/* DMA request status */
+#define   ACDMA_AUDO		0x00000001	/* AUDODMA pending */
+#define   ACDMA_AUDI		0x00000010	/* AUDIDMA pending */
+#define ACAUDODAT		0xa0	/* audio out data */
+#define ACAUDIDAT		0xb0	/* audio in data */
+#define ACREVID			0xfc	/* revision ID */
+
+struct txx9aclc_dmadata {
+	struct resource *dma_res;
+	struct txx9dmac_slave dma_slave;
+	struct dma_chan *dma_chan;
+	struct tasklet_struct tasklet;
+	spinlock_t dma_lock;
+	int stream; /* SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE */
+	struct snd_pcm_substream *substream;
+	unsigned long pos;
+	dma_addr_t dma_addr;
+	unsigned long buffer_bytes;
+	unsigned long period_bytes;
+	unsigned long frag_bytes;
+	int frags;
+	int frag_count;
+	int dmacount;
+};
+
+struct txx9aclc_plat_drvdata {
+	void __iomem *base;
+	u64 physbase;
+};
+
+struct txx9aclc_soc_device {
+	struct snd_soc_device soc_dev;
+	struct platform_device *aclc_pdev;	/* for ioresources, drvdata */
+	struct txx9aclc_dmadata dmadata[2];
+};
+
+static inline struct txx9aclc_plat_drvdata *txx9aclc_get_plat_drvdata(
+	struct txx9aclc_soc_device *sdev)
+{
+	return platform_get_drvdata(sdev->aclc_pdev);
+}
+
+extern struct snd_soc_platform txx9aclc_soc_platform;
+extern struct snd_soc_dai txx9aclc_ac97_dai;
+
+#endif /* __TXX9ACLC_H */
-- 
1.5.6.5
