Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 04:59:00 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:38123 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901161Ab2EHC6x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 04:58:53 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q482wgTk009749
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Mon, 7 May 2012 19:58:43 -0700
Date:   Mon, 07 May 2012 22:58:42 -0400 (EDT)
Message-Id: <20120507.225842.692131427998127266.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     ralf@linux-mips.org, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org, david.daney@cavium.com
Subject: Re: [PATCH v6 1/3] netdev/of/phy: New function: of_mdio_find_bus().
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1336007799-31016-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
        <1336007799-31016-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Mon, 07 May 2012 19:58:45 -0700 (PDT)
X-archive-position: 33181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Wed,  2 May 2012 18:16:37 -0700

> From: David Daney <david.daney@cavium.com>
> 
> Add of_mdio_find_bus() which allows an mii_bus to be located given its
> associated the device tree node.
> 
> This is needed by the follow-on patch to add a driver for MDIO bus
> multiplexers.
> 
> The of_mdiobus_register() function is modified so that the device tree
> node is recorded in the mii_bus.  Then we can find it again by
> iterating over all mdio_bus_class devices.
> 
> Because the OF device tree has now become an integral part of the
> kernel, this can live in mdio_bus.c (which contains the needed
> mdio_bus_class structure) instead of of_mdio.c.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied.
