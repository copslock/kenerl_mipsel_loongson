Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 14:56:34 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7434 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038652AbWI1N4c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 14:56:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8EA64F633A;
	Thu, 28 Sep 2006 15:56:27 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NyYP81CiWOk; Thu, 28 Sep 2006 15:56:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3B959F6339;
	Thu, 28 Sep 2006 15:56:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k8SDuYHD018602;
	Thu, 28 Sep 2006 15:56:34 +0200
Date:	Thu, 28 Sep 2006 14:56:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>,
	linux-mips@linux-mips.org
Subject: Re: wrong SP restored after DBE exception
In-Reply-To: <20060928130925.GA3394@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0609281448310.3949@blysk.ds.pg.gda.pl>
References: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
 <20060928130925.GA3394@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1948/Wed Sep 27 18:03:03 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 28 Sep 2006, Ralf Baechle wrote:

> If we take a DBE exception in this code we're in trouble and I've seen
> systems delivering DBEs highly asynchronously.  Afar the Broadcom SOCs
> fall into that class.
> 
> So the interesting part is if we take a data bus exception between
> the stack pointer adjustment and and before EXL is cleared.  We're taking
> a nested exception so c0_epc and c0_cause.bd will not be updated.  So
> when the bus error handler will save the $sp value it saw on entry but
> will return to the EPC of the first exception, that is only one stack
> frame will be popped.  Whops ...

 It looks like a design issue -- further asynchronous bus error exceptions 
should be blocked till one currenly being handled has been acked.  In fact 
if they are asynchronous, then it really makes no sense to use the 
exception and a general interrupt should be used instead -- the whole 
point of using an exception here is the ability to stop a data corrupting 
transaction, as unlike an interropt, an exception can be precise.

  Maciej
