Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 22:06:34 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:17350 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225934AbUDWVGb>; Fri, 23 Apr 2004 22:06:31 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 98FE647C6D; Fri, 23 Apr 2004 23:06:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 852EC47855; Fri, 23 Apr 2004 23:06:24 +0200 (CEST)
Date: Fri, 23 Apr 2004 23:06:24 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: MC Parity Error
In-Reply-To: <16521.32766.143451.421173@doms-laptop.algor.co.uk>
Message-ID: <Pine.LNX.4.55.0404232252080.14494@jurand.ds.pg.gda.pl>
References: <20040423080247.GC5814@paradigm.rfc822.org>
 <Pine.LNX.4.55.0404231509190.14494@jurand.ds.pg.gda.pl>
 <20040423164517.GA16401@linux-mips.org> <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl>
 <16521.32766.143451.421173@doms-laptop.algor.co.uk>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 Apr 2004, Dominic Sweetman wrote:

> > > The KSU bits are meaningless.  On Indy like most other MIPS systems a
> > > bus error exception may be delayed.  So the generic solution requires
> > 
> >  I beg your pardon?  AFAIK, bus errors are documented to be reported
> > precisely...
> 
> You're both right :-) Data errors like this on an R4x00 are reported
> as cache parity errors, and cache parity error exceptions are precise.
> There's also a signalling mechanism typically used for an invalid
> memory address, which generates a "bus error" exception, which is not
> precise.

 I refer to the situation, when SysCmd(5) is set in a response to a
processor read request.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
