Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA01252
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 00:33:23 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA15012; Mon, 2 Aug 1999 15:30:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA31525
	for linux-list;
	Mon, 2 Aug 1999 15:28:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA50818
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 2 Aug 1999 15:28:33 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08760
	for <linux@cthulhu.engr.sgi.com>; Mon, 2 Aug 1999 15:28:30 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA11170
	for <linux@cthulhu.engr.sgi.com>; Tue, 3 Aug 1999 00:28:28 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA29839;
	Tue, 3 Aug 1999 00:26:24 +0200
Date: Tue, 3 Aug 1999 00:26:24 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
Message-ID: <19990803002624.C29290@uni-koblenz.de>
References: <19990803000615.A29290@uni-koblenz.de> <Pine.LNX.3.96.990803011347.15805C-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.96.990803011347.15805C-100000@mdk187.tucc.uab.edu>; from Andrew R. Baker on Tue, Aug 03, 1999 at 01:17:19AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 03, 1999 at 01:17:19AM -0500, Andrew R. Baker wrote:

> On Tue, 3 Aug 1999, Ralf Baechle wrote:
> > The solution which we're using for other systems is to number the
> > interrupts such that 0 ... 15 are the (E)ISA interrupts; all other
> > system specific interrupts use higher numbers.  In such a scenario
> > request_irq() will essentially just be a demultiplexer which for
> > (E)ISA interrupt numbers calls request_isa_irq() etc.  You really
> > should try to leave the interrupt numbers unchanged as they are;
> > basically every (E)ISA interrupt driver has it's numbers hardwired.
> 
> That's basically what William Earl suggested.  I am going to change the
> SGINT_XXX defines in sgint23.h to leave space for the (E)ISA interrupts
> and get change any absolute references (like in the SCSI driver) to things
> like "SGINT_LOCAL0 + 1".   Is there anything else I should allocate some
> space for?

No, but I'd prefer symbolic names like SGINT_WD93_1 over SGINT_LOCAL0 + 1.

  Ralf
