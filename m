Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03699; Mon, 16 Jun 1997 10:54:34 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA27708 for linux-list; Mon, 16 Jun 1997 10:54:20 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA27684; Mon, 16 Jun 1997 10:54:17 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA14400; Mon, 16 Jun 1997 10:54:16 -0700
Date: Mon, 16 Jun 1997 10:54:16 -0700
Message-Id: <199706161754.KAA14400@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com, ralf@Julia.DE,
        Mike Shaver <shaver@engsoc.carleton.ca>
Subject: Re: A pointed question about endianness...
In-Reply-To: <Pine.LNX.3.95.970615184212.1448A-100000@lager.engsoc.carleton.ca>
References: <199706140312.WAA17152@athena.nuclecu.unam.mx>
	<Pine.LNX.3.95.970615184212.1448A-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
 > 
 > I'm going to repeat this question because I still haven't gotten a firm
 > answer.
 > 
 > As previously discussed, there are good reasons to produce a kernel which
 > can handle bi-endianness.  But, as Mike says, just not this week...
 > 
 > As we speak, Ralf has produced a batch of MIPS LSB binaries that would be
 > glorious to be able to run.  The kernel that Mike Shaver and I have is
 > MSB, as are our kernel, cross-compiler and rudamentary binaries.  I
 > believe this is because we're branching off of Dave M's work.
 > 
 > But, can we please agree on one endianness?  I don't care which it is, so
 > long as we all agree. Mike and I are quite willing to give up MSB.

     You probably can't agree on one, unless you can agree on one set
of systems.  Most MIPS architecture systems, including all SGI
systems, are big-endian, but all DEC systems and all MIPS Magnum 4000
systems configured to run NT are little-endian.  (All other MIPS
systems are big-endian.)
