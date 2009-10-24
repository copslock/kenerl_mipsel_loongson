Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2009 15:26:18 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43215
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492394AbZJXN0L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2009 15:26:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 477C5C8C2A9;
	Sat, 24 Oct 2009 06:26:28 -0700 (PDT)
Date:	Sat, 24 Oct 2009 06:26:28 -0700 (PDT)
Message-Id: <20091024.062628.263337033.davem@davemloft.net>
To:	ebiederm@xmission.com
Cc:	jesse.brandeburg@gmail.com, ddaney@caviumnetworks.com,
	cfriesen@nortel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Irq architecture for multi-core network driver.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <m17huln1ab.fsf@fess.ebiederm.org>
References: <m13a5apmm0.fsf@fess.ebiederm.org>
	<4807377b0910231028g60b479cfycdbf3f4e25384c58@mail.gmail.com>
	<m17huln1ab.fsf@fess.ebiederm.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 23 Oct 2009 16:22:36 -0700

> irqbalance is actually more likely to move irqs than the hardware.
> I have heard promises it won't move network irqs but I have seen
> the opposite behavior.

It knows what network devices are named, and looks for those keys
in /proc/interrupts.  Anything names 'ethN' will not be moved and
if you name them on a per-queue basis properly (ie. 'ethN-RX1' etc.)
it will flat distribute those interrupts amongst the cpus in the
machine.

So if you're doing "silly stuff" and naming your devices by some other
convention, you would end up defeating the detations built into
irqbalanced.

Actually, let's not even guess, go check out the sources of the
irqbalanced running on your system and make sure it has the network
device logic in it. :-)
