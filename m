Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA28069 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Mar 1999 14:32:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA92736
	for linux-list;
	Tue, 30 Mar 1999 14:31:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA87874
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Mar 1999 14:31:21 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06770
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Mar 1999 14:31:20 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10S77s-0027UNC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Wed, 31 Mar 1999 00:36:52 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10S72C-002P4TC; Wed, 31 Mar 99 00:31 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA03069;
	Tue, 30 Mar 1999 23:51:35 +0200
Message-ID: <19990330235135.A2991@alpha.franken.de>
Date: Tue, 30 Mar 1999 23:51:35 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: eedthwo@eede.ericsson.se
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: New Indy kernel uploaded
References: <19990329012602.A3227@alpha.franken.de> <199903300743.JAA15859@sun168.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903300743.JAA15859@sun168.eu>; from Tom Woelfel on Tue, Mar 30, 1999 at 09:43:16AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Mar 30, 1999 at 09:43:16AM +0200, Tom Woelfel wrote:
> Yep, done. Works without problems - Linux is up and running. How do
> you solve the problems with the ECOFF/ELF thing ? Is there some kind
> of backwards-compatibility ? 

yes, every newer PROM is also able to boot ECOFF kernels. So I just
uploaded an ECOFF kernel, which should work with every PROM.

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
