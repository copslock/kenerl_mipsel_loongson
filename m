Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:15:45 +0100 (CET)
Received: from cantor.suse.de ([195.135.220.2]:40127 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493720AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 128DD8E8CC;
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
Subject: [PATCH 4/5] ALSA: pcm - fix page conversion on non-coherent PPC arch
Date:   Thu, 26 Nov 2009 16:13:07 +0100
Message-Id: <1259248388-20095-5-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259248388-20095-4-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
 <1259248388-20095-2-git-send-email-tiwai@suse.de>
 <1259248388-20095-3-git-send-email-tiwai@suse.de>
 <1259248388-20095-4-git-send-email-tiwai@suse.de>
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

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
index e48c5f6..76eb763 100644
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
+		return pfn_to_page(dma_handle >> PAGE_SHIFT);
+	}
+#endif
 	return virt_to_page(vaddr);
 }
 
-- 
1.6.5.3
