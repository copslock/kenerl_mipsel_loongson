Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA49819 for <linux-archive@neteng.engr.sgi.com>; Wed, 4 Nov 1998 17:32:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA52164
	for linux-list;
	Wed, 4 Nov 1998 17:31:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA50963
	for <linux@engr.sgi.com>;
	Wed, 4 Nov 1998 17:31:31 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA05212
	for <linux@engr.sgi.com>; Wed, 4 Nov 1998 17:31:30 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-26.uni-koblenz.de [141.26.249.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA09412
	for <linux@engr.sgi.com>; Thu, 5 Nov 1998 02:31:24 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id CAA02594;
	Thu, 5 Nov 1998 02:30:15 +0100
Message-ID: <19981105023015.K359@uni-koblenz.de>
Date: Thu, 5 Nov 1998 02:30:15 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: GDB
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I found that by accident GDB and the kernel were using different
ptrace(2) interfaces.  After fixing that for example ``info registers''
works ok.

  Ralf
