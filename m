Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 19:28:10 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:40829 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994248AbeINR2HETWOa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 19:28:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7bMh67wq6ZF6SoYKaGfvchiuTDGJQZ+2CbQv/xU2+P8=;
        b=PvOt3lBv9XFLtANXE4rhLCke5PdeYqLxaPLCqlbR5jd6ZkhdPZmYtOGxJb973TczILWqxbt0BId4g3OmgiHebvllS//vVIBy5z0kp2RHKZ7oAbr5gk7pCAir0sm2n63F3haoDb3OIp3hAwiJ18JBVj1Oazh1S9AB9g34nTouy6o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0rso-0006E2-PS; Fri, 14 Sep 2018 19:27:54 +0200
Date:   Fri, 14 Sep 2018 19:27:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Message-ID: <20180914172754.GC3811@lunn.ch>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66304
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


>  struct vsc8531_private {
>  	int rate_magic;
>  	u16 supp_led_modes;
> @@ -181,6 +354,7 @@ struct vsc8531_private {
>  	struct vsc85xx_hw_stat *hw_stats;
>  	u64 *stats;
>  	int nstats;
> +	bool pkg_init;

> +/* bus->mdio_lock should be locked when using this function */
> +static int vsc8584_cmd(struct mii_bus *bus, int phy, u16 val)
> +{
> +	unsigned long deadline;
> +	u16 reg_val;
> +
> +	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
> +			MSCC_PHY_PAGE_EXTENDED_GPIO);
> +
> +	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NCOMPLETED | val);

Hi Quentin

All the __mdiobus_write() look a bit ugly. Maybe add bus and base_addr
to the vsc8531_private structure. Then add helpers
phy_write_base_phy(priv, reg, val) and phy_read_base_phy(priv, reg).

You could also add in:

        if (unlikely(!mutex_is_locked(&priv->bus->mdio_lock))) {
                dev_err(bus->dev, "MDIO bus lock not held!\n");
                dump_stack();
        }

Having such code in the mv88e6xxx driver has found a few bugs for me.

       Andrew
