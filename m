Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 00:54:36 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:57585 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab1I3Wyc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 00:54:32 +0200
Received: from localhost (cpe-66-65-62-183.nyc.res.rr.com [66.65.62.183])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p8UMsLQQ028035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 30 Sep 2011 15:54:26 -0700
Date:   Fri, 30 Sep 2011 18:54:21 -0400 (EDT)
Message-Id: <20110930.185421.252729993071152404.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] netdev/phy: Use mdiobus_read() so that proper locks
 are taken.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1317419482-25655-1-git-send-email-david.daney@cavium.com>
References: <1317419482-25655-1-git-send-email-david.daney@cavium.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Fri, 30 Sep 2011 15:54:28 -0700 (PDT)
X-archive-position: 31190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24

From: David Daney <david.daney@cavium.com>
Date: Fri, 30 Sep 2011 14:51:22 -0700

> Accesses to the mdio busses must be done with the mdio_lock to ensure
> proper operation.  Conveniently we have the helper function
> mdiobus_read() to do that for us.  Lets use it in get_phy_id() instead
> of accessing the bus without the lock held.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied to net-next.
