Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA38523 for <linux-archive@neteng.engr.sgi.com>; Tue, 10 Nov 1998 19:23:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA90890
	for linux-list;
	Tue, 10 Nov 1998 19:22:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA77755
	for <linux@engr.sgi.com>;
	Tue, 10 Nov 1998 19:22:38 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA01176
	for <linux@engr.sgi.com>; Tue, 10 Nov 1998 19:22:37 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-04.uni-koblenz.de [141.26.249.4])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id EAA22507
	for <linux@engr.sgi.com>; Wed, 11 Nov 1998 04:22:22 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id OAA00639;
	Mon, 9 Nov 1998 14:03:41 +0100
Message-ID: <19981109140341.D541@uni-koblenz.de>
Date: Mon, 9 Nov 1998 14:03:41 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Binutils 2.9.x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've been asked if I recommend an upgrade to binutils 2.9.x when I recently
posted patches.  No, at this time I even disrecommend an upgrade since
binutils 2.9.1.0.4 have been the most buggy binutils version I touched since
a long, long time.  Rebuilding glibc 2.0.99 triggers more than 3000 lines
warning messages for failed assertions in elf32-mips.c, I get core dumps and
all sorts of sick effects.

I touched them though for two reasons.  First of all, in the interest of
getting an Linux distribution working for us with as little changes as
possible we should go with whatever the Linux distributor uses.  In case
of Redhat 5.1 this is binutils 2.9.1.0.4.  Second I've started to work a bit
on glibc 2.0.99.  In order to get symbol versioning working we need at
least binutils 2.9.1.

  Ralf
