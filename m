Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 16:35:52 +0000 (GMT)
Received: from p508B5C01.dip.t-dialin.net ([IPv6:::ffff:80.139.92.1]:45193
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225315AbUAMQfv>; Tue, 13 Jan 2004 16:35:51 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0DGZlWI005333;
	Tue, 13 Jan 2004 17:35:47 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0DGZi3X005332;
	Tue, 13 Jan 2004 17:35:44 +0100
Date: Tue, 13 Jan 2004 17:35:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: karthikeyan natarajan <karthik_96cse@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: How to configure the cache size in r4000
Message-ID: <20040113163543.GA31459@linux-mips.org>
References: <20040111124828.71884.qmail@web10103.mail.yahoo.com> <Pine.LNX.4.55.0401121345490.21851@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401121345490.21851@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 12, 2004 at 01:51:55PM +0100, Maciej W. Rozycki wrote:

> >     The cache size is modified by setting the IC/DC
> > bits in the 'config' register. Seems they are set only
> > by the hardware during the processor reset. And also,
> > those bits are mentioned as read only bits..
> 
>  You cannot modify the size of the primary caches -- the values are
> hardwired to the amount of cache available in the processor (8kB+8kB for
> the original R4000).  However, if you take appropriate precautions, you
> can alter the line sizes of the caches by modifying appropriate bits of
> cp0.config.

On some systems that's a dangerous and won't work due to some issue with
the memory controller.  That's why Linux supports all possible combinations
instead of reconfiguring caches.  Of course there's also the hope that
developers of a system did configure the cache for the optimal performance.

The one system I recall where reconfiguring is not possible are certain
revs of MIPS Magnum 4000 / MIPS Millenium / Olivetti M700-10 but I'm
convinced there are others.

If reconfiguring is possible 32-byte D-cache and I-Cache lines are probably
the optimum for non-tiny systems.  For the L2 cache I'd guess 64 or 128
byte lines.

  Ralf
