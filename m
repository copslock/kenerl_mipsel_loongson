Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA59994 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 16:56:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA02441 for linux-list; Fri, 5 Sep 1997 16:55:28 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA02424 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 16:55:26 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA20408; Fri, 5 Sep 1997 16:55:20 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA02349; Fri, 5 Sep 1997 16:55:15 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA26810; Fri, 5 Sep 1997 16:55:11 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA09349;
	Fri, 5 Sep 1997 18:47:53 -0500
Date: Fri, 5 Sep 1997 18:47:53 -0500
Message-Id: <199709052347.SAA09349@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: wje@fir.engr.sgi.com
CC: linux@fir.engr.sgi.com
In-reply-to: <199709052251.PAA20078@fir.engr.sgi.com> (wje@fir.engr.sgi.com)
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
X-Windows: Form follows malfunction.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>      0x20000 (not 0x200000) is automatically mapped in a process
> by the kernel when referenced.  See <sys/prctl.h> on IRIX for
> the definitions.  

Ok, thanks for the pointer.  btw, the code seems to indicate that the
address is indeed 0x200000 (it does a lui $reg,0x20).  Oops.  Hold
on.  The sys/prctl agrees with me, it is 0x200000.

That structure looks very promising, I will go and fill it.

> Most of the fields you can probably ignore, but you should set
> t_pid, t_rpid, and t_prid (where the latter is the value of the
> $prid COP0 register).  Set t_pid and t_rpid to the pid of the
> process.  (They cannot really be different in IRIX.)

Ok.  There is another bit that looks promising: the t_cpu field, which
is supposed to have the cpu number where the process is executing.
Does IRIX update this on every context switch? 

>      Simply automatically create the page in the page fault handler
> when it is first referenced.  Treat as if it were an mmap() of /dev/zero
> for 1 page.

Ok.  The code that I used last night to work around this was to map
a /dev/zero page at sys_irix_elfexec time, I think I will just poke
the right values there.

best wishes and thanks for this pointer!
Miguel.
