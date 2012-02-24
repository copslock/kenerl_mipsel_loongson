Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 09:28:26 +0100 (CET)
Received: from shards.monkeyblade.net ([198.137.202.13]:43702 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2BXI2T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 09:28:19 +0100
Received: from localhost (cpe-66-65-56-15.nyc.res.rr.com [66.65.56.15])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q1O8SDJh013280
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Fri, 24 Feb 2012 00:28:14 -0800
Date:   Fri, 24 Feb 2012 03:28:12 -0500 (EST)
Message-Id: <20120224.032812.10813781440356110.davem@davemloft.net>
To:     blogic@openwrt.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V2 11/14] NET: MIPS: lantiq: convert etop driver to
 clkdev api
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1330012993-13510-11-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
        <1330012993-13510-11-git-send-email-blogic@openwrt.org>
X-Mailer: Mew version 6.4 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Fri, 24 Feb 2012 00:28:16 -0800 (PST)
X-archive-position: 32534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: John Crispin <blogic@openwrt.org>
Date: Thu, 23 Feb 2012 17:03:10 +0100

> Update from old pmu_{dis,en}able() to ckldev api.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Come on guys, don't do crap like this.

When you have a 14 patch series, and I only see one or two of them
I have no idea what in the world you want me to do with these patches.

Are they dependent upon the previous patches that weren't sent to me?

Are they not and I can just apply them as-is?

Could I apply them as-is, but you want them to go via the MIPS tree
for some reason and just want my ACK?

Nobody knows because you didn't bother to say one way or another
and that is extremely irritating because as a result I have to
ask you all of these stupid questions and write this rediculious
email.

I'm just ignoring every single one of these MIPS patches, sorry.
