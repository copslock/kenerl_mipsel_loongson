Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2007 12:58:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:61370 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022663AbXIXL6F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Sep 2007 12:58:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8OBw5De024180;
	Mon, 24 Sep 2007 12:58:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8OBw5gc024179;
	Mon, 24 Sep 2007 12:58:05 +0100
Date:	Mon, 24 Sep 2007 12:58:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Steve Graham <stgraham2000@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070924115804.GA12300@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca> <20070921134753.GA8090@linux-mips.org> <12833079.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12833079.post@talk.nabble.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 21, 2007 at 08:20:13PM -0700, Steve Graham wrote:

> I've just recently fixed this problem on my E9000 core which is a MSP85XX.  I
> did some digging and found that the problem started to occur in 2.6.16 and
> is not there in 2.6.15.  I looked into the deltas and found the specific
> change that broke me.  The file is c-r4k.c.
> 
> In the function "local_r4k_flush_cache_sigtramp" there is a conditional:
> 
> if (!cpu_icache_snoops_remote_store && scache_size)
>     protected_writeback_scache_line(addr & ~(sc_lsize - 1));
> 
> This additional "scache_size" has been added to this conditional.  On my
> platform, "scache_size" is set to zero so the
> "protected_writeback_scache_line" is now not being called.  I took out the
> "scache_size" from the conditional and now I boot without any illegal
> instructions.

In this case the question is, why is scache_size 0 on your platform?  I
suppose that's because sc-rm7k.c has it's own scache_size so c-r4k.c never
gets to see the right value so maybe the sanest fix would be to move
sc-rm7k.c into c-r4k.c.

> As a side note, I also took out the workaround in "war.h".  This workaround
> only hid the problem, it didn't fix it.  Before I changed the conditional, I
> would crash on every boot without the workaround.  The workaround reduced
> the crashes to maybe 1 in 3.  Now, without the workaround, and with the
> change in the conditional, I haven't experienced any problems.
> 
> I'm sure this change was made for a reason in 2.6.16 so I'm not sure what
> the official fix needs to be but that solved my issues on my platform.

ICACHE_REFILLS_WORKAROUND_WAR is a separate issue - you need to enable it
for all RM7000 and also unless PMC changed mind also all E9000 cores.  So
while I can understand that disabling this for testing a fix for the real
issue you definately should reenable this once you're done.

> Let me know if there is anything anyone wants me to try on my platform to
> help come to an official fix for this problem.

I wrote most of that stuff anyway ...

  Ralf
