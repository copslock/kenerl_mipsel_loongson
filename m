Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:33:48 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:20967 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022032AbXDDObP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:15 +0100
Received: (qmail 16948 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <932376.137093769-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 16/16] alsa sound support for mips
Date:	Wed, 4 Apr 2007 14:38:20 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-225282.322456227"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-225282.322456227
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 sound/core/pcm_native.c |   10 ++++++++++
 sound/core/sgbuf.c      |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3e276fc..9005bac 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3145,7 +3145,11 @@ static struct page *snd_pcm_mmap_data_nopage(struct vm_area_struct *area,
 			return NOPAGE_OOM; /* XXX: is this really due to OOM? */
 	} else {
 		vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		page = virt_to_page(CAC_ADDR(vaddr));
+#else
 		page = virt_to_page(vaddr);
+#endif
 	}
 	get_page(page);
 	if (type)
@@ -3261,6 +3265,12 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	substream = pcm_file->substream;
 	snd_assert(substream != NULL, return -ENXIO);
 
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* all mmap using uncached mode */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+	area->vm_flags |= ( VM_RESERVED | VM_IO);
+#endif
+
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..535f0bc 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 		}
 		sgbuf->table[i].buf = tmpb.area;
 		sgbuf->table[i].addr = tmpb.addr;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
+#else
 		sgbuf->page_table[i] = virt_to_page(tmpb.area);
+#endif
 		sgbuf->pages++;
 	}
 
 	sgbuf->size = size;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* maybe we should use uncached accelerated mode */
+	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
+#else
 	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
+#endif
 	if (! dmab->area)
 		goto _failed;
 	return dmab->area;
-- 
1.4.4.4



------MIME delimiter for sendEmail-225282.322456227--
