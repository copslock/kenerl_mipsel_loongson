Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:11:45 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:47066 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225226AbUBCPLo>; Tue, 3 Feb 2004 15:11:44 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 4AE6A47823; Tue,  3 Feb 2004 16:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 3F4064781E; Tue,  3 Feb 2004 16:11:43 +0100 (CET)
Date: Tue, 3 Feb 2004 16:11:43 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] pg-r4k.c cp0 hazards for R4000/R4400
In-Reply-To: <20040202150806.GA27819@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0402031504030.16076@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0401261755460.26076@jurand.ds.pg.gda.pl>
 <20040202150806.GA27819@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 2 Feb 2004, Ralf Baechle wrote:

> >  The R4000/R4400 has a coprocessor 0 hazard when a P-cache operation is
> > less than two non-load, non-cache instructions apart from a store to the
> > same line.  For processors without a secondary cache, the code in pg-r4k.c
> > currently issues a Create Dirty Exclusive D-cache operation and then
> > immediately executes consecutive stores to the same line, therefore 
> > fulfilling the conditions for the hazard.
> 
> The wording is "There must be two non-load, non-CACHE instructions between
> a store and a CACHE instruction directed to the same primary cache line as
> the store."  My interpretation of that is the problem only exists if a
> store instruction is followed by a cache instruction, not if the
> cache instruction is followed by the store?  I've not found any hints in
> the manual to verify or falsify this theory.  In case you're right we've

 I'm pretty sure the hazard is in both directions -- why?  Because it's 
marked both in the "CP0 Data Used, Stage Used" and the "CP0 Data Written, 
Stage Available" column.  I interpret that as a requirement for the CACHE 
instructions to "start using data" two instructions ahead and "finish 
writing data" two instructions after itself.  If your assumption was true, 
I'd put the marking only in the former column.  Of course that does not 
mean the table is correct, but I'd assume so, for safety, if not anything 
else.

> violated this hazard since almost beginning of the time, see
> http://www.linux-mips.org/cvsweb/linux/arch/mips/mm/Attic/pg-r4k.S?rev=1.9
> and I've not heared of any problems arising from this.

 Perhaps it wasn't really tested.  Have you ever run the code on a PC 
variant?  Has anyone else?

> Any DECstations using the R4[04]00PC CPU variant?

 None.  That would normally be a downgrade in memory throughput as the
R2k/R3k DECstations used to have 64kB of I-cache + 64kB of D-cache,
typically, and sometimes (with the 33MHz variant) even 128kB of D-cache.

> > but 
> > currently I'd like to apply this change to assure correct operation.  As I 
> > have no non-SC R4000/R4400 system, this was untested, but perhaps studying 
> > the problem covered by the -scache patch sent previously will show if the 
> > hazard is indeed avoided.
> 
> Have you actually been hit by that hazard?  

 I suppose so -- without the "mips-pg-r4k-scache" patch my system is very
unstable and the difference is essentially that in addition to
Create_Dirty_Excl_SD there are additional Create_Dirty_Excl_D ones, that,
apart from being a performance hit, shouldn't have any effect.  I have to
investigate it further yet.

> >  OK to apply?
> 
> Most of your changes conflict with my fixes, so I guess that need redoing ...

 I can see you've already resolved a few problems -- I'll check if any
remained.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
