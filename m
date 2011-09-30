Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Oct 2011 00:55:02 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:57594 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491082Ab1I3Wyk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Oct 2011 00:54:40 +0200
Received: from localhost (cpe-66-65-62-183.nyc.res.rr.com [66.65.62.183])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p8UMsYWU028048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 30 Sep 2011 15:54:34 -0700
Date:   Fri, 30 Sep 2011 18:54:33 -0400 (EDT)
Message-Id: <20110930.185433.371029849281805679.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Gregory.Dietsche@cuw.edu, u.kleine-koenig@pengutronix.de,
        peppe.cavallaro@st.com
Subject: Re: [PATCH] netdev/phy/icplus: Use mdiobus_write() and
 mdiobus_read() for proper locking.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1317421068-27278-1-git-send-email-david.daney@cavium.com>
References: <1317421068-27278-1-git-send-email-david.daney@cavium.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Fri, 30 Sep 2011 15:54:36 -0700 (PDT)
X-archive-position: 31191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 25

From: David Daney <david.daney@cavium.com>
Date: Fri, 30 Sep 2011 15:17:48 -0700

> Usually you have to take the bus lock.  Why not here too?
> 
> I saw this when working on something else.  Not even compile tested.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Greg Dietsche <Gregory.Dietsche@cuw.edu>
> Cc: "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Applied to net-next.
