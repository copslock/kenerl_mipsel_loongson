Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 14:48:28 +0100 (MET)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:45819 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S870424AbSK2NsT>;
	Fri, 29 Nov 2002 14:48:19 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gATDncNf029546;
	Fri, 29 Nov 2002 05:49:38 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA24088;
	Fri, 29 Nov 2002 05:49:37 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gATDnbb22848;
	Fri, 29 Nov 2002 14:49:37 +0100 (MET)
Message-ID: <3DE77071.17FE9FED@mips.com>
Date: Fri, 29 Nov 2002 14:49:37 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
References: <20021128171519.A18165@linux-mips.org> <Pine.GSO.3.96.1021128172026.8D-100000@delta.ds2.pg.gda.pl> <20021129134230.A11704@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Fri, Nov 29, 2002 at 12:56:10PM +0100, Maciej W. Rozycki wrote:
>
> > > We've talked about this before - the specification of the ll/sc
> > > instructions says they only work ok on cached memory.  In the real world
> > > they seem to work also in uncached memory but I'd not bet the farm on
> > > that, too many implementations out there, too many chances for subtle
> > > bugs.
> >
> >  Indeed -- CONFIG_MIPS_UNCACHED should either be removed or imply
> > CONFIG_CPU_HAS_LLSC=n.  I suppose there is some interest in the option, so
> > the latter is preferable.  That would imply moving the option into the CPU
> > configuration section as now it's set very late, long after
> > CONFIG_CPU_HAS_LLSC is set.  Or it could be set up the other way, i.e. the
> > option would only become available if CONFIG_CPU_HAS_LLSC had been set to
> > n.  There would be no need to move it then.
> >
> >  What do you think?
>
> I had the same thought.  So far there are the following groups of people
> using this option:
>
>   - Hardware people using it so the the entire program is becoming visible
>     externally.
>
>     Becoming obsoleted by more advanced, less intrusive hardware debugging
>     methods.
>
>   - Software people kluding around bugs in their software.
>
>     Don't expect me to support this.  Note with a line of code.
>
>   - For testing if the cache code is actually working.
>
>     Will only be useful to show big fat bugs.  For the more subtle bugs
>     there is no way at all around understanding the entire cache managment
>     thing including all subtilities.  Actually a good reason to not support
>     this option either.
>
> It's been my observation that hardly any user is aware of these consquences
> nor is the Linux code making a good attempt at complying with all the
> additional restrictions of running uncached.  So in my oppinion
> CONFIG_MIPS_UNCACHED should go.  But I don't feel very strong about it so
> I'm going to wait for a few days so others have a chance to raise their
> voice.
>

I have used this option a lot, it has been very useful in hardware (CPU)
debugging.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
