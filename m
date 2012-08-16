Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 21:29:39 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37073 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903435Ab2HPT3e convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 21:29:34 +0200
Received: by wgbdr1 with SMTP id dr1so2427638wgb.24
        for <multiple recipients>; Thu, 16 Aug 2012 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kLCenX8wJECby7O3j6B0n5QdVeRpFLaL2y/JvPMWYU4=;
        b=JALnzyfcjA85V9sdkqBtiysc54D18LUcDMU32O3j25xmCM5KAnlB1unVOz7vPF/ggV
         7zR6nF25XJWPc7W+iyXcrRU21lk4pjHfjWtxjuX3GP9B+dw8SwI5Cra5wUni2fP+yyvt
         xXwyHm2pizWcUvHXFmB3lXFE4dqtpca02TOlkXV6HItfDfk4mg2fVE3BUpeLcUR/YL1z
         +RyL3P+4P2cWDgweD8GBb5ob6UYCNkt3im/p4UvePYDmR7CISZqv58VIkx9E5DrP+KwR
         UYRZy/bYPehahX9midR03TaUfh8GfmtuX/t5jQAgAkAlneh8CPLsvibUQw36Tc1A+2//
         sSAQ==
MIME-Version: 1.0
Received: by 10.216.220.89 with SMTP id n67mr1285410wep.73.1345145368862; Thu,
 16 Aug 2012 12:29:28 -0700 (PDT)
Received: by 10.216.169.136 with HTTP; Thu, 16 Aug 2012 12:29:28 -0700 (PDT)
In-Reply-To: <502D3F3F.7060207@broadcom.com>
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de>
        <1345132801-8430-4-git-send-email-hauke@hauke-m.de>
        <1791263.5FQJJv4xHF@bender>
        <CACna6rxVOFO-n5J_6J7HFSt+WnoX0=2ULjiRv3p9va47K2Edsw@mail.gmail.com>
        <502D3F3F.7060207@broadcom.com>
Date:   Thu, 16 Aug 2012 21:29:28 +0200
Message-ID: <CACna6ryphAPip5hpAuzCMQjqvZe70MpPnFkCyzrMhFkk5iLS+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        john@phrozen.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 34228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2012/8/16 Arend van Spriel <arend@broadcom.com>:
> On 08/16/2012 07:39 PM, Rafał Miłecki wrote:
>>
>> 2012/8/16 Florian Fainelli<florian@openwrt.org>:
>>>>
>>>> >>+void __init bcm47xx_gpio_init(void)
>>>> >>+{
>>>> >>+     int err;
>>>> >>+
>>>> >>+     switch (bcm47xx_bus_type) {
>>>> >>+#ifdef CONFIG_BCM47XX_SSB
>>>> >>+     case BCM47XX_BUS_TYPE_SSB:
>>>> >>+             bcm47xx_gpio_count = ssb_gpio_count(&bcm47xx_bus.ssb);
>>>> >>+#endif
>>>> >>+#ifdef CONFIG_BCM47XX_BCMA
>>>> >>+     case BCM47XX_BUS_TYPE_BCMA:
>>>> >>+             bcm47xx_gpio_count =
>>>> >> bcma_gpio_count(&bcm47xx_bus.bcma.bus);
>>>> >>+#endif
>>>> >>+     }
>>>
>>> >
>>> >Is this exclusive? Cannot we have both SSB and BCMA on the same device?
>>
>> This applies to SoC only, so I believe it's fine. We don't have SoCs
>> based on BCMA and SSB at the same time.
>
>
> It is indeed more than unlikely for a chip to have two silicon
> interconnects, which is what SSB and BCMA are. However, it does look
> suspicious from a code reading perspective. So I general I stick to the rule
> that each case must have a break and fall-thru are clearly commented.

Ahh, I though question is related to the enum used for bustype. I
definitely vote for using "break"


-- 
Rafał
