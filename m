Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 20:51:50 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:52061 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903740Ab2CNTvo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 20:51:44 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8680723C00BA;
        Wed, 14 Mar 2012 20:21:16 +0100 (CET)
Message-ID: <4F60F6CF.1010007@openwrt.org>
Date:   Wed, 14 Mar 2012 20:51:43 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH v4 7/7] USB: use generic platform driver on ath79
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de> <1331597093-425-8-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1331597093-425-8-git-send-email-hauke@hauke-m.de>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-archive-position: 32709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

2012.03.13. 1:04 keltezéssel, Hauke Mehrtens írta:
> The ath79 usb driver doesn't do anything special and is now converted
> to the generic ehci and ohci driver.
> This was tested on a TP-Link TL-WR1043ND (AR9132)
> 
> CC: Gabor Juhos <juhosg@openwrt.org>
> CC: Imre Kaloz <kaloz@openwrt.org>
> CC: linux-mips@linux-mips.org
> CC: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Gabor Juhos <juhosg@openwrt.org>
