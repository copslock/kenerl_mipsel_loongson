Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA08351 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Mar 1999 13:31:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA39945
	for linux-list;
	Thu, 11 Mar 1999 13:29:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA85618;
	Thu, 11 Mar 1999 13:29:21 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id NAA22834; Thu, 11 Mar 1999 13:29:15 -0800
Date: Thu, 11 Mar 1999 13:29:15 -0800
Message-Id: <199903112129.NAA22834@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: darkaeon@cubicsky.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indigo2 & Linux
In-Reply-To: <36E85AC2.25F7C9B0@kotetsu.cubicsky.com>
References: <36E85AC2.25F7C9B0@kotetsu.cubicsky.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Steve Martin writes:
 > I'm curious as to what the current progress is with Linux and the
 > Indigo2(R4400SC 150Mhz Elan)
 > Also, I remember hearing something about running Xsgi on Linux, has that
 > been successfully(not stable, just enough to see it start up, maybe not
 > usable) done yet?

     One recent change is that I and other SGI engineers now have
authorization to release interface details of the system and graphics
hardware for Indigo2, as we have previously had authorization for
Indy.  Unfortunately, I have not yet had time to locate the additional
documentation (where Indigo2 differs from Indy).  Also, the policy
for source code disclosure is still not settled, and being able
to release selected bits of low-level IRIX code would make the whole
effort much simpler.  (Everyone is agreed in principle that SGI should
release some such source code to interested Linux developers, but we
need a formal policy to authorize people to, in effect, give away
SGI intellectual property.  Admittedly, the value of the relevant
code is small, but individual employees are not ordinarily authorized
to make such contributions, although that is obviously changing in
respect to Linux-based work.)
