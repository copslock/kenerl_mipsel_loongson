Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 16:45:28 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:30166 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224847AbSLDPp1>; Wed, 4 Dec 2002 16:45:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA06825;
	Wed, 4 Dec 2002 16:45:38 +0100 (MET)
Date: Wed, 4 Dec 2002 16:45:38 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: watch exception only for kseg0 addresses..?
In-Reply-To: <20021204001547.GA8012@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1021204125557.29982B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Dec 2002, Daniel Jacobowitz wrote:

> >  As a fallback the approach is just fine, but doesn't is suck
> > performance-wise for watchpoints at the stack?  It certainly sucks for
> > instruction fetches.  While gdb doesn't seem to use hardware breakpoints
> > as they are only really necessary for ROMs, other software may want to
> > (well, gdb too, one day). 
> 
> Page-protection watchpoints on the stack do bite for performance, yes. 
> Most watched variables are not on the stack, though.  People tend to
> watch globals.

 Well, so far I've almost exclusively watched the stack, sometimes
malloc()ed areas, to track down out of bound corruption.  It's really
useful when a program crashes with a SIGSEGV when returning from a
function call or when calling free() with a legal pointer.  Watching
globals has not been really useful for me so far -- they are rarely used
in the first place and you know where they can get modified, so you can
set ordinary breakpoints in contexts of interest. 

> On Mon, Nov 25, 2002 at 04:08:00PM +0100, Ralf Baechle wrote:
> > I assume you got and R4000 manual and the MIPS64 spec.   R4000 implements
> > matching a physical address with a granularity of 8 bytes for load and
> > store operations.
> 
> Not handy.

 Still better than nothing.  Userland doesn't need to care of the
underlying implementation anyway.  You simply have a single watchpoint
available.  The kernel needs to take care when entering and exiting
userland.

> > So how would a prefered ptrace(2) API for hardware watchpoints look like?
> 
> Well, it would be nice to have at least:
>   - query total number
>   - query the granularity, or at least query whether or not the
>     granularity is settable
>   - Set and remove watchpoints.
> 
> Off the top of my head:
> PTRACE_MIPS_WATCHPOINT_INFO
> struct mips_watchpoint_info {
>   u32 num_avail;
>   u32 max_size;
> };

 The information may be provided when reading the registers.

> PTRACE_MIPS_WATCHPOINT_SET
> struct mips_watchpoint_set {
>   u32 index;
>   u32 size;
>   s64 address;
> };

 How about a KISS approach:

typedef struct {
	s64 address;
	u64 mask;
	u64 access;
} mips_watchpoint;

typedef struct {
	s32 api_version;
	s32 nr_watchpoints;
	mips_watchpoint watchpoints[0];
} mips_watchpoint_set;

Then PTRACE_MIPS_WATCHPOINT_GET is used to retrieve current settings,
PTRACE_MIPS_WATCHPOINT_SET is used to alter them.  More details:

PTRACE_MIPS_WATCHPOINT_SET:

Input:

- api_version has to match the version implemented, currently 0,

- nr_watchpoints specifies the number of watchpoint descriptions
  following, >= 0,

- for each watchpoints entry i, (i = 0; i < nr_watchpoints; i++):

  - address specifies the virtual address covered -- properly
    sign-extended for the 32-bit kernel),

  - mask specifies the mask to use against the address -- don't care bits
    set to one,

  - access specifies the access type; currently read, write and exec are
    specified -- we may follow the MIPS32/64 ISA definition.

Output:

- error code: a failure if a protection violation happens when reading
  mips_watchpoint_set, otherwise success.

PTRACE_MIPS_WATCHPOINT_GET:

Input:

- api_version set to the version expected, currently 0, = api_version_i,

- nr_watchpoints specifies the maximum number of watchpoint descriptions
  expected, >= 0, = nr_watchpoints_i

Output:

- error code: a failure if a protection violation happens when writing
  mips_watchpoint_set, otherwise success,

- api_version set to the version supported, currently 0, = api_version_o,

- if (api_version_i == api_version_o):

  - nr_watchpoints set to the number of watchpoints supported, >= 0, =
    nr_watchpoints_o,

  - for each watchpoints entry i, (i = 0; i < min(nr_watchpoints_i,
    nr_watchpoints_o; i++):

    - address set to the value preset for the watchpoint, as obtained
      from hardware,

    - mask set to the value preset for the watchpoint, as obtained from
      hardware,

    - access set to the value preset for the watchpoint, as obtained from
      hardware.

 I think such an interface covers all the functionality we care of now,
including implementation variations (R4000 vs R4650 vs MIPS32/64), and
provides for cheap future expansion.  Additionally thread-global
watchpoints may be handled by adding a bit to the access member if needed. 

 What do you think?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
