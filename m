Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 18:52:08 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33006 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225746AbUE1Rvx>;
	Fri, 28 May 2004 18:51:53 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i4SHppx6020696;
	Fri, 28 May 2004 10:51:51 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i4SHpp0U020694;
	Fri, 28 May 2004 10:51:51 -0700
Date: Fri, 28 May 2004 10:51:51 -0700
From: Jun Sun <jsun@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: 2.4 preempt kernel patch
Message-ID: <20040528105151.G20139@mvista.com>
References: <20040528.131236.112629910.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040528.131236.112629910.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Fri, May 28, 2004 at 01:12:36PM +0900
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, May 28, 2004 at 01:12:36PM +0900, Atsushi Nemoto wrote:
> Hi.  I'm investigating preempt patch for 2.4 kernel.  (MIPS part of
> preempt-kernel-rml-2.4.26-pre5-1.patch seems a bit old.  I'm looking
> Jun Sun's 030304-b.preempt-mips.patch).
> 
> The patch contains following block (end of
> arch/mips/kernel/irq.c:do_IRQ()):
> 
>  
>  	if (softirq_pending(cpu))
>  		do_softirq();
> +
> +#if defined(CONFIG_PREEMPT)
> +	for(;;) {
> +		preempt_enable_no_resched();
> +		if (preempt_is_disabled() || !need_resched())
> +			break;
> +
> +		db_assert(intr_off());
> +		db_assert(!in_interrupt());
> +
> +		preempt_disable();
> +		__sti();
> +		preempt_schedule();
> +		__cli();
> +	}
> +#endif
> +
>  	return 1;
>  }
>  
> 
> Q1.  What is purpose of this block?  (To decrease latency?  But other
> archs (and 2.6 MIPS kernel) do not have block like this...)
> 

This is to check possible preemption at the end of (possibly nested)
interrupt handling.

All other arches and 2.6 MIPS are doing the same thing in .S file
(something like ret_from_irq path)

> Q2.  If an interrupt happened between __sti() and __cli(), and the
> interrupt handler raise softirq, the softirq handler will not be
> called soon (because do_softirq() immediately return if preempt
> disabled).  So we must check softirq_pending again after this block?
> 

do_softirq() does not (and should not) return when preemtpion is disabled.  
We should be fine here.

Jun
