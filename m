Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 15:10:30 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33200 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225264AbTDCOK3>; Thu, 3 Apr 2003 15:10:29 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA22762;
	Thu, 3 Apr 2003 16:11:02 +0200 (MET DST)
Date: Thu, 3 Apr 2003 16:11:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: ralf@linux-mips.org
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20030403133610Z8225197-1272+1139@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030403154337.19058E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 3 Apr 2003 ralf@linux-mips.org wrote:

> Modified files:
> 	arch/mips/mm   : Tag: linux_2_4 c-r4k.c 
> 	arch/mips64/mm : Tag: linux_2_4 c-r4k.c 
> 
> Log message:
> 	Add check for R4000 V2.2 errata #2.

 Hmm, erratum #2 is about status output pins.  I suppose you mean erratum
#5.  But then it applies to V3.0, too.

 Then the bit is r/w, so how about toggling it instead of panicking? 
With an informational message like:

printk(KERN_ERR "Firmware bug: 32-byte I-cache line size unsupported for
the R4000...\n");
printk(KERN_ERR "... fixing up to 16-byte size.\n");

Of course that probably requires a temporary cache inhibition and
invalidation.

 Would you care to code that or should I look into it?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
