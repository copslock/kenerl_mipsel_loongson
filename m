Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA2427711 for <linux-archive@neteng.engr.sgi.com>; Fri, 24 Apr 1998 08:46:15 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA16137304
	for linux-list;
	Fri, 24 Apr 1998 08:45:00 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA15992156
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 24 Apr 1998 08:44:57 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id IAA04375
	for <linux@cthulhu.engr.sgi.com>; Fri, 24 Apr 1998 08:44:56 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id LAA30119; Fri, 24 Apr 1998 11:46:17 -0400
Date: Fri, 24 Apr 1998 12:00:32 -0400
Message-Id: <199804241600.MAA05998@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: ralf@uni-koblenz.de
Cc: Dong Liu <dliu@npiww.com>, linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
In-Reply-To: <19980423050447.63659@uni-koblenz.de>
References: <199804222119.RAA20883@pluto.npiww.com>
	<19980423050447.63659@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > 
 > Thanks for your report.  An untested patch to be applied to
 > libc/sysdeps/unix/sysv/linux/mips/syscalls.list is attached below.
 > 
 > > my glibc is glibc-2.0.6-1, so I went ftp.redhat.com downloaded
 > > glibc-2.0.7, but I can't build it. Where can I found sgi-linux
 > > specific patches for glibc.
 > 
 > You can find the patches In the rpm packages on ftp.linux.sgi.com.
 > 
 > I don't know if the MIPS patches for glibc 2.0.6 are working for 2.0.7.
 > Unless I missed the announcement 2.0.7 hasn't been released yet and I
 > don't try to follow the beta releases, no time ...
 > 
 >   Ralf

Nope, after 4 hours building new glibc, it gives me same error for
undefined reference to __libc_accept ... :=*(.

Another bug is invokinf "/lib/ld.so.1 --verify " gives segmentation
fault, so ldd dosn't work.

BTW, I get glibc 2.0.7 from redhat's updates directory.

Dong.
