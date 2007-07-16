Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 13:33:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:55722 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024697AbXGPMdq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jul 2007 13:33:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6GCXiS0013999;
	Mon, 16 Jul 2007 13:33:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6GCXit7013998;
	Mon, 16 Jul 2007 13:33:44 +0100
Date:	Mon, 16 Jul 2007 13:33:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
Message-ID: <20070716123343.GA13439@linux-mips.org>
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469B5C2E.5080905@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469B5C2E.5080905@niisi.msk.ru>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 16, 2007 at 03:53:18PM +0400, Sergey Rogozhkin wrote:

> >Big loud bell began ringing.  The RM7000 fetches and decodes multiple
> >instructions in one go.  And just like the E9000 cores it does
> >throw an exception if it doesn't like one of the opcodes even if that
> >doesn't actually get executed.  The kernel has a workaround for this
> >PMC-Sierra peculiarity (I call it a bug) but it's only being activated
> >for E9000 platforms.
> 
> We have had a similar problems with shell on RM7000 based system. It 
> seems, the reason listed above is only half of the problem, another is: 
> linux works incorrectly with RM7000 caches hierarchy. One visible effect 
>  is errors in userspace on signal delivery trampolines.
> Lets imagine we deliver a signal to application: we write signal 
> trampoline instructions to stack, writeback (and invalidate) 
> corresponding dcache line, invalidate corresponding icache line. Thats 
> all, and we think that we can safely execute the trampoline, but this is 
> wrong on RM7000! Our trampoline is now in scache, and everything seems 
> to be ok, but after some number of load/stores corresponding scache line 
> can be moved to dcache, replaced in scache by another data and not 
> written to memory (this is a feature of RM7000 caches, its dcache is not 
> a subset of scache, you can find a possible scenario of similar (but not 
> the same) cache line transference in RM7000 manual (7.1.5 Orphaned Cache 
> Lines)). After that it is possible that on signal trampoline execution 
> icache fetch old memory content instead of instruction written. If we 
> want to execute instruction written by cpu, we must not only writeback 
> corresponding dcache lines, but also writeback corresponding scache 
> lines after it. The error is very sensitively to kernel/user code and 
> data arrangement, it can be visible with one kernel configuration and 
> irreproducible with another.
> The problem affects not only signal trampoline flush to memory, but most 
> cases of icache invalidation in kernel.

Hmm...  Makes sense.  I guess I can cook up a patch based on that analysis.

Thanks!

  Ralf
