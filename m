Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 16:32:25 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:58681 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993890AbeHAOcWI7waK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2018 16:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=HZVHIcGBbO59f7jeBPx4lFsq7RRBofTJ/CSi1I5TcGk=;
        b=hUdWdB0VXUGyE60C42ZwW+GFf/ov+RNxzunrAnzZdDw1IZOVGUeAlGDngswWgIoiMyo7PJcZtUKLVz4EzRnkY+DTEWVH/lw25rgCHre4LgOzfcm46tO8U0WSil3ieYHTa1gJLcyW3GGBlBbvhpPf3uU8ZSa9snkrkL8XQrpa8pE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fksAF-0004PV-Hs; Wed, 01 Aug 2018 16:31:47 +0200
Date:   Wed, 1 Aug 2018 16:31:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180801143147.GA16322@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <20180730133448.GD13198@lunn.ch>
 <20180801082413.2mjm52vwxw3anun6@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801082413.2mjm52vwxw3anun6@qschulz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65347
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

> > Maybe this should be serdes-mux? The SERDES itself should have some
> > registers somewhere. If you ever decide to make use of phylink,
> > e.g. to support SFP, you are going to need to know if the SERDES is
> > up. So you might need to add the actual SERDES device, in addition to
> > the mux for the SERDES.
> > 
> 
> I'm not sure to follow.
> 
> To be honest, I might have mislead you. The whole configuration of the
> serdes is in the hsio register address space. For now, muxing is the
> only reason there is a driver for the serdes but there are other things
> that can be configured (though not used yet): de/serializer, input/output
> buffers, PLL, ... configuration registers for the SerDes.

When you are using the SERDES for networking, you need to know if the
SERDES has achieved sync. For example, when the SERDES connects to an
optical SFP module, the SERDES bit stream continues unmodified over
the optical link to the SERDES in the peer. The optical module can
tell you if it is receiving optical power, but it cannot tell you if
the optical signal makes any sense. The SERDES however knows how to
decode the bitstream, sync to it, etc. So you need some registers in
the SERDES to get this status information. Typically, you can also get
access to the SGMII/1000Base-X code word, so you can do
auto-negotiation, or know if you need to send each bit 10 or 100 times
in order to do 100Mbps or 10Mbps. If you are connecting to a PHY which
can do > 1Gbps, you need to change the SERDES between SGMII,
1000Base-X, 2500Base-X, etc. Before you can say the link is up, you
want the PHY to tell you it has link to its peer PHY, and you want to
know the SERDES is ready. Typically the SERDES is last, since you
don't know what to configure the SERDES to until the PHY is finished
negotiating the link to its peer.

If you look at any of the Marvell SERDES interfaces, found in PHYs or
switches, there are dozens of registers for controlling the SERDES.

Now, it could be we don't have a clear definition of what a SERDES
is. The Marvell documents has a lot in its definition of SERDES, where
as what you could be purely a 'dumb' parallel to serial convert, and
all the rest of the logic is in the Ethernet MAC and the PCIe device?

Now, back to my original point. Where are the registers for 'the rest
of this logic'? If they are in the MAC address space, we don't have a
problem. If they are somewhere else, maybe you will need to add
another device. What is this device called? That is why i'm trying to
differentiate between the 'SERDES-MUX' and the 'SERDES'.

	Andrew
