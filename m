Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA19984 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Oct 1998 15:57:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA64943
	for linux-list;
	Tue, 27 Oct 1998 15:57:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA66693
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 27 Oct 1998 15:57:12 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup120-1-42.swipnet.se [130.244.120.42]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02948
	for <linux@cthulhu.engr.sgi.com>; Tue, 27 Oct 1998 15:57:10 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m0zYJ0v-000w6rC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Wed, 28 Oct 1998 00:59:01 +0100 (CET) 
Message-ID: <19981028005901.C23849@zigzegv.ml.org>
Date: Wed, 28 Oct 1998 00:59:01 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: HAL2 interrupt
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I mailed you a few days ago, maybe that mail got dropped somewhere or maybe you
were to busy too read, anyhow ..

Now I'm asking again, do you know which interrupt number I should request for
the PBUS DMA:s. I can't handle the interrupts correctly without the knowledge of
interrupt numbers, and I'm afraid the spec didn't tell me anything about this
(atleast not the ones I've read). Also, is everything else I need for dealing
these interrupts ok (I haven't been able to check)? Maybe I could setup some
bogus irq detection stuff to figure this out on my own, but to save some bogus
programming I'm asking you instead.

It would be nice if you even explained *how* you know..

I think I'm pretty much done with a simple playback/recording driver now, still
untested though (probably +1000 serious bugs and race conditions, but I'll fix
that..).

Thanks,
Ulf
