Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 12:49:53 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:42999 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSIMKtw>;
	Fri, 13 Sep 2002 12:49:52 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8DAnhUD022386;
	Fri, 13 Sep 2002 03:49:43 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA14637;
	Fri, 13 Sep 2002 03:49:48 -0700 (PDT)
Message-ID: <00ca01c25b13$92c7f780$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Matthew Dharm" <mdharm@momenco.com>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
References: <NEBBLJGMNKKEEMNLHGAIMEPBCIAA.mdharm@momenco.com>
Subject: Re: When to #ifdef on CPUs?
Date: Fri, 13 Sep 2002 12:51:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Matthew Dharm" <mdharm@momenco.com>
> I'm basically done with my task of porting linux to our SR71000-based
> board.  I'm getting ready to start feeding patches to Ralf, and
> something occured to me....
> 
> Sometimes, in some places, we use CONFIG_ options to select the
> apropriate CPU.  Other places, we probe for the CPU based on the PRID
> register.
> 
> In some places, the reason for the choice is clear -- it's just much
> easier to select the cache library based on a CONFIG_ option in a
> Makefile than trying to do run-time assignment of many function
> pointers.
> 
> However, is some places, the choice is not clear.  In cpu-probe.c, for
> example, several of the CPU identification routines are wrapped in
> #ifdef's -- odd, since the wrong 'case' of the switch statements
> should never get executed, even if compiled in....

There is a big discontinuity between the R3000 privileged resource 
model and that of the R4000 and later CPUs. So it would not surprise 
me if the MIPS/Linux kernel retained some R3000/non-R3000 
conditional code for a while longer.  Much of rest of what you're 
seeing, particularly in cpu-probe.c, is just slop - expedient hacks 
that somehow became permanent.  

But the ambivalence between run-time and build-time binding
to CPUs probably also reflects the two poles of use of
MIPS/Linux.  The folks who use it on old SGI and DEC
workstations have platforms like the SGI Indy where the
same relatively RAM-rich platform configuration can support 
a number of different CPUs .  That tends to lead to run-time
binding of the CPU-specific routines and parameters.
The folks who use it for embedded apps tend to have
system and peripheral setups that are anyway pretty 
application-specific, and since memory isn't entirely free,
there's no advantage, and some slight disadvantage, 
in including code to support other CPUs in the OS image.
So we have an environment where boot-time CPU
binding works OK across the set of CPUs used in
Indys, and not necessarily for others.

And there are, alas, cases where the designers failed 
to  provide a correctly unique PrID register value, such 
as is apparently the case with the NEC Vr4111 and VR4181.  
I'd be willing to bet that there is *some* way to distinguish 
those two parts at run-time if one really wanted to, though.

> So, what's the rule here?  When do I used #ifdef and when do I just
> let the PRID stuff work it's magic?

I don't know that there's a rule as such, but I would strongly
recommend using the PrID and Config registers to generate a 
kernel CPU ID and a set of mips_cpu.options bits, and that
information abstracted into the mips_cpu structure should be
used in preference to comparing against CPU ID's.  It may
require a little more thought up-front, but it leaves the rest
of the code a lot easier to maintain.  You should have seen
what the kernel looked like before we introduced the
mips_cpu structure!

Fortunately, the standardization of the privileged resource 
architecture in the MIPS32 and MIPS64 specs means that
the problem shouldn't get much worse - newer parts should
just work with a MIPS32 kernel.

> I mean, heck... it might be nice to put a check to see if the detected
> CPU matches what the kernel was compiled for...

If it doesn't, that's a bug.

            Kevin K.
