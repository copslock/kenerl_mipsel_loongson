Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA19187
	for <pstadt@stud.fh-heilbronn.de>; Fri, 17 Sep 1999 23:16:42 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07239; Fri, 17 Sep 1999 14:12:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA08953
	for linux-list;
	Fri, 17 Sep 1999 14:03:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA12236
	for <linux@engr.sgi.com>;
	Fri, 17 Sep 1999 14:03:35 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06846
	for <linux@engr.sgi.com>; Fri, 17 Sep 1999 14:03:32 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA16646
	for <linux@engr.sgi.com>; Fri, 17 Sep 1999 23:03:27 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id WAA06535;
	Fri, 17 Sep 1999 22:29:29 +0200
Date: Fri, 17 Sep 1999 22:29:29 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Dave Airlie <airlied@csn.ul.ie>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: CVS 2.3.9 kernel
Message-ID: <19990917222929.D6143@uni-koblenz.de>
References: <Pine.LNX.3.96.990917173922.23805T-100000@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.96.990917173922.23805T-100000@skynet.csn.ul.ie>; from Dave Airlie on Fri, Sep 17, 1999 at 05:44:00PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Sep 17, 1999 at 05:44:00PM +0100, Dave Airlie wrote:

> 	What is the current CVS status? I'm trying to compile it up for a
> DS5000/200 R3000 box, At link time I'm getting undefined symbols to do
> with emergency_sync ...

Since Harald's recent changes things don't compile anymore, not even for
an Indy.  I'm going to undo them until things are sorted out in a working
manor.

  Ralf
