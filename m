Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA256262; Sat, 16 Aug 1997 15:08:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA11812 for linux-list; Sat, 16 Aug 1997 15:08:03 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA11804 for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 15:07:59 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA20560
	for <linux@cthulhu.engr.sgi.com>; Sat, 16 Aug 1997 15:07:57 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id AAA01148; Sun, 17 Aug 1997 00:07:48 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199708162207.AAA01148@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA07588; Sun, 17 Aug 1997 00:07:45 +0200
Subject: Re: boot linux - wish
To: vincent@waw.com (Vincent Renardias)
Date: Sun, 17 Aug 1997 00:07:45 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.3.95.970816224739.21289F-100000@odin.waw.com> from "Vincent Renardias" at Aug 16, 97 10:54:01 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> On Sat, 16 Aug 1997, Miguel de Icaza wrote:
> 
> > > Is there ever ANY chance of seeing XFS in Linux? Or a flavor of a really
> > > fast journaled file system?
> > 
> > not right now.  And getting an XFS clone to work on Linux is really
> > not a trivial task.
> 
> Are the XFS specs. available BTW?

There is a whitepaper available on SGI's webserver.  It however does
not refer to the really interesting details.

As far as the complexity of writing an XFS-like fs is concerned - SGI has
invested a significant fraction of the R&D of XFS into the realtime stuff.
So ignoring that part for the beginning makes the task of writing a XFS
like filesystem much easier.

  Ralf
