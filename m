Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03494; Mon, 16 Jun 1997 10:57:14 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA28668 for linux-list; Mon, 16 Jun 1997 10:57:02 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA28654; Mon, 16 Jun 1997 10:56:59 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA14413; Mon, 16 Jun 1997 10:56:58 -0700
Date: Mon, 16 Jun 1997 10:56:58 -0700
Message-Id: <199706161756.KAA14413@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Alistair Lambie" <alambie@wellington.sgi.com>
Cc: Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
        adevries@engsoc.carleton.ca (Alex deVries), linux@cthulhu.engr.sgi.com,
        ralf@Julia.DE, shaver@engsoc.carleton.ca
Subject: Re: A pointed question about endianness...
In-Reply-To: <9706161530.ZM15792@windy.wellington.sgi.com>
References: <199706160017.CAA23535@informatik.uni-koblenz.de>
	<ralf@mailhost.uni-koblenz.de>
	<9706161530.ZM15792@windy.wellington.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alistair Lambie writes:
 > On Jun 16, 12:21pm, Ralf Baechle wrote:
 > > Btw, question to the SGI gurus - is the kernel byteorder of SGI machines
 > > be reconfigurable?
 > >
 > 
 > As the guys in the US won't be in for a while yet.....
 > 
 > My belief is that Indy's were designed to require a PROM change.  I have also
 > heard that there was a problem running NT that required some mods to the
 > boards.
 > These were never released to the field.
 > 
 > So the answer is yes, but in practice no!
...
     Indy never ran anything little-endian, although the memory controller
could in principle support it.  The rest of the system probably would not
work correctly.  As far as I know, only the MIPS Magnum systems really
work both ways.  (They actually work better little-endian, but most were shipped
big-endian.)
