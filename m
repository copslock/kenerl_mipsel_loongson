Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA00737
	for <pstadt@stud.fh-heilbronn.de>; Fri, 20 Aug 1999 00:48:11 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01547; Thu, 19 Aug 1999 15:45:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA18484
	for linux-list;
	Thu, 19 Aug 1999 15:34:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA79052
	for <linux@engr.sgi.com>;
	Thu, 19 Aug 1999 15:34:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00336
	for <linux@engr.sgi.com>; Thu, 19 Aug 1999 15:34:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-3.uni-koblenz.de [141.26.131.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA29723
	for <linux@engr.sgi.com>; Fri, 20 Aug 1999 00:34:35 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id PAA13846;
	Thu, 19 Aug 1999 15:47:12 +0200
Date: Thu, 19 Aug 1999 15:47:12 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: ECOFF
Message-ID: <19990819154712.A13843@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Does anybody still rely on the linker support for ECOFF binaries?  I'd
like to drop the ECOFF emulations (mipsbig and mipslittle) from ld.

  Ralf
