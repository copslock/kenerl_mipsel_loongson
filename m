Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA36267 for <linux-archive@neteng.engr.sgi.com>; Fri, 10 Jul 1998 15:19:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA25550
	for linux-list;
	Fri, 10 Jul 1998 15:18:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA90437
	for <linux@engr.sgi.com>;
	Fri, 10 Jul 1998 15:18:13 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09900
	for <linux@engr.sgi.com>; Fri, 10 Jul 1998 15:18:07 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA25341
	for <linux@engr.sgi.com>; Sat, 11 Jul 1998 00:18:03 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id VAA11598;
	Fri, 10 Jul 1998 21:49:31 +0200
Message-ID: <19980710214931.F10756@uni-koblenz.de>
Date: Fri, 10 Jul 1998 21:49:31 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: GCC bug
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex,

I fixed a stupid GCC bug.  As a result the package f2c, flex and ncurses-4
will have to be rebuilt using the new GCC or building new programs using
the libraries provided by these packages may not be possible any longer.

I'll send you an updated gcc package asap.

  Ralf
