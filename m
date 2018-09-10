Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 15:28:07 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35031 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992492AbeIJN2EuL2FF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2018 15:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TtmovV74FKuWTBb+D94+Aoen8twR0slVwOJEOUxc4D0=;
        b=jBhN14v45XLi+hyi10wkEwrGpu3BhSjZ+b2haRwaDQYJFeSC4T+B2F7QSGGZ2CPSUqa4T/88wSDT7EU1knpJ5NnqQSLgjGNBpnDqFwoEBTf27taH7NiGpyPB074UYl5mcWQ9Sbo8zQolIt+OBHTDQ2bd9lthJAkEKNiC2Q9EH6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzMED-0000AO-CX; Mon, 10 Sep 2018 15:27:45 +0200
Date:   Mon, 10 Sep 2018 15:27:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/6] net: dsa: Add Lantiq / Intel DSA driver
 for vrx200
Message-ID: <20180910132745.GE30395@lunn.ch>
References: <20180909201647.32727-1-hauke@hauke-m.d>
 <20180909202039.471-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909202039.471-1-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Sun, Sep 09, 2018 at 10:20:39PM +0200, Hauke Mehrtens wrote:
> +static void gswip_phylink_validate(struct dsa_switch *ds, int port,
> +				   unsigned long *supported,
> +				   struct phylink_link_state *state)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> +
> +	switch (port) {
> +	case 0:
> +	case 1:
> +		if (!phy_interface_mode_is_rgmii(state->interface) &&
> +		    state->interface != PHY_INTERFACE_MODE_MII &&
> +		    state->interface != PHY_INTERFACE_MODE_REVMII &&
> +		    state->interface != PHY_INTERFACE_MODE_RMII) {
> +			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
> +			dev_err(ds->dev,
> +			"Unsupported interface: %d\n", state->interface);
> +			return;
> +		}
> +		break;
> +	case 2:
> +	case 3:
> +	case 4:
> +		if (state->interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
> +			dev_err(ds->dev,
> +			"Unsupported interface: %d\n", state->interface);
> +			return;
> +		}
> +		break;
> +	case 5:
> +		if (!phy_interface_mode_is_rgmii(state->interface) &&
> +		    state->interface != PHY_INTERFACE_MODE_INTERNAL) {
> +			bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
> +			dev_err(ds->dev,
> +			"Unsupported interface: %d\n", state->interface);
> +			return;

Hi Hauke

Minor nit. You have the same thing repeated three times. Maybe change
it to a goto out; and have the error block only once at the out:
label.

> +static int gswip_gphy_fw_list(struct gswip_priv *priv,
> +			      struct device_node *gphy_fw_list_np, u32 version)
> +{
> +	struct device *dev = priv->dev;
> +	struct device_node *gphy_fw_np;
> +	const struct of_device_id *match;
> +	int err;
> +	int i = 0;
> +
> +	/* The The VRX200 rev 1.1 uses the GSWIP 2.0 and needs the older

Double The.

> +
> +	/* bring up the mdio bus */
> +	mdio_np = of_find_compatible_node(pdev->dev.of_node, NULL,
> +					  "lantiq,xrx200-mdio");
> +	if (mdio_np) {
> +		err = gswip_mdio(priv, mdio_np);
> +		if (err) {
> +			dev_err(dev, "mdio probe failed\n");
> +			goto gphy_fw;
> +		}
> +	}
> +
> +	err = dsa_register_switch(priv->ds);
> +	if (err) {
> +		dev_err(dev, "dsa switch register failed: %i\n", err);
> +		goto mdio_bus;
> +	}

> +	if (priv->ds->dst->cpu_dp->index != priv->hw_info->cpu_port) {

I think that can be simplified to

        if (!dsa_is_cpu_port(ds, priv->hw_info->cpu_port))

which is probably more readable.

Florian was also considering that we should move this test into the
DSA core. But for the moment, doing it here is O.K.

This is otherwise looking good.

Thanks

    Andrew
