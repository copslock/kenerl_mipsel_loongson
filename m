Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:22:43 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:53384 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990723AbeCWVWg68mi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 22:22:36 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60E912082C; Fri, 23 Mar 2018 22:22:29 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 189FA20384;
        Fri, 23 Mar 2018 22:22:29 +0100 (CET)
Date:   Fri, 23 Mar 2018 22:22:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
Message-ID: <20180323212230.GA12808@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63198
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

On 23/03/2018 at 14:17:48 -0700, Florian Fainelli wrote:
> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
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
> These PHYs should be defined at the board DTS level.

Those are internal PHYs, present on the SoC, I doubt anyone will have
anything different while using the same SoC.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
