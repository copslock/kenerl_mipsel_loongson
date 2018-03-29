Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 16:14:32 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:53051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990405AbeC2OOZNkP2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Mar 2018 16:14:25 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3C1AB2083E; Thu, 29 Mar 2018 16:14:19 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id DED662037A;
        Thu, 29 Mar 2018 16:14:08 +0200 (CEST)
Date:   Thu, 29 Mar 2018 16:14:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329141408.GC12066@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <9547b11d-147d-5029-0abe-8bf0f705c959@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9547b11d-147d-5029-0abe-8bf0f705c959@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63333
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

On 23/03/2018 at 14:51:19 -0700, Florian Fainelli wrote:
> > +	writel(MSCC_MIIM_CMD_VLD | (mii_id << MSCC_MIIM_CMD_PHYAD_SHIFT) |
> > +	       (regnum << MSCC_MIIM_CMD_REGAD_SHIFT) | MSCC_MIIM_CMD_OPR_READ,
> > +	       miim->regs + MSCC_MIIM_REG_CMD);
> > +
> > +	ret = mscc_miim_wait_ready(bus);
> > +	if (ret)
> > +		goto out;
> 
> Your example had an interrupt specified, can't you use that instead of
> polling?
> 

the interrupt doesn't handle that. It is used to detect when a PHY
register has changed once the MIIM controller is configured to poll the
phys. At some point, this could be used to replace the PHY interrupts
but it doesn't correspond to the linux model so I didn't investigate too
much.

>  > +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> > +		if (mscc_miim_read(bus, i, MII_PHYSID1) < 0)
> > +			bus->phy_mask |= BIT(i);
> > +	}
> 
> What is this used for? You have an OF MDIO bus which would create a
> phy_device for each node specified, is this a similar workaround to what
> drivers/net/phy/mdio-bcm-unimac.c has to do? If so, please document it
> as such.
> 

I replied to Andrew who had the same question.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
