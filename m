Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 14:14:08 +0000 (GMT)
Received: from p508B7BBE.dip.t-dialin.net ([80.139.123.190]:36525 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225268AbSLLOOH>; Thu, 12 Dec 2002 14:14:07 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBCE7Mb07547;
	Thu, 12 Dec 2002 15:07:22 +0100
Date: Thu, 12 Dec 2002 15:07:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Vivien Chappelier <vivienc@nerim.net>,
	linux-mips@linux-mips.org, Ilya Volynets <ilya@theilya.com>
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
Message-ID: <20021212150722.A6657@linux-mips.org>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor> <1039656676.18587.63.camel@irongate.swansea.linux.org.uk> <20021212033307.C22987@linux-mips.org> <1039697045.21231.13.camel@irongate.swansea.linux.org.uk> <20021212132022.A5060@linux-mips.org> <15864.34458.46732.218720@arsenal.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15864.34458.46732.218720@arsenal.algor.co.uk>; from dom@algor.co.uk on Thu, Dec 12, 2002 at 12:52:42PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 12, 2002 at 12:52:42PM +0000, Dominic Sweetman wrote:

> > Flushes are very expensive operations, on the order of 16 cycles per
> > cacheline plus memory delay.
> 
> Hmm.  Not on most MIPS CPUs; the internal cost of running the
> writeback cache-op instructions is typically around 3 clocks per
> cache-line.  But this is misleading anyway... too CPU-centric.

Most MIPS manuals unfortunately do not document the execution time of
cache instructions at all.  This thread is specific to the SGI IP32 aka
O2 which comes with three processor options, the r5000, the R10000 and
the R12000; the R5000's timing should not be too far off from the R4600.

So you got me to dig out my super dusty R4600/R4700 manual ...  Hit_-
Writeback_D costs 7 cycles for a miss, 12 for a hit if the line is clean
and 14 if the line is dirty.  Add another 3 cycles if the store or response
buffers are busy, add even more if the writeback buffer was filled up.

> The associated memory operations are the slowest thing about cacheops,
> always.  Memory accesses (120ns is good) are much, much slower than an
> instruction time on a modern CPU (1-5ns).
> 
> So for your framebuffer, it's the write which does for you.  If you
> use uncached mode and write 32-bit words that's 120ns/word.  You can
> get a cacheline-sized burst of 8 words in and out in roughly the same
> amount of time.

Forgot the numbers but SGI's IP32 memory subsystem is rather fast even
though it's fairly old.

  Ralf
