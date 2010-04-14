Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 11:00:35 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:51223 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491139Ab0DNJAb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Apr 2010 11:00:31 +0200
Received: by pvc30 with SMTP id 30so4115335pvc.36
        for <multiple recipients>; Wed, 14 Apr 2010 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MLY8Tkp5qhZQIgOucOlAlOZPYWUUTrW3bZpNADlYyE0=;
        b=G7xQPO/aTJZJ/NFf0ka0zrW9hib26obkEV39X5YwLJz1rIDCPKZiswV/4PMqPpSS5t
         PLASRvuuVVxSqoWKH+z0Qgiqr5Z5f8vDwHXxI3p4hob2RQOmia6ZKcR1L4cLMKJeTrqI
         cMFDC21rUzvCaH36Ovi0QlaHe3G0ePbOv2/7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=hWdLNasXWBP16SyX+yfKed3wQ0bFxEFXHZoXOQ9NKkY4DCpjWcC9nN2iSLMQmUB9OA
         QXHqlxiL9TswLED842hVGHuy5It3WqkFrHwIZ/K6wVqSLqk79P4cR9HaSW7qh+9yZM1Z
         tQJHeTSq2TJk3RhXVOH3VnFPWyHKQ0YlS1m7M=
Received: by 10.141.91.7 with SMTP id t7mr1063331rvl.83.1271235624797;
        Wed, 14 Apr 2010 02:00:24 -0700 (PDT)
Received: from [192.168.2.243] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm113661pzk.1.2010.04.14.02.00.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 02:00:24 -0700 (PDT)
Subject: Re: About MIPS specific dma_mmap_coherent()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <s5hzl164kay.wl%tiwai@suse.de>
References: <1271134735.25797.35.camel@falcon>
         <s5hmxx7z4a7.wl%tiwai@suse.de> <1271218889.25872.27.camel@falcon>
         <s5hzl164kay.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 14 Apr 2010 17:00:19 +0800
Message-ID: <1271235619.25872.148.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-14 at 08:31 +0200, Takashi Iwai wrote:
[...]
> > 
> > Before, we have added the low-level handling with pgprot_noncached() in
> > snd_pcm_mmap() to fix it, but now, can we add MIPS specific
> > dma_mmap_coherent() as ARM did?
> 
> That would be a certainly fix, yes.  I have no objection, of course ;)
> A quicky, less-intrusive one would be the patch below.

The below patch works well, just tested it.

> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index c22ebb0..fd6703e 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3188,6 +3188,8 @@ static int snd_pcm_default_mmap(struct snd_pcm_substream *substream,
>  					 substream->runtime->dma_area,
>  					 substream->runtime->dma_addr,
>  					 area->vm_end - area->vm_start);
> +#elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
> +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
>  #endif /* ARCH_HAS_DMA_MMAP_COHERENT */
>  	/* mmap with fault handler */
>  	area->vm_ops = &snd_pcm_vm_ops_data_fault;
