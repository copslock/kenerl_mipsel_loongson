Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA15881
	for <pstadt@stud.fh-heilbronn.de>; Tue, 27 Jul 1999 01:20:16 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA12348; Mon, 26 Jul 1999 16:14:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA54340
	for linux-list;
	Mon, 26 Jul 1999 16:03:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA40175
	for <linux@engr.sgi.com>;
	Mon, 26 Jul 1999 16:03:07 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07127
	for <linux@engr.sgi.com>; Mon, 26 Jul 1999 16:03:03 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA29197
	for <linux@engr.sgi.com>; Tue, 27 Jul 1999 01:03:00 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA04806;
	Mon, 26 Jul 1999 23:53:43 +0200
Date: Mon, 26 Jul 1999 23:53:43 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Linker bug
Message-ID: <19990726235343.B4793@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ld crashes when doing the following:

  echo "main(){}" > c.c
  gcc -o c c.c -lm -ieee

Strange enough this only hits native linkers, not crosslinkers built from
the same sources.  This prevents us from building several RH 6.0 packages.

I don't have the time to track this one down, so I'd _really_ appreciate
if somebody else would do so.

  Ralf
