Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA00364; Wed, 9 Apr 1997 08:23:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA07729 for linux-list; Wed, 9 Apr 1997 08:22:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA07691 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 08:22:29 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id IAA01626 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 08:19:52 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id MAA18135;
	Wed, 9 Apr 1997 12:07:49 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id MAA06864; Wed, 9 Apr 1997 12:06:52 +0200
Message-Id: <199704091006.MAA06864@kernel.panic.julia.de>
Subject: Re: serial consoles, sash and other wonders
To: wje@fir.esd.sgi.com (William J. Earl)
Date: Wed, 9 Apr 1997 12:06:52 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com
In-Reply-To: <199704081948.MAA14047@fir.esd.sgi.com> from "William J. Earl" at Apr 8, 97 12:48:07 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

>      By the way, it is pretty easy to write a little program to convert
> a kernel ELF binary to an ECOFF binary, discarding most of the symbols and
> other stuff, assuming you have the header files for the file formats.
> (The result would not be acceptable to many of the tools, such as dbx,
> but it would be bootable.)
> 
>      For a production linux for the Indy, the most reasonable approach,
> however, would be to make silo or whatever boot program you are using be
> ECOFF, so that old PROMs are supported.

I also have to deal with ARC machines (the little endian NT stuff).  By
definiton they have to support ECOFF; everything else is optional.  This
brings in the extra issue that the loader needs to be relocatable.
MIPS-ECOFF configurations of GCC can't do that and the linker dies when
loading ELF PIC code into an ECOFF executable.  Unfortunately fixing is
nontrivial.

The {Net,Open}BSD people already have a converter tool which they use to
generate their kernel executable.  It would solve the ld problems.
I did some work on it and I should probably finish it ...

  Ralf
