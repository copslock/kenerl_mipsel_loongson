Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA121630; Tue, 12 Aug 1997 13:23:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA06473 for linux-list; Tue, 12 Aug 1997 13:21:58 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA06449; Tue, 12 Aug 1997 13:21:55 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA23445; Tue, 12 Aug 1997 13:21:54 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199708122021.NAA23445@oz.engr.sgi.com>
Subject: Re: Precompiled kernel available ?
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Tue, 12 Aug 1997 13:21:54 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <199708122005.WAA01791@informatik.uni-koblenz.de> from "Ralf Baechle" at Aug 12, 97 10:05:41 pm
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:> -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
:> -mcpu=r4600 -mips2 -pipe  -c -o system.o system.c
:> system.c:17: #error "... You're fearless, aren't you?"
:> make[1]: *** [system.o] Error 1
:> make[1]: Leaving directory `/usr/src/adevries/linux/arch/mips/sgi/kernel'
:> make: *** [linuxsubdirs] Error 2
:> 
:> Heh.  I don't think anyone's called me fearless before.
:
:That's a shopstopper that I added on Ariel's request.  I don't think we
:need it anymore.  Ariel?
:
:  Ralf
:
Ah the early days when a build would likely not even run since you
didn't yet have a test machine over there...

Sure, if you think it is not needed (and people can actually build
something that would run on an Indy) then by all means delete it.

;-)

-- 
Peace, Ariel
