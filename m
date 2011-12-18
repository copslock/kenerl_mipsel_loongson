Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 03:56:55 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:52335 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903751Ab1LRC4u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 03:56:50 +0100
Received: from localhost (cpe-66-65-61-233.nyc.res.rr.com [66.65.61.233])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBI2uV7x020344
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Sat, 17 Dec 2011 18:56:34 -0800
Date:   Sat, 17 Dec 2011 21:56:30 -0500 (EST)
Message-Id: <20111217.215630.640392276998191183.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4EED3A3D.9080503@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 17 Dec 2011 18:56:35 -0800 (PST)
X-archive-position: 32130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14321

From: Joshua Kinard <kumba@gentoo.org>
Date: Sat, 17 Dec 2011 19:56:29 -0500

> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
> + * MACE Ethernet uses a 64 element hash table based on the Ethernet CRC.
> + */
> +static int multicast_filter_limit = 32;
> +
> +

Unnecessary empty line, only one is sufficient.  I also don't see a reason
to even define this value.  If it's a constant then use a const type.

> +	/* Multicast filter. */
> +	unsigned long mcast_filter;
> +
 ...
> +		priv->mcast_filter = 0xffffffffffffffffUL;

You're assuming that unsigned long is 64-bits here.  You need to use a
type which matches your expections regardless of the architecture that
the code is built on.

> +		netdev_for_each_mc_addr(ha, dev)
> +			set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
> +				    (volatile long unsigned int *)&priv->mcast_filter);

This makes an assumption not only about the size of the "unsigned long"
type, but also of the endianness of the architecture this runs on.

Please recode this to remove both assumptions.
