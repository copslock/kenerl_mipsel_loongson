Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA17123; Mon, 17 Jun 1996 13:58:13 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA26260 for linux-list; Mon, 17 Jun 1996 20:58:06 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA26244 for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jun 1996 13:58:04 -0700
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA17113 for <linux@neteng.engr.sgi.com>; Mon, 17 Jun 1996 13:58:04 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id NAA12238; Mon, 17 Jun 1996 13:58:03 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id NAA10393; Mon, 17 Jun 1996 13:58:02 -0700
Date: Mon, 17 Jun 1996 13:58:02 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606172058.NAA10393@fir.esd.sgi.com>
To: dm@sgi.com
Cc: linux@neteng.engr.sgi.com
Subject: Re: strace project
In-Reply-To: <199606172051.NAA16930@neteng.engr.sgi.com>
References: <199606172051.NAA16930@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 > 
 > I'm just curious how strace support for IRIX 6.2 is coming along?
 > 
 > It would be _extremely_ useful and make me _extremely_ happy to have
 > so that I can write all of the IRIX system call compatability code
 > when I return from my talks in the U.K. on Thursday.

       If by strace you mean tracing system call arguments and results,
try using par(1).  (It does not help if you want to decode argument structures,
however.)  Here is a sample:

<fir:5> par -s -SS date
Mon Jun 17 13:56:39 PDT 1996
    0mS was sent signal SIGUSR1
    0mS END-pause() errno = 4 (Interrupted system call)
    0mS received signal SIGUSR1
    0mS sigreturn(0x7fff2a00) OK
    1mS execve(/usr/bsd/date, 0x7fff2ea8, 0x7fff2eb0) errno = 2 (No such file or directory)
    1mS execve(/usr/new/date, 0x7fff2ea8, 0x7fff2eb0) errno = 2 (No such file or directory)
    1mS execve(/usr/people/wje/abi-bin/date, 0x7fff2ea8, 0x7fff2eb0) errno = 2 (No such file or directory)
    2mS execve(/usr/people/wje/irix-bin/date, 0x7fff2ea8, 0x7fff2eb0) errno = 2 (No such file or directory)
    2mS execve(/usr/bin/date, 0x7fff2ea8, 0x7fff2eb0) OK
   74mS open(/lib/rld, O_RDONLY, 04) = 3
   74mS read(3, <7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00>..., 52) = 52
   74mS lseek(3, 52, SEEK_SET) = 52
   74mS read(3, <70 00 00 00 00 00 00 a0 0f b6 00 a0 0f b6 00 a0>..., 96) = 96
   74mS elfmap(3, 0x7fff21bc, 2) = 0xfb60000
   75mS close(3) OK
   76mS getpagesize() = 4096
   77mS getpid() = 10390 ppid=10389
   78mS syssgi(SGI_TOSSTSAVE) OK
   78mS getpagesize() = 4096
   78mS brk(0x10002000) OK
   80mS time() = 835044999
   80mS ioctl(1, TCGETA, 0x7fff2cd8) = 0
   81mS write(1, "Mon Jun 17 13:56:39 PDT 1996\n", 29) = 29
   81mS prctl(PR_GETNSHARE) = 0
   81mS exit(0)
exit             : 1 times
read             : 2 times
write            : 1 times
open             : 1 times
close            : 1 times
time             : 1 times
brk              : 1 times
lseek            : 1 times
getpid           : 1 times
syssgi           : 2 times
ioctl            : 1 times
sysmp            : 2 times
execve           : 5 times
sigreturn        : 1 times
prctl            : 1 times
