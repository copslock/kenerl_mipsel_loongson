Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:45:44 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:31889 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123397AbSJDNpo>; Fri, 4 Oct 2002 15:45:44 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA09075;
	Fri, 4 Oct 2002 15:46:06 +0200 (MET DST)
Date: Fri, 4 Oct 2002 15:46:06 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@algor.co.uk>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <200210041329.OAA12180@mudchute.algor.co.uk>
Message-ID: <Pine.GSO.3.96.1021004153416.6208F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Oct 2002, Dominic Sweetman wrote:

> > You can also configure you system, so you get a external interrupt
> > from you system controller in case of a bus error, there is no way
> > the CPU can relate this interrupt to the prefetching.
> 
> Yes, that's true; interrupts on bus errors are vaguely useful for
> post-mortem diagnosis, but useless for recovery.

 Why do you think so?  Bus errors on reads are synchronous, so if the
handler can judge the error is recoverable (e.g. it was a correctable ECC
error), you can just restart.

 Bus errors on writes are asynchronous, but you may record the necessary
details (the cycle type, the address and the data involved) in chipset
registers and if the handler judges the conditions are recoverable, it may
fix up the error -- e.g. mark the page of physical memory as bad and
substitute another one, copying all other valid data plus the bits that
caused the failure. 

 A system has to be designed to handle such cases, though.  And obviously
if you get one of these errors as a result of a severe hardware damage,
you may not be able to recover, anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
