Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA17861
	for <pstadt@stud.fh-heilbronn.de>; Thu, 12 Aug 1999 23:52:50 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03974; Thu, 12 Aug 1999 14:49:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA08410
	for linux-list;
	Thu, 12 Aug 1999 14:34:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA08694
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 12 Aug 1999 14:34:08 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00807
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Aug 1999 14:34:06 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id QAA12394
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Aug 1999 16:34:04 -0500
Date: Thu, 12 Aug 1999 16:34:10 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Does the (E)ISA bus allow shared interupts?
Message-ID: <Pine.LNX.3.96.990812163231.12643D-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I am looking at whether I should use the interrupt handling in
arch/mips/kernel/irq.c for the i8259 or the stuff in
arch/mips/sgi/kernel/indy_int.c for local interrupts as a basis in doing
the EISA interrupt handling.

Thanks,

Andrew
