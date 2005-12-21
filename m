Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 19:38:27 +0000 (GMT)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:55921 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133869AbVLUTiI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 19:38:08 +0000
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 21 Dec 2005 11:39:09 -0800
X-IronPort-AV: i="3.99,280,1131350400"; 
   d="scan'208"; a="243733236:sNHT33022368"
Received: from cisco.com (sjc-xdm-007.cisco.com [171.70.105.141])
	by sj-core-3.cisco.com (8.12.10/8.12.6) with ESMTP id jBLJd6Me019119;
	Wed, 21 Dec 2005 11:39:07 -0800 (PST)
Received: from sjc-xdm-007.cisco.com (localhost.localdomain [127.0.0.1])
	by cisco.com (8.12.11/8.12.11) with ESMTP id jBLJd6tB017143;
	Wed, 21 Dec 2005 11:39:06 -0800
Received: (from skommu@localhost)
	by sjc-xdm-007.cisco.com (8.12.11/8.12.11/Submit) id jBLJd6a9017141;
	Wed, 21 Dec 2005 11:39:06 -0800
Date:	Wed, 21 Dec 2005 11:39:06 -0800
From:	Srinivas Kommu <kommu@hotmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Yoann Allain <yallain@avilinks.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Preempted interrupt handler
Message-ID: <20051221193906.GB1456@sjc-xdm-007.cisco.com>
References: <43A6F155.7080402@avilinks.com> <20051220131829.GB3376@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220131829.GB3376@linux-mips.org>
User-Agent: Mutt/1.5.10i
Return-Path: <skommu@sjc-xdm-007.cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kommu@hotmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 20, 2005 at 02:18:29PM +0100, Ralf Baechle wrote:
> On Mon, Dec 19, 2005 at 06:43:49PM +0100, Yoann Allain wrote:
> 
> > I'm actually working on a driver for a Marvell chip on a MIPS-based 
> > board running a 2.4 kernel. I have one problem:
> > In my module, my interrupt handler is never executed. I have traced the 
> > code until action->handler(irq, action->dev_id, regs)  in 
> > handle_IRQ_event() but when the handler should be executed, it is not 
> > and the kernel reenters in the low-level interrupt dispatch routine 
> > (because we're using level sensitive interrupts and it is still up). 
> > I've checked that the function pointer called is the one of my handler 
> > but my routine is never entered.
> > 
> > But when my handler is included in the kernel (ie not compiled as a 
> > module), it works! My function gets executed and acks the interrupt. In 
> > this case all goes fine.
> >
> > Moreover, I've noticed that the kernel symbols are mapped at adresses 
> > like 0x80258040 (start_kernel) but my module (and so is my handler) is 
> > loaded at something like 0xc000275c . I was thinking the module would be 
> > loaded in the same memory area as the kernel, so I think this is weird...
> > Perhaps, the module handler can't be executed because of its location 
> > but I don't know how to fix this.
> 
> Good new then - you don't need to fix anything :-)
> 
> The sympthoms you're describing are not specific enough, so only some
> general advice:
> 
>  - Make sure you're running a current version of modutils; older versions
>    have a number of bugs that could result in almost any kind of ill
>    behaviour.
>  - Make sure all object files of the modules have been built with
>    -mlong-calls.  That's done automatically by the kernel's makefiles
>    but not necessarily when building out of tree and certain versions
>    would silently tolerate the resulting relocation error.

Is it normal for the modules to be loaded at 0xc0000000 (this is
highmem, isn't it)? I see the same on my bcm1250 box. I've been wondering
why they can't be loaded in kseg0. Or is it because of bad
modutils/compiler flags?

thanks
srini

> 
>   Ralf

-- 
Srinivas Kommu
Cisco Systems, Inc.
Ph. (408) 527-8610
