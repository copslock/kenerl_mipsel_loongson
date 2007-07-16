Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 18:38:53 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:29738 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20024685AbXGPRiv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2007 18:38:51 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 16 Jul 2007 10:38:23 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 16 Jul 2007 10:38:23 -0700
Date:	Mon, 16 Jul 2007 10:38:23 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070716103823.3fe9aef4@ripper.onstor.net>
In-Reply-To: <20070716123343.GA13439@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org>
	<468825BE.6090001@gmx.net>
	<50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>
	<20070704152729.GA2925@linux-mips.org>
	<20070704192208.GA7873@linux-mips.org>
	<469B5C2E.5080905@niisi.msk.ru>
	<20070716123343.GA13439@linux-mips.org>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2007 17:38:23.0374 (UTC) FILETIME=[1B9CE2E0:01C7C7D0]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

On Mon, 16 Jul 2007 13:33:44 +0100 Ralf Baechle <ralf@linux-mips.org>
wrote:

> On Mon, Jul 16, 2007 at 03:53:18PM +0400, Sergey Rogozhkin wrote:
> 
> > >Big loud bell began ringing.  The RM7000 fetches and decodes
> > >multiple instructions in one go.  And just like the E9000 cores it
> > >does throw an exception if it doesn't like one of the opcodes even
> > >if that doesn't actually get executed.  The kernel has a
> > >workaround for this PMC-Sierra peculiarity (I call it a bug) but
> > >it's only being activated for E9000 platforms.
> > 
> > We have had a similar problems with shell on RM7000 based system.
> > It seems, the reason listed above is only half of the problem,
> > another is: linux works incorrectly with RM7000 caches hierarchy.
> > One visible effect is errors in userspace on signal delivery
> > trampolines. Lets imagine we deliver a signal to application: we
> > write signal trampoline instructions to stack, writeback (and
> > invalidate) corresponding dcache line, invalidate corresponding
> > icache line. Thats all, and we think that we can safely execute the
> > trampoline, but this is wrong on RM7000! Our trampoline is now in
> > scache, and everything seems to be ok, but after some number of
> > load/stores corresponding scache line can be moved to dcache,
> > replaced in scache by another data and not written to memory (this
> > is a feature of RM7000 caches, its dcache is not a subset of
> > scache, you can find a possible scenario of similar (but not the
> > same) cache line transference in RM7000 manual (7.1.5 Orphaned
> > Cache Lines)). After that it is possible that on signal trampoline
> > execution icache fetch old memory content instead of instruction
> > written. If we want to execute instruction written by cpu, we must
> > not only writeback corresponding dcache lines, but also writeback
> > corresponding scache lines after it. The error is very sensitively
> > to kernel/user code and data arrangement, it can be visible with
> > one kernel configuration and irreproducible with another. The
> > problem affects not only signal trampoline flush to memory, but
> > most cases of icache invalidation in kernel.
> 
> Hmm...  Makes sense.  I guess I can cook up a patch based on that
> analysis.

I hungrily await said patch, as I believe this is a problem on RM9000
processors as well.  I'm seeing "random" SIGILLs on user processes,
particularly large complicated shell scripts like configure on an RM9k
platform.

Cheers,

a
