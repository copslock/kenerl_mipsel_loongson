Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA97432 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 16:31:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA17417 for linux-list; Tue, 7 Oct 1997 16:30:51 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA17386 for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 16:30:49 -0700
Received: from dns.cobaltmicro.com ([209.19.61.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA06151
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 16:30:33 -0700
	env-from (ralf@mail2.cobaltmicro.com)
Received: from dull.cobaltmicro.com (dull.cobaltmicro.com [209.19.61.35])
	by dns.cobaltmicro.com (8.8.5/8.8.5) with ESMTP id QAA24302;
	Tue, 7 Oct 1997 16:30:14 -0700
From: Ralf Baechle <ralf@cobaltmicro.com>
Received: (from ralf@localhost)
	by dull.cobaltmicro.com (8.8.5/8.8.5) id QAA17826;
	Tue, 7 Oct 1997 16:28:08 -0700
Message-Id: <199710072328.QAA17826@dull.cobaltmicro.com>
Subject: Re: More Linux/SGI status
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Tue, 7 Oct 1997 16:28:07 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-Reply-To: <199710072241.RAA01259@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Oct 7, 97 05:41:38 pm
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

>    Ralf's fixes to the dynamic linker fixed the Xt applications.  Now,
> only the PAM remains to be fixed.

The PAM problem is also a dynamic linker problem.  It's (I hope) one the
last major showstopper class bugs that prevent just building a
Linux/MIPS distribution from 95% unchanged source packages - and
fullfilling all the promises to those loading hardware to me ...

Btw, I stopped the mega load test (Running many compilers and tools in
parallel) I posted recently after some more hours because the machine ran
out of swap, some processes died therefore and load < 100 isn't that
interesting ...

System call latencies were pretty lousy bad for MIPS kernel because
we were using a syscall handler written in C.  I rewrote the entire
thing in assembler and now we're as fast as a MMX Pentium accounting
for the different clock rates.  Pretty nice, because we actually have
to save/restore many more registers and deal with a more complex
system call convention.  Seven nops left to eleminate ...

>    So, where do we stand now?  So, the only bits missing now are:
> 
> 	1. me finishing the support for the X server.  just a hack
> 	   here and there.
> 
> 	1.b. Getting the other important bits of the RRM code in the
> 	   kernel. 
> 
> 	2. me fixing the mouse.
> 
> 	3. Would it be possible to negotiate with SGI management 
> 	   the posibility of shipping the IRIX runtime libraries and
> 	   the X server as found on IRIX with a Linux disrtibution?

Bad point in time, it has been pointed out to me that SGI's stock
was doing pretty bad ;-)

> 	4. A nice, easy-to use install program.  Taking the existing
> 	   Red Hat/Mustand install program and port it should be
> 	   pretty easy. 

  Ralf
