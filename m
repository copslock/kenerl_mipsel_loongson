Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA65241 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Apr 1999 13:18:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA34479
	for linux-list;
	Fri, 9 Apr 1999 13:17:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA94617
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 9 Apr 1999 13:17:36 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup88-8-3.swipnet.se [130.244.88.115]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA01803
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Apr 1999 13:17:33 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id WAA09127
	for linux@cthulhu.engr.sgi.com; Fri, 9 Apr 1999 22:17:38 +0200
Date: Fri, 9 Apr 1999 22:17:37 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Newport fixes
Message-ID: <19990409221737.A9111@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I have optimized the newport console enough to make it possible to play mp3's
without those extremely annoying "clicks" during heavy console work, such as
console switching.

It's actually about 20% faster when you cat normal HOWTO's, so I consider it to
be a welcome boost up for an already fast console driver. :-)

I have also fixed some bugs. For example will the colors in ncurses applications
now show up correctly.

- Ulf
