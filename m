Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 12:20:29 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([IPv6:2001:67c:670:201:290:27ff:fe1d:cc33]:33145
        "EHLO metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdE2KUVTmvpw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 12:20:21 +0200
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.84_2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1dFHme-00005Y-5e; Mon, 29 May 2017 12:20:20 +0200
Message-ID: <1496053214.17695.49.camel@pengutronix.de>
Subject: Re: [PATCH v3 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org,
        andy.shevchenko@gmail.com
Date:   Mon, 29 May 2017 12:20:14 +0200
In-Reply-To: <20170528184006.31668-11-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
         <20170528184006.31668-11-hauke@hauke-m.de>
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
X-archive-position: 58064
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

On Sun, 2017-05-28 at 20:40 +0200, Hauke Mehrtens wrote:
[...]
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> @@ -0,0 +1,30 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,reset-danube"
> +				"lantiq,reset-xrx200"
> +- regmap		: A phandle to the RCU syscon
> +- offset-set		: Offset of the reset set register
> +- offset-status		: Offset of the reset status register
> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 2.
> +			  The first cell takes the reset set bit and the
> +			  second cell takes the status bit.
> +
> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	reset0: reset-controller@0 {
> +		compatible = "lantiq,reset-xrx200";
> +
> +		regmap = <&rcu0>;

Why not place these nodes as children of &rcu0 ? This property would be
superfluous then.

> +		offset-set = <0x10>;
> +		offset-status = <0x14>;
> +		#reset-cells = <2>;
> +	};
[...]
> --- /dev/null
> +++ b/drivers/reset/reset-lantiq.c
> @@ -0,0 +1,205 @@
[...]
> +static int lantiq_rcu_reset_update(struct reset_controller_dev *rcdev,
> +				   unsigned long id, bool assert)
> +{
> +	struct lantiq_rcu_reset_priv *priv = to_lantiq_rcu_reset_priv(rcdev);
> +	int ret, retry = LANTIQ_RCU_RESET_TIMEOUT;
> +	unsigned int set = id & 0x1f;
> +	u32 val;
> +
> +	if (assert)
> +		val = BIT(set);
> +	else
> +		val = 0;
> +
> +	ret = regmap_update_bits(priv->regmap, priv->reset_offset, BIT(set),
> +				 val);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to set reset bit %u\n", set);
> +		return ret;
> +	}
> +
> +	do {
> +		ret = lantiq_rcu_reset_status(rcdev, id);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == assert)
> +			break;
> +		usleep_range(20, 40);
> +	} while (--retry);

How about wrapping this in a lantiq_rcu_poll_status(_timeout) function?
I still think this is a case where regmap_read_poll_timeout could be
used.

[...]
> +static int lantiq_rcu_reset_of_probe(struct platform_device *pdev,
> +			       struct lantiq_rcu_reset_priv *priv)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	priv->regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");

Why not use syscon_node_to_regmap(dev->of_node->parent) ?

regards
Philipp
