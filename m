Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA119887; Tue, 12 Aug 1997 12:20:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA13090 for linux-list; Tue, 12 Aug 1997 12:19:22 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA12908 for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 12:18:36 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA15902
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 12:18:33 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id PAA21518; Tue, 12 Aug 1997 15:17:40 -0400
Date: Tue, 12 Aug 1997 15:17:40 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Shaver <shaver@neon.ingenia.ca>
cc: Jan Rychter <jwr@icm.edu.pl>, linux@cthulhu.engr.sgi.com
Subject: Re: Precompiled kernel available ?
In-Reply-To: <199708121836.OAA12605@neon.ingenia.ca>
Message-ID: <Pine.LNX.3.95.970812151611.11852C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hmmmm... my compile error today was quite entertaning.  I'm crosscompiling
on an PPro/Linux system:

t' declared inside parameter list
/usr/src/adevries/linux/include/asm/processor.h:146: warning: its scope is
only this definition or declaration,
/usr/src/adevries/linux/include/asm/processor.h:146: warning: which is
probably not what you want.
mips-linux-gcc -D__KERNEL__ -I/usr/src/adevries/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe  -c -o indy_int.o indy_int.c
mips-linux-gcc -D__KERNEL__ -I/usr/src/adevries/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -pipe  -c -o system.o system.c
system.c:17: #error "... You're fearless, aren't you?"
make[1]: *** [system.o] Error 1
make[1]: Leaving directory `/usr/src/adevries/linux/arch/mips/sgi/kernel'
make: *** [linuxsubdirs] Error 2


Heh.  I don't think anyone's called me fearless before.

- Alex
