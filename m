Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA713429 for <linux-archive@neteng.engr.sgi.com>; Mon, 23 Mar 1998 18:38:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id SAA2972575
	for linux-list;
	Mon, 23 Mar 1998 18:37:26 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA2959053
	for <linux@engr.sgi.com>;
	Mon, 23 Mar 1998 18:37:20 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id SAA26399
	for <linux@engr.sgi.com>; Mon, 23 Mar 1998 18:37:18 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-20.uni-koblenz.de [141.26.249.20])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA14350
	for <linux@engr.sgi.com>; Tue, 24 Mar 1998 03:37:15 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA09670;
	Mon, 23 Mar 1998 22:51:25 +0100
Message-ID: <19980323225125.14671@uni-koblenz.de>
Date: Mon, 23 Mar 1998 22:51:25 +0100
To: linux@cthulhu.engr.sgi.com
Subject: More fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I fixed the old reboot problem.  The cause were three lines of code
that should have been removed ages ago.  Now the second level cache
is being disabled on reboot as it is supposed to.

Furthermore as long as we don't have suitable floating point support
(Grrr... Motorola spread their stuff for the 68k under a BSDish
license ...) I changed the kernel to try to deal with that problem a
little bit more gentle by setting the ``Flush To Zero'' bit in
$fcr31 on unimplemented exceptions.  IEEE754 at it's best :-(

  Ralf
