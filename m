Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA06529 for <linux-archive@neteng.engr.sgi.com>; Wed, 5 Aug 1998 10:58:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA95245
	for linux-list;
	Wed, 5 Aug 1998 10:57:03 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA94011
	for <linux@engr.sgi.com>;
	Wed, 5 Aug 1998 10:57:01 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA10958
	for <linux@engr.sgi.com>; Wed, 5 Aug 1998 10:56:58 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-28.uni-koblenz.de [141.26.249.28])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA03856
	for <linux@engr.sgi.com>; Wed, 5 Aug 1998 19:56:55 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA01057;
	Wed, 5 Aug 1998 18:54:34 +0200
Message-ID: <19980805185434.G386@uni-koblenz.de>
Date: Wed, 5 Aug 1998 18:54:34 +0200
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: N32 kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

FYI, I managed to build the first using the n32 ABI.  It doesn't work
yet perfectly but running n32 will give us the full power of all 64 bits
in the register without the bloat of the 64 bit address space.  Probably
currently the best choice for the supported machines.

  Ralf
