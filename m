Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:53:49 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:38977 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225247AbVAaVxd> convert rfc822-to-8bit; Mon, 31 Jan 2005 21:53:33 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: initial bootstrap and jtag
Date:	Mon, 31 Jan 2005 13:53:26 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE864@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: initial bootstrap and jtag
Thread-Index: AcUH2eaZWFIQHzrBQxSqTuMpHI3a/wABWxVw
From:	"Joseph Chiu" <joseph@omnilux.net>
To:	"Ed Okerson" <ed@okerson.com>,
	"Clem Taylor" <clem.taylor@gmail.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

Hi Ed,
What kinds of patching did you have to do in the source code except for the MIPS endian-registers?  I've made such changes plus little-endian-fied the build scripts/linker scripts/makefile/etc. but haven't yet had u-boot working.  I'm assuming that outside of the bootstrapping, the code is endian-independant.  Am I wrong?
Thanks!
Joseph

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ed Okerson
> Sent: Monday, January 31, 2005 1:15 PM
> To: Clem Taylor
> Cc: linux-mips@linux-mips.org
> Subject: Re: initial bootstrap and jtag
> 
> 
> I use the BDI-2000 for an AU1500 based board.  For the boot 
> loader I found
> u-boot to be very functional.  It did require a bit of 
> patching to handle
> the Au1500 in little endian mode, but since that is now done 
> everything
> works great.
> 
> Ed Okerson
> 
> > We are finishing up the design of our new Au1550 based board. I was
> > wondering if someone could recommend an ejtag wiggler. I need
> > something that has full linux host support, is good enough 
> to flash a
> > bootloader and do some minimal debug while getting the board support
> > working. Looking over the list some people seem to be using the
> > Abatron BDI 2000 and others are using the Macraigor mpDemon. What do
> > you guys recommend?
> >
> > This is my first time doing embedded linux, but I've done 
> quite a bit
> > with DSPs (written bootloaders, flash programmers, etc). I was
> > wondering how people go about bootstrapping new Au1xxx 
> systems. Who is
> > responsible for configuring the PLL or SDRAM enough to allow code to
> > be loaded into SDRAM? Are bootloaders like YAMON position 
> independent
> > to run out of SDRAM?
> >
> >                                      Thanks,
> >                                      Clem
> >
> 
> 
> 
> 
