Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id NAA96308 for <linux-archive@neteng.engr.sgi.com>; Wed, 11 Feb 1998 13:00:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA17747 for linux-list; Wed, 11 Feb 1998 12:57:50 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA17716 for <linux@engr.sgi.com>; Wed, 11 Feb 1998 12:57:44 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA00124
	for <linux@engr.sgi.com>; Wed, 11 Feb 1998 12:57:43 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA08298
	for <linux@engr.sgi.com>; Wed, 11 Feb 1998 21:57:42 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA10785;
	Wed, 11 Feb 1998 21:53:59 +0100
Message-ID: <19980211215359.48251@uni-koblenz.de>
Date: Wed, 11 Feb 1998 21:53:59 +0100
To: Nat Friedman <ndf@ALEPH1.MIT.EDU>
Cc: linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: PPro: Global flag in page table
References: <199802112027.PAA07668@ALEPH1.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199802112027.PAA07668@ALEPH1.MIT.EDU>; from Nat Friedman on Wed, Feb 11, 1998 at 03:27:50PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 11, 1998 at 03:27:50PM -0500, Nat Friedman wrote:

> I was just reading through some Intel docs and noticed that the Pentium Pro
> introduced a Global flag for for page table and page directory entries.  When
> this flag is set on an entry, and the PGE (Page Global Enable) flag is set
> in register CR4, the entry is not invalidated in the TLB on a task switch.
> My understanding of this is crude, so be gentle if I've misunderstood, but
> I don't think that this is implemented for Linux and was wondering if the
> benefits warranted implementing it.
> 
> Miguel tells me that a similar tactic is implemented in the MIPS port - it 
> might be nice for PPro to have it too.

No, we don't use that feature on MIPS.  It could be used for the
pagetables for kernel virtual memory - but we currently don't use it,
mainly because it would make flushing the TLB more complex because would
have to examine every entry before we might flush it.  Basically it would
be a tradeoff between the costs of an increased number page faults for
pagetable entries for kernel virtual memory and the increased costs for
a more complex TLB flush routine.  I haven't done detailed profiling on
that but my stomach says that trying to avoid the added complexity by
using the global bit is actually making things faster.  I suppose this
would be different on the PPro.

There is another strategy which the MIPS port is using to avoid the cost
of having to flush and possibly reload the TLB entries on MIPS.  On MIPS
each TLB entry has an additional 6 bit (R2000, R3000 series) / 8 bit
(R4000 and up) field that contains something called process id / address
space identifier.  That field basicaly allows to tag TLB entries such
that there is in most cases no need to flush the entire TLB on context
switches.

With respect to the global bit in TLB entries this means that we may
have multiple entries for the same kernel virtual address in the TLB,
just with a different PID / ASID tag.

(PID / ASID is the same thing; it's just a different naming for the 32 bit
and 64 bit implementations of the MIPS architecture)

A feature we do use on MIPS is the KSEG0.  KSEG0 ("Kernel SEGment 0") is
an area in the virtual address space at 0x80000000 of 512mb size which is
1:1 mapped to physical addresses from 0 upwards.  KSEG0 is probably best
compared with the transparent translation registers of the 68030 with the
big difference that it cannot be disabled and the only thing that can be
configured for KSEG0 is the caching mode the CPU uses to access the main
memory.  KSEG0 is actually a nice win because the topic of TLB faults for
kernel memory is non-issue on MIPS.

  Ralf
