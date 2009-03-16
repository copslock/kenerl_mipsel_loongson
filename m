Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2009 13:47:58 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:54796 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21368500AbZCPNrv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2009 13:47:51 +0000
Received: from 10.8.0.20 ([10.8.0.20]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Mon, 16 Mar 2009 13:47:41 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 16 Mar 2009 08:47:41 -0500
Subject: Re: linux-2.6.28.4 regarding
From:	Kevin Hickey <khickey@rmicorp.com>
To:	umeshyv <umeshyv@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <b5c34db00903140452l672f1a50g30f8003b4d24728d@mail.gmail.com>
References: <b5c34db00903140452l672f1a50g30f8003b4d24728d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 16 Mar 2009 08:47:41 -0500
Message-Id: <1237211261.7473.3.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-03-14 at 17:22 +0530, umeshyv wrote:
> Hi to all,
> I downloaded latest kernel for mips (linux-2.6.28.4).How do I
> configure Asoc driver(wm8731 codec,I2S based)  for DbAu1200
> development board.Please guide me  with your valuable
> suggestions.waiting for your valuable reply
> 
I just recently had the same request from someone else and created a
pair of patches for this.  It has only been through limited testing so I
can't promise that it's perfect, but it basically works.

>From 4fec1f6b93b09df62294d8fb08ae9d5266453d5f Mon Sep 17 00:00:00 2001
From: khickey <khickey@35c7ba61-0b3b-44cf-8ad4-8c98d727fa3b>
Date: Wed, 11 Mar 2009 21:06:51 +0000
Subject: [PATCH] DB1200: Sample I2S audio sound machine

Added a sound machine in the model of sample-ac97 for I2S audio with the
WM8731
codec.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>


git-svn-id: svn://coredev/Linux-kernel/trunk@65
35c7ba61-0b3b-44cf-8ad4-8c98d727fa3b
---
 sound/soc/au1x/Kconfig      |    9 ++
 sound/soc/au1x/Makefile     |    2 +
 sound/soc/au1x/sample-i2s.c |  187
+++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/au1x/sample-i2s.c

diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index c7ca3f2..abf333b 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -22,6 +22,15 @@ config SND_SOC_AU1XPSC_AC97
 ##
 ## Boards
 ##
+config SND_SOC_SAMPLE_PSC_I2S
+	tristate "Sample Au12x0/Au1550 PSC I2S sound machine"
+	depends on SND_SOC_AU1XPSC
+	select SND_SOC_AU1XPSC_I2S
+	select SND_SOC_WM8731
+	help
+	  This is a sample I2S sound machine for use with the DB1200
+	  development board, which has a WM8731 codec.
+
 config SND_SOC_SAMPLE_PSC_AC97
 	tristate "Sample Au12x0/Au1550 PSC AC97 sound machine"
 	depends on SND_SOC_AU1XPSC
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index b48bb36..b8e54a4 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -9,7 +9,9 @@ obj-$(CONFIG_SND_SOC_AU1XPSC_AC97) +=
snd-soc-au1xpsc-ac97.o
 
 # Boards
 snd-soc-sample-ac97-objs := sample-ac97.o
+snd-soc-sample-i2s-objs  := sample-i2s.o
 snd-soc-hmp10-ac97-objs  := hmp10-ac97.o
 
 obj-$(CONFIG_SND_SOC_SAMPLE_PSC_AC97) += snd-soc-sample-ac97.o
+obj-$(CONFIG_SND_SOC_SAMPLE_PSC_I2S) += snd-soc-sample-i2s.o
 obj-$(CONFIG_SND_SOC_HMP10_AC97) += snd-soc-hmp10-ac97.o
diff --git a/sound/soc/au1x/sample-i2s.c b/sound/soc/au1x/sample-i2s.c
new file mode 100644
index 0000000..612cfaa
--- /dev/null
+++ b/sound/soc/au1x/sample-i2s.c
@@ -0,0 +1,187 @@
+/*
+ * Sample Au12x0 PSC I2S sound machine.
+ *
+ * Copyright (c) 2009 RMI Corporation <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms outlined in the file COPYING at the root of this
+ *  source archive.
+ *
+ * This is a very generic I2S sound machine driver for boards which
+ * have I2S audio at PSC1 (e.g. DB1200 demoboards).
+ *
+ * This file is based on sample-ac97.c by Manuel Lauss
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
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#endif
+
+#include "../codecs/wm8731.h"
+#include "psc.h"
+
+static int au1xpsc_sample_i2s_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static int au1xpsc_sample_hw_params(struct snd_pcm_substream
*substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret = 0;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+					     SND_SOC_DAIFMT_CBM_CFM);
+	return ret;
+}
+
+
+static struct snd_soc_ops au1xpsc_sample_ops = {
+	.hw_params = au1xpsc_sample_hw_params,
+};
+
+static struct snd_soc_dai_link au1xpsc_sample_i2s_dai = {
+	.name		= "I2S",
+	.stream_name	= "I2S WM8731",
+	.cpu_dai	= &au1xpsc_i2s_dai,	/* see psc-i2s.c */
+	.codec_dai	= &wm8731_dai,		/* see codecs/wm8731.c */
+	.init		= au1xpsc_sample_i2s_init,
+	.ops		= &au1xpsc_sample_ops,
+};
+
+static struct snd_soc_card au1xpsc_sample_i2s_machine = {
+	.name		= "Au1xxx PSC I2S Audio",
+	.dai_link	= &au1xpsc_sample_i2s_dai,
+	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
+	.num_links	= 1,
+	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
+};
+
+static struct wm8731_setup_data au1xpsc_sample_wm8731_setup = {
+	.i2c_bus = 0,
+	.i2c_address = 0x1b,
+};
+
+static struct snd_soc_device au1xpsc_sample_i2s_devdata = {
+	.card		= &au1xpsc_sample_i2s_machine,
+	.codec_dev	= &soc_codec_dev_wm8731,
+	.codec_data	= &au1xpsc_sample_wm8731_setup,
+};
+
+static struct resource au1xpsc_psc1_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(PSC1_BASE_ADDR),
+		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+#ifdef CONFIG_SOC_AU1200
+		.start	= AU1200_PSC1_INT,
+		.end	= AU1200_PSC1_INT,
+#elif defined(CONFIG_SOC_AU1550)
+		.start	= AU1550_PSC1_INT,
+		.end	= AU1550_PSC1_INT,
+#elif defined(CONFIG_SOC_AU13XX)
+		.start  = AU1300_IRQ_PSC1,
+		.end	= AU1300_IRQ_PSC1,
+#endif
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
+static struct platform_device *au1xpsc_sample_i2s_dev;
+
+static int __init au1xpsc_sample_i2s_load(void)
+{
+	int ret;
+
+#ifdef CONFIG_SOC_AU1200
+	unsigned long io;
+
+	/* modify sys_pinfunc for AC97 on PSC1 */
+	io = au_readl(SYS_PINFUNC);
+	io |= SYS_PINFUNC_P1C;
+	io &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B);
+	au_writel(io, SYS_PINFUNC);
+	au_sync();
+
+#endif
+
+	/*
+	 * The DB1200 has a mux coming out of PSC1 that switches between AC97
+	 * and I2S.  The default is AC97 so we have to make sure to change it
+	 * here.
+	 */
+#ifdef CONFIG_MIPS_DB1200
+	AU_SET_BITS_16(BCSR_RESETS_PCS1MUX, &bcsr->resets);
+#endif
+
+	ret = -ENOMEM;
+
+	/* setup PSC clock source for AC97 part: external clock provided
+	 * by codec.  The psc-ac97.c driver depends on this setting!
+	 */
+	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
+	au_sync();
+
+	au1xpsc_sample_i2s_dev = platform_device_alloc("soc-audio", -1);
+	if (!au1xpsc_sample_i2s_dev)
+		goto out;
+
+	au1xpsc_sample_i2s_dev->resource =
+		kmemdup(au1xpsc_psc1_res, sizeof(struct resource) *
+			ARRAY_SIZE(au1xpsc_psc1_res), GFP_KERNEL);
+	au1xpsc_sample_i2s_dev->num_resources = ARRAY_SIZE(au1xpsc_psc1_res);
+	au1xpsc_sample_i2s_dev->id = 1;
+
+	platform_set_drvdata(au1xpsc_sample_i2s_dev,
+			     &au1xpsc_sample_i2s_devdata);
+	au1xpsc_sample_i2s_devdata.dev = &au1xpsc_sample_i2s_dev->dev;
+	ret = platform_device_add(au1xpsc_sample_i2s_dev);
+
+	if (ret) {
+		platform_device_put(au1xpsc_sample_i2s_dev);
+		au1xpsc_sample_i2s_dev = NULL;
+	}
+
+out:
+	return ret;
+}
+
+static void __exit au1xpsc_sample_i2s_exit(void)
+{
+	platform_device_unregister(au1xpsc_sample_i2s_dev);
+}
+
+module_init(au1xpsc_sample_i2s_load);
+module_exit(au1xpsc_sample_i2s_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Au1xxx PSC sample I2S machine");
+MODULE_AUTHOR("Kevin Hickey <khickey@rmicorp.com>");
-- 
1.5.4.3


>From 6a54eade32f3df84af3644ea7991f48e7ea91f99 Mon Sep 17 00:00:00 2001
From: khickey <khickey@35c7ba61-0b3b-44cf-8ad4-8c98d727fa3b>
Date: Fri, 13 Mar 2009 14:01:04 +0000
Subject: [PATCH] DB1200: Bugfix - WM8731 powerup

The existing WM8731 code was not powering up the codec properly,
resulting in
no sound.  The clock output, oscillator and DAC were all staying powered
down.


git-svn-id: svn://coredev/Linux-kernel/trunk@69
35c7ba61-0b3b-44cf-8ad4-8c98d727fa3b
---
 sound/soc/codecs/wm8731.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index c444b9f..0dcf172 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -418,8 +418,8 @@ static int wm8731_set_bias_level(struct
snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* vref/mid, osc on, dac unmute */
-		wm8731_write(codec, WM8731_PWR, reg);
+		/* Turn everything on */
+		wm8731_write(codec, WM8731_PWR, 0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
-- 
1.5.4.3



-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
