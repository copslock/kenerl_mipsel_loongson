Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA42590 for <linux-archive@neteng.engr.sgi.com>; Sat, 10 Apr 1999 12:23:33 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA30553
	for linux-list;
	Sat, 10 Apr 1999 12:20:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA86498
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 10 Apr 1999 12:20:02 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup88-10-3.swipnet.se [130.244.88.147]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA06205
	for <linux@cthulhu.engr.sgi.com>; Sat, 10 Apr 1999 12:20:00 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id VAA23114
	for linux@cthulhu.engr.sgi.com; Sat, 10 Apr 1999 21:20:07 +0200
Date: Sat, 10 Apr 1999 21:20:07 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: boot logo
Message-ID: <19990410212007.A23099@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I have been investigating the REX3 today. I decided that we couldn't live
without our friend Tux in the upper right corner when we boot, so there he is..

It took some research and a lot of testing before I figured out how the pixel
drawing should be done. Now I know the principles at least. :-)

(It hasn't been tested on 8 bit newports yet)

- Ulf
