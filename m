Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 13:44:12 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:21673 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S870068AbSK2MoC>; Fri, 29 Nov 2002 13:44:02 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gATCgVU12750;
	Fri, 29 Nov 2002 13:42:31 +0100
Date: Fri, 29 Nov 2002 13:42:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
Message-ID: <20021129134230.A11704@linux-mips.org>
References: <20021128171519.A18165@linux-mips.org> <Pine.GSO.3.96.1021128172026.8D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021128172026.8D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Nov 29, 2002 at 12:56:10PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 29, 2002 at 12:56:10PM +0100, Maciej W. Rozycki wrote:

> > We've talked about this before - the specification of the ll/sc
> > instructions says they only work ok on cached memory.  In the real world
> > they seem to work also in uncached memory but I'd not bet the farm on
> > that, too many implementations out there, too many chances for subtle
> > bugs.
> 
>  Indeed -- CONFIG_MIPS_UNCACHED should either be removed or imply
> CONFIG_CPU_HAS_LLSC=n.  I suppose there is some interest in the option, so
> the latter is preferable.  That would imply moving the option into the CPU
> configuration section as now it's set very late, long after
> CONFIG_CPU_HAS_LLSC is set.  Or it could be set up the other way, i.e. the
> option would only become available if CONFIG_CPU_HAS_LLSC had been set to
> n.  There would be no need to move it then. 
> 
>  What do you think? 

I had the same thought.  So far there are the following groups of people
using this option:

  - Hardware people using it so the the entire program is becoming visible
    externally.

    Becoming obsoleted by more advanced, less intrusive hardware debugging
    methods.

  - Software people kluding around bugs in their software.

    Don't expect me to support this.  Note with a line of code.

  - For testing if the cache code is actually working.

    Will only be useful to show big fat bugs.  For the more subtle bugs
    there is no way at all around understanding the entire cache managment
    thing including all subtilities.  Actually a good reason to not support
    this option either.

It's been my observation that hardly any user is aware of these consquences
nor is the Linux code making a good attempt at complying with all the
additional restrictions of running uncached.  So in my oppinion
CONFIG_MIPS_UNCACHED should go.  But I don't feel very strong about it so
I'm going to wait for a few days so others have a chance to raise their
voice.

  Ralf
