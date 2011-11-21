Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 12:58:58 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:52677 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903745Ab1KUL6w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 12:58:52 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CC4E723C0087;
        Mon, 21 Nov 2011 12:58:49 +0100 (CET)
Message-ID: <4ECA3CF9.8040109@openwrt.org>
Date:   Mon, 21 Nov 2011 12:58:49 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: Re: [PATCH v3 4/7] MIPS: ath79: add a common PCI registration function
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org> <1321825151-16053-5-git-send-email-juhosg@openwrt.org> <4ECA254E.4040509@mvista.com>
In-Reply-To: <4ECA254E.4040509@mvista.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 31856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17199

Hi Sergei,

2011.11.21. 11:17 keltezéssel, Sergei Shtylyov írta:
> Hello.
> 
> On 21-11-2011 1:39, Gabor Juhos wrote:
> 
>> The current code unconditionally registers the AR724X
>> specific PCI controller, even if the kernel is running
>> on a different SoC.
> 

<...>

>>   }
>> +
>> +int __init ath79_register_pci(void)
>> +{
>> +    int ret;
>> +
>> +    if (soc_is_ar724x())
>> +        ret = ath724x_pcibios_init();
>> +    else
>> +        ret = -ENODEV;
> 
>    Why not return right away and save 4 lines of code?

Because I have more patches which will need the if-else statement. Apart from
that, you are right it is not needed here. I will remove it from the current patch.

-Gabor
