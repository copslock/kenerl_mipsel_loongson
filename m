Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 00:04:40 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:60848 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20025740AbXIGXEc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Sep 2007 00:04:32 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1ITms4-0003KC-EN; Fri, 07 Sep 2007 23:04:17 +0000
Message-ID: <46E1D8EF.7010608@pobox.com>
Date:	Fri, 07 Sep 2007 19:04:15 -0400
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Matteo Croce <technoboy85@gmail.com>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, ejka@imfi.kspu.ru,
	netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
	pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
	kaber@coreworks.de
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
References: <200708201704.11529.technoboy85@gmail.com> <200709061734.11170.technoboy85@gmail.com> <20070906153025.7cb71cb1.akpm@linux-foundation.org> <200709070121.42629.technoboy85@gmail.com>
In-Reply-To: <200709070121.42629.technoboy85@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:
> Il Friday 07 September 2007 00:30:25 Andrew Morton ha scritto:
>>> On Thu, 6 Sep 2007 17:34:10 +0200 Matteo Croce <technoboy85@gmail.com> wrote:
>>> Driver for the cpmac 100M ethernet driver.
>>> It works fine disabling napi support, enabling it gives a kernel panic
>>> when the first IPv6 packet has to be forwarded.
>>> Other than that works fine.
>>>
>> I'm not too sure why I got cc'ed on this (and not on patches 1-6?) but
>> whatever.
> 
> I mailed every maintainer in the respective section in the file MAINTAINERS
> and you were in the "NETWORK DEVICE DRIVERS" section
> 
>> This patch introduces quite a number of basic coding-style mistakes. 
>> Please run it through scripts/checkpatch.pl and review the output.
> 
> Already done. I'm collecting other suggestions before committing

cool, I'll wait for the resend before reviewing, then.

As an author I understand that fixing up coding style / cosmetic stuff 
rather than "meat" is annoying.

But it is important to emphasize that a "clean" driver is what makes a 
good, thorough, effective review possible.

	Jeff
