Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA16742; Thu, 26 Jun 1997 11:59:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA22044 for linux-list; Thu, 26 Jun 1997 11:59:31 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA22023 for <linux@cthulhu.engr.sgi.com>; Thu, 26 Jun 1997 11:59:27 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA26528
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Jun 1997 11:59:12 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from dali..uni-koblenz (ralf@dali.uni-koblenz.de [141.26.5.1]) by informatik.uni-koblenz.de (8.8.5/8.6.9) with SMTP id UAA00700; Thu, 26 Jun 1997 20:58:20 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199706261858.UAA00700@informatik.uni-koblenz.de>
Subject: Re: anon-ftp enabled on linus
To: ariel@sgi.com
Date: Thu, 26 Jun 1997 20:55:56 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199706261846.LAA11570@oz.engr.sgi.com> from "Ariel Faigon" at Jun 26, 97 11:46:22 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

> Since IRIX comes only with a dynamically liked '/bin/ls'
> I had to add /lib/rld libc.so and /dev/zero rooted at /src
> for dir to work.

> If anyone feels like building the latest wu-ftpd (with all security
> patches) and replace the SGI ftpd - welcome.

If someone wants do work on this - I've got an modified wu-ftpd 2.4
with a builtin ls command.  Would be nice to have that in linus' ftpd,
too.

> A web site is planned too.  I hope we got a volunteer to set it up.

Alan is already complaining.  I told him that I consider port 80
burned land ;-)

  Ralf
