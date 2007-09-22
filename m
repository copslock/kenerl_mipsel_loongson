Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Sep 2007 04:23:32 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:37545 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20021389AbXIVDXY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Sep 2007 04:23:24 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1IYvXR-0000NV-A0
	for linux-mips@linux-mips.org; Fri, 21 Sep 2007 20:20:13 -0700
Message-ID: <12833079.post@talk.nabble.com>
Date:	Fri, 21 Sep 2007 20:20:13 -0700 (PDT)
From:	Steve Graham <stgraham2000@yahoo.com>
To:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
In-Reply-To: <20070921134753.GA8090@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: stgraham2000@yahoo.com
References: <4687DCE2.8070302@gentoo.org> <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca> <20070921134753.GA8090@linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stgraham2000@yahoo.com
Precedence: bulk
X-list: linux-mips


I've just recently fixed this problem on my E9000 core which is a MSP85XX.  I
did some digging and found that the problem started to occur in 2.6.16 and
is not there in 2.6.15.  I looked into the deltas and found the specific
change that broke me.  The file is c-r4k.c.

In the function "local_r4k_flush_cache_sigtramp" there is a conditional:

if (!cpu_icache_snoops_remote_store && scache_size)
    protected_writeback_scache_line(addr & ~(sc_lsize - 1));

This additional "scache_size" has been added to this conditional.  On my
platform, "scache_size" is set to zero so the
"protected_writeback_scache_line" is now not being called.  I took out the
"scache_size" from the conditional and now I boot without any illegal
instructions.

As a side note, I also took out the workaround in "war.h".  This workaround
only hid the problem, it didn't fix it.  Before I changed the conditional, I
would crash on every boot without the workaround.  The workaround reduced
the crashes to maybe 1 in 3.  Now, without the workaround, and with the
change in the conditional, I haven't experienced any problems.

I'm sure this change was made for a reason in 2.6.16 so I'm not sure what
the official fix needs to be but that solved my issues on my platform.

Let me know if there is anything anyone wants me to try on my platform to
help come to an official fix for this problem.

Steve...
-- 
View this message in context: http://www.nabble.com/O2-RM7000-Issues-tf4008392.html#a12833079
Sent from the linux-mips main mailing list archive at Nabble.com.
