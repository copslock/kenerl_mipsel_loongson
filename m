Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA91042 for <linux-archive@neteng.engr.sgi.com>; Sun, 28 Mar 1999 15:30:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA38209
	for linux-list;
	Sun, 28 Mar 1999 15:29:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA67359
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 28 Mar 1999 15:29:52 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09396
	for <linux@cthulhu.engr.sgi.com>; Sun, 28 Mar 1999 15:29:49 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10RP4d-0027TpC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Mon, 29 Mar 1999 01:34:35 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10ROzw-002Ox5C; Mon, 29 Mar 99 01:29 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id BAA03251
	for linux@cthulhu.engr.sgi.com; Mon, 29 Mar 1999 01:26:03 +0200
Message-ID: <19990329012602.A3227@alpha.franken.de>
Date: Mon, 29 Mar 1999 01:26:02 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux@cthulhu.engr.sgi.com
Subject: New Indy kernel uploaded
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

After killing a lot of SCSI bugs during the last weeks, I've made a new
kernel with all of the fixes in it. It also contains a workaround 
for the problem with hanging after "Freeing unused kernel memory".

Everyone, who had problems with older kernels, please test this kernel.

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990329.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
