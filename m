Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 23:35:21 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:48139 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994626AbeDZVfPA5Two (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Apr 2018 23:35:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=YzGa9yr7a4UO4of5iMC6Y75ZnlIn/8IX4YS/miqAnaY=;
        b=MeOyoVuEfQTjNbsbLJLgixqlI6W+OkfSM7DDmY32ADYqqcWjnGe82BhxHh7KX5hcdM5wHuTRGzRd3XkZhwo9bQ+N20seADIQJqHRwV4BM0Xenslbu9aNHrpoMV3t8b2mtT+XzqmME0TRbicuugchgW0Y2KRocoEpO7oLrVF2510=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fBo8h-0007DS-3e; Thu, 26 Apr 2018 23:09:15 +0200
Date:   Thu, 26 Apr 2018 23:09:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 4/7] net: mscc: Add initial Ocelot switch
 support
Message-ID: <20180426210915.GE23481@lunn.ch>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63809
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

> +/* Checks if the net_device instance given to us originate from our driver. */
> +static bool ocelot_netdevice_dev_check(const struct net_device *dev)
> +{
> +	return dev->netdev_ops == &ocelot_port_netdev_ops;
> +}

This is probably O.K. now, but when you add support for controlling
the switch over PCIe, i think it breaks. A board could have two
switches...

It might be possible to do something with dev->parent. All ports of a
switch should have the same parent.

       Andrew
