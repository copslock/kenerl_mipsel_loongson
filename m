Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA07407; Fri, 30 May 1997 14:38:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA24469 for linux-list; Fri, 30 May 1997 14:37:47 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA24432 for <linux@engr.sgi.com>; Fri, 30 May 1997 14:37:41 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA10556
	for <linux@engr.sgi.com>; Fri, 30 May 1997 14:37:39 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id RAA22822; Fri, 30 May 1997 17:25:28 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705302125.RAA22822@neon.ingenia.ca>
Subject: Re: ah...
In-Reply-To: <199705301804.UAA18639@informatik.uni-koblenz.de> from Ralf Baechle at "May 30, 97 08:04:37 pm"
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Fri, 30 May 1997 17:25:28 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Ralf Baechle:
> One of the fun things with SGI...  Long time ago checked two SGI machines
> running different OS versions for reference.  In one of them the values
> for SOCK_STREAM and SOCK_DGRAM are swapped compared to the other.  I wonder
> why.  But anyway, at that time I choose to clone the constants from the
> newer one.

Solaris is the same way...it's probably an SVR thing.
(If you're going to use sockets, though, why not use the BSD values?)

> Grrr...  I somewhen moved the definitions of these constants from the
> generic header files to the machine specific header files and somehow
> lost the appropriate change to the library.  I did change this with an
> eye into the future (IRIX / ABI compatibility) so we wouldn't need some
> stupid conversion routine.  Actually I wonder why I was able to use
> bind, so I'll have to enquire my setup a bit closer.

FWIW, I'd prefer to keep the Linux constants, well, constant.
I don't see a problem with doing value swapping in an ABI routine
later on, a la Linux/SPARC<->Solaris.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
