Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:00:18 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:28371 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022491AbZDIFAM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:00:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 7CA3D3412F;
	Thu,  9 Apr 2009 12:57:13 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPZUIK6rMOOC; Thu,  9 Apr 2009 12:57:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id A069E34129;
	Thu,  9 Apr 2009 12:57:07 +0800 (CST)
Message-ID: <49DD80D0.7090903@lemote.com>
Date:	Thu, 09 Apr 2009 13:00:00 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 7/14] lemote: Alsa memory maps fixup on mips systems
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

The user application mmap audio dma regions must be dma-coherent
---
sound/core/pcm_native.c | 9 +++++++++
sound/core/sgbuf.c | 8 ++++++++
sound/pci/Kconfig | 1 -
3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a789efc..438dd80 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3099,7 +3099,11 @@ static int snd_pcm_mmap_data_fault(struct
vm_area_struct *area,
return VM_FAULT_SIGBUS;
} else {
vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+ page = virt_to_page(CAC_ADDR(vaddr));
+#else
page = virt_to_page(vaddr);
+#endif
}
get_page(page);
vmf->page = page;
@@ -3214,6 +3218,11 @@ static int snd_pcm_mmap(struct file *file, struct
vm_area_struct *area)
if (PCM_RUNTIME_CHECK(substream))
return -ENXIO;

+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+ /* all mmap using uncached mode */
+ area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+ area->vm_flags |= ( VM_RESERVED | VM_IO);
+#endif
offset = area->vm_pgoff << PAGE_SHIFT;
switch (offset) {
case SNDRV_PCM_MMAP_OFFSET_STATUS:
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 4e7ec2b..977e9ce 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -114,7 +114,11 @@ void *snd_malloc_sgbuf_pages(struct device *device,
if (!i)
table->addr |= chunk; /* mark head */
table++;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+ *pgtable++ = virt_to_page(CAC_ADDR(tmpb.area));
+#else
*pgtable++ = virt_to_page(tmpb.area);
+#endif
tmpb.area += PAGE_SIZE;
tmpb.addr += PAGE_SIZE;
}
@@ -125,7 +129,11 @@ void *snd_malloc_sgbuf_pages(struct device *device,
}

sgbuf->size = size;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+ dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP | VM_IO,
pgprot_noncached(PAGE_KERNEL));
+#else
dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
+#endif
if (! dmab->area)
goto _failed;
if (res_size)
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 82b9bdd..4ccfae0 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -259,7 +259,6 @@ config SND_CS5530

config SND_CS5535AUDIO
tristate "CS5535/CS5536 Audio"
- depends on X86 && !X86_64
select SND_PCM
select SND_AC97_CODEC
help
-- 
1.5.6.5
