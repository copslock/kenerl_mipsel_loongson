Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 12:33:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53888 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133725AbWDXL3k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 12:29:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3OBgZBX006517;
	Mon, 24 Apr 2006 12:42:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3OA83Ld003686;
	Mon, 24 Apr 2006 11:08:03 +0100
Date:	Mon, 24 Apr 2006 11:08:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Question on SMP warning in irq_cpu.c
Message-ID: <20060424100803.GC3194@linux-mips.org>
References: <12E9F4D6141E504DA2F115E577252AC7C09451@sjc1exm04.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12E9F4D6141E504DA2F115E577252AC7C09451@sjc1exm04.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 18, 2006 at 10:50:28AM -0700, Raj Palani wrote:

>    I have a question regarding the following warning in the arch/mips/kernel/irq_cpu.c.
>    What is the reason for this comment and in case it is not SMP safe, what are the changes needed to make it SMP safe?
> /*
>  * Almost all MIPS CPUs define 8 interrupt sources.  They are typically
>  * level triggered (i.e., cannot be cleared from CPU; must be cleared from
>  * device).  The first two are software interrupts which we don't really
>  * use or support.  The last one is usually the CPU timer interrupt if
>  * counter register is present or, for CPUs with an external FPU, by
>  * convention it's the FPU exception interrupt.
>  *
>  * Don't even think about using this on SMP.  You have been warned.
>  *
>  * This file exports one global function:
>  *	void mips_cpu_irq_init(int irq_base);
>  */

The interrupt controller is part of the processor itself, so any
manipulation of it's control registers needs to be done on the processor
itself.  On an SMP system however calling enable_irq, disable_irq etc.
is legal on any CPU, so the wrong processor's interrupts might be
changed.  Also there is no provision for interrupts that are handled the
same on all processor.  The count / compare interrupt is a typical
example for this.

The answer is a little more complicated if considering multithreading a la
34K due to the more complicated priviledged resource architecture but the
underlying problem is the same.

  Ralf
