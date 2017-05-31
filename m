Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 21:30:37 +0200 (CEST)
Received: from mail-wm0-x234.google.com ([IPv6:2a00:1450:400c:c09::234]:35856
        "EHLO mail-wm0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdEaTa0RdVe3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 21:30:26 +0200
Received: by mail-wm0-x234.google.com with SMTP id 7so130862241wmo.1
        for <linux-mips@linux-mips.org>; Wed, 31 May 2017 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WsDigyBqzGXyCvazaUOs/PVfegYSyqlSxX7AhxIrlqc=;
        b=M4wDQO5L+rVdzL+uY3VVLVNXZfAgjTELTKT9kwV+Ch2DAD4gFhM6T6vnvwCzyc1c7C
         V5uY/MjYj8qx8LDzRrZMHbvL0MyqlpC9k5C1EDfZdqtrE44ey2ToBP9J8ae0boDXqx81
         iZOHqS6enwqX5o2JU3m4sF4gwnMx13snwlxxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WsDigyBqzGXyCvazaUOs/PVfegYSyqlSxX7AhxIrlqc=;
        b=TJiMwKa0JUffX/E5PQAz6str8NmOV6ELpwC+m6cz9O8KIhQRlL/qqrTz8c9NwVp7lZ
         z8M23P5TIVB1m5tMZNvMdAbwJ/2/qfDV9dyO3Qk1mSOGSg/U/jNak5+8pL0WdcMK8nDu
         6fow2ShVeeVZhei6TIrmHXqRRBwskchrU0bW+zRnHmi2p6rQNqxDHUPVJSML2FiOJsjK
         2OeyeRbB5ofK8cBH9ZzKWk0X46v9Zevi0lcArMy40supQv/LQM9zyx0OGVUFBGcKh4ql
         SF6pGH8GXMNK82b9ge4WKcZC3Kem6320KYTU+YCkwlbMWO1SHGNnGsJozjxBHN0iSrDB
         /7Bw==
X-Gm-Message-State: AODbwcD0koA9qLPI5MNHglkz9XQOnODUHNwmNRbDiS9wgwZvN7g4j6EH
        6mNtIAOZ5gQy8NZi
X-Received: by 10.80.137.155 with SMTP id g27mr22660693edg.125.1496259020814;
        Wed, 31 May 2017 12:30:20 -0700 (PDT)
Received: from [192.168.178.39] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id k44sm6673059ede.16.2017.05.31.12.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 12:30:20 -0700 (PDT)
Subject: Re: [PATCH] bcm47xx: fix build regression
To:     paulmck@linux.vnet.ibm.com, Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20170530112027.3983554-1-arnd@arndb.de>
 <7b6903a2-ce54-44f9-18ed-a14bd32069ce@broadcom.com>
 <CAK8P3a2-kO==gMDm3E6U8CR-zhwmZGztRy7Trcezf8oZxgn01g@mail.gmail.com>
 <20170531131216.GJ3956@linux.vnet.ibm.com>
 <CAK8P3a1wcVC1+dPbtAgn=2RbToV_ai+dGc2tJxdQ4r1s+nxAFg@mail.gmail.com>
 <20170531163110.GL3956@linux.vnet.ibm.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <51fbd3af-853e-f055-bef5-58d7438ba1ae@broadcom.com>
Date:   Wed, 31 May 2017 21:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170531163110.GL3956@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <arend.vanspriel@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend.vanspriel@broadcom.com
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

On 31-05-17 18:31, Paul E. McKenney wrote:
> On Wed, May 31, 2017 at 03:34:57PM +0200, Arnd Bergmann wrote:
>> On Wed, May 31, 2017 at 3:12 PM, Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com> wrote:
>>> On Wed, May 31, 2017 at 12:21:10PM +0200, Arnd Bergmann wrote:
>>>> On Wed, May 31, 2017 at 11:43 AM, Arend van Spriel
>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>> On 5/30/2017 1:20 PM, Arnd Bergmann wrote:
>>>>>>
>>>>>> An unknown change in the kernel headers caused a build regression
>>>>>> in an MTD partition driver:
>>>>>>
>>>>>> In file included from drivers/mtd/bcm47xxpart.c:12:0:
>>>>>> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
>>>>>> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first
>>>>>> use in this function)
>>>>>>
>>>>>> Clearly we want to include linux/errno.h here.
>>>>>
>>>>>
>>>>> unfortunate that you did not find the commit that caused this build
>>>>> regression. You could produce preprocessor output when it was working to see
>>>>> where errno.h got implicitly included and start looking there for git
>>>>> history.
>>>>
>>>> I did a 'git bisect run make drivers/mtd/bcm47xxpart.o' now, which pointed to
>>>> 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h").
>>>>
>>>> That commit seems reasonable, it was just bad luck that it caused this
>>>> regression. The commit is currently in the rcu/rcu/next branch of tip.git,
>>>> so Paul could merge the patch there.

Arnd,

Thanks for digging a bit further. I am a sucker for telling the whole story.

>>>
>>> Apologies for the inconvenience, not sure why 0day test robot didn't
>>> find this.  Probably because it cannot test each and every driver.  ;-)
>>
>> No worries.
>>
>>> This patch, correct?
>>>
>>>         https://lkml.org/lkml/2017/5/30/348
>>
>> Right, I should have included the link.
> 
> And my turn to say "no worries".  ;-)
> 
> I reworked the commit log to tell the full story as shown below.
> Anything I misstated or otherwise missed?

Maybe add the 'Fixes:' tag, ie.:

Fixes: 0bc2d534708b ("rcu: Refactor #includes from
include/linux/rcupdate.h")

Seems a bit redundant given that you mentioned it in the commit message,
but it might be looked for in kernel-stats scripts.

Regards,
Arend

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit ff278071dce9af9da2b5e2b33f682710a855d266
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed May 31 09:26:07 2017 -0700
> 
>     bcm47xx: fix build regression
>     
>     Commit 0bc2d534708b ("rcu: Refactor #includes from include/linux/rcupdate.h")
>     caused a build regression in an MTD partition driver:
>     
>     In file included from drivers/mtd/bcm47xxpart.c:12:0:
>     include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
>     include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first use in this function)
>     
>     The rcupdate.h file has no particular need for linux/errno.h, so this
>     commit includes linux/errno.h into bcm47xx_nvram.h.
>     
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
> index 2793652fbf66..a414a2b53e41 100644
> --- a/include/linux/bcm47xx_nvram.h
> +++ b/include/linux/bcm47xx_nvram.h
> @@ -8,6 +8,7 @@
>  #ifndef __BCM47XX_NVRAM_H
>  #define __BCM47XX_NVRAM_H
>  
> +#include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/vmalloc.h>
> 
