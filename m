Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA54562 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Oct 1998 16:39:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA53492
	for linux-list;
	Wed, 14 Oct 1998 16:38:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA53754
	for <linux@engr.sgi.com>;
	Wed, 14 Oct 1998 16:38:14 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09814
	for <linux@engr.sgi.com>; Wed, 14 Oct 1998 16:38:12 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-29.uni-koblenz.de [141.26.249.29])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA07329
	for <linux@engr.sgi.com>; Thu, 15 Oct 1998 01:38:04 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id OAA00789;
	Wed, 14 Oct 1998 14:24:43 +0200
Message-ID: <19981014142443.F392@uni-koblenz.de>
Date: Wed, 14 Oct 1998 14:24:43 +0200
From: ralf@uni-koblenz.de
To: tsbogend@alpha.franken.de
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Milo & R4000SC
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've just found yet another SC problem.  Due bugs in a certain ARC firmware
in the FlushAllCaches() function Milo uses it's own cache flushing routine.
Which does not has the feature of flushing R4000 caches 32 times in a row,
it also doesn't correctly deal with R4000 second level caches.  It just
happens to work for the Magnum 4000SCs because they use a unified second
level cache.

Any success in finally getting rid of Milo?

  Ralf
