Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 21:43:57 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:44656 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904114Ab1KWUnv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 21:43:51 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B49E823C00B5;
        Wed, 23 Nov 2011 21:43:48 +0100 (CET)
Message-ID: <4ECD5B06.10204@openwrt.org>
Date:   Wed, 23 Nov 2011 21:43:50 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     =?UTF-8?B?UmVuw6kgQm9sbGRvcmY=?= <xsecute@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org> <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com> <4ECCFE72.6090300@openwrt.org> <CAEWqx5_hgSH0FoWJPL0JDrVXGTWFCV0-FH9hXPMTxbG3A1pScQ@mail.gmail.com> <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com>
In-Reply-To: <CAEWqx5_emEPp1HzK=SwOUJnJp5uFhco1asEQjuucdEV4rTQCdg@mail.gmail.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20307

2011.11.23. 16:15 keltezéssel, René Bolldorf írta:
> It seems your board is a older one.

Yes, it uses AR7240.

> Can you remove the heatsink and post the revision from the SoC?

Sorry, I can't remove the heatsink. It is glued onto the SoC, and I don't want
to brick the board. However the kernel shows this:

SoC: Atheros AR7240 rev 2
Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz

On the TL-MR3420:

SoC: Atheros AR7241 rev 1
Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz

-Gabor
