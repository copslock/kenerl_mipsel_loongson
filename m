Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA46892 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Apr 1999 14:31:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA83788
	for linux-list;
	Tue, 6 Apr 1999 14:30:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA85479
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 6 Apr 1999 14:30:19 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-12-10.swipnet.se [130.244.71.186]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08900
	for <linux@cthulhu.engr.sgi.com>; Tue, 6 Apr 1999 14:30:17 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id WAA09501
	for linux@cthulhu.engr.sgi.com; Tue, 6 Apr 1999 22:16:41 -0400
Date: Tue, 6 Apr 1999 22:16:41 -0400
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: HAL2 driver 0.2
Message-ID: <19990406221641.A6206@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hello,

I've uploaded new version of ALSA HAL2 sounddrivers now. Works much better.

New features:
o Better sound quality
o Support for both Mono / Stereo
o Support for sample rates in range 4.000 kHz to 48.000 kHz
o Support for both Big endian and Little endian
o Limited support for recording (doesn't work very good yet)

Check: ftp://ftp.linux.sgi.com/pub/linux/mips/test/ALSA

(don't forget to patch mpg123)

- Ulf
