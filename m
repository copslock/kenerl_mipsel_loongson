Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA92851 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Apr 1999 03:43:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA21594
	for linux-list;
	Tue, 6 Apr 1999 03:41:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA91336
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 6 Apr 1999 03:41:44 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup87-3-7.swipnet.se [130.244.87.39]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07094
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Apr 1999 03:41:42 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id MAA25320
	for linux@cthulhu.engr.sgi.com; Tue, 6 Apr 1999 12:31:35 -0400
Date: Tue, 6 Apr 1999 12:31:35 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: HAL2 spec bug
Message-ID: <19990406123135.A21186@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

The DMA noise problem was actually a specification bug. I should not configure
cfgdma as a 16 bit device as the specification explicitly tells me to do. If
it's configured for 16 bit DMA transfers are the low 8 bits just dumped or
replaced with a noise if they differ from the upper 8 bits.

It's kind of hard to write a decent driver when the spec lies for me..

- Ulf
