Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 00:34:55 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:53757 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903746Ab2FYWer (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 00:34:47 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CCC6583B39;
        Mon, 25 Jun 2012 15:34:41 -0700 (PDT)
Date:   Mon, 25 Jun 2012 15:34:40 -0700 (PDT)
Message-Id: <20120625.153440.17010814246237639.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet
 PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com>
References: <1340411056-18988-1-git-send-email-ddaney.cavm@gmail.com>
        <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.97 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 33803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Fri, 22 Jun 2012 17:24:13 -0700

> From: David Daney <david.daney@cavium.com>
> 
> The IEEE802.3 clause 45 MDIO bus protocol allows for directly
> addressing PHY registers using a 21 bit address, and is used by many
> 10G Ethernet PHYS.  Already existing is the ability of MDIO bus
> drivers to use clause 45, with the MII_ADDR_C45 flag.  Here we add
> struct phy_c45_device_ids to hold the device identifier registers
> present in clause 45. struct phy_device gets a couple of new fields:
> c45_ids to hold the identifiers and is_c45 to signal that it is clause
> 45.
> 
> Normally the MII_ADDR_C45 flag is ORed with the register address to
> indicate a clause 45 transaction.  Here we also use this flag in the
> *device* address passed to get_phy_device() to indicate that probing
> should be done with clause 45 transactions.
> 
> EXPORT phy_device_create() so that the follow-on patch to of_mdio.c
> can use it to create phy devices for PHYs, that have non-standard
> device identifier registers, based on the device tree bindings.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

I see no value in having two ways to say that clause-45 transactions
should be used.

Either make it a PHY device attribute, or specify it in the address
in the register accesses, but not both.

Also your patch is full of coding style errors, I simply couldn't
stomache applying this even if I agreed with the substance of the
changes:

> +	     i < ARRAY_SIZE(c45_ids->device_ids) &&
> +		     c45_ids->devices_in_package == 0;

c45_ids on the second line should line up with the initial 'i'
on the first line.

> +		c45_ids->devices_in_package = (phy_reg & 0xffff) << 16;
> +
> +
> +		reg_addr = MII_ADDR_C45 | i << 16 | 5;

There is not reason in the world to have two empty lines there, it
looks awful.

> +		/*
> +		 * If mostly Fs, there is no device there,
> +		 * let's get out of here.
> +		 */

Format comments:

	/* Like
	 * this.
	 */

Not.

	/*
	 * Like
	 * this.
	 */

> +		c45_ids->device_ids[i] = (phy_reg & 0xffff) << 16;
> +
> +
> +		reg_addr = MII_ADDR_C45 | i << 16 | MII_PHYSID2;

Two empty lines.  This is extremely irritating, it looks like you
had some kind of debugging code here and then were very lazy about
removing it.

> +/*
> + * Or MII_ADDR_C45 into regnum for read/write on mii_bus to enable the
> + * 21 bit IEEE 802.3ae clause 45 addressing mode used by 10GIGE phy
> + * chips.  Also may be ORed into the device address in
> + * get_phy_device().
> + */

Comment formatting.

> +/*
> + * phy_c45_device_ids: 802.3-c45 Device Identifiers
> + *
> + * devices_in_package: Bit vector of devices present.
> + * device_ids: The device identifer for each present device.
> + */

If you're going to list the struct members use the correct kerneldoc
format to do so.
