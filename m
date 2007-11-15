Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 11:53:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16325 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025259AbXKOLxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 11:53:54 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAFBrpY6005214;
	Thu, 15 Nov 2007 11:53:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAFBrpoN005213;
	Thu, 15 Nov 2007 11:53:51 GMT
Date:	Thu, 15 Nov 2007 11:53:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cannot unwind through MIPS signal frames with
	ICACHE_REFILLS_WORKAROUND_WAR
Message-ID: <20071115115351.GA4973@linux-mips.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <473C0761.1040205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473C0761.1040205@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 15, 2007 at 09:46:25AM +0100, Franck Bui-Huu wrote:

> Ralf Baechle wrote:
> > Another reason is to get rid of the classic trampoline the kernel installs
> > on the stack.  On some multiprocessor systems it requires a cacheflush
> 
> BTW, could we get rid of the trampoline so easily ? I mean won't we have
> to keep it for backward compatibility reasons ?

The trampolines are an implementation detail.  Little software needs to
know about it, so while I expect some slight colateral damage from getting
rid of trampolines it's not going to be painful.  GDB is the primary piece
of software that will need to change.

Some of the other architectures have an sa_restorer field in struct
sigaction but we don't have that on MIPS.

One way to deal with this would be to do a similar as IRIX where the
sigaction(2) takes a 4th argument which takes the role of sa_restorer.
For backward compatibility an SA_RESTORER field.  So if the SA_RESTORER
is clear we'd be using a classic trampoline, if it's set the value of
the 4th argument.

Or slightly crazier, put a kernel address into the $ra register of the
invoked signal handler.  So the signal handler will cause an address
error exception which then can be trapped.  Additional advantage - some of
the "Don't let your children do this ..." sections of code can go away ;-)

  Ralf
