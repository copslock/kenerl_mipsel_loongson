Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 23:07:17 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46528 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeCWWHKqCMQS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 23:07:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7fjPL5ILCoZDxc+Y8tHT7qz1xAWXbUYQUWYXeykWccM=;
        b=UBV/usXsN/5Nsm5+aEEfRBcHSBr3e0ME/a9DdN81zhlewgrnyTVUPq/EXk10tL0VCjTUzc8JTFbKflpr8W54eY94vK8Ghnq6eAp3smB8UUKUjmJt5HYX92MzC0tlbxsqWvgqWb5kvZBIV57+KQz2JYKakHrFBASqllhnN/tfAM0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ezUpt-00062o-AB; Fri, 23 Mar 2018 23:06:57 +0100
Date:   Fri, 23 Mar 2018 23:06:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
Message-ID: <20180323220657.GY24361@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net>
 <20180323213344.GV24361@lunn.ch>
 <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63205
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

> > That is the trade off of having a standalone MDIO bus driver.  Maybe
> > add a phandle to the internal MDIO bus? The switch driver could then
> > follow the phandle, and direct connect the internal PHYs?
> 
> This is more or less what patch 7 does, right?

Patch 7 does it in DT. I'm suggesting it could be done in C. It is
hard wired, so there is no need to describe it in DT. Use the phandle
to get the mdio bus, mdiobus_get_phy(, port) to get the phydev and
then use phy_connect().

     Andrew
