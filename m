Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 17:26:54 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:29402 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133399AbWEVP0n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2006 17:26:43 +0200
Received: from localhost (p3247-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9668394E4; Tue, 23 May 2006 00:26:38 +0900 (JST)
Date:	Tue, 23 May 2006 00:27:28 +0900 (JST)
Message-Id: <20060523.002728.126141842.anemo@mba.ocn.ne.jp>
To:	rincewind@discworld.dascon.de
Cc:	linux-mips@linux-mips.org
Subject: Re: Soundcard problems on Cobalt Qube 2
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060521181323.GA3740@discworld.dascon.de>
References: <20060521181323.GA3740@discworld.dascon.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 21 May 2006 20:13:24 +0200, rincewind@discworld.dascon.de (Michael Schwingen) wrote:
> I installed Debian testing and compiled a kernel.org 2.6.16.14 kernel.
> Everything works fine until I start playing sound - at that point, I get
> crash #1 below. 
> 
> Just for comparison, I tried two different soundcards - a Yamaha
> YMF744-based card, which at least plays 8-bit WAV files using aplay, but
> causes crash #2 when playing mp3 files using mocp. A ES1938-based card does
> not respond to alsamixer, and showed crash #3 when playing mp3 files using
> mocp. An Intel EEPRO100 ethernet card works just fine.
> 
> I am only really interested in getting the ICE1712 card working, but the
> other two crashes seemed quite similar, so there may be a common or similar
> problem in the drivers. I have a bit of kernel driver experience, but have
> not used DMA or interrupts until now, and have no experience on MIPS.
> 
> Do you have any idea what goes wrong, or lacking that, where I might start
> looking?

I know one problem in ALSA on mips, but not sure it is relevant to
your crash.

http://www.linux-mips.org/archives/linux-mips/2006-01/msg00327.html

And here is an updated (still ugly) patch against current git.

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0860c5a..8f9fd64 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3110,6 +3110,10 @@ static struct page *snd_pcm_mmap_data_no
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
@@ -3131,6 +3135,10 @@ static struct vm_operations_struct snd_p
 static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
 				struct vm_area_struct *area)
 {
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+	/* use uncached access for dma_area */
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
 	area->vm_ops = &snd_pcm_vm_ops_data;
 	area->vm_private_data = substream;
 	area->vm_flags |= VM_RESERVED;
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 74745da..c4828d7 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -95,7 +95,12 @@ void *snd_malloc_sgbuf_pages(struct devi
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
 
