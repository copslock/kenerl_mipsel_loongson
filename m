Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA41156 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Jun 1998 14:59:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA28887
	for linux-list;
	Wed, 3 Jun 1998 14:57:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA17840
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Jun 1998 14:57:14 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id OAA23806
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Jun 1998 14:57:06 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA25282
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Jun 1998 17:56:57 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 3 Jun 1998 17:56:57 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: strace
Message-ID: <Pine.LNX.3.95.980603175556.24778K-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I know this worked before.

I rebuilt strace from the CVS, and now it does:

[root@alex3 strace]# ./strace /bin/ls
execve("/bin/ls", ["/bin/ls"], [/* 17 vars */]) = 0
brk(0)                                  = -1 EFAULT (Bad address)
cacheflush(0x7ffffb60, 28, BCACHE)      = -1 EFAULT (Bad address)
cacheflush(0x7ffffae8, 28, BCACHE)      = -1 EFAULT (Bad address)
mmap(0x40d578, 24879, PROT_EXEC, 0 /* MAP_??? */, -1, 0xc) = -1 EFAULT
(Bad address)
write(2, "BUG IN DYNAMIC LINKER ld.so: ", 29) = -1 EFAULT (Bad address)
write(2, "dl-minimal.c", 12)            = -1 EFAULT (Bad address)
write(2, ": ", 2)                       = -1 EFAULT (Bad address)
write(2, "70", 2)                       = -1 EFAULT (Bad address)
write(2, ": ", 2)                       = -1 EFAULT (Bad address)
write(2, "malloc", 6)                   = -1 EFAULT (Bad address)
write(2, ": ", 2)                       = -1 EFAULT (Bad address)
write(2, "Assertion `", 11)             = -1 EFAULT (Bad address)
write(2, "page != (caddr_t) -1", 20)    = -1 EFAULT (Bad address)
write(2, "\' failed!\n", 10)            = -1 EFAULT (Bad address)
_exit(127)                              = ?
_exit returned!
) = ?
--- SIGBUS (Segmentation fault) ---
+++ killed by SIGBUS +++

Where should I start looking?


- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
