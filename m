From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 26 Nov 2009 15:04:24 +0100
Subject: [PATCH] ALSA: pcm - fix page conversion on non-coherent PPC arch
Message-ID: <20091126140424.Z2Tsnyh9vf2lM95AT0KfYRDpzQykP8YPDkn8m5APXSs@z>

The non-cohernet PPC arch doesn't give the correct address by a simple
virt_to_page() for pages allocated via dma_alloc_coherent().
This patch adds a hack to fix the conversion similarly like MIPS.

Note that this doesn't fix perfectly: the pages should be marked with
proper pgprot value.  This will be done in a future implementation like
the conversion to dma_mmap_coherent().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index e48c5f6..29ab46a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3070,6 +3070,16 @@ snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
 	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return virt_to_page(CAC_ADDR(vaddr));
 #endif
+#if defined(CONFIG_PPC32) && defined(CONFIG_NOT_COHERENT_CACHE)
+	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV) {
+		dma_addr_t addr = substream->runtime->dma_addr + ofs;
+		addr -= get_dma_offset(substream->dma_buffer.dev.dev);
+		/* assume dma_handle set via pfn_to_phys() in
+		 * mm/dma-noncoherent.c
+		 */
+		return pfn_to_page(addr >> PAGE_SHIFT);
+	}
+#endif
 	return virt_to_page(vaddr);
 }
 
-- 
1.6.5.3
