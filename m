Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2003 18:56:37 +0000 (GMT)
Received: from p508B5C7D.dip.t-dialin.net ([IPv6:::ffff:80.139.92.125]:38359
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225330AbTKUS4Z>; Fri, 21 Nov 2003 18:56:25 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hALIoZA0029125;
	Fri, 21 Nov 2003 19:50:35 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hALIoZpp029124;
	Fri, 21 Nov 2003 19:50:35 +0100
Date: Fri, 21 Nov 2003 19:50:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] 2.4, head: PAGE_SHIFT changes break glibc
Message-ID: <20031121185035.GC8318@linux-mips.org>
References: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0311211550270.32551@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 21, 2003 at 06:33:37PM +0100, Maciej W. Rozycki wrote:

>  Recent changes made to <asm/page.h> break a build of glibc 2.2.5 for me.  
> Compilation bails out due to PAGE_SHIFT being undeclared -- glibc pulls it
> as it uses PAGE_SIZE in linuxthreads/internals.h.  The PAGE_SHIFT macro
> depends on configuration now (I use an empty cofinguration for glibc
> headers, hence the error) and thus it'd better be simply private to the
> kernel.  Glibc will then use sysconf(_SC_PAGE_SIZE) which now better
> reflects actual configuration of the system it's run on.

Interesting.  IA-64 does the same thing, for example.  Wonder why they
seem to be able to get away with that.  At the very least including the
kernel header file may pick up a wrong value for PAGE_SHIFT.

>  Here's a patch that limits PAGE_SIZE to the kernel scope.  If there's any
> other program that needs PAGE_SIZE, it should be converted to
> sysconf(_SC_PAGE_SIZE) as well.
> 
>  OK to apply?

Yes, please go ahead.

>  Additionally, I think we should also implement the getpagesize syscall to
> benefit statically linked programs (and make glibc use it like for other
> platforms that use variable page sizes).

The kernel is already passing AT_PAGESZ to ELF binaries.  Wouldn't that
be sufficient?  Currently it's passing the largest supported page size,
that is 64k.  However this constant is always passed even when a smaller
page size is configured.

>  Finally, I'm not sure such a
> noticeable change was a good move in these late days of 2.4...

TLB reloads have been shown to be a major performance problem; this is an
not yet completed attempt to improve the situation so people don't need
to go for crude hacks such as wired TLB entires and similar.

Other parts of improvments such as hugetlbfs are available in 2.6 only
anyway.  I'm also thinking of changing the pagetable structure back to
the aggressivly optmized thing we were using before Linux 2.0.14 - but
certainly not for 2.4 - too intrusive, as you say.  With most MIPS users
being embedded users I still expect 2.4 to live for quite a while -
certainly longer than I'd like to see ...

  Ralf
