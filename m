Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 21:44:26 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:2060 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225927AbUDWUoZ>;
	Fri, 23 Apr 2004 21:44:25 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1BH7lp-0002eN-00; Fri, 23 Apr 2004 21:59:37 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BH7WV-0006th-00; Fri, 23 Apr 2004 21:43:48 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16521.32766.143451.421173@doms-laptop.algor.co.uk>
Date: Fri, 23 Apr 2004 13:43:42 -0700
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: MC Parity Error
In-Reply-To: <Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl>
References: <20040423080247.GC5814@paradigm.rfc822.org>
	<Pine.LNX.4.55.0404231509190.14494@jurand.ds.pg.gda.pl>
	<20040423164517.GA16401@linux-mips.org>
	<Pine.LNX.4.55.0404231849480.14494@jurand.ds.pg.gda.pl>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.844, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Maciej W. Rozycki (macro@ds2.pg.gda.pl) writes:

> > The KSU bits are meaningless.  On Indy like most other MIPS systems a
> > bus error exception may be delayed.  So the generic solution requires
> 
>  I beg your pardon?  AFAIK, bus errors are documented to be reported
> precisely...

You're both right :-) Data errors like this on an R4x00 are reported
as cache parity errors, and cache parity error exceptions are precise.
There's also a signalling mechanism typically used for an invalid
memory address, which generates a "bus error" exception, which is not
precise.

--
Dominic Sweetman
MIPS Technologies.
