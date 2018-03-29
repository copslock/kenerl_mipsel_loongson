Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 16:06:06 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:52744 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990405AbeC2OF7rx4KM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Mar 2018 16:05:59 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 45AF620879; Thu, 29 Mar 2018 16:05:54 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 180712037A;
        Thu, 29 Mar 2018 16:05:44 +0200 (CEST)
Date:   Thu, 29 Mar 2018 16:05:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329140544.GB12066@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <20180323204939.GS24361@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323204939.GS24361@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 23/03/2018 at 21:49:39 +0100, Andrew Lunn wrote:
> On Fri, Mar 23, 2018 at 09:11:12PM +0100, Alexandre Belloni wrote:
> > Add a driver for the Microsemi MII Management controller (MIIM) found on
> > Microsemi SoCs.
> > On Ocelot, there are two controllers, one is connected to the internal
> > PHYs, the other one can communicate with external PHYs.
> 
> Hi Alexandre
> 
> This looks to be standalone. Such drivers we try to put in
> drivers/net/phy.
> 
> > +static int mscc_miim_read(struct mii_bus *bus, int mii_id, int regnum)
> > +{
> > +	struct mscc_miim_dev *miim = bus->priv;
> > +	u32 val;
> > +	int ret;
> > +
> > +	mutex_lock(&miim->lock);
> 
> What are you locking against here?
> 
> And you don't appear to initialize the mutex anywhere.
> 
> > +static int mscc_miim_reset(struct mii_bus *bus)
> > +{
> > +	struct mscc_miim_dev *miim = bus->priv;
> > +	int i;
> > +
> > +	if (miim->phy_regs) {
> > +		writel(0, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> > +		writel(0x1ff, miim->phy_regs + MSCC_PHY_REG_PHY_CFG);
> > +		mdelay(500);
> > +	}
> > +
> > +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> > +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> > +			bus->phy_mask |= BIT(i);
> > +	}
> 
> Why do this? Especially so for the external bus, where the PHYs might
> have a GPIO reset line, and won't respond until the gpio is
> released. The core code does that just before it scans the bus, or
> just before it scans the particular address on the bus, depending on
> the scope of the GPIO.
> 

IIRC, this was needed when probing the bus without DT, in that case, the
mdiobus_scan loop of __mdiobus_register() will fail when doing the
get_phy_id for phys 0 to 31 because get_phy_id() transforms any error in
-EIO and so it is impossible to register the bus. Other drivers have a
similar code to handle that case.

Anyway, I'll remove that loop for now because I'm only supporting DT.
I'll get back to that later.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
