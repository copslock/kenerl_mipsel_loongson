Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 08:31:23 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:53060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491012Ab0DNGbT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 08:31:19 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 34C5989783;
        Wed, 14 Apr 2010 08:31:19 +0200 (CEST)
Date:   Wed, 14 Apr 2010 08:31:17 +0200
Message-ID: <s5hzl164kay.wl%tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     wuzhangjin@gmail.com
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: About MIPS specific dma_mmap_coherent()
In-Reply-To: <1271218889.25872.27.camel@falcon>
References: <1271134735.25797.35.camel@falcon>
        <s5hmxx7z4a7.wl%tiwai@suse.de>
        <1271218889.25872.27.camel@falcon>
User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.7 Emacs/23.1
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tiwai@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips

At Wed, 14 Apr 2010 12:21:29 +0800,
Wu Zhangjin wrote:
> 
> Hi,
> 
> > > $ mplayer -ao alsa file.mp3
> > > 
> > > but without it, the ALSA output is broken.
> > 
> > Hm, which driver/device are you using?  Also, how is it broken?
> 
> I'm using the cs5535 audio in my Yeeloong laptop with the config
> "CONFIG_SND_CS5535AUDIO=m"
> 
> the above 'broken' means there is audio output with ALSA, but the output
> is not normal for it has lots of noises: sha sha sha... 
> 
> > 
> > There is already a low-level hack in sound/core/pcm_native.c for MIPS,
> > so I thought the kernel oops should have been avoided, at least.
> > Maybe still pgprot_noncached() is missing, though.
> 
> You mean this part for MIPS:
> 
> static inline struct page *
> snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned
> long ofs) 
> {
>         void *vaddr = substream->runtime->dma_area + ofs; 
> #if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
>         if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
>                 return virt_to_page(CAC_ADDR(vaddr));
> #endif
> 
> ...
> }
> 
> Yes, it was already there from one of your patches to linux-2.6.33, but
> the pgprot_noncached() was missing as you mentioned above.
> 
> And I have found you have added the ARM specific dma_mmap_coherent() to
> snd_pcm_default_mmap() to mmap the DMA buffer on RAM:
> 
> /*
>  * mmap the DMA buffer on RAM
>  */
> static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
>                                 struct vm_area_struct *area)
> {
>         area->vm_flags |= VM_RESERVED;
> #ifdef ARCH_HAS_DMA_MMAP_COHERENT
>         if (!substream->ops->page &&
>             substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
>                 return dma_mmap_coherent(substream->dma_buffer.dev.dev,
>                                          area,
>                                          substream->runtime->dma_area,
>                                          substream->runtime->dma_addr,
>                                          area->vm_end - area->vm_start);
> #endif /* ARCH_HAS_DMA_MMAP_COHERENT */
>         /* mmap with fault handler */
>         area->vm_ops = &snd_pcm_vm_ops_data_fault;
>         return 0;
> }
> 
> Before, we have added the low-level handling with pgprot_noncached() in
> snd_pcm_mmap() to fix it, but now, can we add MIPS specific
> dma_mmap_coherent() as ARM did?

That would be a certainly fix, yes.  I have no objection, of course ;)
A quicky, less-intrusive one would be the patch below.


thanks,

Takashi

---
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c22ebb0..fd6703e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3188,6 +3188,8 @@ static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
 					 area->vm_end - area->vm_start);
+#elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
 #endif /* ARCH_HAS_DMA_MMAP_COHERENT */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
