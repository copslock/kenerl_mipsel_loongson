Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2004 12:50:33 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:5345 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225525AbUCWMud>; Tue, 23 Mar 2004 12:50:33 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 42E044BD34; Tue, 23 Mar 2004 13:50:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2F0AD4AC6E; Tue, 23 Mar 2004 13:50:27 +0100 (CET)
Date: Tue, 23 Mar 2004 13:50:27 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <20040323120033.GA6151@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0403231348010.16819@jurand.ds.pg.gda.pl>
References: <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org>
 <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org>
 <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org>
 <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0403221255200.6539@jurand.ds.pg.gda.pl> <20040323120033.GA6151@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Mar 2004, Ralf Baechle wrote:

> >  What's important, segment alignment happens under the assumption a binary 
> > will be used in a paged environment.  This is not normally the case with a 
> > MIPS Linux kernel, so I think the right solution is to ask the linker not 
> > to do page aligning using the "-n" option.  Here's a patch that should do 
> > that.
> > 
> >  Ralf, OK to apply this?
> 
> Sure, I don't see any possible drawback from this.

 Some picky firmware may be unhappy about a bit different ELF layout it
yields.  Anyway, this is the right way to go and any problems with bad
firmware may be able to be compensated with updates to our linker scripts.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
