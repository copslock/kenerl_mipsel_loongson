Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 23:40:18 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45213 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491783Ab1FFVkP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 23:40:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 3E4138B0D;
        Mon,  6 Jun 2011 23:40:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EVH7YEnh1K8J; Mon,  6 Jun 2011 23:40:11 +0200 (CEST)
Received: from [192.168.0.151] (host-091-097-241-128.ewe-ip-backbone.de [91.97.241.128])
        by hauke-m.de (Postfix) with ESMTPSA id 0C8868B06;
        Mon,  6 Jun 2011 23:40:10 +0200 (CEST)
Message-ID: <4DED493A.8050209@hauke-m.de>
Date:   Mon, 06 Jun 2011 23:40:10 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Julian Calaby <julian.calaby@gmail.com>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        zajec5@gmail.com, mb@bu3sch.de, george@znau.edu.ua,
        arend@broadcom.com, b43-dev@lists.infradead.org,
        bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <1307311658-15853-4-git-send-email-hauke@hauke-m.de> <BANLkTi=atiB_=_N3xSJBAjRGXjTV8a97CA@mail.gmail.com>
In-Reply-To: <BANLkTi=atiB_=_N3xSJBAjRGXjTV8a97CA@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4917

On 06/06/2011 01:22 AM, Julian Calaby wrote:
> Hauke,
> 
> Minor nit:
> 
> On Mon, Jun 6, 2011 at 08:07, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> This patch adds support for using bcma on an embedded bus. An embedded
>> system like the bcm4716 could register this bus and it searches for the
>> bcma cores then.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
>> index 70b39f7..9229615 100644
>> --- a/drivers/bcma/scan.c
>> +++ b/drivers/bcma/scan.c
>> @@ -219,9 +219,34 @@ int bcma_bus_scan(struct bcma_bus *bus)
>>        bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
>>        bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
>>        bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
>> +       bus->nr_cores = (tmp & BCMA_CC_ID_NRCORES) >> BCMA_CC_ID_NRCORES_SHIFT;
>> +
>> +       /* If we are an embedded device we now know the number of avaliable
>> +        * core and ioremap the correct space.
>> +        */
>> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
>> +               iounmap(bus->mmio);
>> +               mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>> +               if (!mmio)
>> +                       return -ENOMEM;
>> +               bus->mmio = mmio;
>> +
>> +               mmio = ioremap(BCMA_WRAP_BASE, BCMA_CORE_SIZE * bus->nr_cores);
>> +               if (!mmio)
>> +                       return -ENOMEM;
>> +               bus->host_embedded = mmio;
>> +       }
>> +       /* reset it to 0 as we use it for counting */
>> +       bus->nr_cores = 0;
> 
> Would it make sense to use a local variable for nr_cores, and only use
> it within the BCMA_HOSTTYPE_EMBEDDED if statement, rather than
> re-using bus->nr_cores and having to reset it?
Yes that looks better.

Hauke
