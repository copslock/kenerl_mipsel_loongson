Received:  by oss.sgi.com id <S553814AbRCNU5B>;
	Wed, 14 Mar 2001 12:57:01 -0800
Received: from NEVYN.RES.CMU.EDU ([128.2.145.225]:29608 "EHLO nevyn.them.org")
	by oss.sgi.com with ESMTP id <S553817AbRCNU4q>;
	Wed, 14 Mar 2001 12:56:46 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dIJd-0008Cy-00; Wed, 14 Mar 2001 15:56:17 -0500
Date:   Wed, 14 Mar 2001 15:56:17 -0500
From:   Daniel Jacobowitz <dan@debian.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314155617.A31541@nevyn.them.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010314202058.B1911@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Mar 14, 2001 at 08:20:58PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Mar 14, 2001 at 08:20:58PM +0100, Ralf Baechle wrote:
> On Wed, Mar 14, 2001 at 02:05:29PM -0500, Daniel Jacobowitz wrote:
> 
> > OK, so that needs to change.  That's pretty easy to do, at least in our
> > local toolchains.
> 
> If it's only in your local toolchains, it's lost.  Send your changes to
> the FSF!

Of course.  Let me clarify that statement - it's easy to do in a way
that would be acceptable in our local toolchains, and somewhat harder
to do in a way acceptable to the FSF.

In this case, though, not much harder.  I'm going to try to have a
-mmad patch later today for binutils, and a trivial patch for GCC to
use it instead of -m4650.

> > If it does, I can probably whip up a -mmad patch to binutils to allow
> > those opcodes - or I could introduce -mnevada, or whatever the
> > appropriate term would be, to mean "r8000 with the mad* extensions". 
> > In fact, that would probably be easiest, and sounds like the most
> > correct.
> 
> Don't think of the r8000; the kernel only uses the -mcpu=r8000 option
> because the Nevada CPUs have _somewhat_ similar scheduling properties
> to the R8000.  This of it as an independant ISA expension which can
> be used with an arbitrary MIPS processor - even a R3000 processor.

Oh, I see.  Thanks for the clarification.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"
