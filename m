Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA2661634 for <linux-archive@neteng.engr.sgi.com>; Mon, 27 Apr 1998 16:25:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA17103924
	for linux-list;
	Mon, 27 Apr 1998 16:22:23 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA17413157
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 27 Apr 1998 16:21:48 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id QAA22011
	for <linux@cthulhu.engr.sgi.com>; Mon, 27 Apr 1998 16:21:38 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id TAA18859; Mon, 27 Apr 1998 19:23:58 -0400
Date: Mon, 27 Apr 1998 19:37:42 -0400
Message-Id: <199804272337.TAA14149@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <199804241600.MAA05998@pluto.npiww.com>
References: <199804222119.RAA20883@pluto.npiww.com>
	<19980423050447.63659@uni-koblenz.de>
	<199804241600.MAA05998@pluto.npiww.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Dong Liu writes:
 > ralf@uni-koblenz.de writes:
 >  > 
 >  > Thanks for your report.  An untested patch to be applied to
 >  > libc/sysdeps/unix/sysv/linux/mips/syscalls.list is attached below.
 >  > 
 >  > > my glibc is glibc-2.0.6-1, so I went ftp.redhat.com downloaded
 >  > > glibc-2.0.7, but I can't build it. Where can I found sgi-linux
 >  > > specific patches for glibc.
 >  > 
 >  > You can find the patches In the rpm packages on ftp.linux.sgi.com.
 >  > 
 >  > I don't know if the MIPS patches for glibc 2.0.6 are working for 2.0.7.
 >  > Unless I missed the announcement 2.0.7 hasn't been released yet and I
 >  > don't try to follow the beta releases, no time ...
 >  > 
 >  >   Ralf
 > 
 > Nope, after 4 hours building new glibc, it gives me same error for
 > undefined reference to __libc_accept ... :=*(.
 > 

Sorry, I didn't install it properly, now my program links, but it
still give segementation fault.

Dong.

BTW, can some one make a tarball of strace and gdb, I don't think I
can check them out from CVS.
