Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Dec 2011 21:17:28 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:50914 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903595Ab1LZURY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Dec 2011 21:17:24 +0100
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBQKHDEQ014809
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Mon, 26 Dec 2011 12:17:14 -0800
Date:   Mon, 26 Dec 2011 15:17:13 -0500 (EST)
Message-Id: <20111226.151713.2002746283994460284.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4EF6803C.9060203@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF6803C.9060203@gentoo.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Mon, 26 Dec 2011 12:17:15 -0800 (PST)
X-archive-position: 32193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19726

From: Joshua Kinard <kumba@gentoo.org>
Date: Sat, 24 Dec 2011 20:45:32 -0500

> SGI IP32 (O2)'s ethernet driver (meth) lacks meth_set_rx_mode, which
> prevents IPv6 from working completely because any ICMPv6 neighbor
> solicitation requests aren't picked up by the driver.  So the machine can
> ping out and connect to other systems, but other systems will have a very
> hard time connecting to the O2.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>

Lots of completely unrelated changes here, the IRQ name string has
nothing to do with specifically fixing the ICMPv6 neighbour discovery
bug.

Do not mix changes like this, one change per patch please, thanks.
