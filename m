Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA1344239 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 15:52:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA10093 for linux-list; Fri, 5 Sep 1997 15:51:03 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA10081 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 15:51:01 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA20078; Fri, 5 Sep 1997 15:51:00 -0700
Date: Fri, 5 Sep 1997 15:51:00 -0700
Message-Id: <199709052251.PAA20078@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
In-Reply-To: <199709050245.VAA03103@athena.nuclecu.unam.mx>
References: <199709050245.VAA03103@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > Hello guys,
 > 
 >     Ok, it seems our irix_elfmap routine is just fine, I just found
 > out with a simple test case that the code is trying to access memory
 > from the location at 0x200000 which is making my IRIX executables
 > crash (this one is crashing inside usinit ()).
 > 
 >     Is there something magic about 0x20000 on IRIX that I should be
 > aware of? 

     0x20000 (not 0x200000) is automatically mapped in a process
by the kernel when referenced.  See <sys/prctl.h> on IRIX for
the definitions.  Most of the fields you can probably ignore,
but you should set t_pid, t_rpid, and t_prid (where the latter is the value
of the $prid COP0 register).  Set t_pid and t_rpid to the pid of the process.
(They cannot really be different in IRIX.)

     The library is fetching the PID from t_pid instead of calling getpid()
for performance reasons.

     Simply automatically create the page in the page fault handler
when it is first referenced.  Treat as if it were an mmap() of /dev/zero
for 1 page.
