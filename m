Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA96683 for <linux-archive@neteng.engr.sgi.com>; Mon, 1 Feb 1999 15:26:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA45205
	for linux-list;
	Mon, 1 Feb 1999 15:25:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA14004
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 1 Feb 1999 15:25:19 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup84-12-3.swipnet.se [130.244.84.179]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07751
	for <linux@cthulhu.engr.sgi.com>; Mon, 1 Feb 1999 15:25:14 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m107Sar-0015A9C@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Tue, 2 Feb 1999 00:17:25 +0100 (CET) 
Date: Tue, 2 Feb 1999 00:09:53 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: weird HAL2
Message-ID: <19990202000953.A32386@bun.falkenberg.se>
References: <19990201231003.A2810@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <19990201231003.A2810@alpha.franken.de>; from Thomas Bogendoerfer on Mon, Feb 01, 1999 at 11:10:03PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Thomas,

> I've looked at the HAL2 driver,

Cool :)

> and everything is looking strange hardware- wise.

I was actually thinking exactly the same thought.

> The driver first resets the hardware by clearing the isr register and setting
> the appropriate bits afterwards.

I was looking at the sgiseeq.c, and I've actually stolen some ideas from it. For
example are we doing the reset (trying to do?) in about the same way.

> But reading back isr indicates, that the hardware is still in reset state.
> I've removed clearing of the isr, so the driver just writes the same value as
> was before. This still leads to a HAL2 in reset state. Even removing the reset
> code completly the HAL2 acts very strange. Doing the first indirect register
> access, causes as set busy bit in isr, that's all. Any ideas

Hm, I haven't been able to set the busy bit, how did you manage to do that?

It looks to me like some volatile bug, causing the driver not to read back the
values directly from the card. But everything seems to be ok.

By the way, did you notice that isr is 0x0018 before you reset the card? This is
one of the strange things. Maybe it's because Alex didn't reboot his computer
after reinserting the driver again. If this is the case, why doesn't the card
enter active mode again before the driver has failed to activate it?

- Ulf
