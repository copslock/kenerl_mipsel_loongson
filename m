Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 19:24:54 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:27616
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8226105AbVF3SYF>; Thu, 30 Jun 2005 19:24:05 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id BACC314B6C1
	for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 14:23:43 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17092.14511.626777.981192@cortez.sw.starentnetworks.com>
Date:	Thu, 30 Jun 2005 14:23:43 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
In-Reply-To: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
References: <17092.5345.75666.403044@cortez.sw.starentnetworks.com>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Dave Johnson writes:
> 
> Got this crash with recent 2.6 CVS version.
> 
> CONFIG_SMP and CONFIG_PREEMPT are both on.  This in on a sb1250 rev
> B2.
> 
> The PC it was trying to lookup is in preempt_schedule_irq().  Without
> preempt_schedule_irq in mfinfo[] it ended up with the wrong function
> and then dereferenced a NULL FP.

Looks like more than preempt_schedule_irq are missing.

I've got these in .sched.text:

ffffffff8031ea70 T __sched_text_start
ffffffff8031eb88 T __down_interruptible
ffffffff8031ed18 T schedule
ffffffff8031f7e8 T preempt_schedule
ffffffff8031f8a8 T preempt_schedule_irq
ffffffff8031f9b0 T wait_for_completion
ffffffff8031fae0 T wait_for_completion_timeout
ffffffff8031fc58 T wait_for_completion_interruptible
ffffffff8031fdf0 T wait_for_completion_interruptible_timeout
ffffffff8031ff98 T interruptible_sleep_on
ffffffff80320070 T interruptible_sleep_on_timeout
ffffffff80320160 T sleep_on
ffffffff80320238 T sleep_on_timeout
ffffffff80320328 T cond_resched
ffffffff803203c0 T cond_resched_softirq
ffffffff80320478 T yield
ffffffff803204b8 T io_schedule
ffffffff80320548 T io_schedule_timeout
ffffffff803205d8 T console_conditional_schedule
ffffffff80320610 T schedule_timeout
ffffffff803206f0 t nanosleep_restart
ffffffff803207f0 T __wait_on_bit
ffffffff80320910 T out_of_line_wait_on_bit
ffffffff803209e0 T __wait_on_bit_lock
ffffffff80320b28 T out_of_line_wait_on_bit_lock
ffffffff80320bf8 T __down_read
ffffffff80320d00 T __down_write
ffffffff80320e10 T __lock_text_start
ffffffff80320e10 T __sched_text_end

All of those should be in mfinfo[] with omit_fp 1 for those in
kernel/sched.c and 0 for elsewhere.  Or am I missing something here?

-- 
Dave Johnson
Starent Networks
