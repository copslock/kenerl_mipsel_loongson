Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id DAA08275
	for <pstadt@stud.fh-heilbronn.de>; Fri, 23 Jul 1999 03:05:53 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA16167; Thu, 22 Jul 1999 18:04:17 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA33421
	for linux-list;
	Thu, 22 Jul 1999 18:00:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA29643
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jul 1999 18:00:28 -0700 (PDT)
	mail_from (duke@frodo.heloc.com)
Received: from fire.heloc.com (wally.heloc.com [209.47.200.155]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA00097
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jul 1999 18:00:27 -0700 (PDT)
	mail_from (duke@frodo.heloc.com)
Received: from drugs.heloc.com (drugs.heloc.com [192.168.1.24])
	by fire.heloc.com (8.9.3/8.9.2) with ESMTP id VAA11839
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jul 1999 21:00:25 -0400 (EDT)
Received: from frodo.heloc.com (frodo.heloc.com [192.168.1.21])
	by drugs.heloc.com (8.9.3/8.9.2) with ESMTP id VAA89089
	for <@relay.heloc.com:linux@cthulhu.engr.sgi.com>; Thu, 22 Jul 1999 21:00:11 -0400 (EDT)
Received: (from duke@localhost) by frodo.heloc.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id VAA50473 for linux@cthulhu.engr.sgi.com; Thu, 22 Jul 1999 21:00:58 -0400 (EDT)
From: "Rob Dueckman" <duke@heloc.com>
Message-Id: <990722210058.ZM50511@frodo.heloc.com>
Date: Thu, 22 Jul 1999 21:00:57 -0400
X-Mailer: Z-Mail (5.0.0 30July97)
To: linux@cthulhu.engr.sgi.com
Subject: RedHat 6.0 (SMP) on 540
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 8bit

I've got this new box here at the office which I've installed RedHat 6.0.  It
is a VisWis 540 with 4 processors.

After downloading  the 2.2.10 kernel, applying the patches and installing the
new kernel, Linux only sees 2 of the 4 processors...

I havn't spent a huge amount of time looking at the source, but is there a flag
during the build that tells now many processors to support?  If not, is this a
bug?

Thanks.
