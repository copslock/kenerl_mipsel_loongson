Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 20:51:09 +0100 (BST)
Received: from p508B6E75.dip.t-dialin.net ([IPv6:::ffff:80.139.110.117]:57178
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225777AbUERTvI>; Tue, 18 May 2004 20:51:08 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4IJovxT005499;
	Tue, 18 May 2004 21:50:57 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4IJotiO005498;
	Tue, 18 May 2004 21:50:55 +0200
Date: Tue, 18 May 2004 21:50:55 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: Jun Sun <jsun@mvista.com>, Bob Breuer <bbreuer@righthandtech.com>,
	linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518195055.GB2454@linux-mips.org>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com> <20040518114519.C5390@mvista.com> <20040518191019.GA11007@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518191019.GA11007@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 08:10:19PM +0100, Peter Horton wrote:

> The kernel maps the page cache page into user space ... BANG! possible
> D-cache alias.
> 
> The kernel doesn't bother flushing the page cache page from the D-cache
> as it's never accessed at it's page cache address.

It is - after all the driver is copying the data to there.  The same
problem also exists in the ramdisk driver and there it has been fixed
properly, it seems.

> The current fix in the Cobalt patches (2.4 & 2.6) just flushes the read
> data out of the D-cache after every IDE insw()/insl(). This is the least
> intrusive fix.
> 
> Some Sparc machines also see this problem.

Carelessly written PIO drivers on any architecture would suffer from this
kind of problem.

  Ralf
