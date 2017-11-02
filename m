Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 13:23:39 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:47137 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbdKBMXcPsW0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 13:23:32 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAEWt-0006eZ-QD; Thu, 02 Nov 2017 13:23:27 +0100
Date:   Thu, 2 Nov 2017 13:23:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 3/7] MIPS: Octeon: Add a global resource manager.
Message-ID: <20171102122327.GE4772@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-4-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102003606.19913-4-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60671
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

> +static void res_mgr_lock(void)
> +{
> +	unsigned int tmp;
> +	u64 lock = (u64)&res_mgr_info->rlock;
> +
> +	__asm__ __volatile__(
> +		".set noreorder\n"
> +		"1: ll   %[tmp], 0(%[addr])\n"
> +		"   bnez %[tmp], 1b\n"
> +		"   li   %[tmp], 1\n"
> +		"   sc   %[tmp], 0(%[addr])\n"
> +		"   beqz %[tmp], 1b\n"
> +		"   nop\n"
> +		".set reorder\n" :
> +		[tmp] "=&r"(tmp) :
> +		[addr] "r"(lock) :
> +		"memory");
> +}
> +
> +static void res_mgr_unlock(void)
> +{
> +	u64 lock = (u64)&res_mgr_info->rlock;
> +
> +	/* Wait until all resource operations finish before unlocking. */
> +	mb();
> +	__asm__ __volatile__(
> +		"sw $0, 0(%[addr])\n" : :
> +		[addr] "r"(lock) :
> +		"memory");
> +
> +	/* Force a write buffer flush. */
> +	mb();
> +}

It would be good to add some justification for using your own locks,
rather than standard linux locks.

Is there anything specific to your hardware in this resource manager?
I'm just wondering if this should be generic, put somewhere in lib. Or
maybe there is already something generic, and you should be using it,
not re-inventing the wheel again.

      Andrew
