Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 01:15:38 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:15511 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225218AbSLDAPh>;
	Wed, 4 Dec 2002 01:15:37 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18JP4g-0006Ms-00; Tue, 03 Dec 2002 20:15:42 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18JNCd-0002T7-00; Tue, 03 Dec 2002 19:15:47 -0500
Date: Tue, 3 Dec 2002 19:15:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
Message-ID: <20021204001547.GA8012@nevyn.them.org>
References: <20021125102458.B22046@linux-mips.org> <Pine.GSO.3.96.1021125123643.8769B-100000@delta.ds2.pg.gda.pl> <20021125144059.GA23310@nevyn.them.org> <20021125160800.A22590@linux-mips.org> <20021125144059.GA23310@nevyn.them.org> <Pine.GSO.3.96.1021125162225.8769H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125160800.A22590@linux-mips.org> <Pine.GSO.3.96.1021125162225.8769H-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 04:30:13PM +0100, Maciej W. Rozycki wrote:
> On Mon, 25 Nov 2002, Daniel Jacobowitz wrote:
> 
> > >  I think the best use of the watch exception would be making it available
> > > to userland via PTRACE_PEEKUSR and PTRACE_POKEUSR for hardware watchpoint
> > > support (e.g. for gdb).  Hardware support is absolutely necessary for
> > > watching read accesses and much beneficial for write ones (otherwise gdb
> > > single-steps code which sucks performace-wise).
> > 
> > (Although that isn't necessary; page-protection watchpoints are on my
> > TODO for next year.  They aren't quite as efficient as hardware
> > watchpoints but they don't require hardware support either, just an
> > MMU.)
> 
>  As a fallback the approach is just fine, but doesn't is suck
> performance-wise for watchpoints at the stack?  It certainly sucks for
> instruction fetches.  While gdb doesn't seem to use hardware breakpoints
> as they are only really necessary for ROMs, other software may want to
> (well, gdb too, one day). 

Page-protection watchpoints on the stack do bite for performance, yes. 
Most watched variables are not on the stack, though.  People tend to
watch globals.


On Mon, Nov 25, 2002 at 04:08:00PM +0100, Ralf Baechle wrote:
> I assume you got and R4000 manual and the MIPS64 spec.   R4000 implements
> matching a physical address with a granularity of 8 bytes for load and
> store operations.

Not handy.

> MIPS64 extends that to also support instruction address matches; the
> granularity can be set anywhere from 8 bytes to 4kB; in addition ASID
> matching and a global bit can be used for matching.  A MIPS64 CPU can
> support anywhere from 0 to 4 such watch registers.
> 
> The global bit stuff would only be useful for in-kernel use, I think.  The
> ASID thing could be used to implement watchpoints for an entire process, not
> just per thread though I doubt there is much use for something like that.
> 
> So how would a prefered ptrace(2) API for hardware watchpoints look like?

Well, it would be nice to have at least:
  - query total number
  - query the granularity, or at least query whether or not the
    granularity is settable
  - Set and remove watchpoints.

Off the top of my head:
PTRACE_MIPS_WATCHPOINT_INFO
struct mips_watchpoint_info {
  u32 num_avail;
  u32 max_size;
};

PTRACE_MIPS_WATCHPOINT_SET
struct mips_watchpoint_set {
  u32 index;
  u32 size;
  s64 address;
};

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
