Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA55017 for <linux-archive@neteng.engr.sgi.com>; Sun, 25 Jan 1998 22:13:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA12069 for linux-list; Sun, 25 Jan 1998 22:12:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA12065 for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 22:12:46 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA27248
	for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 22:12:43 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA27483
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 01:13:30 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 26 Jan 1998 01:13:30 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Modutils...
Message-ID: <Pine.LNX.3.95.980126010844.18537B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The more I work on this, the more I realize that I know nothing.

For modutils to work, we need someone to go over the obj_mips.c in
modutils.  That's mostly ELF stuff, if I've read correctly.  

Has anyone done any work on that, or can they explain it to me? It'd be
nice not always having to reboot to debug kernel work.  The hard reboot
button on my machine is starting to wear out.  Thank god for thumbtacks!

- Alex

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
