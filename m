Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA00010
	for <pstadt@stud.fh-heilbronn.de>; Sun, 11 Jul 1999 01:22:30 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA12977; Sat, 10 Jul 1999 16:18:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA41304
	for linux-list;
	Sat, 10 Jul 1999 16:15:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA78474
	for <linux@engr.sgi.com>;
	Sat, 10 Jul 1999 16:15:41 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03397
	for <linux@engr.sgi.com>; Sat, 10 Jul 1999 16:15:38 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-1.uni-koblenz.de [141.26.131.1])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA12137
	for <linux@engr.sgi.com>; Sun, 11 Jul 1999 01:15:35 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA21653;
	Sun, 11 Jul 1999 01:15:25 +0200
Date: Sun, 11 Jul 1999 01:15:24 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: CVS archive
Message-ID: <19990711011524.D17143@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I recently updated the CVS server on linus.linux.sgi.com.  The old one
was misshaving when working on a branch.  That is after a sequence
of commands like

  cvs update -d -P -r linux_2_2
  cvs update -d -P

the final local copy would end up containing files both from the branch
linux_2_2 and the main branch.

This is fixed now.  Just in case everybody who is working on a branch
should explicitly give an ``-r <branch-tag>'' option on the next update,
ESPECIALLY before doing checkins; the archive might get messed up
otherwise.

  Ralf
