Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 18:05:57 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:50137 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S869682AbSLFRFg>; Fri, 6 Dec 2002 18:05:36 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01734;
	Fri, 6 Dec 2002 18:01:19 +0100 (MET)
Date: Fri, 6 Dec 2002 18:01:18 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
In-Reply-To: <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1021206175502.26674R-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Dec 2002, Thiemo Seufer wrote:

> >  Which wouldn't work either as it implies 32-bit pointers, while gcc still
> > emits 64-bit assembly.
> 
> Which should be enough for smaller address spaces.

 But gas will complain of the same address truncation as for o32. 

> > If we want to preserve the setup cleanly, we
> > probably need yet another ABI model in gcc (especially in the face of the
> > coming changes to get rid of assembly macros), with sign-extended 32-bit
> > pointers for accessing program segments and 64-bit ones for the remaining
> > addresses.
> 
> Do you think this is worth the hassle? N64 offers better flexibility in
> the large memory case at some performance cost, and it's conceptionally
> cleaner.

 Remember we are writing of the kernel -- we don't know what userland is
going to bring us -- a user pointer need not fit in 32 bits.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
