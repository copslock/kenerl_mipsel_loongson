Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 23:24:04 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:59593 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990506AbdKIWX4UPhrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 23:23:56 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eCvEm-0006oQ-NP; Thu, 09 Nov 2017 23:23:52 +0100
Date:   Thu, 9 Nov 2017 23:23:52 +0100
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
Subject: Re: [PATCH v3 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171109222352.GA25275@lunn.ch>
References: <20171109192915.11912-1-david.daney@cavium.com>
 <20171109192915.11912-8-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109192915.11912-8-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60825
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

> +	priv->phy_np = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
> +	priv->phy_mode = of_get_phy_mode(pdev->dev.of_node);
> +	/* If phy-mode absent, default to SGMII. */
> +	if (priv->phy_mode < 0)
> +		priv->phy_mode = PHY_INTERFACE_MODE_SGMII;
> +
> +	if (priv->phy_mode == PHY_INTERFACE_MODE_1000BASEX)
> +		priv->mode_1000basex = true;
> +
> +	if (of_phy_is_fixed_link(pdev->dev.of_node))
> +		priv->bgx_as_phy = true;
> +

...

> +	priv->mode = bgx_port_get_mode(priv->node, priv->bgx, priv->index);
> +

It might be a good idea to verify priv->phy_mode and priv->mode are
compatible.

> +	switch (priv->mode) {
> +	case PORT_MODE_SGMII:
> +	case PORT_MODE_RGMII:
> +		priv->get_link = bgx_port_get_sgmii_link;
> +		priv->set_link = bgx_port_set_xgmii_link;
> +		break;
> +	case PORT_MODE_XAUI:
> +	case PORT_MODE_RXAUI:
> +	case PORT_MODE_XLAUI:
> +	case PORT_MODE_XFI:
> +	case PORT_MODE_10G_KR:
> +	case PORT_MODE_40G_KR4:
> +		priv->get_link = bgx_port_get_xaui_link;
> +		priv->set_link = bgx_port_set_xaui_link;
> +		break;


  Andrew
