Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA68021 for <linux-archive@neteng.engr.sgi.com>; Sun, 11 Apr 1999 03:34:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA31403
	for linux-list;
	Sun, 11 Apr 1999 03:30:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA96268
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 11 Apr 1999 03:30:28 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup89-11-10.swipnet.se [130.244.89.170]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA02880
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Apr 1999 03:30:26 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id MAA07397
	for linux@cthulhu.engr.sgi.com; Sun, 11 Apr 1999 12:30:36 +0200
Date: Sun, 11 Apr 1999 12:30:35 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: SGI Console
Message-ID: <19990411123035.A7346@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I've fixed the configure scripts now. It's not possible to compile in fbcon
support anylonger, so that the logo stuff becomes redefined. I move the newport
console to the console drivers section instead..

I also made it possible to compile a kernel without newport console support.
What I wonder is: What should happen when you don't select "y" here? As it is
now nothing takes over the console, it justs remain in the state the prom left
it.

Is this what we want, or do we want to use some other console when we don't use
newport console?

- Ulf
