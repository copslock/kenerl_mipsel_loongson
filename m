Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA01452 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Mar 1999 07:59:56 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA37663
	for linux-list;
	Mon, 22 Mar 1999 07:57:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA37655
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Mar 1999 07:57:45 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup85-7-6.swipnet.se [130.244.85.102]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA04608
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Mar 1999 10:57:43 -0500 (EST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id QAA27517
	for linux@cthulhu.engr.sgi.com; Mon, 22 Mar 1999 16:47:06 -0500
Date: Mon, 22 Mar 1999 16:47:06 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: GDB
Message-ID: <19990322164706.A27372@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3us
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm having some problems with gdb for mips. I can't examine core files since gdb
itself dumps core files when I try start gdb (gdb nsgsml core). Are there other
ways to check where a program crashes (except for printf()s)? It isn't possible
to run nsgsml in gdb either, or at least it doesn't provide the information I
want.

It's also tricky to debug where gdb fails because it just dumps another core
when I try to debug the core file gdb dumps :)

By the way, I have received a new Indy from SGI (that's why I'm back in action).
But the monitor was not working so I had to take the machine to the support
center in Sweden, which I did last Friday. They replaced the monitor so
everything works fine now. Thanks Nancy!

FYI I've fixed /dev/graphics now (thanks for making it a module at first place
Alex!). The code was really broken. I'll commit that stuff sometime when I don't
experience too much CVS problems.. (CVS is really bad from here..)

I've applied for being an X developer now as well (X was the real reason for
fixing /dev/graphics). Maybe I can remove the abscence of X servers if it's so
easy to port the IBM8514 driver as everyone says it is.

- Ulf
