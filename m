Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:56:38 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:47834 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbdKBQ4bqOL6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:56:31 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAImj-0000zN-SC; Thu, 02 Nov 2017 17:56:05 +0100
Date:   Thu, 2 Nov 2017 17:56:05 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171102165605.GJ24320@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
 <20171102124339.GF4772@lunn.ch>
 <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
 <20171102161016.GH24320@lunn.ch>
 <0f39046d-dc99-5c05-d918-10952cd20e1b@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f39046d-dc99-5c05-d918-10952cd20e1b@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60691
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

> OK, now I think I understand.  Yes, the MAC can be hardwired to a switch.
> In fact, there are system designs that do exactly that.
> 
> We try to handle this case by not having a "phy-handle" property in the
> device tree.  The link to the remote device (switch IC in this case) is
> brought up on ndo_open()

O.K, so you totally ignore the Linux way of doing this and hack
together your own proprietary solution.
 
> There may be opportunities to improve how this works in the future, but the
> current code is serviceable.

It might be serviceable, but it will never get into mainline. For
mainline, you need to use DSA.

http://elixir.free-electrons.com/linux/v4.9.60/source/Documentation/networking/dsa/dsa.txt

Getting back to my original point, having these platform devices can
cause issues for DSA. Freescale FMAN has a similar architecture, and
it took a while to restructure it to make DSA work.

https://www.spinics.net/lists/netdev/msg459394.html

	Andrew
