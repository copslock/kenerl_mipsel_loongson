Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 19:16:07 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54467 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIERQG>; Thu, 5 Sep 2002 19:16:06 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA10420;
	Thu, 5 Sep 2002 19:16:23 +0200 (MET DST)
Date: Thu, 5 Sep 2002 19:16:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <20020905163913.GA6086@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1020905190929.7444L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> >  Huh?  I can somewhat understand the "rebuild and forget" approach,
> > especially in cases suitably experienced stuff was lost meanwhile.  But if
> > you start to fiddle with some old crap, you may equally well run
> > 's/long/int/' within it, what's a deal. 
> 
> Eh?  That's not even sort-of practical on an application of significant
> size.  It would be a nightmare.

 Oh yes, I tend to forget there are people who do not write clean software
-- if the size of an object is critical e.g. for a system-independent
binary data interface, there should be a data type for it defined in a
single place somewhere.  But who cares?  "It's not me who'll have to fix
it later, so why should I bother putting more effort into it."

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
