Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 20:43:46 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1226 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903438Ab2HPSni convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 20:43:38 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 16 Aug 2012 11:42:00 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 16 Aug 2012 11:43:15 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 6ECA59F9F5; Thu, 16 Aug 2012 11:43:15 -0700 (PDT)
Received: from [10.0.2.15] (unknown [10.177.252.134]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 2ADCB207C0; Thu, 16
 Aug 2012 11:43:12 -0700 (PDT)
Message-ID: <502D3F3F.7060207@broadcom.com>
Date:   Thu, 16 Aug 2012 20:43:11 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714
 Thunderbird/14.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
cc:     "Florian Fainelli" <florian@openwrt.org>,
        "Hauke Mehrtens" <hauke@hauke-m.de>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        john@phrozen.org
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use
 gpiolib
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de>
 <1345132801-8430-4-git-send-email-hauke@hauke-m.de>
 <1791263.5FQJJv4xHF@bender>
 <CACna6rxVOFO-n5J_6J7HFSt+WnoX0=2ULjiRv3p9va47K2Edsw@mail.gmail.com>
In-Reply-To: <CACna6rxVOFO-n5J_6J7HFSt+WnoX0=2ULjiRv3p9va47K2Edsw@mail.gmail.com>
X-WSS-ID: 7C33E1723NK16219348-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-archive-position: 34227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/16/2012 07:39 PM, Rafał Miłecki wrote:
> 2012/8/16 Florian Fainelli<florian@openwrt.org>:
>>> >>+void __init bcm47xx_gpio_init(void)
>>> >>+{
>>> >>+     int err;
>>> >>+
>>> >>+     switch (bcm47xx_bus_type) {
>>> >>+#ifdef CONFIG_BCM47XX_SSB
>>> >>+     case BCM47XX_BUS_TYPE_SSB:
>>> >>+             bcm47xx_gpio_count = ssb_gpio_count(&bcm47xx_bus.ssb);
>>> >>+#endif
>>> >>+#ifdef CONFIG_BCM47XX_BCMA
>>> >>+     case BCM47XX_BUS_TYPE_BCMA:
>>> >>+             bcm47xx_gpio_count = bcma_gpio_count(&bcm47xx_bus.bcma.bus);
>>> >>+#endif
>>> >>+     }
>> >
>> >Is this exclusive? Cannot we have both SSB and BCMA on the same device?
> This applies to SoC only, so I believe it's fine. We don't have SoCs
> based on BCMA and SSB at the same time.

It is indeed more than unlikely for a chip to have two silicon 
interconnects, which is what SSB and BCMA are. However, it does look 
suspicious from a code reading perspective. So I general I stick to the 
rule that each case must have a break and fall-thru are clearly commented.

> You can find devices with multiple buses, but additional ones are
> connected via PCIE or USB interface (or some other I don't know
> about).
>
> -- Rafał

Gr. AvS
