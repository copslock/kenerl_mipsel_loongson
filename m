Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 22:59:48 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58245 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904026Ab2AaV7l convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 22:59:41 +0100
Received: by pbdx9 with SMTP id x9so621136pbd.36
        for <multiple recipients>; Tue, 31 Jan 2012 13:59:35 -0800 (PST)
Received: by 10.68.73.196 with SMTP id n4mr52982063pbv.33.1328047174191; Tue,
 31 Jan 2012 13:59:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.224.170 with HTTP; Tue, 31 Jan 2012 13:59:14 -0800 (PST)
In-Reply-To: <201201312220.41561.florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
 <1328019048-5892-10-git-send-email-florian@openwrt.org> <20120131201922.GE22611@ponder.secretlab.ca>
 <201201312220.41561.florian@openwrt.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Tue, 31 Jan 2012 14:59:14 -0700
X-Google-Sender-Auth: CDQDNoHBnR8sOw185xG2OCQgb18
Message-ID: <CACxGe6vsW6u5s26vat=M4J-+39NK5L=ccydQaVkGHYZpeV=gOw@mail.gmail.com>
Subject: Re: [PATCH 9/9 v3] spi: add Broadcom BCM63xx SPI controller driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jan 31, 2012 at 2:20 PM, Florian Fainelli <florian@openwrt.org> wrote:
> On Tuesday 31 January 2012 21:19:22 Grant Likely wrote:
>> > +static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
>> > +   .suspend        = bcm63xx_spi_suspend,
>> > +   .resume         = bcm63xx_spi_resume,
>> > +};
>> > +
>> > +#define BCM63XX_SPI_PM_OPS (&bcm63xx_spi_pm_ops)
>> > +#else
>> > +#define BCM63XX_SPI_PM_OPS NULL
>>
>> A bit ugly.  Do this instead in the else clause and drop the
>> BCM63XX_SPI_PM_OPS:
>>
>> #define bcm63xx_spi_pm_ops NULL
>
> This won't work, because driver.pm must be set to a pointer to a struct
> dev_pm_ops, that's why I used this trick to make it build fine in both cases.
> If I follow your advice, with driver.pm = &bcm63xx_spi_pm_ops, it won't build
> for CONFIG_PM=n.

Okay, fair enough.

g.
