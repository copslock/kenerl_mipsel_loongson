Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA47386 for <linux-archive@neteng.engr.sgi.com>; Sat, 8 May 1999 04:59:59 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA96506
	for linux-list;
	Sat, 8 May 1999 04:57:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA46474
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 8 May 1999 04:57:44 -0700 (PDT)
	mail_from (hanwen@cs.uu.nl)
Received: from mail.cs.uu.nl (sunset.cs.uu.nl [131.211.80.32]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04442
	for <linux@cthulhu.engr.sgi.com>; Sat, 8 May 1999 07:57:43 -0400 (EDT)
	mail_from (hanwen@cs.uu.nl)
Date: Sat, 8 May 1999 07:57:43 -0400 (EDT)
Message-Id: <199905081157.HAA04442@sgi.com>
Received: from sunshine.cs.uu.nl.cs.uu.nl (sunshine.cs.uu.nl [131.211.80.33])
	by mail.cs.uu.nl (Postfix) with SMTP id A7841453A
	for <linux@cthulhu.engr.sgi.com>; Sat,  8 May 1999 13:57:41 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
To: linux@cthulu.engr.sgi.com
Subject: success/ quirks.
X-Mailer: VM 6.64 under Emacs 20.2.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hi guys,


just a little success / quirk report.  I got my hands on a 24 bit
R4600 Indy when my university ditched them all (they switched to Sun
machines), and I now use it as as very luxurious X-terminal to my
lowly linux PC.  After some tweaking I managed to boot Linux on the
machine as well, and installed it on the 2nd HD.

I have some remarks/bugreports:

  * the size of /proc/kcore was ludicrous for a 32 MB machine,

  -r--r--r--   1 root     root            0 May  6 23:24 ioports
  -r--------   1 root     root     167354368 May  6 23:24 kcore
  -r--------   1 root     root            0 May  6 23:22 kmsg

  * I  couldn't get g++ working.  The linker gave up after saying:

  /usr/lib/libstdc++.so: undefined reference to `__unwind_function'
  /usr/lib/libstdc++.so: undefined reference to
  `__find_first_exception_table_match'
  /usr/lib/libstdc++.so: undefined reference to
  `__register_exceptions'
collect2: ld returned 1 exit status

This was with Hard hat (snatched from a RH mirror), and
vmlinux-indy-2.2.1-990329 kernel.  I can send you a bootlog as well.

Finally, what is the status of Linux/Indy Xserver?  (I know I should
contribute instead of asking, but hey, I'm spending lots of time on
free s/w already.)

In any case, keep up the good work.  Blue computers are so cool!



-- 

Han-Wen Nienhuys, hanwen@cs.uu.nl ** GNU LilyPond - The Music Typesetter 
      http://www.cs.uu.nl/people/hanwen/lilypond/index.html 
