Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 21:39:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57877 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904114Ab1KWUjc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 21:39:32 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 442C223C00B5;
        Wed, 23 Nov 2011 21:39:30 +0100 (CET)
Message-ID: <4ECD5A04.1020702@openwrt.org>
Date:   Wed, 23 Nov 2011 21:39:32 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com> <4ECCFE72.6090300@openwrt.org> <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com>
In-Reply-To: <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 31957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20305

Hi,

<...>

>> I'm curious why do you think that it is broken now.
>> You are getting a data bus error by any chance?
>>
> 
> after a pci write, the pci read return bogus values.

Can you be more specific please? The new code reads bogus values from every
configuration registers or only from some of them?

> However, I go through this tomorrow.

Ok.

<...>

>>> -I never hit the pci controller bug, any steps to replicate?
>>
>> Hm, weird. Your devices are based on AR7240 or or AR7241?
>>
>> Regards,
>> Gabor
>>
> 
> AR7241 AH-4A

Yeah, that is different, my Bullet 5M uses an AR7240. I have retested the code
with and without the workaround on an AR7241 based board and it is working in
both cases. So it seems that the AR7241 is not affected. I will change the patch
to use the workaround only if the kernel is running on AR7240.

> Maybe it is better to split ar71xx and ar72xx pci support completly?

Sorry, what do you mean? It is separated already. The common functions are
'pcibios_map_irq', 'pcibios_plat_dev_init' and 'ath79_register_pci'. None of
these functions are related to accessing of the PCI devices. Additionally, the
'ath79_register_pci' function calls the appropriate 'ar7{1x,24}x_pcibios_init'
depending on the actual SoC, so the AR71XX specific PCI controller code never
runs on AR724X.

-Gabor
