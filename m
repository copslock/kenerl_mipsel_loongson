Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA709869 for <linux-archive@neteng.engr.sgi.com>; Sun, 30 Nov 1997 18:22:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA16255 for linux-list; Sun, 30 Nov 1997 18:18:28 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA16247 for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 18:18:17 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA15063
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Nov 1997 18:18:16 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id DAA01551;
	Mon, 1 Dec 1997 03:18:15 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id DAA14841; Mon, 1 Dec 1997 03:18:13 +0100
Message-ID: <19971201031813.06139@thoma.uni-koblenz.de>
Date: Mon, 1 Dec 1997 03:18:13 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: More news...
References: <19971130172918.59762@uni-koblenz.de> <Pine.LNX.3.95.971130202217.22956K-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.95.971130202217.22956K-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Nov 30, 1997 at 08:41:40PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> The bad news:
> 
> Still more libc problems, but I'll quit whining about that since Ralf
> kindly told me to cross cross my own.  I'm looking at my cross-compiler
> problems now.
> 
> Next problem:
> I was running a ./configure for the nfs-server package, and I got a few
> segfaults, followed by many copies of this on the console:

Don't worry to much about those do_page_fault ... messages, when running
configure it is what you have to expect.

> release_dev: pty1: read/write wait queue active!
> 
> and finally:
> Got a bus error IRQ, shouldn't happen yet
> and a freeze.

Sigh, that one is really annoying.  I smells like an Ethernet driver
problem.

  Ralf
