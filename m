Received:  by oss.sgi.com id <S553777AbQJXVfG>;
	Tue, 24 Oct 2000 14:35:06 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:41979 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553774AbQJXVfA>;
	Tue, 24 Oct 2000 14:35:00 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9OLXQ328024;
	Tue, 24 Oct 2000 14:33:27 -0700
Message-ID: <39F600D6.A54FC824@mvista.com>
Date:   Tue, 24 Oct 2000 14:36:22 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: pthread_create() gets BUS ERROR
References: <39EF765A.EC787ED6@mvista.com> <20001020003946.E20887@bacchus.dhis.org> <39F4E4C2.A9570003@mvista.com> <20001024033743.B2816@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Mon, Oct 23, 2000 at 06:24:18PM -0700, Jun Sun wrote:
> 
> > Since Ralf has not posted his patch for glibc yet, I looked into the
> > problem a little bit more.
> 
> If you'd be waiting just a few minutes longer I'd have announced it :-)
> 
> The srpm is currently uploading to oss.sgi.com:/pub/linux/mips/glibc/
> srpms/glibc-2.0.6-7lm.src.rpm.  The file is 4682466 bytes long, so don't
> start downloading before it's completly uploaded :-)
> 
> > It appears to be another toolchain related problem, instead of a glibc
> > problem.
> >
> > In linuxthread/pthread.c:pthread_initialize_manager(), it accesses a
> > global variable __pthread_initial_thread_bos in pthread shared library.
> > Apparently the code finds out the address of the variable through some
> > table (why is that?).  It looks like the offset for variable is off by
> > 8.  Another ld problem?
> >
> > I am using the "old but stable" toolchains, as I stated in an earlier
> > email.:-9
> 
> This description somehow rings a bell.  I'll dig through my mailfolders
> and will post if I find something.
> 
>   Ralf

Since I suspect it is binutils problem, I tried to use the latest
binutil with egcs 1.0.3a and glibc 2.0.6.  This leads to unusable
userland programs - init hangs.  sash runs, but nothing else seems to
work.  Do that mean I should not mix up the versions among toolchains? 
Has anybody tried that above combo before?

I will try glibc-2.0.6-7lm.src.rpm, but I am very hopeful that it will
solve this problem.

BTW, has anybody got pthread running on any 2.4 Linux/MIPS?  I want to
know if I am just unlucky or else...

Jun
