Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA1373789 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 19:01:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA04047 for linux-list; Fri, 5 Sep 1997 19:00:30 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04019 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 19:00:27 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA20744; Fri, 5 Sep 1997 19:00:26 -0700
Date: Fri, 5 Sep 1997 19:00:26 -0700
Message-Id: <199709060200.TAA20744@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
In-Reply-To: <199709052347.SAA09349@athena.nuclecu.unam.mx>
References: <199709052251.PAA20078@fir.engr.sgi.com>
	<199709052347.SAA09349@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > >      0x20000 (not 0x200000) is automatically mapped in a process
 > > by the kernel when referenced.  See <sys/prctl.h> on IRIX for
 > > the definitions.  
 > 
 > Ok, thanks for the pointer.  btw, the code seems to indicate that the
 > address is indeed 0x200000 (it does a lui $reg,0x20).  Oops.  Hold
 > on.  The sys/prctl agrees with me, it is 0x200000.

    Yes, you are correct.  

...
 > > Most of the fields you can probably ignore, but you should set
 > > t_pid, t_rpid, and t_prid (where the latter is the value of the
 > > $prid COP0 register).  Set t_pid and t_rpid to the pid of the
 > > process.  (They cannot really be different in IRIX.)
 > 
 > Ok.  There is another bit that looks promising: the t_cpu field, which
 > is supposed to have the cpu number where the process is executing.
 > Does IRIX update this on every context switch? 

     Yes, on a multiprocessor, but it is a constant on a uniprocessor.

 > >      Simply automatically create the page in the page fault handler
 > > when it is first referenced.  Treat as if it were an mmap() of /dev/zero
 > > for 1 page.
 > 
 > Ok.  The code that I used last night to work around this was to map
 > a /dev/zero page at sys_irix_elfexec time, I think I will just poke
 > the right values there.

      As someone else pointed out, mapping the page is sys_irix_elfexec
time is probably better, since it will avoid slowing down the page
fault handler.
