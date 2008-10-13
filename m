Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 22:50:59 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:29394 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21418436AbYJMVu5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2008 22:50:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9DLos8A017519;
	Mon, 13 Oct 2008 22:50:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9DLos0J017518;
	Mon, 13 Oct 2008 22:50:54 +0100
Date:	Mon, 13 Oct 2008 22:50:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Dickgreber <tanzy@gmx.de>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Questions for CONFIG_WEAK_ORDERING  and
	CONFIG_WEAK_REORDERING_BEYOND_LLSC
Message-ID: <20081013215054.GB8145@linux-mips.org>
References: <48F39B18.9030601@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F39B18.9030601@gmx.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 09:01:44PM +0200, Johannes Dickgreber wrote:

> If a cpu is WEAK_ORDERING schouldn't it do a sync independent of CONFIG_SMP ?
> 
> And if it is a SMP system schouldn't it do a sync independent of CONFIG_WEAK_ORDERING ?
> 
> And if a cpu has no sync with LLSC schouldn't it do a sync independent of CONFIG_SMP ?
> 
> All together, is the following the right thing to do ?

A processor is always consistently ordered wrt. to itself, so uniprocessor
cores never need SYNCs even if that processor was weakly ordered in a
multiprocessor systems.

A while ago I walked through all mb(), rmb() and wmb() uses in the generic
code.  None of the ones I verified is actually needed on uniprocessor
kernels.  Ocasionally one of these functions is used to maintain I/O
ordering but again other mechanisms are prefered for that purpose.

  Ralf
