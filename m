Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 06:19:36 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:52933 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab1LRFTd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 06:19:33 +0100
Received: from localhost (cpe-66-65-61-233.nyc.res.rr.com [66.65.61.233])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBI5JQDt025647
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Sat, 17 Dec 2011 21:19:29 -0800
Date:   Sun, 18 Dec 2011 00:19:25 -0500 (EST)
Message-Id: <20111218.001925.2108645748994734084.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4EED6DED.50308@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <20111217.215630.640392276998191183.davem@davemloft.net>
        <4EED6DED.50308@gentoo.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 17 Dec 2011 21:19:29 -0800 (PST)
X-archive-position: 32134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14338

From: Joshua Kinard <kumba@gentoo.org>
Date: Sat, 17 Dec 2011 23:37:01 -0500

> MACE Ethernet only ever appears on the SGI O2 systems.

That has no bearing on my feedback, we simply do not put non-portable
code like this into the tree at this point.

Just because this driver has been maintained in an non-portable manner
up to this point, doesn't mean we continue doing that.
