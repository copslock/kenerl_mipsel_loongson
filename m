Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA59365 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 08:26:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA41445
	for linux-list;
	Tue, 2 Feb 1999 08:25:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA08807
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 08:25:34 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup84-12-3.swipnet.se [130.244.84.179]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01243
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 08:25:31 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m107iWH-0015A9C@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Tue, 2 Feb 1999 17:17:45 +0100 (CET) 
Date: Tue, 2 Feb 1999 17:17:45 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: weird HAL2
Message-ID: <19990202171745.A1051@bun.falkenberg.se>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 02, 1999 at 04:23:39PM +0100, Thomas Bogendoerfer wrote:
> On Tue, Feb 02, 1999 at 05:14:44PM +0100, Ulf Carlsson wrote:
> > Is it possible to download the BIOS and disassemble it to check how to do it
> > correctly?
> 
> should be doable, but I guess disassembling the IRIX driver might be easier.
> I've hoped someone at SGI could help us out.

I think we should ask them kindly then:

Does anyone at SGI know how the HAL2 works?

We can't get it working correctly, it doesn't come back to normal state after
the reset. Even if we write 0x0018 to isr, to enable the chip, it still shows
0x0000. It's certainly off because we can't write to the indirect registers in
this state

If we don't reset the HAL2, leaving it the way it is when after playing the boot
sound, we can't write to the indirect registers. The busy bit doesn't go off.

The only thing which works correctly is reading the version register.

- Ulf
