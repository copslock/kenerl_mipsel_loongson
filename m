Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2014 12:23:03 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:48009 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006659AbaKWLXBAPqsu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Nov 2014 12:23:01 +0100
Received: from [192.168.178.21] (host-091-097-251-142.ewe-ip-backbone.de [91.97.251.142])
        by hauke-m.de (Postfix) with ESMTPSA id 754E320010;
        Sun, 23 Nov 2014 12:23:00 +0100 (CET)
Message-ID: <5471C393.2060204@hauke-m.de>
Date:   Sun, 23 Nov 2014 12:22:59 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
References: <1415735146-31552-1-git-send-email-zajec5@gmail.com>        <5463CE30.2080405@hauke-m.de> <CACna6rwq+e83me_nGQDccwSJ=sSOUF6gFLF1HSRCp3OHox-KFg@mail.gmail.com>
In-Reply-To: <CACna6rwq+e83me_nGQDccwSJ=sSOUF6gFLF1HSRCp3OHox-KFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 11/23/2014 10:45 AM, Rafał Miłecki wrote:
> On 12 November 2014 at 22:16, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> On 11/11/2014 08:45 PM, Rafał Miłecki wrote:
>>> After Broadcom switched from MIPS to ARM for their home routers we need
>>> to have NVRAM driver in some common place (not arch/mips/).
>>> We were thinking about putting it in bus directory, however there are
>>> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
>>> won't fit there neither.
>>> This is why I would like to move this driver to the drivers/misc/
>>
>> I will do a more detailed review when you send a patch with -M
>>
>>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>> ---
>>>  arch/mips/Kconfig                                  |   1 +
>>>  arch/mips/bcm47xx/Makefile                         |   2 +-
>>>  arch/mips/bcm47xx/board.c                          |   2 +-
>>>  arch/mips/bcm47xx/nvram.c                          | 228 --------------------
>>>  arch/mips/bcm47xx/setup.c                          |   1 -
>>>  arch/mips/bcm47xx/sprom.c                          |   1 -
>>>  arch/mips/bcm47xx/time.c                           |   1 -
>>>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h       |   1 +
>>>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  21 --
>>>  drivers/bcma/driver_mips.c                         |   2 +-
>>>  drivers/misc/Kconfig                               |   9 +
>>>  drivers/misc/Makefile                              |   1 +
>>>  drivers/misc/bcm47xx_nvram.c                       | 230 +++++++++++++++++++++
>>>  drivers/net/ethernet/broadcom/b44.c                |   2 +-
>>>  drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
>>>  drivers/ssb/driver_chipcommon_pmu.c                |   2 +-
>>>  drivers/ssb/driver_mipscore.c                      |   2 +-
>>>  include/linux/bcm47xx_nvram.h                      |  18 ++
>>>  18 files changed, 267 insertions(+), 259 deletions(-)
>>>  delete mode 100644 arch/mips/bcm47xx/nvram.c
>>>  delete mode 100644 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
>>>  create mode 100644 drivers/misc/bcm47xx_nvram.c
>>>  create mode 100644 include/linux/bcm47xx_nvram.h
>>
>> ....
>>
>>> diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
>>> new file mode 100644
>>> index 0000000..5ed6917
>>> --- /dev/null
>>> +++ b/include/linux/bcm47xx_nvram.h
>>> @@ -0,0 +1,18 @@
>>> +/*
>>> + *  This program is free software; you can redistribute  it and/or modify it
>>> + *  under  the terms of  the GNU General  Public License as published by the
>>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>>> + *  option) any later version.
>>> + */
>>> +
>>> +#ifndef __BCM47XX_NVRAM_H
>>> +#define __BCM47XX_NVRAM_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/kernel.h>
>>> +
>>> +int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
>>> +int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
>>> +int bcm47xx_nvram_gpio_pin(const char *name);
>>
>> Could you change this to something like this:
>>
>> #ifdef CONFIG_BCM47XX_NVRAM
>> int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
>> int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
>> int bcm47xx_nvram_gpio_pin(const char *name);
>> #else
>> static inline int bcm47xx_nvram_init_from_mem(u32 base, u32 lim) {return
>> -1;};
>> static inline int bcm47xx_nvram_getenv(const char *name, char *val,
>> size_t val_len) {return -1;};
>> static inline int bcm47xx_nvram_gpio_pin(const char *name) {return -1;};
>> #endif
>>
>> and use something better than -1.
>>
>> This way we can get rid of these  all other the code.
>> #ifdef CONFIG_BCM47XX
>> ..
>> #endif
> 
> How many drivers using
> #ifdef CONFIG_BCM47XX
> bcm47xx_nvram_foo(...)
> #endif
> do we have?
> 
> I think right now it is done in
> drivers/bcma/driver_mips.c
> but should be dropped anyway. We should make BCMA_DRIVER_MIPS depend on BCM47XX.
> 
> And second usage is in:
> drivers/net/ethernet/broadcom/b44.c
> 
> Do you think it's worth doing just for b44.c?
> 

There is also a call in
drivers/ssb/driver_chipcommon_pmu.c

In addition
drivers/net/ethernet/broadcom/bgmac.c:
calls bcm47xx_nvram_foo(...) without any ifdef and depends on this.

I think it would be best to separate these two things and and try to
remove the ifdefs in a separate patch.

Hauke
