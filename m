Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 20:42:30 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:64555 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225216AbVAaUmO> convert rfc822-to-8bit; Mon, 31 Jan 2005 20:42:14 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: initial bootstrap and jtag
Date:	Mon, 31 Jan 2005 12:42:07 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE863@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: initial bootstrap and jtag
Thread-Index: AcUH0LNXte2XyRb4RWylrwim1ojSrQAA9SDQ
From:	"Joseph Chiu" <joseph@omnilux.net>
To:	"Clem Taylor" <clem.taylor@gmail.com>, <linux-mips@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

We use the Macraigor Raven here.  It okay.  Not very fast.  And, for some reason, I've been having memory read problems in little-endian mode.  They've sicne released updated drivers, but I haven't been able to get them to work in my environment (because I have a bunch of older tools in the environment that I've got working well enough for my use with the older driver). 

I haven't seen the BDI2000.  My understanding is that the mpDemon is functionally the same, but faster.  If I knew then that I'd spend as much time with JTAG as I've spent, the extra money for mpDemon or the BDI2000 would have definitely been my purchase.

As for configuring the Au1xxx for bootstrapping, this is what I did:

I wrote a minimal gdb script (for use with the Raven-gdb interface) to write config values into CPU registers to get the SDRAM running.  I then uploaded a minimal program that listened for hex data on the serial port, and used that to load code that would perform FLASH memory accesses and the like.

Do people still use ROM emulators?  I think the turnaround time for getting the machine bootstrapped would have been faster with a ROMulator (at least for the stuff I was doing)...



> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Clem Taylor
> Sent: Monday, January 31, 2005 12:08 PM
> To: linux-mips@linux-mips.org
> Subject: initial bootstrap and jtag
> 
> 
> We are finishing up the design of our new Au1550 based board. I was
> wondering if someone could recommend an ejtag wiggler. I need
> something that has full linux host support, is good enough to flash a
> bootloader and do some minimal debug while getting the board support
> working. Looking over the list some people seem to be using the
> Abatron BDI 2000 and others are using the Macraigor mpDemon. What do
> you guys recommend?
> 
> This is my first time doing embedded linux, but I've done quite a bit
> with DSPs (written bootloaders, flash programmers, etc). I was
> wondering how people go about bootstrapping new Au1xxx systems. Who is
> responsible for configuring the PLL or SDRAM enough to allow code to
> be loaded into SDRAM? Are bootloaders like YAMON position independent
> to run out of SDRAM?
> 
>                                      Thanks,
>                                      Clem
> 
> 
