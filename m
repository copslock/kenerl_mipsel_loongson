Received:  by oss.sgi.com id <S553797AbRCNTGK>;
	Wed, 14 Mar 2001 11:06:10 -0800
Received: from NEVYN.RES.CMU.EDU ([128.2.145.225]:20647 "EHLO nevyn.them.org")
	by oss.sgi.com with ESMTP id <S553793AbRCNTF6>;
	Wed, 14 Mar 2001 11:05:58 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dGaP-0007gy-00; Wed, 14 Mar 2001 14:05:29 -0500
Date:   Wed, 14 Mar 2001 14:05:29 -0500
From:   Daniel Jacobowitz <dan@debian.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Message-ID: <20010314140529.A29525@nevyn.them.org>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010314195919.A1911@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Mar 14, 2001 at 07:59:19PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Mar 14, 2001 at 07:59:19PM +0100, Ralf Baechle wrote:
> On Wed, Mar 14, 2001 at 08:46:33AM -0500, Daniel Jacobowitz wrote:
> 
> > I've been trying for a couple of days now to build a MIPS kernel with
> > CONFIG_CPU_NEVADA, and I can't get it to work.  r4k_switch.S produces a
> > pile of "opcode not supported by processor" errors.
> 
> Known and unsolved problem.

> >         cfc1    tmp,  fcr31;                    \
> >         sdc1    $f0,  (THREAD_FPU + 0x000)(thread); \
> >         sdc1    $f2,  (THREAD_FPU + 0x010)(thread); \
> > 
> > 
> > The sdc1 instruction in binutils is flagged like this:
> >       if (mips_cpu == CPU_R4650)
> >         {
> >           as_bad (_("opcode not supported on this processor"));
> >           return;
> >         }
> > 
> > And the IVR sets CONFIG_CPU_NEVADA, which produces
> > ifdef CONFIG_CPU_NEVADA
> > GCCFLAGS        += -mcpu=r8000 -mips2 -Wa,--trap -mmad
> > endif
> > 
> > and -mmad becomes -m4650 to the assembler.
> 
> Which is pretty much bs because mmad may have been introduced with the
> R4640 / R4650 but isn't only available on this processor.  From an ISA
> view it's a processor specific extension and as such it should be
> controlled by a separate option.  Gcc has -mmad which is fine but passing
> it on to as as -m4650 is borken.

OK, so that needs to change.  That's pretty easy to do, at least in our
local toolchains.

> > I worked back in time in gcc, binutils, and kernel sources and I
> > couldn't figure out what's changed - I'm sure this worked at some
> > point.
> 
> You'll have to go back far in time.  I introduced the use of -mmad for
> Nevada-class CPUs in late summor '97.
> 
> As a second bug which makes this one even more annoying something like
> 
> 	.set	mips3
> 	sdc1    $f2, (a0)
> 	.set	mips0
> 
> also doesn't work - the assembler will still throw an "opcode not supported
> on this processor" message.  After all MIPS III means double precission fp.
> And passing additional assembler options with -Wa,foo doesn't help either
> in this case so without the necessary gcc / assembler changes this
> optimization is lost for now.

Does -mmad make a sufficient difference on these processors to bother
fixing it?

If it does, I can probably whip up a -mmad patch to binutils to allow
those opcodes - or I could introduce -mnevada, or whatever the
appropriate term would be, to mean "r8000 with the mad* extensions". 
In fact, that would probably be easiest, and sounds like the most
correct.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"
