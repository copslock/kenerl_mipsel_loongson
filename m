Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA09632
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 01:07:02 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA21520; Mon, 2 Aug 1999 16:03:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA40959
	for linux-list;
	Mon, 2 Aug 1999 16:00:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id QAA12465;
	Mon, 2 Aug 1999 16:00:47 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA14945; Mon, 2 Aug 1999 16:00:46 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14246.8990.201459.912911@fir.engr.sgi.com>
Date: Mon, 2 Aug 1999 16:00:46 -0700 (PDT)
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "Andrew R. Baker" <andrewb@uab.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
In-Reply-To: <19990803000615.A29290@uni-koblenz.de>
References: <Pine.LNX.3.96.990802203514.15805A-100000@mdk187.tucc.uab.edu>
	<19990803000615.A29290@uni-koblenz.de>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle writes:
...
 > The solution which we're using for other systems is to number the
 > interrupts such that 0 ... 15 are the (E)ISA interrupts; all other
 > system specific interrupts use higher numbers.  In such a scenario
 > request_irq() will essentially just be a demultiplexer which for
 > (E)ISA interrupt numbers calls request_isa_irq() etc.  You really
 > should try to leave the interrupt numbers unchanged as they are;
 > basically every (E)ISA interrupt driver has it's numbers hardwired.

     That suggests that we need to renumber the levels in sgiint23.h,
moving all of them up by 16 to make room for the EISA interrupts, and
then increasing NR_IRQ to at least 68 from 64 to account for the extra
levels.  
