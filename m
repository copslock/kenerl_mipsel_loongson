Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id OAA143578; Sat, 9 Aug 1997 14:12:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA25977 for linux-list; Sat, 9 Aug 1997 14:12:20 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA25967 for <linux@engr.sgi.com>; Sat, 9 Aug 1997 14:12:14 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA19624
	for <linux@engr.sgi.com>; Sat, 9 Aug 1997 14:12:12 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id XAA01472; Sat, 9 Aug 1997 23:12:01 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708092112.XAA01472@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id XAA16857; Sat, 9 Aug 1997 23:11:57 +0200
Subject: Re: your mail
To: vincent@waw.com (Vincent Renardias)
Date: Sat, 9 Aug 1997 23:11:56 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970809214814.29239A-100000@odin.waw.com> from "Vincent Renardias" at Aug 9, 97 10:05:02 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> % mips-linux-gcc  -o pwgen pwgen.o -lm
> /usr/local/mips-linux/lib/libc.a: could not read symbols: Archive has no
> index; run ranlib to add one
> 
> running mips-linux-ranlib on the given file does not change anything.
> (ie: still getting the same message)
> 
> Did I do anything wrong, or is this a problem in the Linux/SGI glibc?

No.  Looks as if your lib still isn't correctly installed.  If ranlib
doesn't help, then your libc.a is probably corrupted into a zero lenght
file.

  Ralf
