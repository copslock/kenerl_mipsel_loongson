Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id OAA301176 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 14:45:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA07998 for linux-list; Thu, 4 Dec 1997 14:45:12 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA07693 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 14:44:38 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA18684
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 14:44:33 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA01489
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 23:44:31 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA30277;
	Thu, 4 Dec 1997 23:18:21 +0100
Message-ID: <19971204231821.08074@uni-koblenz.de>
Date: Thu, 4 Dec 1997 23:18:21 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: Update ...
References: <Pine.LNX.3.95.971203210446.3395A-100000@lager.engsoc.carleton.ca> <m0xdbxc-0005FsC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0xdbxc-0005FsC@lightning.swansea.linux.org.uk>; from Alan Cox on Thu, Dec 04, 1997 at 02:09:00PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Dec 04, 1997 at 02:09:00PM +0000, Alan Cox wrote:

> > Can someone _please_ break my cycle by uploading their functional libc?
> > Please? If I get it, and can become a productive member of society again.
> 
> I think we are all in the same boat but I've been waiting cos Ralf did say
> he doesnt get to upload tons of stuff any time he wants. 

Yes.  Basically the problem is that I have to carry all the stuff to
the university for uploading.  Everything else would be pretty insane
over a 28.8k line at German phone rates.  Right now I already have about
120mb of pending uploads and the Indy is still compiling ...

Note that only publishing libc wouldn't do the job.  Some libc bugs
also affect the part of libc that are being linked statically into
executables.

  Ralf
