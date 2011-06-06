Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 00:13:09 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:34873 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491783Ab1FFWNG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 00:13:06 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 301A48B0D;
        Tue,  7 Jun 2011 00:13:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HnrYIMPV-YcU; Tue,  7 Jun 2011 00:13:01 +0200 (CEST)
Received: from [192.168.0.151] (host-091-097-241-128.ewe-ip-backbone.de [91.97.241.128])
        by hauke-m.de (Postfix) with ESMTPSA id 529948B06;
        Tue,  7 Jun 2011 00:13:01 +0200 (CEST)
Message-ID: <4DED50EC.3040401@hauke-m.de>
Date:   Tue, 07 Jun 2011 00:13:00 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 09/10] bcm47xx: add support for bcma bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>        <1307311658-15853-10-git-send-email-hauke@hauke-m.de> <BANLkTi=ybf59NR1NA3TOuamsWzey9zx19A@mail.gmail.com>
In-Reply-To: <BANLkTi=ybf59NR1NA3TOuamsWzey9zx19A@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4968

On 06/06/2011 01:07 PM, Rafał Miłecki wrote:
> 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
>> This patch add support for the bcma bus. Broadcom uses only Mips 74K
>> CPUs on the new SoC and on the old ons using ssb bus there are no Mips
>> 74K CPUs.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/mips/Kconfig                            |    4 +++
>>  arch/mips/bcm47xx/gpio.c                     |    9 ++++++++
>>  arch/mips/bcm47xx/nvram.c                    |    6 +++++
>>  arch/mips/bcm47xx/serial.c                   |   24 +++++++++++++++++++++++
>>  arch/mips/bcm47xx/setup.c                    |   27 ++++++++++++++++++++++++-
>>  arch/mips/bcm47xx/time.c                     |    3 ++
>>  arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    3 ++
>>  arch/mips/include/asm/mach-bcm47xx/gpio.h    |   18 +++++++++++++++++
>>  drivers/watchdog/bcm47xx_wdt.c               |    6 +++++
>>  9 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 653da62..bdb0341 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -100,6 +100,10 @@ config BCM47XX
>>        select SSB_EMBEDDED
>>        select SSB_B43_PCI_BRIDGE if PCI
>>        select SSB_PCICORE_HOSTMODE if PCI
>> +       select BCMA
>> +       select BCMA_HOST_EMBEDDED
>> +       select BCMA_DRIVER_MIPS
>> +       select BCMA_PCICORE_HOSTMODE
> 
> I'm not involved in development for embedded devices but I believe
> that space is quite important for them.
> 
> You force compiling both: ssb and bcma for every device using bcm47xx.
> I think ppl may want to compile only one bus driver.
> 
Yes that has to be improved as there should also be an option to use the
compiler optimazions for the new MIPS 74K CPU core.

Hauke
