Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 20:23:02 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34004 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010921AbcARTXAcQYIa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 20:23:00 +0100
Received: by mail-ob0-f173.google.com with SMTP id vt7so169394602obb.1;
        Mon, 18 Jan 2016 11:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=2R0mlNalTAj8wETR2789hon024B1s2ShUiewWmHSh4Q=;
        b=R8EHwXA6HaedqpvPGP5o/8TaJJ5BbZwU1tnNpdymklBSDFflu6vJ8W1huuuSm01CKc
         voFkk4tzlqGbGdL55Zg9WEDaQE5TEenhyMG2gnll/QzMJkfyEfd5+DMK6dWKDCpodwoS
         62V+YTvi7Nz2e9pbHPGcFcT9p2Mw7JvlAhHqavRcuoTyJ3gSrL07EBgnHQFqjVkMgAQh
         3gnW8fR9gpgBP/dr0KNr4Yth0j/wuByfiZQVVg3jzu37ssXuRiaSBicSSDd2O1fe3kZg
         fqreZw/zc9ts0mvQCOmwiTjVLre2qbIsrdEijJVmzMshp6ReFfvfGsIX4oSoThW2oYLd
         LSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2R0mlNalTAj8wETR2789hon024B1s2ShUiewWmHSh4Q=;
        b=LrExYIyron/jM7CupjSOzuFiAwPVXKZvXVP8Hj+9O42yc+L617a5PBaJQ6RyYIJE99
         I9CP83+5RNc6Z5BhDzPsBuwGgeDUAZHZBw9jqvgA0+I3GXdPPGoFQULxm9LpELS9v99O
         TedAs5lgxrUt0M8DEE+8p/9sglnIDCV+ZQe47lK9HQ1goEhm/LKmG99TgL8RvZR7gnML
         0+kHgBVxsftYx6dzfriAEExHP+B44R3QafVfVuYgKrBo4hZowH7oOI0wgdRVFXJaYJLc
         rfjgCjI8oYY6Y0fmSKTMrpueogwE/EC+w17FfyYV+mPjEGmooAx4f0VOEC3j3asL9X0p
         XgMw==
X-Gm-Message-State: ALoCoQlkSm35ifN9n5YL7U8hdvpd1X5EclsifFgCLc8guHFzbN9WNp4B1oi4bwA6BeGlsOzaJtDX4I32Zt7Cj3BcPOP9RoG8Tw==
X-Received: by 10.60.232.194 with SMTP id tq2mr19681242oec.64.1453144974572;
        Mon, 18 Jan 2016 11:22:54 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:3518:aff0:c491:7d67? ([2001:470:d:73f:3518:aff0:c491:7d67])
        by smtp.googlemail.com with ESMTPSA id s200sm13554472oie.2.2016.01.18.11.22.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 11:22:54 -0800 (PST)
Subject: Re: [PATCH 1/2] bmips: add BCM6358 support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <1453030101-14794-1-git-send-email-noltari@gmail.com>
 <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com>
 <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <569D3B8D.6040603@gmail.com>
Date:   Mon, 18 Jan 2016 11:22:53 -0800
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
X-archive-position: 51203
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

(please don't top post)

Le 18/01/2016 01:42, Álvaro Fernández Rojas a écrit :
> I can refine it to support a custom offset for each cpu instead of a generic one, but defining a custom offset for new SoCs such as BCM6368 or BCM6328 would actually break them, since that way the address wouldn't be remapped to 0xb0000000.
> See: https://github.com/torvalds/linux/blob/master/arch/mips/include/asm/io.h#L213
> In those CPUs the remapping is done automatically (from 0x10000000 to 0xb0000000), since the registers are located in the low 512MB of address space (0x1fffffffULL).

These registers are always accessible AFAIR, either through KSEG3
(0xFF00_0000), or through KSEG1 (0xB000_0000) for newer SoCs, and in
arch/mips/include/asm/io.h, the first thing we do is call
plat_ioremap(), if the address returned is valid, we just bail out and
do not execute the snippet you are indicating.

> 
> However, the older CPUs such as BCM6358 (or BCM3368) need that custom ioremap, since those registers aren't located in the low 512MB of address space.
> If you want, I can do something like this: https://gist.github.com/Noltari/bc5fe029c52cf053a454
> And after that we could add other CPUs such as the BCM3368, which needs a different offset: "{ "brcm,bcm3368", 0xfff80000 }"
> 
> What do you think? Should we keep a generic offset (0xfff00000) or should we add SoC specific compatible strings with each custom offset?

I would prefer we maintain the existing logic from
arch/mips/include/asm/mach-bcm63xx/ioremap.h. If needed we could do this
in a two level step, where plat_ioremap() calls a helper function, and
this helper function has been scanning the Device Tree for the bus
register space.

Jonas' suggestion works too.

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
