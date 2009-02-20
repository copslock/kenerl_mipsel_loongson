Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2009 13:47:33 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55991 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21299246AbZBTNrb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Feb 2009 13:47:31 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1KDlUY8023357;
	Fri, 20 Feb 2009 13:47:30 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1KDlTLH023354;
	Fri, 20 Feb 2009 13:47:29 GMT
Date:	Fri, 20 Feb 2009 13:47:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Rhodin <chris@notav8.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: plat_irq_dispatch
Message-ID: <20090220134729.GC19924@linux-mips.org>
References: <499E6AC5.5070404@notav8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499E6AC5.5070404@notav8.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 20, 2009 at 12:33:09AM -0800, Chris Rhodin wrote:

> I've been digging through the interrupt code trying to figure out what  
> would be required to make it "generic irq" clean.  I have a couple of  
> questions that I haven't been able to answer myself.
>
> 1) I count 24 different versions of plat_irq_dispatch, many of them only  
> seem to vary in the use and priority of the 8 sources in the cause  
> register.  Is this really the case or am I missing something subtle?

No, you're correct.  Part of why all these plat_irq_dispatch versions
do exist is that there are different versions of CPU interrupt controllers.
There is the basic MIPS CPU integrated interrupt controller providing
6 level-sensitive inputs and 2 software interrupts.  Some processors
such as the RM7000 processors and E9000 cores extend this in vendor-
specific ways.  Outside of the actual processor in most cases there is
a system-specific hierarchy of interrupt controllers attached which
needs to be polled in software to find the source of a pending interrupt
and compute an interrupt number for use by the generic code.

plat_irq_dispatch came into existence in commit
5476b529ad3ba9db6e189c79d692d2929c1d1f95 as the hardware-specific part
of the former platform-specific handle_int family of functions and for
sanity reasons is written in C, no longer assembler.

> 2) Why isn't plat_irq_dispatch looping until all active interrupts are  
> serviced?

The assumption is that most often there won't be another interrupt
pending and that it is faster on average to just take another interrupt
exception than to always perform the check.

> I already have what I believe is a generic plat_irq_dispatch that finds  
> the highest priority irq in (almost) constant time.  It needs one block  
> of defines to identify the 8 sources and another block to set the  
> priorities.

I'm not sure how important priorities actually are these days.  In the dark
past of Linux the SCSI code did go braindead if timer interrupts were not
handled at higher priority than device interrupts.  That's got fixed
eons ago.  Some embedded devices may have requirements there?

  Ralf
