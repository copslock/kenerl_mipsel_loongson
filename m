Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA2267318 for <linux-archive@neteng.engr.sgi.com>; Wed, 22 Apr 1998 14:04:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id OAA15167756
	for linux-list;
	Wed, 22 Apr 1998 14:03:20 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA15259774
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Apr 1998 14:03:18 -0700 (PDT)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via SMTP id OAA00457
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 14:03:15 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from mailhub.networkprograms.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id RAA20660 for <linux@cthulhu.engr.sgi.com>; Wed, 22 Apr 1998 17:04:43 -0400
Date: Wed, 22 Apr 1998 17:19:13 -0400
Message-Id: <199804222119.RAA20883@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com
Subject: glibc problem
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I want to try some pthread program on sgi-linux, this is what I got

/usr/lib/libpthread.so: undefined reference to `__libc_accept'
/usr/lib/libpthread.so: undefined reference to `__libc_send'
/usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
/usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_recv'
/usr/lib/libpthread.so: undefined reference to `__libc_sendto'
/usr/lib/libpthread.so: undefined reference to `__libc_connect'

my glibc is glibc-2.0.6-1, so I went ftp.redhat.com downloaded
glibc-2.0.7, but I can't build it. Where can I found sgi-linux
specific patches for glibc.

Dong.
