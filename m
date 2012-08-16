Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 00:38:19 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:40610 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903553Ab2HPWiM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 00:38:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E229F3EE18;
        Fri, 17 Aug 2012 00:38:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aJfxLudzFasq; Fri, 17 Aug 2012 00:38:06 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:2a:1be:14a6:74fa] (unknown [IPv6:2001:470:1f0b:447:2a:1be:14a6:74fa])
        by hauke-m.de (Postfix) with ESMTPSA id 05E013EE16;
        Fri, 17 Aug 2012 00:38:05 +0200 (CEST)
Message-ID: <502D764C.1060501@hauke-m.de>
Date:   Fri, 17 Aug 2012 00:38:04 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Arend van Spriel <arend@broadcom.com>,
        Florian Fainelli <florian@openwrt.org>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        john@phrozen.org
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de> <1345132801-8430-4-git-send-email-hauke@hauke-m.de> <1791263.5FQJJv4xHF@bender> <CACna6rxVOFO-n5J_6J7HFSt+WnoX0=2ULjiRv3p9va47K2Edsw@mail.gmail.com> <502D3F3F.7060207@broadcom.com> <CACna6ryphAPip5hpAuzCMQjqvZe70MpPnFkCyzrMhFkk5iLS+A@mail.gmail.com>
In-Reply-To: <CACna6ryphAPip5hpAuzCMQjqvZe70MpPnFkCyzrMhFkk5iLS+A@mail.gmail.com>
X-Enigmail-Version: 1.5a1pre
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 34233
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/16/2012 09:29 PM, Rafał Miłecki wrote:
> 2012/8/16 Arend van Spriel <arend@broadcom.com>:
>> On 08/16/2012 07:39 PM, Rafał Miłecki wrote:
>>>
>>> 2012/8/16 Florian Fainelli<florian@openwrt.org>:
>>>>>
>>>>>>> +void __init bcm47xx_gpio_init(void)
>>>>>>> +{
>>>>>>> +     int err;
>>>>>>> +
>>>>>>> +     switch (bcm47xx_bus_type) {
>>>>>>> +#ifdef CONFIG_BCM47XX_SSB
>>>>>>> +     case BCM47XX_BUS_TYPE_SSB:
>>>>>>> +             bcm47xx_gpio_count = ssb_gpio_count(&bcm47xx_bus.ssb);
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_BCM47XX_BCMA
>>>>>>> +     case BCM47XX_BUS_TYPE_BCMA:
>>>>>>> +             bcm47xx_gpio_count =
>>>>>>> bcma_gpio_count(&bcm47xx_bus.bcma.bus);
>>>>>>> +#endif
>>>>>>> +     }
>>>>
>>>>>
>>>>> Is this exclusive? Cannot we have both SSB and BCMA on the same device?
>>>
>>> This applies to SoC only, so I believe it's fine. We don't have SoCs
>>> based on BCMA and SSB at the same time.
>>
>>
>> It is indeed more than unlikely for a chip to have two silicon
>> interconnects, which is what SSB and BCMA are. However, it does look
>> suspicious from a code reading perspective. So I general I stick to the rule
>> that each case must have a break and fall-thru are clearly commented.
> 
> Ahh, I though question is related to the enum used for bustype. I
> definitely vote for using "break"

I will add the missing break.

Hauke
