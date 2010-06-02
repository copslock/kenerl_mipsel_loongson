Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 21:17:48 +0200 (CEST)
Received: from smtp-out-182.synserver.de ([212.40.180.182]:1583 "HELO
        smtp-out-182.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492639Ab0FBTOG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 21:14:06 +0200
Received: (qmail 31914 invoked by uid 0); 2 Jun 2010 19:13:10 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 31322
Received: from port-91163.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.68.144]
  by 217.119.54.81 with SMTP; 2 Jun 2010 19:13:10 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        alsa-devel@alsa-project.org
Subject: [RFC][PATCH 21/26] alsa: ASoC: Add JZ4740 ASoC support
Date:   Wed,  2 Jun 2010 21:12:27 +0200
Message-Id: <1275505950-17334-5-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1275505397-16758-1-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
X-archive-position: 27028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1640

This patch adds ASoC support for JZ4740 SoCs I2S module.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/Kconfig             |    1 +
 sound/soc/Makefile            |    1 +
 sound/soc/jz4740/Kconfig      |   13 +
 sound/soc/jz4740/Makefile     |    9 +
 sound/soc/jz4740/jz4740-i2s.c |  568 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/jz4740/jz4740-i2s.h |   18 ++
 sound/soc/jz4740/jz4740-pcm.c |  350 +++++++++++++++++++++++++
 sound/soc/jz4740/jz4740-pcm.h |   22 ++
 8 files changed, 982 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/jz4740/Kconfig
 create mode 100644 sound/soc/jz4740/Makefile
 create mode 100644 sound/soc/jz4740/jz4740-i2s.c
 create mode 100644 sound/soc/jz4740/jz4740-i2s.h
 create mode 100644 sound/soc/jz4740/jz4740-pcm.c
 create mode 100644 sound/soc/jz4740/jz4740-pcm.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index b1749bc..5a7a724 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -36,6 +36,7 @@ source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/jz4740/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 1470141..fdbe74d 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_SND_SOC)	+= s3c24xx/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= jz4740/
diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
new file mode 100644
index 0000000..39df949
--- /dev/null
+++ b/sound/soc/jz4740/Kconfig
@@ -0,0 +1,13 @@
+config SND_JZ4740_SOC
+	tristate "SoC Audio for Ingenic JZ4740 SoC"
+	depends on SOC_JZ4740 && SND_SOC
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Jz4740 AC97, I2S or SSP interface. You will also need
+	  to select the audio interfaces to support below.
+
+config SND_JZ4740_SOC_I2S
+	depends on SND_JZ4740_SOC
+	tristate "SoC Audio (I2S protocol) for Ingenic jz4740 chip"
+	help
+	  Say Y if you want to use I2S protocol and I2S codec on Ingenic Jz4740 QI_LB60 board.
diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
new file mode 100644
index 0000000..1be8d19
--- /dev/null
+++ b/sound/soc/jz4740/Makefile
@@ -0,0 +1,9 @@
+#
+# Jz4740 Platform Support
+#
+snd-soc-jz4740-objs := jz4740-pcm.o
+snd-soc-jz4740-i2s-objs := jz4740-i2s.o
+
+obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
+obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
+
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
new file mode 100644
index 0000000..2b139fd
--- /dev/null
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -0,0 +1,568 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "jz4740-i2s.h"
+#include "jz4740-pcm.h"
+
+#define JZ_REG_AIC_CONF		0x00
+#define JZ_REG_AIC_CTRL		0x04
+#define JZ_REG_AIC_I2S_FMT	0x10
+#define JZ_REG_AIC_FIFO_STATUS	0x14
+#define JZ_REG_AIC_I2S_STATUS	0x1c
+#define JZ_REG_AIC_CLK_DIV	0x30
+#define JZ_REG_AIC_FIFO		0x34
+
+#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_MASK (0xf << 12)
+#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_MASK (0xf <<  8)
+#define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
+#define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
+#define JZ_AIC_CONF_I2S BIT(4)
+#define JZ_AIC_CONF_RESET BIT(3)
+#define JZ_AIC_CONF_BIT_CLK_MASTER BIT(2)
+#define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
+#define JZ_AIC_CONF_ENABLE BIT(0)
+
+#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
+#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
+
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
+#define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
+#define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
+#define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
+#define JZ_AIC_CTRL_SWITCH_ENDIANNESS BIT(10)
+#define JZ_AIC_CTRL_SIGNED_TO_UNSIGNED BIT(9)
+#define JZ_AIC_CTRL_FLUSH		BIT(8)
+#define JZ_AIC_CTRL_ENABLE_ROR_INT BIT(6)
+#define JZ_AIC_CTRL_ENABLE_TUR_INT BIT(5)
+#define JZ_AIC_CTRL_ENABLE_RFS_INT BIT(4)
+#define JZ_AIC_CTRL_ENABLE_TFS_INT BIT(3)
+#define JZ_AIC_CTRL_ENABLE_LOOPBACK BIT(2)
+#define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
+#define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
+
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
+
+#define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
+#define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
+#define JZ_AIC_I2S_FMT_MSB BIT(0)
+
+#define JZ_AIC_I2S_STATUS_BUSY BIT(2)
+
+#define JZ_AIC_CLK_DIV_MASK 0xf
+
+struct jz4740_i2s {
+	struct resource *mem;
+	void __iomem *base;
+	dma_addr_t phys_base;
+
+	struct clk *clk_aic;
+	struct clk *clk_i2s;
+
+	struct jz4740_pcm_config pcm_config_playback;
+	struct jz4740_pcm_config pcm_config_capture;
+};
+
+static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
+	unsigned int reg)
+{
+	return readl(i2s->base + reg);
+}
+
+static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
+	unsigned int reg, uint32_t value)
+{
+	writel(value, i2s->base + reg);
+}
+
+static inline struct jz4740_i2s *jz4740_dai_to_i2s(struct snd_soc_dai *dai)
+{
+	return dai->private_data;
+}
+
+static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	uint32_t conf, ctrl;
+
+	if (dai->active)
+		return 0;
+
+
+	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+	ctrl |= JZ_AIC_CTRL_FLUSH;
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+
+	clk_enable(i2s->clk_i2s);
+
+	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
+	conf |= JZ_AIC_CONF_ENABLE;
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+
+	return 0;
+}
+
+static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	uint32_t conf;
+
+	if (!dai->active)
+		return;
+
+	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
+	conf &= ~JZ_AIC_CONF_ENABLE;
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+
+	clk_disable(i2s->clk_i2s);
+}
+
+
+static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+	struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	uint32_t ctrl;
+	uint32_t mask;
+
+	if (playback)
+		mask = JZ_AIC_CTRL_ENABLE_PLAYBACK | JZ_AIC_CTRL_ENABLE_TX_DMA;
+	else
+		mask = JZ_AIC_CTRL_ENABLE_CAPTURE | JZ_AIC_CTRL_ENABLE_RX_DMA;
+
+	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ctrl |= mask;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ctrl &= ~mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+
+	return 0;
+}
+
+
+static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+
+	uint32_t format = 0;
+	uint32_t conf;
+
+	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
+
+	conf &= ~(JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		conf |= JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER;
+		format |= JZ_AIC_I2S_FMT_ENABLE_SYS_CLK;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		conf |= JZ_AIC_CONF_SYNC_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		conf |= JZ_AIC_CONF_BIT_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_MSB:
+		format |= JZ_AIC_I2S_FMT_MSB;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
+
+	return 0;
+}
+
+static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	enum jz4740_dma_width dma_width;
+	struct jz4740_pcm_config *pcm_config;
+	unsigned int sample_size;
+	uint32_t ctrl;
+
+	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		sample_size = 0;
+		dma_width = JZ4740_DMA_WIDTH_8BIT;
+		break;
+	case SNDRV_PCM_FORMAT_S16:
+		sample_size = 1;
+		dma_width = JZ4740_DMA_WIDTH_16BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (playback) {
+		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
+		ctrl |= sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
+	} else {
+		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
+		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
+	}
+
+	switch (params_channels(params)) {
+	case 2:
+		break;
+	case 1:
+		if (playback) {
+			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
+			break;
+		}
+	default: /* Falltrough */
+		return -EINVAL;
+	}
+
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+
+	if (playback) {
+		pcm_config = &i2s->pcm_config_playback;
+		pcm_config->dma_config.dst_width = dma_width;
+	} else {
+		pcm_config = &i2s->pcm_config_capture;
+		pcm_config->dma_config.src_width = dma_width;
+	}
+
+
+	snd_soc_dai_set_dma_data(dai, substream, pcm_config);
+
+	return 0;
+}
+
+static int jz4740_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+
+	switch (div_id) {
+	case JZ4740_I2S_BIT_CLK:
+		if (div & 1 || div > 16)
+			return -EINVAL;
+		jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div - 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+	unsigned int freq, int dir)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	int ret = 0;
+	struct clk *parent;
+
+	switch (clk_id) {
+	case JZ4740_I2S_CLKSRC_EXT:
+		parent = clk_get(NULL, "ext");
+		clk_set_parent(i2s->clk_i2s, parent);
+		break;
+	case JZ4740_I2S_CLKSRC_PLL:
+		parent = clk_get(NULL, "pll half");
+		clk_set_parent(i2s->clk_i2s, parent);
+		ret = clk_set_rate(i2s->clk_i2s, freq);
+		break;
+	default:
+		return -EINVAL;
+	}
+	clk_put(parent);
+
+	return ret;
+}
+
+static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	uint32_t conf;
+
+	if (dai->active) {
+		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
+		conf &= ~JZ_AIC_CONF_ENABLE;
+		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+
+		clk_disable(i2s->clk_i2s);
+	}
+
+	clk_disable(i2s->clk_aic);
+
+	return 0;
+}
+
+static int jz4740_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	uint32_t conf;
+
+	clk_enable(i2s->clk_aic);
+
+	if (dai->active) {
+		clk_enable(i2s->clk_i2s);
+
+		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
+		conf |= JZ_AIC_CONF_ENABLE;
+		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+
+	}
+
+	return 0;
+}
+
+static int jz4740_i2s_probe(struct platform_device *pdev, struct snd_soc_dai *dai)
+{
+	struct jz4740_i2s *i2s = jz4740_dai_to_i2s(dai);
+	uint32_t conf;
+
+	conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
+		(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
+		JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+		JZ_AIC_CONF_I2S |
+		JZ_AIC_CONF_INTERNAL_CODEC;
+
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
+	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+
+	return 0;
+}
+
+
+static struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
+	.startup = jz4740_i2s_startup,
+	.shutdown = jz4740_i2s_shutdown,
+	.trigger = jz4740_i2s_trigger,
+	.hw_params = jz4740_i2s_hw_params,
+	.set_fmt = jz4740_i2s_set_fmt,
+	.set_clkdiv = jz4740_i2s_set_clkdiv,
+	.set_sysclk = jz4740_i2s_set_sysclk,
+};
+
+#define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
+		SNDRV_PCM_FMTBIT_S16_LE)
+
+struct snd_soc_dai jz4740_i2s_dai = {
+	.name = "jz4740-i2s",
+	.probe = jz4740_i2s_probe,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = JZ4740_I2S_FMTS,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = JZ4740_I2S_FMTS,
+	},
+	.symmetric_rates = 1,
+	.ops = &jz4740_i2s_dai_ops,
+	.suspend = jz4740_i2s_suspend,
+	.resume = jz4740_i2s_resume,
+};
+EXPORT_SYMBOL_GPL(jz4740_i2s_dai);
+
+static void __devinit jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
+{
+	struct jz4740_dma_config *dma_config;
+
+	/* Playback */
+	dma_config = &i2s->pcm_config_playback.dma_config;
+	dma_config->src_width = JZ4740_DMA_WIDTH_32BIT,
+	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
+	dma_config->request_type = JZ4740_DMA_TYPE_AIC_TRANSMIT;
+	dma_config->flags = JZ4740_DMA_SRC_AUTOINC;
+	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
+	i2s->pcm_config_playback.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+
+	/* Capture */
+	dma_config = &i2s->pcm_config_capture.dma_config;
+	dma_config->dst_width = JZ4740_DMA_WIDTH_32BIT,
+	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
+	dma_config->request_type = JZ4740_DMA_TYPE_AIC_RECEIVE;
+	dma_config->flags = JZ4740_DMA_DST_AUTOINC;
+	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
+	i2s->pcm_config_capture.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+}
+
+static int __devinit jz4740_i2s_dev_probe(struct platform_device *pdev)
+{
+	struct jz4740_i2s *i2s;
+	int ret;
+
+	i2s = kzalloc(sizeof(*i2s), GFP_KERNEL);
+
+	if (!i2s)
+		return -ENOMEM;
+
+	i2s->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!i2s->mem) {
+		ret = -ENOENT;
+		goto err_free;
+	}
+
+	i2s->mem = request_mem_region(i2s->mem->start, resource_size(i2s->mem),
+				pdev->name);
+
+	if (!i2s->mem) {
+		ret = -EBUSY;
+		goto err_free;
+	}
+
+	i2s->base = ioremap_nocache(i2s->mem->start, resource_size(i2s->mem));
+
+	if (!i2s->base) {
+		ret = -EBUSY;
+		goto err_release_mem_region;
+	}
+
+	i2s->phys_base = i2s->mem->start;
+
+	i2s->clk_aic = clk_get(&pdev->dev, "aic");
+	if (IS_ERR(i2s->clk_aic)) {
+		ret = PTR_ERR(i2s->clk_aic);
+		goto err_iounmap;
+	}
+
+	i2s->clk_i2s = clk_get(&pdev->dev, "i2s");
+	if (IS_ERR(i2s->clk_i2s)) {
+		ret = PTR_ERR(i2s->clk_i2s);
+		goto err_iounmap;
+	}
+
+	clk_enable(i2s->clk_aic);
+
+	jz4740_i2c_init_pcm_config(i2s);
+
+	jz4740_i2s_dai.private_data = i2s;
+	ret = snd_soc_register_dai(&jz4740_i2s_dai);
+
+	platform_set_drvdata(pdev, i2s);
+
+	return 0;
+
+err_iounmap:
+	iounmap(i2s->base);
+err_release_mem_region:
+	release_mem_region(i2s->mem->start, resource_size(i2s->mem));
+err_free:
+	kfree(i2s);
+
+	return ret;
+}
+
+static int __devexit jz4740_i2s_dev_remove(struct platform_device *pdev)
+{
+	struct jz4740_i2s *i2s = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_dai(&jz4740_i2s_dai);
+
+	clk_disable(i2s->clk_aic);
+	clk_put(i2s->clk_i2s);
+	clk_put(i2s->clk_aic);
+
+	iounmap(i2s->base);
+	release_mem_region(i2s->mem->start, resource_size(i2s->mem));
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(i2s);
+
+	return 0;
+}
+
+static struct platform_driver jz4740_i2s_driver = {
+	.probe = jz4740_i2s_dev_probe,
+	.remove = __devexit_p(jz4740_i2s_dev_remove),
+	.driver = {
+		.name = "jz4740-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init jz4740_i2s_init(void)
+{
+	return platform_driver_register(&jz4740_i2s_driver);
+}
+module_init(jz4740_i2s_init);
+
+static void __exit jz4740_i2s_exit(void)
+{
+	platform_driver_unregister(&jz4740_i2s_driver);
+}
+module_exit(jz4740_i2s_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen, <lars@metafoo.de>");
+MODULE_DESCRIPTION("Ingenic JZ4740 SoC I2S driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:jz4740-i2s");
diff --git a/sound/soc/jz4740/jz4740-i2s.h b/sound/soc/jz4740/jz4740-i2s.h
new file mode 100644
index 0000000..da22ed8
--- /dev/null
+++ b/sound/soc/jz4740/jz4740-i2s.h
@@ -0,0 +1,18 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _JZ4740_I2S_H
+#define _JZ4740_I2S_H
+
+/* I2S clock source */
+#define JZ4740_I2S_CLKSRC_EXT 0
+#define JZ4740_I2S_CLKSRC_PLL 1
+
+#define JZ4740_I2S_BIT_CLK		0
+
+extern struct snd_soc_dai jz4740_i2s_dai;
+
+#endif
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
new file mode 100644
index 0000000..fd1c203
--- /dev/null
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -0,0 +1,350 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/mach-jz4740/dma.h>
+#include "jz4740-pcm.h"
+
+struct jz4740_runtime_data {
+	unsigned int dma_period;
+	dma_addr_t dma_start;
+	dma_addr_t dma_pos;
+	dma_addr_t dma_end;
+
+	struct jz4740_dma_chan *dma;
+
+	dma_addr_t fifo_addr;
+};
+
+/* identify hardware playback capabilities */
+static const struct snd_pcm_hardware jz4740_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8,
+
+	.rates			= SNDRV_PCM_RATE_8000_48000,
+	.channels_min		= 1,
+	.channels_max		= 2,
+	.period_bytes_min	= 16,
+	.period_bytes_max	= 2 * PAGE_SIZE,
+	.periods_min		= 2,
+	.periods_max		= 128,
+	.buffer_bytes_max	= 128 * 2 * PAGE_SIZE,
+	.fifo_size		= 32,
+};
+
+static void jz4740_pcm_start_transfer(struct jz4740_runtime_data *prtd, int stream)
+{
+	unsigned int count;
+
+	if (prtd->dma_pos + prtd->dma_period > prtd->dma_end)
+		count = prtd->dma_end - prtd->dma_pos;
+	else
+		count = prtd->dma_period;
+
+	jz4740_dma_disable(prtd->dma);
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		jz4740_dma_set_src_addr(prtd->dma, prtd->dma_pos);
+		jz4740_dma_set_dst_addr(prtd->dma, prtd->fifo_addr);
+	} else {
+		jz4740_dma_set_src_addr(prtd->dma, prtd->fifo_addr);
+		jz4740_dma_set_dst_addr(prtd->dma, prtd->dma_pos);
+	}
+
+	jz4740_dma_set_transfer_count(prtd->dma, count);
+
+	jz4740_dma_enable(prtd->dma);
+
+	prtd->dma_pos += prtd->dma_period;
+	if (prtd->dma_pos >= prtd->dma_end)
+		prtd->dma_pos = prtd->dma_start;
+}
+
+static void jz4740_pcm_dma_transfer_done(struct jz4740_dma_chan *dma, int err,
+	void *dev_id)
+{
+	struct snd_pcm_substream *substream = dev_id;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd = runtime->private_data;
+
+	snd_pcm_period_elapsed(substream);
+
+	jz4740_pcm_start_transfer(prtd, substream->stream);
+}
+
+static int jz4740_pcm_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd = runtime->private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct jz4740_pcm_config *config;
+
+	config = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	if (!prtd->dma) {
+		const char *dma_channel_name;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			dma_channel_name = "PCM Playback";
+		else
+			dma_channel_name = "PCM Capture";
+
+		prtd->dma = jz4740_dma_request(substream, dma_channel_name);
+	}
+
+	if (!prtd->dma)
+		return -EBUSY;
+
+	jz4740_dma_configure(prtd->dma, &config->dma_config);
+	prtd->fifo_addr = config->fifo_addr;
+
+	jz4740_dma_set_complete_cb(prtd->dma, jz4740_pcm_dma_transfer_done);
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = params_buffer_bytes(params);
+
+	prtd->dma_period = params_period_bytes(params);
+	prtd->dma_start = runtime->dma_addr;
+	prtd->dma_pos = prtd->dma_start;
+	prtd->dma_end = prtd->dma_start + runtime->dma_bytes;
+
+	return 0;
+}
+
+static int jz4740_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct jz4740_runtime_data *prtd = substream->runtime->private_data;
+
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	if (prtd->dma) {
+		jz4740_dma_free(prtd->dma);
+		prtd->dma = NULL;
+	}
+
+	return 0;
+}
+
+static int jz4740_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct jz4740_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	if (!prtd->dma)
+			return 0;
+
+	prtd->dma_pos = prtd->dma_start;
+
+	return ret;
+}
+
+static int jz4740_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd = runtime->private_data;
+
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		jz4740_pcm_start_transfer(prtd, substream->stream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		jz4740_dma_disable(prtd->dma);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t jz4740_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd = runtime->private_data;
+	unsigned long count, pos;
+	snd_pcm_uframes_t offset;
+	struct jz4740_dma_chan *dma = prtd->dma;
+
+	count = jz4740_dma_get_residue(dma);
+	if (prtd->dma_pos == prtd->dma_start)
+		pos = prtd->dma_end - prtd->dma_start - count;
+	else
+		pos = prtd->dma_pos - prtd->dma_start - count;
+
+	offset = bytes_to_frames(runtime, pos);
+	if (offset >= runtime->buffer_size)
+		offset = 0;
+
+	return offset;
+}
+
+static int jz4740_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd;
+
+	snd_soc_set_runtime_hwparams(substream, &jz4740_pcm_hardware);
+	prtd = kzalloc(sizeof(struct jz4740_runtime_data), GFP_KERNEL);
+
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	runtime->private_data = prtd;
+	return 0;
+}
+
+static int jz4740_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct jz4740_runtime_data *prtd = runtime->private_data;
+
+	kfree(prtd);
+
+	return 0;
+}
+
+static int jz4740_pcm_mmap(struct snd_pcm_substream *substream,
+	struct vm_area_struct *vma)
+{
+	return remap_pfn_range(vma, vma->vm_start,
+			substream->dma_buffer.addr >> PAGE_SHIFT,
+			vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+static struct snd_pcm_ops jz4740_pcm_ops = {
+	.open		= jz4740_pcm_open,
+	.close		= jz4740_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= jz4740_pcm_hw_params,
+	.hw_free	= jz4740_pcm_hw_free,
+	.prepare	= jz4740_pcm_prepare,
+	.trigger	= jz4740_pcm_trigger,
+	.pointer	= jz4740_pcm_pointer,
+	.mmap		= jz4740_pcm_mmap,
+};
+
+static int jz4740_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = jz4740_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+
+	buf->area = dma_alloc_noncoherent(pcm->card->dev, size,
+					  &buf->addr, GFP_KERNEL);
+	if (!buf->area)
+		return -ENOMEM;
+
+	buf->bytes = size;
+
+	return 0;
+}
+
+static void jz4740_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_noncoherent(pcm->card->dev, buf->bytes,
+		  buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static u64 jz4740_pcm_dmamask = DMA_BIT_MASK(32);
+
+int jz4740_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+	struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &jz4740_pcm_dmamask;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	if (dai->playback.channels_min) {
+		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			goto err;
+	}
+
+	if (dai->capture.channels_min) {
+		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
+			SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			goto err;
+	}
+
+err:
+	return ret;
+}
+
+struct snd_soc_platform jz4740_soc_platform = {
+		.name		= "jz4740-pcm",
+		.pcm_ops	= &jz4740_pcm_ops,
+		.pcm_new	= jz4740_pcm_new,
+		.pcm_free	= jz4740_pcm_free,
+};
+EXPORT_SYMBOL_GPL(jz4740_soc_platform);
+
+static int __init jz4740_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&jz4740_soc_platform);
+}
+module_init(jz4740_soc_platform_init);
+
+static void __exit jz4740_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&jz4740_soc_platform);
+}
+module_exit(jz4740_soc_platform_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Ingenic SoC JZ4740 PCM driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/jz4740/jz4740-pcm.h b/sound/soc/jz4740/jz4740-pcm.h
new file mode 100644
index 0000000..e3f221e
--- /dev/null
+++ b/sound/soc/jz4740/jz4740-pcm.h
@@ -0,0 +1,22 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _JZ4740_PCM_H
+#define _JZ4740_PCM_H
+
+#include <linux/dma-mapping.h>
+#include <asm/mach-jz4740/dma.h>
+
+/* platform data */
+extern struct snd_soc_platform jz4740_soc_platform;
+
+struct jz4740_pcm_config {
+	struct jz4740_dma_config dma_config;
+	phys_addr_t fifo_addr;
+};
+
+#endif
-- 
1.5.6.5
