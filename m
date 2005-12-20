Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 13:18:05 +0000 (GMT)
Received: from p549F54A9.dip.t-dialin.net ([84.159.84.169]:57161 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S8126482AbVLTNRr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 13:17:47 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id jBKDIYgC006601;
	Tue, 20 Dec 2005 14:18:34 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id jBKDITN4006600;
	Tue, 20 Dec 2005 14:18:29 +0100
Date:	Tue, 20 Dec 2005 14:18:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoann Allain <yallain@avilinks.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Preempted interrupt handler
Message-ID: <20051220131829.GB3376@linux-mips.org>
References: <43A6F155.7080402@avilinks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A6F155.7080402@avilinks.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 19, 2005 at 06:43:49PM +0100, Yoann Allain wrote:

> I'm actually working on a driver for a Marvell chip on a MIPS-based 
> board running a 2.4 kernel. I have one problem:
> In my module, my interrupt handler is never executed. I have traced the 
> code until action->handler(irq, action->dev_id, regs)  in 
> handle_IRQ_event() but when the handler should be executed, it is not 
> and the kernel reenters in the low-level interrupt dispatch routine 
> (because we're using level sensitive interrupts and it is still up). 
> I've checked that the function pointer called is the one of my handler 
> but my routine is never entered.
> 
> But when my handler is included in the kernel (ie not compiled as a 
> module), it works! My function gets executed and acks the interrupt. In 
> this case all goes fine.
>
> Moreover, I've noticed that the kernel symbols are mapped at adresses 
> like 0x80258040 (start_kernel) but my module (and so is my handler) is 
> loaded at something like 0xc000275c . I was thinking the module would be 
> loaded in the same memory area as the kernel, so I think this is weird...
> Perhaps, the module handler can't be executed because of its location 
> but I don't know how to fix this.

Good new then - you don't need to fix anything :-)

The sympthoms you're describing are not specific enough, so only some
general advice:

 - Make sure you're running a current version of modutils; older versions
   have a number of bugs that could result in almost any kind of ill
   behaviour.
 - Make sure all object files of the modules have been built with
   -mlong-calls.  That's done automatically by the kernel's makefiles
   but not necessarily when building out of tree and certain versions
   would silently tolerate the resulting relocation error.

  Ralf
