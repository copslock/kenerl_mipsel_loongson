Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id GAA670274 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Dec 1997 06:09:06 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA28295 for linux-list; Mon, 8 Dec 1997 06:06:56 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA28281 for <linux@engr.sgi.com>; Mon, 8 Dec 1997 06:06:44 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA17216
	for <linux@engr.sgi.com>; Mon, 8 Dec 1997 06:06:39 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from brian.uni-koblenz.de (ralf@brian [141.26.4.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id PAA01954
	for <linux@engr.sgi.com>; Mon, 8 Dec 1997 15:06:05 +0100 (MET)
Received: by brian.uni-koblenz.de (4.1/KO-2.0)
	id AA19161; Mon, 8 Dec 97 15:06:03 +0100
Message-Id: <19971208150602.52582@brian.uni-koblenz.de>
Date: Mon, 8 Dec 1997 15:06:02 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com
Subject: Uploads ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just as announced I've started uploading all the toys I've been working
on to Linus.  Right now all the RPMs (about 134mb) and all the source RPMs
are online.  I had to modify a couple of the source RPMs.  The most
common bug was trying to link with libbsd.a from Linux-libc which of
course is missing on our glibc-only system.

I've also uploaded a linux 2.1.67 kernel binary to Linus.

Still missing:

 - sh-utils (bug in the Redhat sources)
 - binutils (gcc dies during compile)
 - X
 - libc

I'll pump at least the last two items up tomorrow; the other items will
need some work.

Ok, and with this upload ``Mustang'' is history for me.  Let's go for
Redhat 5.0 ...

  Ralf
