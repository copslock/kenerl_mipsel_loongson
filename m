Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA30728 for <linux-archive@neteng.engr.sgi.com>; Thu, 1 Apr 1999 11:47:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA06864
	for linux-list;
	Thu, 1 Apr 1999 11:43:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA17146
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 1 Apr 1999 11:43:17 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup88-6-3.swipnet.se [130.244.88.83]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07940
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Apr 1999 11:43:12 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id UAA11553
	for linux@cthulhu.engr.sgi.com; Thu, 1 Apr 1999 20:32:43 -0500
Date: Thu, 1 Apr 1999 20:32:43 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: HAL2 making noise
Message-ID: <19990401203243.A11536@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all!

I've been working on the HAL2 driver again. My Indy actually makes noises and it
catches interrupts from the HAL2 when a DMA descriptor is done.

I'll implement a beep function now. It's probably not a big deal to implement
/dev/dsp correctly, just a matter of programming. Maybe I'm heading for ALSA.
Well, let's do beep first..

One problem with ALSA is the beep, how can I make the kernel produce beeps with
a sound driver loaded as an ALSA driver?

- Ulf
