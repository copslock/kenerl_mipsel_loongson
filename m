Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 19:39:21 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32783 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903452Ab2HPRjP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 19:39:15 +0200
Received: by wibhq4 with SMTP id hq4so804005wib.6
        for <multiple recipients>; Thu, 16 Aug 2012 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YzvUXa0F5TWf5Q6hQD3rjDaJsqFMAY9Q/7mK85mxoJo=;
        b=wsqVmV0xlSMl39XWi+TusLTqdlfJWom/MjkCO6rDqgRPB0SjBCzIEiqgdDR1XsW3OL
         Bi7zELwH7h/PEjER2l1M/lua4CIWpNGKjO8fT7jTa5NEj8mX8tqOKIF93vl7HFt0kAxR
         UOEEDbDY28vMjma/lg+GgKaj8rq8LPbOzwh4fO691gKpOy+UH7DUTzOe23CL1Ikt5pAv
         rNgDM3qyUraJ2BYP0fD675w8pfbIS4Kk+i9RppwBPmynrdYSPH+jCxp4jkYVyhgp5Sm1
         NiWNtYim/1hTd58zOmQil8P78CwdROm8I85s6nNBrb1KNbUUVKYnzBtpP7v7aaveO+N4
         8q5g==
MIME-Version: 1.0
Received: by 10.180.96.3 with SMTP id do3mr4996518wib.5.1345138750395; Thu, 16
 Aug 2012 10:39:10 -0700 (PDT)
Received: by 10.216.169.136 with HTTP; Thu, 16 Aug 2012 10:39:10 -0700 (PDT)
In-Reply-To: <1791263.5FQJJv4xHF@bender>
References: <1345132801-8430-1-git-send-email-hauke@hauke-m.de>
        <1345132801-8430-4-git-send-email-hauke@hauke-m.de>
        <1791263.5FQJJv4xHF@bender>
Date:   Thu, 16 Aug 2012 19:39:10 +0200
Message-ID: <CACna6rxVOFO-n5J_6J7HFSt+WnoX0=2ULjiRv3p9va47K2Edsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MIPS: BCM47xx: rewrite GPIO handling and use gpiolib
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        john@phrozen.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 34223
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

2012/8/16 Florian Fainelli <florian@openwrt.org>:
>> +void __init bcm47xx_gpio_init(void)
>> +{
>> +     int err;
>> +
>> +     switch (bcm47xx_bus_type) {
>> +#ifdef CONFIG_BCM47XX_SSB
>> +     case BCM47XX_BUS_TYPE_SSB:
>> +             bcm47xx_gpio_count = ssb_gpio_count(&bcm47xx_bus.ssb);
>> +#endif
>> +#ifdef CONFIG_BCM47XX_BCMA
>> +     case BCM47XX_BUS_TYPE_BCMA:
>> +             bcm47xx_gpio_count = bcma_gpio_count(&bcm47xx_bus.bcma.bus);
>> +#endif
>> +     }
>
> Is this exclusive? Cannot we have both SSB and BCMA on the same device?

This applies to SoC only, so I believe it's fine. We don't have SoCs
based on BCMA and SSB at the same time.

You can find devices with multiple buses, but additional ones are
connected via PCIE or USB interface (or some other I don't know
about).

-- 
Rafał
