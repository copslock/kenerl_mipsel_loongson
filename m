Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA29430 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Feb 1999 15:28:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA52818
	for linux-list;
	Fri, 26 Feb 1999 15:27:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA66175
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Feb 1999 15:26:58 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07903
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Feb 1999 15:26:56 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10GWef-0027T9C@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 27 Feb 1999 00:26:49 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10GWeV-002PCWC; Sat, 27 Feb 99 00:26 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA04142;
	Sat, 27 Feb 1999 00:22:51 +0100
Message-ID: <19990227002251.B4022@alpha.franken.de>
Date: Sat, 27 Feb 1999 00:22:51 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com, m_thrope@rigelfore.com
Subject: R4400 200MHz Indys
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Yesterday Ralf told me about a bug in the R4400 Rev 6.0 250 MHz devices.
As we can't say, whether the 200Mhz are real 250 MHz chip, it's worth
a try to activate the workaround for it, which is already present in
the kernel (but never gets enabled). People, which have problem with 
R4400 Indys, please try the kernel below.

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-r4400-990226.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
