Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:30:40 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:11235 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCPaj>; Tue, 3 Feb 2004 15:30:39 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id AC35847823; Tue,  3 Feb 2004 16:30:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id A0924474C8; Tue,  3 Feb 2004 16:30:33 +0100 (CET)
Date: Tue, 3 Feb 2004 16:30:33 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20040202152307.GB28673@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031612100.16076@jurand.ds.pg.gda.pl>
References: <20040202141939Z8225226-9616+1555@linux-mips.org>
 <Pine.LNX.4.55.0402021611490.6182@jurand.ds.pg.gda.pl>
 <20040202152307.GB28673@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004, Ralf Baechle wrote:

> >  How do we assure tails of interrupt handlers don't trigger the errata?
> 
> The problem can only be triggered if instructions surrounding the
> cacheop use the dcache; exceptions such as interrupts are not relevant.

 Why?  How is an "eret" with its preceding instructions different to other 
instructions?  There may be a data cache miss soon before an "eret" and 
the response buffer may contain data.  And you may get an exeption right 
before a CACHE instruction.

> Which I'm really happy about.  Disabling interrupts is a problem in cases
> were we can't avoid page faults.

 I worry this is unsafe and given the unlikeliness of getting an interrupt
just between the dummy load and the CACHE instruction, this change creates
a completely obscure bug that'll bite unpredictably and possibly
invisibly, just corrupting data, every once and then.  But the situation
may be not that bad -- what does exactly happen when the erratum gets 
triggered?  Missing a Create_Dirty_Excl_D operation should itself be a 
performance hit only, but given the problems reported I suppose data gets 
corrupted, either in the cache or in the main memory.  Am I right?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
