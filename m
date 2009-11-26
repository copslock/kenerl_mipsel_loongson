Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 16:13:48 +0100 (CET)
Received: from cantor.suse.de ([195.135.220.2]:40119 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492899AbZKZPNo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 16:13:44 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 0F90E8D893;
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
Subject: [PATCH 2/5] ALSA: pcm - define snd_pcm_default_page_ops()
Date:   Thu, 26 Nov 2009 16:13:05 +0100
Message-Id: <1259248388-20095-3-git-send-email-tiwai@suse.de>
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <1259248388-20095-2-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
 <1259248388-20095-2-git-send-email-tiwai@suse.de>
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

Add a helper (inline) function as the default page ops.  Any hacks wrt
the page address conversion will be applied in this function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f067c5b..c906be2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3062,6 +3062,13 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
 }
 #endif /* coherent mmap */
 
+static inline struct page *
+snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
+{
+	void *vaddr = substream->runtime->dma_area + ofs;
+	return virt_to_page(vaddr);
+}
+
 /*
  * fault callback for mmapping a RAM page
  */
@@ -3072,7 +3079,6 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	struct snd_pcm_runtime *runtime;
 	unsigned long offset;
 	struct page * page;
-	void *vaddr;
 	size_t dma_bytes;
 	
 	if (substream == NULL)
@@ -3082,14 +3088,12 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (offset > dma_bytes - PAGE_SIZE)
 		return VM_FAULT_SIGBUS;
-	if (substream->ops->page) {
+	if (substream->ops->page)
 		page = substream->ops->page(substream, offset);
-		if (!page)
-			return VM_FAULT_SIGBUS;
-	} else {
-		vaddr = runtime->dma_area + offset;
-		page = virt_to_page(vaddr);
-	}
+	else
+		page = snd_pcm_default_page_ops(substream, offset);
+	if (!page)
+		return VM_FAULT_SIGBUS;
 	get_page(page);
 	vmf->page = page;
 	return 0;
-- 
1.6.5.3
