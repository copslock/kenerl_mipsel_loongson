Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id MAA08769; Thu, 17 Jul 1997 12:13:54 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA14470 for linux-list; Thu, 17 Jul 1997 12:13:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA14430 for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jul 1997 12:13:30 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id MAA08446
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jul 1997 12:13:22 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id VAA29648; Thu, 17 Jul 1997 21:12:57 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199707171912.VAA29648@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id VAA12319; Thu, 17 Jul 1997 21:12:55 +0200
Subject: Re: strace
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Thu, 17 Jul 1997 21:12:55 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199707171728.NAA08651@neon.ingenia.ca> from "Mike Shaver" at Jul 17, 97 01:28:43 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> Anyone know what state the strace stuff in the CVS tree is in?

The strace is the strace as left by David Miller plus some modifications
by Miguel.  Those add some IRIX bits he needs to reverse engineer what
the X server is doing.

> I'm seeing some weird behaviour with rpm right now (can't find
> user/group) and I'd like to see what it's actually doing.
> 
> (Also, remind me to work on fdisk when I get back[*] -- I don't like
> fx very much.)

Set up an at(1) job ;-)

  Ralf
