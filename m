Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 21:02:07 +0100 (BST)
Received: from p508B6E75.dip.t-dialin.net ([IPv6:::ffff:80.139.110.117]:2139
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225795AbUERUCG>; Tue, 18 May 2004 21:02:06 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4IK25xT005778;
	Tue, 18 May 2004 22:02:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4IK25IV005777;
	Tue, 18 May 2004 22:02:05 +0200
Date: Tue, 18 May 2004 22:02:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bob Breuer <bbreuer@righthandtech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: problems on D-cache alias in 2.4.22
Message-ID: <20040518200205.GC2454@linux-mips.org>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 01:17:38PM -0500, Bob Breuer wrote:

> Changing that same place also fixes my problem.  However, I came across
> the mips cobalt patches and after applying a variation of the IDE cache
> fix from there, that also fixes the problem.  So it would seem that this
> is the same problem as already fixed in the cobalt patch, but showing up
> on non-cobalt hardware.
> 
> flush_page_to_ram() was made useless around the release of 2.4.21.  I
> suspect that this was broken at that time, seeing how it is broken in
> 2.4.22 and 2.4.26.  From browsing the debian-mips mailing list archives,
> it appears that they have not had a stable mips kernel since 2.4.19,
> could this bug be the cause?  Are the recent Debian mips kernels still
> unstable?
> 
> Would anyone with an unstable 2.4.2x kernel be willing to try one of the
> attached patches to see if the situation improves?

flush_page_to_ram has been deprecated since a long, long time and so it's
use in memory managment was no longer correct for all cases - MIPS was
basically the last major Linux architecture left using it.  Replacing
it with flush_dcache_page fixed those correctness problem and delivered
a major speedup.  So no sense in whining - flush_page_to_ram won't return.

  Ralf
