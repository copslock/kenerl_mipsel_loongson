Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 15:50:34 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:56246 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993057AbeG3Nuan1k8o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 15:50:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=U3oipQDuKhWXq1o6qVl/9OolBNXLVPhtpVyoIhKPzuI=;
        b=Ekizksp68Ckc3otkrt30ClAdVFlQQGHlmssJZyGB6iaNArf1vcx88XX4qTD8IODmPSWBKEsbtQ7bKBCRLGlrqJaxcSod7bXXnFB4ZHRTHQOx+w87pE0/M7p0I+K4mfYknwJkehAGqx3OQqkhbT3QKv1o3JPn+hrXjUN/PV0Vqjw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8Z0-0008Ce-0N; Mon, 30 Jul 2018 15:50:18 +0200
Date:   Mon, 30 Jul 2018 15:50:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 10/10] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
Message-ID: <20180730135018.GF13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <0ce1b3e8466064741dc6e484f87bbe48542cb978.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce1b3e8466064741dc6e484f87bbe48542cb978.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65255
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

 On Mon, Jul 30, 2018 at 02:43:55PM +0200, Quentin Schulz wrote:

> +		err = of_get_phy_mode(portnp);
> +		if (err < 0)
> +			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
> +		else
> +			ocelot->ports[port]->phy_mode = err;
> +
> +		if (ocelot->ports[port]->phy_mode == PHY_INTERFACE_MODE_NA)
> +			continue;
> +
> +		if (ocelot->ports[port]->phy_mode == PHY_INTERFACE_MODE_SGMII)
> +			phy_mode = PHY_MODE_SGMII;
> +		else
> +			phy_mode = PHY_MODE_QSGMII;

Hi Quentin

Say somebody puts RGMII as the phy-mode? It would be better to verify
it is only SGMII or QSGMII and return -EINVAL otherwise.

> +
> +		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
> +		if (IS_ERR(serdes)) {
> +			if (PTR_ERR(serdes) == -EPROBE_DEFER) {
> +				dev_err(ocelot->dev, "deferring probe\n");

dev_dbg() ? It is not really an error.

> +				err = -EPROBE_DEFER;
> +				goto err_probe_ports;
> +			}
> +
> +			dev_err(ocelot->dev, "missing SerDes phys for port%d\n",
> +				port);
> +			err = -ENODEV;

err = PTR_ERR(serdes) so we get the actual error?

>  			goto err_probe_ports;
>  		}
> +
> +		ocelot->ports[port]->serdes = serdes;
>  	}
>  
>  	register_netdevice_notifier(&ocelot_netdevice_nb);


	Andrew
