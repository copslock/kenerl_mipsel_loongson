Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 16:51:14 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:2716 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8224847AbSLDPvN>;
	Wed, 4 Dec 2002 16:51:13 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18JdgA-0007je-00; Wed, 04 Dec 2002 11:51:23 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18Jbo8-0004xm-00; Wed, 04 Dec 2002 10:51:28 -0500
Date: Wed, 4 Dec 2002 10:51:28 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021204155128.GA18940@nevyn.them.org>
References: <20021204001547.GA8012@nevyn.them.org> <Pine.GSO.3.96.1021204125557.29982B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021204125557.29982B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 04:45:38PM +0100, Maciej W. Rozycki wrote:
> On Tue, 3 Dec 2002, Daniel Jacobowitz wrote:
> 
> > >  As a fallback the approach is just fine, but doesn't is suck
> > > performance-wise for watchpoints at the stack?  It certainly sucks for
> > > instruction fetches.  While gdb doesn't seem to use hardware breakpoints
> > > as they are only really necessary for ROMs, other software may want to
> > > (well, gdb too, one day). 
> > 
> > Page-protection watchpoints on the stack do bite for performance, yes. 
> > Most watched variables are not on the stack, though.  People tend to
> > watch globals.
> 
>  Well, so far I've almost exclusively watched the stack, sometimes
> malloc()ed areas, to track down out of bound corruption.  It's really
> useful when a program crashes with a SIGSEGV when returning from a
> function call or when calling free() with a legal pointer.  Watching
> globals has not been really useful for me so far -- they are rarely used
> in the first place and you know where they can get modified, so you can
> set ordinary breakpoints in contexts of interest. 

Whereas I'm usually tracking global or heap variables whose value is
getting set to something peculiar.  Interesting.

> 
> > On Mon, Nov 25, 2002 at 04:08:00PM +0100, Ralf Baechle wrote:
> > > I assume you got and R4000 manual and the MIPS64 spec.   R4000 implements
> > > matching a physical address with a granularity of 8 bytes for load and
> > > store operations.
> > 
> > Not handy.
> 
>  Still better than nothing.

Sorry, by "not handy" I meant I didn't have the manuals available :)

>  Userland doesn't need to care of the
> underlying implementation anyway.  You simply have a single watchpoint
> available.  The kernel needs to take care when entering and exiting
> userland.
> 
> > > So how would a prefered ptrace(2) API for hardware watchpoints look like?
> > 
> > Well, it would be nice to have at least:
> >   - query total number
> >   - query the granularity, or at least query whether or not the
> >     granularity is settable
> >   - Set and remove watchpoints.
> > 
> > Off the top of my head:
> > PTRACE_MIPS_WATCHPOINT_INFO
> > struct mips_watchpoint_info {
> >   u32 num_avail;
> >   u32 max_size;
> > };
> 
>  The information may be provided when reading the registers.
> 
> > PTRACE_MIPS_WATCHPOINT_SET
> > struct mips_watchpoint_set {
> >   u32 index;
> >   u32 size;
> >   s64 address;
> > };
> 
>  How about a KISS approach:
> 
> typedef struct {
> 	s64 address;
> 	u64 mask;
> 	u64 access;
> } mips_watchpoint;
> 
> typedef struct {
> 	s32 api_version;
> 	s32 nr_watchpoints;
> 	mips_watchpoint watchpoints[0];
> } mips_watchpoint_set;
> 
> Then PTRACE_MIPS_WATCHPOINT_GET is used to retrieve current settings,
> PTRACE_MIPS_WATCHPOINT_SET is used to alter them.  More details:

>  What do you think?

You don't reveal to userland what size watchpoints are available - i.e.
how large a watchpoint can be.  Does the mask match the hardware
implementation, and what are the restrictions on it?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
