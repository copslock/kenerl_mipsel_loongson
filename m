Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 14:29:14 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:37086 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029254AbcEPM3NWdCOK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2016 14:29:13 +0200
Received: from andrew by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1b2Hdv-0007Mg-Od; Mon, 16 May 2016 14:29:03 +0200
Date:   Mon, 16 May 2016 14:29:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rabin Vincent <rabin.vincent@axis.com>
Cc:     "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
Message-ID: <20160516122903.GA27725@lunn.ch>
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53457
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

On Mon, May 16, 2016 at 01:15:56PM +0200, Rabin Vincent wrote:
> From: Rabin Vincent <rabinv@axis.com>
> 
> Since e7f4dc3536a ("mdio: Move allocation of interrupts into core"),
> platforms which call fixed_phy_add() before fixed_mdio_bus_init() is
> called (for example, because the platform code and the fixed_phy driver
> use the same initcall level) crash in fixed_phy_add() since the
> ->mii_bus is not allocated.
> 
> Also since e7f4dc3536a, these interrupts are initalized to polling by
> default.  All callers of both fixed_phy_register() and fixed_phy_add()
> pass PHY_POLL for the irq argument, so we can fix these crashes by
> simply removing the irq parameter, since the default is correct for all
> users.

Hi Rabin

Thanks for the patch. However, this is more of a work around than a
fix. And it leaves one case still open for bad things to happen. Take
the call sequence:

	ret = of_phy_register_fixed_link(port_dn);
        if (ret) {
        	netdev_err(slave_dev, "failed to register fixed PHY: %d\n", ret);
                return ret;
  	}

	p->phy = of_phy_connect(slave_dev, phy_dn,
        			dsa_slave_adjust_link,
                                phy_flags,
                                p->phy_interface);
 
This is taken from net/dsa/slave.c

With your patch, of_phy_register_fixed_link() will be successful, but
the call to of_phy_connect() will fail, returning NULL, because the
mdio bus the phy is on has not yet been added to the bus.

What i think is better is to make fixed_phy_add() return -EPROBE_DEFER
if it is called before fixed_mdio_bus_init().

I also think it is a bad idea to remove the interrupt
parameter. fixed_phy can actually change it state, so maybe at some
point in the future, somebody will want an interrupt for this? We
should try to keep this phy emulation as similar to real phys as
possible, so lets keep the interrupt for the moment.

	Thanks
	  Andrew
