Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03283; Thu, 16 May 1996 09:05:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA22884 for linux-list; Thu, 16 May 1996 16:03:40 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA22868 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 09:03:37 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id JAA03193; Thu, 16 May 1996 09:03:36 -0700
Message-Id: <199605161603.JAA03193@neteng.engr.sgi.com>
To: "David S. Miller" <davem@caip.rutgers.edu>
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
cc: lmlinux@neteng.engr.sgi.com, torvalds@cs.helsinki.fi,
        sparclinux-cvs@caipfs.rutgers.edu, alan@cymru.net
Subject: Re: lmbench with new checksum code... 
Date: Thu, 16 May 1996 09:03:36 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:             *Local* Communication bandwidths in megabytes/second
:             ----------------------------------------------------
: Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
:                                   reread reread (libc) (hand) read write
: --------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
: trombetas  Linux 1.99.3    8  4.8   25.0   17.4     18     24   41    36
: geneva.ru     SunOS 5.5    8  7.0   12.6   19.5     18     18   40    36
: negro.rut SunOS 4.1.3_U    4  2.0   19.5    8.2     18     24   41    36

THis is sorta weird - why is it that mmap reread is slower than file reread?
Do you have a kernel bcopy that is faster than memory read?

I think your 4.8MB/sec number is pretty studly.  That means you are 
checksumming 9MB/sec as well as the protocol stack on a system that 
bcopies at ~20MB/sec.  You're already better than 2x the SunOS code.
Call it a day, you won.
