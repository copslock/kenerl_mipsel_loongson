Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:14:57 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:36315 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492904AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 0069486A2E;
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
Subject: [PATCH 3/5] ALSA: pcm - fix page conversion on non-coherent MIPS arch
Date:   Thu, 26 Nov 2009 16:13:06 +0100
Message-Id: <1259248388-20095-4-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259248388-20095-3-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
 <1259248388-20095-2-git-send-email-tiwai@suse.de>
 <1259248388-20095-3-git-send-email-tiwai@suse.de>
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

The non-coherent MIPS arch doesn't give the correct address by a simple
virt_to_page() for pages allocated via dma_alloc_coherent().

Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
buffer allocation type was added to avoid the wrong conversion.

Note that this doesn't fix perfectly: the pages should be marked with
proper pgprot value.  This will be done in a future implementation like
the conversion to dma_mmap_coherent().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c906be2..e48c5f6 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3066,6 +3066,10 @@ static inline struct page *
 snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
 {
 	void *vaddr = substream->runtime->dma_area + ofs;
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+		return virt_to_page(CAC_ADDR(vaddr));
+#endif
 	return virt_to_page(vaddr);
 }
 
-- 
1.6.5.3
