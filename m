Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA09684
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 01:09:08 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA22187; Mon, 2 Aug 1999 16:05:48 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA44358
	for linux-list;
	Mon, 2 Aug 1999 16:04:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA52431;
	Mon, 2 Aug 1999 16:04:16 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06199; Mon, 2 Aug 1999 16:04:10 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA21205;
	Tue, 3 Aug 1999 01:04:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA30269;
	Tue, 3 Aug 1999 01:03:57 +0200
Date: Tue, 3 Aug 1999 01:03:57 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: "Andrew R. Baker" <andrewb@uab.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
Message-ID: <19990803010357.A29946@uni-koblenz.de>
References: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu> <19990803000615.A29290@uni-koblenz.de> <14246.8990.201459.912911@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <14246.8990.201459.912911@fir.engr.sgi.com>; from William J. Earl on Mon, Aug 02, 1999 at 04:00:46PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 02, 1999 at 04:00:46PM -0700, William J. Earl wrote:

> Ralf Baechle writes:
> ...
>  > The solution which we're using for other systems is to number the
>  > interrupts such that 0 ... 15 are the (E)ISA interrupts; all other
>  > system specific interrupts use higher numbers.  In such a scenario
>  > request_irq() will essentially just be a demultiplexer which for
>  > (E)ISA interrupt numbers calls request_isa_irq() etc.  You really
>  > should try to leave the interrupt numbers unchanged as they are;
>  > basically every (E)ISA interrupt driver has it's numbers hardwired.
> 
>      That suggests that we need to renumber the levels in sgiint23.h,
> moving all of them up by 16 to make room for the EISA interrupts, and
> then increasing NR_IRQ to at least 68 from 64 to account for the extra
> levels.  

Indeed, but I don't see a problem with that.

  Ralf
