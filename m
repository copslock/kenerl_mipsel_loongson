Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 04:24:44 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:65039 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133356AbWAXEYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 04:24:20 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with SMTP; 24 Jan 2006 04:28:36 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E592620303;
	Tue, 24 Jan 2006 13:28:32 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D0F9D202AC;
	Tue, 24 Jan 2006 13:28:32 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k0O4SW4D072962;
	Tue, 24 Jan 2006 13:28:32 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 24 Jan 2006 13:28:32 +0900 (JST)
Message-Id: <20060124.132832.37533152.nemoto@toshiba-tops.co.jp>
To:	tbm@cyrius.com
Cc:	linux-mips@linux-mips.org, t.sailer@alumni.ethz.ch, perex@suse.cz
Subject: Re: Ensoniq ES1371 problem on Cobalt MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060124030725.GA14063@deprecation.cyrius.com>
References: <20060124030725.GA14063@deprecation.cyrius.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 24 Jan 2006 03:07:25 +0000, Martin Michlmayr <tbm@cyrius.com> said:
tbm> I get the following problems on a Cobalt MIPS machine with PCI
tbm> and an Ensoniq ES1371 sound card when the module is being loaded.
tbm> It occurs both with the ALSA and the OSS driver so I assume
tbm> there's some MIPS related issue.  Note that the OSS driver worked
tbm> fine under 2.4.  This is now with 2.6.15.

ALSA uses virt_to_page() but this is not work for buffers returned by
pci_alloc_consistent() on MIPS with CONFIG_DMA_NONCOHERENT.  We can
make virt_to_page() bulletproof but it might have some performance
impact.  It seems API something like dma_to_page() should be
introduced.

This issue was discussed years ago:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20030523215935.71373.qmail%40web11901.mail.yahoo.com

Also I suppose snd_pcm_default_mmap() should return uncached page for
DMA area, but I do not sure to where to fix this too.

Anyway, here is my ugly patch against 2.6.15.  It would fix some
problems with ALSA on noncoherent MIPS platform.

diff -ur linux-2.6.15/sound/core/memalloc.c linux/sound/core/memalloc.c
--- linux-2.6.15/sound/core/memalloc.c	2006-01-03 12:21:10.000000000 +0900
+++ linux/sound/core/memalloc.c	2006-01-05 11:46:55.000000000 +0900
@@ -248,8 +248,13 @@
 	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
 	if (res != NULL) {
 #ifdef NEED_RESERVE_PAGES
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		/* res is nocache addr */
+		mark_pages(virt_to_page(CAC_ADDR(res)), pg); /* should be dma_to_page() */
+#else
 		mark_pages(virt_to_page(res), pg); /* should be dma_to_page() */
 #endif
+#endif
 		inc_snd_pages(pg);
 	}
 
@@ -267,8 +272,13 @@
 	pg = get_order(size);
 	dec_snd_pages(pg);
 #ifdef NEED_RESERVE_PAGES
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* ptr is nocache addr */
+	unmark_pages(virt_to_page(CAC_ADDR(ptr)), pg); /* should be dma_to_page() */
+#else
 	unmark_pages(virt_to_page(ptr), pg); /* should be dma_to_page() */
 #endif
+#endif
 	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
 }
 
diff -ur linux-2.6.15/sound/core/pcm_native.c linux/sound/core/pcm_native.c
--- linux-2.6.15/sound/core/pcm_native.c	2006-01-03 12:21:10.000000000 +0900
+++ linux/sound/core/pcm_native.c	2006-01-05 11:46:55.000000000 +0900
@@ -3056,6 +3056,10 @@
 			return NOPAGE_OOM;
 	} else {
 		vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		/* dma_area is nocache addr */
+		vaddr = CAC_ADDR(vaddr);
+#endif
 		page = virt_to_page(vaddr);
 	}
 	get_page(page);
@@ -3076,6 +3080,10 @@
  */
 static int snd_pcm_default_mmap(snd_pcm_substream_t *substream, struct vm_area_struct *area)
 {
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* use uncached access for dma_area */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
 	area->vm_ops = &snd_pcm_vm_ops_data;
 	area->vm_private_data = substream;
 	area->vm_flags |= VM_RESERVED;
diff -ur linux-2.6.15/sound/core/sgbuf.c linux/sound/core/sgbuf.c
--- linux-2.6.15/sound/core/sgbuf.c	2006-01-03 12:21:10.000000000 +0900
+++ linux/sound/core/sgbuf.c	2005-03-04 11:07:45.000000000 +0900
@@ -95,7 +95,12 @@
 		}
 		sgbuf->table[i].buf = tmpb.area;
 		sgbuf->table[i].addr = tmpb.addr;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+		/* snd_dma_malloc_pages returns nocache addr */
+		sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
+#else
 		sgbuf->page_table[i] = virt_to_page(tmpb.area);
+#endif
 		sgbuf->pages++;
 	}
 
