Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA2285334 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 20:10:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id UAA15311971
	for linux-list;
	Wed, 22 Apr 1998 20:08:37 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA4904864
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 20:08:35 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id UAA14492
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 20:08:33 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id FAA13145
	for <linux@cthulhu.engr.sgi.com>; Thu, 23 Apr 1998 05:08:30 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id FAA05813;
	Thu, 23 Apr 1998 05:04:47 +0200
Message-ID: <19980423050447.63659@uni-koblenz.de>
Date: Thu, 23 Apr 1998 05:04:47 +0200
To: Dong Liu <dliu@npiww.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: glibc problem
References: <199804222119.RAA20883@pluto.npiww.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804222119.RAA20883@pluto.npiww.com>; from Dong Liu on Wed, Apr 22, 1998 at 05:19:13PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 22, 1998 at 05:19:13PM -0400, Dong Liu wrote:

> I want to try some pthread program on sgi-linux, this is what I got
> 
> /usr/lib/libpthread.so: undefined reference to `__libc_accept'
> /usr/lib/libpthread.so: undefined reference to `__libc_send'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
> /usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
> /usr/lib/libpthread.so: undefined reference to `__libc_recv'
> /usr/lib/libpthread.so: undefined reference to `__libc_sendto'
> /usr/lib/libpthread.so: undefined reference to `__libc_connect'

Thanks for your report.  An untested patch to be applied to
libc/sysdeps/unix/sysv/linux/mips/syscalls.list is attached below.

> my glibc is glibc-2.0.6-1, so I went ftp.redhat.com downloaded
> glibc-2.0.7, but I can't build it. Where can I found sgi-linux
> specific patches for glibc.

You can find the patches In the rpm packages on ftp.linux.sgi.com.

I don't know if the MIPS patches for glibc 2.0.6 are working for 2.0.7.
Unless I missed the announcement 2.0.7 hasn't been released yet and I
don't try to follow the beta releases, no time ...

  Ralf

Index: unix/sysv/linux/mips/syscalls.list
===================================================================
RCS file: /disk2/cvs/libc/sysdeps/unix/sysv/linux/mips/syscalls.list,v
retrieving revision 1.1
diff -u -r1.1 syscalls.list
--- syscalls.list	1997/06/21 23:58:37	1.1
+++ syscalls.list	1998/04/22 06:25:06
@@ -16,19 +16,19 @@
 # Socket functions; Linux/MIPS doesn't use the socketcall(2) wrapper;
 # it's provided for compatibility, though.
 #
-accept		-	accept		3	__accept	accept
+accept		-	accept		3	__libc_accept	__accept accept
 bind		-	bind		3	__bind		bind
-connect		-	connect		3	__connect	connect
+connect		-	connect		3	__libc_connect	__connect connect
 getpeername	-	getpeername	3	__getpeername	getpeername
 getsockname	-	getsockname	3	__getsockname	getsockname
 getsockopt	-	getsockopt	5	__getsockopt	getsockopt
 listen		-	listen		2	__listen	listen
-recv		-	recv		4	__recv		recv
-recvfrom	-	recvfrom	6	__recvfrom	recvfrom
-recvmsg		-	recvmsg		3	__recvmsg	recvmsg
-send		-	send		4	__send		send
-sendmsg		-	sendmsg		3	__sendmsg	sendmsg
-sendto		-	sendto		6	__sendto	sendto
+recv		-	recv		4	__libc_recv	__recv recv
+recvfrom	-	recvfrom	6	__libc_recvfrom	__recvfrom recvfrom
+recvmsg		-	recvmsg		3	__libc_recvfrom	__recvmsg recvmsg
+send		-	send		4	__libc_send	__send send
+sendmsg		-	sendmsg		3	__libc_sendmsg	__sendmsg sendmsg
+sendto		-	sendto		6	__libc_sendto	__sendto sendto
 setsockopt	-	setsockopt	5	__setsockopt	setsockopt
 shutdown	-	shutdown	2	__shutdown	shutdown
 socket		-	socket		3	__socket	socket
