Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 14:47:07 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992891AbeHNMrECKnIg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 14:47:04 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C07C520799; Tue, 14 Aug 2018 14:46:56 +0200 (CEST)
Received: from localhost (unknown [37.169.111.59])
        by mail.bootlin.com (Postfix) with ESMTPSA id 562982072C;
        Tue, 14 Aug 2018 14:46:46 +0200 (CEST)
Date:   Tue, 14 Aug 2018 14:45:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180814124547.GL943@piout.net>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
 <20180801081539.gxkviv6rnpwzoyxb@qschulz>
 <20180813223748.GA20086@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813223748.GA20086@rob-hp-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65589
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

On 13/08/2018 16:37:48-0600, Rob Herring wrote:
> > I'm fine with a define for the second value (which is basically the enum
> > serdes_type I've defined at the beginning of the serdes driver) but I
> > don't see the point of defining the index of the SerDes. What would it
> > look like?
> > 
> > enum serdes_type {
> > 	SERDES1G = 1,
> > 	SERDES6G = 6,
> > }
> > 
> > #define SERDES1G_0	0
> > #define SERDES1G_1	1
> > #define SERDES1G_2	2
> > #define SERDES6G_0	0
> > #define SERDES6G_1	1
> > 
> > Then, e.g.:
> > 
> > &port5 {
> > 	phys = <&serdes 5 SERDES1G SERDES1G_0>
> > };
> > 
> > If you want a define for the pair (serdes_type, serdes_index), I don't
> > see how I could re-use it on the driver side but it makes more sense on the
> > DeviceTree side:
> > 
> > #define SERDES1G_0	1 0
> > #define SERDES1G_1	1 1
> > #define SERDES1G_2	1 2
> > #define SERDES6G_0	6 0
> > #define SERDES6G_1	6 1
> 
> I prefer #defines which are a single number. Otherwise if you read a dts 
> file when #phy-cells is 3, it will look like an error in that you have 
> what looks like 2 cells.
> 

Maybe we should not have the type in DT and simply have an index. The
driver will now what the serdes type is anyway and the defines would be:

#define SERDES1G_0  0
#define SERDES1G_1  1
#define SERDES1G_2  2
#define SERDES6G_0  3
#define SERDES6G_1  4

The main drawback is that this requires one include file per soc.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
