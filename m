Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA92041 for <linux-archive@neteng.engr.sgi.com>; Wed, 15 Jul 1998 16:30:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA05325
	for linux-list;
	Wed, 15 Jul 1998 16:29:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA96875
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 15 Jul 1998 16:29:44 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from dirtpan.npiww.com (dirtpan.networkprograms.com [207.113.23.2]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA05089
	for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 16:29:40 -0700 (PDT)
	mail_from (dliu@npiww.com)
Received: from pluto.npi.com [192.9.202.51] by dirtpan.npiww.com (8.6.9/8.6.9) with ESMTP id PAA03267 for <linux@cthulhu.engr.sgi.com>; Wed, 15 Jul 1998 15:38:32 -0400
Date: Wed, 15 Jul 1998 19:48:43 -0400
Message-Id: <199807152348.TAA00114@pluto.npiww.com>
From: Dong Liu <dliu@npiww.com>
To: linux@cthulhu.engr.sgi.com
Subject: libpthread of hard hat still doesn't work
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This is what I got

/usr/lib/libpthread.so: undefined reference to `__libc_accept'
/usr/lib/libpthread.so: undefined reference to `__libc_send'
/usr/lib/libpthread.so: undefined reference to `__libc_recvfrom'
/usr/lib/libpthread.so: undefined reference to `__libc_recvmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_sendmsg'
/usr/lib/libpthread.so: undefined reference to `__libc_recv'
/usr/lib/libpthread.so: undefined reference to `__libc_sendto'
/usr/lib/libpthread.so: undefined reference to `__libc_connect'


Thanks!

Dong.
