Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA23609 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Feb 1999 15:28:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA86171
	for linux-list;
	Fri, 26 Feb 1999 15:26:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA25557
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Feb 1999 15:26:55 -0800 (PST)
	mail_from (sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07572
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Feb 1999 15:26:54 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m10GWeg-0027TKC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sat, 27 Feb 1999 00:26:50 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m10GWeV-002PCXC; Sat, 27 Feb 99 00:26 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA04134;
	Sat, 27 Feb 1999 00:16:17 +0100
Message-ID: <19990227001617.A4022@alpha.franken.de>
Date: Sat, 27 Feb 1999 00:16:17 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com,
        linux-mips@vger.rutgers.edu
Subject: 2.2.1 MIPS kernel sources plus Indy kernel binaries uploaded
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

After syncing my two source trees with CVS, I've exported a tarball
and uploaded it to

ftp://ftp.linux.sgi.com/pub/linux/mips/test/linux-2.2.1-990226.tar.gz

I've tested compilation for Indy and Olivetti M700 (MIPS Magnum).

I also uploaded a Indy kernel (map and .config file included):

ftp://ftp.linux.sgi.com/pub/linux/mips/test/vmlinux-indy-2.2.1-990226.tar.gz

Thomas.

-- 
   This device has completely bogus header. Compaq scores again :-|
It's a host bridge, but it should be called ghost bridge instead ;^)
                                        [Martin `MJ' Mares on linux-kernel]
