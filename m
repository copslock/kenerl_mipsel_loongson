Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA26990
	for <pstadt@stud.fh-heilbronn.de>; Sat, 21 Aug 1999 00:57:20 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA21452; Fri, 20 Aug 1999 15:52:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA45471
	for linux-list;
	Fri, 20 Aug 1999 15:46:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA14722
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 20 Aug 1999 15:46:08 -0700 (PDT)
	mail_from (imp@harmony.village.org)
Received: from rover.village.org (rover.village.org [204.144.255.49]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08066
	for <linux@cthulhu.engr.sgi.com>; Fri, 20 Aug 1999 15:46:06 -0700 (PDT)
	mail_from (imp@harmony.village.org)
Received: from harmony.village.org (harmony.village.org [10.0.0.6])
	by rover.village.org (8.9.3/8.9.3) with ESMTP id QAA57450;
	Fri, 20 Aug 1999 16:45:54 -0600 (MDT)
	(envelope-from imp@harmony.village.org)
Received: from harmony.village.org (localhost.village.org [127.0.0.1]) by harmony.village.org (8.9.3/8.8.3) with ESMTP id QAA39630; Fri, 20 Aug 1999 16:45:59 -0600 (MDT)
Message-Id: <199908202245.QAA39630@harmony.village.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: ECOFF 
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
In-reply-to: Your message of "Thu, 19 Aug 1999 15:47:12 +0200."
		<19990819154712.A13843@uni-koblenz.de> 
References: <19990819154712.A13843@uni-koblenz.de>  
Date: Fri, 20 Aug 1999 16:45:59 -0600
From: Warner Losh <imp@village.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

In message <19990819154712.A13843@uni-koblenz.de> Ralf Baechle writes:
: Does anybody still rely on the linker support for ECOFF binaries?  I'd
: like to drop the ECOFF emulations (mipsbig and mipslittle) from ld.

Doesn't LILO for the little endian ARC machines require this?

Warner
