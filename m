Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 16:27:16 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:34029 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDDP1P>; Fri, 4 Apr 2003 16:27:15 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA10466;
	Fri, 4 Apr 2003 17:27:48 +0200 (MET DST)
Date: Fri, 4 Apr 2003 17:27:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Erik J. Green" <erik@greendragon.org>
cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Unknown ARCS message/hang
In-Reply-To: <1049468250.3e8d9d5aecb0a@my.visi.com>
Message-ID: <Pine.GSO.3.96.1030404171736.7307E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Apr 2003, Erik J. Green wrote:

> Clearly then, the kernel is linked at the wrong address to have this work.  The
> question I have is, why is kseg0 used in this case?  Is it due to the 32 to 64
> bit conversion that happens later on in the build?  It looks like the IP27 load
> address was originally  0xa80000000001c000, but was amended to 0x8001c000 for
> the current CVS(2.4) kernel.  Again, due to the conversion?

 Not all parts of the MIPS64/Linux kernel are 64-bit clean when it comes
to addressing.  There used to be troubles with 64-bit tools until
recently, too.  That's why the kernel is built with 32-bit addressing and
only after the final link converted to a 64-bit object to satisfy firmware
that needs such for a load.

 It should be fixed one day, but that's not necessarily a starter's task. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
