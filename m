Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA30011
	for <pstadt@stud.fh-heilbronn.de>; Fri, 24 Sep 1999 00:21:18 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA05573; Thu, 23 Sep 1999 15:18:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA21421
	for linux-list;
	Thu, 23 Sep 1999 15:09:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA76579
	for <linux@engr.sgi.com>;
	Thu, 23 Sep 1999 15:09:41 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09400
	for <linux@engr.sgi.com>; Thu, 23 Sep 1999 15:09:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA15326
	for <linux@engr.sgi.com>; Fri, 24 Sep 1999 00:09:37 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id TAA08221;
	Thu, 23 Sep 1999 19:34:41 +0200
Date: Thu, 23 Sep 1999 19:34:40 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Cc: kevink@mips.com
Subject: Indy Serial
Message-ID: <19990923193440.A8210@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

For those who don't read the CVS mailing list - the CVS now has a fix
for the bug recently reported by Kevin Kissel.  Sympthon was that
sending data with O_POST disabled was broken.  This broke various
programs like cu or minicom.

Thanks Kevin!

  Ralf

PS: That's the first contribution by MIPS :-)
