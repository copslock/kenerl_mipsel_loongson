Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA11552 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 11:37:17 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA21168
	for linux-list;
	Tue, 16 Feb 1999 11:36:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA26503
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Feb 1999 11:36:00 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02640
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Feb 1999 11:35:59 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10CqHi-0027T7C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 16 Feb 1999 20:35:54 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10CqHc-002OkuC; Tue, 16 Feb 99 20:35 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id UAA01691;
	Tue, 16 Feb 1999 20:25:55 +0100
Message-ID: <19990216202555.A1673@alpha.franken.de>
Date: Tue, 16 Feb 1999 20:25:55 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Eric Melville <m_thrope@rigelfore.com>
Cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: problem booting sgi linux
References: <36C76479.62B097D2@rigelfore.com> <19990215013527.B2910@alpha.franken.de> <36C966DA.C7F506BA@rigelfore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <36C966DA.C7F506BA@rigelfore.com>; from Eric Melville on Tue, Feb 16, 1999 at 04:38:50AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 16, 1999 at 04:38:50AM -0800, Eric Melville wrote:
> CPU: MIPS R4400 Processor Chip Revision: 6.0
[..]
> any ideas as to why every kernel i've tried hangs when it tries to free
> unused kernel memory? thanks...

looks like we have still a problem with R4400. Ralf ?

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
