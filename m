Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA138237; Sat, 9 Aug 1997 10:42:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA18660 for linux-list; Sat, 9 Aug 1997 10:41:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA18651 for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 10:41:53 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA23174
	for <linux@cthulhu.engr.sgi.com>; Sat, 9 Aug 1997 10:41:50 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id TAA09294; Sat, 9 Aug 1997 19:41:41 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708091741.TAA09294@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id TAA16668; Sat, 9 Aug 1997 19:41:40 +0200
Subject: Re: your mail
To: vincent@waw.com (Vincent Renardias)
Date: Sat, 9 Aug 1997 19:41:39 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970809175116.19882B-100000@odin.waw.com> from "Vincent Renardias" at Aug 9, 97 06:16:02 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 	I've just joined this ML, and I'm trying to contribute to the
> Linux/SGI development. Since I'm not too good at kernel hacking, I've
> tough about working on porting the userland part (I have some experience
> with this part since I've been a Debian developper for a while and
> initiated the Debian/PowerPC port).
> 	By now I don't have access to any SGI hardware, but i've been able
> to build some packages with the crossdev (i486-linux) packages from
> ftp.linux.sgi.com.
> 
> 	So here are my questions:
> 
> 1/ Which are the 'most wanted' packages not yet recompiled/ported to
> Linux/SGI? I've looked at the RPMs available RPM list, and some important
> packages seem unavailable yet. (sed,tar,perl come to mind).

sed, tar: confilicting declaration in source and libc.  Both work other-
wise.  Perl: builds shrink wrapped & works, just the binary packaging
with RPM fails.  I think because groff/man are missing.  I've got another
two dozen packages on disk which I'll upload when I next pass by in
Mountain View ...

> 2/ While using the crossdev gcc, several times I got complains about a
> file 'sgidefs.h' missing (from
> /usr/local/lib/gcc-lib/mips-linux/2.7.2/include/va-mips.h, line 41). 
> Commenting the '#include' file made the compile work, but I not sure it's
> the right fix. 

Not the right thing, but won't hurt.  I shows that your libc is
not installed correctly.

> 3/ Can any1 confirm/correct the following values for GNU/autoconf:

> ac_cv_c_bigendian=no

MIPS CPUs can be configured for both byte orders.  SGI, Mips Inc.,
Sony machines are wired big endian, most other machines are little
endian or configurable by replacing the firmware.  As a consequence
we have to build all packages twice, once for each byte sex.
mips-linux-* tools are big endian by default, mipsel-linux-* tools
little endian.

> ac_cv_c_char_unsigned=no

True by default, unless you give -funsigned-char.

> ac_cv_sizeof_long=4
> ac_cv_sizeof_int=4

True by default in the mips{el}-linux configurations; the size of
these types can be changed by -mlong64 and -mint64.  These options
are incompatible with libc, so I mention them only for completeness.

  Ralf
