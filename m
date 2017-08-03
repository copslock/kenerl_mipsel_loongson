Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 10:33:54 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([IPv6:2001:67c:670:201:290:27ff:fe1d:cc33]:41393
        "EHLO metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993035AbdHCIdp1onWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2017 10:33:45 +0200
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.84_2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ddBZh-0004Vx-0q; Thu, 03 Aug 2017 10:33:45 +0200
Message-ID: <1501749222.23911.4.camel@pengutronix.de>
Subject: Re: [PATCH v8 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com
Date:   Thu, 03 Aug 2017 10:33:42 +0200
In-Reply-To: <20170802225717.24408-11-hauke@hauke-m.de>
References: <20170802225717.24408-1-hauke@hauke-m.de>
         <20170802225717.24408-11-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <p.zabel@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.zabel@pengutronix.de
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

Hi Hauke,

On Thu, 2017-08-03 at 00:57 +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
> 
> For some devices the request and the status bits are different.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/reset/lantiq,reset.txt     |  30 +++
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq.c                       | 224 +++++++++++++++++++++
>  4 files changed, 261 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>  create mode 100644 drivers/reset/reset-lantiq.c
> 
[...]
> diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
> new file mode 100644
> index 000000000000..b84c45e7e6b8
> --- /dev/null
> +++ b/drivers/reset/reset-lantiq.c
> @@ -0,0 +1,224 @@
[...]
> +static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
> +			       struct lantiq_rcu_reset_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct resource res_parent;
> +	int ret;
> +
> +	priv->regmap = syscon_node_to_regmap(dev->of_node->parent);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(&pdev->dev, "Failed to lookup RCU regmap\n");
> +		return PTR_ERR(priv->regmap);
> +	}
> +
> +	ret = of_address_to_resource(dev->of_node->parent, 0, &res_parent);
> +	if (ret)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get RCU reset offset\n");
> +		return ret;

This should return -EINVAL instead of 0.

> +	}
> +
> +	if (res->start < res_parent.start)
> +		return -ENOENT;
> +	priv->reset_offset = res->start - res_parent.start;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Failed to get RCU status offset\n");
> +		return ret;

Same here.

With this fixed,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
