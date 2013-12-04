Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2013 15:05:17 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:49836 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827435Ab3LDOFOcf0RK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Dec 2013 15:05:14 +0100
Received: from mail-ve0-f172.google.com (mail-ve0-f172.google.com [209.85.128.172])
        by mail.nanl.de (Postfix) with ESMTPSA id B5E7C460B1;
        Wed,  4 Dec 2013 14:04:08 +0000 (UTC)
Received: by mail-ve0-f172.google.com with SMTP id jw12so11998303veb.17
        for <multiple recipients>; Wed, 04 Dec 2013 06:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1TKzuJLUDbXHNwuYjVgrkMdf/oaQxV6PBd746ic4Q48=;
        b=iPp2lEv7KlNqSerJ+5xNXTS+ZtgW9Z8IHFNZ6cBNVoM9BIqhnVcUrUhN/rodzABkR7
         3mxIruXE4UjqFdqnRyqyY/sjFozZSs308oPfc1hYnFoQ+x18mfYYnwjjyLfBPfNgxP9/
         He0yTQYYV+ttk5joW3D9+JBWOexn+yb5hxIJDfl8auq2IfvNK70Gba1BT/31L0jy5QoP
         0gA4mptlIM66Kzu3Pl5WE3ZDvCNnQLXS9O4Hn+2jEX1A29F9nC5diGL8mxi/GXOsrcEQ
         SuI6ii4XlZbp5cnrpPoDHWuLIRzBaYKtQgXBrc2cCG3khAhDOtKSAtPKSnu/e/KSqVq+
         jhIw==
X-Received: by 10.52.78.193 with SMTP id d1mr495184vdx.57.1386165908184; Wed,
 04 Dec 2013 06:05:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.208.136 with HTTP; Wed, 4 Dec 2013 06:04:48 -0800 (PST)
In-Reply-To: <20131204133823.GS29268@sirena.org.uk>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org> <20131204133823.GS29268@sirena.org.uk>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 4 Dec 2013 15:04:48 +0100
Message-ID: <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
To:     Mark Brown <broonie@kernel.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-spi@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Nov 30, 2013 at 12:42:06PM +0100, Jonas Gorski wrote:
>> Add a driver for the High Speed SPI controller found on newer BCM63XX SoCs.
>>
>> It does feature some new modes like 3-wire or dual spi, but neither of it
>> is currently implemented.
>
> This is basically good so I've applied it but there are a few minor
> things that could use improving, please send incremental patches for
> these.

Cool, thanks, will do. Expect a few days delay since I'm in the middle
of a cold. I Don't want to introduce thinkos ;-)

>
>> +     clk = clk_get(dev, "hsspi");
>
> Use devm_clk_get().

Oh, it indeed seems to work now. The last time I tried it broke
compilation because bcm63xx does not implement CLKDEV (or something
like that).

>
>> +     clk_prepare_enable(clk);
>
> You should check the return value here.

True, even if it can't fail in the current supported platforms.

>
>> +     /* register and we are done */
>> +     ret = spi_register_master(master);
>> +     if (ret)
>> +             goto out_put_master;
>
> devm_spi_register_master().

Sure thing.

>
>> +#ifdef CONFIG_PM
>
> This should be CONFIG_PM_SLEEP.

Ah, dammit, I knew I forgot something. I remember the same issue was
fixed for spi-bcm63xx.c, but somehow forgot to check for it in this
driver.


>> +static int bcm63xx_hsspi_suspend(struct device *dev)
>> +{
>> +     struct spi_master *master = dev_get_drvdata(dev);
>> +     struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
>> +
>> +     spi_master_suspend(master);
>> +     clk_disable(bs->clk);
>
> This ought to be disable_unprepare().  It would also be better to move
> this to runtime PM (you can set auto_runtime_pm to have the core manage
> the enable and disable for you) since that will save a bit of power.

I already set auto_runtime_pm to true. I basically copied what's
currently in spi-bcm63xx.c *coughs*. Is there anything else needed
besides what you mentioned?
>
>> +static int bcm63xx_hsspi_resume(struct device *dev)
>> +{
>> +     struct spi_master *master = dev_get_drvdata(dev);
>> +     struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
>> +
>> +     clk_enable(bs->clk);
>> +     spi_master_resume(master);
>
> Similar comments here, plus you should be checking errors.

Will fix that, too.


Regards
Jonas
