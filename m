Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:01:06 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:9616 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123397AbSJDNBF>; Fri, 4 Oct 2002 15:01:05 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA07942;
	Fri, 4 Oct 2002 15:01:17 +0200 (MET DST)
Date: Fri, 4 Oct 2002 15:01:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
In-Reply-To: <1033734968.31839.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.3.96.1021004145625.6208C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 4 Oct 2002, Alan Cox wrote:

> > Is a bus error exception an address related exception ?
> > I'm afraid some implementation think it's not.
> 
> So you need an option for broken systems, no new news 8)

 For MIPS a bus error exception is not an address related exception by
definition (not surprising, anyway).  Specifically, the BadVaddr register
is not set upon one.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
