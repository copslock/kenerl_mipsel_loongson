Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 17:17:14 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:34617 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994542AbeIDPRJWdUqp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Sep 2018 17:17:09 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59D3E208AF; Tue,  4 Sep 2018 17:17:04 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3004C204AE;
        Tue,  4 Sep 2018 17:16:54 +0200 (CEST)
Date:   Tue, 4 Sep 2018 17:16:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     andrew@lunn.ch, quentin.schulz@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180904151653.GI13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903.220910.899357653888940454.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65926
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

On 03/09/2018 22:09:10-0700, David Miller wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date: Mon, 3 Sep 2018 15:45:22 +0200
> 
> > On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
> >> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
> >> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
> >> 
> >> Hi Quentin
> >> 
> >> Are you expecting merge conflicts? If not, it might be simpler to gets
> >> ACKs from each maintainer, and then merge it though one tree.
> >> 
> > 
> > There are some other DT changes for this cycle so those should probably
> > go through MIPS.
> 
> No objection for this going through the MIPS tree, and from me:
> 

What I meant was that 1/11 and 8/11 should go through MIPS because of
the potential conflicts. The other patches can go through net-next as
that will make more sense. Maybe Quentin can split the series in two,
one for MIPS and one for net if that makes it easier for you to apply.

> Acked-by: David S. Miller <davem@davemloft.net>

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
