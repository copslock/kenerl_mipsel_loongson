Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 16:57:45 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:52183 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990413AbeC2O5iuC-ve (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Mar 2018 16:57:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=A3/uTG1k6ebcD8ccz85HW4AnnJ3j6oKf0o0i8kV3x98=;
        b=p1fpRtOXvFseM7MV5jJXk/gHNDma45xERXh0N46SQTzEp/Uv5a5AstlFAI1RjT77w4eJTYYs+LhrQgBt5oRZDND1NN7L1wW7j0vGBsCdcl8Gph4AiWmgjQswFnacBDFBG+F0LcObHW20S2rUBJr5zicTUKB/Rm5o/DveVN/X+EQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1f1YzX-0002Gm-VO; Thu, 29 Mar 2018 16:57:27 +0200
Date:   Thu, 29 Mar 2018 16:57:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329145727.GB25752@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <20180323204939.GS24361@lunn.ch>
 <20180329140544.GB12066@piout.net>
 <20180329144041.GA25752@lunn.ch>
 <20180329145352.GD12066@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329145352.GD12066@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63337
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

> > It sounds like the correct fix is for get_phy_id() to look at the
> > error code for mdiobus_read(bus, addr, MII_PHYSID1). If it is EIO and
> > maybe ENODEV, set *phy_id to 0xffffffff and return. The scan code
> > should then do the correct thing.
> > 
> 
> That could work indeed. Do you want me to test and send a patch?

Yes please.

Thanks
	Andrew
