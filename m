Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2018 09:41:13 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:51632 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeD0HlGP5Den (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2018 09:41:06 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3E2302070D; Fri, 27 Apr 2018 09:40:59 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 158712036F;
        Fri, 27 Apr 2018 09:40:59 +0200 (CEST)
Date:   Fri, 27 Apr 2018 09:40:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] MIPS: mscc: Add switch to ocelot
Message-ID: <20180427074058.GW4813@piout.net>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-6-alexandre.belloni@bootlin.com>
 <20180426205113.GD23481@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426205113.GD23481@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63811
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

On 26/04/2018 22:51:13+0200, Andrew Lunn wrote:
> > +
> > +		mdio0: mdio@107009c {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			compatible = "mscc,ocelot-miim";
> > +			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
> > +			interrupts = <14>;
> > +			status = "disabled";
> > +
> > +			phy0: ethernet-phy@0 {
> > +				reg = <0>;
> > +			};
> > +			phy1: ethernet-phy@1 {
> > +				reg = <1>;
> > +			};
> > +			phy2: ethernet-phy@2 {
> > +				reg = <2>;
> > +			};
> > +			phy3: ethernet-phy@3 {
> > +				reg = <3>;
> > +			};
> 
> Hi Alexandre
> 
> These are internal PHYs? Is there an option to use external PHYs for
> the ports which have internal PHYs?
> 
> I'm just wondering if they should be linked together by default. Or a
> comment added to the commit message about why they are not linked
> together here.
> 

They are dual media ports so they are not necessarily using the
integrated PHY but can use SerDEs1G lanes.

I'll add that to the commit message.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
