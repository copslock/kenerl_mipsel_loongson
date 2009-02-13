Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 23:53:14 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:36389 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S21367131AbZBMXxM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Feb 2009 23:53:12 +0000
Received: from Mobile0.Peter (194.105.100.66.dynamic.cablesurf.de [194.105.100.66])
	by mail1.pearl-online.net (Postfix) with ESMTP id 71D3BD5AF;
	Sat, 14 Feb 2009 00:53:14 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id n1E0shxO001258;
	Sat, 14 Feb 2009 00:54:43 GMT
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id n1DNok57000462;
	Sat, 14 Feb 2009 00:50:46 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id n1DNok25000459;
	Sat, 14 Feb 2009 00:50:46 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Sat, 14 Feb 2009 00:50:46 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	naresh kamboju <naresh.kernel@gmail.com>, linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
In-Reply-To: <20090211131649.GA1365@linux-mips.org>
Message-ID: <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter>
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com>
 <20090211131649.GA1365@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi Ralf,

there is one more good reason to ... : the Impact Xserver needs to do
a cacheflush(a,w,DCACHE) as part of the refresh-sequence.
And hence requires a sys_cacheflush, let's say, more conforming to the
man-page (or some disgusting new ioctl in the Impact kernel-driver to
do an equivalent operation ;-)

kind regards :-)


On Wed, 11 Feb 2009, Ralf Baechle wrote:

> Date: Wed, 11 Feb 2009 13:16:49 +0000
> From: Ralf Baechle <ralf@linux-mips.org>
> To: naresh kamboju <naresh.kernel@gmail.com>
> Cc: linux-mips@linux-mips.org
> Subject: Re: cacheflush system call-MIPS
>
> On Tue, Feb 10, 2009 at 08:46:58PM +0530, naresh kamboju wrote:
>
> > Hi Mr. Ralf,
> >
> > I have tried to test cacheflush system call to generate EINVAL
> >
> > on Toshiba RBTX4927/RBTX4937 board with 2.6.23 kernel.
> >
> > I have referred latest Man pages there is a bug column.
> >
> > Please let me know whether this is bug in source code or in the man page.
> >
> > (arch/mips/mm/cache.c)
>
> The answer is probably a bit of both.  The API and error behaviour was
> defined by the earlier MIPS UNIX variant RISC/os or possibly even earlier.
>
> Gcc relies on the existence of this syscall - or rather a library
> function which usually will be implemented to execute this syscall because
> the operating requires kernel priviledges - so Linux had to get an
> implementation as well.
>
> Now in practice there is only one good reason to perform explicit
> cacheflushes from userspace and that's to ensure I-cache coherency and
> that's the one thing the Linux implementation of cacheflush(2) is trying
> to do.  Therefore the implementation ignores the cache argument and
> will instead perform whatever is necessary to guarantee I-cache coherency -
> whatever this means on a particlar implementation.
>
> Similarly the implementation won't verify that every byte of the range
> is accessible.  For a large range it instead may choose to perform a full
> writeback / invalidation of some or all parts of the cache hierarchy
> which might mean there will not be an error return even though part of
> the address space may not be accessible.
>
> Talking about bugs - the "BUGS" section of the man page is wrong.  A full
> cacheflush is only performed if this is considered to be faster than a
> cacheline-by-cacheline flush.
>
>   Ralf
>
>
