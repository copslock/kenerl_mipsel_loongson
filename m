Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 22:27:10 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:16894 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224987AbUAUW1B>;
	Wed, 21 Jan 2004 22:27:01 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0LMQvl30699;
	Wed, 21 Jan 2004 14:26:57 -0800
Date: Wed, 21 Jan 2004 14:26:57 -0800
From: Jun Sun <jsun@mvista.com>
To: David Daney <ddaney@avtrex.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Haley <aph@redhat.com>,
	Andreas Tobler <toa@pop.agri.ch>,
	Geoffrey Keating <geoffk@apple.com>,
	gcc-patches <gcc-patches@gcc.gnu.org>,
	Andrew Pinski <pinskia@physics.uc.edu>,
	Eric Christopher <echristo@redhat.com>,
	Richard Henderson <rth@redhat.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [RFC]: MD_FALLBACK_FRAME_STATE_FOR macro for darwin PPC
Message-ID: <20040121142657.B29705@mvista.com>
References: <400D9173.7010508@pop.agri.ch> <7809AEC4-4B8A-11D8-83EB-000A95B1F520@apple.com> <400E3C5C.3060001@pop.agri.ch> <400EC5B4.6020402@avtrex.com> <400ED0D9.20704@pop.agri.ch> <400ED4DE.6080601@avtrex.com> <16398.55568.933882.591110@cuddles.cambridge.redhat.com> <400EDC24.3080309@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <400EDC24.3080309@avtrex.com>; from ddaney@avtrex.com on Wed, Jan 21, 2004 at 12:08:04PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 12:08:04PM -0800, David Daney wrote:
> Andrew Haley wrote:
> 
> >David Daney writes:
> > > Andreas Tobler wrote:
> > > 
> > > > David Daney wrote:
> > > >
> > > >
> > > >> I know next to nothing about PPC ABIs, but are any of these floating 
> > > >> point registers?
> > > >
> > > >
> > > > There are, yes.
> > > >
> > > >> Are there any call saved FP registers in this ABI? and if so are you 
> > > >> restoring them.  Although I don't think that the unwinder uses 
> > > >> floating point, it seems that restoring call saved FP registers is a 
> > > >> good idea if you are not already doing it.
> > > >
> > > >
> > > > Well, here I expect the advise from the experts, I have floats around 
> > > > and I may try to restore them.
> > > >
> > > > But, I need some guidance here.
> > > 
> > > When I did the MD_FALLBACK_FRAME_STATE_FOR for mips/linux I did not 
> > > handle floating point either as the problem did not occur to me until 
> > > after I checked in the code.
> > > 
> > > However after thinking about it and posting:
> > > 
> > > http://gcc.gnu.org/ml/gcc/2003-10/msg00972.html
> > > 
> > > I learned that this is a real issue.
> > > 
> > > I may be about ready to do some more mips/linux work soon and may 
> > > revisit MD_FALLBACK_FRAME_STATE_FOR.  Because in its current state it 
> > > seems to be incomplete.
> >
> >You only need to restore what has been saved.  Looking at
> >/usr/src/linux-2.4/arch/mips/kernel/signal.c, it seems that there is a
> >call to save_fp_context().  However, this is only executed if
> >(current->used_math) is set; you mustn't restore any fp registers if
> >the process hasn't saved the fp state.
> >
> >There is a field called sc_used_math in the sigcontext struct.  I
> >think this tells you what you need to know.  But I am not a kernel
> >hacker...
> >
> >Andrew.
> >  
> >
> Ralf,
> 
> Is this all true?
> 
> Perhaps you could shed some light on what really needs to be done in the 
> MIPS/linux case.
> 
> Also what should be done in the case of mips 4Kc core where there is 
> only software floating point?
> 

I wrote those code.  Here are some bits which might be helpful.

. If a CPU does not a hw FPU, a software emulator is used.  A bunch of 
  functions defined in asm-mips/fpu.h attempts to abstract away the difference
  between a CPU with hw fpu or not.

. Regarding FPU status, a process in one of the three states (when not in 
  signal handling context)
	a. have not used FPU yet (current->used_math == 0)
	b. have used FPU but not the current hw FPU owner 
	c. have use FPU and is the current hw FPU owner

  (in the case of emulated FPU case, there is no FPU ownder at any time)

. When setting a signal frame, we treat those three cases differently:

	for case a), do nothing (no saving or what so ever)
	for case b), current replaces current FPU owner (which implies
 		possible FPU saving of current owner and restoring FPU
		registers from current thread structure to FPU hw)
		And then we save FPU registers into signal context.
	for case c), we save FPU registers into signal context.

. When returning from signal handling, 
	for case a), we forciably loose CPU (even if sig handler has used it)
	for case b) and c) we become the FPU owner (i.e., restoring FPU
		registers from signal context area)

Jun
