Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KCRlEC025427
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 05:27:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KCRlJn025426
	for linux-mips-outgoing; Tue, 20 Aug 2002 05:27:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f39.dialo.tiscali.de [62.246.16.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KCReEC025414
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 05:27:41 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g7JDSHS21246;
	Mon, 19 Aug 2002 15:28:17 +0200
Date: Mon, 19 Aug 2002 15:28:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: a really really weird crash on swarm
Message-ID: <20020819152817.A14266@linux-mips.org>
References: <20020811185138.A2133@dea.linux-mips.net> <Pine.GSO.3.96.1020819144136.14441E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020819144136.14441E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 19, 2002 at 02:57:14PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 19, 2002 at 02:57:14PM +0200, Maciej W. Rozycki wrote:

> > Really odd because the register only lost the upper 16 bits; the lower 16
> > bits still have their expected value.
> 
>  It is a typical symptom of a register being corrupted between a "lui" and
> an "addiu"  -- an exception must have done it in the immediately preceding
> code.  You might be able to track a reason down by carefully studying
> possible exception paths at the place of the problem.  Unfortunately you
> don't have much of the state preserved at this stage -- you only know
> which register was corrupted. 

Little exception potencial in this case as the interrupts got disabled and
the addresses used were rsp. should all be in KSEG0.

>  Another possible approach is to add some code that compares the values of
> the register upon an exception entry and exit and wait for it to trigger
> -- for a single register it shouldn't be too tough and you have still much
> of the state available before an "rfe" or "eret".

Don't try to think too deterministic - Jun was working on first silicon, so
not necessarily on a deterministic platform as we'd like.  Fortunately
as you may have seen in the kernel code there's already newer silicon so
I'd simply file this one to /dev/null for now.

  Ralf
