Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA12611; Fri, 7 Mar 1997 13:41:03 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA19630 for linux-list; Fri, 7 Mar 1997 21:40:54 GMT
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA19619 for <linux@relay.engr.SGI.COM>; Fri, 7 Mar 1997 13:40:52 -0800
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA03811 for <linux@relay.engr.SGI.COM>; Fri, 7 Mar 1997 13:40:46 -0800
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id WAA04572;
	Fri, 7 Mar 1997 22:39:43 +0100
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id WAA16621; Fri, 7 Mar 1997 22:38:36 +0100
Message-Id: <199703072138.WAA16621@kernel.panic.julia.de>
Subject: Re: Linux/SGI
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Fri, 7 Mar 1997 22:38:35 +0100 (MET)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199703071951.NAA10311@athena.nuclecu.unam.mx> from "Miguel de Icaza" at Mar 7, 97 01:51:32 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello,

>    This is kind of a test message to see if we are (Ralf and I) are on
> the SGI Linux mailing list.
>  
>    Ralf and I have joined the Linux/SGI project (he will mail his very
> own presentation later).  The idea basically is that we will be
> getting a machine each one to finish the Linux on SGI port.

   Thanks for the introduction Miguel; I'd like to use the chance to drop
some words about what I'm doing right now on Linux and what the status
of this is.

   As you know David left SGI again in the late August.  At that time he
had not only completed a good part of the SGI specific stuff but also
made a lot of improofments to the generic MIPS parts of the kernel.  At
that time his kernel was based on Linus' 2.0.14.

  At the same time I was working mostly independend of him; luckily.  My target
machines were at that time the good old Magnum 4000 and it's OEM variant
M700-10 from Olivetti, the Magnum based Acer PICA machine and SNI's RM200.
When Ariel mailed me about working on Linux/SGI my kernel for these
machines was based on Linux 2.1.21.

  It's obvious that our kernels have diverged a good bit from each other
and right now I'm working on merging both kernel sources into one single
tree again.

  The second most important part of the system is libc.  On MIPS we use
the GNU which has the enormous advantage of being far more portable and
cleaner code than the Linux Libc on which most Linux/i386 systems are
based.  Disadvantage is that GNU libc was much buggier than Linux Libc.
This has changed a lot and so libc presents itself already quite near
to a release (*) libc but there is still some work to do.

  Similar for the other core parts of the system on which David worked but
right now I'm still busy merging the kernel sources; the next step will
be libc.

  Ralf

*) famous last words
