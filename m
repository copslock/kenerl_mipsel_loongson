Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05141; Tue, 18 Jun 1996 10:22:18 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA27398 for linux-list; Tue, 18 Jun 1996 17:22:13 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA27374 for <linux@cthulhu.engr.sgi.com>; Tue, 18 Jun 1996 10:22:10 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA14883; Tue, 18 Jun 1996 10:21:17 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199606181721.KAA14883@yon.engr.sgi.com>
Subject: Re: anyone know if this is true?
To: olson@anchor.engr.sgi.com (Dave Olson)
Date: Tue, 18 Jun 1996 10:21:17 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199606181711.KAA13973@anchor.engr.sgi.com> from "Dave Olson" at Jun 18, 96 10:11:49 am
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>
>It's not true.  All he has to do is install eoe.hdrs and compiler_eoe.hdrs.
>
Dave, I'm afraid you're misinformed. The problem is real.
Customers cannot build anything on 6.2 even if the install the above
subsystems, unless they buy our IDO.

I said it many times, to be able to build anything on 6.2
they still miss a linker (the GNU linker is not supported in
any official GNU or Cygnus releases on any SGI and we don't include 
/usr/lib/crt[1n].o with our headers and libraries)

David Miller has a heavily patched working GNU linker that creates
Linux elf-32 binaries. He told me that it should be easy to
make it produce native IRIX binaries. As for the crt[1n].o files
I really hope they are not a problem to give away.

>That's just the *BASE* header files.
>
This is correct. From the point of view of the original complaint
Is not enough.

-- 
Peace, Ariel
