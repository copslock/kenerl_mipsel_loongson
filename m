Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA71124 for <linux-archive@neteng.engr.sgi.com>; Sat, 11 Jul 1998 20:14:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA42894
	for linux-list;
	Sat, 11 Jul 1998 20:14:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA29250
	for <linux@engr.sgi.com>;
	Sat, 11 Jul 1998 20:14:14 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA27888
	for <linux@engr.sgi.com>; Sat, 11 Jul 1998 12:12:16 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id VAA26292
	for <linux@engr.sgi.com>; Sat, 11 Jul 1998 21:12:11 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA14625;
	Sat, 11 Jul 1998 21:10:55 +0200
Message-ID: <19980711211054.N10756@uni-koblenz.de>
Date: Sat, 11 Jul 1998 21:10:54 +0200
To: shaver@netscape.com
Cc: linux@cthulhu.engr.sgi.com
Subject: NAN
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I looked about around and found comments in some source code that according
to IEEE 754 apparently the result of converting a NAN to an integer is
unspecified.

I wrote a small test program that casts a double NAN into unsigned int.
On Linux/i386 + GNU libc the result is zero.  An equivalent program
running under IRIX returns MAXINT, that's 2^31 - 1.

Since even making the aliens land on earth would be a strictly IEEE 754
conformant result or maybe somewhat closer to the reality, treating the
conversion operation as a nop therefore probably resulting in a random
result, I think the part of Mozilla which dies is buggy and should be fixed.

  Ralf
