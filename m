Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05226; Wed, 4 Jun 1997 10:30:55 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA27123 for linux-list; Wed, 4 Jun 1997 10:29:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA27104 for <linux@relay.engr.SGI.COM>; Wed, 4 Jun 1997 10:29:32 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA07656
	for <linux@relay.engr.SGI.COM>; Wed, 4 Jun 1997 10:29:30 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id NAA23779; Wed, 4 Jun 1997 13:28:09 -0400
Date: Wed, 4 Jun 1997 13:28:09 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: Mike Shaver <shaver@neon.ingenia.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: The Plan For Userland(tm)
In-Reply-To: <199706031823.UAA01401@informatik.uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.970604132358.17656I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 3 Jun 1997, Ralf Baechle wrote:

> Sorry, it's taking a bit longer.  In the meantime I synced with .42;
> still need to fix some more bugs.

We're looking forward to it.

> Whith what package again did you have the problems with atomic.h?

procps complains loudly, and doesn't compile although there are other
issues with procps.

> > - rpm built

zlib, rpm 2.4.1 and gzip appear to work.

- Alex
