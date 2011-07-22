Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 09:43:15 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:45899 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491002Ab1GVHnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2011 09:43:07 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 6EDF8EF9;
        Fri, 22 Jul 2011 09:43:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Mc9ZhT7eCBLJ; Fri, 22 Jul 2011 09:43:01 +0200 (CEST)
Received: from [192.168.123.134] (e177126024.adsl.alicedsl.de [85.177.126.24])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 419BDEF3;
        Fri, 22 Jul 2011 09:42:36 +0200 (CEST)
Message-ID: <4E292984.5020708@metafoo.de>
Date:   Fri, 22 Jul 2011 09:40:52 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110702 Icedove/3.0.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     alsa-devel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH V2 1/2] ALSA: Alchemy AC97C/I2SC audio support
References: <1311266050-22199-1-git-send-email-manuel.lauss@googlemail.com>        <1311266050-22199-2-git-send-email-manuel.lauss@googlemail.com>        <4E28BC1F.50804@metafoo.de> <CAOLZvyGxPB1oCKg4BtvBjiuKTb=8urq6L8YQHYbMfmQQigo0kA@mail.gmail.com>
In-Reply-To: <CAOLZvyGxPB1oCKg4BtvBjiuKTb=8urq6L8YQHYbMfmQQigo0kA@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15801

On 07/22/2011 08:54 AM, Manuel Lauss wrote:
> On Fri, Jul 22, 2011 at 1:54 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
>>> +     ret = -ENOMEM;
>>> +     db1000_asoc97_dev = platform_device_alloc("soc-audio", 0);
>>
>> New drivers shouldn't user soc-audio anymore, just register a normal platform
>> device driver.
> 
> Can you point to an example of the new way?
> 

sound/soc/samsung/speyside.c

> 
>>> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
>>> new file mode 100644
>>> index 0000000..0f7d90a
>>> --- /dev/null
>>> +++ b/sound/soc/au1x/dma.c
>>> @@ -0,0 +1,470 @@
>>> [...]
>>> +
>>> +static struct platform_driver alchemy_ac97pcm_driver = {
>>> +     .driver = {
>>> +             .name   = AC97C_DMANAME,
>>> +             .owner  = THIS_MODULE,
>>> +     },
>>> +     .probe          = alchemy_pcm_drvprobe,
>>> +     .remove         = __devexit_p(alchemy_pcm_drvremove),
>>> +};
>>> +
>>> +static struct platform_driver alchemy_i2spcm_driver = {
>>> +     .driver = {
>>> +             .name   = I2SC_DMANAME,
>>> +             .owner  = THIS_MODULE,
>>> +     },
>>> +     .probe          = alchemy_pcm_drvprobe,
>>> +     .remove         = __devexit_p(alchemy_pcm_drvremove),
>>> +};
>>
>> You shouldn't really have to register two identical drivers for this. If you
>> really want to be able to instantiate the driver with two different names use
>> platform_device_id. But in my opinion it should be enough to just have one
>> generic name, since there is nothing AC97 or I2S specific in this driver.
> 
> I need a unique name for the DMA device in soc_dai_link.  This was the
> easiest way. Especially since both ac97 and i2s can be active at
> runtime.

If you want to instantiate two pcm drivers you can just give the devices
different ids. As there is nothing I2C or AC97 specific in the pcm driver it
should not matter which one is used for what, if two devices are active at the
same time.
Right now you need to know which one is which, because you instantiate the
driver with either the I2C or AC97 DMA addresses, but if you use
snd_soc_dai_get_dma_data as described below and pass the DMA address at runtime
this issue will go away.

> 
> 
>>> [...]
>>> +
>>> +struct platform_device *alchemy_pcm_add(struct platform_device *pdev, int type)
>>> +{
>> +       struct resource *res, *r;
>> +       struct platform_device *pd;
>> +       char *pdevname;
>> +       int id[2];
>> +       int ret;
>> +
>> +       r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> +       if (!r)
>> +               return NULL;
>> +       id[0] = r->start;
>> +
>> +       r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> +       if (!r)
>> +               return NULL;
>> +       id[1] = r->start;
>> +
>> +       res = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
>> +       if (!res)
>> +               return NULL;
>> +
>> +       res[0].start = res[0].end = id[0];
>> +       res[1].start = res[1].end = id[1];
>> +       res[0].flags = res[1].flags = IORESOURCE_DMA;
>> +
>> +       /* "alchemy-pcm-ac97" or "alchemy-pcm-i2s" */
>> +       pdevname = (type == 0) ? AC97C_DMANAME : I2SC_DMANAME;
>> +       pd = platform_device_alloc(pdevname, -1);
>> +       if (!pd)
>> +               goto out;
>> +
>> +       pd->resource = res;
>> +       pd->num_resources = 2;
>> +
>> +       ret = platform_device_add(pd);
>> +       if (!ret)
>> +               return pd;
>> +
>> +       platform_device_put(pd);
>> +out:
>> +       kfree(res);
>> +       return NULL;
>>> +}
>>
>> This function looks a bit fishy. The pcm driver should be registered by the
>> platform code file as well. If you need different DMA regions for I2C and AC97
>> use snd_soc_dai_set_dma_data and snd_soc_dai_get_dma_data to pass them to the
>> PCM driver from the I2S or AC97 driver.
> 
> I like to pass the DMA id's along with the ac97/i2s resource
> information (since they
> belong together anyway). As an added benefit I get a sensibly named dma device
> with the correct DMA information, all by simply registering the ac97
> platform device.

There is nothing wrong with passing the DMA ids along with the other AC97/I2C
resources. At least for the AC97 and I2C driver. But the PCM driver should use
snd_soc_dai_get_dma_data to get the DMA addresses at runtime rather then during
device instantiation. Take a look at how other platforms handle this.

- Lars
