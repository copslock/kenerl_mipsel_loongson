Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA135764 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 14:53:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA14649 for linux-list; Sun, 11 Jan 1998 14:47:13 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA14637 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 14:47:07 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA28612
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 14:47:04 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA13395
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 17:49:46 -0500
Date: Sun, 11 Jan 1998 17:49:45 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: some glibc issues...
Message-ID: <Pine.LNX.3.95.980111174623.26800D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Two things that puzzle me:

- exactly what's wrong with using -lbsd now?
- why does sys/mount.h have no MS_ defines in it now?

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
