Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA22068; Tue, 15 Jul 1997 12:50:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA12623 for linux-list; Tue, 15 Jul 1997 12:50:06 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA12393 for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 12:49:28 -0700
Received: from jenolan.rutgers.edu (jenolan.rutgers.edu [128.6.111.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA10521
	for <linux@cthulhu.engr.sgi.com>; Tue, 15 Jul 1997 12:49:24 -0700
	env-from (davem@jenolan.rutgers.edu)
Received: (from davem@localhost)
	by jenolan.rutgers.edu (8.8.5/8.8.5) id PAA08407;
	Tue, 15 Jul 1997 15:48:12 -0400
Date: Tue, 15 Jul 1997 15:48:12 -0400
Message-Id: <199707151948.PAA08407@jenolan.rutgers.edu>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-reply-to: <199707151935.VAA00342@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Tue, 15 Jul 1997 21:35:53 +0200 (MET DST))
Subject: Re: Fun with binutils ...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Tue, 15 Jul 1997 21:35:53 +0200 (MET DST)

    - GAS still doesn't deal with _huge_ loops.  The only program I know
      of which is affected is lmbench, but that alone is reason enough
      to fix it :-)

It is not a bug, just that we have the local label semantics specified
for linux-mips differently in gcc and gas.  I fixed this ages ago and
it made lat_ctx.c compile just fine.
