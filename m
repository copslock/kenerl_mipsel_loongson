Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id RAA15114
	for <pstadt@stud.fh-heilbronn.de>; Fri, 6 Aug 1999 17:03:43 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA14192; Fri, 6 Aug 1999 07:59:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA13453
	for linux-list;
	Fri, 6 Aug 1999 07:51:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA16121
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 6 Aug 1999 07:51:25 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA06907
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Aug 1999 07:51:22 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id JAA20258
	for <linux@cthulhu.engr.sgi.com>; Fri, 6 Aug 1999 09:51:20 -0500
Date: Fri, 6 Aug 1999 17:47:51 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: problems compiling 2.3 cvs kernel
Message-ID: <Pine.LNX.3.96.990806174135.10369B-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I am getting consistent signal 11 errors while trying to compile the 2.3
tree from the CVS archives with gcc-2.7.2.  They always occur on the same
files and in both my normal cross-compile enviroment and in the native
Linux-MIPS enviroment.  egcs seems to work fine in the native enviroment.
Do I just need to upgrade my cross-compiler setup?  Is there a tarball I
can install instead of fussing with the RPMs on the web site?

Thanks,

Andrew
