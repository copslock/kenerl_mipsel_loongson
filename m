Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id BAA15921 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Apr 1999 01:36:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA15842
	for linux-list;
	Sun, 4 Apr 1999 01:35:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA42390
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 4 Apr 1999 01:34:59 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-2-10.swipnet.se [130.244.71.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA02741
	for <linux@cthulhu.engr.sgi.com>; Sun, 4 Apr 1999 01:34:56 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id LAA01719
	for linux@cthulhu.engr.sgi.com; Sun, 4 Apr 1999 11:24:42 -0400
Date: Sun, 4 Apr 1999 11:24:42 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: PBUS bugs smashed
Message-ID: <19990404112442.A1700@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I can happily report perfect sound in my Indy. :-)

The last bug was quite tricky. I had to reboot the machine after every playback,
otherwise I got noise in the DMA channels.

I could obviously not set the configuration bits in the pbus ctrl register at
the same write as I wrote the activation bits..

- Ulf
