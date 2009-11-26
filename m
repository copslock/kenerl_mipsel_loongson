Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 22:14:29 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:47739 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493822AbZKZVOZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2009 22:14:25 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAQLEDoG017524;
        Thu, 26 Nov 2009 15:14:14 -0600
Subject: Re: [PATCH 4/5] ALSA: pcm - fix page conversion on non-coherent
 PPC arch
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <s5hpr751ayp.wl%tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
         <1259248388-20095-2-git-send-email-tiwai@suse.de>
         <1259248388-20095-3-git-send-email-tiwai@suse.de>
         <1259248388-20095-4-git-send-email-tiwai@suse.de>
         <1259248388-20095-5-git-send-email-tiwai@suse.de>
         <s5hpr751ayp.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 27 Nov 2009 08:14:12 +1100
Message-ID: <1259270052.18084.29.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, 2009-11-26 at 17:56 +0100, Takashi Iwai wrote:
> Sorry, a typo was in this patch.  The fixed version is below.
> 
> FYI, the patchset is found in sound git tree topic/pcm-dma-fix branch:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git topic/pcm-dma-fix
> 

Ah, I didn't notice the typo :-) Ack still.

Cheers,
Ben.

> thanks,
> 
> Takashi
> 
> 
> From bc01f9e365d3afc041ab2c296107728c56410f8f Mon Sep 17 00:00:00 2001
> From: Takashi Iwai <tiwai@suse.de>
> Date: Thu, 26 Nov 2009 15:04:24 +0100
> Subject: [PATCH] ALSA: pcm - fix page conversion on non-coherent PPC arch
> 
> The non-cohernet PPC arch doesn't give the correct address by a simple
> virt_to_page() for pages allocated via dma_alloc_coherent().
> This patch adds a hack to fix the conversion similarly like MIPS.
> 
> Note that this doesn't fix perfectly: the pages should be marked with
> proper pgprot value.  This will be done in a future implementation like
> the conversion to dma_mmap_coherent().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index e48c5f6..29ab46a 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3070,6 +3070,16 @@ snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
>  	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
>  		return virt_to_page(CAC_ADDR(vaddr));
>  #endif
> +#if defined(CONFIG_PPC32) && defined(CONFIG_NOT_COHERENT_CACHE)
> +	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV) {
> +		dma_addr_t addr = substream->runtime->dma_addr + ofs;
> +		addr -= get_dma_offset(substream->dma_buffer.dev.dev);
> +		/* assume dma_handle set via pfn_to_phys() in
> +		 * mm/dma-noncoherent.c
> +		 */
> +		return pfn_to_page(addr >> PAGE_SHIFT);
> +	}
> +#endif
>  	return virt_to_page(vaddr);
>  }
>  
