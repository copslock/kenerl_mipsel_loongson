Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2010 19:28:25 +0200 (CEST)
Received: from gateway07.websitewelcome.com ([69.41.242.21]:49359 "HELO
        gateway07.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491807Ab0EZR2S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 May 2010 19:28:18 +0200
Received: (qmail 8783 invoked from network); 26 May 2010 17:31:58 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway07.websitewelcome.com with SMTP; 26 May 2010 17:31:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Vm0t1378OMWxsPQM1fuQfCp+AL44gv1lXjVGrdS0TYtUix2oOCQHP+UYTqmyf48ErG+bz4DbY/GFDscn4iEUMBV2livrpfpjIHbT/aRJtqjMOLQxbV2KduxYTnZwRjGK;
Received: from 216-239-45-4.google.com ([216.239.45.4]:40839 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OHKOV-0004LU-QG; Wed, 26 May 2010 12:27:51 -0500
Message-ID: <4BFD5A19.5030602@paralogos.com>
Date:   Wed, 26 May 2010 10:27:53 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Julia Lawall <julia@diku.dk>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Affinity Automation (was Re: [PATCH 3/17] arch/mips/kernel: Add missing
 read_unlock)
References: <Pine.LNX.4.64.1005261754390.23743@ask.diku.dk> <20100526163227.GA17043@linux-mips.org>
In-Reply-To: <20100526163227.GA17043@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Your patch appears correct - and mipsmt_sys_sched_setaffinity() even
> more broken than you thought.  It duplicates some code from kernel/sched.c
> and has gotten out of sync.
Yeah, that was inevitable.  Since the distribution of the previous 
message seems to cover concerned developers outside the MIPS community, 
let me make one final(?) plea to actually do this right.

The MIPS SMTC support for managing a single FPU context on a processor 
with multiple integer TC contexts involves having the system make 
automous, real time, decisions about scheduling affinity.  It may be a 
first, but it can't possibly be the only case, especially as we've 
started seeing more and more mainstream multi-core, multi-thread 
designs.  System and chip resources are going to be "closer" to one 
processor or another.  The current Linux paradigm is that it's the 
responsibility of programs, or users, to know what the optimal placement 
of processes should be for a given system platform, and while it's 
absolutely appropriate to provide that level of control for the cases 
where the user really does know best, it's mildly insane to make that 
the only way that thread placement can be optimized.  It's really the 
OS's job to match demand to resources.

My contention years ago was, and remains, that it would be a bad idea to 
burden the main scheduler loop with checks for two different levels of 
affinity, system-automatic and user-specified.  It would add 
non-trivially to the cache footprint and execution overhead of thread 
dispatch, and there's no logical need for it.  So the model I proposed, 
and implemented in the cloned affinity system calls for SMTC, was that a 
*single* affinity mask continue to be used by the scheduler, but that 
the per-thread data structures carry two:  The one requested explicitly 
by the user, and the one actually used by the scheduler.  The idea is 
that normally those two are the same, but that the system - in the MIPS 
SMTC case, the FPU emulator - can overlay its constraints with the 
user's constraints to come up with an intersection-of-sets constraint 
that satisfies both (there was a clause which prevents system affinity 
heuristics from restricting the affinity mask to a null set of CPUs, 
though of course the user can do that if he really wants to).

There's nothing particularly MIPS-specific about the problem or the 
solution.  Most of the mechanisms should really be in 
platform-independent code, so we don't get the drift of cloned components.

I don't recall who owned the scheduler at the time, but whoever it was 
was too busy dealing with mainstream processor problems to even engage 
in a dialogue about this.  Is it time to raise the question again?

          Regards,

          Kevin K.
