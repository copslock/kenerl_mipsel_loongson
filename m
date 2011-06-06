Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2011 00:11:13 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56046 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491783Ab1FFWLJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jun 2011 00:11:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D895D8B0D;
        Tue,  7 Jun 2011 00:11:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nv3zR++Py+4W; Tue,  7 Jun 2011 00:11:04 +0200 (CEST)
Received: from [192.168.0.151] (host-091-097-241-128.ewe-ip-backbone.de [91.97.241.128])
        by hauke-m.de (Postfix) with ESMTPSA id 17EE28B06;
        Tue,  7 Jun 2011 00:11:04 +0200 (CEST)
Message-ID: <4DED5077.9040503@hauke-m.de>
Date:   Tue, 07 Jun 2011 00:11:03 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Subject: Re: [RFC][PATCH 07/10] bcma: add pci(e) host mode
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>        <1307311658-15853-8-git-send-email-hauke@hauke-m.de> <BANLkTik93+7ujHyv0_Zk2Ma9BPsHvJTttg@mail.gmail.com>
In-Reply-To: <BANLkTik93+7ujHyv0_Zk2Ma9BPsHvJTttg@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4967

On 06/06/2011 01:32 PM, Rafał Miłecki wrote:
> 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
>> +config BCMA_PCICORE_HOSTMODE
>> +       bool "Hostmode support for BCMA PCI core"
>> +       depends on BCMA_DRIVER_MIPS
>> +       help
>> +         PCIcore hostmode operation (external PCI bus).
> 
> I think you started to use BCMA_DRIVER_corename. Could you stick to it
> (one schema), please? Maybe just
> BCMA_DRIVER_PCI_HOSTMODE
> ?
> 
Yes sounds better.
> 
>> +#ifdef CONFIG_BCMA_PCICORE_HOSTMODE
>> +       pc->hostmode = bcma_pcicore_is_in_hostmode(pc);
>> +       if (pc->hostmode)
>> +               bcma_pcicore_init_hostmode(pc);
>> +#endif /* CONFIG_BCMA_PCICORE_HOSTMODE */
>> +       if (!pc->hostmode)
>> +               bcma_pcicore_serdes_workaround(pc);
> 
> Does it make sense to init hostmode PCI like clientmode if we just
> disable CONFIG_BCMA_PCICORE_HOSTMODE?
> 
> I think we should always check if core is host or client mode and use
> correct initialization only. We should not init it as clientmode just
> because we do not have driver for host mode.
Yes we should not initialize a host mode pci core with client init code
as it will break my device. ;-) I will place
bcma_pcicore_is_in_hostmode() into the normal PCI driver code so it is
available all the time.
> 
> 
>> diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
>> new file mode 100644
>> index 0000000..b52c6c9
>> --- /dev/null
>> +++ b/drivers/bcma/driver_pci_host.c
>> @@ -0,0 +1,44 @@
>> +/*
>> + * Broadcom specific AMBA
>> + * PCI Core
> 
> Please rename "PCI Core", add something about hostmode.
> 
Missed that while copy and past.

Hauke
