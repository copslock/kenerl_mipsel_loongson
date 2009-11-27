Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 04:53:35 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:44161 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839AbZK0Dxa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 04:53:30 +0100
Received: by pwi15 with SMTP id 15so797982pwi.24
        for <multiple recipients>; Thu, 26 Nov 2009 19:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LuYNJ5m8THcc0LXLYGcXkvvKeQT4sjyQbHaFqr3haPw=;
        b=W+toIRFdDjVqxOHfg45EHLjOMtRARB6DrsqQAJ1XBvVzQe0tYl4w354N7IXg5WsMJZ
         v/UENjAdmBLFzzauHIwOw6HFKS0Hk/eA9tD0NMBgqxFCB/ryfNGRRHtAuYhHJdOFJkHZ
         +UUWmIyOSrkRGo4+QPnfq8n+jmld/6alSx+Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=s/UVoDm6Bc3Cp5oYuqXXUHz5E1XBBr8izataBDPuQEQPvt/dzw9RSbqnb+73KvvSID
         uTAbADy2w7cc+zmFUspNaONgZNlDBBZ4y+F+43RxM1yFOnjN3uOZqpbRvrMEH1BHvuQ0
         cJKJveqjs+VRajdto0zJyPgrViibDmyF3wxzw=
Received: by 10.115.134.18 with SMTP id l18mr984200wan.128.1259294002427;
        Thu, 26 Nov 2009 19:53:22 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm906048pzk.15.2009.11.26.19.53.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 19:53:21 -0800 (PST)
Subject: Re: [PATCH 3/5] ALSA: pcm - fix page conversion on non-coherent
 MIPS arch
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1259248388-20095-4-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
         <1259248388-20095-2-git-send-email-tiwai@suse.de>
         <1259248388-20095-3-git-send-email-tiwai@suse.de>
         <1259248388-20095-4-git-send-email-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 27 Nov 2009 11:52:58 +0800
Message-ID: <1259293978.3197.92.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-11-26 at 16:13 +0100, Takashi Iwai wrote:
> The non-coherent MIPS arch doesn't give the correct address by a simple
> virt_to_page() for pages allocated via dma_alloc_coherent().
> 
> Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
> buffer allocation type was added to avoid the wrong conversion.
> 
> Note that this doesn't fix perfectly: the pages should be marked with
> proper pgprot value.  This will be done in a future implementation like
> the conversion to dma_mmap_coherent().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index c906be2..e48c5f6 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3066,6 +3066,10 @@ static inline struct page *
>  snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
>  {
>  	void *vaddr = substream->runtime->dma_area + ofs;
> +#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
> +	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
> +		return virt_to_page(CAC_ADDR(vaddr));
> +#endif
>  	return virt_to_page(vaddr);
>  }

Works well on Loongson family machines, thanks!

Regards,
	Wu Zhangjin
