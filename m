Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA18230; Tue, 18 Jun 1996 16:25:00 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA02396 for linux-list; Tue, 18 Jun 1996 23:24:54 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA02391 for <linux@cthulhu.engr.sgi.com>; Tue, 18 Jun 1996 16:24:52 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA15589; Tue, 18 Jun 1996 16:23:57 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199606182323.QAA15589@yon.engr.sgi.com>
Subject: gcc solution looks plausible (was: anyone know if this is true?)
To: olson@anchor.engr.sgi.com (Dave Olson)
Date: Tue, 18 Jun 1996 16:23:56 -0700 (PDT)
Cc: gcc@corp.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199606182106.OAA15730@anchor.engr.sgi.com> from "Dave Olson" at Jun 18, 96 02:06:24 pm
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[I'm Ccing gcc@corp and linux@engr, some more people may be happy to hear this]

Dave Olson wrote to me about 'ld':
>
>The one in /var/sysgen/root is the same one that driverwrap invokes.
>
>There are two ld's, the one in usr/lib, and the one in usr/bin.  They
>are different.  There is a one to one match between /usr/bin/ld and
>/var/sysgen/root/usr/bin/ld, and similarly for /usr/lib/ld and
>/var/sysgen/root/ld
>
>(assuming a 32 bit system)
>

Thanks! that's encouraging.

I assume this means that I should install two symlinks:

  /usr/freeware/bin/ld -> /var/sysgen/root/usr/bin/ld
  /usr/freeware/lib/gcc-lib/mips-sgi-irixX.Y/2.7.2/ld -> /var/sysgen/root/ld

Or something close to this.

This plus building gcc -with-gnu-as, using -32 -old_ld in the specs file
and Bean's permission to package crt[1n].o  should solve all the problems
I'm aware of and make many customers happy.

That was very helpful. Looks like a solution is close. Thanks again.
-- 
Peace, Ariel
