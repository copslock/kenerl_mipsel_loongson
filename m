Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA16924; Fri, 11 Apr 1997 07:15:53 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA19979 for linux-list; Fri, 11 Apr 1997 07:13:53 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA19967 for <linux@relay.engr.SGI.COM>; Fri, 11 Apr 1997 07:13:50 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id HAA21575 for <linux@relay.engr.SGI.COM>; Fri, 11 Apr 1997 07:13:42 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id PAA21979;
	Fri, 11 Apr 1997 15:12:14 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id PAA01052; Fri, 11 Apr 1997 15:11:52 +0200
Message-Id: <199704111311.PAA01052@kernel.panic.julia.de>
Subject: Re: More on the serial strangeness
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 11 Apr 1997 15:11:52 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199704090858.EAA08923@neon.ingenia.ca> from "Mike Shaver" at Apr 9, 97 04:58:17 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Received: from sgi.sgi.com (SGI.COM [192.48.153.1])
>         by alles.intern.julia.de (8.8.5/8.8.5) with SMTP id KAA19302
>         for <ralf@Julia.DE>; Fri, 11 Apr 1997 10:51:21 +0200
[...]
>Date: Wed, 9 Apr 1997 04:58:17 -0400 (EDT)

Two days for that mail?

> - If I try to access /dev/console or /dev/tty[1234], I get "can't
> create /dev/whatever: Error 19", which seems to be "no such device".

Btw, Linux/MIPS errno values are (almost) the same as IRIX.

> If someone with the appropriate tools could build me a static tail
> binary, it'll make the experimentation go a fair bit faster.

This is the fun part.  You probably need to cheat to make textutils'
autoconf work for crosscompilation.  It's usually ok to run configure on
a Linux/Intel system (Using a glibc system is a good idea) and then
crosscompile with a command like

  make CC=mips-linux-gcc CFLAGS="-O2 -pipe" LDFLAGS="-static -s"

Autoconf is *nice* in almost all cases but it's often a bitch when
crosscompiling, so feel free to use every dirty trick in the book ...

> (If it'll help, I can set Miguel and Ralf up with appropriate access
> on neon so they can experiment.  It'll take a few days, but if it
> keeps those precious geek-cycle from going to waste...)

Thanks, would be useful.

  Ralf
