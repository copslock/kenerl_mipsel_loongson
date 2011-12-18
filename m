Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 04:00:47 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:52362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903750Ab1LRDAm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 04:00:42 +0100
Received: from localhost (cpe-66-65-61-233.nyc.res.rr.com [66.65.61.233])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBI30XUs020538
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Sat, 17 Dec 2011 19:00:33 -0800
Date:   Sat, 17 Dec 2011 22:00:32 -0500 (EST)
Message-Id: <20111217.220032.683061606470374131.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Some code cleanups for meth
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4EED418E.40501@gentoo.org>
References: <4EED418E.40501@gentoo.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 17 Dec 2011 19:00:34 -0800 (PST)
X-archive-position: 32131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14326

From: Joshua Kinard <kumba@gentoo.org>
Date: Sat, 17 Dec 2011 20:27:42 -0500

> -#define WAIT_FOR_PHY(___rval)					\
> -	while ((___rval = mace->eth.phy_data) & MDIO_BUSY) {	\
> -		udelay(25);					\
> +#define WAIT_FOR_PHY(___rval)                               \
> +	while ((___rval = mace->eth.phy_data) & MDIO_BUSY) {    \
> +		udelay(25);                                         \

I think using tabs at the end of the line to line up the "\" is much
better than what you're changing it to, that being spaces.

> -		priv->phy_addr=i;
> -		p2=mdio_read(priv,2);
> -		p3=mdio_read(priv,3);
> +
> +	for (i = 0; i < 32; i++){
> +		priv->phy_addr = i;
> +		p2 = mdio_read(priv,2);
> +		p3 = mdio_read(priv,3);

If you're going to put forth the effort to put spaces around the
"=" characters, fix up the arguments to mdio_read() as well, there
needs to be a space after the "," and right before the second
argument.

> +		if ((p2 != 0xffff) && (p2 != 0x0000)) {

There is no need for the new parenthesis you are adding here.  It
doesn't change things semantically, and it does not improve
readability, it just makes for more characters a human has to parse in
his mind.

> - * Copyright (C) 2001 Alessandro Rubini and Jonathan Corbet
> - * Copyright (C) 2001 O'Reilly & Associates
> + * Copyright (C) 2001-2003 Ilya Volynets
> + * Copyright (C) 2011 Joshua Kinard
>   *
> - * The source code in this file can be freely used, adapted,
> - * and redistributed in source or binary form, so long as an
> - * acknowledgment appears in derived source files.  The citation
> - * should list that the code comes from the book "Linux Device
> - * Drivers" by Alessandro Rubini and Jonathan Corbet, published
> - * by O'Reilly & Associates.   No warranty is attached;
> - * we cannot take responsibility for errors or fitness for use.
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version
> + *	2 of the License, or (at your option) any later version.
>   */

I'm not sure at all that you have the ability to make this kind of
change to the copyright and attributions here.

There are probably a lot more problems with this patch, but I'm
exhausted look at this stuff as-is.
