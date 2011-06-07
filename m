Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 23:23:51 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42820 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491818Ab1FGVXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 23:23:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6CDA98B95;
        Tue,  7 Jun 2011 23:23:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 62uTIrJ8xjBX; Tue,  7 Jun 2011 23:23:43 +0200 (CEST)
Received: from [192.168.0.10] (host-091-097-248-162.ewe-ip-backbone.de [91.97.248.162])
        by hauke-m.de (Postfix) with ESMTPSA id D60078B86;
        Tue,  7 Jun 2011 23:23:42 +0200 (CEST)
Message-ID: <4DEE96DD.2020609@hauke-m.de>
Date:   Tue, 07 Jun 2011 23:23:41 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Arend van Spriel <arend@broadcom.com>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "george@znau.edu.ua" <george@znau.edu.ua>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <1307311658-15853-4-git-send-email-hauke@hauke-m.de> <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com> <4DED4DEB.5030802@hauke-m.de> <BANLkTikATEB7zoDPBcc4Ubh7ONyHXWBW+w@mail.gmail.com> <4DEDFDC8.50005@broadcom.com>
In-Reply-To: <4DEDFDC8.50005@broadcom.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6157

On 06/07/2011 12:30 PM, Arend van Spriel wrote:
> On 06/07/2011 02:33 AM, Rafał Miłecki wrote:
>> W dniu 7 czerwca 2011 00:00 użytkownik Hauke Mehrtens
>> <hauke@hauke-m.de>  napisał:
>>> On 06/06/2011 12:22 PM, Rafał Miłecki wrote:
>>>>> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
>>>>> +               iounmap(bus->mmio);
>>>>> +               mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE *
>>>>> bus->nr_cores);
>>>>> +               if (!mmio)
>>>>> +                       return -ENOMEM;
>>>>> +               bus->mmio = mmio;
>>>>> +
>>>>> +               mmio = ioremap(BCMA_WRAP_BASE, BCMA_CORE_SIZE *
>>>>> bus->nr_cores);
>>>>> +               if (!mmio)
>>>>> +                       return -ENOMEM;
>>>>> +               bus->host_embedded = mmio;
>>>> Do we really need both? mmio and host_embedded? What about keeping
>>>> mmio only and using it in calculation for read/write[8,16,32]?
>>> These are two different memory regions, it should be possible to
>>> calculate the other address, but I do not like that. As host_embedded is
>>> in a union this does not waste any memory.
>> Ah, OK, I can see what does happen here. You are using:
>> 1) bus->mmio for first core
>> 2) bus->host_embedded for first agent/wrapper
>>
>> I'm not sure if this is a correct approach. Doing "core_index *
>> BCMA_CORE_SIZE" comes from ssb, where it was the way to calculate
>> offset. In case of BCMA we are reading all the info from (E)EPROM,
>> which also includes addresses of the cores.
>>
>> IMO you should use core->addr and core->wrap for read/write ops. I
>> believe this is approach Broadcom decided to use for BCMA, when
>> designing (E)EPROM.
> 
> Agree. There is no guarantee for the core index to relate to the
> physical address. Chip designer may be systematic in this and the
> index*size method may work, but not by design.
> 
> Gr. AvS
> 
Ok I will use these addresses.

Hauke
