Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA08180
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 00:49:31 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA18199; Mon, 2 Aug 1999 15:46:13 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA85591
	for linux-list;
	Mon, 2 Aug 1999 15:44:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA44137;
	Mon, 2 Aug 1999 15:44:11 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA14846; Mon, 2 Aug 1999 15:44:10 -0700
From: "William J. Earl" <wje@fir.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14246.7994.461082.434930@fir.engr.sgi.com>
Date: Mon, 2 Aug 1999 15:44:10 -0700 (PDT)
To: "Andrew R. Baker" <andrewb@uab.edu>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
In-Reply-To: <Pine.LNX.3.96.990803003314.15805B-100000@mdk187.tucc.uab.edu>
References: <14246.1339.269402.396117@fir.engr.sgi.com>
	<Pine.LNX.3.96.990803003314.15805B-100000@mdk187.tucc.uab.edu>
X-Mailer: VM 6.72 under Emacs 19.34.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Andrew R. Baker writes:
 > 
 > 
 > On Mon, 2 Aug 1999, William J. Earl wrote:
...
 > >       Suppose you define a range of request_irq() index values which
 > > correspond to EISA interrupts.  The generic EISA interrupt would always
 > > be enabled, and the selective masking would apply to various bits in the
 > > EISA interrupt controller, in much the way that the cascading interrupts
 > > in INT2 and INT3 are handled.
 > 
 > I hadn't even thought about doing it that way, but after looking at the
 > existing interupt code, it shouldn't be much of a problem. My biggest
 > concern is maintaining compatability with the existing drivers. From what
 > I can tell, they all grab IRQs in the range of 1-15 (the available range
 > for EISA on x86 machines).  So the best course of action is to shift the
 > virtual IRQ numbers up to start at 16, and put the EISA irqs on the 0-15
 > range.  Are there any major things I should consider before doing this?
 > Are there any arguments against this? 

       I see that some drivers use NR_IRQS to form an IRQ_ports[] array,
to map from IRQ to board object, as in serial.c, whereas others, such as
riscom8.c, wire in 16 as the limit.   Still, you could make
probe_irq_on() and probe_irq_off() actually work for an Indy and Indigo2,
and simply declare broken any drives which do not use NR_IRQS and probe
using the probe_irq_* routines.  The biggest problem with that approach
is that NR_IRQS is 64 on mips, which means that probe_irq_on() and probe_irq_off()
would need a different interface (long long instead of int, to allow 64-bit
IRQ bit maps on 32-bit kernel).  

      Changing the MIPS symbolic IRQ mapping to put EISA in the bottom
16 slots is probably the course of least resistance.
