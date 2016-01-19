Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 01:04:05 +0100 (CET)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35128 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011226AbcASAEBoLxtA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 01:04:01 +0100
Received: by mail-ob0-f179.google.com with SMTP id py5so206162820obc.2;
        Mon, 18 Jan 2016 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=r5Elocw6jUVdauCvRSd0qHmFR7N3lHqnjx6QblLrg9c=;
        b=gKvhIw2Iyxi5I0lIeDfhPFK5gTkrgEJpi+GdPMA8xe8gZfpEtaTYeeu9FCL25QCX2b
         pAGz+tXeE4vHLe8sejTaNdAQd+vG+FZViCRQHa0ZXYQfmEMalX7y/en/uCZT9Tir2I4Q
         bVLDAhlmablGqL26B023tupnlHumMz7avaws6rDsXX1kSNr55mgU14humfhKGhLiHar0
         6uwNnS/Eoyivlen5JUROz2aJjFzS7G1yfHPXk8zxi/9O4kcsmzIQy6qVrq4zczCG5Ykt
         Ed5VoaH7T0YRFHfVF702EAUA4m1OTGMgL5M9LVWuLeeq76k7z7HA6doYgOew+vLHYEIy
         OwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=r5Elocw6jUVdauCvRSd0qHmFR7N3lHqnjx6QblLrg9c=;
        b=F+rTr2Q0YSDDTBQ03dw9yU9e2oCNrQM+PGYL5p0DKjxQ5EoJZUxbWBWZ2cfIRkIALY
         CHUnlyU7hWKjjG+GlGlcFKsCuJBzferT12Vd8RlpBANR7I0OGW+b8HMfIdoUW6NAxcqe
         AWJAy2OxilmgH5QJQXm/I8AUcYfNtzUgZ7OQKqofNRWLjFx58/h2aRLuDCLtSGpW4o/o
         N38sAJ27S5ZA3JpP16ocfJJx+JOMkEZE3z13WlQjsWUVsSWVW30htgoaUXiOCSfOJecf
         V+akwawYSi7r/wjHtamvQ4GBlSBR3lIJDf7Qdmk+EyL95bOSlMG8b93xYCeE2n52zfOb
         ENNQ==
X-Gm-Message-State: ALoCoQmZ08W1RLk23SbxcgwJxshvzckBh+pL0ZYazCbyAY2WCffs75uw1j1nIQ6SURQ3D8l7RAYYTxNR865Oog9juG2kf5Ep8g==
X-Received: by 10.182.68.104 with SMTP id v8mr20967957obt.64.1453161835645;
        Mon, 18 Jan 2016 16:03:55 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:cd6b:e613:d25b:c85f? ([2001:470:d:73f:cd6b:e613:d25b:c85f])
        by smtp.googlemail.com with ESMTPSA id ur2sm14297962obc.11.2016.01.18.16.03.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 16:03:54 -0800 (PST)
Subject: Re: [PATCH 1/2] bmips: add BCM6358 support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <1453030101-14794-1-git-send-email-noltari@gmail.com>
 <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com>
 <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <569D7D69.6070807@gmail.com>
Date:   Mon, 18 Jan 2016 16:03:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Le 18/01/2016 01:42, Álvaro Fernández Rojas a écrit :
> I can refine it to support a custom offset for each cpu instead of a generic one, but defining a custom offset for new SoCs such as BCM6368 or BCM6328 would actually break them, since that way the address wouldn't be remapped to 0xb0000000.
> See: https://github.com/torvalds/linux/blob/master/arch/mips/include/asm/io.h#L213
> In those CPUs the remapping is done automatically (from 0x10000000 to 0xb0000000), since the registers are located in the low 512MB of address space (0x1fffffffULL).

I see what you mean by that now, we can indeed drop these registers from
plat_ioremap() since the fallback already takes care of that for us.

> 
> However, the older CPUs such as BCM6358 (or BCM3368) need that custom ioremap, since those registers aren't located in the low 512MB of address space.
> If you want, I can do something like this: https://gist.github.com/Noltari/bc5fe029c52cf053a454
> And after that we could add other CPUs such as the BCM3368, which needs a different offset: "{ "brcm,bcm3368", 0xfff80000 }"
> 
> What do you think? Should we keep a generic offset (0xfff00000) or should we add SoC specific compatible strings with each custom offset?
> 
> Regards,
> Álvaro.
> 
>> El 18 ene 2016, a las 7:49, Florian Fainelli <f.fainelli@gmail.com> escribió:
>>
>>> On January 17, 2016 3:28:20 AM PST, "Álvaro Fernández Rojas" <noltari@gmail.com> wrote:
>>> BCM6358 has a shared TLB which conflicts with current SMP support, so
>>> it must
>>> be disabled for now.
>>> BCM6358 uses >= 0xfff00000 addresses for internal registers, which need
>>> to be
>>> remapped (by using a simplified version of BRCM63xx ioremap.h).
>>>
>>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>>> ---
>>> arch/mips/bmips/setup.c                    | 10 +++++++++
>>> arch/mips/include/asm/mach-bmips/ioremap.h | 33
>>> ++++++++++++++++++++++++++++++
>>> 2 files changed, 43 insertions(+)
>>> create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h
>>>
>>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>>> index 3553528..38b5bd5 100644
>>> --- a/arch/mips/bmips/setup.c
>>> +++ b/arch/mips/bmips/setup.c
>>> @@ -95,6 +95,15 @@ static void bcm6328_quirks(void)
>>>        bcm63xx_fixup_cpu1();
>>> }
>>>
>>> +static void bcm6358_quirks(void)
>>> +{
>>> +    /*
>>> +     * BCM6358 needs special handling for its shared TLB, so
>>> +     * disable SMP for now
>>> +     */
>>> +    bmips_smp_enabled = 0;
>>> +}
>>
>> That part looks good.
>>
>>> +
>>> static void bcm6368_quirks(void)
>>> {
>>>    bcm63xx_fixup_cpu1();
>>> @@ -104,6 +113,7 @@ static const struct bmips_quirk bmips_quirk_list[]
>>> = {
>>>    { "brcm,bcm3384-viper",        &bcm3384_viper_quirks        },
>>>    { "brcm,bcm33843-viper",    &bcm3384_viper_quirks        },
>>>    { "brcm,bcm6328",        &bcm6328_quirks            },
>>> +    { "brcm,bcm6358",        &bcm6358_quirks            },
>>>    { "brcm,bcm6368",        &bcm6368_quirks            },
>>>    { "brcm,bcm63168",        &bcm6368_quirks            },
>>>    { },
>>
>> <snip>
>>
>>> +
>>> +static inline int is_bmips_internal_registers(phys_addr_t offset)
>>> +{
>>> +    if (offset >= 0xfff00000)
>>> +        return 1;
>>> +
>>> +    return 0;
>>
>> That should probably be refined to be looking at the SoC/CPU you are running on, using eventually of_machine_is_compatible on the SoC-specific compatible string. For instance, on 6368 and newer, the physical register offset moves to PA 0x1000_0000.
>>
>> Thanks!
>>
>> -- 
>> Florian


-- 
Florian
