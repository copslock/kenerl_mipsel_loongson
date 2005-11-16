Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 18:40:20 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:3858 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134075AbVKPSkB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 18:40:01 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAGIg2Ui022985;
	Wed, 16 Nov 2005 18:42:02 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAGIg1Yo022984;
	Wed, 16 Nov 2005 18:42:01 GMT
Date:	Wed, 16 Nov 2005 18:42:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
Message-ID: <20051116184201.GJ3229@linux-mips.org>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 17, 2005 at 01:19:06AM +0900, Atsushi Nemoto wrote:

> Looking at recent change in cpu_idle(), I find an another potential
> problem with cpu_wait (WAIT instruction).
> 
>     48	ATTRIB_NORET void cpu_idle(void)
>     49	{
>     50		/* endless idle loop with no priority at all */
>     51		while (1) {
>     52			while (!need_resched())
>     53				if (cpu_wait)
>     54					(*cpu_wait)();
>     55			preempt_enable_no_resched();
>     56			schedule();
>     57			preempt_disable();
>     58		}
>     59	}
> 
> If an interrupt raised on line 53 and the interrupt handler woke a
> sleeping thread up, the thread becomes runnable and current thread
> (idle thread) is marked as NEED_RESCHED.
> 
> Since preemption is disabled, the interrupt handler just return to
> current thread (idle thread) without rescheduling.  The idle thread
> then call cpu_wait() and execute WAIT instruction (or something
> similer).  The CPU will stops until next interrupt.  Then the idle
> task checks need_resched() and finally calls schedule().  Therefore,
> wakeup-resume latency will be nearly one TICK on worst case!

Pleassure.

> If this analysis was correct, how to fix this?
> 
> Removing above preempt_enable_no_resched/preempt_disable pair would
> fix it for preemptive kernel, but no point for non-preemptive kernel.
> Replacing them with local_irq_enable/local_irq_disable would fix it
> for both kernel, but there is an question:

Somebody sneaking those lines into kernel.org ...

> 	The CPU can surely exit from the WAIT instruction by interrupt
> 	even if interrupts disabled?

That's implementation dependent behaviour, unfortunately.

  Ralf
