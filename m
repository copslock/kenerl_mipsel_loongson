Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA67525 for <linux-archive@neteng.engr.sgi.com>; Sat, 3 Apr 1999 14:11:11 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA40092
	for linux-list;
	Sat, 3 Apr 1999 14:09:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA49812
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 3 Apr 1999 14:09:09 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup89-7-6.swipnet.se [130.244.89.102]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA21062
	for <linux@cthulhu.engr.sgi.com>; Sat, 3 Apr 1999 14:08:46 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id WAA00769
	for linux@cthulhu.engr.sgi.com; Sat, 3 Apr 1999 22:58:48 -0500
Date: Sat, 3 Apr 1999 22:58:48 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: ALSA progress
Message-ID: <19990403225848.A746@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi, and happy easter everyone!

I've improved the sound quality a lot now. There's only a very slight noise in
the background now, otherwise the sound is crystal clear. :-)

I'll soon release some ALSA patches. I'll just catch a few more bugs first. It
still bombs with bus irq's occasionaly.

Another strange thing is that I can't reset the HAL2. If I do so, I can't hear
anything, it receives interrupts correctly though. I've checked that my setup is
equal to the one before the reset so I don't know exactly what's wrong here.
Well, that doesn't matter as long as it sounds good.

I've been trying to change the volume without any success as well. There were
some hints about two volume registers in the IRIX hal2.h, but those don't affect
anything.

- Ulf
