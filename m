Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 00:34:34 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:43002 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225310AbTKZAeW>;
	Wed, 26 Nov 2003 00:34:22 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id hAQ0YK601895;
	Tue, 25 Nov 2003 16:34:20 -0800
Date: Tue, 25 Nov 2003 16:34:20 -0800
From: Jun Sun <jsun@mvista.com>
To: "Kapoor, Pankaj" <pkapoor@telogy.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: MIPS Interrupts.
Message-ID: <20031125163420.J28822@mvista.com>
References: <37A3C2F21006D611995100B0D0F9B73C02C8FCAF@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73C02C8FCAF@tnint11.telogy.design.ti.com>; from pkapoor@telogy.com on Tue, Nov 25, 2003 at 07:24:18PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 25, 2003 at 07:24:18PM -0500, Kapoor, Pankaj wrote:
> > The nested interrupt call, do_IRQ(), may still try to call do_softirq()
> but
> > that it will return immediately as it discovers another instance of
> do_softirq()
> > is running.  No further nesting occurs as a result. 
> 
> How is this detected ? Is this the check of "softirq_pending(cpu)" in the
> do_softirq() ?
> 

No.  It is 

        if (in_interrupt())
                return;


> Can we have a case as shown below :
> 
> 1. Interrupt 1 is generated : Jump to general exception handler
> (0x8000:0180)
> 2. Save the current context
> 3. Interrupt 1 is processed which schedules tasklet1 for execution.
> 	softirq_pending(cpu) = TASKLET_SOFTIRQ
> 4. Interrupts are reenabled.
> 5. do_softirq : Tasklet1 is executing & softirq_pending(cpu) = 0.
> 6. -------> Interrupt 2 is generated : Jump to general exception handler
> (0x8000:0180)
> 		6a) Save the current context
> 		6b) Interrupt2 is processed which schedules tasklet2 for
> execution. 
> 			softirq_pending(cpu) = TASKLET_SOFTIRQ
> 		6c) Interrupts are reenabled.
> 		6d) do_softirq : Tasklet2 is executing &
> softirq_pending(cpu) = 0.

Impossible here, due to the above checking code.  Instead,
Tasklet2 will run by 5) once this interrupt trap returns.

Jun
