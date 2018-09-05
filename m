Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:08:11 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:57589 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994565AbeIEJIGTjA6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 11:08:06 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4689520737; Wed,  5 Sep 2018 11:08:01 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19B6A20618;
        Wed,  5 Sep 2018 11:07:51 +0200 (CEST)
Date:   Wed, 5 Sep 2018 11:07:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        David Miller <davem@davemloft.net>, andrew@lunn.ch,
        ralf@linux-mips.org, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180905090750.GM13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
 <20180904151653.GI13888@piout.net>
 <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
 <20180904180006.d5th3jrbhr4vtahi@qschulz>
 <20180904230351.vwlq2s7joulvqw2i@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904230351.vwlq2s7joulvqw2i@pburton-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65937
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

On 04/09/2018 16:03:51-0700, Paul Burton wrote:
> Well, it sounded like David is OK with this all going through the MIPS
> tree, though we'd need an ack for the PHY parts.
> 
> Alternatively I'd be happy for the DT changes to go through the net-next
> tree, which may make more sense given that the .dts changes are pretty
> trivial in comparison with the driver changes. If David wants to do that
> then for patches 1 & 8:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 
> Either way there may be conflicts for ocelot.dtsi when it comes to
> merging to master, but they should be simple to resolve. It seems
> Wolfram already took your DT changes for I2C so there's probably going
> to be multiple trees updating that file this cycle already anyway.
> 

Actually, I think Wolfram meant that he took the bindings so you can
take the DT patches for i2c.

> Ideally I'd say "don't break bisection" but that's sort of a separate
> issue here since even if you restructure your series to do that it would
> still need to go through one tree. For example you could adjust
> mscc_ocelot_probe() to handle either the reg property or the syscon,
> then adjust the DT to use the syscon, then remove the code dealing with
> the reg property, and I'd consider that a good idea anyway but it would
> still probably all need to go through one tree to make sure things get
> merged in the right order & avoid breaking bisection.
> 

I don't really think bisection is important at this stage but if you
don't want to break it, then I guess it makes more sense to have the
whole series through net.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
