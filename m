Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 14:58:10 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47512 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIDM6K>; Wed, 4 Sep 2002 14:58:10 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA12867;
	Wed, 4 Sep 2002 14:58:27 +0200 (MET DST)
Date: Wed, 4 Sep 2002 14:58:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Matthew Dharm <mdharm@momenco.com>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: RE: Interrupt handling....
In-Reply-To: <200209040953.KAA17466@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1020904144630.10619F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 74
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Dominic Sweetman wrote:

> > Which, as you can see, attempts to access address 0xfc00000c.
> 
> But that address is in the MIPS CPU's 'kseg2' region.  Addresses there
> are always translated by the TLB, and you haven't got an entry.
> 
> Registers from things like the 2nd level interrupt controller are
> memory mapped I/O locations, and you need to do an uncached access to
> the appropriate physical address.

 As I understand 0xfc00000c is the physical address.  Thus you cannot
reach it via KSEG0/1 (although you may use XKPHYS to get there in the
64-bit mode).  Still ioremap() already handles the case mapping the area
requested in the KSEG2 space, so it should work just fine. 

> Most MIPS hardware has registers mapped between 0-512Mbyte
> (0-0x1fff.ffff) physical, because a MIPS CPU can do uncached accesses
> to that using the 'kseg1' window, which occupies the 
> 
>   0xa000.0000-0xbfff.ffff  (CPU virtual address)
>   0x0000.0000-0x1fff.ffff  (physical address).

 As I understand this is an exception.  Possibly the system supports more
than 512MB of RAM and the designers wanted to avoid holes. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
