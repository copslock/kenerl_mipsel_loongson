Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 00:35:05 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35792 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeBQXe6tAD5y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Feb 2018 00:34:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=w7H8PiXL1tguc6lgQRY5MwOJAsdtWlJSo60n1YhBRAk=;
        b=v3k+5wf48LOFOlEeSjWoLu8RmbCKesqlSuq1iBWdzd58jlSCeWYmL4hNDXQBRD6VvVp6JbhZ0hW1AfRvnCdR47fS98mvIx44tFJ4J0UgFkZPh8QO09unpIpxek9hctYPmjXOupoo0QrP8m6rsE7/DojXYGdg6dGB0df5VmpvDiQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enC0A-0006NJ-6m; Sun, 18 Feb 2018 00:34:42 +0100
Date:   Sun, 18 Feb 2018 00:34:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20180217233442.GA24375@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-3-paul.burton@mips.com>
 <20180217222933.GB21315@lunn.ch>
 <20180217225022.x45ozstehuuunpp3@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217225022.x45ozstehuuunpp3@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62603
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

> Note that this is a driver which is already in mainline, and I didn't
> write it. Claiming that *I* am doing this all wrong is a bit of a
> stretch - all this patch does is make small changes to some existing
> code, which only tangentially relates to a PHY driver, such that it
> ceases to be specific to a single platform.

Hi Paul

I would so you are doing it all wrong for the reset GPIO.

> Even if that is true, rewriting the driver's PHY handling would be a
> very separate change to the changes this series make which allow this
> driver to work on a platform besides the Minnowboard. The *only* thing
> this series does relating to the PHY is allow the reset GPIO to be
> handled properly - rewriting the existing PHY handling is beyond it's
> scope.

Well, you are adding a device tree binding, which needs to be
supported forever. This is going to make things messy in the future
when you do such a cleanup that you follow the PHY binding, in that
you have to handle both what you add here, and the official PHY
binding.

I would prefer that for the moment, you drop the PHY binding patches
in this series. That is what i object to the most. Adding an MDIO
driver and using the standard PHY driver for this PHY is all
internal. You can change that anytime. But adding a binding means an
ABI.

	Andrew
