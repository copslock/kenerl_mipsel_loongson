Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 21:49:58 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46436 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeCWUtvJ5Kz1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 21:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=RPsIrAEotpf9xjF3aS2UuAY3gdkwYBdfQkCDHKyCPQY=;
        b=Du9Vj9edP9et1KjKUKMvKQ/XN8yeZaXueRY27l0kyYJb36bzVgkc21aELbAmAyI04ghNsoFoMpMa7dMlyvZ0uiYmgLN6IJqgDsbGSRQHn5fhM5FLGgLw6rWf2ypmAYL4A0FJdaCFY45qvK7ATSOon5gNP3AfGGHy/+obDcfU2e0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ezTd5-0005V2-K8; Fri, 23 Mar 2018 21:49:39 +0100
Date:   Fri, 23 Mar 2018 21:49:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180323204939.GS24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-4-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63190
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

On Fri, Mar 23, 2018 at 09:11:12PM +0100, Alexandre Belloni wrote:
> Add a driver for the Microsemi MII Management controller (MIIM) found on
> Microsemi SoCs.
> On Ocelot, there are two controllers, one is connected to the internal
> PHYs, the other one can communicate with external PHYs.

Hi Alexandre

This looks to be standalone. Such drivers we try to put in
drivers/net/phy.

> +static int mscc_miim_read(struct mii_bus *bus, int mii_id, int regnum)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(&miim->lock);

What are you locking against here?

And you don't appear to initialize the mutex anywhere.

> +static int mscc_miim_reset(struct mii_bus *bus)
> +{
> +	struct mscc_miim_dev *miim = bus->priv;
> +	int i;
> +
> +	if (miim->phy_regs) {
> +		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> +		mdelay(500);
> +	}
> +
> +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> +			bus->phy_mask |= BIT(i);
> +	}

Why do this? Especially so for the external bus, where the PHYs might
have a GPIO reset line, and won't respond until the gpio is
released. The core code does that just before it scans the bus, or
just before it scans the particular address on the bus, depending on
the scope of the GPIO.

Otherwise, pretty good :-)

	   Andrew
