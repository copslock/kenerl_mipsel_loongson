Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 10:36:40 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:21467 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122961AbSIRIgj>;
	Wed, 18 Sep 2002 10:36:39 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8I8aVUD009648;
	Wed, 18 Sep 2002 01:36:31 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA25025;
	Wed, 18 Sep 2002 01:36:39 -0700 (PDT)
Message-ID: <003c01c25eee$cfb41c30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>, <jsun@mvista.com>
References: <20020917110423.E17321@mvista.com> <01ad01c25ea4$435ab220$10eca8c0@grendel> <20020917164520.P17321@mvista.com>
Subject: Re: [RFC] FPU context switch
Date: Wed, 18 Sep 2002 10:38:38 +0200
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
X-archive-position: 230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Jun Sun" <jsun@mvista.com>
> On Wed, Sep 18, 2002 at 01:44:57AM +0200, Kevin D. Kissell wrote:
> > 
> > I'd much prefer something that is simple and processor-local,
> > even if it may be less optimal in some corner cases.  For example,
> > Why not simply use CP0.Status.CU1 as a "dirty" bit?  If it's set 
> > when a process switches out, the FPU state gets saved, and CU1 
> > cleared.  If it's not set when a process hits an FP instruction, 
> > CU1 gets set and the context gets loaded. This involves no 
> > access whatever to shared control variables, indeed, it doesn't 
> > even go to memory to make the decision. It will, of course, save 
> > some FP contexts that don't need saving, but it is well behaved
> > in the cases I care most about - it avoids saving/restoring FPRs
> > of code that is doing no FP whatsoever, and it ensures that
> > whenever a thread starts up, whatever CPU its on, its full
> > context is available to that CPU, no (coherent) questions asked.
> > 
> 
> This is basically 2) except for dirty bit difference.
> 
> My current implementaion uses bit:1 in task->used_math flag for 
> "dirty" bit purpose.

Which is not a property of the CPU, but of the thread,
meaning that it will be written by one CPU and read by
another, i.e. there will be MP memory traffic and cache
interventions/invalidations/misses around the operation.

            Kevin K.
