Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 11:17:16 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20918 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIEJRP>; Thu, 5 Sep 2002 11:17:15 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02844;
	Thu, 5 Sep 2002 11:17:33 +0200 (MET DST)
Date: Thu, 5 Sep 2002 11:17:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Matthew Dharm <mdharm@momenco.com>, Jun Sun <jsun@mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Interrupt handling....
In-Reply-To: <200209042008.VAA25407@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1020905110423.2423C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 99
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Sep 2002, Dominic Sweetman wrote:

> Well, next time, get your board designers to think before they map...
> 
> It's generally better to map some DRAM low (for boot ROMs and other
> stupid programs you don't want to make big-address aware), then remap
> the whole DRAM to some very high address for Linux.  Much better than
> forcing you to use the TLB (or XKPHYS, if you've a 64-bit CPU) to get
> at I/O.

 Hmm, what's the deal?  Other processors always use MMU to access iomem...

> Bear in mind that there *isn't a 64-bit mode*.  Privileged code (which
> is everything except Linux applications) can always run 64-bit
> instructions; all addresses are 64-bits really, it's just the
> sign-extension of the registers which makes you think you've got
> 32-bit pointers.  Usually a 64-bit CPU can access XKPHYS any time
> it can access I/O registers.

 Well, it's mostly a programming convention.  Without going into details,
arch/mips is the 32-bit mode and arch/mips64 is the 64-bit one.  The usual
approximation is the state of cp0.kx, even though 64-bit operations do
indeed work when ~cp0.kx.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
