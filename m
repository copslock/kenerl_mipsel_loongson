Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 15:40:59 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:37155 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028345AbcEPNk5jxS0n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2016 15:40:57 +0200
Received: from andrew by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1b2IlG-0007nT-Ec; Mon, 16 May 2016 15:40:42 +0200
Date:   Mon, 16 May 2016 15:40:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rabin Vincent <rabin@rab.in>
Cc:     Rabin Vincent <rabin.vincent@axis.com>,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
Message-ID: <20160516134042.GD27725@lunn.ch>
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
 <20160516122903.GA27725@lunn.ch>
 <20160516131134.GA31094@lnxartpec.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160516131134.GA31094@lnxartpec.se.axis.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53459
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

On Mon, May 16, 2016 at 03:11:35PM +0200, Rabin Vincent wrote:
> On Mon, May 16, 2016 at 02:29:03PM +0200, Andrew Lunn wrote:
> > What i think is better is to make fixed_phy_add() return -EPROBE_DEFER
> > if it is called before fixed_mdio_bus_init().
> 
> I don't see how this will work for platforms such as ar7 and bcm47xx
> which call fixed_phy_add() from platform code.

Ah! Not good.

fixed_phy_add() is the lower layer call. What we can do is only access
fmb->mii_bus->irq[phy_addr] if irq != PHY_POLL. That should make ar7
and bcm47xx work again.

The higher level function fixed_phy_register() should return
-EPROBE_DEFER if fixed_mdio_bus_init() has not been called yet.

Thanks
	Andrew
