Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2018 15:44:13 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:36229 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeD0NoHLIYmV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2018 15:44:07 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5200B20720; Fri, 27 Apr 2018 15:44:01 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 28CC9206A0;
        Fri, 27 Apr 2018 15:44:01 +0200 (CEST)
Date:   Fri, 27 Apr 2018 15:44:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 4/7] net: mscc: Add initial Ocelot switch
 support
Message-ID: <20180427134400.GA4813@piout.net>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-5-alexandre.belloni@bootlin.com>
 <20180426210915.GE23481@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426210915.GE23481@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63812
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

On 26/04/2018 23:09:15+0200, Andrew Lunn wrote:
> > +/* Checks if the net_device instance given to us originate from our driver. */
> > +static bool ocelot_netdevice_dev_check(const struct net_device *dev)
> > +{
> > +	return dev->netdev_ops == &ocelot_port_netdev_ops;
> > +}
> 
> This is probably O.K. now, but when you add support for controlling
> the switch over PCIe, i think it breaks. A board could have two
> switches...
> 
> It might be possible to do something with dev->parent. All ports of a
> switch should have the same parent.
> 

Actually, that is fine because it simply ensures netdev_priv(dev); is a
struct ocelot_port.

Later on, we get ocelot_port->ocelot and do the right thing.

The only thing that would not be working when having multiple of those
switches on the same platform would be having interfaces from different
switches in the same bridge. Anyway, this is definitively not something
we want because of the limited bandwidth of the CPU port.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
