Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2003 17:54:50 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41206 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225294AbTHMQys>;
	Wed, 13 Aug 2003 17:54:48 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h7DGskj09878;
	Wed, 13 Aug 2003 09:54:46 -0700
Date: Wed, 13 Aug 2003 09:54:46 -0700
From: Jun Sun <jsun@mvista.com>
To: "Sirotkin, Alexander" <demiurg@ti.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: tasklet latency and system calls on mips
Message-ID: <20030813095446.C9655@mvista.com>
References: <3F3A411C.70603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F3A411C.70603@ti.com>; from demiurg@ti.com on Wed, Aug 13, 2003 at 04:46:04PM +0300
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 13, 2003 at 04:46:04PM +0300, Sirotkin, Alexander wrote:
> Hello dearest all.
> 
> I have a question regarding tasklets on MIPS. I suspect that there is a
> bug in generic MIPS kernel, but I'm not sure yet.
> 
> Linux kernel has a couple of so called "checkpoints" when the system
> should check if there are tasklets to
> run and run them in the following way :
> 
> if (softirq_pending(cpu))
>                     do_softirq();
> 
> One of these places is at the end of interrupt handler (do_IRQ()),
> however this is not the only place. I was under
> impression that this code should be called after system call too. The
> caveat here is that on MIPS (contrary to
> other architectures, such as x86) system call is not an interrupt (it's
> a different exception) and has completely
> different handler. So in x86 it is sufficient to call
> 
> if (softirq_pending(cpu))
>                     do_softirq();
> 
> at the end of do_IRQ because do_IRQ handles system call too, but on MIPS
> it is not. Therefore I believe
> these lines should be added to the end of sys_syscall function on MIPS.
> 
> What do you think ?
> 

softirq/tasklet/bottom_half/etc should only be raised from interrupt
context.  Checking at the end of do_IRQ should be good enough.

One possible mistake in MIPS porting is that if the board uses its private
time interrupt routine poeple may forget to put the above two lines
at the end.  Check against that.

> P.S. The whole issue started when we noticed that user process making
> many system calls has very
> significant impact on device drivers running in tasklet mode 

What kind of impact?  On i386? Or on MIPS?

Jun
