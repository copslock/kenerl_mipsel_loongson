Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA03361
	for <pstadt@stud.fh-heilbronn.de>; Fri, 1 Oct 1999 03:42:48 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA11207; Thu, 30 Sep 1999 18:38:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA94410
	for linux-list;
	Thu, 30 Sep 1999 18:27:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA91694
	for <linux@engr.sgi.com>;
	Thu, 30 Sep 1999 18:27:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA4642381
	for <linux@engr.sgi.com>; Thu, 30 Sep 1999 18:27:48 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA06955
	for <linux@engr.sgi.com>; Fri, 1 Oct 1999 03:27:39 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id DAA29315;
	Fri, 1 Oct 1999 03:24:03 +0200
Date: Fri, 1 Oct 1999 03:24:01 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: CVS move finished
Message-ID: <19991001032401.B28857@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Anonymous users can now access the CVS archive by

  cvs -d :pserver:cvs@oss.sgi.com:/cvs login

Enter cvs when prompted for the password, then:

  cvs -d :pserver:cvs@oss.sgi.com:/cvs co linux

For user with an account the path name is /home/pub/cvs/.

  Ralf
