Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 21:30:05 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46420 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990498AbeCWU3zD-c81 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 21:29:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=QjBUXQWrQWphotC9oTO1gve+8sOwiX+pw/2/x36COWA=;
        b=NFBex6Gqp2fTxf5x3JGdIJCyPHdORlu3I8ls7gbwdCfmHwWHf/2NBHUJjTS8aIlFii/rFx4PKx3tHJKa0L8aqzECVKPh6z/v6Wm7Q9hTXbdGMI99WtJNjAUFsbE0WCa2W9gtrkkVQfg870mX22C4VWkOOsuwU+gbUgY3cUnbGAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ezTJm-0005Pl-Bi; Fri, 23 Mar 2018 21:29:42 +0100
Date:   Fri, 23 Mar 2018 21:29:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
Message-ID: <20180323202942.GR24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63189
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

On Fri, Mar 23, 2018 at 09:11:10PM +0100, Alexandre Belloni wrote:
> Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> functions but more features are available.
> 
> Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/phy/mscc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..e1ab3acd1cdb 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
>  #define SECURE_ON_PASSWD_LEN_4		  0x4000
>  
>  /* Microsemi PHY ID's */
> +#define PHY_ID_OCELOT			  0x00070540
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
>  #define PHY_ID_VSC8540			  0x00070760
> @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  
>  /* Microsemi VSC85xx PHYs */
>  static struct phy_driver vsc85xx_driver[] = {
> +{
> +	.phy_id		= PHY_ID_OCELOT,
> +	.name		= "Microsemi OCELOT",
> +	.phy_id_mask    = 0xfffffff0,
> +	.features	= PHY_GBIT_FEATURES,

No interrupt support? In fact, the only advantage i see this brings
over the generic driver is that the name Microsemi OCELOT is printed.

     Andrew

> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init	= &genphy_config_init,
> +	.config_aneg	= &genphy_config_aneg,
> +	.aneg_done	= &genphy_aneg_done,
> +	.read_status	= &genphy_read_status,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,
> +},
