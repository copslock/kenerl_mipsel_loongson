Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 12:12:28 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:22343 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20023461AbXEQLM0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 May 2007 12:12:26 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 17 May 2007 20:12:24 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 02D6B420A0;
	Thu, 17 May 2007 20:12:18 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id E44232035C;
	Thu, 17 May 2007 20:12:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l4HBCEW0013262;
	Thu, 17 May 2007 20:12:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 17 May 2007 20:12:14 +0900 (JST)
Message-Id: <20070517.201214.15246811.nemoto@toshiba-tops.co.jp>
To:	tbm@cyrius.com
Cc:	guido.zeiger@mailprocessor.de, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Segmentation Fault from MP3-Player with Etch on Qube2
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070516142849.GD19816@deprecation.cyrius.com>
References: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de>
	<20070510.011348.25233649.anemo@mba.ocn.ne.jp>
	<20070516142849.GD19816@deprecation.cyrius.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 16 May 2007 16:28:49 +0200, Martin Michlmayr <tbm@cyrius.com> wrote:
> > There are know problems with PCI soundcard on noncoherent MIPS
> > platform (including cobalt) and some patches are floating around.  For
> > example:
> > http://www.linux-mips.org/archives/linux-mips/2007-04/msg00072.html
> > 
> > This is a long standing issue and I wonder why your soundcard _did_
> > work with debian sid.  The kernel of sid contains fixes for this
> > issue?
> 
> I don't think it ever worked with 2.6, but it certainly worked with
> 2.4.  Is it much work to get 2.6 working again?  This problem comes up
> from time to time, so it seems it's hitting a number of users.

Did the 2.4 kernel use ALSA or OSS?  I think ALSA for kernel 2.4 had
same problem.

And this is a minimal patch for current git tree.  But I'm not sure if
this patch really fixes the reported segfault.


There are two problem.

1. virt_to_page() can not be used for a buffer returned by
   dma_alloc_coherent().

2. mmap() for a buffer returned by dma_alloc_coherent() should be
   uncached.

This patch is actually ugly and would not be acceptable as is.
So we need a plan to how to fix them _right_ way.


diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a96733a..2d3660c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3138,6 +3138,9 @@ static struct page *snd_pcm_mmap_data_nopage(struct vm_area_struct *area,
 			return NOPAGE_OOM; /* XXX: is this really due to OOM? */
 	} else {
 		vaddr = runtime->dma_area + offset;
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+		vaddr = CAC_ADDR(vaddr);
+#endif
 		page = virt_to_page(vaddr);
 	}
 	get_page(page);
@@ -3159,6 +3162,10 @@ static struct vm_operations_struct snd_pcm_vm_ops_data =
 static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
 				struct vm_area_struct *area)
 {
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	/* use uncached access for dma_area */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
 	area->vm_ops = &snd_pcm_vm_ops_data;
 	area->vm_private_data = substream;
 	area->vm_flags |= VM_RESERVED;
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..1dd1c9e 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 		}
 		sgbuf->table[i].buf = tmpb.area;
 		sgbuf->table[i].addr = tmpb.addr;
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+		sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
+#else
 		sgbuf->page_table[i] = virt_to_page(tmpb.area);
+#endif
 		sgbuf->pages++;
 	}
 
 	sgbuf->size = size;
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP,
+			  PAGE_KERNEL_UNCACHED);
+#else
 	dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, PAGE_KERNEL);
+#endif
 	if (! dmab->area)
 		goto _failed;
 	return dmab->area;
