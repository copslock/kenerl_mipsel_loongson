Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA10730
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 01:23:42 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05935; Mon, 2 Aug 1999 16:20:45 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA49476
	for linux-list;
	Mon, 2 Aug 1999 16:17:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA72913;
	Mon, 2 Aug 1999 16:17:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03806; Mon, 2 Aug 1999 16:17:36 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA18597;
	Tue, 3 Aug 1999 01:17:31 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA30417;
	Tue, 3 Aug 1999 01:17:20 +0200
Date: Tue, 3 Aug 1999 01:17:20 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: "Andrew R. Baker" <andrewb@uab.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: EISA support
Message-ID: <19990803011720.C29946@uni-koblenz.de>
References: <14246.1339.269402.396117@fir.engr.sgi.com> <Pine.LNX.3.96.990803003314.15805B-100000@mdk187.tucc.uab.edu> <14246.7994.461082.434930@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <14246.7994.461082.434930@fir.engr.sgi.com>; from William J. Earl on Mon, Aug 02, 1999 at 03:44:10PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 02, 1999 at 03:44:10PM -0700, William J. Earl wrote:

>        I see that some drivers use NR_IRQS to form an IRQ_ports[] array,
> to map from IRQ to board object, as in serial.c, whereas others, such as
> riscom8.c, wire in 16 as the limit.   Still, you could make
> probe_irq_on() and probe_irq_off() actually work for an Indy and Indigo2,
> and simply declare broken any drives which do not use NR_IRQS and probe
> using the probe_irq_* routines.  The biggest problem with that approach
> is that NR_IRQS is 64 on mips, which means that probe_irq_on() and probe_irq_off()
> would need a different interface (long long instead of int, to allow 64-bit
> IRQ bit maps on 32-bit kernel).  

probe_irq_{on,off} are being used for interrupt probing only and that's
an art only practiced for ISA.  So we don't even want to support these
functions for interupts >= 16, that is non (E)ISA interrupts.

  Ralf
