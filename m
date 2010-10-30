Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Oct 2010 08:32:51 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:46199 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0J3Gcr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Oct 2010 08:32:47 +0200
Received: by wyf22 with SMTP id 22so3828913wyf.36
        for <multiple recipients>; Fri, 29 Oct 2010 23:32:41 -0700 (PDT)
Received: by 10.216.27.9 with SMTP id d9mr9808353wea.61.1288420361252;
        Fri, 29 Oct 2010 23:32:41 -0700 (PDT)
Received: from angua (dyn-247.woodhou.se [90.155.92.247])
        by mx.google.com with ESMTPS id x15sm2138342weq.31.2010.10.29.23.32.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 23:32:40 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 66BEC3C00E5; Sat, 30 Oct 2010 07:32:37 +0100 (BST)
Date:   Sat, 30 Oct 2010 07:32:37 +0100
From:   Grant Likely <grant.likely@secretlab.ca>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jeremy Kerr <jeremy.kerr@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH] of: of_mdio: Fix some endianness problems.
Message-ID: <20101030063237.GC2456@angua.secretlab.ca>
References: <1288227827-5447-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1288227827-5447-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Wed, Oct 27, 2010 at 06:03:47PM -0700, David Daney wrote:
> In of_mdiobus_register(), the __be32 *addr variable is dereferenced.
> This will not work on little-endian targets.  Also since it is
> unsigned, checking for less than zero is redundant.
> 
> Fix these two issues.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  drivers/of/of_mdio.c |   23 ++++++++++++++---------
>  1 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index 1fce00e..b370306 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -52,27 +52,32 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  
>  	/* Loop over the child nodes and register a phy_device for each one */
>  	for_each_child_of_node(np, child) {
> -		const __be32 *addr;
> +		const __be32 *paddr;
> +		u32 addr;
>  		int len;
>  
>  		/* A PHY must have a reg property in the range [0-31] */
> -		addr = of_get_property(child, "reg", &len);
> -		if (!addr || len < sizeof(*addr) || *addr >= 32 || *addr < 0) {
> +		paddr = of_get_property(child, "reg", &len);
> +		if (!paddr || len < sizeof(*paddr)) {
> +addr_err:
>  			dev_err(&mdio->dev, "%s has invalid PHY address\n",
>  				child->full_name);
>  			continue;
>  		}
> +		addr = be32_to_cpup(paddr);
> +		if (addr >= 32)
> +			goto addr_err;

goto's are fine for jumping to the end of a function to unwind
allocations, but please don't use it in this manner.  The original
structure will actually work just fine if you do it thusly:

		if (!paddr || len < sizeof(*paddr) ||
		    *(addr = be32_to_cpup(paddr)) >= 32) {
			dev_err(&mdio->dev, "%s has invalid PHY address\n",
				child->full_name);
			continue;
		}

Otherwise this patch looks good. After you've reworked and retested
I'll pick it up for 2.6.37 (or dave will).

g.


>  
>  		if (mdio->irq) {
> -			mdio->irq[*addr] = irq_of_parse_and_map(child, 0);
> -			if (!mdio->irq[*addr])
> -				mdio->irq[*addr] = PHY_POLL;
> +			mdio->irq[addr] = irq_of_parse_and_map(child, 0);
> +			if (!mdio->irq[addr])
> +				mdio->irq[addr] = PHY_POLL;
>  		}
>  
> -		phy = get_phy_device(mdio, be32_to_cpup(addr));
> +		phy = get_phy_device(mdio, addr);
>  		if (!phy || IS_ERR(phy)) {
>  			dev_err(&mdio->dev, "error probing PHY at address %i\n",
> -				*addr);
> +				addr);
>  			continue;
>  		}
>  		phy_scan_fixups(phy);
> @@ -91,7 +96,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  		}
>  
>  		dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
> -			child->name, *addr);
> +			child->name, addr);
>  	}
>  
>  	return 0;
> -- 
> 1.7.2.3
> 
