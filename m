Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA54594 for <linux-archive@neteng.engr.sgi.com>; Sat, 3 Apr 1999 10:02:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA11955
	for linux-list;
	Sat, 3 Apr 1999 10:00:37 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA02686
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 3 Apr 1999 10:00:35 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from bun.falkenberg.se (dialup71-12-7.swipnet.se [130.244.71.183]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA07385
	for <linux@cthulhu.engr.sgi.com>; Sat, 3 Apr 1999 10:00:33 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: (from ulfc@localhost)
	by bun.falkenberg.se (8.8.7/8.8.7) id SAA21642
	for linux@cthulhu.engr.sgi.com; Sat, 3 Apr 1999 18:50:11 -0500
Date: Sat, 3 Apr 1999 18:50:11 -0500
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: ALSA driver
Message-ID: <19990403185011.A21627@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've spent today and yesterday writing an ALSA driver for the HAL2.

Anyhow I'm playing MP3:s on the Indy now (did you hear that puffin?).

I can't say that it sounds good yet, but I can hear what song it is. I'll do
some finetuning now. It shouldn't be hard to fix. It oopses every now and then
as well. I'll consider writing to allocated memory areas instead.. :-)

I'll also implement an interface for the mixer (I don't have any documentation
at all about how the mixer works..?).

- Ulf
