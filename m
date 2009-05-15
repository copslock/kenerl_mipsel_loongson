Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:32:06 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:18813 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023409AbZEOWcA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:32:00 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1221322rvb.24
        for <multiple recipients>; Fri, 15 May 2009 15:31:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=mTfsdLuI/S7qbSgGLlOTpSo2gwLPbw2hlWXgkHeLGpg=;
        b=o082WkEQypnpboCQmzNs+CjfNWyN07IfggeoQK1gZngiNSsh9/lhgOW/ptBOmdz1dP
         CBLjRv/g/Nf9liFE2Pq2lkj/XhOYGaKbZZMihY3TrHYNwRtRyw5jFL8/Wc+s0h7qHopj
         dvX7092iY+b8m6sCFPA2mXXiZ00kjgWKfkodY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MWcOTFFTkV4vy6Snit0+e8ZTBRQCXpb8WHptqY/5ZmUv8AwJ8QbGMg7SMuFEVpzF9b
         T/8MWf1+Vvc8GPCJ8Vgpsj2dy6fLr+1/c4RW4VE1EkOpEJkEmBvPq6RkCh+1MaOaHj9k
         vZbA6OPCw8hhqnuPFExYXDm6dyffcwMlj6SfY=
Received: by 10.141.15.11 with SMTP id s11mr982440rvi.222.1242426718304;
        Fri, 15 May 2009 15:31:58 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id k2sm375249rvb.0.2009.05.15.15.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:31:57 -0700 (PDT)
Subject: [PATCH 27/30] loongson: Alsa memory maps fixup on mips systems
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-sound@vger.kernel.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:31:50 +0800
Message-Id: <1242426710.10164.177.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 491b2522226c4d8f4abfdced9c0371a8521ea1e1 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:56:32 +0800
Subject: [PATCH 27/30] loongson: Alsa memory maps fixup on mips systems

The user application mmap audio dma regions must be dma-coherent
---
 sound/core/pcm_native.c |    9 +++++++++
 sound/core/sgbuf.c      |    8 ++++++++
 sound/pci/Kconfig       |    1 -
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
+		page = virt_to_page(CAC_ADDR(vaddr));
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
+	/* all mmap using uncached mode */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+	area->vm_flags |= ( VM_RESERVED | VM_IO);
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
+			*pgtable++ = virt_to_page(CAC_ADDR(tmpb.area));
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
+	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP | VM_IO,
pgprot_noncached(PAGE_KERNEL));
+#else
 	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP,
PAGE_KERNEL);
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
