Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 22:12:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8952 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225195AbTFLVMo>;
	Thu, 12 Jun 2003 22:12:44 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h5CLCfj07787;
	Thu, 12 Jun 2003 14:12:41 -0700
Date: Thu, 12 Jun 2003 14:12:41 -0700
From: Jun Sun <jsun@mvista.com>
To: Ranjan Parthasarathy <ranjanp@efi.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: do_IRQ query
Message-ID: <20030612141241.D7321@mvista.com>
References: <D9F6B9DABA4CAE4B92850252C52383AB07968330@ex-eng-corp.efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D9F6B9DABA4CAE4B92850252C52383AB07968330@ex-eng-corp.efi.com>; from ranjanp@efi.com on Thu, Jun 12, 2003 at 01:16:51PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2003 at 01:16:51PM -0700, Ranjan Parthasarathy wrote:
> Is it safe to call do_IRQ directly inside interrupt handlers without doing a irq_enter. I have seen ksoftirqd_CPUX crashes when I call the do_IRQ routines directly instead of the following sequence.
> 
> irq_enter()
> do_IRQ
> irq_exit()
>

This is not right.  irq_enter()/irq_exit() is already called in 
handle_IRQ_event(), which in turn is called by do_IRQ().  YOu 
don't need this yourself.  

The rest of do_IRQ() code is protected by closing interrupts.

Something must be wrong in your system.  If you show the crash message,
we might be able to tell more.

> Some code use it while some do not. The timer code in arch/mips/kernel/time.c uses it in ll_timer_interrupt. Some ports call this function directly in their interrupt handlers.

Those ll_timer_xxx functions are alternative routes (fast ones) to
do_IRQ(), and therefore it needs to protect itself by calling
irq_enter()/irq_exit().

Jun
