Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA136718 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 16:41:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA25074 for linux-list; Sun, 11 Jan 1998 16:38:59 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA25069 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 16:38:58 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA15325
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 16:38:56 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id BAA28880
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jan 1998 01:38:55 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA04123;
	Mon, 12 Jan 1998 01:35:42 +0100
Message-ID: <19980112013541.24300@uni-koblenz.de>
Date: Mon, 12 Jan 1998 01:35:41 +0100
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: some glibc issues...
References: <Pine.LNX.3.95.980111174623.26800D-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980111174623.26800D-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sun, Jan 11, 1998 at 05:49:45PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jan 11, 1998 at 05:49:45PM -0500, Alex deVries wrote:

> Two things that puzzle me:
> 
> - exactly what's wrong with using -lbsd now?

It simply doesn't exist anymore.  RedHat on kludges things by making
libbsd.a a link to libbsd-compat.a.  That's a broken attempt to keep
Makefiles alive because -D_BSD_SOURCE needs to be added to CFLAGS for
BSD code anyway ...

> - why does sys/mount.h have no MS_ defines in it now?

Duh?  It does have them ...

  Ralf
