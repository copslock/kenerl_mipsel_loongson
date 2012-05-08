Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 04:59:32 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:38138 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab2EHC7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 04:59:01 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q482wrAZ009757
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Mon, 7 May 2012 19:58:54 -0700
Date:   Mon, 07 May 2012 22:58:53 -0400 (EDT)
Message-Id: <20120507.225853.1863347275703801019.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     ralf@linux-mips.org, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org, david.daney@cavium.com
Subject: Re: [PATCH v6 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1336007799-31016-3-git-send-email-ddaney.cavm@gmail.com>
References: <1336007799-31016-1-git-send-email-ddaney.cavm@gmail.com>
        <1336007799-31016-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Mon, 07 May 2012 19:58:55 -0700 (PDT)
X-archive-position: 33182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Wed,  2 May 2012 18:16:38 -0700

> From: David Daney <david.daney@cavium.com>
> 
> This patch adds a somewhat generic framework for MDIO bus
> multiplexers.  It is modeled on the I2C multiplexer.
> 
> The multiplexer is needed if there are multiple PHYs with the same
> address connected to the same MDIO bus adepter, or if there is
> insufficient electrical drive capability for all the connected PHY
> devices.
> 
> Conceptually it could look something like this:
 ...
> This framework configures the bus topology from device tree data.  The
> mechanics of switching the multiplexer is left to device specific
> drivers.
> 
> The follow-on patch contains a multiplexer driven by GPIO lines.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied.
