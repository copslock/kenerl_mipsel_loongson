Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2003 15:59:55 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:28379 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225218AbTAUP7y>; Tue, 21 Jan 2003 15:59:54 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA29579;
	Tue, 21 Jan 2003 16:59:57 +0100 (MET)
Date: Tue, 21 Jan 2003 16:59:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: linux-mips@linux-mips.org
Subject: Re: [CFT] DECstation SCSI driver clean-ups
In-Reply-To: <Pine.LNX.4.44.0301202312430.28219-100000@skynet>
Message-ID: <Pine.GSO.3.96.1030121164054.24462D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 20 Jan 2003, Dave Airlie wrote:

> >  The single PMAZ-A limitation of the driver still applies, but it should
> > be fairly easy to relax in the next step.
> 
> can someone try it on a 5000/200 if they have one also .. it's been a long
> while since that code was written ... if it works on a PMAZ it'll probably
> work on a 5000/200 anyways..

 The "discrete" PMAZ-A is identical to the "integrated" one, so if one
works, the other does too.  Changes that affect the PMAZ-A are as follows: 

1. Use bus (physical) addresses everywhere, except when doing PIO copying
between host memory and the board's SRAM. 

2. An additional write barrier is added before triggering board's DMA
transfer from the board's SRAM (a nop for R3k). 

So they are minimal enough for a single run-time check to suffice. 

 Anyway, testing a current kernel on the /200 would be a good thing. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
