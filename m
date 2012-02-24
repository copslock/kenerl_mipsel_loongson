Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 09:54:05 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:43856 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXIx6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 09:53:58 +0100
Received: from localhost (cpe-66-65-56-15.nyc.res.rr.com [66.65.56.15])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q1O8rqkr015097
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Fri, 24 Feb 2012 00:53:55 -0800
Date:   Fri, 24 Feb 2012 03:53:52 -0500 (EST)
Message-Id: <20120224.035352.619003522379818254.davem@davemloft.net>
To:     blogic@openwrt.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 11/14] NET: MIPS: lantiq: convert etop driver to
 clkdev api
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4F474D02.1040306@openwrt.org>
References: <1330012993-13510-11-git-send-email-blogic@openwrt.org>
        <20120224.032812.10813781440356110.davem@davemloft.net>
        <4F474D02.1040306@openwrt.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Fri, 24 Feb 2012 00:53:56 -0800 (PST)
X-archive-position: 32536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: John Crispin <blogic@openwrt.org>
Date: Fri, 24 Feb 2012 09:40:34 +0100

> One question if I may ask
> * do you want to be CC'ed for a full series even if only 1 patch relates
> to netdev or should I simply think more about the commit message so it
> is apparent what i expect ?

Only post the networking patches and mention the situation at hand
in this kind of case.
