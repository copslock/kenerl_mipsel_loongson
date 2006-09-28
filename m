Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 00:58:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52378 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039165AbWI1X6q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 00:58:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SNxcP9009518;
	Fri, 29 Sep 2006 00:59:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SNxbIX009517;
	Fri, 29 Sep 2006 00:59:37 +0100
Date:	Fri, 29 Sep 2006 00:59:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Watkins <treestem@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SGI Origin 200 (ip27) with DEBUG_SPINLOCK
Message-ID: <20060928235937.GF3394@linux-mips.org>
References: <451C134C.6010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451C134C.6010806@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 02:24:12PM -0400, Peter Watkins wrote:

> Greetings SGI Origin wizards,
> 
> I'm doing some SMP testing on an SGI Origin 200 (ip27).
> 
> I started with a 2.6.15 vintage kernel and added changes from here:
> ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/ip27/

There have been a few significant fixes to the Origin code IP27 since
2.6.15 ...

> It boots both processors and runs OK.
> 
> Then I turn on CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP, 
> and get lots of lockup messages. A typical one is below.
> 
> Anyone seen this? Some of the low-level lock code has R10000_LLSC_WAR 
> versions, but I don't see anything wrong there.

The R10000_LLSC_WAR is a workaround for a CPU bug in certain relativly
old version of the R10000 processor.  Version 2.6 or older were affected
but the cutoff version number could have been 2.7.  Anyway, the sympthom
was that possibly multiple processors were taking a able to grab a
spinlock which obvious is the way to disaster.  I originally found the
problem when analyzing why rebuilding a MD RAID array was resulting in a
crash.

Even with that fix applied I found a MD RAID 5 / 6 not very stable as of
last week; it seems this instability is limited to IP27 and IP30 and it
seemed like the various kernel debuging options I tried were aggrevating
the problem significantly.

  Ralf
