Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA03597; Tue, 3 Jun 1997 17:46:29 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA02364 for linux-list; Tue, 3 Jun 1997 17:45:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA02318 for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 17:45:19 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA14995
	for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 17:45:13 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from flake (ralf@flake.uni-koblenz.de [141.26.4.37]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id CAA04699; Wed, 4 Jun 1997 02:41:21 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706040041.CAA04699@informatik.uni-koblenz.de>
Received: by flake (SMI-8.6/KO-2.0)
	id CAA05044; Wed, 4 Jun 1997 02:41:15 +0200
Subject: Re: The Plan For Userland(tm)
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Wed, 4 Jun 1997 02:41:14 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, shaver@neon.ingenia.ca,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970603180712.25914M-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Jun 3, 97 06:13:42 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I need to link it with libz, which I just realized is really called zlib,
> not the zlibc found on prep.ai.mit.edu.  Who knew?  I'm just getting
> problmes now with glibc's crt1.o, which I know little or nothing about.
> 
> Ralph, can you give us (Mike or I) a copy of your SSH's?  We will in turn

s/Ralph/Ralf/

> keep you up to date with our userland binaries, and hopefully we can move
> towards sharing RPMs, both source and binary. 

ssh is no big deal.  Builds out of the box.  You will just have to
tell it for which architecture you're building, ie:
./configure --prefix=/usr mips-linux

There is also a rpm source package for libz available, but for now you
can just use the libz.a and includes included with ssh.

> mips-linux-gcc, incidentally, is very impressive.

Just another GCC.

  Ralf
