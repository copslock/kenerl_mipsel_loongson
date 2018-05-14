Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:50:23 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:36267 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992692AbeENUuEayDXZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:50:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=xG6eXewBXmSUZU/HSLbbyaUmOLg/5L93grIkCncix20=;
        b=bNccMZb8lJnP8MhQHt/7f3mJoPZonPcRPfS5uDPnN0ucEfO+ihb4ihZYD/yVpzLlJVdFOcCx00EZ3jmTBz03r+Gx80JQZMfYfJVMtj2NboHwpD0+iTpdNzoCXu0z7w14S6t1JkMfXB1/sn1ApdhI0pW+nVoHjyiJWm2pUPYy2YI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fIKPq-00025i-OA; Mon, 14 May 2018 22:49:54 +0200
Date:   Mon, 14 May 2018 22:49:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v3 5/7] MIPS: mscc: Add switch to ocelot
Message-ID: <20180514204954.GC1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-6-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-6-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63944
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

On Mon, May 14, 2018 at 10:04:58PM +0200, Alexandre Belloni wrote:
> Ocelot has an integrated switch, add support for it.
> 
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
