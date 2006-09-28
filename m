Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 15:27:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:31891 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038697AbWI1O1s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 15:27:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SESfpx001648;
	Thu, 28 Sep 2006 15:28:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SESete001647;
	Thu, 28 Sep 2006 15:28:40 +0100
Date:	Thu, 28 Sep 2006 15:28:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>,
	linux-mips@linux-mips.org
Subject: Re: wrong SP restored after DBE exception
Message-ID: <20060928142840.GB3394@linux-mips.org>
References: <17690.54995.407882.581783@zeus.sw.starentnetworks.com> <20060928130925.GA3394@linux-mips.org> <Pine.LNX.4.64N.0609281448310.3949@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0609281448310.3949@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 02:56:29PM +0100, Maciej W. Rozycki wrote:

> > If we take a DBE exception in this code we're in trouble and I've seen
> > systems delivering DBEs highly asynchronously.  Afar the Broadcom SOCs
> > fall into that class.
> > 
> > So the interesting part is if we take a data bus exception between
> > the stack pointer adjustment and and before EXL is cleared.  We're taking
> > a nested exception so c0_epc and c0_cause.bd will not be updated.  So
> > when the bus error handler will save the $sp value it saw on entry but
> > will return to the EPC of the first exception, that is only one stack
> > frame will be popped.  Whops ...
> 
>  It looks like a design issue -- further asynchronous bus error exceptions 
> should be blocked till one currenly being handled has been acked.  In fact 
> if they are asynchronous, then it really makes no sense to use the 
> exception and a general interrupt should be used instead -- the whole 
> point of using an exception here is the ability to stop a data corrupting 
> transaction, as unlike an interropt, an exception can be precise.

I would suggest to disable interrupts around accesses that potencially
could result in DB exceptions and just to make sure he is not getting
trapped by a non-blocking load by making some use of any value read
from the device.  Writes could be posted depending on bus type.  So
having a read from the same device would force the write to complete.

  Ralf
