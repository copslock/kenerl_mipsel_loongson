Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA28937 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Feb 1999 14:22:57 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA14565
	for linux-list;
	Tue, 2 Feb 1999 14:22:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA01005
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 Feb 1999 14:21:58 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01326
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Feb 1999 14:21:57 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m107oCf-0027SkC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 2 Feb 1999 23:21:53 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m107oCY-002PANC; Tue, 2 Feb 99 23:21 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id WAA03340;
	Tue, 2 Feb 1999 22:26:32 +0100
Message-ID: <19990202222630.A3337@alpha.franken.de>
Date: Tue, 2 Feb 1999 22:26:30 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulf Carlsson <ulfc@bun.falkenberg.se>
Cc: alambie@rock.csd.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: weird HAL2
References: <19990202205328.A1996@bun.falkenberg.se> <m107n69-0007U1C@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <m107n69-0007U1C@the-village.bc.nu>; from Alan Cox on Tue, Feb 02, 1999 at 09:11:04PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 02, 1999 at 09:11:04PM +0000, Alan Cox wrote:
> 
> write 0x0010
> wait 10uS
> write 0x0018
> 
> work ?

not for me.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
