Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA14841
	for <pstadt@stud.fh-heilbronn.de>; Mon, 16 Aug 1999 00:40:57 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA01489; Sun, 15 Aug 1999 15:39:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA66600
	for linux-list;
	Sun, 15 Aug 1999 15:31:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA19739
	for <linux@engr.sgi.com>;
	Sun, 15 Aug 1999 15:30:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05593
	for <linux@engr.sgi.com>; Sun, 15 Aug 1999 15:30:53 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA27073
	for <linux@engr.sgi.com>; Mon, 16 Aug 1999 00:30:50 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA12353;
	Sun, 15 Aug 1999 23:56:34 +0200
Date: Sun, 15 Aug 1999 23:56:34 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Binutils, once more ...
Message-ID: <19990815235634.A12336@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Another binutils status report - as of now I still have two open bugs:

 - ld doesn't fill the .got entries for non-dynamic binaries.
 - binutils-current are so extremly wastefull with .got space that we run
   out of got space for building relativly simple programs like vim.
   There is a workaround for this problem which is using compiling things
   with the -Wa,-xgot option.  Not really a good idea because it requires
   recompilation of several packages with that option but at least it
   works ...

Btw, binutils 2.8.1 died the SIGSEGV death when trying to link vim ...

  Ralf
