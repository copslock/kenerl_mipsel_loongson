Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 23:14:27 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:6894 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006917AbaHZVO0k0ntn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 23:14:26 +0200
X-IronPort-AV: E=Sophos;i="5.04,406,1406617200"; 
   d="scan'208";a="43521448"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 26 Aug 2014 14:29:27 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 26 Aug 2014 14:14:18 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Tue, 26 Aug 2014 14:14:17 -0700
Received: from [10.176.128.58] (xl-bun-04.bun.broadcom.com [10.176.128.58])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 76D5727A82;        Tue, 26 Aug
 2014 14:14:16 -0700 (PDT)
Message-ID: <53FCF8A7.4090807@broadcom.com>
Date:   Tue, 26 Aug 2014 23:14:15 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <53FCEECA.8090308@hauke-m.de>
In-Reply-To: <53FCEECA.8090308@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

On 08/26/14 22:32, Hauke Mehrtens wrote:
> On 08/26/2014 06:42 PM, Rafał Miłecki wrote:
>> [cross-list: linux-mips@ and linux-wireless@]
>>
>> We're working on another Broadcom platform, SoC with an ARM CPU,
>> platform called bcm53xx. It shares many things with the older (MIPS
>> based) bcm47xx, so we need to figure out how to modify some of the
>> drivers.
>>
>> Hauke recently proposed sharing code for NVRAM support as a separated
>> driver. In his RFC patch it was added as a new platform driver. I
>> liked this idea (I'd simply prefer to modify existing code instead of
>> duplicating it), so I played with it a bit today.
>
> I will also make mips bcm47xx uses that code in the next version of the
> patch. (move the code from mips)
>
>>
>> My plan was to modify bcm47xx code to make nvram.c a separated driver
>> and update bcm47xx/bcma to use it. Well, it didn't work out. The
>> problem is that we need access to the NVRAM pretty early. Please take
>> a look at my description of bcm47xx booting process (it's simply a
>> summary of start_kernel and bcm47xx code):
>>
>> 1) prom_init / plat_mem_setup
>> These two functions are called in pretty much the same phase from the
>> setup_arch (arch/mips/kernel/setup.c).
>> Task: detect&  register memory
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
>>
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
> I would make this nvram.c a platform driver in addition so it can get
> registered to device tree. this part would only get activated when
> CONFIG_OF is set which is not on MIPS bcm47xx.
>
>> 2) I was also thinking about cleaning bcm47xx init. Right now we do a
>> lot of hacks in plat_mem_setup&  bcma to register the bus and scan its
>> cores. It's so early (before mm_init) that we can't alloc memory!
>> Doing all this stuff slightly later (e.g. arch_init_irq) would allow
>> us to simply use "kmalloc" and drop all current hacks in bcma.
>>
>> 3) Above change (point 2) would require some small change in bcma. We
>> would need 2-stages init: detecting (with kmalloc!) bus cores,
>> registering cores. This is required, because we can't register cores
>> too early, device_add (and the underlying kobject) would oops/WARN in
>> kobject_get.
>>
>
> This sound good to me, but I still have some questions.
>
> Do you also want to change ssb registration?
> Is it worth the effort? I think MIPS bcm47xx will be EOL and replaced by
> the ARM versions completely in the next years. (I do not have any
> private information about Broadcom product politics)

I am not a (product) politician as well, but I think it is a safe 
assumption.

Regards,
Arend
