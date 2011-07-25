Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 13:03:09 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:60510 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491006Ab1GYLDF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2011 13:03:05 +0200
Received: by gxk2 with SMTP id 2so2377412gxk.36
        for <multiple recipients>; Mon, 25 Jul 2011 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/CtKVe8l/hHnAbSMskeozBGHGDlZlZonO31NR3k39nQ=;
        b=hyIdDSc/rjHd2YcyWw12V1gz4BJ6ARkO/MEQKyNZqqqiAJoAb6T2W4GxiwCHWA4as+
         ik/CPReHPHvu6mCEK4OH57tg7eXou8fcvINv1Bm8E9ciT01ZSExtrOI9EwxLBPqM3H4o
         XH7ymY/kb8+cK2G8TWQpb/KlrjCq3YqPZqvgM=
MIME-Version: 1.0
Received: by 10.236.184.197 with SMTP id s45mr5885064yhm.157.1311591778954;
 Mon, 25 Jul 2011 04:02:58 -0700 (PDT)
Received: by 10.236.95.168 with HTTP; Mon, 25 Jul 2011 04:02:58 -0700 (PDT)
In-Reply-To: <4E2D3825.1070905@ti.com>
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com>
        <1311502311-16916-2-git-send-email-manuel.lauss@googlemail.com>
        <4E2D3825.1070905@ti.com>
Date:   Mon, 25 Jul 2011 13:02:58 +0200
Message-ID: <CAOLZvyEpHe_TUygZV7cstg_m1RqdNSg88KwJdkwZF55ThQzn0g@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] ASoC: Alchemy AC97C/I2SC audio support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Liam Girdwood <lrg@ti.com>
Cc:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17572

On Mon, Jul 25, 2011 at 11:32 AM, Liam Girdwood <lrg@ti.com> wrote:
> On 24/07/11 11:11, Manuel Lauss wrote:
>> This patch adds ASoC support for the AC97 and I2S controllers
>> on the old Au1000/Au1500/Au1100 chips,
>>
>> AC97 Tested on a Db1500.  I2S untested since none of the boards
>> actually have an I2S codec wired up (just test pins).
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> V4: dropped hunk which removed I2S constants in au1000.h header to avoid merge
>>     conflicts with other patches, use the context structure in psc.h since it
>>     fits really well.
>> V3: implemented feedback from Lars-Peter Clausen: src tidying, no more
>>     automatic dma device registration, split off db1000 board code.
>> V2: added untested I2S controller driver for completeness, removed the audio
>>     defines from the au1000 header as well.
>>
>
> Looks mostly OK, I just have some questions below:-
>> +#define AC97_RATES     \
>> +       SNDRV_PCM_RATE_8000_44100
>
> Just curious, is there any reason this doesn't support 48kHz ?

No reason really; fixed.


>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>> new file mode 100644
>> index 0000000..20fedbd
>> +static int alchemy_pcm_hw_params(struct snd_pcm_substream *substream,
>> +                                struct snd_pcm_hw_params *hw_params)
>> +{
>> +       struct audio_stream *stream = ss_to_as(substream);
>> +       int err;
>> +
>> +       err = snd_pcm_lib_malloc_pages(substream,
>> +                                      params_buffer_bytes(hw_params));
>> +       if (err < 0)
>> +               return err;
>> +       return au1000_setup_dma_link(stream,
>> +                                    params_period_bytes(hw_params),
>> +                                    params_periods(hw_params));
>
>
> What happens if this fails ? You already have malloc'ed some pages.

also fixed,


>> +static int alchemy_pcm_new(struct snd_card *card,
>> +                          struct snd_soc_dai *dai,
>> +                          struct snd_pcm *pcm)
>
> This API call has been updated to only pass the rtd *

fixed,


>> diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
>> +static inline unsigned long RD(struct au1xpsc_audio_data *ctx, int reg)
>> +{
>> +       return __raw_readl(ctx->mmio + reg);
>> +}
>> +
>> +static inline void WR(struct au1xpsc_audio_data *ctx, int reg, unsigned long v)
>> +{
>> +       __raw_writel(v, ctx->mmio + reg);
>> +       wmb();
>> +}
>
> Btw, just wondering if arch/mips already supplies a suitable RD()/WR() for you ?

with the proper context, no.  I've used these kind of macros in other
code, though :)


>> +static unsigned long msbits_to_reg(int msbits)
>> +{
>> +       switch (msbits) {
>> +       case 8:  return CFG_SZ_8;
>> +       case 16: return CFG_SZ_16;
>> +       case 18: return CFG_SZ_18;
>> +       case 20: return CFG_SZ_20;
>> +       case 24: return CFG_SZ_24;
>
> It's best to format all the switch statements consistently throughout your code.

also fixed,


>> +static int au1xi2s_drvsuspend(struct device *dev)
>> +{
>> +       struct au1xpsc_audio_data *ctx = dev_get_drvdata(dev);
>> +
>> +       WR(ctx, I2S_ENABLE, EN_D);      /* clock off, disable */
>> +
>> +       return 0;
>> +}
>> +
>> +static int au1xi2s_drvresume(struct device *dev)
>> +{
>
> Should we not enalbe the clock here (i.e. in order to balance the clock off in suspend) ?

According to the datasheet, these bits only control internal clock
supply to the I2S module
itself.  It's reenabled in the trigger callback.  Clock for the codec
is controlled through
another register in the central clock block.   As I wrote, this is an
untested driver since none
of the boards I have actually have an I2S codec wired up.  So this is
all guesswork based
on vague datasheets ;)


>> diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
>> index b30eadd..c59b9e5 100644
>> --- a/sound/soc/au1x/psc.h
>> +++ b/sound/soc/au1x/psc.h
>> @@ -1,7 +1,7 @@
>>  /*
>> - * Au12x0/Au1550 PSC ALSA ASoC audio support.
>> + * Alchemy ALSA ASoC audio support.
>>   *
>> - * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
>> + * (c) 2007-2011 MSC Vertriebsges.m.b.H.,
>>   *     Manuel Lauss <manuel.lauss@gmail.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>> @@ -13,7 +13,13 @@
>>  #ifndef _AU1X_PCM_H
>>  #define _AU1X_PCM_H
>>
>> -/* DBDMA helpers */
>> +#define PCM_TX 0
>> +#define PCM_RX 1
>
> Is there any need for these macros, SNDRV_PCM_STREAM_PLAYBACK and SNDRV_PCMP_STREAM_CAPTURE should be used for this type of logic.

As long as they both stay 0 and 1, might as well use them directly.  Fixed.
I'll remove them in a follow-up patch for the PSC drivers.

Thanks for the review!
        Manuel Lauss
