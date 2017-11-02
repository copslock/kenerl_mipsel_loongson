Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 17:10:31 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:47700 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993373AbdKBQKUIgYFt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 17:10:20 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAI4O-0000Wc-P3; Thu, 02 Nov 2017 17:10:16 +0100
Date:   Thu, 2 Nov 2017 17:10:16 +0100
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
Message-ID: <20171102161016.GH24320@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
 <20171102124339.GF4772@lunn.ch>
 <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521d6b21-b7f0-66e0-4b49-cf95d83452d1@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60681
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

On Thu, Nov 02, 2017 at 08:55:33AM -0700, David Daney wrote:
> On 11/02/2017 05:43 AM, Andrew Lunn wrote:
> [...]
> >>+
> >>+		i = atomic_inc_return(&pki_id);
> >>+		pki_dev = platform_device_register_data(&new_dev->dev,
> >>+							is_mix ? "octeon_mgmt" : "ethernet-mac-pki",
> >>+							i, &platform_data, sizeof(platform_data));
> >>+		dev_info(&pdev->dev, "Created %s %u: %p\n",
> >>+			 is_mix ? "MIX" : "PKI", pki_dev->id, pki_dev);
> >
> >Is there any change of these ethernet ports being used to connect to
> >an Ethernet switch. We have had issues in the past with these sort of
> >platform devices combined with DSA.
> >
> 
> There are only two possibilities.  The BGX MACs have a multiplexer that
> allows them to be connected to either the "octeon_mgmt" MIX packet
> processor, or to the "ethernet-mac-pki" PKI/PKO packet processor.  The SoCs
> supported by these drivers do not contain any hardware that would be
> considered an "Ethernet switch".

Hi David

I was thinking of an external Ethernet switch. You generally connect
via RGMII to a port of the switch.

http://elixir.free-electrons.com/linux/v4.9.60/source/Documentation/networking/dsa/dsa.txt

	Andrew
