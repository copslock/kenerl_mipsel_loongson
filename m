Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA141844; Sat, 9 Aug 1997 13:01:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA13069 for linux-list; Sat, 9 Aug 1997 13:01:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA13062 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 13:01:30 -0700
Received: from odin.waw.com (ns1.waw.com [194.51.88.250]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA10954
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 13:01:27 -0700
	env-from (vincent@waw.com)
Received: from odin.waw.com (vincent@mail.waw.com [194.51.88.252]) by odin.waw.com (8.7.3/8.7.3/waw) with SMTP id WAA29835; Sat, 9 Aug 1997 22:05:02 +0100
Date: Sat, 9 Aug 1997 22:05:02 +0100 (GMT+0100)
From: Vincent Renardias <vincent@waw.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: your mail
In-Reply-To: <199708091942.VAA22164@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970809214814.29239A-100000@odin.waw.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sat, 9 Aug 1997, Ralf Baechle wrote:

> > I just installed the binutils/gcc crossdev packages from
> > ftp.linux.sgi.com. Should i also install the glibc-2.0.4-1.tar.gz package
> > from /pub/mips-linux? In case it matters my native libc is glibc-2.0.4
> > (i386).
> 
> Well, it doesn't matter except that I built the executables with Linux
> libc and you therefore need that one.  DANGER:  When you install libs
> for a crosscompiler you will have to move the libs a bit around.
> Just doing tar zxf ... -C / will fry your native system.  MIPS stuff
> just has too much octane to be suitable as fuel for your Intel machine ;-)

Debian provides nice tools to handdle this kind of installation:

- alien: allows to convert binary packages between any 2 of the
{.deb,.tgz,.rpm} formats.

- dpkg-cross: tool handdling cross-compilation packages. That is any file
that should go into /*/lib is redirected into /usr/local/$ARCH-linux/lib.
(same for the include files). It also makes it possible to build a given
package for several architectures at the same time.
Those tools should probably work on any Linux flavour (distrib./arch.)

Anyway, I've installed glibc-2.0.4 to get around the missing sgidefs.h
problem, and I run into another problem:
now mips-linux-gcc complains about:

% mips-linux-gcc  -o pwgen pwgen.o -lm
/usr/local/mips-linux/lib/libc.a: could not read symbols: Archive has no
index; run ranlib to add one

running mips-linux-ranlib on the given file does not change anything.
(ie: still getting the same message)

Did I do anything wrong, or is this a problem in the Linux/SGI glibc?

	Cordialement,

--
-     ** Linux **         +-------------------+             ** WAW **     -
-  vincent@debian.org     | RENARDIAS Vincent |          vincent@waw.com  -
-  Debian/GNU Linux       +-------------------+      http://www.waw.com/  -
-  http://www.debian.org/           |            WAW  (33) 4 91 81 21 45  -
---------------------------------------------------------------------------
