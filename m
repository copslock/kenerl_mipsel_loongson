Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA20975; Fri, 30 May 1997 01:53:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA28404 for linux-list; Fri, 30 May 1997 01:52:02 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA28399 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 01:51:59 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA09411
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 01:51:53 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id KAA25091; Fri, 30 May 1997 10:47:19 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705300847.KAA25091@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id KAA12360; Fri, 30 May 1997 10:47:19 +0200
Subject: Re: userland cometh
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 30 May 1997 10:47:18 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705300548.BAA09588@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 01:48:34 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> OK, I think I've got this cross-compiling thing licked.
> 
> Modulo some bogus interactions between the mostly-hacked 2.1.36 kernel
> headers and the glibc 2.0.1 stuff (which seems to be a bit off itself,
> but that's for another day), userland is coming along nicely.
> 
> I've been rebuilding with the glibc-2.0.1 stuff and all-dynamic
> linking, and I've got:
> fileutils-3.16
> tar-1.12
> sh-utils-1.16
> textutils-1.22
> ncurses_1.9.9g (just the libncurses.a, ma'am)
> net-tools' inetd, arp, ifconfig, rarp, route and telnetd
> 
> I can't get ping or bash to work build just yet (ping was _not_ happy with
> my headers), but I'll keep at it.
> 
> Once I'm done here, I'll be making a new root.tar.gz for anyone who
> wants to play around with it.

Take a look at the little endian RPM packages I've published on
kernel.panic.julia.de.  All these packages were build from the vanilla
SRPM packages on the RedHat 4.1 package.

I'd like to keep the number of .tar packages as low as possible; the
root.tar.gz package has proven not to be very updateable.

  Ralf
