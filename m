Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 18:48:23 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:62888 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225316AbTKDSsL>; Tue, 4 Nov 2003 18:48:11 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 7D4164C0CB; Tue,  4 Nov 2003 19:48:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 7111B4BFF3; Tue,  4 Nov 2003 19:48:09 +0100 (CET)
Date: Tue, 4 Nov 2003 19:48:09 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux 
In-Reply-To: <20031103231010Z8225443-1272+8723@linux-mips.org>
Message-ID: <Pine.LNX.4.32.0311041939110.31563-100000@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 3 Nov 2003 ralf@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips: i8259.h
>
> Log message:
> 	Declare i8259A_lock spinlock.  New inline function i8259_irq to poll
> 	interrupts in a PC-style daisy-chained i8259 configuration where no
> 	better method to execute an interrupt acknowledge cycle is available.

 This is broken -- you do want to check bit #7 for spurious interrupts
instead of doing awkward PIC poking.  Alternatively, just skip the check
-- the condition is rare and handlers need to be able to deal with it
anyway.  It was discussed a few months ago and I proposed a correct patch
similar to your one, but it was rejected, sigh...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
