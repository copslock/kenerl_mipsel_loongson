Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA04862
	for <pstadt@stud.fh-heilbronn.de>; Thu, 19 Aug 1999 03:59:49 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04375; Wed, 18 Aug 1999 18:57:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA92789
	for linux-list;
	Wed, 18 Aug 1999 18:50:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA96129
	for <linux@engr.sgi.com>;
	Wed, 18 Aug 1999 18:50:50 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08610
	for <linux@engr.sgi.com>; Wed, 18 Aug 1999 18:50:48 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-3.uni-koblenz.de [141.26.131.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA02540
	for <linux@engr.sgi.com>; Thu, 19 Aug 1999 03:50:45 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id DAA31150;
	Thu, 19 Aug 1999 03:50:32 +0200
Date: Thu, 19 Aug 1999 03:50:32 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: N32/64 Assembler work
Message-ID: <19990819035032.C9737@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Binutils now have more or less reached a state where we can use them
to sanely build a distribution.  What's still missing is support for
the N32 and 64 ABIs in the assembler such that we also can build a
64-bit userland.  Volunteers?

  Ralf
