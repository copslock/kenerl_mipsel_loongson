Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4NNxnnC014645
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 23 May 2002 16:59:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4NNxnSC014644
	for linux-mips-outgoing; Thu, 23 May 2002 16:59:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ayrnetworks.com (64-166-72-142.ayrnetworks.com [64.166.72.142])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4NNxknC014637
	for <linux-mips@oss.sgi.com>; Thu, 23 May 2002 16:59:46 -0700
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g4NNxRf08207
	for linux-mips@oss.sgi.com; Thu, 23 May 2002 16:59:27 -0700
Date: Thu, 23 May 2002 16:59:27 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: linux-mips@oss.sgi.com
Subject: Re: Please disregard; was: [PATCH] arch/mips/kernel/irq_cpu.c interrupt safety?
Message-ID: <20020523165927.I7205@ayrnetworks.com>
References: <20020520184151.C26598@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020520184151.C26598@ayrnetworks.com>; from wjhun@ayrnetworks.com on Mon, May 20, 2002 at 06:41:51PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Please disregard this, I jumped the gun on this one. These routines are
only ever called from arch/mips/kernel/irq.c, which always safely
calls these routines under the irq_desc's spinlock (or in the case of
ack(), do_IRQ() is already invoked with interrupts turned off).

I'll be sure to grep a little more carefully next time. ;o)

Will

On Mon, May 20, 2002 at 06:41:51PM -0700, William Jhun wrote:
> The mips_cpu_irq_*() routines in arch/mips/kernel/irq_cpu.c seem to not be
> safe; {clear,set}_cp0_*() don't provide interrupt safety while changing the cp0
> register. Is this not wrong? Is there a case where an interrupt handler may
> change CP0 status? If so, the patch below (against linux_2_4) simply disables
> interrupts during these operations.
> 
> Thanks,
> Will
