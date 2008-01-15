Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 01:57:59 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:37775 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20035995AbYAOB5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 01:57:50 +0000
Received: from lagash (88-106-221-90.dynamic.dsl.as9105.com [88.106.221.90])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id DB96D48916;
	Tue, 15 Jan 2008 02:57:44 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JEb4A-0007lk-D0; Tue, 15 Jan 2008 01:58:14 +0000
Date:	Tue, 15 Jan 2008 01:58:14 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	The Engineer <lper.home@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cache aliasing issues using 4K pages.
Message-ID: <20080115015814.GF9693@networkno.de>
References: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The Engineer wrote:
> We are working with a 2.6.12 kernel on a dual-core mips architecture.
> In this dual-core system, one core is running the linux kernel and the
> other is used for some real-time handling (not directly controlled by
> Linux)
> We had different stability issues, which could be pinpointed to be
> related with cache aliasing problems.
> Cache aliasing happens when the same physical memory can be cached
> twice as it is accessed by two different virtual addresses.
> Indeed, for the index to select the correct cache line the virtual
> address is used. If some bits of the virtual page address are used in
> the cache index, aliasing can occur.
> 
> 
> As there is no hardware solution in the mips to recover from this
> (which would provide some cache coherency, even for one core), the
> only intrinsic safe solution is to enlarge the page size, so that
> cache indexing is only done by the offset address in the page (thus
> the physical part of the address).
> Another solution is to flush the cache if a page is being remapped to
> an aliased address (but in our case linux does not has control on the
> second core, which can cause issues with shared data between both
> cores).
> Currently the second solution is used in the kernel, but we found
> different issues with it (for instance: we had to merge more recent
> mips kernels, to get a reliable copy-on-write behaviour after
> forks...).
> 
> Therefore some questions:
> - Are there still some known issues with cache aliasing in the MIPS kernel?
> - Are there known issues when using 16KB pages (8KB pages seems not be
> possible due to tlb issues).

With recent kernels and toolchains 16k pages work ok IME. With a 2.6.12
kernel however you'll have to backport a serious amount of bugfixes
before 16k pages can work. Upgrading the kernel is probably less work.


Thiemo
