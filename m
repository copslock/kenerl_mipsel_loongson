Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 18:49:56 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55451 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbeG2QtuvJcZk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 18:49:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kfATHFcVeVZaxvE2JmPLACXyJtPUKRQqU5kT/+E5Dj0=;
        b=cqIldArPoxQrJVsF6UMT5fQFD7dF9WMRIL3OHmmimdS7HscN9MG7WNafmacZSrGLii+uhuTN/2ZT5nyTD+sEKYTxCKAID/gZYNQ4yFja7eHGmGtikAWaCLkF8OVGt/hWFxDvUMLcGjktPvTvldwhYiDIZXwJUv5izNDbdd+av2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fjot2-0003pf-AL; Sun, 29 Jul 2018 18:49:40 +0200
Date:   Sun, 29 Jul 2018 18:49:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
Message-ID: <20180729164940.GB14420@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-5-hauke@hauke-m.de>
 <20180725161219.GC16819@lunn.ch>
 <df047f7a-de85-372a-7bce-1f78839f98fe@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df047f7a-de85-372a-7bce-1f78839f98fe@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65232
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

> >> +static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
> >> +	/** Receive Packet Count (only packets that are accepted and not discarded). */
> >> +	MIB_DESC(1, 0x1F, "RxGoodPkts"),
> >> +	/** Receive Size 1024-1522 (or more, if configured) Packet Count. */
> >> +	MIB_DESC(1, 0x17, "RxMaxBytePkts"),
> >> +	/** Transmit Size 1024-1522 (or more, if configured) Packet Count. */
> >> +	MIB_DESC(1, 0x05, "TxMaxBytePkts"),
> > 
> > Most of the comments here don't add anything useful. Maybe remove
> > them?
> 
> Ok I removed them.

The comments i left above are useful, since they give additional
information which is not obvious from the name.

> Are the names ok, or should they follow any Linux definition?

There are no standard names. So each driver tends to be different.

> > Please return ETIMEOUT when needed. Maybe use one of the variants of
> > readx_poll_timeout().
> 
> I am returning ETIMEOUT now.
> 
> When I would use readx_poll_timeout() I can not use the gswip_mdio_r()
> function, because it takes two arguments and would have to use readl
> directly.

Yes, they don't always fit, which is why is said "maybe".

> > The names make this unclear. The callback is used to configure the MAC
> > layer when something happens at the PHY layer. phyaddr does not appear
> > to be an address, not should it be doing anything to a PHY.
> 
> I renamed this to phyconf, as this contains multiple configuration
> values. This tells the mac what settings the phy wants to use.

macconf might be better, since this is configuring the MAC, not the
PHY.

> This is sort of a firmware, but it is also in the GPL driver.
> Currently the probe function is not marked __init so we can not make
> this easily __initdata.
> It has 64 entries of 8 bytes each so, 512 bytes, I think we can put this
> into the code.

512 bytes is fine.

    Andrew
