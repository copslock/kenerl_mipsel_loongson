Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 19:17:58 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:59373 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab1L0SRy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 19:17:54 +0100
Received: from localhost (nat-pool-rdu.redhat.com [66.187.233.202])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id pBRIHhWi014261
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Tue, 27 Dec 2011 10:17:44 -0800
Date:   Tue, 27 Dec 2011 13:17:43 -0500 (EST)
Message-Id: <20111227.131743.1555029258883745131.davem@davemloft.net>
To:     kumba@gentoo.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4EF95247.7000403@gentoo.org>
References: <4EED3A3D.9080503@gentoo.org>
        <4EF95247.7000403@gentoo.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 27 Dec 2011 10:17:44 -0800 (PST)
X-archive-position: 32198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20074

From: Joshua Kinard <kumba@gentoo.org>
Date: Tue, 27 Dec 2011 00:06:15 -0500

> SGI IP32 (O2)'s ethernet driver (meth) lacks a set_rx_mode function, which
> prevents IPv6 from working completely because any ICMPv6 neighbor
> solicitation requests aren't picked up by the driver.  So the machine can
> ping out and connect to other systems, but other systems will have a very
> hard time connecting to the O2.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>

Applied to net-next, thanks.
