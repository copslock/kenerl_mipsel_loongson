Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2003 12:48:02 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:33936 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225326AbTLVMsB>; Mon, 22 Dec 2003 12:48:01 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 132F94AF7D; Mon, 22 Dec 2003 13:47:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 09B6D4AC79; Mon, 22 Dec 2003 13:47:53 +0100 (CET)
Date: Mon, 22 Dec 2003 13:47:52 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: karthikeyan natarajan <karthik_96cse@yahoo.com>,
	Michael Uhler <uhler@mips.com>, linux-mips@linux-mips.org
Subject: Re: Regarding branch delay instructions in R4000
In-Reply-To: <01e801c3c6e2$4aa51ff0$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.55.0312221342180.27237@jurand.ds.pg.gda.pl>
References: <20031220095312.38822.qmail@web10104.mail.yahoo.com>
 <01e801c3c6e2$4aa51ff0$10eca8c0@grendel>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 20 Dec 2003, Kevin D. Kissell wrote:

> Yes, MIPS stood for Microprocessor without Interlocked Pipeline Stages
> when it was first used as a name for a graduate student project at Stanford
> University in publications from 1982.  But that in itself was a play on words,
> as the most common metric of computer perfomance at the time was 
> "Millions of Instructions Per Second", or MIPS.  The Stanford architcture 
> was revamped and commercialized as the "MIPS I" architecture, implemented 
> in the R2000 and R3000 CPUs, which likewise had no interlocks on cache load 
> delays. As silicon geometries became finer and gates got cheaper, the relative cost
> of providing the interlocks decreased, while the need to run the same MIPS 
> binaries on multiple, very different implementations of the architecture increased.
> So from the R4000 onwards, MIPS CPUs have had interlocks.  But by that time
> the name "MIPS" was a well-known trademark, and it made no sense to change it.

 Well, as I like to nitpick, actually the original MIPS I R2000 and R3000
processors did have a single interlock already -- the one used for reading
the HI and LO registers. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
