Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 13:25:27 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:31510 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbVDGMZN>; Thu, 7 Apr 2005 13:25:13 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j37CP7UH013177;
	Thu, 7 Apr 2005 13:25:07 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j37CP4OK013176;
	Thu, 7 Apr 2005 13:25:04 +0100
Date:	Thu, 7 Apr 2005 13:25:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: memcpy prefetch
Message-ID: <20050407122504.GY4948@linux-mips.org>
References: <4253D67C.4010705@timesys.com> <20050406200848.GB4978@linux-mips.org> <4255240E.4050701@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4255240E.4050701@timesys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 07, 2005 at 08:14:06AM -0400, Greg Weeks wrote:

> What's the performance hit for doing a pref on a cache line that is 
> already pref'd?

A wasted instruction.

(More complicated on certain multi-issue in-order processors such as the
SB1 CPU core.  Mentioning this for completeness; we shouldn't worry about
it here.)

>  Does it turn into a nop, or do we get some horrible 
> degenerate case? Are 64 bit processors always at least 32 byte cache 
> line size?

The smallest D-cache line I know of is 16 bytes.

> I don't really expect anyone to know the answers right now. I 
> expect I'll need to time code to tell. This makes generating them at run 
> time look better and better.

Indeed.  Initially when we started doing such things some people felt it
might be really bad to debug and everything but in practice it's been a
relativly minor problem, so I guess the resistance against yet another
run-time generated group of functions is getting less.

One interesting issue to solve - memcpy, memmove and copy_user are combined
into a single big function, so the fixups for userspace accesses need to
be handled at runtime as well.

  Ralf
