Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA1235529 for <linux-archive@neteng.engr.sgi.com>; Sat, 13 Dec 1997 03:16:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA04016 for linux-list; Sat, 13 Dec 1997 03:15:38 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA04011 for <linux@engr.sgi.com>; Sat, 13 Dec 1997 03:15:35 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA14484
	for <linux@engr.sgi.com>; Sat, 13 Dec 1997 03:15:34 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id MAA01152
	for <linux@engr.sgi.com>; Sat, 13 Dec 1997 12:15:02 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id JAA06709;
	Sat, 13 Dec 1997 09:05:25 +0100
Message-ID: <19971213090525.19333@uni-koblenz.de>
Date: Sat, 13 Dec 1997 09:05:25 +0100
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: Re: crtbegin.o
References: <19971212011157.53174@uni-koblenz.de> <Pine.LNX.3.95.971212213052.17729A-100000@ravage.labs.gmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.971212213052.17729A-100000@ravage.labs.gmu.edu>; from Ryan on Fri, Dec 12, 1997 at 09:35:21PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Dec 12, 1997 at 09:35:21PM -0500, Ryan wrote:

> After hours of meticulous downloading, I grabbed all the RPMs I could from

Hehe, shop for a watercooled NIC:

[root@tbird redhat]# du -s RPMS SRPMS
174930  RPMS
207239  SRPMS

Btw, after about a week of destruction testing:

[root@tbird redhat]# uptime
  8:54am  up 16 days,  2:20,  2 users,  load average: 0.00, 0.00, 0.00
[root@tbird redhat]#

No scratches, still supershiny ...

> ftp.linux.sgi.com and began trying to install them.  Most worked like a
> charm, including many that I couldn't get to compile myself.  .  However,
> one big problem has appeared:  I can't compile any programs because
> /usr/lib/crtbegin.o is now missing.  I tried recompiling glibc-2.0.4 and
> it didn't produce the file.  After looking on a Redhat/ALPHA box,
> /usr/lib/crtbegin.o belongs to glibc.rpm; what gives?

It's actually produced as part of the GCC installation procedure.

> Anyway, I'm looking for that file, if anyone can send it or tell me where
> to find it.

It's being installed as part of the GCC installation procedure.  Quick
fix: steal the files from a crosscompiler installation, if you have one.
As Tim already said the missing files crtbegin.o, crtbeginS.o, crtend.o
and crtendS.o should be part of gcc-2.7.2-1.mips.rpm; I'll upload a new
package rsn.

  Ralf
