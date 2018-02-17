Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 23:29:49 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35772 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992923AbeBQW3mqmVLS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Feb 2018 23:29:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=AoOhPH5KAGrBMEUNk6Dertfmp32UtL89w9WWi8jCmuk=;
        b=OMlKcs50fpUnjKLH54M6sP5v/2s+X4axgri03AbiVDYO687zF0Qaru8TPOKTVrVYO57XHdbUPbUjwGNF4w5NmgoQH9tyVx6X4r9JJ/FS/L2n7QkgoAseidZAqUqFQyjIUX7/stJssvO0de0a+CxcGwVM2Lo1dXy87v+obeB7abY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enAz7-0006B1-ST; Sat, 17 Feb 2018 23:29:33 +0100
Date:   Sat, 17 Feb 2018 23:29:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20180217222933.GB21315@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-3-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217201037.3006-3-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62600
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

On Sat, Feb 17, 2018 at 12:10:25PM -0800, Paul Burton wrote:
> The MIPS Boston development board uses the Intel EG20T Platform
> Controller Hub, including its gigabit ethernet controller, and requires
> that its RTL8211E PHY be reset much like the Minnow platform. Pull the
> PHY reset GPIO handling out of Minnow-specific code such that it can be
> shared by later patches.

Hi Paul

I'm i right in saying the driver currently supports the Atheros AT8031
PHY? The same phy which is supported in drivers/net/phy/at803x.c?

If so, i think you are doing this all wrong. You would be much better
off throwing away pch_gbe_phy.c and write a proper MDIO driver. You
then get the PHY driver for free, and the MDIO code could will handle
your GPIO for you, in the standardised way.

     Andrew
