Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:41:42 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:53459 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904136Ab1KRSlf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:41:35 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B3C7623C0087;
        Fri, 18 Nov 2011 19:41:33 +0100 (CET)
Message-ID: <4EC6A6E3.8040806@openwrt.org>
Date:   Fri, 18 Nov 2011 19:41:39 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/7] MIPS: ath79: add a common PCI registration function
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org> <1321629720-29035-4-git-send-email-juhosg@openwrt.org> <CAEWqx59XzDyGWi7q-PYjiXx7t1Jinoz8ygypbk65CmD+zcyW2g@mail.gmail.com>
In-Reply-To: <CAEWqx59XzDyGWi7q-PYjiXx7t1Jinoz8ygypbk65CmD+zcyW2g@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15787

2011.11.18. 19:32 keltezéssel, René Bolldorf írta:
> On Fri, Nov 18, 2011 at 4:21 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
>> The current code unconditionally registers the AR724X
>> specific PCI controller, even if the kernel is running
>> on a different SoC.
>>
> This is not true, take a look in the ath79 Kconfig file...

Well, it is true. If you have the Ubiquiti board selected, that will allow you
to select the PCI code to be built. If you select the PCI code as well, then
pci-ath724x.c will be compiled into the kernel. Due to the nature of the
'arch_initcall' macro the PCI controller always gets registered. If you have
another board selected along with the Ubiquiti, and you are trying to run the
kernel on the other board, the PCI controller will be registered on that as well.

-Gabor
