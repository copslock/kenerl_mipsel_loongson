Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 12:34:05 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2993 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122961AbSIMKeE>; Fri, 13 Sep 2002 12:34:04 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA25192;
	Fri, 13 Sep 2002 12:34:22 +0200 (MET DST)
Date: Fri, 13 Sep 2002 12:34:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Matthew Dharm <mdharm@momenco.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: When to #ifdef on CPUs?
In-Reply-To: <00a801c25b05$251ae980$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020913121447.23112B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Sep 2002, Kevin D. Kissell wrote:

> There is a big discontinuity between the R3000 privileged resource 
> model and that of the R4000 and later CPUs. So it would not surprise 
> me if the MIPS/Linux kernel retained some R3000/non-R3000 
> conditional code for a while longer.  Much of rest of what you're 

 Well, code paths may be selected via indirect calls and variable
references.  That may be tedious and require much care when implementing,
but it is doable.

> seeing, particularly in cpu-probe.c, is just slop - expedient hacks 
> that somehow became permanent.  

 A few fixes here is pending on my short-term to-do list.  I'd like to get
rid of #ifdefs here as they are unnecessary.

> But the ambivalence between run-time and build-time binding
> to CPUs probably also reflects the two poles of use of
> MIPS/Linux.  The folks who use it on old SGI and DEC
> workstations have platforms like the SGI Indy where the
> same relatively RAM-rich platform configuration can support 
> a number of different CPUs .  That tends to lead to run-time
> binding of the CPU-specific routines and parameters.
> The folks who use it for embedded apps tend to have
> system and peripheral setups that are anyway pretty 
> application-specific, and since memory isn't entirely free,
> there's no advantage, and some slight disadvantage, 
> in including code to support other CPUs in the OS image.

 I have the Alpha approach in mind.  The idea is to select between a
generic and a system-specific kernel.  With the former there is a vector
of available configurations one of which is selected early in the boot
process.  Items from the vector element chosen are accessed indirectly.
With the latter only a single element of the vector is build and its
contents are accessed directly with the help of some preprocessor magic.

> And there are, alas, cases where the designers screwed up 
> and failed to  provide a correctly unique PrID register value,
> such as is apparently the case with the NEC Vr4111 and
> VR4181.  I'd be willing to bet that there is *some* way to
> distinguish those two parts at run-time if one really wanted
> to, though.

 Well, if the chips differ, which is the case as I infer from what you
wrote, then the difference between them may be used to determine which one
of them a system is being executed on.

> > I mean, heck... it might be nice to put a check to see if the detected
> > CPU matches what the kernel was compiled for...
> 
> If it doesn't, that's a bug.

 No, it's a user fault.  And it's nice to the user to print an appropriate
message and panic() explicitly instead of crashing in an interesting way.
This is currently being done for the R3k vs R4k in the DECstation-specific
code, but it might be beneficial to expand it move it somewhere to the
generic code. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
