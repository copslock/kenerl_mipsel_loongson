Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 16:51:58 +0200 (CEST)
Received: from blue-ld-261.synserver.de ([217.119.54.83]:59403 "EHLO
        smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491798Ab0FSOvx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 16:51:53 +0200
Received: (qmail 17607 invoked by uid 0); 19 Jun 2010 14:51:53 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 17533
Received: from port-13469.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.52.209]
  by 217.119.54.87 with SMTP; 19 Jun 2010 14:51:52 -0000
From:   1276924111-11158-27-git-send-email-lars@metafoo.de
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: [PATCH v3] alsa: ASoC: JZ4740: Add qi_lb60 board driver
Date:   Sat, 19 Jun 2010 16:51:22 +0200
Message-Id: <1276959082-9184-1-git-send-email-1276924111-11158-27-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
X-archive-position: 27213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 1276924111-11158-27-git-send-email-lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13538

From: Lars-Peter Clausen <lars@metafoo.de>

This patch adds ASoC support for the qi_lb60 board.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org

--
Changes since v1
- Refer to AMP gpios always by their define
- Do not try to set codecs format, since the set_fmt callback for the codec was
  dropped.

Changes since v2
- The codec prefix was removed from jz4740 codec include file
- This patch accidentally contained a few bits meant for ASoC JZ4740 platform
  support patch. Removed them.
---
 sound/soc/jz4740/Kconfig   |    9 +++
 sound/soc/jz4740/Makefile  |    4 +
 sound/soc/jz4740/qi_lb60.c |  166 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/jz4740/qi_lb60.c

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 27480f2..5351cba 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -12,3 +12,12 @@ config SND_JZ4740_SOC_I2S
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
 	  based boards.
+
+config SND_JZ4740_SOC_QI_LB60
+	tristate "SoC Audio support for Qi LB60"
+	depends on SND_JZ4740_SOC && JZ4740_QI_LB60
+	select SND_JZ4740_SOC_I2S
+    select SND_SOC_JZ4740_CODEC
+	help
+	  Say Y if you want to add support for ASoC audio on the Qi LB60 board
+	  a.k.a Qi Ben NanoNote.
diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
index 1be8d19..be873c1 100644
--- a/sound/soc/jz4740/Makefile
+++ b/sound/soc/jz4740/Makefile
@@ -7,3 +7,7 @@ snd-soc-jz4740-i2s-objs := jz4740-i2s.o
 obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
 obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
 
+# Jz4740 Machine Support
+snd-soc-qi-lb60-objs := qi_lb60.o
+
+obj-$(CONFIG_SND_JZ4740_SOC_QI_LB60) += snd-soc-qi-lb60.o
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
new file mode 100644
index 0000000..f15f491
--- /dev/null
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (C) 2009, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
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
+#include <linux/gpio.h>
+
+#include "../codecs/jz4740.h"
+#include "jz4740-pcm.h"
+#include "jz4740-i2s.h"
+
+
+#define QI_LB60_SND_GPIO JZ_GPIO_PORTB(29)
+#define QI_LB60_AMP_GPIO JZ_GPIO_PORTD(4)
+
+static int qi_lb60_spk_event(struct snd_soc_dapm_widget *widget,
+			     struct snd_kcontrol *ctrl, int event)
+{
+	int on = 0;
+	if (event & SND_SOC_DAPM_POST_PMU)
+		on = 1;
+	else if (event & SND_SOC_DAPM_PRE_PMD)
+		on = 0;
+
+	gpio_set_value(QI_LB60_SND_GPIO, on);
+	gpio_set_value(QI_LB60_AMP_GPIO, on);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget qi_lb60_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", qi_lb60_spk_event),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route qi_lb60_routes[] = {
+	{"Mic", NULL, "MIC"},
+	{"Speaker", NULL, "LOUT"},
+	{"Speaker", NULL, "ROUT"},
+};
+
+#define QI_LB60_DAIFMT (SND_SOC_DAIFMT_I2S | \
+			SND_SOC_DAIFMT_NB_NF | \
+			SND_SOC_DAIFMT_CBM_CFM)
+
+static int qi_lb60_codec_init(struct snd_soc_codec *codec)
+{
+	int ret;
+	struct snd_soc_dai *cpu_dai = codec->socdev->card->dai_link->cpu_dai;
+
+	snd_soc_dapm_nc_pin(codec, "LIN");
+	snd_soc_dapm_nc_pin(codec, "RIN");
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, QI_LB60_DAIFMT);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cpu dai format: %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_dapm_new_controls(codec, qi_lb60_widgets, ARRAY_SIZE(qi_lb60_widgets));
+	snd_soc_dapm_add_routes(codec, qi_lb60_routes, ARRAY_SIZE(qi_lb60_routes));
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link qi_lb60_dai = {
+	.name = "jz4740",
+	.stream_name = "jz4740",
+	.cpu_dai = &jz4740_i2s_dai,
+	.codec_dai = &jz4740_codec_dai,
+	.init = qi_lb60_codec_init,
+};
+
+static struct snd_soc_card qi_lb60 = {
+	.name = "QI LB60",
+	.dai_link = &qi_lb60_dai,
+	.num_links = 1,
+	.platform = &jz4740_soc_platform,
+};
+
+static struct snd_soc_device qi_lb60_snd_devdata = {
+	.card = &qi_lb60,
+	.codec_dev = &soc_codec_dev_jz4740_codec,
+};
+
+static struct platform_device *qi_lb60_snd_device;
+
+static int __init qi_lb60_init(void)
+{
+	int ret;
+
+	qi_lb60_snd_device = platform_device_alloc("soc-audio", -1);
+
+	if (!qi_lb60_snd_device)
+		return -ENOMEM;
+
+	ret = gpio_request(QI_LB60_SND_GPIO, "SND");
+	if (ret) {
+		pr_err("qi_lb60 snd: Failed to request SND GPIO(%d): %d\n",
+				QI_LB60_SND_GPIO, ret);
+		goto err_device_put;
+	}
+
+	ret = gpio_request(QI_LB60_AMP_GPIO, "AMP");
+	if (ret) {
+		pr_err("qi_lb60 snd: Failed to request AMP GPIO(%d): %d\n",
+				QI_LB60_AMP_GPIO, ret);
+		goto err_gpio_free_snd;
+	}
+
+	gpio_direction_output(QI_LB60_SND_GPIO, 0);
+	gpio_direction_output(QI_LB60_AMP_GPIO, 0);
+
+	platform_set_drvdata(qi_lb60_snd_device, &qi_lb60_snd_devdata);
+	qi_lb60_snd_devdata.dev = &qi_lb60_snd_device->dev;
+
+	ret = platform_device_add(qi_lb60_snd_device);
+	if (ret) {
+		pr_err("qi_lb60 snd: Failed to add snd soc device: %d\n", ret);
+		goto err_unset_pdata;
+	}
+
+	 return 0;
+
+err_unset_pdata:
+	platform_set_drvdata(qi_lb60_snd_device, NULL);
+/*err_gpio_free_amp:*/
+	gpio_free(QI_LB60_AMP_GPIO);
+err_gpio_free_snd:
+	gpio_free(QI_LB60_SND_GPIO);
+err_device_put:
+	platform_device_put(qi_lb60_snd_device);
+
+	return ret;
+}
+module_init(qi_lb60_init);
+
+static void __exit qi_lb60_exit(void)
+{
+	gpio_free(QI_LB60_AMP_GPIO);
+	gpio_free(QI_LB60_SND_GPIO);
+	platform_device_unregister(qi_lb60_snd_device);
+}
+module_exit(qi_lb60_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("ALSA SoC QI LB60 Audio support");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
