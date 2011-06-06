Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 00:00:22 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:54548 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491783Ab1FFWAT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 00:00:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D49FC8B0D;
        Tue,  7 Jun 2011 00:00:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8DHyZtWoaHWU; Tue,  7 Jun 2011 00:00:13 +0200 (CEST)
Received: from [192.168.0.151] (host-091-097-241-128.ewe-ip-backbone.de [91.97.241.128])
        by hauke-m.de (Postfix) with ESMTPSA id 783C88B06;
        Tue,  7 Jun 2011 00:00:12 +0200 (CEST)
Message-ID: <4DED4DEB.5030802@hauke-m.de>
Date:   Tue, 07 Jun 2011 00:00:11 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>        <1307311658-15853-4-git-send-email-hauke@hauke-m.de> <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
In-Reply-To: <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4951

On 06/06/2011 12:22 PM, Rafał Miłecki wrote:
> Hauke,
> 
> My idea for naming schema was to use:
> bcma_host_TYPE_*
> 
> Like:
> bcma_host_pci_*
> bcma_host_sdio_*
> 
> You are using:
> bcma_host_bcma_*
> 
> What do you think about changing this to:
> bcma_host_embedded_*
> or just some:
> bcma_host_emb_*
> ?
> 
> Does it make more sense to you? I was trying to keep names in bcma
> really clear, so every first-time-reader can see differences between
> hosts, host and driver, etc.
> 
At first I named it bcma_host_bcma_ but then renamed the file name, but
forgot the function names. I will rename it all to bcma_host_soc_*
host_sco.c and so on.

> 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
>> --- /dev/null
>> +++ b/drivers/bcma/host_embedded.c
>> @@ -0,0 +1,93 @@
>> +/*
>> + * Broadcom specific AMBA
>> + * PCI Host
> 
> s/PCI/Embedded/
> 
> 
>> +int bcma_host_bcma_register(struct bcma_bus *bus)
>> +{
>> +       u32 __iomem *mmio;
>> +       /* iomap only first core. We have to read some register on this core
>> +        * to get the number of cores. This is sone in bcma_scan()
>> +        */
>> +       mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * 1);
>> +       if (!mmio)
>> +               return -ENOMEM;
>> +       bus->mmio = mmio;
> 
> Maybe just:
> bus->mmio = ioremap(...);
> ? :)
yes makes sens.
> 
>> +       /* Host specific */
>> +       bus->hosttype = BCMA_HOSTTYPE_EMBEDDED;
>> +       bus->ops = &bcma_host_bcma_ops;
>> +
>> +       /* Register */
>> +       return bcma_bus_register(bus);
>> +}
>> diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
>> index 1afa107..c5bcb5f 100644
>> --- a/drivers/bcma/main.c
>> +++ b/drivers/bcma/main.c
>> @@ -119,6 +119,7 @@ static int bcma_register_cores(struct bcma_bus *bus)
>>                        break;
>>                case BCMA_HOSTTYPE_NONE:
>>                case BCMA_HOSTTYPE_SDIO:
>> +               case BCMA_HOSTTYPE_EMBEDDED:
>>                        break;
>>                }
>>
>> diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
>> index 70b39f7..9229615 100644
>> --- a/drivers/bcma/scan.c
>> +++ b/drivers/bcma/scan.c
>> @@ -203,7 +203,7 @@ static s32 bcma_erom_get_addr_desc(struct bcma_bus *bus, u32 **eromptr,
>>  int bcma_bus_scan(struct bcma_bus *bus)
>>  {
>>        u32 erombase;
>> -       u32 __iomem *eromptr, *eromend;
>> +       u32 __iomem *eromptr, *eromend, *mmio;
>>
>>        s32 cia, cib;
>>        u8 ports[2], wrappers[2];
>> @@ -219,9 +219,34 @@ int bcma_bus_scan(struct bcma_bus *bus)
>>        bus->chipinfo.id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
>>        bus->chipinfo.rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
>>        bus->chipinfo.pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
>> +       bus->nr_cores = (tmp & BCMA_CC_ID_NRCORES) >> BCMA_CC_ID_NRCORES_SHIFT;
> 
> I'd use different variable as Julian suggested.
yes
> 
> 
>> +
>> +       /* If we are an embedded device we now know the number of avaliable
>> +        * core and ioremap the correct space.
>> +        */
> 
> Typo: avaliable
my favorite typo ;-)
> 
> 
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
> 
> Do we really need both? mmio and host_embedded? What about keeping
> mmio only and using it in calculation for read/write[8,16,32]?
These are two different memory regions, it should be possible to
calculate the other address, but I do not like that. As host_embedded is
in a union this does not waste any memory.

> 
>> +       }
>> +       /* reset it to 0 as we use it for counting */
>> +       bus->nr_cores = 0;
>>
>>        erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
>> -       eromptr = bus->mmio;
>> +       if (bus->hosttype == BCMA_HOSTTYPE_EMBEDDED) {
>> +               eromptr = ioremap(erombase, BCMA_CORE_SIZE);
>> +               if (!eromptr)
>> +                       return -ENOMEM;
>> +       } else
>> +               eromptr = bus->mmio;
> 
> I though eromptr = bus->mmio; will do the trick for embedded as well.
> I think I need some time to read about IO mapping and understand that.
> 
No they are different eromptr is 0x1810e000 and bus->mmio is 0xb8000000
for example on my device. I tried using eromptr = bus->mmio; on embedded
and it did not work.

Hauke
