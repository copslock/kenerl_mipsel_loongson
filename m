Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 00:47:17 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:24460 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225331AbUCRArQ>; Thu, 18 Mar 2004 00:47:16 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 9E6F64B3CA; Thu, 18 Mar 2004 01:46:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 8A9A4474E9; Thu, 18 Mar 2004 01:46:48 +0100 (CET)
Date: Thu, 18 Mar 2004 01:46:48 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <4058E89B.3010208@gentoo.org>
Message-ID: <Pine.LNX.4.55.0403180141400.14525@jurand.ds.pg.gda.pl>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org>
 <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org>
 <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl> <4058E89B.3010208@gentoo.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 17 Mar 2004, Kumba wrote:

> >  A simpler workaround (no need to rebuild binutils) might be setting:
> > 
> > LOADADDR := 0x88010000
> > 
> > for CONFIG_SGI_IP22 in arch/mips/Makefile.
> 
> And/or CONFIG_SGI_IP32.  I've seen the issue appear there as well.

 Essentially all platforms that currently set the address to something
that's not aligned to a 64kB boundry.  I'd like binutils to be fixed
instead, though -- I'll try to track the problem down and cook a patch
before 2.15.  I think the problem may be considered serious enough the
release may even be deferred for a few days if necessary (since I believe
it's quite close).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
