Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA00393; Sat, 31 May 1997 15:13:44 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA21316 for linux-list; Sat, 31 May 1997 15:13:28 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA21311 for <linux@engr.sgi.com>; Sat, 31 May 1997 15:13:21 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA16390
	for <linux@engr.sgi.com>; Sat, 31 May 1997 15:13:12 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from uhland (ralf@uhland.uni-koblenz.de [141.26.4.63]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id AAA13044; Sun, 1 Jun 1997 00:09:20 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705312209.AAA13044@informatik.uni-koblenz.de>
Received: by uhland (SMI-8.6/KO-2.0)
	id AAA03419; Sun, 1 Jun 1997 00:09:16 +0200
Subject: Re: ah...
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Sun, 1 Jun 1997 00:09:15 -2200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199705302125.RAA22822@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 05:25:28 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Thus spake Ralf Baechle:
> > One of the fun things with SGI...  Long time ago checked two SGI machines
> > running different OS versions for reference.  In one of them the values
> > for SOCK_STREAM and SOCK_DGRAM are swapped compared to the other.  I wonder
> > why.  But anyway, at that time I choose to clone the constants from the
> > newer one.
> 
> Solaris is the same way...it's probably an SVR thing.
> (If you're going to use sockets, though, why not use the BSD values?)

One crappy conversion routine less.

I checked my own source base at home; both libc and the kernel use the
same values as IRIX 6.2 so there must be something wrong with your libc.

  Ralf
