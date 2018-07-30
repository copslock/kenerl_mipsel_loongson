Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 15:25:04 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:56197 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993041AbeG3NZAqlv5D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 15:25:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2/jopxJ0a3Xr5McvI9/4v/db/6AbFZh4lrTEwV7FVGg=;
        b=yvK8Q5rxVzowFxnL1dw2048nnDehg+3tD7VczRCuI59j27Tsu3BQIFQiFzAYyhCmBt/fetQupTzPsXZkMpxPAKjUolm+O3BML9JZA5BB35eMDd8uUHX9X9fFaDWvHwgPqe+R1U8LYPws7ABaMzvFV8p93787ZuaJojPQYW3tEeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8AD-000810-Uk; Mon, 30 Jul 2018 15:24:41 +0200
Date:   Mon, 30 Jul 2018 15:24:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 00/10] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180730132441.GC13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65252
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

> The SerDes configuration is in the middle of an address space (HSIO) that
> is used to configure some parts in the MAC controller driver, that is why
> we need to use a syscon so that we can write to the same address space from
> different drivers safely using regmap.

Hi Quentin

I assume breaking backwards compatibility is not an issue here, since
there currently is only one board using the DT binding. But it would
be good to give a warning in the cover notes. git bisect will also
break for this one particular board. And since these changes are going
through different trees, it could be quite a big break.

	Andrew
