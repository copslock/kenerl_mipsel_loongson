Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 19:06:24 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:19698 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122961AbSIRRGY>;
	Wed, 18 Sep 2002 19:06:24 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8IGrkx28492;
	Wed, 18 Sep 2002 09:53:46 -0700
Date: Wed, 18 Sep 2002 09:53:46 -0700
From: Jun Sun <jsun@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] FPU context switch
Message-ID: <20020918095346.T17321@mvista.com>
References: <20020917110423.E17321@mvista.com> <01ad01c25ea4$435ab220$10eca8c0@grendel> <20020917164520.P17321@mvista.com> <003c01c25eee$cfb41c30$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003c01c25eee$cfb41c30$10eca8c0@grendel>; from kevink@mips.com on Wed, Sep 18, 2002 at 10:38:38AM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 10:38:38AM +0200, Kevin D. Kissell wrote:
> From: "Jun Sun" <jsun@mvista.com>
> > On Wed, Sep 18, 2002 at 01:44:57AM +0200, Kevin D. Kissell wrote:
> > > 
> > > I'd much prefer something that is simple and processor-local,
> > > even if it may be less optimal in some corner cases.  For example,
> > > Why not simply use CP0.Status.CU1 as a "dirty" bit?  If it's set 
> > > when a process switches out, the FPU state gets saved, and CU1 
> > > cleared.  If it's not set when a process hits an FP instruction, 
> > > CU1 gets set and the context gets loaded. This involves no 
> > > access whatever to shared control variables, indeed, it doesn't 
> > > even go to memory to make the decision. It will, of course, save 
> > > some FP contexts that don't need saving, but it is well behaved
> > > in the cases I care most about - it avoids saving/restoring FPRs
> > > of code that is doing no FP whatsoever, and it ensures that
> > > whenever a thread starts up, whatever CPU its on, its full
> > > context is available to that CPU, no (coherent) questions asked.
> > > 
> > 
> > This is basically 2) except for dirty bit difference.
> > 
> > My current implementaion uses bit:1 in task->used_math flag for 
> > "dirty" bit purpose.
> 
> Which is not a property of the CPU, but of the thread,
> meaning that it will be written by one CPU and read by
> another, i.e. there will be MP memory traffic and cache
> interventions/invalidations/misses around the operation.
>

In all places the task is "current" process.  Therefore no inter-processor
traffic.

Obiviously it is still less desriable than a bit in cpu regiters....

Jun
