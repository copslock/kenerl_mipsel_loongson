Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 05:19:22 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33026
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491873AbZJXDTP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 05:19:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 1DE7FC8C2A9;
	Fri, 23 Oct 2009 20:19:29 -0700 (PDT)
Date:	Fri, 23 Oct 2009 20:19:28 -0700 (PDT)
Message-Id: <20091023.201928.12664693.davem@davemloft.net>
To:	jesse.brandeburg@gmail.com
Cc:	ebiederm@xmission.com, ddaney@caviumnetworks.com,
	cfriesen@nortel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Irq architecture for multi-core network driver.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <4807377b0910231028g60b479cfycdbf3f4e25384c58@mail.gmail.com>
References: <4AE0DB98.1000101@caviumnetworks.com>
	<m13a5apmm0.fsf@fess.ebiederm.org>
	<4807377b0910231028g60b479cfycdbf3f4e25384c58@mail.gmail.com>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Fri, 23 Oct 2009 10:28:10 -0700

> Yes, I know Arjan and others will say you should always run
> irqbalance, but some people don't and some distros don't ship it
> enabled by default (or their version doesn't work for one reason or
> another)  The question is should the kernel work better by default
> *without* irqbalance loaded, or does it not matter?

I think requiring irqbalanced for optimal behavior is more
than reasonable.

And since we explicitly took that policy logic out of the
kernel it makes absolutely no sense to put it back there.

It's policy, and policy is (largely) userspace.
