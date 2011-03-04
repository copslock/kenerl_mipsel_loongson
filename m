Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 17:13:40 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60723 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491800Ab1CDQNh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 17:13:37 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p24GDF1Y028989;
        Fri, 4 Mar 2011 17:13:16 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p24GDFu1028987;
        Fri, 4 Mar 2011 17:13:15 +0100
Date:   Fri, 4 Mar 2011 17:13:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MTX-1: make au1000_eth probes all PHY addresses
Message-ID: <20110304161315.GB24966@linux-mips.org>
References: <201102271953.54065.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201102271953.54065.florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 27, 2011 at 07:53:53PM +0100, Florian Fainelli wrote:

> From: Florian Fainelli <florian@openwrt.org>
> 
> When au1000_eth probes the MII bus for PHY address, if we do not set au1000_eth
> platform data's phy_search_highest_address, the MII probing logic will exit
> early and will assume a valid PHY is found at address 0. For MTX-1, the PHY is
> at address 31, and without this patch, the link detection/speed/duplex would not
> work correctly.
> 
> CC: stable@kernel.org
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> Stable: 2.6.34+

Thanks, applied to 2.6.34+.  Note that while you added a
CC stable@kernel.org that address was not actually on the mail's cc list!

  Ralf
