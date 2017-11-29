Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 23:56:24 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46796 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2W4Riawv3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 23:56:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PyQvMnvcYNjrDOEa0V/DntdRbKVCRo5uUnDeAuGL1w0=;
        b=zbBKxlqAOTsGICYOS2vzhib3yKi8OgC3F76BxUHVCNBZOpmhhefafz2Xhh58YoMUe2HKaNbqsety3nMY6D9BB7bOvH5hJWZukY2acqh1cLp1hhK90dPpnzeX9ktOf+mfMLujsel5090jIx78Xi24YU/7Nfyek+rObeElLwY3YE0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eKBGz-0001uA-9Q; Wed, 29 Nov 2017 23:56:09 +0100
Date:   Wed, 29 Nov 2017 23:56:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171129225609.GE1706@lunn.ch>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129005540.28829-8-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61229
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

On Tue, Nov 28, 2017 at 04:55:39PM -0800, David Daney wrote:
> +static int bgx_probe(struct platform_device *pdev)
> +{
> +	struct mac_platform_data platform_data;
> +	const __be32 *reg;
> +	u32 port;
> +	u64 addr;
> +	struct device_node *child;
> +	struct platform_device *new_dev;
> +	struct platform_device *pki_dev;
> +	int numa_node, interface;
> +	int i;
> +	int r = 0;
> +	char id[64];
> +	u64 data;
> +
> +	reg = of_get_property(pdev->dev.of_node, "reg", NULL);
> +	addr = of_translate_address(pdev->dev.of_node, reg);
> +	interface = (addr >> 24) & 0xf;
> +	numa_node = (addr >> 36) & 0x7;

Hi David

You have these two a few times in the code. Maybe add a helper to do
it? The NUMA one i assume could go somewhere in the SoC code?

> +static int bgx_mix_init_from_fdt(void)
> +{
> +	struct device_node	*node;
> +	struct device_node	*parent = NULL;
> +	int			mix = 0;

> +		/* Get the lmac index */
> +		reg = of_get_property(lmac_fdt_node, "reg", NULL);
> +		if (!reg)
> +			goto err;
> +
> +		mix_port_lmacs[mix].lmac = *reg;

I don't think of_get_property() deals with endianness. Is there any
danger of this driver being used on hardware with the other endianness
to what you have tested?

> +/**
> + * bgx_pki_init_from_param - Initialize the list of lmacs that connect to the
> + *			     pki from information in the "pki_port" parameter.
> + *
> + *			     The pki_port parameter format is as follows:
> + *			     pki_port=nbl
> + *			     where:
> + *				n = node
> + *				b = bgx
> + *				l = lmac
> + *
> + *			     Commas must be used to separate multiple lmacs:
> + *			     pki_port=000,100,110
> + *
> + *			     Asterisks (*) specify all possible characters in
> + *			     the subset:
> + *			     pki_port=00* (all lmacs of node0 bgx0).
> + *
> + *			     Missing lmacs identifiers default to all
> + *			     possible characters in the subset:
> + *			     pki_port=00 (all lmacs on node0 bgx0)
> + *
> + *			     Brackets ('[' and ']') specify the valid
> + *			     characters in the subset:
> + *			     pki_port=00[01] (lmac0 and lmac1 of node0 bgx0).
> + *
> + * Returns 0 if successful.
> + * Returns <0 for error codes.

I've not used kerneldoc much, but i suspect this is wrongly formated:

https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#function-documentation

> +int bgx_port_ethtool_set_settings(struct net_device	*netdev,
> +				  struct ethtool_cmd	*cmd)
> +{
> +	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;

Not required. The enforces this. See dev_ethtool()

> +
> +	if (p->phydev)
> +		return phy_ethtool_sset(p->phydev, cmd);
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(bgx_port_ethtool_set_settings);
> +
> +int bgx_port_ethtool_nway_reset(struct net_device *netdev)
> +{
> +	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;

Also not needed.

> +static void bgx_port_adjust_link(struct net_device *netdev)
> +{
> +	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
> +	bool			link_changed = false;
> +	unsigned int		link;
> +	unsigned int		speed;
> +	unsigned int		duplex;
> +
> +	mutex_lock(&priv->lock);
> +
> +	if (!priv->phydev->link && priv->last_status.link)
> +		link_changed = true;
> +
> +	if (priv->phydev->link &&
> +	    (priv->last_status.link != priv->phydev->link ||
> +	     priv->last_status.duplex != priv->phydev->duplex ||
> +	     priv->last_status.speed != priv->phydev->speed))
> +		link_changed = true;
> +
> +	link = priv->phydev->link;
> +	priv->last_status.link = priv->phydev->link;
> +
> +	speed = priv->phydev->speed;
> +	priv->last_status.speed = priv->phydev->speed;
> +
> +	duplex = priv->phydev->duplex;
> +	priv->last_status.duplex = priv->phydev->duplex;
> +
> +	mutex_unlock(&priv->lock);
> +
> +	if (link_changed) {
> +		struct port_status status;
> +
> +		phy_print_status(priv->phydev);
> +
> +		status.link = link ? 1 : 0;
> +		status.duplex = duplex;
> +		status.speed = speed;
> +		if (!link) {
> +			netif_carrier_off(netdev);
> +			 /* Let TX drain. FIXME check that it is drained. */
> +			mdelay(50);
> +		}
> +		priv->set_link(priv, status);
> +		if (link)
> +			netif_carrier_on(netdev);

The code should do netif_carrier_on/off for you. See phy_link_change()

> +static void bgx_port_check_state(struct work_struct *work)
> +{
> +	struct bgx_port_priv	*priv;
> +	struct port_status	status;
> +
> +	priv = container_of(work, struct bgx_port_priv, dwork.work);
> +
> +	status = priv->get_link(priv);
> +
> +	if (!status.link &&
> +	    priv->mode != PORT_MODE_SGMII && priv->mode != PORT_MODE_RGMII)
> +		bgx_port_init_xaui_link(priv);
> +
> +	if (priv->last_status.link != status.link) {
> +		priv->last_status.link = status.link;
> +		if (status.link)
> +			netdev_info(priv->netdev, "Link is up - %d/%s\n",
> +				    status.speed,
> +				    status.duplex == DUPLEX_FULL ? "Full" : "Half");

You already have phy_print_status() in bgx_port_adjust_link(). Do you need this here?

> +		else
> +			netdev_info(priv->netdev, "Link is down\n");
> +	}
> +
> +	mutex_lock(&priv->lock);
> +	if (priv->work_queued)
> +		queue_delayed_work(check_state_wq, &priv->dwork, HZ);
> +	mutex_unlock(&priv->lock);
> +}
> +
> +int bgx_port_enable(struct net_device *netdev)
> +{


> +	} else {
> +		priv->phydev = of_phy_connect(netdev, priv->phy_np,
> +					      bgx_port_adjust_link, 0, priv->phy_mode);
> +		if (!priv->phydev)
> +			return -ENODEV;
> +
> +		netif_carrier_off(netdev);
> +
> +		if (priv->phydev)

You already checked this above.

> +			phy_start_aneg(priv->phydev);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(bgx_port_enable);
> +
> +int bgx_port_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
> +	int max_frame;
> +
> +	if (new_mtu < 60 || new_mtu > 65392) {

See dev_set_mtu(). If you have done your initialisation correctly, this
won't happen.

> +static int bgx_port_probe(struct platform_device *pdev)
> +{
> +	switch (priv->mode) {
> +	case PORT_MODE_SGMII:
> +		if (priv->phy_np &&
> +		    priv->phy_mode != PHY_INTERFACE_MODE_SGMII)
> +			dev_warn(&pdev->dev, "SGMII phy mode mismatch.\n");
> +		goto set_link_functions;
> +	case PORT_MODE_RGMII:
> +		if (priv->phy_np &&
> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII &&
> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_ID &&
> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_RXID &&
> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_TXID)

phy_interface_mode_is_rgmii()

More later, maybe.

     Andrew
