Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA00607
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 00:17:13 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA18856; Tue, 3 Aug 1999 15:13:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA93714
	for linux-list;
	Tue, 3 Aug 1999 15:10:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA86948
	for <linux@engr.sgi.com>;
	Tue, 3 Aug 1999 15:10:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02287
	for <linux@engr.sgi.com>; Tue, 3 Aug 1999 15:10:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA03810
	for <linux@engr.sgi.com>; Wed, 4 Aug 1999 00:10:37 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA07274;
	Wed, 4 Aug 1999 00:09:08 +0200
Date: Wed, 4 Aug 1999 00:09:08 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>, binutils@sourceware.cygnus.com,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: HI16 / LO16 relocations.
Message-ID: <19990804000908.A7145@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mark, for now I'm just posting this in the hope it may ring a bell.
It seems like HI16 / LO16 relocation pairs are not handled correctly
This may result in ``la $reg, symbol'' ending up after the final link
as ``la $reg, symbol + 0x10000''.

I'll try to come up with a resonably small example tomorrow; right now
I've just discovered this problem and can only show the problem in
the diffs of disassembler listings between the two builds of a Linux
kernel with binutils 2.8.1 and cvs-binutils.

  Ralf
