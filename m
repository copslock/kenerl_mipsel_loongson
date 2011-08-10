Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2011 09:14:45 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:51154 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491108Ab1HJHOk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2011 09:14:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 2E3D58C90;
        Wed, 10 Aug 2011 09:14:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WLNTirg7OZZa; Wed, 10 Aug 2011 09:14:35 +0200 (CEST)
Received: from [10.59.128.41] (unknown [82.113.99.169])
        by hauke-m.de (Postfix) with ESMTPSA id 769868C88;
        Wed, 10 Aug 2011 09:14:30 +0200 (CEST)
Message-ID: <4E422FD0.5050600@hauke-m.de>
Date:   Wed, 10 Aug 2011 09:14:24 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com,
        ralf@linux-mips.org, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com, arnd@arndb.de,
        julian.calaby@gmail.com, sshtylyov@mvista.com
Subject: Re: [PATCH 06/11] bcma: add serial console support
References: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>        <1311376815-15755-7-git-send-email-hauke@hauke-m.de>    <CACna6rxMA9KDuWSPLmdNsS=zNJawkbX5-KYrRWq3Jn25gWhX7A@mail.gmail.com> <CACna6rzqm=NhsrUWZr8Mun5fNaz3x1Qa6Fv_-TMKw8iOsK=u-w@mail.gmail.com>
In-Reply-To: <CACna6rzqm=NhsrUWZr8Mun5fNaz3x1Qa6Fv_-TMKw8iOsK=u-w@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7224

On 07/29/2011 11:06 PM, Rafał Miłecki wrote:
> W dniu 29 lipca 2011 23:04 użytkownik Rafał Miłecki <zajec5@gmail.com> napisał:
>> 2011/7/23 Hauke Mehrtens <hauke@hauke-m.de>:
>>> This adds support for serial console to bcma, when operating on an SoC.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  drivers/bcma/bcma_private.h                 |    8 ++++
>>>  drivers/bcma/driver_chipcommon.c            |   48 +++++++++++++++++++++++++++
>>>  drivers/bcma/driver_chipcommon_pmu.c        |   26 ++++++++++++++
>>>  drivers/bcma/driver_mips.c                  |    1 +
>>>  include/linux/bcma/bcma_driver_chipcommon.h |   14 ++++++++
>>>  5 files changed, 97 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/bcma/bcma_private.h b/drivers/bcma/bcma_private.h
>>> index b97633d..22d3052 100644
>>> --- a/drivers/bcma/bcma_private.h
>>> +++ b/drivers/bcma/bcma_private.h
>>> @@ -29,6 +29,14 @@ void bcma_init_bus(struct bcma_bus *bus);
>>>  /* sprom.c */
>>>  int bcma_sprom_get(struct bcma_bus *bus);
>>>
>>> +/* driver_chipcommon.c */
>>> +#ifdef CONFIG_BCMA_DRIVER_MIPS
>>> +void bcma_chipco_serial_init(struct bcma_drv_cc *cc);
>>> +#endif /* CONFIG_BCMA_DRIVER_MIPS */
>>> +
>>> +/* driver_chipcommon_pmu.c */
>>> +u32 bcma_pmu_alp_clock(struct bcma_drv_cc *cc);
>>> +
>>>  #ifdef CONFIG_BCMA_HOST_PCI
>>>  /* host_pci.c */
>>>  extern int __init bcma_host_pci_init(void);
>>
>> Not sure, what do you think about this, feel free to comment.
>>
>> My idea was to use bcma_private.h for bcma-internal functions. For
>> example, support for PCI host or SoC host, is something "internal" (as
>> I call it) for bcma. Drivers in theory could be separated modules and
>> I use include/linux/bcma/driver_*.h for them.
>>
>> If following this schema, declarations of
>> bcma_pmu_alp_clock
>> bcma_host_pci_init
>> should be in include/linux/bcma/bcma_driver_chipcommon.h
> 
> Same goes to the
> bcma_pmu_get_clockcpu
> from patch 07/11.
> 
> Sorry for late-noticing this.
> 
> I don't have more comments against your patch set :) Hope John will
> take it soon :)
> 
This sounds good. I will send a new patch moving the method declaration
to bcma_driver_chipcommon.h for these 3 functions.

Hauke
