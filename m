Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 01:04:16 +0200 (CEST)
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:21213
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992684AbeENXEH4KP9U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2018 01:04:07 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DcAABmFPpa/6SIBjoNTxsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGFR5k1BoEHIYEPlSqEdwKDMjgUAQIBAQEBAQEChjwBAQEBAgE4QQULCw0?=
 =?us-ascii?q?BCi5XBgEMBgIBAYMfgXQFqxuDCRqEPoNugieJMYEHgTIMglyKRwKYNgmOS4dxh?=
 =?us-ascii?q?QQrkV0zgXMzGggoCIJ+kGBdkQgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DcAABmFPpa/6SIBjoNTxsBAQEBAwEBAQkBAQGFR5k1BoE?=
 =?us-ascii?q?HIYEPlSqEdwKDMjgUAQIBAQEBAQEChjwBAQEBAgE4QQULCw0BCi5XBgEMBgIBA?=
 =?us-ascii?q?YMfgXQFqxuDCRqEPoNugieJMYEHgTIMglyKRwKYNgmOS4dxhQQrkV0zgXMzGgg?=
 =?us-ascii?q?oCIJ+kGBdkQgBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,402,1520870400"; 
   d="scan'208";a="133423000"
Received: from unknown (HELO [192.168.0.106]) ([58.6.136.164])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 15 May 2018 07:03:11 +0800
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-media@vger.kernel.org
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
 <20180514213719.o6ceftp2quem3s7f@ninjato>
From:   Greg Ungerer <gerg@uclinux.org>
Message-ID: <40bb677a-e6e1-7906-28fe-9e74cdfbefd7@uclinux.org>
Date:   Tue, 15 May 2018 09:03:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514213719.o6ceftp2quem3s7f@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@uclinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@uclinux.org
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


Hi Wolfram,

On 15/05/18 07:37, Wolfram Sang wrote:
>>   arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>>   arch/arm/mach-sa1100/simpad.c                    | 2 +-
>>   arch/mips/alchemy/board-gpr.c                    | 2 +-
> 
> Those still need acks...
> 
>> diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
>> index 937eb1d47e7b..ef835d82cdb9 100644
>> --- a/arch/arm/mach-ks8695/board-acs5k.c
>> +++ b/arch/arm/mach-ks8695/board-acs5k.c
>> @@ -19,7 +19,7 @@
>>   #include <linux/gpio/machine.h>
>>   #include <linux/i2c.h>
>>   #include <linux/i2c-algo-bit.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   #include <linux/platform_data/pca953x.h>
>>   
>>   #include <linux/mtd/mtd.h>
> 
> ...
> 
>> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
>> index ace010479eb6..49a61e6f3c5f 100644
>> --- a/arch/arm/mach-sa1100/simpad.c
>> +++ b/arch/arm/mach-sa1100/simpad.c
>> @@ -37,7 +37,7 @@
>>   #include <linux/input.h>
>>   #include <linux/gpio_keys.h>
>>   #include <linux/leds.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   
>>   #include "generic.h"
>>   
>> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
>> index 4e79dbd54a33..fa75d75b5ba9 100644
>> --- a/arch/mips/alchemy/board-gpr.c
>> +++ b/arch/mips/alchemy/board-gpr.c
>> @@ -29,7 +29,7 @@
>>   #include <linux/leds.h>
>>   #include <linux/gpio.h>
>>   #include <linux/i2c.h>
>> -#include <linux/i2c-gpio.h>
>> +#include <linux/platform_data/i2c-gpio.h>
>>   #include <linux/gpio/machine.h>
>>   #include <asm/bootinfo.h>
>>   #include <asm/idle.h>
> 
> ... and this was the shortened diff for those.
> 
> Greg, Russell, Ralf, James? Is it okay if I take this via my tree?

Yes, I have no problem with that for the ks8695 part.

Acked-by: Greg Ungerer <gerg@uclinux.org>

Thanks
Greg


> Thanks,
> 
>     Wolfram
> 
