Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2004 09:18:20 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:58506 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224985AbUBPJSU>; Mon, 16 Feb 2004 09:18:20 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id D18CC4781E; Mon, 16 Feb 2004 10:18:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id BE15143046; Mon, 16 Feb 2004 10:18:17 +0100 (CET)
Date: Mon, 16 Feb 2004 10:18:17 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
In-Reply-To: <20040213220725.GA31847@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402161014220.19569@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
 <20040213145316.GA23810@linux-mips.org> <20040213175141.GB16718@mvista.com>
 <Pine.LNX.4.55.0402131908370.15042@jurand.ds.pg.gda.pl>
 <20040213220725.GA31847@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 13 Feb 2004, Ralf Baechle wrote:

> >  If we want to tolerate performance loss, then it's easily doable.  That 
> > can be done with the current setup, with a jump instruction to the 
> > referred function added at the end and "__attribute__((used))" or perhaps 
> > "asm("foo")" added to the function declaration.
> > 
> >  I can choose this path if we agree on it.
> 
> The inline version is fundemantally fragile.  The outline version has
> problems with getting reordered by later gcc which can be solved by
> putting a jump to the C function at the end; the C function also needs
> the right __attribute__s so it won't get eleminated by gcc.

 This is exactly what I'm writing of ("the current setup" == what we now
have in the kernel; sorry for being ambiguous) -- except that I'd go for
the "asm("foo")" variant which does not require any additional
__attribute__s and should work at least since gcc 2.95 (and which I like
better).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
