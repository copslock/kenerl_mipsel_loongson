Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA08701; Thu, 13 Mar 1997 17:01:09 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA00658 for linux-list; Fri, 14 Mar 1997 01:00:54 GMT
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA00638 for <linux@engr.sgi.com>; Thu, 13 Mar 1997 17:00:50 -0800
Received: from windy.wellington.sgi.com by soyuz.wellington.sgi.com via ESMTP (940816.SGI.8.6.9/940406.SGI)
	for <@soyuz.wellington.sgi.com:linux@engr.sgi.com> id NAA08146; Fri, 14 Mar 1997 13:12:40 +1300
Received: (from alambie@localhost) by windy.wellington.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA06459 for linux@engr.sgi.com; Fri, 14 Mar 1997 13:56:29 +1300
From: "Alistair Lambie" <alambie@wellington.sgi.com>
Message-Id: <9703141356.ZM6484@windy.wellington.sgi.com>
Date: Fri, 14 Mar 1997 13:56:29 +0000
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Where to....
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel, (and anyone else....)

1. Are you going to reactivate the linux-progress list...it was great to
   keep track of where things were at last time.

2. I'm not sure what root environment is sitting around in David's stuff,
   but in neteng.engr:~dm/alambie there are a bunch of files:
      root.tar.gz  -  Root filesystem contents with prebuilt devs, basic bin
                      utilities and a shell.
      init.tar.gz  -  An init program and the basics to get multiuser
      mount.tar.gz -  guess what.....
      e2fsprogs-IRIXprebuilt.tar.gz  -  The e2fsprogs that run under Irix to
                      build an ext2 filesystem
   Don't know whether these are useful to any of the guys or not, but they may
   help them bootstrap to something use[able|ful].  These were built with
   Ralph's static libc stuff.

3. The original plan for userland that David was working towards was to use
   the packages from RedHat and set them up for Alpha (that way we get big
   endian and 64bit) and work from that as a base....I'm guessing that's still
   the best way.  We felt at the time that the RedHat rpms seemed the best
   to go with as they have good support for handling multiple architecture's.

4. From memory David had done a heap of work on glibc as well as gcc.  I think
   he was getting ral close to something that was almost useable...a lot of
   the problems seemed to be in the runtime linker for shared lib support.
   I'm wondering if any of the work Cygnus are doing will help here??

5. Are we going to keep using CVS as a standard....we will definitely need
   some form of source control with so many people working on it!

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
