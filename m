Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:45:55 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:59022 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491021Ab1GYLpA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2011 13:45:00 +0200
Received: by fxd20 with SMTP id 20so6754313fxd.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2011 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CdWFeq1qJo1RcVt9O81IHRb0CYXB9mA5b63vfqORfQk=;
        b=qpFM2GZoYtUTFuPa/12dk1+ETCsNE60+4sAR2ww0qEpEtHbCOEqieC8kIrbnl51/T4
         qVG7Cc/1O3XafxPXlYoWpIoZzQe9wAgOkmwj4LXdUGuxmo2yCCyA5KJxSZQQCoiZbyC/
         IuFVNFtl5jkXVDEOTL663u1ap/pEXUcc9qs/8=
Received: by 10.223.13.198 with SMTP id d6mr6596246faa.119.1311594295288;
        Mon, 25 Jul 2011 04:44:55 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-52.adsl.highway.telekom.at [188.22.157.52])
        by mx.google.com with ESMTPS id n18sm2723648fam.31.2011.07.25.04.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 04:44:54 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V5 2/3] ASoC: Add a DB1x00 AC97 machine driver
Date:   Mon, 25 Jul 2011 13:44:46 +0200
Message-Id: <1311594287-31576-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17609

Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
boards.

Run-tested on DB1500.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V4/V5: no changes.
V3: split off from patch 1, implemented new machine code.

 arch/mips/alchemy/devboards/db1x00/platform.c |   48 ++++++++++++++++
 sound/soc/au1x/Kconfig                        |    9 +++
 sound/soc/au1x/Makefile                       |    2 +
 sound/soc/au1x/db1000.c                       |   75 +++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/au1x/db1000.c

diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index 978d5ab..7057d28 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -19,8 +19,11 @@
  */
 
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include "../platform.h"
@@ -85,6 +88,45 @@
 #endif
 #endif
 
+static struct resource alchemy_ac97c_res[] = {
+	[0] = {
+		.start	= AU1000_AC97_PHYS_ADDR,
+		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMA_ID_AC97C_TX,
+		.end	= DMA_ID_AC97C_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMA_ID_AC97C_RX,
+		.end	= DMA_ID_AC97C_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device alchemy_ac97c_dev = {
+	.name		= "alchemy-ac97c",
+	.id		= -1,
+	.resource	= alchemy_ac97c_res,
+	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
+};
+
+static struct platform_device alchemy_ac97c_dma_dev = {
+	.name		= "alchemy-pcm-dma",
+	.id		= 0,
+};
+
+static struct platform_device db1x00_codec_dev = {
+	.name		= "ac97-codec",
+	.id		= -1,
+};
+
+static struct platform_device db1x00_audio_dev = {
+	.name		= "db1000-audio",
+};
+
 static int __init db1xxx_dev_init(void)
 {
 #ifdef DB1XXX_HAS_PCMCIA
@@ -113,6 +155,12 @@ static int __init db1xxx_dev_init(void)
 				    1);
 #endif
 	db1x_register_norflash(BOARD_FLASH_SIZE, BOARD_FLASH_WIDTH, F_SWAPPED);
+
+	platform_device_register(&db1x00_codec_dev);
+	platform_device_register(&alchemy_ac97c_dma_dev);
+	platform_device_register(&alchemy_ac97c_dev);
+	platform_device_register(&db1x00_audio_dev);
+
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 0460b42..6d59254 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -41,6 +41,15 @@ config SND_SOC_AU1XI2SC
 ##
 ## Boards
 ##
+config SND_SOC_DB1000
+	tristate "DB1000 Audio support"
+	depends on SND_SOC_AU1XAUDIO
+	select SND_SOC_AU1XAC97C
+	select SND_SOC_AC97_CODEC
+	help
+	  Select this option to enable AC97 audio on the early DB1x00 series
+	  of boards (DB1000/DB1500/DB1100).
+
 config SND_SOC_DB1200
 	tristate "DB1200 AC97+I2S audio support"
 	depends on SND_SOC_AU1XPSC
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index ff5531e..9207105 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_SND_SOC_AU1XAC97C) += snd-soc-au1x-ac97c.o
 obj-$(CONFIG_SND_SOC_AU1XI2SC) += snd-soc-au1x-i2sc.o
 
 # Boards
+snd-soc-db1000-objs := db1000.o
 snd-soc-db1200-objs := db1200.o
 
+obj-$(CONFIG_SND_SOC_DB1000) += snd-soc-db1000.o
 obj-$(CONFIG_SND_SOC_DB1200) += snd-soc-db1200.o
diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
new file mode 100644
index 0000000..127477a
--- /dev/null
+++ b/sound/soc/au1x/db1000.c
@@ -0,0 +1,75 @@
+/*
+ * DB1000/DB1500/DB1100 ASoC audio fabric support code.
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#include "psc.h"
+
+static struct snd_soc_dai_link db1000_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.codec_dai_name	= "ac97-hifi",
+	.cpu_dai_name	= "alchemy-ac97c",
+	.platform_name	= "alchemy-pcm-dma.0",
+	.codec_name	= "ac97-codec",
+};
+
+static struct snd_soc_card db1000_ac97 = {
+	.name		= "DB1000_AC97",
+	.dai_link	= &db1000_ac97_dai,
+	.num_links	= 1,
+};
+
+static int __devinit db1000_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &db1000_ac97;
+	card->dev = &pdev->dev;
+	return snd_soc_register_card(card);
+}
+
+static int __devexit db1000_audio_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	snd_soc_unregister_card(card);
+	return 0;
+}
+
+static struct platform_driver db1000_audio_driver = {
+	.driver	= {
+		.name	= "db1000-audio",
+		.owner	= THIS_MODULE,
+		.pm	= &snd_soc_pm_ops,
+	},
+	.probe		= db1000_audio_probe,
+	.remove		= __devexit_p(db1000_audio_remove),
+};
+
+static int __init db1000_audio_load(void)
+{
+	return platform_driver_register(&db1000_audio_driver);
+}
+
+static void __exit db1000_audio_unload(void)
+{
+	platform_driver_unregister(&db1000_audio_driver);
+}
+
+module_init(db1000_audio_load);
+module_exit(db1000_audio_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DB1000/DB1500/DB1100 ASoC audio");
+MODULE_AUTHOR("Manuel Lauss");
-- 
1.7.6
