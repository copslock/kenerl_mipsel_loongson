Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:17:48 +0200 (CEST)
Received: from p508B493B.dip.t-dialin.net ([80.139.73.59]:26274 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123397AbSJDNRr>; Fri, 4 Oct 2002 15:17:47 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g94DHIb16581;
	Fri, 4 Oct 2002 15:17:18 +0200
Date: Fri, 4 Oct 2002 15:17:18 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>, linux-mips@linux-mips.org
Subject: Re: Promblem with PREF (prefetching) in memcpy
Message-ID: <20021004151718.A16064@linux-mips.org>
References: <1033734968.31839.5.camel@irongate.swansea.linux.org.uk> <Pine.GSO.3.96.1021004145625.6208C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021004145625.6208C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Oct 04, 2002 at 03:01:17PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 04, 2002 at 03:01:17PM +0200, Maciej W. Rozycki wrote:

> > > Is a bus error exception an address related exception ?
> > > I'm afraid some implementation think it's not.
> > 
> > So you need an option for broken systems, no new news 8)
> 
>  For MIPS a bus error exception is not an address related exception by
> definition (not surprising, anyway).  Specifically, the BadVaddr register
> is not set upon one.

A particular pain is the exception can be delayed almost arbitrarily due to
posted writes.  So quite frequently there is no easy association between
the machine state at exception time and the cause ...

  Ralf
