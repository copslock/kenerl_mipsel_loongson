Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 16:03:35 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:55441 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCQDe>; Tue, 3 Feb 2004 16:03:34 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 1933E47823; Tue,  3 Feb 2004 17:03:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 07B47474C8; Tue,  3 Feb 2004 17:03:30 +0100 (CET)
Date: Tue, 3 Feb 2004 17:03:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c cp0 hazards for R4000/R4400
In-Reply-To: <20040203154217.GA1018@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031651220.16076@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl>
 <20040202150806.GA27819@linux-mips.org> <Pine.LNX.4.55.0402031504030.16076@jurand.ds.pg.gda.pl>
 <20040203154217.GA1018@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 3 Feb 2004, Ralf Baechle wrote:

> >  Perhaps it wasn't really tested.  Have you ever run the code on a PC 
> > variant?  Has anyone else?
> 
> Yes, it has.  Olivetti M700-10, around 2.2 or so.  The code used at that
> time in arch/mips/mm/r4xx0.c was not much different from what pg-r4k.c is
> generating now that is it violates this hazard.

 OK then.

> >  I suppose so -- without the "mips-pg-r4k-scache" patch my system is very
> > unstable and the difference is essentially that in addition to
> > Create_Dirty_Excl_SD there are additional Create_Dirty_Excl_D ones, that,
> > apart from being a performance hit, shouldn't have any effect.  I have to
> > investigate it further yet.
> 
> Interesting, I was expecting somewhat better performance from the
> combination of both.  Anyway, what is now in CVS is tested on R4400SC V4.0.

 After rereading the description I agree with you, so I am going to get at 
the code again soon.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
