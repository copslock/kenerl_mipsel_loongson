Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 00:03:25 +0200 (CEST)
Received: from p508B5F13.dip.t-dialin.net ([80.139.95.19]:16521 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSIBWDY>; Tue, 3 Sep 2002 00:03:24 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82M3DN23514;
	Tue, 3 Sep 2002 00:03:13 +0200
Date: Tue, 3 Sep 2002 00:03:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: PATCH: linux_2_4: add support for the Ocelot-G board
Message-ID: <20020903000313.A23265@linux-mips.org>
References: <NEBBLJGMNKKEEMNLHGAIKEJOCIAA.mdharm@momenco.com> <20020902190038.F15618@linux-mips.org> <20020902123850.A28171@momenco.com> <20020902224615.A17378@linux-mips.org> <20020902134053.A28347@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902134053.A28347@momenco.com>; from mdharm@momenco.com on Mon, Sep 02, 2002 at 01:40:53PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 02, 2002 at 01:40:53PM -0700, Matthew Dharm wrote:

> Hrm... okay... first question, where do I get the 64-bit toolchain?  Right
> now, I'm using HJ's toolchain RPMs (from over a year ago -- I should update
> those).

ftp.linux-mips.org:/pub/linux/mips/crossdev/.

> Second, what about all those nifty extras?  Things like the fact that
> kseg0/1 (well, their 64-bit equivalents) are now larger (how big are they,
> anyway)

Giant.  The entire XKPHYS space has a size of 60 Exabyte.  Three bits of
the address specify one of the caching modes.  That leaves punny 59 bits
or 512 Petabyte for each of these segments.  And simply because that's
still a shitload for most applications (unless you want to mmap a decent
sized disk array or so ...) most MIPS implementations actually only use
a fraction of this space; 1TB is typical but the R10000 family actually
supports 16TB and I guess another extension will be due soon ...

> so they can map all of my SDRAM as well as most (all?) of my
> I/O space... I guess for that I need to reprogram all my address decoders,
> and then that sort of thing must be what the arch/mips64/* stuff is for.

I've actually eleminated all board support code from arch/mips64.

The way Ocelot support was done for 32-bit kernel was mapping all RAM
contiguously starting from address 0.  That will be the right thing for
64-bit as well.  Just all the highmem crap goes away and the ioremap code
becomes a trivial 1:1 mapping.

> Yes? No?  Or am I smoking something too strong again?

As long as you don't inhale ;-)

> The 64/32 mixed-mode linux is certainly of some interest to our customers,
> but full 64-bit is really where the demand is.  Is there anything that a
> non-compiler guy can do to help the effort along?

The lion part of the effort will be the toolchain for this round.  Once
that part is done we'll have to port libc at which point rebuilding code as
N32 or N64 should have become trivial.

  Ralf
