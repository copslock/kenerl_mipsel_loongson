Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 13:47:28 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:47185 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993310AbdKBMrUjS7lN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 13:47:20 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAEtz-0006t5-Ln; Thu, 02 Nov 2017 13:47:19 +0100
Date:   Thu, 2 Nov 2017 13:47:19 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
Message-ID: <20171102124719.GG4772@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-2-david.daney@cavium.com>
 <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0de889-a34b-8346-9eeb-171498cc61ca@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60673
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

On Wed, Nov 01, 2017 at 06:09:17PM -0700, Florian Fainelli wrote:
> On 11/01/2017 05:36 PM, David Daney wrote:
> > From: Carlos Munoz <cmunoz@cavium.com>
> > 
> > Add bindings for Common Ethernet Interface (BGX) block.
> > 
> > Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> > Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > ---
> [snip]
> > +Properties:
> > +
> > +- compatible: "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs.
> > +
> > +- reg: The index of the interface within the BGX block.
> > +
> > +- local-mac-address: Mac address for the interface.
> > +
> > +- phy-handle: phandle to the phy node connected to the interface.
> > +
> > +- cavium,rx-clk-delay-bypass: Set to <1> to bypass the rx clock delay setting.
> > +  Needed by the Micrel PHY.
> 
> Is not that implied by an appropriate "phy-mode" property already?

Hi Florian

Looking at the driver patch, phy-mode is not used at
all. of_phy_connect() passes a hard coded SGMII value!

David, you need to fix this.

       Andrew
