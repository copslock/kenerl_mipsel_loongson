Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 21:06:06 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:41749
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeAOUF5S9J33 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 21:05:57 +0100
Received: by mail-pf0-x241.google.com with SMTP id j3so8556971pfh.8
        for <linux-mips@linux-mips.org>; Mon, 15 Jan 2018 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRGzTgKQ4lxWcrytWlL/9pbdr28IlDLoaUJqcRyIwlw=;
        b=suXYkawGui8261ACd8OVWP0V0GR4UH165GW0/qhMgu3Qr0CtbVt1ZPDbKeH20jYNu4
         nXsNg2AeC2g7ddq1nieSfR+hxScIsHyjWV4WMu3jJI13VuvxDAHPDB8EA4yAVjbJxvh3
         ecuK2Xrn1IxV8ZFdZmmTUihyr3rj879j8LxQWagc2pFBlTdWO5MZX8Cd8yD3Udzjn6G0
         bS7HnHEQJqjicaPqgHPraWVvSXWR60g3bGv3nTcrPK2tMyQ0zRgMFFYmYv5I7NV4tfdz
         PbPr3PYtF8BJs0btNURuLBfuyUAVEIV71HwixCWGIMITlrDn7dtIe/95fNb+n6ibgu0u
         4qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRGzTgKQ4lxWcrytWlL/9pbdr28IlDLoaUJqcRyIwlw=;
        b=mTQ3xjnJaQo7vvv+6ft4lA7+4+kHlRMpq3k4GlPw9r6lvyK41L7TYEVh39INRuak8A
         SZbIBiQHZ3+4Y3VEGy1swWDFTjocL7+k1VusAlrtv0v2oizubxvXGQ7foQqmDPy4CUzc
         4kXvM92zxXMHQYwPa52W2bdaIuS8Co50d04tmwx1IyQvkuQOf5R1A2fRetpZH4QJaThI
         Wc29XDTJLIDhF10tbqxM0h0PGQXzvvRLx1KKyeBXe4BV7rzQX8K8I2pQE799TCA/psPL
         FOa8qU8Mx7/yUcN80n68vC+adTzg2pQWEDhzbJz1cNq1IQQ9IppChC+vPPGQQkoy9N+E
         YlWA==
X-Gm-Message-State: AKGB3mJ4y5fXDQ5wuKqX92dFJ7yiQKhpaBYpKy/TB1UFzakmaxK1q918
        6z55Un6SCUUzH8RZwT5tuyibMg==
X-Google-Smtp-Source: ACJfBouyBkoHhNG//BnlRXONkA218NmM5+0xsVRkr9wJaF9Q/d5PaHcDpDcBwilK70D/5x4MzCY2vw==
X-Received: by 10.98.138.153 with SMTP id o25mr25099514pfk.234.1516046750693;
        Mon, 15 Jan 2018 12:05:50 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v4sm434009pgq.23.2018.01.15.12.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 12:05:49 -0800 (PST)
Subject: Re: [PATCH] bcma: Fix 'allmodconfig' and BCMA builds on MIPS targets
To:     Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <1515965642-16259-1-git-send-email-linux@roeck-us.net>
 <20180115102336.GC29126@saruman>
 <20180115171053.6nvstoufw4y6ar4s@pburton-laptop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <61e41256-f0d3-11f7-06ca-768fab84914d@roeck-us.net>
Date:   Mon, 15 Jan 2018 12:05:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180115171053.6nvstoufw4y6ar4s@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 01/15/2018 09:10 AM, Paul Burton wrote:
> Hello,
> 
> On Mon, Jan 15, 2018 at 10:23:37AM +0000, James Hogan wrote:
>> On Sun, Jan 14, 2018 at 01:34:02PM -0800, Guenter Roeck wrote:
>>> Mips builds with BCMA host mode enabled fail in mainline and -next
>>> with:
>>>
>>> In file included from include/linux/bcma/bcma.h:10:0,
>>>                   from drivers/bcma/bcma_private.h:9,
>>> 		 from drivers/bcma/main.c:8:
>>> include/linux/bcma/bcma_driver_pci.h:218:24: error:
>>> 	field 'pci_controller' has incomplete type
>>>
>>> Bisect points to commit d41e6858ba58c ("MIPS: Kconfig: Set default MIPS
>>> system type as generic") as the culprit. Analysis shows that the commmit
>>> changes PCI configuration and enables PCI_DRIVERS_GENERIC. This in turn
>>> disables PCI_DRIVERS_LEGACY. 'struct pci_controller' is, however, only
>>> defined if PCI_DRIVERS_LEGACY is enabled.
>>>
>>> Ultimately that means that BCMA_DRIVER_PCI_HOSTMODE depends on
>>> PCI_DRIVERS_LEGACY. Add the missing dependency.
>>>
>>> Fixes: d41e6858ba58c ("MIPS: Kconfig: Set default MIPS system type as ...")
>>
>> Well, technically I think commit c5611df96804 ("MIPS: PCI: Introduce
>> CONFIG_PCI_DRIVERS_LEGACY") is to blame (Cc'ing paul), and the first bad
>> commit would be commit eed0eabd12ef ("MIPS: generic: Introduce generic
>> DT-based board support") which selects PCI_DRIVERS_GENERIC and is the
>> only platform to do so. Both commits were first in v4.9-rc1 and I can
>> reproduce this problem at that latter commit with the appropriate
>> configuration.
> 
> Ah - yes if I recall correctly my assumption was that the MIPS-specific
> struct pci_controller was only used by the MIPS-specific PCI drivers
> under arch/mips/pci/, which are only built when configured for the
> appropriate platform.
> 
> In this case use of that MIPS-specific struct pci_controller has spread
> beyond arch/mips/ & the user can be configured in for platforms other
> than the one that will actually use the driver, including the generic
> platform which moves towards more generic PCI drivers in
> drivers/pci/host/.
> 
>> But yes clearly the mentioned commit does also expose that existing
>> problem more widely and to the default allmodconfig, and it looks like a
>> reasonable approach for now, so if some mention of the other two commits
>> is added:
>>
>> Reviewed-by: James Hogan <jhogan@kernel.org>
> 
> Likewise, with the "Fixes:" tag fixed:
> 
>      Reviewed-by: Paul Burton <paul.burton@mips.com>
> 

Unfortunately, that alone doesn't fix the problem. SSB driver dependencies
are also broken, and in much worse shape. I had to add dependencies in five
places to get it to build, and the result is so messy that I won't even try
to submit it. And if that is fixed, mips:allmodconfig still doesn't build -
the next error is an undefined reference to physical_memsize in
arch/mips/kernel/vpe-mt.o.

I wonder if I should just stop trying to build allmodconfig for mips.
Any thoughts ?

Guenter

> Thanks,
>      Paul
> 
>> Having it in 4.15 would be great.
>>
>> Cheers
>> James
>>
>>> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
>>> Cc: James Hogan <jhogan@kernel.org>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> I am aware that this problem has been reported several times. I have
>>> not been able to find a fix, but I may have missed it. If so, my
>>> apologies for the noise.
>>>
>>> Also note that this is not the only fix required; commit d41e6858ba58c,
>>> as simple as it looks like, does a pretty good job messing up
>>> "mips:allmodconfig" builds.
>>>
>>>   drivers/bcma/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
>>> index 02d78f6cecbb..ba8acca036df 100644
>>> --- a/drivers/bcma/Kconfig
>>> +++ b/drivers/bcma/Kconfig
>>> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>>>   
>>>   config BCMA_DRIVER_PCI_HOSTMODE
>>>   	bool "Driver for PCI core working in hostmode"
>>> -	depends on MIPS && BCMA_DRIVER_PCI
>>> +	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
>>>   	help
>>>   	  PCI core hostmode operation (external PCI bus).
>>>   
>>> -- 
>>> 2.7.4
>>>
> 
> 
> 
