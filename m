Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7L82nX13184
	for linux-mips-outgoing; Tue, 21 Aug 2001 01:02:49 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7L82k913181
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 01:02:46 -0700
Received: from dea.linux-mips.net (u-32-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.32]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA00081
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 01:01:17 -0700 (PDT)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7L6rrf13491;
	Tue, 21 Aug 2001 08:53:53 +0200
Date: Tue, 21 Aug 2001 08:53:53 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: questions about some bits of STATUS register and exception priority...
Message-ID: <20010821085353.B13302@dea.linux-mips.net>
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001901c129e1$5aaaadc0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001901c129e1$5aaaadc0$8021690a@huawei.com>; from dony.he@huawei.com on Tue, Aug 21, 2001 at 09:34:00AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 21, 2001 at 09:34:00AM +0800, machael thailer wrote:

>     I am confused about CU0 and UM(ERL EXL) bit of STATUS register.
> 
>     The user manual says that " CP0 is always usable when in Kernel mode,
> regardless of the setting of CU0 bit". Does it mean that when in Kernel mode
> , the CU0 bit is always 1 and in User mode, the CU0 bit is 0? If the CU0 is
> 0, can we be sure that it is in User mode?

In the Linux kernel CU0 is used to indicate that we're running on the
kernel stack.

>      If a user program is running in User mode, an interrupt happens at this
> time(or an error occurs), then it will switch to Kernel mode to run the
> interrupt handler(or the error exception handler). We know that the EXL(or
> ERL) bit of Status register will be set to 1 by hardware. What about the UM
> bit of Status? Does it remain unchangeable or change to 1 too? The user
> manual doesn't say anything about it.

The hardware does not change UM (r4k: KSU bits).

> Another question about exception priority:
> In entry.S, some exception handlers enables global interrupt bit(IE) but
> others disables it.

We have to avoid infinite recursion of exceptions; in same cases it's
just paranoia or minor performance issue.

> Also syscall exception handler enables global interrupt bit(IE). Since the
> interrupt priority  is lowest,If an interrupt happens in a syscall exception
> handler, will it pause the syscall exception handler and run the interrupt
> handler? If not, why it enable the IE bit(STI) in the syscall exception
> handler??
> 
> If two interrupts happens at the same time, how can we decide the larger
> priority interrupt and run its ISR?

That's the decission of implementor of the respective board.  No strict
rules here; in general we priorize the timer interrupt highest but that's
no longer mandatory.

  Ralf
