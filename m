Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA138737 for <linux-archive@neteng.engr.sgi.com>; Mon, 26 Jan 1998 16:46:51 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA00757 for linux-list; Mon, 26 Jan 1998 16:44:48 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA00716 for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 16:44:39 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA13686
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 16:44:32 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id TAA06667
	for <linux@cthulhu.engr.sgi.com>; Mon, 26 Jan 1998 19:45:24 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Mon, 26 Jan 1998 19:45:24 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: More on modules...
Message-ID: <Pine.LNX.3.95.980126194243.20316I-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The modutils in the CVS appears to work; I'll get an RPM out tonight for
others.

But, I use the term 'work' with a grain of salt; the modules appear to
load, but I get errors like:
Illegal instruction at c000c0d0 ra=88034ed4
Unable to handle kernel paging request at virtual address c0008113, epc ==
c000c0d8, ra == 88034ed4
Killed

- A

-- 
      Alex deVries          Run Linux on everything,
  System Administrator      run everything on Linux.
   The EngSoc Project       Send spam to spam@engsoc.carleton.ca.
