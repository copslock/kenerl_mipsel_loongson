Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA120439; Tue, 12 Aug 1997 13:07:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA00286 for linux-list; Tue, 12 Aug 1997 13:06:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA00257 for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 13:06:25 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA07414
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 13:06:15 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id WAA01791; Tue, 12 Aug 1997 22:05:45 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708122005.WAA01791@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id WAA25467; Tue, 12 Aug 1997 22:05:42 +0200
Subject: Re: Precompiled kernel available ?
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 12 Aug 1997 22:05:41 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, jwr@icm.edu.pl, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970812151611.11852C-100000@lager.engsoc.carleton.ca> from "Alex deVries" at Aug 12, 97 03:17:40 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
> -mcpu=r4600 -mips2 -pipe  -c -o system.o system.c
> system.c:17: #error "... You're fearless, aren't you?"
> make[1]: *** [system.o] Error 1
> make[1]: Leaving directory `/usr/src/adevries/linux/arch/mips/sgi/kernel'
> make: *** [linuxsubdirs] Error 2
> 
> Heh.  I don't think anyone's called me fearless before.

That's a shopstopper that I added on Ariel's request.  I don't think we
need it anymore.  Ariel?

  Ralf
