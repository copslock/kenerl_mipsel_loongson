Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 18:19:48 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:56406 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992336AbeC1QTlW4f7X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Mar 2018 18:19:41 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0EBF206F3; Wed, 28 Mar 2018 18:19:04 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7723620146;
        Wed, 28 Mar 2018 18:18:54 +0200 (CEST)
Date:   Wed, 28 Mar 2018 18:18:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
Message-ID: <20180328161855.GJ13942@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
 <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63291
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

On 23/03/2018 at 14:08:10 -0700, Florian Fainelli wrote:
> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> > Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> > functions but more features are available.
> > 
> > Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/net/phy/mscc.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> > index 650c2667d523..e1ab3acd1cdb 100644
> > --- a/drivers/net/phy/mscc.c
> > +++ b/drivers/net/phy/mscc.c
> > @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
> >  #define SECURE_ON_PASSWD_LEN_4		  0x4000
> >  
> >  /* Microsemi PHY ID's */
> > +#define PHY_ID_OCELOT			  0x00070540
> >  #define PHY_ID_VSC8530			  0x00070560
> >  #define PHY_ID_VSC8531			  0x00070570
> >  #define PHY_ID_VSC8540			  0x00070760
> > @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
> >  
> >  /* Microsemi VSC85xx PHYs */
> >  static struct phy_driver vsc85xx_driver[] = {
> > +{
> > +	.phy_id		= PHY_ID_OCELOT,
> > +	.name		= "Microsemi OCELOT",
> > +	.phy_id_mask    = 0xfffffff0,
> > +	.features	= PHY_GBIT_FEATURES,
> > +	.soft_reset	= &genphy_soft_reset,
> > +	.config_init	= &genphy_config_init,
> > +	.config_aneg	= &genphy_config_aneg,
> > +	.aneg_done	= &genphy_aneg_done,
> > +	.read_status	= &genphy_read_status,
> > +	.suspend	= &genphy_suspend,
> > +	.resume		= &genphy_resume,
> 
> With the exception of config_init(), suspend and resume, everything else
> is already the default when you don't provide a callback. To echo to
> what Andrew wrote already, if the purpose is just to show a nice name,
> and do nothing else, consider using the Generic PHY driver (default).

Ok, I'll drop this patch for now, until we handle more features for that
PHY.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
