Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 21:04:30 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:63623 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225308AbUCQVE3>; Wed, 17 Mar 2004 21:04:29 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 8269E4B467; Wed, 17 Mar 2004 22:04:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 72EC84B05E; Wed, 17 Mar 2004 22:04:22 +0100 (CET)
Date: Wed, 17 Mar 2004 22:04:22 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
In-Reply-To: <4058BC76.9020204@gentoo.org>
Message-ID: <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl>
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de>
 <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de>
 <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 17 Mar 2004, Kumba wrote:

> >  It looks like a bug somewhere in binutils, probably BFD.  The segment's
> > start address should be rounded up to 0x8010000, not down to 0x8000000.
> 
> Well, I did test removing the patch Thiemo mentioned 
> (http://sources.redhat.com/ml/binutils/2003-12/msg00380.html), and 
> rebuilding a kernel, and now they boot.  I tested a 2.4.25 on an Indy, 
> and 2.6.4 on an O2.  Perhaps a bug in this specific patch?

 The patch just triggers it.  Previously, the segment's start address as
set by Linux in a linker script was already aligned to the page size as it
was defined then.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
