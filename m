Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA24335 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 12:02:20 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA67508
	for linux-list;
	Tue, 2 Feb 1999 12:01:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA16470
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 12:01:20 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup84-6-16.swipnet.se [130.244.84.96]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09248
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 12:01:18 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m107lt2-0015A9C@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Tue, 2 Feb 1999 20:53:28 +0100 (CET) 
Date: Tue, 2 Feb 1999 20:53:28 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alistair Lambie <alambie@rock.csd.sgi.com>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: weird HAL2
Message-ID: <19990202205328.A1996@bun.falkenberg.se>
Mail-Followup-To: Alistair Lambie <alambie@csd.sgi.com>,
	Linux SGI <linux@cthulhu.engr.sgi.com>
References: <19990202171745.A1051@bun.falkenberg.se> <36B753D6.641616A4@csd.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <36B753D6.641616A4@csd.sgi.com>; from Alistair Lambie on Wed, Feb 03, 1999 at 08:36:54AM +1300
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I don't know anything about the HAL2, but looking in hal2.h it says
> 0=reset, so from what I can see you write 0x0018 to it and then it
> should read 0x0000 when it is reset.

The spec says:

Bit 3, Global reset R/W:
Assertion of hardware reset i.e. RESET_N, set this to zero. Software brings the
HAL2 out of reset by setting this bit and may reset the HAL2 by clearing it.
Please note: this bit must be set before any other internal register access
occurs.
RESET = 0;
ACTIVE = 1;

Bit 4, Codec reset R/W:
Value reflected to CODEC_RESET_N pin. To reset external codecs and other
external devices.
RESET = 0; ACTIVE = 1;

This is exactly what I'm trying to do by first writing 0x0000 to isr, waiting
some us, and then writing 0x0018. Then the card should be active and isr should
IMHO contain 0x0018.

> Maybe this part is working ok for you and the problem is further along?

Nope.

- Ulf
