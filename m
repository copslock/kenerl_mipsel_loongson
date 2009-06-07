Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 19:40:34 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.157]:20925 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023040AbZFGSjS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 19:39:18 +0100
Received: by fg-out-1718.google.com with SMTP id 22so936918fge.9
        for <multiple recipients>; Sun, 07 Jun 2009 11:39:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=poOhZqdvzdRqx5jqEecRH/lmr+NaKAuO/sLtskmZwGg=;
        b=JwIYN4DaErBijsMOzxOIrXFs/R0yal1D0GHM5dhRY7hY5r20vEsZR6I2pQgJuIkpGE
         NyC8T1g2Pumjlf5pFVIyAw/Yss+us0z0Cb52sRuXwamXssvpKB0B7+LbCtRgz3AMQ5Yz
         4lBE8I2FdVEhH/8IWl5Jzm+Nym6xNPJ9J5vW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vgzCTJ1/2LTWioRboDKuEhWibuVMu0BaRhmwP50xOrNOncYLr1/gz0VS4Hj0Tjpa9T
         wZa+D6LnzDVqu7vtf6rKxxGFXOZD89atn/UZ7rqnzaeQWgCIAb288rrQuDODNJsGHMEI
         gqWsYqExD6wtD05n7yOqmZweapJVLURjkKmh4=
Received: by 10.86.91.10 with SMTP id o10mr6261573fgb.13.1244399958081;
        Sun, 07 Jun 2009 11:39:18 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 12sm421510fgg.0.2009.06.07.11.39.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 11:39:17 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
Subject: [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date:	Sun,  7 Jun 2009 20:39:01 +0200
Message-Id: <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Replaces the sample Alchemy PSC AC97 machine code with a DB1200 machine
driver with AC97 and I2S support.

AC97/I2S can be selected at boot time by setting switch S6.7.

Cc: alsa-devel@alsa-project.org
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200/platform.c |   12 ++
 sound/soc/au1x/Kconfig                        |   10 +-
 sound/soc/au1x/Makefile                       |    4 +-
 sound/soc/au1x/db1200.c                       |  189 +++++++++++++++++++++++++
 sound/soc/au1x/sample-ac97.c                  |  144 -------------------
 5 files changed, 209 insertions(+), 150 deletions(-)
 create mode 100644 sound/soc/au1x/db1200.c
 delete mode 100644 sound/soc/au1x/sample-ac97.c

diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
index cc3f663..b3142e0 100644
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -428,6 +428,7 @@ static int __init db1200_dev_init(void)
 				ARRAY_SIZE(db1200_i2c_devs));
 
 	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C  ON=SPI)
+	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
 	 */
 
 	/* NOTE: GPIO215 controls OTG VBUS supply.  In SPI mode however
@@ -466,6 +467,17 @@ static int __init db1200_dev_init(void)
 	au_writel(pfc, SYS_PINFUNC);
 	au_sync();
 
+	/* audio is handled in sound/soc/au1x/db1200.c;
+	 * however we need I2C to talk to I2S codec.
+	 */
+	if ((bcsr->switches & 3) == BCSR_SWITCHES_DIP_8) {
+		bcsr->resets |= BCSR_RESETS_PSC1MUX;
+		printk(KERN_INFO " S6.7 ON : PSC1 mode I2S\n");
+	} else {
+		bcsr->resets &= ~BCSR_RESETS_PSC1MUX;
+		printk(KERN_INFO " S6.7 OFF: PSC1 mode AC97\n");
+	}
+
 	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
 }
 device_initcall(db1200_dev_init);
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 410a893..4b67140 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -22,11 +22,13 @@ config SND_SOC_AU1XPSC_AC97
 ##
 ## Boards
 ##
-config SND_SOC_SAMPLE_PSC_AC97
-	tristate "Sample Au12x0/Au1550 PSC AC97 sound machine"
+config SND_SOC_DB1200
+	tristate "DB1200 AC97+I2S audio support"
 	depends on SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
+	select SND_SOC_AU1XPSC_I2S
+	select SND_SOC_WM8731
 	help
-	  This is a sample AC97 sound machine for use in Au12x0/Au1550
-	  based systems which have audio on PSC1 (e.g. Db1200 demoboard).
+	  Select this option to enable audio (AC97 or I2S) on the
+	  Alchemy/AMD/RMI DB1200 demoboard.
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index 6c6950b..1687307 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_SND_SOC_AU1XPSC_I2S) += snd-soc-au1xpsc-i2s.o
 obj-$(CONFIG_SND_SOC_AU1XPSC_AC97) += snd-soc-au1xpsc-ac97.o
 
 # Boards
-snd-soc-sample-ac97-objs := sample-ac97.o
+snd-soc-db1200-objs := db1200.o
 
-obj-$(CONFIG_SND_SOC_SAMPLE_PSC_AC97) += snd-soc-sample-ac97.o
+obj-$(CONFIG_SND_SOC_DB1200) += snd-soc-db1200.o
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
new file mode 100644
index 0000000..a2cb02c
--- /dev/null
+++ b/sound/soc/au1x/db1200.c
@@ -0,0 +1,189 @@
+/*
+ * DB1200 ASoC audio support code.
+ *
+ * (c) 2008 Manuel Lauss <manuel.lauss@gmail.com>
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
+#include <sound/soc-dapm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+/* it sucks that the ASoC headers are not under include/ */
+#include "../codecs/ac97.h"
+#include "../codecs/wm8731.h"
+#include "psc.h"
+
+/*-------------------------  AC97 PART  ---------------------------*/
+
+static int db1200_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link db1200_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.cpu_dai	= &au1xpsc_ac97_dai,
+	.codec_dai	= &ac97_dai,
+	.init		= db1200_ac97_init,
+};
+
+static struct snd_soc_card db1200_ac97_machine = {
+	.name		= "DB1200 AC97 Audio",
+	.dai_link	= &db1200_ac97_dai,
+	.num_links	= 1,
+	.platform	= &au1xpsc_soc_platform,
+};
+
+static struct snd_soc_device db1200_ac97_devdata = {
+	.card		= &db1200_ac97_machine,
+	.codec_dev	= &soc_codec_dev_ac97,
+};
+
+/*-------------------------  I2S PART  ---------------------------*/
+
+static int db1200_i2s_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* WM8731 has its own 12MHz crystal */
+	snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+				12000000, SND_SOC_CLOCK_IN);
+
+	/* codec is bitclock and lrclk master */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_LEFT_J |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		goto out;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_LEFT_J |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static struct snd_soc_ops db1200_i2s_wm8731_ops = {
+	.startup	= db1200_i2s_startup,
+};
+
+static int db1200_i2s_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link db1200_i2s_dai = {
+	.name		= "WM8731",
+	.stream_name	= "WM8731 PCM",
+	.cpu_dai	= &au1xpsc_i2s_dai,
+	.codec_dai	= &wm8731_dai,
+	.init		= db1200_i2s_init,
+	.ops		= &db1200_i2s_wm8731_ops,
+};
+
+static struct snd_soc_card db1200_i2s_machine = {
+	.name		= "DB1200 I2S Audio",
+	.dai_link	= &db1200_i2s_dai,
+	.num_links	= 1,
+	.platform	= &au1xpsc_soc_platform,
+};
+
+static struct snd_soc_device db1200_i2s_devdata = {
+	.card		= &db1200_i2s_machine,
+	.codec_dev	= &soc_codec_dev_wm8731,
+};
+
+/*-------------------------  COMMON PART  ---------------------------*/
+
+static struct resource psc1_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(PSC1_BASE_ADDR),
+		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC1_INT,
+		.end	= AU1200_PSC1_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC1_TX,
+		.end	= DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC1_RX,
+		.end	= DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device *db1200_asoc_dev;
+
+static int __init db1200_audio_load(void)
+{
+	int ret;
+
+	/* DB1200: PSC clock is supplied externally */
+	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
+	au_sync();
+
+	ret = -ENOMEM;
+	db1200_asoc_dev = platform_device_alloc("soc-audio", -1);
+	if (!db1200_asoc_dev)
+		goto out;
+
+	db1200_asoc_dev->resource =
+		kmemdup(psc1_res, sizeof(struct resource) *
+			ARRAY_SIZE(psc1_res), GFP_KERNEL);
+	db1200_asoc_dev->num_resources = ARRAY_SIZE(psc1_res);
+	db1200_asoc_dev->id = 1;
+
+	/* DB1200 board setup set PSC1MUX to preferred audio device */
+	if (bcsr->resets & BCSR_RESETS_PSC1MUX)
+		platform_set_drvdata(db1200_asoc_dev, &db1200_i2s_devdata);
+	else
+		platform_set_drvdata(db1200_asoc_dev, &db1200_ac97_devdata);
+
+	db1200_ac97_devdata.dev = &db1200_asoc_dev->dev;
+	db1200_i2s_devdata.dev = &db1200_asoc_dev->dev;
+	ret = platform_device_add(db1200_asoc_dev);
+
+	if (ret) {
+		platform_device_put(db1200_asoc_dev);
+		db1200_asoc_dev = NULL;
+	}
+out:
+	return ret;
+}
+
+static void __exit db1200_audio_unload(void)
+{
+	platform_device_unregister(db1200_asoc_dev);
+}
+
+module_init(db1200_audio_load);
+module_exit(db1200_audio_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DB1200 ASoC audio support");
+MODULE_AUTHOR("Manuel Lauss");
diff --git a/sound/soc/au1x/sample-ac97.c b/sound/soc/au1x/sample-ac97.c
deleted file mode 100644
index 27683eb..0000000
--- a/sound/soc/au1x/sample-ac97.c
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Sample Au12x0/Au1550 PSC AC97 sound machine.
- *
- * Copyright (c) 2007-2008 Manuel Lauss <mano@roarinelk.homelinux.net>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms outlined in the file COPYING at the root of this
- *  source archive.
- *
- * This is a very generic AC97 sound machine driver for boards which
- * have (AC97) audio at PSC1 (e.g. DB1200 demoboards).
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-
-#include "../codecs/ac97.h"
-#include "psc.h"
-
-static int au1xpsc_sample_ac97_init(struct snd_soc_codec *codec)
-{
-	snd_soc_dapm_sync(codec);
-	return 0;
-}
-
-static struct snd_soc_dai_link au1xpsc_sample_ac97_dai = {
-	.name		= "AC97",
-	.stream_name	= "AC97 HiFi",
-	.cpu_dai	= &au1xpsc_ac97_dai,	/* see psc-ac97.c */
-	.codec_dai	= &ac97_dai,		/* see codecs/ac97.c */
-	.init		= au1xpsc_sample_ac97_init,
-	.ops		= NULL,
-};
-
-static struct snd_soc_card au1xpsc_sample_ac97_machine = {
-	.name		= "Au1xxx PSC AC97 Audio",
-	.dai_link	= &au1xpsc_sample_ac97_dai,
-	.num_links	= 1,
-};
-
-static struct snd_soc_device au1xpsc_sample_ac97_devdata = {
-	.card		= &au1xpsc_sample_ac97_machine,
-	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
-	.codec_dev	= &soc_codec_dev_ac97,
-};
-
-static struct resource au1xpsc_psc1_res[] = {
-	[0] = {
-		.start	= CPHYSADDR(PSC1_BASE_ADDR),
-		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-#ifdef CONFIG_SOC_AU1200
-		.start	= AU1200_PSC1_INT,
-		.end	= AU1200_PSC1_INT,
-#elif defined(CONFIG_SOC_AU1550)
-		.start	= AU1550_PSC1_INT,
-		.end	= AU1550_PSC1_INT,
-#endif
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= DSCR_CMD0_PSC1_TX,
-		.end	= DSCR_CMD0_PSC1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DSCR_CMD0_PSC1_RX,
-		.end	= DSCR_CMD0_PSC1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device *au1xpsc_sample_ac97_dev;
-
-static int __init au1xpsc_sample_ac97_load(void)
-{
-	int ret;
-
-#ifdef CONFIG_SOC_AU1200
-	unsigned long io;
-
-	/* modify sys_pinfunc for AC97 on PSC1 */
-	io = au_readl(SYS_PINFUNC);
-	io |= SYS_PINFUNC_P1C;
-	io &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B);
-	au_writel(io, SYS_PINFUNC);
-	au_sync();
-#endif
-
-	ret = -ENOMEM;
-
-	/* setup PSC clock source for AC97 part: external clock provided
-	 * by codec.  The psc-ac97.c driver depends on this setting!
-	 */
-	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
-	au_sync();
-
-	au1xpsc_sample_ac97_dev = platform_device_alloc("soc-audio", -1);
-	if (!au1xpsc_sample_ac97_dev)
-		goto out;
-
-	au1xpsc_sample_ac97_dev->resource =
-		kmemdup(au1xpsc_psc1_res, sizeof(struct resource) *
-			ARRAY_SIZE(au1xpsc_psc1_res), GFP_KERNEL);
-	au1xpsc_sample_ac97_dev->num_resources = ARRAY_SIZE(au1xpsc_psc1_res);
-	au1xpsc_sample_ac97_dev->id = 1;
-
-	platform_set_drvdata(au1xpsc_sample_ac97_dev,
-			     &au1xpsc_sample_ac97_devdata);
-	au1xpsc_sample_ac97_devdata.dev = &au1xpsc_sample_ac97_dev->dev;
-	ret = platform_device_add(au1xpsc_sample_ac97_dev);
-
-	if (ret) {
-		platform_device_put(au1xpsc_sample_ac97_dev);
-		au1xpsc_sample_ac97_dev = NULL;
-	}
-
-out:
-	return ret;
-}
-
-static void __exit au1xpsc_sample_ac97_exit(void)
-{
-	platform_device_unregister(au1xpsc_sample_ac97_dev);
-}
-
-module_init(au1xpsc_sample_ac97_load);
-module_exit(au1xpsc_sample_ac97_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Au1xxx PSC sample AC97 machine");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.6.3.1
