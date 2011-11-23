Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 13:04:17 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:52299 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903550Ab1KWMEJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 13:04:09 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9011823C00A7;
        Wed, 23 Nov 2011 13:04:07 +0100 (CET)
Message-ID: <4ECCE137.8080803@openwrt.org>
Date:   Wed, 23 Nov 2011 13:04:07 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Ren=E9_Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 08/12] MIPS: ath79: add support for the PCI host controller
 of the AR71XX SoCs
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <1322003670-8797-9-git-send-email-juhosg@openwrt.org> <4ECCBB01.3070507@mvista.com>
In-Reply-To: <4ECCBB01.3070507@mvista.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19838

Hi Sergei,

>> @@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)        += pci-bcm47xx.o
>>   obj-$(CONFIG_BCM63XX)        += pci-bcm63xx.o fixup-bcm63xx.o \
>>                       ops-bcm63xx.o
>>   obj-$(CONFIG_MIPS_ALCHEMY)    += pci-alchemy.o
>> +obj-$(CONFIG_SOC_AR71XX)    += pci-ar71xx.o
> 
>    OK, but where's pci_ar71xx.c file itself? Your whole patchset doesn't seem to
> include it...

You are correct, I forgot to add that. I have added that now, it will be in v2
of the patch-set.

Thanks,
Gabor
