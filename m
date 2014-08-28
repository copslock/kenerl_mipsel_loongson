Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 18:00:58 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35457 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007231AbaH1QA5AY8wz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Aug 2014 18:00:57 +0200
Received: by mail-ie0-f181.google.com with SMTP id rp18so1161777iec.26
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=whatLFO29xbe4XuZjshRPIV8lrbse3id/xR0nO1eml0=;
        b=pFTeba0zI46AQbuP1cB47ubtuYdgRxfWO303gNMilGI08+yqrjcSbx4TMFknUGhtpN
         KS9VAH2JFswfbIYcQoDHISufP61+SakMcrTjQXv+N/SNXvrlwJgPozrW9DRjSJmrHwQN
         3zgc5tRgdUC5mhTW6BwosXJ7p59u6x0KMZqHYxOKJFrYx05/88fFVlXC2Vq/CERzaBcZ
         NUrwkgpaFf7g3iEOLxNEB2LoHq0mwNGL0l88NgJJGUDmMw+THjf+h5l43cXDoSxbzj6G
         du9yTkf7Eo1Ri9doAEKkrMsYjOYNIbq+yR3qcwxFfWc0s4iAqA53vcZsUZqufkdhb+vb
         earw==
MIME-Version: 1.0
X-Received: by 10.50.62.50 with SMTP id v18mr38701355igr.21.1409241649841;
 Thu, 28 Aug 2014 09:00:49 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Thu, 28 Aug 2014 09:00:49 -0700 (PDT)
In-Reply-To: <6633831.1CSHMPPLH1@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <2859425.94ptgpItD3@wuerfel>
        <CACna6rx0E_s76wLLkDjj90sXH=Q3yzBemQM5Qrp96QiWCWr0qg@mail.gmail.com>
        <6633831.1CSHMPPLH1@wuerfel>
Date:   Thu, 28 Aug 2014 18:00:49 +0200
Message-ID: <CACna6rwKheOAogaeeDd5pLNaRo=Zq0euURTT87BY-S1MdOWwVQ@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 28 August 2014 17:32, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 August 2014 14:37:54 Rafał Miłecki wrote:
>> To make booting possible, flash content is mapped to the memory. We're
>> talking about read only access. This mapping allows CPU to get code
>> (bootloader) and execute it as well as it allows CFE to get NVRAM
>> content easily. You don't need flash driver (with erasing & writing
>> support) to read NVRAM.
>
> Ok. Just out of curiosity, how does the system manage to map NAND
> flash into physical address space? Is this a feature of the SoC
> of the flash chip?

I don't know exactly. Many (all?) device with BCM4706 SoC have two
flashes. Serial flash (~2 MiB) with bootloader + nvram and NAND flash
with the firmware. However Netgear WNR3500Lv2 (based on BCM47186B0)
has only a NAND flash.


> I guess for writing you'd still use the full MTD driver, right?

That's right. This is why I wrote about "talking about read only access".


>> Depending on the boot flash device, content of flash is mapped at
>> different offsets:
>> 1) MIPS serial flash: SI_FLASH2 (0x1c000000)
>> 2) MIPS NAND flash: SI_FLASH1 (0x1fc00000)
>> 3) ARM serial flash: SI_NS_NORFLASH (0x1e000000)
>> 4) ARM NAND flash: SI_NS_NANDFLASH (0x1c000000)
>>
>> So on my ARM device with serial flash (connected over SPI) I was able
>> to get NVRAM header this way:
>>
>> void __iomem *iobase = ioremap_nocache(0x1e000000, 0x1000000);
>> u8 *buf;
>>
>> buf = (u8 *)(iobase + 0xff0000);
>> pr_info("[NVRAM] %02X %02X %02X %02X\n", buf[0], buf[1], buf[2], buf[3]);
>>
>> This resulted in:
>> [NVRAM] 46 4C 53 48
>>
>> (I hardcoded 0xff0000 above, normally you would need to try 0x10000,
>> 0x20000, 0x30000 and so on...).
>
> Does that mean the entire 0x1e000000-0x1f000000 area is mapped to
> the flash and you are looking for the nvram in it, or that you don't
> know where it is?

The correct algorithm would be:
for (off = 0; off < SOME_LIMIT; off += 0x10000) {
    buf = (u8 *)(iobase + off);
    if (buf[0] == 0x46 && buf[1] == 0x4C) {
        pr_info("NVRAM found at 0x%X offset\n", off);
        break;
    }
}

-- 
Rafał
