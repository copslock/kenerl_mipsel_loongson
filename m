Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 23:29:30 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:59640 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990506AbdKIW3VIBjh2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 23:29:21 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eCvK3-0006x5-ST; Thu, 09 Nov 2017 23:29:19 +0100
Date:   Thu, 9 Nov 2017 23:29:19 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v3 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171109222919.GB25275@lunn.ch>
References: <20171109192915.11912-1-david.daney@cavium.com>
 <20171109192915.11912-8-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109192915.11912-8-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60826
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

> +	if (link_changed != 0) {
> +		struct port_status status;
> +
> +		if (link_changed > 0) {
> +			netdev_info(netdev, "Link is up - %d/%s\n",
> +				    priv->phydev->speed,
> +				    priv->phydev->duplex == DUPLEX_FULL ?
> +				    "Full" : "Half");
> +		} else {
> +			netdev_info(netdev, "Link is down\n");
> +		}

phy_print_status()

	Andrew
