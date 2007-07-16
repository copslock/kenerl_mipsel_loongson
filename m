Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 13:03:04 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:51890 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S20024654AbXGPMDC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jul 2007 13:03:02 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.13.4) with ESMTP id l6GC2fDE005786;
	Mon, 16 Jul 2007 16:02:41 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id l6GC2fgc005783;
	Mon, 16 Jul 2007 16:02:41 +0400
Received: from [192.168.173.21] (aa248 [172.16.0.248])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id l6GC17Gh015886;
	Mon, 16 Jul 2007 16:01:08 +0400
Message-ID: <469B5C2E.5080905@niisi.msk.ru>
Date:	Mon, 16 Jul 2007 15:53:18 +0400
From:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, kumba@gentoo.org
CC:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org>
In-Reply-To: <20070704192208.GA7873@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <rogozhkin@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rogozhkin@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

> 
> Big loud bell began ringing.  The RM7000 fetches and decodes multiple
> instructions in one go.  And just like the E9000 cores it does
> throw an exception if it doesn't like one of the opcodes even if that
> doesn't actually get executed.  The kernel has a workaround for this
> PMC-Sierra peculiarity (I call it a bug) but it's only being activated
> for E9000 platforms.

We have had a similar problems with shell on RM7000 based system. It 
seems, the reason listed above is only half of the problem, another is: 
linux works incorrectly with RM7000 caches hierarchy. One visible effect 
  is errors in userspace on signal delivery trampolines.
Lets imagine we deliver a signal to application: we write signal 
trampoline instructions to stack, writeback (and invalidate) 
corresponding dcache line, invalidate corresponding icache line. Thats 
all, and we think that we can safely execute the trampoline, but this is 
wrong on RM7000! Our trampoline is now in scache, and everything seems 
to be ok, but after some number of load/stores corresponding scache line 
can be moved to dcache, replaced in scache by another data and not 
written to memory (this is a feature of RM7000 caches, its dcache is not 
a subset of scache, you can find a possible scenario of similar (but not 
the same) cache line transference in RM7000 manual (7.1.5 Orphaned Cache 
Lines)). After that it is possible that on signal trampoline execution 
icache fetch old memory content instead of instruction written. If we 
want to execute instruction written by cpu, we must not only writeback 
corresponding dcache lines, but also writeback corresponding scache 
lines after it. The error is very sensitively to kernel/user code and 
data arrangement, it can be visible with one kernel configuration and 
irreproducible with another.
The problem affects not only signal trampoline flush to memory, but most 
cases of icache invalidation in kernel.

Sergey Rogozhkin.
