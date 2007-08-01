Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 08:57:12 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:21681 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021676AbXHAH5E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2007 08:57:04 +0100
Received: (qmail 31801 invoked by uid 511); 1 Aug 2007 08:02:12 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 1 Aug 2007 08:02:12 -0000
Message-ID: <46B03CC0.3090000@lemote.com>
Date:	Wed, 01 Aug 2007 15:56:48 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	alsa-devel@alsa-project.org, linux-mips@linux-mips.org
Subject: ALSA on MIPS platform
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Hi,
    In 
http://www.linux-mips.org/archives/linux-mips/2007-04/msg00114.html, 
Atsushi Nemoto pointed out the problem is discussed before, the thread 
can be found at http://lkml.org/lkml/2006/1/25/117. Thanks Atsushi Nemoto:)
    The problem is clear:
1. dma_alloc_noncoherent() return a non-cached address, and 
virt_to_page() need a cached logical addr (Have I named it right?)
2. mmaped dam buffer should be non-cached.

We have a ugly patch, but we want to solve the problem cleanly, so can 
anyone show me the way?

Regards,
Tian

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 59b29cd..fd0aa66 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3138,7 +3138,11 @@ static struct page 
*snd_pcm_mmap_data_nopage(struct vm_area_struct *area,
             return NOPAGE_OOM; /* XXX: is this really due to OOM? */
     } else {
         vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+        page = virt_to_page(CAC_ADDR(vaddr));
+#else
         page = virt_to_page(vaddr);
+#endif
     }
     get_page(page);
     if (type)
@@ -3254,6 +3258,11 @@ static int snd_pcm_mmap(struct file *file, struct 
vm_area_struct *area)
     substream = pcm_file->substream;
     snd_assert(substream != NULL, return -ENXIO);
 
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+    /* all mmap using uncached mode */
+    area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
+
     offset = area->vm_pgoff << PAGE_SHIFT;
     switch (offset) {
     case SNDRV_PCM_MMAP_OFFSET_STATUS:
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..2251e70 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
         }
         sgbuf->table[i].buf = tmpb.area;
         sgbuf->table[i].addr = tmpb.addr;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+        sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
+#else
         sgbuf->page_table[i] = virt_to_page(tmpb.area);
+#endif
         sgbuf->pages++;
     }
 
     sgbuf->size = size;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+    /* maybe we should use uncached accelerated mode */
+    dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, 
pgprot_noncached(PAGE_KERNEL));
+#else
     dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, 
PAGE_KERNEL);
+#endif
     if (! dmab->area)
         goto _failed;
     return dmab->area;
