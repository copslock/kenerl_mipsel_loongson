Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA12058; Tue, 3 Jun 1997 15:15:22 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA15508 for linux-list; Tue, 3 Jun 1997 15:15:06 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15491 for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 15:15:04 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA07996
	for <linux@relay.engr.SGI.COM>; Tue, 3 Jun 1997 15:15:03 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id SAA15185; Tue, 3 Jun 1997 18:13:45 -0400
Date: Tue, 3 Jun 1997 18:13:42 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: The Plan For Userland(tm)
In-Reply-To: <199706031823.UAA01401@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970603180712.25914M-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

-----BEGIN PGP SIGNED MESSAGE-----

On Tue, 3 Jun 1997, Ralf Baechle wrote:
> > - rpm built

I'm almost there.  _almost_.

I need to link it with libz, which I just realized is really called zlib,
not the zlibc found on prep.ai.mit.edu.  Who knew?  I'm just getting
problmes now with glibc's crt1.o, which I know little or nothing about.

Ralph, can you give us (Mike or I) a copy of your SSH's?  We will in turn
keep you up to date with our userland binaries, and hopefully we can move
towards sharing RPMs, both source and binary. 

mips-linux-gcc, incidentally, is very impressive.

- - Alex


      Alex deVries           "Alex can cut a mean rug."
  System Administrator       - M. Dittberner <shabby@engsoc.carleton.ca>
   The EngSoc Project     


-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQB1AwUBM5SXGe5CP+X51y2VAQG/+QL/fibKfgBkkO/qmT5lSvU1guwLdpDrp22K
kyt5zzuMkpNqMBGW1uS8vBrs9UFxJdADtrKrCzVTP9jVTSIBYZKbXTOZUdeII7Ak
pdtvKkU5fpgRsErFVyFLnEO4IroNq0GK
=kBWg
-----END PGP SIGNATURE-----
