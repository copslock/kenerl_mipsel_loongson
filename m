Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 21:44:06 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:41846 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012497AbbLBUoETs8GM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2015 21:44:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=f7S99wPx4zbQYLNehnlSzLcQXQ7vm7w+Y2lX3kQwx+Q=;
        b=HScBAt5gXGa4+C8p6vLEQTSKnM2mCevOyxU+qEJnBQERbUgeirz9XyWpBnGw14SjirJg1A2m+7Mvi9ETHwifcoZ22mkK9my3p/pSYJjA46J4MMtakeV+GdqP+WxYnjhq8rPqWhA3zDrS/1aue6IxtlPGS6RawMndCy2sy6ovDHiLwtAfh2iutbcwBh3mjkp5leVpeq0RnxTxgV36c7Gxenvz7+QclYptAAtgsaE/bfIQWEdG36/sXWfHfSn/Knyt8XalftjHioJml8yC+hEzq4BRvE7DW7EmdzgvBZLHRP2zZxnQPQ5vyfxk6hcKPKbX7LDm6T5Kjx0pQ4QvjWpGVg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:48861)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a4EFj-0005r3-Vr (Exim); Wed, 02 Dec 2015 20:43:52 +0000
Subject: Re: [PATCH 2/2] reset: bcm63xx: Add support for the BCM63xx
 soft-reset controller
To:     Florian Fainelli <f.fainelli@gmail.com>
References: <565CB83B.7010000@simon.arlott.org.uk>
 <565CB86F.4040303@simon.arlott.org.uk>
 <CAGVrzcbjdsbGLuH6T6DSoC5SGN5WDFdM1h1xB5nQyX8wm-Esow@mail.gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565F5805.6010506@simon.arlott.org.uk>
Date:   Wed, 2 Dec 2015 20:43:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAGVrzcbjdsbGLuH6T6DSoC5SGN5WDFdM1h1xB5nQyX8wm-Esow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 02/12/15 18:03, Florian Fainelli wrote:
> 2015-11-30 12:58 GMT-08:00 Simon Arlott <simon@fire.lp0.eu>:
>> The BCM63xx contains a soft-reset controller activated by setting
>> a bit (that must previously have cleared).
>>
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>> ---
>>  MAINTAINERS                   |   1 +
>>  drivers/reset/Kconfig         |   9 +++
>>  drivers/reset/Makefile        |   1 +
>>  drivers/reset/reset-bcm63xx.c | 134 ++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 145 insertions(+)
>>  create mode 100644 drivers/reset/reset-bcm63xx.c
> 
> 
> Could you create a bcm directory and then add your reset-bcm63xx.c
> file there? I have a pending submission for the BCM63138 reset
> controller which is not at all using the same structure and will share
> nothing with your driver.
> 

Ok, I'll call it reset-bcm6345.c to avoid confusion.

> 
>> +static int bcm63xx_reset_xlate(struct reset_controller_dev *rcdev,
>> +       const struct of_phandle_args *reset_spec)
>> +{
>> +       struct bcm63xx_reset_priv *priv = to_bcm63xx_reset_priv(rcdev);
>> +
>> +       if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
>> +               return -EINVAL;
>> +
>> +       if (reset_spec->args[0] >= rcdev->nr_resets)
>> +               return -EINVAL;
> 
> Should not these two things be moved to the core reset controller code
> based on the #reset-cells value?
> 

This has already been removed from the next version of the patch.

> 
>> +       if (of_property_read_u32(np, "offset", &priv->offset))
>> +               return -EINVAL;
>> +
>> +       /* valid reset bits */
>> +       if (of_property_read_u32(np, "mask", &priv->mask))
>> +               priv->mask = 0xffffffff;
>> +
>> +       priv->rcdev.owner = THIS_MODULE;
>> +       priv->rcdev.ops = &bcm63xx_reset_ops;
>> +       priv->rcdev.nr_resets = 32;
> 
> Should not that come from Device Tree, or be computed based on the
> mask property, like hweight_long() or something along these lines?

The "mask" property has been removed. It will assume 32 resets and rely
on the rest of the DT to only refer to valid bits.

-- 
Simon Arlott
