Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 12:30:55 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1753 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491030Ab1FGKau convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 12:30:50 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 07 Jun 2011 03:35:00 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 7 Jun 2011 03:30:35 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 AB58F74D03; Tue, 7 Jun 2011 03:30:35 -0700 (PDT)
Received: from [192.168.1.120] (unknown [10.176.68.21]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 9833320501; Tue, 7
 Jun 2011 03:30:33 -0700 (PDT)
Message-ID: <4DEDFDC8.50005@broadcom.com>
Date:   Tue, 7 Jun 2011 12:30:32 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
cc:     "Hauke Mehrtens" <hauke@hauke-m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "george@znau.edu.ua" <george@znau.edu.ua>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
 <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
 <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
 <4DED4DEB.5030802@hauke-m.de>
 <BANLkTikATEB7zoDPBcc4Ubh7ONyHXWBW+w@mail.gmail.com>
In-Reply-To: <BANLkTikATEB7zoDPBcc4Ubh7ONyHXWBW+w@mail.gmail.com>
X-WSS-ID: 61F3215E3B4122601-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-archive-position: 30282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5406

On 06/07/2011 02:33 AM, Rafał Miłecki wrote:
> W dniu 7 czerwca 2011 00:00 użytkownik Hauke Mehrtens
> <hauke@hauke-m.de>  napisał:
>> On 06/06/2011 12:22 PM, Rafał Miłecki wrote:
>>>> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
>>>> +               iounmap(bus->mmio);
>>>> +               mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>>>> +               if (!mmio)
>>>> +                       return -ENOMEM;
>>>> +               bus->mmio = mmio;
>>>> +
>>>> +               mmio = ioremap(BCMA_WRAP_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>>>> +               if (!mmio)
>>>> +                       return -ENOMEM;
>>>> +               bus->host_embedded = mmio;
>>> Do we really need both? mmio and host_embedded? What about keeping
>>> mmio only and using it in calculation for read/write[8,16,32]?
>> These are two different memory regions, it should be possible to
>> calculate the other address, but I do not like that. As host_embedded is
>> in a union this does not waste any memory.
> Ah, OK, I can see what does happen here. You are using:
> 1) bus->mmio for first core
> 2) bus->host_embedded for first agent/wrapper
>
> I'm not sure if this is a correct approach. Doing "core_index *
> BCMA_CORE_SIZE" comes from ssb, where it was the way to calculate
> offset. In case of BCMA we are reading all the info from (E)EPROM,
> which also includes addresses of the cores.
>
> IMO you should use core->addr and core->wrap for read/write ops. I
> believe this is approach Broadcom decided to use for BCMA, when
> designing (E)EPROM.

Agree. There is no guarantee for the core index to relate to the 
physical address. Chip designer may be systematic in this and the 
index*size method may work, but not by design.

Gr. AvS

-- 
Almost nobody dances sober, unless they happen to be insane.
-- H.P. Lovecraft --
