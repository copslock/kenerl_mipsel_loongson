Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jul 2011 16:43:26 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:38213 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491043Ab1GZOnW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jul 2011 16:43:22 +0200
Received: by yxj20 with SMTP id 20so323977yxj.36
        for <linux-mips@linux-mips.org>; Tue, 26 Jul 2011 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JBCgSddvIJh2Nu7vwLj8k3hIp/sowTdwkE2gJ+dKnns=;
        b=oZdggtVYuOqk3H0SbvEJf+IFNd8ispxvNYS1IcITapBL7u93NcxILMfLRPtTJqsFxY
         cRTqJSRzBRpxurKfiMk73yAXXd64/9pKpQHc/7KVsF7cxKtu17RK4JpW8vAXqpEbpZyY
         R/kug/dtoLAU01T2520IHPDDTQJrLUSbW9sNc=
MIME-Version: 1.0
Received: by 10.236.185.132 with SMTP id u4mr7701471yhm.224.1311691396492;
 Tue, 26 Jul 2011 07:43:16 -0700 (PDT)
Received: by 10.236.95.168 with HTTP; Tue, 26 Jul 2011 07:43:16 -0700 (PDT)
In-Reply-To: <20110726143112.GF7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
        <1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
        <20110726143112.GF7285@opensource.wolfsonmicro.com>
Date:   Tue, 26 Jul 2011 16:43:16 +0200
Message-ID: <CAOLZvyFzHFGFvFrWigLi_oHpdQBp1ZCsRBEU8tF-62X8VaCd_Q@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:     alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18657

On Tue, Jul 26, 2011 at 4:31 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 25, 2011 at 01:44:45PM +0200, Manuel Lauss wrote:
>
> Looks good, I'll apply this but a few minor comments you might want to
> look at incrementally.
>
>> +#define ALCHEMY_PCM_FMTS                                     \
>> +     (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |        \
>> +      SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |    \
>> +      SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |    \
>> +      SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |    \
>> +      SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |    \
>> +      0)
>
> Why the | 0?  Same for the other one.

Old habit in case I need to insert other format bits in the future (then
the second-to-last line need not be changed in a patch).


>> +     case (DMA_D0 | DMA_D1):
>> +             pr_debug("DMA %d missed interrupt.\n", stream->dma);
>> +             au1000_dma_stop(stream);
>> +             au1000_dma_start(stream);
>> +             break;
>> +     case (~DMA_D0 & ~DMA_D1):
>> +             pr_debug("DMA %d empty irq.\n", stream->dma);
>
> This case should return IRQ_NONE really since it didn't handle an
> interrupt...

If that last case ever happens the DMA engine is broken, as it shouldn't
issue interrupts when no transfer is in progress.  The errata sheets don't
mention anything (yet).

Thanks!
        Manuel Lauss
