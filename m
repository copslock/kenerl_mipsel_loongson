Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:47:58 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:62371 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491145Ab1GYLpM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jul 2011 13:45:12 +0200
Received: by mail-fx0-f49.google.com with SMTP id 20so6754283fxd.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jul 2011 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0dO3pEQ9seanKOpkpvYvnWnptghAvjfI/RNl54jrmjw=;
        b=dVGWBRrmCjhX7ul0D8ZY186al7WH9fCFZl1bWr1W/zIo+B+PnLa1aYq9YaQC1o85pD
         fPmwa78Ke5eh7NjAI+5S5U9/HJyT92ImTvmiD6zbSYnkuaBYqQhxs2KfzvpIGG1Y3JhP
         GDYgc+PJ/nAXAgo7RkWFPfVPGzD4TH+GOF4GU=
Received: by 10.223.143.18 with SMTP id s18mr4866282fau.134.1311594311783;
        Mon, 25 Jul 2011 04:45:11 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-52.adsl.highway.telekom.at [188.22.157.52])
        by mx.google.com with ESMTPS id 9sm3744387far.37.2011.07.25.04.45.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 04:45:11 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     alsa-devel@vger.kernel.org,
        Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     Liam Girdwood <lrg@ti.com>, Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH V2 3/3] ASoC: au1x: use substream stream info directly
Date:   Mon, 25 Jul 2011 13:45:04 +0200
Message-Id: <1311594304-31605-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311594304-31605-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17615

PCM_TX/RX are the same as SNDRV_PCM_STREAM_PLAYBACK/CAPTURE.  Use
them directly.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
V2: new patch based on feedback from Liam Girdwood.

 sound/soc/au1x/dbdma2.c   |   10 +++++-----
 sound/soc/au1x/psc-ac97.c |   18 +++++++++---------
 sound/soc/au1x/psc-i2s.c  |   14 +++++++-------
 sound/soc/au1x/psc.h      |    6 ------
 4 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index fd5378f..d7d04e2 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -169,7 +169,7 @@ static int au1x_pcm_dbdma_realloc(struct au1xpsc_audio_dmadata *pcd,
 
 	au1x_pcm_dbdma_free(pcd);
 
-	if (stype == PCM_RX)
+	if (stype == SNDRV_PCM_STREAM_CAPTURE)
 		pcd->ddma_chan = au1xxx_dbdma_chan_alloc(pcd->ddma_id,
 					DSCR_CMD0_ALWAYS,
 					au1x_pcm_dmarx_cb, (void *)pcd);
@@ -198,7 +198,7 @@ static inline struct au1xpsc_audio_dmadata *to_dmadata(struct snd_pcm_substream
 	struct snd_soc_pcm_runtime *rtd = ss->private_data;
 	struct au1xpsc_audio_dmadata *pcd =
 				snd_soc_platform_get_drvdata(rtd->platform);
-	return &pcd[SUBSTREAM_TYPE(ss)];
+	return &pcd[ss->stream];
 }
 
 static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -212,7 +212,7 @@ static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		goto out;
 
-	stype = SUBSTREAM_TYPE(substream);
+	stype = substream->stream;
 	pcd = to_dmadata(substream);
 
 	DBG("runtime->dma_area = 0x%08lx dma_addr_t = 0x%08lx dma_size = %d "
@@ -255,7 +255,7 @@ static int au1xpsc_pcm_prepare(struct snd_pcm_substream *substream)
 
 	au1xxx_dbdma_reset(pcd->ddma_chan);
 
-	if (SUBSTREAM_TYPE(substream) == PCM_RX) {
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		au1x_pcm_queue_rx(pcd);
 		au1x_pcm_queue_rx(pcd);
 	} else {
@@ -295,7 +295,7 @@ static int au1xpsc_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct au1xpsc_audio_dmadata *pcd = to_dmadata(substream);
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int stype = SUBSTREAM_TYPE(substream), *dmaids;
+	int stype = substream->stream, *dmaids;
 
 	dmaids = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 	if (!dmaids)
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 44296ab..172eefd 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -41,14 +41,14 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3BE)
 
 #define AC97PCR_START(stype)	\
-	((stype) == PCM_TX ? PSC_AC97PCR_TS : PSC_AC97PCR_RS)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_AC97PCR_TS : PSC_AC97PCR_RS)
 #define AC97PCR_STOP(stype)	\
-	((stype) == PCM_TX ? PSC_AC97PCR_TP : PSC_AC97PCR_RP)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_AC97PCR_TP : PSC_AC97PCR_RP)
 #define AC97PCR_CLRFIFO(stype)	\
-	((stype) == PCM_TX ? PSC_AC97PCR_TC : PSC_AC97PCR_RC)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_AC97PCR_TC : PSC_AC97PCR_RC)
 
 #define AC97STAT_BUSY(stype)	\
-	((stype) == PCM_TX ? PSC_AC97STAT_TB : PSC_AC97STAT_RB)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_AC97STAT_TB : PSC_AC97STAT_RB)
 
 /* instance data. There can be only one, MacLeod!!!! */
 static struct au1xpsc_audio_data *au1xpsc_ac97_workdata;
@@ -215,7 +215,7 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 {
 	struct au1xpsc_audio_data *pscdata = snd_soc_dai_get_drvdata(dai);
 	unsigned long r, ro, stat;
-	int chans, t, stype = SUBSTREAM_TYPE(substream);
+	int chans, t, stype = substream->stream;
 
 	chans = params_channels(params);
 
@@ -235,7 +235,7 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 		r |= PSC_AC97CFG_SET_LEN(params->msbits);
 
 		/* channels: enable slots for front L/R channel */
-		if (stype == PCM_TX) {
+		if (stype == SNDRV_PCM_STREAM_PLAYBACK) {
 			r &= ~PSC_AC97CFG_TXSLOT_MASK;
 			r |= PSC_AC97CFG_TXSLOT_ENA(3);
 			r |= PSC_AC97CFG_TXSLOT_ENA(4);
@@ -294,7 +294,7 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct au1xpsc_audio_data *pscdata = snd_soc_dai_get_drvdata(dai);
-	int ret, stype = SUBSTREAM_TYPE(substream);
+	int ret, stype = substream->stream;
 
 	ret = 0;
 
@@ -391,12 +391,12 @@ static int __devinit au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!r)
 		goto out2;
-	wd->dmaids[PCM_TX] = r->start;
+	wd->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r->start;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!r)
 		goto out2;
-	wd->dmaids[PCM_RX] = r->start;
+	wd->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r->start;
 
 	/* configuration: max dma trigger threshold, enable ac97 */
 	wd->cfg = PSC_AC97CFG_RT_FIFO8 | PSC_AC97CFG_TT_FIFO8 |
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 1b7ab5d..7c5ae92 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -42,13 +42,13 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
 #define I2SSTAT_BUSY(stype)	\
-	((stype) == PCM_TX ? PSC_I2SSTAT_TB : PSC_I2SSTAT_RB)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_I2SSTAT_TB : PSC_I2SSTAT_RB)
 #define I2SPCR_START(stype)	\
-	((stype) == PCM_TX ? PSC_I2SPCR_TS : PSC_I2SPCR_RS)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_I2SPCR_TS : PSC_I2SPCR_RS)
 #define I2SPCR_STOP(stype)	\
-	((stype) == PCM_TX ? PSC_I2SPCR_TP : PSC_I2SPCR_RP)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_I2SPCR_TP : PSC_I2SPCR_RP)
 #define I2SPCR_CLRFIFO(stype)	\
-	((stype) == PCM_TX ? PSC_I2SPCR_TC : PSC_I2SPCR_RC)
+	((stype) == SNDRV_PCM_STREAM_PLAYBACK ? PSC_I2SPCR_TC : PSC_I2SPCR_RC)
 
 
 static int au1xpsc_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
@@ -240,7 +240,7 @@ static int au1xpsc_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	struct au1xpsc_audio_data *pscdata = snd_soc_dai_get_drvdata(dai);
-	int ret, stype = SUBSTREAM_TYPE(substream);
+	int ret, stype = substream->stream;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -316,12 +316,12 @@ static int __devinit au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!r)
 		goto out2;
-	wd->dmaids[PCM_TX] = r->start;
+	wd->dmaids[SNDRV_PCM_STREAM_PLAYBACK] = r->start;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!r)
 		goto out2;
-	wd->dmaids[PCM_RX] = r->start;
+	wd->dmaids[SNDRV_PCM_STREAM_CAPTURE] = r->start;
 
 	/* preserve PSC clock source set up by platform (dev.platform_data
 	 * is already occupied by soc layer)
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 1b21c4f..b16b2e0 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -13,12 +13,6 @@
 #ifndef _AU1X_PCM_H
 #define _AU1X_PCM_H
 
-#define PCM_TX	0
-#define PCM_RX	1
-
-#define SUBSTREAM_TYPE(substream) \
-	((substream)->stream == SNDRV_PCM_STREAM_PLAYBACK ? PCM_TX : PCM_RX)
-
 struct au1xpsc_audio_data {
 	void __iomem *mmio;
 
-- 
1.7.6
