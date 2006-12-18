Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2006 13:00:54 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:41434 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20048948AbWLRNAs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2006 13:00:48 +0000
Received: from lagash (p54A47C58.dip.t-dialin.net [84.164.124.88])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 131F5B84E1;
	Mon, 18 Dec 2006 13:46:17 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GwHtU-000259-3y; Mon, 18 Dec 2006 12:47:00 +0000
Date:	Mon, 18 Dec 2006 12:47:00 +0000
To:	Daniel Laird <danieljlaird@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: PAGE_ALIGN + PAGE_SHIFT from userspace
Message-ID: <20061218124659.GA17301@networkno.de>
References: <7925460.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7925460.post@talk.nabble.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Daniel Laird wrote:
> 
> Hi All,
> 
> I was using linux 2.6.17.13 on my MIPS and it was all going well.  I am just
> porting to 2.6.19 and am having a couple of issues.
> 
> My first issue is that i used to mmap a buffer from user space.  I used to
> use a PAGE_ALIGN macro when doing this:
> /** to align the pointer to the (next) page boundary */
> #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
> 
> this worked as PAGE_SIZE and PAGE_MASK were available in page.h.

It didn't work reliably since the pagesize is a kernel configuration option.

> This have now been moved inside the #ifdef KERNEL guard in the header file. 
> Meaning these are no longer available.
> 
> Are these available somewhere else?
> Should I be doing something different to mmap?

Use the libc's sysconf(_SC_PAGESIZE) function.


Thiemo
