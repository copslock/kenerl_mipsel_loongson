Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 17:11:09 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:50139 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225394AbTJ2RLF>; Wed, 29 Oct 2003 17:11:05 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id E268C4C108; Wed, 29 Oct 2003 18:11:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CF2E9478D7; Wed, 29 Oct 2003 18:11:03 +0100 (CET)
Date: Wed, 29 Oct 2003 18:11:03 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: <linux-mips@linux-mips.org>
Subject: Re: LK201 keyboard
In-Reply-To: <20031023083736.GL20846@lug-owl.de>
Message-ID: <Pine.LNX.4.32.0310291804500.20758-100000@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 23 Oct 2003, Jan-Benedict Glaw wrote:

> > > Erm, is this even correct if this keyboard isn't used "natively" by X11,
> > > but through the Input API?
> >
> >  For the console (or the cooked mode) we already set up the device
> > correctly.
>
> That doesn't exactly answer my question, but I think I'll figure it out
> at some time:) At least, if I get XFree through the compiler at some
> time (on a VAX).

 I've just misunderstood the question -- sorry.  For XFree86 the current
state is the "native" support doesn't work as of 3.3.6 (that's what I
have) because of broken mappings both in the kernel and in XFree86 and
that version doesn't support the input API AFAIK.  I'm told the "native"
support doesn't work for newer versions of XFree86, either, and I haven't
seen any reports about the input API.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
