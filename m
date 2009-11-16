Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 17:48:41 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:62940 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492810AbZKPQsf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 17:48:35 +0100
Received: by pzk35 with SMTP id 35so4563392pzk.22
        for <multiple recipients>; Mon, 16 Nov 2009 08:48:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XOYF/ejaRlj5gVMa9CZRhKoa8lP61V3OMvONGqrQyoU=;
        b=P2wvEhPrwLIuDEu9YryVFcj14iBVx315xQY7XxVcdqD2wUEy45HOWy/vgpXRWcvRv7
         h2q6CFeltkdiYG3fpbVO0MWBpWqRkoS0xDTqSMHmV1xJ2SvhNb6mFlUvzVm1vrC1xEpw
         xTRRZ/xHZ0AzRBu9CFoWanAh9L8BaY2bIplIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gmxCVQfQUerrPfL8kpNK2D/RW9edDX/OM+bju8FDIwMMp7gLKf+tflcwA3xVA0GrFj
         syr5XJZ6iLfPf2+G/tSMJAkI+eVKebDSMBtur+qVbDEwpXm9ijpCC0P1sszsyM5ZE3A8
         GC3dyjNZggx23gyZoySz+O+A5jARxpG6z81mY=
Received: by 10.115.39.11 with SMTP id r11mr8533588waj.152.1258390106591;
        Mon, 16 Nov 2009 08:48:26 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1942398pxi.13.2009.11.16.08.48.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 08:48:26 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc:	alsa-devel@alsa-project.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, Wu Zhangjin <wuzhangjin@gmail.com>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH] MIPS: Fixups of ALSA memory maps
Date:	Tue, 17 Nov 2009 00:48:14 +0800
Message-Id: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, All

Seems this is MIPS specific, but it's not that easy to move this patch
into the arch/mips part, So, any better solution?

Thanks & Regards,
       Wu Zhangjin

------------------------

The user application mmap audio dma regions must be dma-coherent. This
patch fix it.

Without this patch, artsd will fail on boot, and mplayer will exit with
"Segmentation fault". (this happens on YeeLoong netbook, fuloong2f
mini pc with snd_cs5535 audio card)

This is originally from the to-mips branch of
http://dev.lemote.com/code/linux_loongson, and contributed by Yanhua
from Lemote Inc.

Reported-by: qiaochong <qiaochong@gmail.com>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 sound/core/pcm_native.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ab73edf..2779b9a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3087,7 +3087,11 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
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
@@ -3202,6 +3206,11 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
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
-- 
1.6.2.1
