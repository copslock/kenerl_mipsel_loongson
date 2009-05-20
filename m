Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:12:12 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.248]:6858 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025222AbZETWLk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:11:40 +0100
Received: by rv-out-0708.google.com with SMTP id b17so1391729rvf.0
        for <multiple recipients>; Wed, 20 May 2009 15:11:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=awDufYuZJTe8J5mFk2AprwcVL1P792FtlajVD9++/0M=;
        b=W1EXBavz2EC91Whv385IddpsIIUzZu6+s91m7BumuEL98J2rFvtScRBYmII0gs8SSb
         OIQBHGYRZkoX25Pms8a9zsZ3L6aa9umOfDeFQGcdv0/sRaciUvAr9Qte7DBl0S9i7RG+
         0YYcJXFSIfIhwgcjB/d7uuLH1lyoej0PEkN/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Sv7XyVVBQh2ypNb4hlCEwWbAl651yd+aUnzZmrX8qQzBwmL8N8IYfmtwWwVieWlR8V
         2mVlTsv1efGy26O4faGKJT0ZhV4u1XVekxNK6825zo++csN2FOz1+IyBgrqmYzn89TUC
         yKRfDZ7Tw2Vp94PFj5B8GPmM97JmtwR5omHnM=
Received: by 10.141.122.1 with SMTP id z1mr937096rvm.275.1242857498495;
        Wed, 20 May 2009 15:11:38 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id f21sm4692636rvb.15.2009.05.20.15.11.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:11:37 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 23/27] Alsa memory maps fixup on mips systems
Date:	Thu, 21 May 2009 06:11:26 +0800
Message-Id: <323881882e108383c0360bd6a1138801d9d47679.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

The user application mmap audio dma regions must be dma-coherent.

this is directly pulled from the to-mips branch of
http://dev.lemote.com/code/linux_loongson

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 sound/core/pcm_native.c |    9 +++++++++
 sound/core/sgbuf.c      |    9 +++++++++
 sound/pci/Kconfig       |    1 -
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a789efc..fb11385 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3099,7 +3099,11 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 			return VM_FAULT_SIGBUS;
 	} else {
 		vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		page = virt_to_page(CAC_ADDR(vaddr));
+#else
 		page = virt_to_page(vaddr);
+#endif
 	}
 	get_page(page);
 	vmf->page = page;
@@ -3214,6 +3218,11 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* all mmap using uncached mode */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+	area->vm_flags |= (VM_RESERVED | VM_IO);
+#endif
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 4e7ec2b..c0fcf0d 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -114,7 +114,11 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			if (!i)
 				table->addr |= chunk; /* mark head */
 			table++;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+			*pgtable++ = virt_to_page(CAC_ADDR(tmpb.area));
+#else
 			*pgtable++ = virt_to_page(tmpb.area);
+#endif
 			tmpb.area += PAGE_SIZE;
 			tmpb.addr += PAGE_SIZE;
 		}
@@ -125,7 +129,12 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 	}
 
 	sgbuf->size = size;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, \
+			VM_MAP | VM_IO, pgprot_noncached(PAGE_KERNEL));
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
-	depends on X86 && !X86_64
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
-- 
1.6.2.1
