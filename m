Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA07664; Fri, 30 May 1997 07:46:54 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA07602 for linux-list; Fri, 30 May 1997 07:43:35 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA07567 for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 07:43:25 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA26455
	for <linux@relay.engr.SGI.COM>; Fri, 30 May 1997 07:42:48 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id QAA18776; Fri, 30 May 1997 16:38:52 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199705301438.QAA18776@informatik.uni-koblenz.de>
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA14854; Fri, 30 May 1997 16:38:51 +0200
Subject: Re: userland cometh
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Fri, 30 May 1997 16:38:49 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199705301346.JAA12694@neon.ingenia.ca> from "Mike Shaver" at May 30, 97 09:46:33 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Thus spake Ralf Baechle:
> > Take a look at the little endian RPM packages I've published on
> > kernel.panic.julia.de.  All these packages were build from the vanilla
> > SRPM packages on the RedHat 4.1 package.
> 
> Yeah, yeah... =)
> 
> Once I get a natively-hosted compiler working, I'll be cranking out
> RPMs[*].  In the meantime, convincing some of those packages to
> cross-compile is pretty interesting.  Lots of post-./configure
> Makefile munging with perl and the like.

Urgs...  Easier solution - in most cases running configure on a Intel
or even better Sparc Linux machine does the right thing.  Or even
better - you can save the generated config.cache files and feed them
into future runs of autoconf generated configure scripts.  I used these
two techniques to get my MIPS stuff crosscompiled.

  Ralf
