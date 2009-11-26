Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:15:21 +0100 (CET)
Received: from cantor.suse.de ([195.135.220.2]:40123 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493717AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 15BEA90847;
        Thu, 26 Nov 2009 16:13:44 +0100 (CET)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: Remove old DMA-mmap code from arm/devdma.c
Date:   Thu, 26 Nov 2009 16:13:08 +0100
Message-Id: <1259248388-20095-6-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259248388-20095-5-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
 <1259248388-20095-2-git-send-email-tiwai@suse.de>
 <1259248388-20095-3-git-send-email-tiwai@suse.de>
 <1259248388-20095-4-git-send-email-tiwai@suse.de>
 <1259248388-20095-5-git-send-email-tiwai@suse.de>
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

The call of dma_mmap_coherent() is done in the PCM core now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/arm/Makefile |    2 +-
 sound/arm/aaci.c   |   16 +++-------
 sound/arm/devdma.c |   80 ----------------------------------------------------
 sound/arm/devdma.h |    3 --
 4 files changed, 6 insertions(+), 95 deletions(-)
 delete mode 100644 sound/arm/devdma.c
 delete mode 100644 sound/arm/devdma.h

diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 5a549ed..8c0c851 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-$(CONFIG_SND_ARMAACI)	+= snd-aaci.o
-snd-aaci-objs			:= aaci.o devdma.o
+snd-aaci-objs			:= aaci.o
 
 obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
 snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 1f0f821..e593728 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -30,7 +30,6 @@
 #include <sound/pcm_params.h>
 
 #include "aaci.h"
-#include "devdma.h"
 
 #define DRIVER_NAME	"aaci-pl041"
 
@@ -492,7 +491,7 @@ static int aaci_pcm_hw_free(struct snd_pcm_substream *substream)
 	/*
 	 * Clear out the DMA and any allocated buffers.
 	 */
-	devdma_hw_free(NULL, substream);
+	snd_pcm_lib_free_pages(substream);
 
 	return 0;
 }
@@ -505,8 +504,8 @@ static int aaci_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	aaci_pcm_hw_free(substream);
 
-	err = devdma_hw_alloc(NULL, substream,
-			      params_buffer_bytes(params));
+	err = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(params));
 	if (err < 0)
 		goto out;
 
@@ -551,11 +550,6 @@ static snd_pcm_uframes_t aaci_pcm_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(runtime, bytes);
 }
 
-static int aaci_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct *vma)
-{
-	return devdma_mmap(NULL, substream, vma);
-}
-
 
 /*
  * Playback specific ALSA stuff
@@ -722,7 +716,6 @@ static struct snd_pcm_ops aaci_playback_ops = {
 	.prepare	= aaci_pcm_prepare,
 	.trigger	= aaci_pcm_playback_trigger,
 	.pointer	= aaci_pcm_pointer,
-	.mmap		= aaci_pcm_mmap,
 };
 
 static int aaci_pcm_capture_hw_params(struct snd_pcm_substream *substream,
@@ -850,7 +843,6 @@ static struct snd_pcm_ops aaci_capture_ops = {
 	.prepare	= aaci_pcm_capture_prepare,
 	.trigger	= aaci_pcm_capture_trigger,
 	.pointer	= aaci_pcm_pointer,
-	.mmap		= aaci_pcm_mmap,
 };
 
 /*
@@ -1040,6 +1032,8 @@ static int __devinit aaci_init_pcm(struct aaci *aaci)
 
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &aaci_playback_ops);
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &aaci_capture_ops);
+		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+						      NULL, 0, 64 * 104);
 	}
 
 	return ret;
diff --git a/sound/arm/devdma.c b/sound/arm/devdma.c
deleted file mode 100644
index 9d1e666..0000000
--- a/sound/arm/devdma.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *  linux/sound/arm/devdma.c
- *
- *  Copyright (C) 2003-2004 Russell King, All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  ARM DMA shim for ALSA.
- */
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-
-#include "devdma.h"
-
-void devdma_hw_free(struct device *dev, struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
-
-	if (runtime->dma_area == NULL)
-		return;
-
-	if (buf != &substream->dma_buffer) {
-		dma_free_coherent(buf->dev.dev, buf->bytes, buf->area, buf->addr);
-		kfree(runtime->dma_buffer_p);
-	}
-
-	snd_pcm_set_runtime_buffer(substream, NULL);
-}
-
-int devdma_hw_alloc(struct device *dev, struct snd_pcm_substream *substream, size_t size)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
-	int ret = 0;
-
-	if (buf) {
-		if (buf->bytes >= size)
-			goto out;
-		devdma_hw_free(dev, substream);
-	}
-
-	if (substream->dma_buffer.area != NULL && substream->dma_buffer.bytes >= size) {
-		buf = &substream->dma_buffer;
-	} else {
-		buf = kmalloc(sizeof(struct snd_dma_buffer), GFP_KERNEL);
-		if (!buf)
-			goto nomem;
-
-		buf->dev.type = SNDRV_DMA_TYPE_DEV;
-		buf->dev.dev = dev;
-		buf->area = dma_alloc_coherent(dev, size, &buf->addr, GFP_KERNEL);
-		buf->bytes = size;
-		buf->private_data = NULL;
-
-		if (!buf->area)
-			goto free;
-	}
-	snd_pcm_set_runtime_buffer(substream, buf);
-	ret = 1;
- out:
-	runtime->dma_bytes = size;
-	return ret;
-
- free:
-	kfree(buf);
- nomem:
-	return -ENOMEM;
-}
-
-int devdma_mmap(struct device *dev, struct snd_pcm_substream *substream, struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	return dma_mmap_coherent(dev, vma, runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
-}
diff --git a/sound/arm/devdma.h b/sound/arm/devdma.h
deleted file mode 100644
index d025329..0000000
--- a/sound/arm/devdma.h
+++ /dev/null
@@ -1,3 +0,0 @@
-void devdma_hw_free(struct device *dev, struct snd_pcm_substream *substream);
-int devdma_hw_alloc(struct device *dev, struct snd_pcm_substream *substream, size_t size);
-int devdma_mmap(struct device *dev, struct snd_pcm_substream *substream, struct vm_area_struct *vma);
-- 
1.6.5.3
