Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 13:40:03 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57913 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007017AbaH1LkB60VeR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Aug 2014 13:40:01 +0200
Received: by mail-ie0-f182.google.com with SMTP id rd18so775625iec.27
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ewm6cfp4sFtdsLKe54h8MzStQsrxuFewyuPltFZm6yc=;
        b=b19sRAXptu7qiblN5kB4/qoHq3zTZWucRx6Y5hTBW2dL6h7Iz0lnhhSdzn19aATOsu
         TCsoajqjR51eQ6RyvAvgYtNp8QIQxg0nuEZkrFCsZ6Vm0dWQYMWz0VTivOHOLzvhqWhs
         NeWr3sFzYj1RrNTsucxtliV1xT8oDqUqcYWPCm942y7CLQkHnnDp5xg/o0FgpJin/zu4
         2kU+ZbEEl+iGLvPvKQ7ZUyCfEaR+4nV5rutkeuL+kXT13TUz+6Fa3fJASTrgupklq955
         sI6qmazFn8HOuEBaKbbiXob12fYUIHQQwarrsx7Q8qA3bpPV/uXr/7qat1TJ01xqmbcs
         sR8w==
MIME-Version: 1.0
X-Received: by 10.42.212.146 with SMTP id gs18mr203056icb.96.1409225995641;
 Thu, 28 Aug 2014 04:39:55 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Thu, 28 Aug 2014 04:39:55 -0700 (PDT)
In-Reply-To: <3921668.sgOLRYjGUr@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <3222444.6Ji0x5QqTP@wuerfel>
        <CACna6rwO4qOR_pg-aOt87cdb=HfgdeOeMV_KGvsUyR7kDjnKWg@mail.gmail.com>
        <3921668.sgOLRYjGUr@wuerfel>
Date:   Thu, 28 Aug 2014 13:39:55 +0200
Message-ID: <CACna6rwnz0TGZ8QgW39o4MPfXTp1a1h8naDJqEGVV4UqtkgaWw@mail.gmail.com>
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
X-archive-position: 42306
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

On 28 August 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 August 2014 12:47:29 Rafał Miłecki wrote:
>> On 28 August 2014 12:13, Arnd Bergmann <arnd@arndb.de> wrote:
>> > My impression is that all the information that you need in these early
>> > three steps is stuff that is already meant to be part of DT.
>> > This isn't surprising, because the bcm47xx serves a similar purpose
>> > to DT, it's just more specialized.
>> >
>> > This duplication is a bit unfortunate, but it seems that just using
>> > the respective information from DT would be easier here.
>> >
>> > Is any of the information you need early dynamic? It sounds that
>> > for a given SoC, it should never change and can just be statically
>> > encoded in DT.
>>
>> I'm not sure which info you exactly are talking about. I believe one
>> SoC model always use the same CPU, ChipCommon, embedded wireless and
>> PCIe + USB controllers. However amount of RAM, type of flash (serial
>> vs. NAND), size of flash, booting method, NVRAM location, etc. all
>> depend on vendor's choice. I think CPU speed could also depend on
>> vendor choice.
>
> But those would also be present in DT on ARM, right?

Well, that depends. Hauke was planning to put info about flash in DT.
Me on the other hand suggested reading info about flash from the
board. See my reply:
https://www.mail-archive.com/devicetree@vger.kernel.org/msg39365.html

My plan was to use patch like
[PATCH] bcma: get & store info about flash type SoC booted from
http://www.spinics.net/lists/linux-wireless/msg126163.html
(it would work on both: MIPS and ARM)
and then:

switch (boot_device) {
case BCMA_BOOT_DEV_NAND:
    nvram_address = 0x1000dead;
    break;
case BCMA_BOOT_DEV_SERIAL:
    nvram_address = 0x1000c0de;
    break;
}


>> >> 4) At some point we need to register bcma devices, device_initcall can
>> >> be used for that
>> >>
>> >> As you can see, we need access to the NVRAM quite early (step 3,
>> >> plat_time_init, or even earlier), but device_add (platform
>> >> devices/drivers) is not available then yet. So I'm afraid we won't be
>> >> able to use this common way to write NVRAM driver.
>> >>
>> >>
>> >> So there I want to present my plan for the NVRAM improvements. If you
>> >> don't agree with any part of it, or you can see any better solution,
>> >> please speak up!
>> >>
>> >> 1) I won't make nvram.c a platform driver. Instead I would like to
>> >> make it less bcm47xx specific. I don't want to touch bcm47xx_bus in
>> >> this file. Instead I want to add a generic function that will accept
>> >> address and size of memory where NVRAM should be found. Then I'd like
>> >> to move this file out of "mips" arch (drivers/misc/?
>> >> drivers/bcma/nvram/?) and allow using it for bcm53xx.
>> >
>> > In general, I'd try to avoid adding any platform specific code on ARM
>> > when it needs to run as something other than a device driver.
>> > Moving the code out of arch/mips and making it more generic definitely
>> > sounds good to me, but I'd prefer to have an actual platform_driver
>> > for it.
>>
>> Sure, I didn't want to add NVRAM driver into arch/arm/ :)
>
> What I meant is that I'd prefer to not even call a probe function
> for this driver from arch/arm. I may have misunderstood what you meant
> though.
>
>> Can you see any solution for making NVRAM support a standard platform
>> driver on MIPS and ARM? As I said, on MIPS we need access to the NVRAM
>> really early, before platform devices/drivers can operate.
>
> I think it would make sense to have a common driver that has both
> an 'early' init part used by MIPS and a regular init part used by
> ARM and potentially also on MIPS if we want. Most of the code can
> still be shared.

OK, now it's clear what you meant.
The thing is that we may want to call probe function from
drivers/bcma/main.c. I think we never meant to call it directly from
arch code. This code in drivers/bcma/main.c is used on both: MIPS and
ARM. So I wonder if there is much sense in doing it like
#ifdev MIPS
bcm47xx_nvram_init(nvram_address);
#endif
#ifdef ARM
nvram_device.resource[0].start = nvram_address;
platform_device_register(nvram_device);
#endif

What do you think about this?

-- 
Rafał
