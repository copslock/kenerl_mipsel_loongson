Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:14:11 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:36324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493715AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id F17C3867E2;
        Thu, 26 Nov 2009 16:13:43 +0100 (CET)
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
Subject: [PATCH 1/5] ALSA: pcm - Use dma_mmap_coherent() if available
Date:   Thu, 26 Nov 2009 16:13:04 +0100
Message-Id: <1259248388-20095-2-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259248388-20095-1-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

Use dma_mmap_coherent() for mmapping the buffers allocated via
dma_alloc_coherent() if available.  Currently, only ARM has this function,
so we do temporarily have an ifdef pcm_native.c.  This should be handled
better globally in future.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |   49 +++++++++++++++++++++++++++++++---------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ab73edf..f067c5b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -26,6 +26,7 @@
 #include <linux/time.h>
 #include <linux/pm_qos_params.h>
 #include <linux/uio.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
@@ -3094,23 +3095,42 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	return 0;
 }
 
-static const struct vm_operations_struct snd_pcm_vm_ops_data =
-{
+static const struct vm_operations_struct snd_pcm_vm_ops_data = {
+	.open =		snd_pcm_mmap_data_open,
+	.close =	snd_pcm_mmap_data_close,
+};
+
+static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 	.open =		snd_pcm_mmap_data_open,
 	.close =	snd_pcm_mmap_data_close,
 	.fault =	snd_pcm_mmap_data_fault,
 };
 
+#ifndef ARCH_HAS_DMA_MMAP_COHERENT
+/* This should be defined / handled globally! */
+#ifdef CONFIG_ARM
+#define ARCH_HAS_DMA_MMAP_COHERENT
+#endif
+#endif
+
 /*
  * mmap the DMA buffer on RAM
  */
 static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
 				struct vm_area_struct *area)
 {
-	area->vm_ops = &snd_pcm_vm_ops_data;
-	area->vm_private_data = substream;
 	area->vm_flags |= VM_RESERVED;
-	atomic_inc(&substream->mmap_count);
+#ifdef ARCH_HAS_DMA_MMAP_COHERENT
+	if (!substream->ops->page &&
+	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
+					 area,
+					 substream->runtime->dma_area,
+					 substream->runtime->dma_addr,
+					 area->vm_end - area->vm_start);
+#endif /* ARCH_HAS_DMA_MMAP_COHERENT */
+	/* mmap with fault handler */
+	area->vm_ops = &snd_pcm_vm_ops_data_fault;
 	return 0;
 }
 
@@ -3118,12 +3138,6 @@ static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
  * mmap the DMA buffer on I/O memory area
  */
 #if SNDRV_PCM_INFO_MMAP_IOMEM
-static const struct vm_operations_struct snd_pcm_vm_ops_data_mmio =
-{
-	.open =		snd_pcm_mmap_data_open,
-	.close =	snd_pcm_mmap_data_close,
-};
-
 int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
 			   struct vm_area_struct *area)
 {
@@ -3133,8 +3147,6 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
 #ifdef pgprot_noncached
 	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
 #endif
-	area->vm_ops = &snd_pcm_vm_ops_data_mmio;
-	area->vm_private_data = substream;
 	area->vm_flags |= VM_IO;
 	size = area->vm_end - area->vm_start;
 	offset = area->vm_pgoff << PAGE_SHIFT;
@@ -3142,7 +3154,6 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
 				(substream->runtime->dma_addr + offset) >> PAGE_SHIFT,
 				size, area->vm_page_prot))
 		return -EAGAIN;
-	atomic_inc(&substream->mmap_count);
 	return 0;
 }
 
@@ -3159,6 +3170,7 @@ int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file,
 	long size;
 	unsigned long offset;
 	size_t dma_bytes;
+	int err;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (!(area->vm_flags & (VM_WRITE|VM_READ)))
@@ -3183,10 +3195,15 @@ int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file,
 	if (offset > dma_bytes - size)
 		return -EINVAL;
 
+	area->vm_ops = &snd_pcm_vm_ops_data;
+	area->vm_private_data = substream;
 	if (substream->ops->mmap)
-		return substream->ops->mmap(substream, area);
+		err = substream->ops->mmap(substream, area);
 	else
-		return snd_pcm_default_mmap(substream, area);
+		err = snd_pcm_default_mmap(substream, area);
+	if (!err)
+		atomic_inc(&substream->mmap_count);
+	return err;
 }
 
 EXPORT_SYMBOL(snd_pcm_mmap_data);
-- 
1.6.5.3
