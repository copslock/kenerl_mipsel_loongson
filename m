Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 19:10:07 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:54005 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122961AbSIRRKH>;
	Wed, 18 Sep 2002 19:10:07 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8IGvUM28498;
	Wed, 18 Sep 2002 09:57:30 -0700
Date: Wed, 18 Sep 2002 09:57:30 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [jsun@mvista.com: Re: [RFC] FPU context switch]
Message-ID: <20020918095730.U17321@mvista.com>
References: <20020917160425.O17321@mvista.com> <01b801c25ea7$ce074ed0$10eca8c0@grendel> <20020917171434.Q17321@mvista.com> <004101c25eef$ba035350$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004101c25eef$ba035350$10eca8c0@grendel>; from kevink@mips.com on Wed, Sep 18, 2002 at 10:45:08AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 10:45:08AM +0200, Kevin D. Kissell wrote:
> From: "Jun Sun" <jsun@mvista.com>
> > On Wed, Sep 18, 2002 at 02:10:17AM +0200, Kevin D. Kissell wrote:
> > > Are you able to test this stuff on a proper SMP
> > > system, by the way?  The efficiency of the code 
> > > that manipulates interprocessor control variables 
> > > can reasonably be expected to drop off a bit
> > > in a system with MP cache invalidations blasting
> > > left and right. 
> > 
> > Yes.  I understand this effect.  Solution 1), 2) 
> > and 3) don't really suffer from this problem because
> > variables tested & manipulated are local - unless the 
> > process migrates which is a different problem.
> 
> It's not a "different problem", 

Process migration causeing inter-processor memory access traffic
(which should be one-time) belongs to scheduling issue.  It is
a different problem.

> it's the heart of the
> problem.  If we weren't worried about SMP
> behavior, we wouldn't be revisiting this stuff.
> While (1) can obviously be done without any
> global knowledge, as could something (2)-like 
> based on CPU-local state such as Status.CU1, 
> (2), (3) and (4), as you describe them, all depend 
> to some degree on shared multiprocessor variables 
> to determine whether to save or restore FP state.
>

1), 2), 3) do not depend on global variables with shared
access from multiple cpus.  Please read again.

Please note variables of "current" process do not cause 
inter-processor traffic and thus not belong to this category.

Jun
