Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA141214; Sat, 9 Aug 1997 12:43:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA09219 for linux-list; Sat, 9 Aug 1997 12:42:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09208 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 12:42:51 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA08922
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 12:42:49 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id VAA22164; Sat, 9 Aug 1997 21:42:40 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708091942.VAA22164@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id VAA16786; Sat, 9 Aug 1997 21:42:39 +0200
Subject: Re: your mail
To: vincent@waw.com (Vincent Renardias)
Date: Sat, 9 Aug 1997 21:42:38 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970809195755.24185B-100000@odin.waw.com> from "Vincent Renardias" at Aug 9, 97 08:40:06 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > Not the right thing, but won't hurt.  I shows that your libc is
> > not installed correctly.
> 
> I just installed the binutils/gcc crossdev packages from
> ftp.linux.sgi.com. Should i also install the glibc-2.0.4-1.tar.gz package
> from /pub/mips-linux? In case it matters my native libc is glibc-2.0.4
> (i386).

Well, it doesn't matter except that I built the executables with Linux
libc and you therefore need that one.  DANGER:  When you install libs
for a crosscompiler you will have to move the libs a bit around.
Just doing tar zxf ... -C / will fry your native system.  MIPS stuff
just has too much octane to be suitable as fuel for your Intel machine ;-)

Btw, as I'm writing this I've built about 88mb of binary .rpm packages
running native.  The sole problems I currently have is that the kernel
seems to have some memory corruption problem.  That is nasty because
it usually hits the bitmaps ...  It might as well explain Miguel's
recently reported NFS problem.

  Ralf
