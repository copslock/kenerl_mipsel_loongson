Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:25:35 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46476 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990723AbeCWVZ2VHlaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 22:25:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Ug1UTu6P436xwLo/CQ0tRzEz1a170nAIwjatkf6FQDI=;
        b=m29iUAPjptb+D20YmeiUyczAL93MRm/eKcULbmbB9ASfcBvfX+vsEF4DnPOmkrgxJLWjcJfBT/5hR5uqskd+Im872MdWS2EI0AgZGifpY2bm+9DBqOVQJuq8as6Gx62HldkS0I7hffeGcyzWVRDYGgNgXWddQWm1vlSg8fn9RIs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ezUBY-0005ic-U8; Fri, 23 Mar 2018 22:25:16 +0100
Date:   Fri, 23 Mar 2018 22:25:16 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180323212516.GU24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63199
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

Hi Alexandre

> +static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
> +				   struct net_device *bridge)
> +{
> +	struct ocelot *ocelot = ocelot_port->ocelot;
> +
> +	if (!ocelot->bridge_mask) {
> +		ocelot->hw_bridge_dev = bridge;
> +	} else {
> +		if (ocelot->hw_bridge_dev != bridge)
> +			return -ENODEV; //TODO: do something clever here
> +	}
> +
> +	ocelot->bridge_mask |= BIT(ocelot_port->chip_port);
> +
> +	return 0;
> +}

I could be missing something here, but this looks way too simple.

By default, you have individual ports. They can just forward frames
between the host CPU and the port. There is no port-to-port traffic
allowed.

You then create a bridge, and add ports to the bridge. When you add a
port, you need to program the hardware that it can now forward frames
from this port to other parts in the same bridge. You also need to
tell other parts in the same bridge it can forward frames to it.  You
might also need to tell the port which forwarding database it should
use, since each bridge might have its own.

     Andrew
