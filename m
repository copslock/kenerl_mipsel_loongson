Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2003 13:03:32 +0000 (GMT)
Received: from p508B758A.dip.t-dialin.net ([IPv6:::ffff:80.139.117.138]:11408
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226133AbTAJNDb>; Fri, 10 Jan 2003 13:03:31 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0AD3QI08346;
	Fri, 10 Jan 2003 14:03:26 +0100
Date: Fri, 10 Jan 2003 14:03:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] R4k cache code synchronization
Message-ID: <20030110140326.B7699@linux-mips.org>
References: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030110131859.23678B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 10, 2003 at 01:37:12PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 10, 2003 at 01:37:12PM +0100, Maciej W. Rozycki wrote:

>  I can't see any need for flush_cache_l1() and flush_cache_l2().  I'd like
> to remove them.  A single flush_cache_all() seems sufficient for our
> needs.  Any objections? 

The reason for the existance of flush_cache_l1 and flush_cache_l2 is the
Origin.  An empty flush_cache_all() is sufficient on the Origin because
it's R10000 processor doesn't suffer from cache aliases.  During bootup
we have to flush all caches or the cache coherence logic will send crazy
exceptions at us.  For all other occasions just a flush of the primary
caches is sufficient which is why there is flush_cache_l1.

So I think we want to wrap things a bit nicer but basically we have to
keep those cacheops for the sake of the Origin.

  Ralf
