Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 13:13:02 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:48278 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903547Ab1KWMM4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 13:12:56 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9ACBB23C0098;
        Wed, 23 Nov 2011 13:12:51 +0100 (CET)
Message-ID: <4ECCE343.1010301@openwrt.org>
Date:   Wed, 23 Nov 2011 13:12:51 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 4/7] MIPS: ath79: add a common PCI registration function
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org> <1321887999-14546-5-git-send-email-juhosg@openwrt.org> <CAEWqx5-05WSPYfWOO=TBtQAJ0NmvCGvtJ1LEgfiJ3UdzJF+q2g@mail.gmail.com> <4ECCDDF1.7060605@openwrt.org> <CAEWqx58pY6xpNRsTj0b01=g-JxQdTpbT=OMMLFsPFwk8EPHHKA@mail.gmail.com>
In-Reply-To: <CAEWqx58pY6xpNRsTj0b01=g-JxQdTpbT=OMMLFsPFwk8EPHHKA@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19854

2011.11.23. 13:03 keltezéssel, René Bolldorf írta:
> That is in 'arch/mips/include/asm/mach-ath79'.
> A error in the patch?

Sorry, I meant 2/7:

> diff --git a/arch/mips/include/asm/mach-ath79/pci-ath724x.h b/arch/mips/ath79/pci.h
> similarity index 100%
> rename from arch/mips/include/asm/mach-ath79/pci-ath724x.h
> rename to arch/mips/ath79/pci.h
