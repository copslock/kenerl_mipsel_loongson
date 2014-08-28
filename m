Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 12:47:36 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48168 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007191AbaH1KrfGNrDl convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Aug 2014 12:47:35 +0200
Received: by mail-ie0-f172.google.com with SMTP id rd18so708501iec.3
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uR0yfr11bwe8ly1nFIQU2/LCy50YgzkHu+UN8d3S1sw=;
        b=ZnjLNrZiPbfMwPO9i34WSSqmLiWeKE1O8pNimZ8iGi+IazMuylGCvYHcT+v2stocGq
         JlJlAlVM/nHKtyEHxcSLWBF91UpGPnWR5z5OFRzkX5P61htEKZG+aHpbyDny/VhwZILB
         P6B4GxpqbqCKhC9DfftNNjvW5mSXcg+74mIIlIGVYh+VL983UD2DUsAawKLG45WwpWRQ
         YQN9AkQIk50zdpxzJGhq/UuOkszO3nm35XJ6UwZvMMtrVmTAdhjbQlswZesFCP/Ef+m8
         pXNMu8Msi06OR7bIz/nkOTbXUHVolk6S1B2aOA0NGYFP2xpY8rBqI3jlP7E4U26fJFym
         Aw3g==
MIME-Version: 1.0
X-Received: by 10.42.212.146 with SMTP id gs18mr152022icb.96.1409222849222;
 Thu, 28 Aug 2014 03:47:29 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Thu, 28 Aug 2014 03:47:29 -0700 (PDT)
In-Reply-To: <3222444.6Ji0x5QqTP@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <3222444.6Ji0x5QqTP@wuerfel>
Date:   Thu, 28 Aug 2014 12:47:29 +0200
Message-ID: <CACna6rwO4qOR_pg-aOt87cdb=HfgdeOeMV_KGvsUyR7kDjnKWg@mail.gmail.com>
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
X-archive-position: 42304
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

On 28 August 2014 12:13, Arnd Bergmann <arnd@arndb.de> wrote:
>> 1) prom_init / plat_mem_setup
>> These two functions are called in pretty much the same phase from the
>> setup_arch (arch/mips/kernel/setup.c).
>> Task: detect & register memory
>> Requires: CPU type, maybe Broadcom chip ID (highmem support)
>> Available: CPU type
>> Not available: kmalloc, device_add (kobject)
>>
>> 2) arch_init_irq
>> Called from the arch specific init_IRQ (arch/mips/kernel/irq.c)
>> Task: setup bcma's MIPS core
>> Requires: bcma bus MIPS core
>> Available: kmalloc
>> Not available: device_add (kobject)
>>
>> 3) plat_time_init
>> Called from the arch specific time_init (arch/mips/kernel/time.c)
>> Task: set frequency
>> Requires: bcma bus ChipCommon core, nvram
>> Available: kmalloc
>> Not available: device_add (kobject)
>
> My impression is that all the information that you need in these early
> three steps is stuff that is already meant to be part of DT.
> This isn't surprising, because the bcm47xx serves a similar purpose
> to DT, it's just more specialized.
>
> This duplication is a bit unfortunate, but it seems that just using
> the respective information from DT would be easier here.
>
> Is any of the information you need early dynamic? It sounds that
> for a given SoC, it should never change and can just be statically
> encoded in DT.

I'm not sure which info you exactly are talking about. I believe one
SoC model always use the same CPU, ChipCommon, embedded wireless and
PCIe + USB controllers. However amount of RAM, type of flash (serial
vs. NAND), size of flash, booting method, NVRAM location, etc. all
depend on vendor's choice. I think CPU speed could also depend on
vendor choice.


>> 4) At some point we need to register bcma devices, device_initcall can
>> be used for that
>>
>> As you can see, we need access to the NVRAM quite early (step 3,
>> plat_time_init, or even earlier), but device_add (platform
>> devices/drivers) is not available then yet. So I'm afraid we won't be
>> able to use this common way to write NVRAM driver.
>>
>>
>> So there I want to present my plan for the NVRAM improvements. If you
>> don't agree with any part of it, or you can see any better solution,
>> please speak up!
>>
>> 1) I won't make nvram.c a platform driver. Instead I would like to
>> make it less bcm47xx specific. I don't want to touch bcm47xx_bus in
>> this file. Instead I want to add a generic function that will accept
>> address and size of memory where NVRAM should be found. Then I'd like
>> to move this file out of "mips" arch (drivers/misc/?
>> drivers/bcma/nvram/?) and allow using it for bcm53xx.
>
> In general, I'd try to avoid adding any platform specific code on ARM
> when it needs to run as something other than a device driver.
> Moving the code out of arch/mips and making it more generic definitely
> sounds good to me, but I'd prefer to have an actual platform_driver
> for it.

Sure, I didn't want to add NVRAM driver into arch/arm/ :)

Can you see any solution for making NVRAM support a standard platform
driver on MIPS and ARM? As I said, on MIPS we need access to the NVRAM
really early, before platform devices/drivers can operate.


>> 3) Above change (point 2) would require some small change in bcma. We
>> would need 2-stages init: detecting (with kmalloc!) bus cores,
>> registering cores. This is required, because we can't register cores
>> too early, device_add (and the underlying kobject) would oops/WARN in
>> kobject_get.
>
> Right. Could you do the bcma scan much later, at the time when
> device_add works as well? Traditionally PCI has been a problem
> since it had to be enabled really early, but that restriction
> should be gone now, and we can actually probe it from a loadable
> module.

Take a look at "arch_init_irq" I described above. It needs access to
the MIPS core (bcma bus contains many cores). To get access to this
core (to know it exists and to get it mapped), I need to scan the bus.


> On a global level, there is another choice, which is to do something
> similar to the 'pxa-impedence-matcher' and the 'sunxi-babelfish':
> These are two projects that implement a last-stage boot loader that
> runs before the kernel and translates a platform-specific boot format
> into standard DTB format. We could do the same for bcm53xx and
> translate any nvram strings we know about into properties of device
> nodes we already have, and copy all remaining strings into a
> properties of the /chosen node. That way, we don't even need any
> nvram driver for ARM, except a trivial one that provides raw
> write access to user space for updating it.

I think on bcm53xx early access to the NVRAM is less important, so
this may be not such a big problem at all.

-- 
Rafał
