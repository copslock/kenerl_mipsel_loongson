Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA124214 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Jan 1998 06:50:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA03639 for linux-list; Sun, 11 Jan 1998 06:45:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA03634 for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 06:45:18 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA19556
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 06:45:17 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id JAA26898
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jan 1998 09:47:58 -0500
Date: Sun, 11 Jan 1998 09:47:58 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Rebooting...
Message-ID: <Pine.LNX.3.95.980111094603.26800A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


For the first time, I got my machine to shutdown properly after doing a ^d
after an fsck.  Cool!  No more hanging after "Disabling R4600 SCACHE".

But, now I have something a bit odder after "Disabling 4600 SCACHE": 
--UNKNOWN INTERRUPT:00:01:00--

Just reporting the bug...

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
