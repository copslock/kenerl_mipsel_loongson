Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 10:27:18 +0100 (BST)
Received: from p508B6D14.dip.t-dialin.net ([IPv6:::ffff:80.139.109.20]:52675
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225207AbTHAJ1H>; Fri, 1 Aug 2003 10:27:07 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h719Qtx6017992;
	Fri, 1 Aug 2003 11:26:55 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h719QoJF017991;
	Fri, 1 Aug 2003 11:26:50 +0200
Date: Fri, 1 Aug 2003 11:26:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	Fuxin Zhang <fxzhang@ict.ac.cn>, linux-mips@linux-mips.org
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030801092649.GA17624@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02> <16170.7179.635988.268987@doms-laptop.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16170.7179.635988.268987@doms-laptop.algor.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 08:51:39AM +0100, Dominic Sweetman wrote:

> The MIPS32/MIPS64 release 2 architecture includes a useful instruction
> SYNCI which does the whole job (repeat on each affected cache line)
> and is legal in user mode; this will take a while to spread but I'd
> recommend it as a model worth following.

> So I hope that kernels will provide one function for "I've just
> written instructions and now I want to execute them", and not export
> the separate writeback-D/invalidate-I interface.

Linux supports the traditional MIPS UNIX cacheflush(2) syscall through
a libc interface.  Since I've not seen any other use for the call than
I/D-cache synchronization.  I'd just make cacheflush(3) use SYNCI where
available (Or maybe one of the other vendor specific mechanisms ...) and
fallback to cacheflush(2) where available.  Gcc would be another place
to teach about SYNCI for it's trampolines.

  Ralf
