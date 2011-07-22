Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 09:56:40 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:37607 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491002Ab1GVH4f convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 09:56:35 +0200
Received: by gya1 with SMTP id 1so1168658gya.36
        for <multiple recipients>; Fri, 22 Jul 2011 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bIo0M9imLnybeQU7Bb/rFF1JTPYRXLqQyWQLp9+a0zw=;
        b=IMezZtcSpIwHxLDTJZ83BOMR2a++g/4307v0kf6jAYPOiiR73JnR1vhgxKLBh+qB/y
         OPYWz/IKzm81PF4PEi4fZEoRiNW/EVw1REKcN2fqiWp2aSwsiqADgc2IDcwKds/XjnJf
         2jhYujJICQEzzUZHiDHohlHKWWeUmH9N61MkE=
MIME-Version: 1.0
Received: by 10.236.125.134 with SMTP id z6mr1735591yhh.58.1311321388771; Fri,
 22 Jul 2011 00:56:28 -0700 (PDT)
Received: by 10.236.95.168 with HTTP; Fri, 22 Jul 2011 00:56:28 -0700 (PDT)
In-Reply-To: <4E292984.5020708@metafoo.de>
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>
        <1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>
        <4E28BC1F.50804@metafoo.de>
        <CAOLZvyGxPB1oCKg4BtvBjiuKTb=8urq6L8YQHYbMfmQQigo0kA@mail.gmail.com>
        <4E292984.5020708@metafoo.de>
Date:   Fri, 22 Jul 2011 09:56:28 +0200
Message-ID: <CAOLZvyHfe+a694NKPt2+_PGtw_8JAAsvksFH=HFBYfSZ6odTMg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     alsa-devel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15803

On Fri, Jul 22, 2011 at 9:40 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/22/2011 08:54 AM, Manuel Lauss wrote:
>> On Fri, Jul 22, 2011 at 1:54 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
>>>> +     ret = -ENOMEM;
>>>> +     db1000_asoc97_dev = platform_device_alloc("soc-audio", 0);
>>>
>>> New drivers shouldn't user soc-audio anymore, just register a normal platform
>>> device driver.
>>
>> Can you point to an example of the new way?
>>
>
> sound/soc/samsung/speyside.c

Thanks,



>>>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>>>> new file mode 100644
>>>> index 0000000..0f7d90a
>>>> --- /dev/null
>>>> +++ b/sound/soc/au1x/dma.c
>>>> @@ -0,0 +1,470 @@
>>>> [...]
>>>> +
>>>> +static struct platform_driver alchemy_ac97pcm_driver = {
>>>> +     .driver = {
>>>> +             .name   = AC97C_DMANAME,
>>>> +             .owner  = THIS_MODULE,
>>>> +     },
>>>> +     .probe          = alchemy_pcm_drvprobe,
>>>> +     .remove         = __devexit_p(alchemy_pcm_drvremove),
>>>> +};
>>>> +
>>>> +static struct platform_driver alchemy_i2spcm_driver = {
>>>> +     .driver = {
>>>> +             .name   = I2SC_DMANAME,
>>>> +             .owner  = THIS_MODULE,
>>>> +     },
>>>> +     .probe          = alchemy_pcm_drvprobe,
>>>> +     .remove         = __devexit_p(alchemy_pcm_drvremove),
>>>> +};
>>>
>>> You shouldn't really have to register two identical drivers for this. If you
>>> really want to be able to instantiate the driver with two different names use
>>> platform_device_id. But in my opinion it should be enough to just have one
>>> generic name, since there is nothing AC97 or I2S specific in this driver.
>>
>> I need a unique name for the DMA device in soc_dai_link.  This was the
>> easiest way. Especially since both ac97 and i2s can be active at
>> runtime.
>
> If you want to instantiate two pcm drivers you can just give the devices
> different ids. As there is nothing I2C or AC97 specific in the pcm driver it
> should not matter which one is used for what, if two devices are active at the
> same time.
> Right now you need to know which one is which, because you instantiate the
> driver with either the I2C or AC97 DMA addresses, but if you use
> snd_soc_dai_get_dma_data as described below and pass the DMA address at runtime
> this issue will go away.

so instead of "alchemy-pcm-{ac97|i2s}" i'd have "alchemy-pcm.[01]". Not really
much clearer in my book.  And I still need to know the correct suffix for
dai link.

Or am I missing something fundamentally?



>>>> [...]
>>>> +
>>>> +struct platform_device *alchemy_pcm_add(struct platform_device *pdev, int type)
>>>> +{
>>> +       struct resource *res, *r;
>>> +       struct platform_device *pd;
>>> +       char *pdevname;
>>> +       int id[2];
>>> +       int ret;
>>> +
>>> +       r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>> +       if (!r)
>>> +               return NULL;
>>> +       id[0] = r->start;
>>> +
>>> +       r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>>> +       if (!r)
>>> +               return NULL;
>>> +       id[1] = r->start;
>>> +
>>> +       res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
>>> +       if (!res)
>>> +               return NULL;
>>> +
>>> +       res[0].start = res[0].end = id[0];
>>> +       res[1].start = res[1].end = id[1];
>>> +       res[0].flags = res[1].flags = IORESOURCE_DMA;
>>> +
>>> +       /* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
>>> +       pdevname = (type == 0) ? AC97C_DMANAME : I2SC_DMANAME;
>>> +       pd = platform_device_alloc(pdevname, -1);
>>> +       if (!pd)
>>> +               goto out;
>>> +
>>> +       pd->resource = res;
>>> +       pd->num_resources = 2;
>>> +
>>> +       ret = platform_device_add(pd);
>>> +       if (!ret)
>>> +               return pd;
>>> +
>>> +       platform_device_put(pd);
>>> +out:
>>> +       kfree(res);
>>> +       return NULL;
>>>> +}
>>>
>>> This function looks a bit fishy. The pcm driver should be registered by the
>>> platform code file as well. If you need different DMA regions for I2C and AC97
>>> use snd_soc_dai_set_dma_data and snd_soc_dai_get_dma_data to pass them to the
>>> PCM driver from the I2S or AC97 driver.
>>
>> I like to pass the DMA id's along with the ac97/i2s resource
>> information (since they
>> belong together anyway). As an added benefit I get a sensibly named dma device
>> with the correct DMA information, all by simply registering the ac97
>> platform device.
>
> There is nothing wrong with passing the DMA ids along with the other AC97/I2C
> resources. At least for the AC97 and I2C driver. But the PCM driver should use
> snd_soc_dai_get_dma_data to get the DMA addresses at runtime rather then during
> device instantiation. Take a look at how other platforms handle this.


The ac97/i2s units know they need dma and therefore register the
device themselves.
Having the board code register an "empty" dma device along with the
ac97/i2s devices
seems like a waste of code and a source of potential bugs.  I'll change my code.

Thank you!
        Manuel Lauss
