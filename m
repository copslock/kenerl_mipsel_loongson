Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA01489; Thu, 10 Apr 1997 08:25:45 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA11132 for linux-list; Thu, 10 Apr 1997 08:25:04 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA11117 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 08:25:02 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id IAA13900 for <linux@relay.engr.SGI.COM>; Thu, 10 Apr 1997 08:24:45 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id QAA06445;
	Thu, 10 Apr 1997 16:23:03 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id QAA10766; Thu, 10 Apr 1997 16:22:14 +0200
Message-Id: <199704101422.QAA10766@kernel.panic.julia.de>
Subject: Re: all in the family
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Thu, 10 Apr 1997 16:22:14 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
In-Reply-To: <199704101453.KAA21432@neon.ingenia.ca> from "Mike Shaver" at Apr 10, 97 10:53:19 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Thus spake Miguel de Icaza:
> > > Anyone know if the emulation is up to hosting the Linux/Indy
> > > cross-compiler?
> > 
> > Why do you need the emulation for on Linux/SPARC?   You just need to
> > run configure on Linux/SPARC with the proper --target option and you
> > will get your native cross-compiler in a second.
> 
> I was under the impression that building GCC for the Linux/SGI target
> was non-trivial.  Ralf made mention of some patches, and since there
> are binaries available for Solaris...
> 
> If GCC can support it with a --target choice, that'll be great.

(I think you're confusing host and target.  If you want IRIX to generate
code for Linux the IRIX is the host and Linux the target os).

GCC does that as well as the binutils.  Truely pervert people can even
build GCC / binutils on a host of type a to run on type b and generate
code for type c.  I did that once or twice to build the first native
compiler for Linux/MIPS.

Try something like:

  ./configure --prefix=/usr --target=mips-linux

to configure binutils and GCC.

  Ralf
