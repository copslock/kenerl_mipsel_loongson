Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6BFusRw007174
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 08:56:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6BFusGQ007173
	for linux-mips-outgoing; Thu, 11 Jul 2002 08:56:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f21.dialo.tiscali.de [62.246.18.21])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6BFuhRw007159
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 08:56:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6BBxvJ12000;
	Thu, 11 Jul 2002 13:59:57 +0200
Date: Thu, 11 Jul 2002 13:59:57 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "H. J. Lu" <hjl@lucon.org>, Jun Sun <jsun@mvista.com>,
   linux-mips@oss.sgi.com
Subject: Re: Malta crashes on the latest 2.4 kernel
Message-ID: <20020711135957.A11816@dea.linux-mips.net>
References: <3D2CBF73.50001@mvista.com> <20020710164900.A28911@lucon.org> <20020711043601.B3207@dea.linux-mips.net> <005c01c228a2$fb2bf450$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005c01c228a2$fb2bf450$10eca8c0@grendel>; from kevink@mips.com on Thu, Jul 11, 2002 at 08:19:55AM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.7 required=5.0 tests=IN_REP_TO,PORN_12,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 11, 2002 at 08:19:55AM +0200, Kevin D. Kissell wrote:

> Excuse me, but I've seen this statement used by others in
> the past as an excuse for doing something silly or not doing
> something reasonable, and it generally hasn't washed.
> In what specific cases have the CP0 pipeline hazards 
> changed between minor revisions of any production
> MIPS CPU?  The *documentation* may have been
> corrected, but these hazards are fairly fundamental
> artifacts of the pipeline microarchitecture of a given
> processor.

Ancient TLB exception handler code was assuming out of order execution of
the instruction stream in cp0 based on the documentation in appendix H
of the R4400 manual, version 2.  I wrote that code for a R4400 version 5.0
and it was running fine on R4000 3.0 but somebody found it to break on
R4000 version 2.2.  At least that are the details as I remember them.  I
don't blame MIPS (well, probably SGI at that time ...) for not documenting
these details perfectly right for each and every R4[04]00 implementation.
The code broken was written extremly aggressivly and eventually had to be
changed anyway for the sake of other processors.

> The CP0 hazard between a write of EntryHi
> and a subsequent TLBWI instruction is flagged
> in the MIPS32 spec and noted as being "typically" 
> 2 cycles.  I'm not going to spend the time going
> through my full set of users manuals, but a representative
> sampling shows this hazard as being specified for
> every R4xxx and R5xxx CPU I checked.  The fact
> that a given CPU *may* get away with it is no
> excuse for not protecting common code.

No argument about this one.  We definately were lucky.

> I note that Ralf has, in fact, applied the fix to the
> OSS CVS repository.  I also note that "BARRIER"
> is still defined to be a string of 6 nops.  I would argue
> (again) that those really, really ought to be ssnops,
> and that if they *were* ssnops, one could probably
> have fewer of them.

I've applied it because I think the whole update_mmu_cache implementation
is ready for a reimplementation anyway.  On the performance this isn't
going to have measurable impact anyway as update_mmu_cache is only being
called once per page fault.

BARRIER is defined as 6 nops since it was written somewhen during the summer
'96.  By that time Linux didn't yet support any processor that was featuring
ssnop, so 6 nops certainly were too paranoid.  These days you're certainly
right, ssnops are the way to go, especially because they don't have any
negative impact on pre-ssnop implementations.

  Ralf
