Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 10:42:27 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35499 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009415AbcARJmV24ClT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jan 2016 10:42:21 +0100
Received: by mail-wm0-f67.google.com with SMTP id 123so8196689wmz.2;
        Mon, 18 Jan 2016 01:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6h6mU99wENncXV5lUIwSKl8CuEPHFKIfRPPnbHNp/qE=;
        b=itmEkHP3H1dV8IdpuWdlRUSKaBS09WPlihnAN2BFp7EL4Z5Z4S/AejSfXm+4HZd8D9
         vUxjmYIcHXMM/3DYmrN05jWYA5hrg6NbOufdSE3xjf8oMulND+juL0tlciw0v9FpBKVS
         Nftjy5P3c17X7x4FBJGV5cRkStTSsuLxJsRsURIyjzDyuo6JufV+TWwPptv4eBwxPkzF
         1JDvCFbfk6wFiPYI6ZFzf6hr6P/NIO5fxZYzEOFhzCy1eENuREvkq6hJlH//6KPqTahz
         Ux/kC4wdbPGHmEAKfsRlM7MPyiMag4JIfi4+wk14TXQ7ttfVMdIuPBoLkQ8rSXGOpFFU
         e9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=6h6mU99wENncXV5lUIwSKl8CuEPHFKIfRPPnbHNp/qE=;
        b=RfmqIzE3S3qIXt8vIVFCJN51zjeKV3QqnHeeccjTNCGcLtoD1UNqBzAnz+XQVEq8oi
         vzSMyl3OrsNHaLFL4RFWjV/6ztURg5gZP+7h/NrJ+jjU4XFLx/HXGyAvKUCKSW0tDxaj
         joXSEGvtqRsiETD9kgwIniLQdUWIhZ96rbopSZKxHgeaJ4T9vr/9h0DL9wUbDA/TcsSs
         SgFSYD21DuJ07mitybNxS7VovPnARd1I/DoYxJfC6NUg9DNQtdmYqk8p6GHQTzhH8LjD
         Hy2T8jIsHvasumdx1dVz0a/mGZ5D0tZ6hu7xdM9yzmrzz6q3XxYoWDC+1kB0nLYMUAPj
         B2CQ==
X-Gm-Message-State: ALoCoQl7zijhC7s7/bqYxKFqZXw2A0+Spy1cLDIZyttUKmu5pAcNaAvCvYcBe6tHLsw3DcbnROpkPxXtldopabiPWcho9Wqd7w==
X-Received: by 10.194.87.1 with SMTP id t1mr22715183wjz.170.1453110136210;
        Mon, 18 Jan 2016 01:42:16 -0800 (PST)
Received: from [10.48.148.95] ([31.221.207.48])
        by smtp.gmail.com with ESMTPSA id w80sm14915628wme.17.2016.01.18.01.42.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jan 2016 01:42:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] bmips: add BCM6358 support
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
X-Mailer: iPhone Mail (13C75)
In-Reply-To: <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com>
Date:   Mon, 18 Jan 2016 10:42:13 +0100
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BF36180D-DB32-42A5-AFF7-2B282F5A81DC@gmail.com>
References: <1453030101-14794-1-git-send-email-noltari@gmail.com> <0BC6030C-7485-4193-B86D-E690BF673952@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

I can refine it to support a custom offset for each cpu instead of a generic one, but defining a custom offset for new SoCs such as BCM6368 or BCM6328 would actually break them, since that way the address wouldn't be remapped to 0xb0000000.
See: https://github.com/torvalds/linux/blob/master/arch/mips/include/asm/io.h#L213
In those CPUs the remapping is done automatically (from 0x10000000 to 0xb0000000), since the registers are located in the low 512MB of address space (0x1fffffffULL).

However, the older CPUs such as BCM6358 (or BCM3368) need that custom ioremap, since those registers aren't located in the low 512MB of address space.
If you want, I can do something like this: https://gist.github.com/Noltari/bc5fe029c52cf053a454
And after that we could add other CPUs such as the BCM3368, which needs a different offset: "{ "brcm,bcm3368", 0xfff80000 }"

What do you think? Should we keep a generic offset (0xfff00000) or should we add SoC specific compatible strings with each custom offset?

Regards,
Álvaro.

> El 18 ene 2016, a las 7:49, Florian Fainelli <f.fainelli@gmail.com> escribió:
> 
>> On January 17, 2016 3:28:20 AM PST, "Álvaro Fernández Rojas" <noltari@gmail.com> wrote:
>> BCM6358 has a shared TLB which conflicts with current SMP support, so
>> it must
>> be disabled for now.
>> BCM6358 uses >= 0xfff00000 addresses for internal registers, which need
>> to be
>> remapped (by using a simplified version of BRCM63xx ioremap.h).
>> 
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
>> arch/mips/bmips/setup.c                    | 10 +++++++++
>> arch/mips/include/asm/mach-bmips/ioremap.h | 33
>> ++++++++++++++++++++++++++++++
>> 2 files changed, 43 insertions(+)
>> create mode 100644 arch/mips/include/asm/mach-bmips/ioremap.h
>> 
>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>> index 3553528..38b5bd5 100644
>> --- a/arch/mips/bmips/setup.c
>> +++ b/arch/mips/bmips/setup.c
>> @@ -95,6 +95,15 @@ static void bcm6328_quirks(void)
>>        bcm63xx_fixup_cpu1();
>> }
>> 
>> +static void bcm6358_quirks(void)
>> +{
>> +    /*
>> +     * BCM6358 needs special handling for its shared TLB, so
>> +     * disable SMP for now
>> +     */
>> +    bmips_smp_enabled = 0;
>> +}
> 
> That part looks good.
> 
>> +
>> static void bcm6368_quirks(void)
>> {
>>    bcm63xx_fixup_cpu1();
>> @@ -104,6 +113,7 @@ static const struct bmips_quirk bmips_quirk_list[]
>> = {
>>    { "brcm,bcm3384-viper",        &bcm3384_viper_quirks        },
>>    { "brcm,bcm33843-viper",    &bcm3384_viper_quirks        },
>>    { "brcm,bcm6328",        &bcm6328_quirks            },
>> +    { "brcm,bcm6358",        &bcm6358_quirks            },
>>    { "brcm,bcm6368",        &bcm6368_quirks            },
>>    { "brcm,bcm63168",        &bcm6368_quirks            },
>>    { },
> 
> <snip>
> 
>> +
>> +static inline int is_bmips_internal_registers(phys_addr_t offset)
>> +{
>> +    if (offset >= 0xfff00000)
>> +        return 1;
>> +
>> +    return 0;
> 
> That should probably be refined to be looking at the SoC/CPU you are running on, using eventually of_machine_is_compatible on the SoC-specific compatible string. For instance, on 6368 and newer, the physical register offset moves to PA 0x1000_0000.
> 
> Thanks!
> 
> -- 
> Florian
