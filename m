Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA1377555 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 19:03:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA04591 for linux-list; Fri, 5 Sep 1997 19:03:04 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04576 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 19:03:02 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id TAA20799; Fri, 5 Sep 1997 19:03:01 -0700
Date: Fri, 5 Sep 1997 19:03:01 -0700
Message-Id: <199709060203.TAA20799@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: miguel@nuclecu.unam.mx, linux@fir.engr.sgi.com
Subject: Re: [Q: Linux/SGI] IRIX executable memory map.
In-Reply-To: <199709060033.CAA11262@informatik.uni-koblenz.de>
References: <199709052251.PAA20078@fir.engr.sgi.com>
	<199709060033.CAA11262@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > Hi,
 > 
 > >      The library is fetching the PID from t_pid instead of calling getpid()
 > > for performance reasons.
 > 
 > Byte Benchmarks ;-)

     Actually not, although we have thought about it.  getpid() itself is
a system call, even though it could just use the PRDA.  Note, however, that
IRIX processes which do not use the usema stuff generally do not have the
PRDA mapped, since we wanted to avoid allocating an extra page per process
for processes which do not use it.
