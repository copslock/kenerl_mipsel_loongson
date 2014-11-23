Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2014 10:45:26 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57390 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006659AbaKWJpZTw4Yb convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Nov 2014 10:45:25 +0100
Received: by mail-ie0-f169.google.com with SMTP id y20so7372958ier.0
        for <multiple recipients>; Sun, 23 Nov 2014 01:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Ae6ruYkxqUx+DmT3+Y73UclQlBy7ZES0cxCpVevkX5Y=;
        b=juad6bVlxarz0P4A1D+hRCwqYnvq5X9ZfnQHLlHGylt691/nDovmbL73eW3yY40pyR
         JOz5IpO7/qty2wUbY92YQ8gCNJS4woHHqkPNyhZEK6f5RLJaEgiCmgo3la/3C2U2cQF1
         N8bDd/NMpZM0+gN2EDeZpAZsIXLDl3Y3xLrrjcHHoerlTbPbNg/5irMlb3qh3PiI3JJY
         FZnMdfxxjl0mouGn57yxCuPPrXE2oQ0kS4FZzQwfU/lRCfoyBysNadSfiZH1/qVpIE8k
         t3zl8HRGGbeFCmhyKzZJjRx2qWDceGpUaKvgZ8AtS5iqU9h2QnztPZU5ptFRxekd682v
         E+BQ==
MIME-Version: 1.0
X-Received: by 10.50.88.69 with SMTP id be5mr6406205igb.21.1416735919471; Sun,
 23 Nov 2014 01:45:19 -0800 (PST)
Received: by 10.107.14.9 with HTTP; Sun, 23 Nov 2014 01:45:19 -0800 (PST)
In-Reply-To: <5463CE30.2080405@hauke-m.de>
References: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
        <5463CE30.2080405@hauke-m.de>
Date:   Sun, 23 Nov 2014 10:45:19 +0100
Message-ID: <CACna6rwq+e83me_nGQDccwSJ=sSOUF6gFLF1HSRCp3OHox-KFg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44348
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

On 12 November 2014 at 22:16, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 11/11/2014 08:45 PM, Rafał Miłecki wrote:
>> After Broadcom switched from MIPS to ARM for their home routers we need
>> to have NVRAM driver in some common place (not arch/mips/).
>> We were thinking about putting it in bus directory, however there are
>> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
>> won't fit there neither.
>> This is why I would like to move this driver to the drivers/misc/
>
> I will do a more detailed review when you send a patch with -M
>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>> ---
>>  arch/mips/Kconfig                                  |   1 +
>>  arch/mips/bcm47xx/Makefile                         |   2 +-
>>  arch/mips/bcm47xx/board.c                          |   2 +-
>>  arch/mips/bcm47xx/nvram.c                          | 228 --------------------
>>  arch/mips/bcm47xx/setup.c                          |   1 -
>>  arch/mips/bcm47xx/sprom.c                          |   1 -
>>  arch/mips/bcm47xx/time.c                           |   1 -
>>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h       |   1 +
>>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  21 --
>>  drivers/bcma/driver_mips.c                         |   2 +-
>>  drivers/misc/Kconfig                               |   9 +
>>  drivers/misc/Makefile                              |   1 +
>>  drivers/misc/bcm47xx_nvram.c                       | 230 +++++++++++++++++++++
>>  drivers/net/ethernet/broadcom/b44.c                |   2 +-
>>  drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
>>  drivers/ssb/driver_chipcommon_pmu.c                |   2 +-
>>  drivers/ssb/driver_mipscore.c                      |   2 +-
>>  include/linux/bcm47xx_nvram.h                      |  18 ++
>>  18 files changed, 267 insertions(+), 259 deletions(-)
>>  delete mode 100644 arch/mips/bcm47xx/nvram.c
>>  delete mode 100644 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
>>  create mode 100644 drivers/misc/bcm47xx_nvram.c
>>  create mode 100644 include/linux/bcm47xx_nvram.h
>
> ....
>
>> diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
>> new file mode 100644
>> index 0000000..5ed6917
>> --- /dev/null
>> +++ b/include/linux/bcm47xx_nvram.h
>> @@ -0,0 +1,18 @@
>> +/*
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>> + */
>> +
>> +#ifndef __BCM47XX_NVRAM_H
>> +#define __BCM47XX_NVRAM_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
>> +
>> +int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
>> +int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
>> +int bcm47xx_nvram_gpio_pin(const char *name);
>
> Could you change this to something like this:
>
> #ifdef CONFIG_BCM47XX_NVRAM
> int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
> int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
> int bcm47xx_nvram_gpio_pin(const char *name);
> #else
> static inline int bcm47xx_nvram_init_from_mem(u32 base, u32 lim) {return
> -1;};
> static inline int bcm47xx_nvram_getenv(const char *name, char *val,
> size_t val_len) {return -1;};
> static inline int bcm47xx_nvram_gpio_pin(const char *name) {return -1;};
> #endif
>
> and use something better than -1.
>
> This way we can get rid of these  all other the code.
> #ifdef CONFIG_BCM47XX
> ..
> #endif

How many drivers using
#ifdef CONFIG_BCM47XX
bcm47xx_nvram_foo(...)
#endif
do we have?

I think right now it is done in
drivers/bcma/driver_mips.c
but should be dropped anyway. We should make BCMA_DRIVER_MIPS depend on BCM47XX.

And second usage is in:
drivers/net/ethernet/broadcom/b44.c

Do you think it's worth doing just for b44.c?

-- 
Rafał
