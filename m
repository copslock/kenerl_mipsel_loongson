Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 19:10:28 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:27553 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224827AbTDGSK1>; Mon, 7 Apr 2003 19:10:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA28081;
	Mon, 7 Apr 2003 20:10:50 +0200 (MET DST)
Date: Mon, 7 Apr 2003 20:10:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Erik J. Green" <erik@greendragon.org>
cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 64 to 32 bit jr
In-Reply-To: <1049735885.3e91b2cd7366f@my.visi.com>
Message-ID: <Pine.GSO.3.96.1030407195354.24634H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 7 Apr 2003, Erik J. Green wrote:

> According to my current understanding, the base of each of 8 segments in xkphys
> maps to the start of physical memory, so offset 0 in kseg0 should be the same
> data as at offset 0 of the a800...0000 segment in xkphys.  So, if I load code
> starting at offset 0 in xkphys, I should be able to jump to the 32-bit part of
> the xkphys address and end up at the same offset in kseg0, provided the target
> address is sign-extended properly.

 As long as your offset into XPHYS fits within the KSEG0 size.

> the code in xkphys and kseg0 have the same offsets.  Objcopy seems to have some
> non-obvious rules for doing address calculations, IE objcopy using
> --change-addresses=X
> 
> 0xa800000000000000 + 0x20004000
> 
> gives something close to (not near my MIPS system atm)
> 
> 0xa7ffffff2001c000

 Hmm, the option seems to work for me as expected.  What version of
objcopy?  What do you use for "X"?  What does `readelf -l' report before
and after copying? 

> So, I'm thinking constructing the address in a register might be easier for now.

 But your kernel really needs to be linked at a KSEG0 address -- if you
are to construct the address manually, the resulting kernel won't work. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
