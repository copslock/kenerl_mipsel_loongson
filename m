Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jun 2010 20:16:40 +0200 (CEST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:52246 "EHLO
        sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492317Ab0F3SQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jun 2010 20:16:35 +0200
Authentication-Results: sj-iport-2.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAI8mK0yrRN+K/2dsb2JhbACfU3GmOpo1hSUEg2w
X-IronPort-AV: E=Sophos;i="4.53,514,1272844800"; 
   d="scan'208";a="264900913"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-2.cisco.com with ESMTP; 30 Jun 2010 18:16:27 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id o5UIGQWN006014;
        Wed, 30 Jun 2010 18:16:26 GMT
Date:   Wed, 30 Jun 2010 11:16:27 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Phil Staub <phils@windriver.com>
Cc:     Adam Jiang <jiang.adam@gmail.com>, linux-mips@linux-mips.org
Subject: Re: How to detect STACKOVEFLOW on mips
Message-ID: <20100630181627.GB20597@dvomlehn-lnx2.corp.sa.net>
References: <AANLkTimL7YMyb2ahmTgl8dqV_DNfsROjDhLEDm4jyVWE@mail.gmail.com> <4C2B543E.2010309@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C2B543E.2010309@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 27284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                
X-UID: 20458

On Wed, Jun 30, 2010 at 09:27:10AM -0500, Phil Staub wrote:
> On 06/29/2010 10:59 PM, Adam Jiang wrote:
> > Hello, list.
> >
> > I'm having a problem with kernel mode stack on my box. It seems that
> > STACKOVERFLOW happened to Linux kernel. However, I can't prove it
> > because the lack of any detection in __do_IRQ() function just like on
> > the other architectures. If you know something about, please help me
> > on following two questions.
> > - Is there any possible to do this on MIPS?
> 
> The mechanisms I know about for detecting stack overflow include:
> 
> 1. Use of the MMU - stack ends at a page boundary, adjacent page is
> either unmapped or mapped read-only and causes an exception if violated.

Kernel stacks are allocated in kseg0, which is direct mapped. This means
conversions from virtual to physical addresses don't use the TLBs, so
this strategy doesn't work on MIPS.

> 2. Hooks inserted into toolchain to cause any stack decrement to be
> first tested against a limit.

I don't know of MIPS hooks for this but there may be some. It would have
to be tuned specifically for the kernel because of the way you need to get
the stack bounds (see below).

> 3. Fill entire stack with a recognizable pattern before first
> use. After suspected stack overflow, check to see if the pattern has
> been disturbed in the area of the stack limit.

This one pretty much always works. The only exception is if you allocate
a big array on the stack and don't use enough of it to alter memory in
the area at which you are looking.  Allocating big arrays on the stack
is a kernel no-no, so you should be in good shape here.

To implement this, you have to know the stack bounds. Start by getting
getting current_thread_info(), which is a pointer to a struct
thread_info. The struct thread_info is at the low address part of the
memory allocated for a task stack, which is given by union thread_union.
So, you can cast current_thread_info to a union thread_union* and put
the result in, say, p. Then the valid stack space is from
(char*)(&p->thread_info + 1) to ((char *)p + THREAD_SIZE/sizeof(long)).

> (Disclaimer: I've used all of these in some form on other OSes, but
> not on Linux. Someone else may have a more directly relevant answer.)
> 
> > - or, more simple question, how could I get the address $sp pointed by
> > asm() notation in C?
> 
> How about something like:
> 
> {
> 	long x;
> 	...
> 	asm("move %0,$29":"=g"(x));
> 	...
> }

Depending on the version of gcc you are using, you should also be able
to use __builtin_frame_address(), though I haven't tried this in the kernel.

> Phil
> 
> > Best regards,
> > /Adam

-- 
David VL
