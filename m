Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:32:04 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:8593 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123397AbSJDNcE>; Fri, 4 Oct 2002 15:32:04 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08767;
	Fri, 4 Oct 2002 15:32:30 +0200 (MET DST)
Date: Fri, 4 Oct 2002 15:32:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <20021004151718.A16064@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021004152054.6208E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Oct 2002, Ralf Baechle wrote:

> >  For MIPS a bus error exception is not an address related exception by
> > definition (not surprising, anyway).  Specifically, the BadVaddr register
> > is not set upon one.
> 
> A particular pain is the exception can be delayed almost arbitrarily due to
> posted writes.  So quite frequently there is no easy association between
> the machine state at exception time and the cause ...

 Hmm, I'm not sure if it's permitted to signal a bus exception for
asynchronous write cycles.  At least the R3k and the R4000/R4400
specifications explictly forbid them and state that a general interrupt
has to be used in such a case instead (and at least the DECstations get
this circuitry right -- all of them have a dedicated gp interrupt input
for bus errors on a write).  Later chips might have relaxed this
requirement though -- I don't know at the moment.

 Anyway, the address which is involved in the cycle resulting in a bus
exception is always valid and the reason lies elsewhere -- e.g. it may be
a bus timeout or a data ECC error. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
