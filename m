Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 13:43:19 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:30094 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225803AbUDUMnR>; Wed, 21 Apr 2004 13:43:17 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id BEEF747624; Wed, 21 Apr 2004 14:43:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B3345475C5; Wed, 21 Apr 2004 14:43:10 +0200 (CEST)
Date: Wed, 21 Apr 2004 14:43:10 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Harm Verhagen <hverhagen@dse.nl>, linux-mips@linux-mips.org
Subject: Re: locking problems with mips atomicity ?
In-Reply-To: <20040420224904.GA21924@nevyn.them.org>
Message-ID: <Pine.LNX.4.55.0404211434370.28167@jurand.ds.pg.gda.pl>
References: <1082501074.13783.54.camel@node-d-8d2e.a2000.nl>
 <20040420224904.GA21924@nevyn.them.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Apr 2004, Daniel Jacobowitz wrote:

> > static __inline__ void atomic_add(int i, atomic_t * v)
> > {
> > 	unsigned long temp;
> > 
> > 	__asm__ __volatile__(
> > 		"1:   ll      %0, %1      # atomic_add\n"
> > 		"     addu    %0, %2                  \n"
> > 		"     sc      %0, %1                  \n"
> > 		"     beqz    %0, 1b                  \n"
> > 		: "=&r" (temp), "=m" (v->counter)
> > 		: "Ir" (i), "m" (v->counter));
> > }
> > 
> > So I wonder if there is a bug here. 
> > Can some MIPS guru check ? :)
> 
> It won't be a problem in the kernel.  The problem only happens when the
> assembler expands a macro to multiple instructions including a load,
> and that only happens for position-independent code; the kernel is not
> PIC.

 And if using a function like the above is to be PIC, the solution is to
use the "R" constraint for the ll/sc memory operand to assure it's passed
to gas as a machine-expressible address, although I'm not sure if that's
currently handled by gcc correctly (2.95.x definitely has problems with
it; I'm going to look into it for 3.5.0 soon).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
