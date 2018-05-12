Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 12:35:37 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35339 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992492AbeENKfQYSIUx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 12:35:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=zsSm1JljQrYrgVoRgJ4+q3N8p3ioHjNx21qSNxHNN4I=;
        b=1t0NUhVNujOxReerfBbQqBPCj36j5iIJJGPP9xsqyacTwmy4bRqhZj6euDI1z4OINZ9ZdnIXVbv1TisYRYA65QuXpfUpTWTuam0Z2NSQiqVqCHzS/z82gmgzfvN3m2jbqdTjziBEulTJWNi1kajLLpR//y74m7GZ5L8DlNvqa8U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fHcCL-0007x8-SZ; Sat, 12 May 2018 23:37:01 +0200
Date:   Sat, 12 May 2018 23:37:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Darren Hart <dvhart@linux.intel.com>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 1/6] net: phy: at803x: Export at803x_debug_reg_mask()
Message-ID: <20180512213701.GA30364@lunn.ch>
References: <20180510231657.28503-1-paul.burton@mips.com>
 <20180510231657.28503-2-paul.burton@mips.com>
 <20180511002619.GD5527@lunn.ch>
 <20180511182502.y74wm6dmtf3dbcln@pburton-laptop>
 <20180511192446.GD12738@lunn.ch>
 <20180511222239.aznt4ngtnrbnvshf@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511222239.aznt4ngtnrbnvshf@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63926
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

On Fri, May 11, 2018 at 03:22:39PM -0700, Paul Burton wrote:
> Hi Andrew,
> 
> On Fri, May 11, 2018 at 09:24:46PM +0200, Andrew Lunn wrote:
> > > I could reorder the probe function a little to initialize the PHY before
> > > performing the MAC reset, drop this patch and the AR803X hibernation
> > > stuff from patch 2 if you like. But again, I can't actually test the
> > > result on the affected hardware.
> > 
> > Hi Paul
> > 
> > I don't like a MAC driver poking around in PHY registers.
> > 
> > So if you can rearrange the code, that would be great.
> > 
> >    Thanks
> > 	Andrew
> 
> Sure, I'll give it a shot.
> 
> After digging into it I see 2 ways to go here:
> 
>   1) We could just always reset the PHY before we reset the MAC. That
>      would give us a window of however long the PHY takes to enter its
>      low power state & stop providing the RX clock during which we'd
>      need the MAC reset to complete. In the case of the AR8031 that's
>      "about 10 seconds" according to its data sheet. In this particular
>      case that feels like plenty, but it does also feel a bit icky to
>      rely on the timing chosen by the PHY manufacturer to line up with
>      that of the MAC reset.
> 
>   2) We could introduce a couple of new phy_* functions to disable &
>      enable low power states like the AR8031's hibernation feature, by
>      calling new function pointers in struct phy_driver. Then pch_gbe &
>      other MACs could call those to have the PHY driver disable
>      hibernation at times where we know we'll need the RX clock and
>      re-enable it afterwards.

Hi Paul

When there is no link, you don't need the MAC running. My assumption
is that the PHY is designed around that idea, you leave the MAC idle
until there is a link. When the phylib calls the link_change handler,
the MAC should then be started/stopped depending on the state of the
link. You are then guaranteed to have the clock when you need it.

I've no idea how easy this is to implement given the current code...

     Andrew
