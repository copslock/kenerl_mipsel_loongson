Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA38270; Mon, 11 Aug 1997 17:03:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA23959 for linux-list; Mon, 11 Aug 1997 17:01:25 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA23841 for <linux@cthulhu.engr.sgi.com>; Mon, 11 Aug 1997 17:01:09 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA08060
	for <linux@cthulhu.engr.sgi.com>; Mon, 11 Aug 1997 17:01:05 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA03734;
	Mon, 11 Aug 1997 18:59:07 -0500
Date: Mon, 11 Aug 1997 18:59:07 -0500
Message-Id: <199708112359.SAA03734@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199708100206.EAA12374@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Sun, 10 Aug 1997 04:06:54 +0200 (MET DST))
Subject: Re: Bottom half bug
X-Home: is where the cat is
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello Ralf, list,

  Well, the major problem with getting gdb up was that init is for
some reason setting the blocked signal mask to 0x39 (this includes
sighup, sigtrap and a couple of others).  

  I will debug this next, right now I have this gross hack on gdb to
reset the signal mask to zero.  Any ideas of why would init be doing this?

Cheers,
Miguel.
