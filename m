Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 23:16:54 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:46763 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990482AbdK2WQrFe3W8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 23:16:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=BQcQeK5QnYCeW/bD2164bDlk1yrFKUFz2IS5iXfqO/Y=;
        b=qBuXRryuz7+cpM88Cc+Kr97jXFvlyiGyn5TNUTEJWaZU1VgC4gcLrHm52uel8MqLESsJiOzXqHIccHslnpdtDfZv7dFC+CPzb/U44dJMMxGz4INam649w6pFOQ22A4xB3/AEnlcgYd8I1Dfnd8tsp3bsMs43+AQ5zI6bhFqZ+zA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eKAed-0001ln-4W; Wed, 29 Nov 2017 23:16:31 +0100
Date:   Wed, 29 Nov 2017 23:16:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, Carlos Munoz <cmunoz@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171129221631.GD1706@lunn.ch>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
 <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
 <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
 <20171129191138.ntlfw5fb4xacwyun@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129191138.ntlfw5fb4xacwyun@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61228
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

On Wed, Nov 29, 2017 at 10:11:38PM +0300, Dan Carpenter wrote:
> On Wed, Nov 29, 2017 at 09:37:15PM +0530, Souptick Joarder wrote:
> > >> +static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
> > >> +{
> > >> +       u64     data;
> > >> +       u64     prtx;
> > >> +       u64     miscx;
> > >> +       int     timeout;
> > >> +
> > 
> > >> +
> > >> +       switch (status.speed) {
> > >> +       case 10:
> > >
> > > In my opinion, instead of hard coding the value, is it fine to use ENUM ?
> >    Similar comments applicable in other places where hard coded values are used.
> > 
> 
> 10 means 10M right?  That's not really a magic number.  It's fine.

There are also :
uapi/linux/ethtool.h:#define SPEED_10		10
uapi/linux/ethtool.h:#define SPEED_100		100
uapi/linux/ethtool.h:#define SPEED_1000		1000
uapi/linux/ethtool.h:#define SPEED_10000	10000
uapi/linux/ethtool.h:#define SPEED_100000	100000

	     Andrew
