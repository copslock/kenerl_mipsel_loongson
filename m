Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 18:24:42 +0200 (CEST)
Received: from smtp-out-016.synserver.de ([212.40.185.16]:1270 "EHLO
        smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834995Ab3E3QWRQEM-1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 18:22:17 +0200
Received: (qmail 26899 invoked by uid 0); 30 May 2013 16:22:09 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 26279
Received: from ppp-188-174-155-156.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [188.174.155.156]
  by 217.119.54.73 with SMTP; 30 May 2013 16:22:08 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/6] ASoC: jz4740: Use the generic dmaengine PCM driver
Date:   Thu, 30 May 2013 18:25:04 +0200
Message-Id: <1369931105-28065-6-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1369931105-28065-1-git-send-email-lars@metafoo.de>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Since there is a dmaengine driver for the jz4740 DMA controller now we can use
the generic dmaengine PCM driver instead of a custom one.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
No changes since v1
---
 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c |  48 +++----
 sound/soc/jz4740/jz4740-pcm.c | 310 ++----------------------------------------
 sound/soc/jz4740/jz4740-pcm.h |  20 ---
 4 files changed, 27 insertions(+), 352 deletions(-)
 delete mode 100644 sound/soc/jz4740/jz4740-pcm.h

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 5351cba..29f76af 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,6 +1,7 @@
 config SND_JZ4740_SOC
 	tristate "SoC Audio for Ingenic JZ4740 SoC"
 	depends on MACH_JZ4740 && SND_SOC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the JZ4740 I2S interface. You will also need to select the audio
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 4c849a4..47d3b4c 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -29,9 +29,12 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
+#include <sound/dmaengine_pcm.h>
+
+#include <asm/mach-jz4740/dma.h>
 
 #include "jz4740-i2s.h"
-#include "jz4740-pcm.h"
+
 
 #define JZ_REG_AIC_CONF		0x00
 #define JZ_REG_AIC_CTRL		0x04
@@ -89,8 +92,8 @@ struct jz4740_i2s {
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
 
-	struct jz4740_pcm_config pcm_config_playback;
-	struct jz4740_pcm_config pcm_config_capture;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
 };
 
 static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
@@ -233,8 +236,6 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	enum jz4740_dma_width dma_width;
-	struct jz4740_pcm_config *pcm_config;
 	unsigned int sample_size;
 	uint32_t ctrl;
 
@@ -243,11 +244,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
-		dma_width = JZ4740_DMA_WIDTH_8BIT;
 		break;
 	case SNDRV_PCM_FORMAT_S16:
 		sample_size = 1;
-		dma_width = JZ4740_DMA_WIDTH_16BIT;
 		break;
 	default:
 		return -EINVAL;
@@ -260,22 +259,13 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
-
-		pcm_config = &i2s->pcm_config_playback;
-		pcm_config->dma_config.dst_width = dma_width;
-
 	} else {
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
-
-		pcm_config = &i2s->pcm_config_capture;
-		pcm_config->dma_config.src_width = dma_width;
 	}
 
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 
-	snd_soc_dai_set_dma_data(dai, substream, pcm_config);
-
 	return 0;
 }
 
@@ -342,25 +332,19 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 
 static void jz4740_i2c_init_pcm_config(struct jz4740_i2s *i2s)
 {
-	struct jz4740_dma_config *dma_config;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 
 	/* Playback */
-	dma_config = &i2s->pcm_config_playback.dma_config;
-	dma_config->src_width = JZ4740_DMA_WIDTH_32BIT;
-	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
-	dma_config->request_type = JZ4740_DMA_TYPE_AIC_TRANSMIT;
-	dma_config->flags = JZ4740_DMA_SRC_AUTOINC;
-	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
-	i2s->pcm_config_playback.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+	dma_data = &i2s->playback_dma_data;
+	dma_data->maxburst = 16;
+	dma_data->slave_id = JZ4740_DMA_TYPE_AIC_TRANSMIT;
+	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
 
 	/* Capture */
-	dma_config = &i2s->pcm_config_capture.dma_config;
-	dma_config->dst_width = JZ4740_DMA_WIDTH_32BIT;
-	dma_config->transfer_size = JZ4740_DMA_TRANSFER_SIZE_16BYTE;
-	dma_config->request_type = JZ4740_DMA_TYPE_AIC_RECEIVE;
-	dma_config->flags = JZ4740_DMA_DST_AUTOINC;
-	dma_config->mode = JZ4740_DMA_MODE_SINGLE;
-	i2s->pcm_config_capture.fifo_addr = i2s->phys_base + JZ_REG_AIC_FIFO;
+	dma_data = &i2s->capture_dma_data;
+	dma_data->maxburst = 16;
+	dma_data->slave_id = JZ4740_DMA_TYPE_AIC_RECEIVE;
+	dma_data->addr = i2s->phys_base + JZ_REG_AIC_FIFO;
 }
 
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
@@ -371,6 +355,8 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	clk_prepare_enable(i2s->clk_aic);
 
 	jz4740_i2c_init_pcm_config(i2s);
+	dai->playback_dma_data = &i2s->playback_dma_data;
+	dai->capture_dma_data = &i2s->capture_dma_data;
 
 	conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
 		(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index 7100592..79fcade 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -19,38 +19,14 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <linux/dma-mapping.h>
+#include <sound/dmaengine_pcm.h>
 
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-
-#include <asm/mach-jz4740/dma.h>
-#include "jz4740-pcm.h"
-
-struct jz4740_runtime_data {
-	unsigned long dma_period;
-	dma_addr_t dma_start;
-	dma_addr_t dma_pos;
-	dma_addr_t dma_end;
-
-	struct jz4740_dma_chan *dma;
-
-	dma_addr_t fifo_addr;
-};
-
-/* identify hardware playback capabilities */
 static const struct snd_pcm_hardware jz4740_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8,
-
-	.rates			= SNDRV_PCM_RATE_8000_48000,
-	.channels_min		= 1,
-	.channels_max		= 2,
 	.period_bytes_min	= 16,
 	.period_bytes_max	= 2 * PAGE_SIZE,
 	.periods_min		= 2,
@@ -59,290 +35,22 @@ static const struct snd_pcm_hardware jz4740_pcm_hardware = {
 	.fifo_size		= 32,
 };
 
-static void jz4740_pcm_start_transfer(struct jz4740_runtime_data *prtd,
-	struct snd_pcm_substream *substream)
-{
-	unsigned long count;
-
-	if (prtd->dma_pos == prtd->dma_end)
-		prtd->dma_pos = prtd->dma_start;
-
-	if (prtd->dma_pos + prtd->dma_period > prtd->dma_end)
-		count = prtd->dma_end - prtd->dma_pos;
-	else
-		count = prtd->dma_period;
-
-	jz4740_dma_disable(prtd->dma);
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		jz4740_dma_set_src_addr(prtd->dma, prtd->dma_pos);
-		jz4740_dma_set_dst_addr(prtd->dma, prtd->fifo_addr);
-	} else {
-		jz4740_dma_set_src_addr(prtd->dma, prtd->fifo_addr);
-		jz4740_dma_set_dst_addr(prtd->dma, prtd->dma_pos);
-	}
-
-	jz4740_dma_set_transfer_count(prtd->dma, count);
-
-	prtd->dma_pos += count;
-
-	jz4740_dma_enable(prtd->dma);
-}
-
-static void jz4740_pcm_dma_transfer_done(struct jz4740_dma_chan *dma, int err,
-	void *dev_id)
-{
-	struct snd_pcm_substream *substream = dev_id;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd = runtime->private_data;
-
-	snd_pcm_period_elapsed(substream);
-
-	jz4740_pcm_start_transfer(prtd, substream);
-}
-
-static int jz4740_pcm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd = runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct jz4740_pcm_config *config;
-
-	config = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	if (!config)
-		return 0;
-
-	if (!prtd->dma) {
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			prtd->dma = jz4740_dma_request(substream, "PCM Capture");
-		else
-			prtd->dma = jz4740_dma_request(substream, "PCM Playback");
-	}
-
-	if (!prtd->dma)
-		return -EBUSY;
-
-	jz4740_dma_configure(prtd->dma, &config->dma_config);
-	prtd->fifo_addr = config->fifo_addr;
-
-	jz4740_dma_set_complete_cb(prtd->dma, jz4740_pcm_dma_transfer_done);
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-	runtime->dma_bytes = params_buffer_bytes(params);
-
-	prtd->dma_period = params_period_bytes(params);
-	prtd->dma_start = runtime->dma_addr;
-	prtd->dma_pos = prtd->dma_start;
-	prtd->dma_end = prtd->dma_start + runtime->dma_bytes;
-
-	return 0;
-}
-
-static int jz4740_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct jz4740_runtime_data *prtd = substream->runtime->private_data;
-
-	snd_pcm_set_runtime_buffer(substream, NULL);
-	if (prtd->dma) {
-		jz4740_dma_free(prtd->dma);
-		prtd->dma = NULL;
-	}
-
-	return 0;
-}
-
-static int jz4740_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	struct jz4740_runtime_data *prtd = substream->runtime->private_data;
-
-	if (!prtd->dma)
-		return -EBUSY;
-
-	prtd->dma_pos = prtd->dma_start;
-
-	return 0;
-}
-
-static int jz4740_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd = runtime->private_data;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		jz4740_pcm_start_transfer(prtd, substream);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		jz4740_dma_disable(prtd->dma);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static snd_pcm_uframes_t jz4740_pcm_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd = runtime->private_data;
-	unsigned long byte_offset;
-	snd_pcm_uframes_t offset;
-	struct jz4740_dma_chan *dma = prtd->dma;
-
-	/* prtd->dma_pos points to the end of the current transfer. So by
-	 * subtracting prdt->dma_start we get the offset to the end of the
-	 * current period in bytes. By subtracting the residue of the transfer
-	 * we get the current offset in bytes. */
-	byte_offset = prtd->dma_pos - prtd->dma_start;
-	byte_offset -= jz4740_dma_get_residue(dma);
-
-	offset = bytes_to_frames(runtime, byte_offset);
-	if (offset >= runtime->buffer_size)
-		offset = 0;
-
-	return offset;
-}
-
-static int jz4740_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd;
-
-	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
-	if (prtd == NULL)
-		return -ENOMEM;
-
-	snd_soc_set_runtime_hwparams(substream, &jz4740_pcm_hardware);
-
-	runtime->private_data = prtd;
-
-	return 0;
-}
-
-static int jz4740_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct jz4740_runtime_data *prtd = runtime->private_data;
-
-	kfree(prtd);
-
-	return 0;
-}
-
-static int jz4740_pcm_mmap(struct snd_pcm_substream *substream,
-	struct vm_area_struct *vma)
-{
-	return remap_pfn_range(vma, vma->vm_start,
-			substream->dma_buffer.addr >> PAGE_SHIFT,
-			vma->vm_end - vma->vm_start, vma->vm_page_prot);
-}
-
-static struct snd_pcm_ops jz4740_pcm_ops = {
-	.open		= jz4740_pcm_open,
-	.close		= jz4740_pcm_close,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= jz4740_pcm_hw_params,
-	.hw_free	= jz4740_pcm_hw_free,
-	.prepare	= jz4740_pcm_prepare,
-	.trigger	= jz4740_pcm_trigger,
-	.pointer	= jz4740_pcm_pointer,
-	.mmap		= jz4740_pcm_mmap,
-};
-
-static int jz4740_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
-{
-	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = jz4740_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = pcm->card->dev;
-	buf->private_data = NULL;
-
-	buf->area = dma_alloc_noncoherent(pcm->card->dev, size,
-					  &buf->addr, GFP_KERNEL);
-	if (!buf->area)
-		return -ENOMEM;
-
-	buf->bytes = size;
-
-	return 0;
-}
-
-static void jz4740_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_pcm_substream *substream;
-	struct snd_dma_buffer *buf;
-	int stream;
-
-	for (stream = 0; stream < SNDRV_PCM_STREAM_LAST; ++stream) {
-		substream = pcm->streams[stream].substream;
-		if (!substream)
-			continue;
-
-		buf = &substream->dma_buffer;
-		if (!buf->area)
-			continue;
-
-		dma_free_noncoherent(pcm->card->dev, buf->bytes, buf->area,
-				buf->addr);
-		buf->area = NULL;
-	}
-}
-
-static u64 jz4740_pcm_dmamask = DMA_BIT_MASK(32);
-
-static int jz4740_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_card *card = rtd->card->snd_card;
-	struct snd_pcm *pcm = rtd->pcm;
-	int ret = 0;
-
-	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &jz4740_pcm_dmamask;
-
-	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream) {
-		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret)
-			goto err;
-	}
-
-	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = jz4740_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
-		if (ret)
-			goto err;
-	}
-
-err:
-	return ret;
-}
-
-static struct snd_soc_platform_driver jz4740_soc_platform = {
-		.ops		= &jz4740_pcm_ops,
-		.pcm_new	= jz4740_pcm_new,
-		.pcm_free	= jz4740_pcm_free,
+static const struct snd_dmaengine_pcm_config jz4740_dmaengine_pcm_config = {
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.pcm_hardware = &jz4740_pcm_hardware,
+	.prealloc_buffer_size = 256 * PAGE_SIZE,
 };
 
 static int jz4740_pcm_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &jz4740_soc_platform);
+	return snd_dmaengine_pcm_register(&pdev->dev,
+		&jz4740_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 
 static int jz4740_pcm_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/jz4740/jz4740-pcm.h b/sound/soc/jz4740/jz4740-pcm.h
deleted file mode 100644
index 1220cbb..0000000
--- a/sound/soc/jz4740/jz4740-pcm.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _JZ4740_PCM_H
-#define _JZ4740_PCM_H
-
-#include <linux/dma-mapping.h>
-#include <asm/mach-jz4740/dma.h>
-
-
-struct jz4740_pcm_config {
-	struct jz4740_dma_config dma_config;
-	phys_addr_t fifo_addr;
-};
-
-#endif
-- 
1.8.2.1
