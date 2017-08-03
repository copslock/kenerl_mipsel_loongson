Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 23:41:50 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:46928 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994908AbdHCVlg3w2bu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Aug 2017 23:41:36 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 3E76A458DA;
        Thu,  3 Aug 2017 23:41:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id AhkDo9WHLb3u; Thu,  3 Aug 2017 23:41:17 +0200 (CEST)
Subject: Re: [PATCH v8 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com
References: <20170802225717.24408-1-hauke@hauke-m.de>
 <20170802225717.24408-11-hauke@hauke-m.de>
 <1501749222.23911.4.camel@pengutronix.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4f7f41ad-b6fe-082e-085f-119ad959b817@hauke-m.de>
Date:   Thu, 3 Aug 2017 23:41:15 +0200
MIME-Version: 1.0
In-Reply-To: <1501749222.23911.4.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 08/03/2017 10:33 AM, Philipp Zabel wrote:
> Hi Hauke,
> 
> On Thu, 2017-08-03 at 00:57 +0200, Hauke Mehrtens wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>  .../devicetree/bindings/reset/lantiq,reset.txt     |  30 +++
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq.c                       | 224 +++++++++++++++++++++
>>  4 files changed, 261 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq.c
>>
> [...]
>> diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
>> new file mode 100644
>> index 000000000000..b84c45e7e6b8
>> --- /dev/null
>> +++ b/drivers/reset/reset-lantiq.c
>> @@ -0,0 +1,224 @@
> [...]
>> +static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
>> +			       struct lantiq_rcu_reset_priv *priv)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	struct resource res_parent;
>> +	int ret;
>> +
>> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
>> +	if (IS_ERR(priv->regmap)) {
>> +		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
>> +		return PTR_ERR(priv->regmap);
>> +	}
>> +
>> +	ret = of_address_to_resource(dev->of_node->parent, 0, &res_parent);
>> +	if (ret)
>> +		return ret;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
>> +		return ret;
> 
> This should return -EINVAL instead of 0.

I will fix this in the next round, I am still waiting for Rob's feedback.

The same problem exists in the USB PHY driver, I will also fix it there.

> 
>> +	}
>> +
>> +	if (res->start < res_parent.start)
>> +		return -ENOENT;
>> +	priv->reset_offset = res->start - res_parent.start;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
>> +		return ret;
> 
> Same here.
> 
> With this fixed,
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> regards
> Philipp
> 

Hauke
