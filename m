Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA08085
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 00:46:33 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07733; Mon, 2 Aug 1999 15:43:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA80019
	for linux-list;
	Mon, 2 Aug 1999 15:21:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA45974
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 2 Aug 1999 15:21:12 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02205
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Aug 1999 15:21:09 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id RAA03149;
	Mon, 2 Aug 1999 17:20:52 -0500
Date: Tue, 3 Aug 1999 01:17:19 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
Reply-To: "Andrew R. Baker" <andrewb@uab.edu>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
In-Reply-To: <19990803000615.A29290@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.990803011347.15805C-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Tue, 3 Aug 1999, Ralf Baechle wrote:
> The solution which we're using for other systems is to number the
> interrupts such that 0 ... 15 are the (E)ISA interrupts; all other
> system specific interrupts use higher numbers.  In such a scenario
> request_irq() will essentially just be a demultiplexer which for
> (E)ISA interrupt numbers calls request_isa_irq() etc.  You really
> should try to leave the interrupt numbers unchanged as they are;
> basically every (E)ISA interrupt driver has it's numbers hardwired.

That's basically what William Earl suggested.  I am going to change the
SGINT_XXX defines in sgint23.h to leave space for the (E)ISA interrupts
and get change any absolute references (like in the SCSI driver) to things
like "SGINT_LOCAL0 + 1".   Is there anything else I should allocate some
space for?

-Andrew
