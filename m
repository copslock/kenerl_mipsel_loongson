Received:  by oss.sgi.com id <S553716AbQJXBW5>;
	Mon, 23 Oct 2000 18:22:57 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:26097 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553679AbQJXBWz>;
	Mon, 23 Oct 2000 18:22:55 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9O1LP303349;
	Mon, 23 Oct 2000 18:21:25 -0700
Message-ID: <39F4E4C2.A9570003@mvista.com>
Date:   Mon, 23 Oct 2000 18:24:18 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: pthread_create() gets BUS ERROR
References: <39EF765A.EC787ED6@mvista.com> <20001020003946.E20887@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Thu, Oct 19, 2000 at 03:31:54PM -0700, Jun Sun wrote:
> 
> > I am running a simple pthread_create() test.  The thread gets created,
> > but the creating thread gets BUS error after the function call.  In
> > fact, it gets SIGUSR1 signal.  Does anybody know what is wrong here?
> >
> > It looks to me that creating thread is waiting for the created thread to
> > start up, but somehow did not install the signal handler correctly!?
> >
> > I am running with the "stable" toolchain that I generated recently,
> > i.e., binutil 2.8.1, egcs 1.0.3a and glibc2.0.6.
> 
> Which libc release exactly?
> 
> I've uploaded another release glibc-2.0.6-7lm to oss:/pub/linux/mips/glibc/.
> In case you're running big endian, could you try that release?
> 
> (Sorry, no source, will upload the srpm tomorrow.)
> 
>   Ralf


Since Ralf has not posted his patch for glibc yet, I looked into the
problem a little bit more.

It appears to be another toolchain related problem, instead of a glibc
problem.

In linuxthread/pthread.c:pthread_initialize_manager(), it accesses a
global variable __pthread_initial_thread_bos in pthread shared library. 
Apparently the code finds out the address of the variable through some
table (why is that?).  It looks like the offset for variable is off by
8.  Another ld problem?

I am using the "old but stable" toolchains, as I stated in an earlier
email. :-9

Jun

======

"...
I finally settled down with the old but deemed reliable versions :

a) binutils v2.8.1 + mips patch 

ftp://sourceware.cygnus.com/pub/binutils/releases/
ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-2.8.1-3.diff.gz

b) egcs 1.0.3a + mips patch

ftp://ftp.mvista.com/pub/Area51/mips_le/misc/egcs-1.0.3a.tar.gz
ftp://oss.sgi.com/pub/linux/mips/egcs/egcs-1.0.3a-2.diff.gz


c) glibc 2.0.6 + mips patch

ftp://oss.sgi.com/pub/linux/mips/glibc/srpms/glibc-2.0.6-5lm.src.rpm
..."
