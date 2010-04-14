Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 06:21:49 +0200 (CEST)
Received: from mail-gx0-f228.google.com ([209.85.217.228]:48654 "EHLO
        mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491017Ab0DNEVn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Apr 2010 06:21:43 +0200
Received: by gxk28 with SMTP id 28so1482238gxk.7
        for <multiple recipients>; Tue, 13 Apr 2010 21:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=aAafmdkQvRBXA1RQlKI/AL1MmLhY7OtCSuVwxOyboNc=;
        b=SiKkXpm1djjaxO73v+Oa/a8RqY1jPECA9+ewqcaXy/mu4EYl0RP3U7h67n/b9VnQQl
         sAfX/zLFHKwgn4YsNryDEAk8PXeCudhrLPoIrHQ3B1j3A6giQbNwAOlZn+TXe3/5HA9G
         WtpfqGHJcCDFXqT3h6q5hfE0MD5OR2G0rDV8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ajTgdwhJIV21pmSS3IubcYjIxH2ETsGCjA7KloClf0bF1SD1JFLfVpxFQG0gJZblqD
         5M6T+z5ivjwqolSQP4ATXMNKCiZPUr9512tJ2CWuqTDtEmmbY/BhB5yJ6x7vTofedHdo
         DkYr4BJix85L+lRg8iNysdgGRQVfWlIkd/3PE=
Received: by 10.101.11.17 with SMTP id o17mr11928338ani.111.1271218896145;
        Tue, 13 Apr 2010 21:21:36 -0700 (PDT)
Received: from [192.168.2.243] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5419075iwn.8.2010.04.13.21.21.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 21:21:34 -0700 (PDT)
Subject: Re: About MIPS specific dma_mmap_coherent()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <s5hmxx7z4a7.wl%tiwai@suse.de>
References: <1271134735.25797.35.camel@falcon>
         <s5hmxx7z4a7.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 14 Apr 2010 12:21:29 +0800
Message-ID: <1271218889.25872.27.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> > $ mplayer -ao alsa file.mp3
> > 
> > but without it, the ALSA output is broken.
> 
> Hm, which driver/device are you using?  Also, how is it broken?

I'm using the cs5535 audio in my Yeeloong laptop with the config
"CONFIG_SND_CS5535AUDIO=m"

the above 'broken' means there is audio output with ALSA, but the output
is not normal for it has lots of noises: sha sha sha... 

> 
> There is already a low-level hack in sound/core/pcm_native.c for MIPS,
> so I thought the kernel oops should have been avoided, at least.
> Maybe still pgprot_noncached() is missing, though.

You mean this part for MIPS:

static inline struct page *
snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned
long ofs) 
{
        void *vaddr = substream->runtime->dma_area + ofs; 
#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
        if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
                return virt_to_page(CAC_ADDR(vaddr));
#endif

...
}

Yes, it was already there from one of your patches to linux-2.6.33, but
the pgprot_noncached() was missing as you mentioned above.

And I have found you have added the ARM specific dma_mmap_coherent() to
snd_pcm_default_mmap() to mmap the DMA buffer on RAM:

/*
 * mmap the DMA buffer on RAM
 */
static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
                                struct vm_area_struct *area)
{
        area->vm_flags |= VM_RESERVED;
#ifdef ARCH_HAS_DMA_MMAP_COHERENT
        if (!substream->ops->page &&
            substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
                return dma_mmap_coherent(substream->dma_buffer.dev.dev,
                                         area,
                                         substream->runtime->dma_area,
                                         substream->runtime->dma_addr,
                                         area->vm_end - area->vm_start);
#endif /* ARCH_HAS_DMA_MMAP_COHERENT */
        /* mmap with fault handler */
        area->vm_ops = &snd_pcm_vm_ops_data_fault;
        return 0;
}

Before, we have added the low-level handling with pgprot_noncached() in
snd_pcm_mmap() to fix it, but now, can we add MIPS specific
dma_mmap_coherent() as ARM did?

Regards,
	Wu Zhangjin

> > [2 0001-MIPS-Implement-dma_mmap_coherent-for-ALSA-audio-outp.patch <text/x-patch; UTF-8 (7bit)>]
> > >From a6ee304febbd609d2936dd5b33a16482ef224c97 Mon Sep 17 00:00:00 2001
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > Date: Sun, 11 Apr 2010 03:58:13 +0800
> > Subject: [PATCH] MIPS: Implement dma_mmap_coherent() for ALSA audio output
> > 
> > A lazy version of dma_mmap_coherent() implementation for MIPS.
> > 
> > Without this patch, the ALSA sound output of MIPS is broken:
> > 
> > $ mplayer -ao alsa file.mp3
> > 
> > (This patch was sent out by Takashi Iwai at '18 Aug 2008' but not have
> >  been applied yet for it is not suitable for all MIPS variants. If you
> >  need more info, please access:
> >  http://www.linux-mips.org/archives/linux-mips/2008-08/msg00178.html)
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  arch/mips/include/asm/dma-mapping.h |    4 ++++
> >  arch/mips/mm/dma-default.c          |   13 +++++++++++++
> >  2 files changed, 17 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
> > index 664ba53..c39bfdf 100644
> > --- a/arch/mips/include/asm/dma-mapping.h
> > +++ b/arch/mips/include/asm/dma-mapping.h
> > @@ -74,4 +74,8 @@ extern int dma_is_consistent(struct device *dev, dma_addr_t dma_addr);
> >  extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
> >  	       enum dma_data_direction direction);
> >  
> > +#define ARCH_HAS_DMA_MMAP_COHERENT
> > +extern int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> > +		void *cpu_addr, dma_addr_t handle, size_t size);
> > +
> >  #endif /* _ASM_DMA_MAPPING_H */
> > diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> > index 9547bc0..8388428 100644
> > --- a/arch/mips/mm/dma-default.c
> > +++ b/arch/mips/mm/dma-default.c
> > @@ -375,3 +375,16 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
> >  }
> >  
> >  EXPORT_SYMBOL(dma_cache_sync);
> > +
> > +int __weak dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> > +		void *cpu_addr, dma_addr_t handle, size_t size)
> > +{
> > +	struct page *pg;
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +	cpu_addr = (void *)dma_addr_to_virt(dev, handle);
> > +	pg = virt_to_page(cpu_addr);
> > +	return remap_pfn_range(vma, vma->vm_start,
> > +		       page_to_pfn(pg) + vma->vm_pgoff,
> > +		       size, vma->vm_page_prot);
> > +}
> > +EXPORT_SYMBOL(dma_mmap_coherent);
> > -- 
> > 1.7.0
> > 
