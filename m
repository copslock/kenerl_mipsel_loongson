Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 11:15:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5289 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021948AbXHBKPF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 11:15:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l72AF44p024499;
	Thu, 2 Aug 2007 11:15:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l72AF3Jx024498;
	Thu, 2 Aug 2007 11:15:03 +0100
Date:	Thu, 2 Aug 2007 11:15:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: Modpost warning on Alchemy
Message-ID: <20070802101503.GD22697@linux-mips.org>
References: <46B07B36.1000501@ru.mvista.com> <Pine.LNX.4.64N.0708011337390.20314@blysk.ds.pg.gda.pl> <46B086EB.2030101@ru.mvista.com> <46B0880B.2000009@ru.mvista.com> <Pine.LNX.4.64N.0708011629010.20314@blysk.ds.pg.gda.pl> <46B0AA74.7040100@ru.mvista.com> <Pine.LNX.4.64N.0708011708250.20314@blysk.ds.pg.gda.pl> <46B0B6B4.5090103@ru.mvista.com> <46B0BE52.4000302@ru.mvista.com> <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0708021024200.22591@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 10:39:21AM +0100, Maciej W. Rozycki wrote:

> > >    No, I don't.  But that was why the original code preferred the wired
> > > entry approach over ioremap() -- not to map a whole range...
> > 
> >    Not the only one: dynamic ioremap() seems to be impossible in interrupt
> > context.
> 
>  Well, ioremap() may sleep indeed.  How about using a softirq then?  
> Broken hardware (=one that requires PCI configuration accesses from the 
> IRQ context) is not an excuse to extend the breakage over to software.

Lockdep would trigger on ioremap from an interrupt almost immediately.
But I guess not a whole lot of people are using it, probably because they
think they're safe from locking problems on uniprocessors ...

  Ralf
