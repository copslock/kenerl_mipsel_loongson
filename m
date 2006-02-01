Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 16:39:38 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:1720 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S3458481AbWBAQjU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 16:39:20 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1F4L5k-0001K6-OF; Wed, 01 Feb 2006 11:44:24 -0500
Date:	Wed, 1 Feb 2006 11:44:24 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Johannes Stezenbach <js@linuxtv.org>, linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Message-ID: <20060201164423.GA4891@nevyn.them.org>
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 31, 2006 at 05:36:13PM +0000, Maciej W. Rozycki wrote:
> On Tue, 31 Jan 2006, Johannes Stezenbach wrote:
> 
> > I think (maybe in error ;-), that all binaries compiled for
> > a 32bit ABI, but a 64bit ISA, have this flag set, as the kernel
> > will refuse to execute 64bt code (i.e. not o32 or n32 ABI). Therefore,
> > shouldn't gdb also evaluate this flag when deciding about the ISA
> > register size?
> 
>  O32 implies 32-bit registers no matter what ISA is specified (while 
> o32/MIPS-III is effectively o32/MIPS-II, o32/MIPS-IV makes a difference), 
> therefore it's a bug.  You should try sending your proposal to 
> <gdb-patches@sources.redhat.com> instead.  But I smell the problem is 
> elsewhere -- mips_isa_regsize() shouldn't be called for the "cooked" 
> registers and these are ones you should only see under Linux or, as a 
> matter of fact, any hosted environment.  See mips_register_type() for a 
> start.

All of this code is flat-out wrong, as far as I'm concerned.  I have a
project underway which will fix it, as a nice side effect.

GDB is trying to do something confusing, but admirable, here.  When
you're running on a 64-bit system the full 64 bits are always there:
even if the binary only uses half of them (is this true in Linux?  I
don't remember if the relevant control bits get fudged, it's been a
while; it's definitely true on some other systems).  Thus it's possible
for a bogus instruction to corrupt the top half of a register, leading
to otherwise inexplicable problems.

So if the remote stub knows about 64-bit registers, it should report
them to GDB, and GDB should accept and display them, and still handle
32-bit frames.  If the remote stub doesn't, then there's no option but
to report the 32-bit registers.

Really, GDB ought to (and soon will I hope) autodetect which ones were
sent.

-- 
Daniel Jacobowitz
CodeSourcery
