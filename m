Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 21:34:12 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:49095 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIETeL>; Thu, 5 Sep 2002 21:34:11 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA12385;
	Thu, 5 Sep 2002 21:34:28 +0200 (MET DST)
Date: Thu, 5 Sep 2002 21:34:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Daniel Jacobowitz <dan@debian.org>,
	Hartvig Ekner <hartvige@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <019601c25501$c5307250$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020905205511.7444O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Kevin D. Kissell wrote:

> of some algorithms.  MIPS was rather unique in having made 
> a "binary compatible" transition from 32 to 64-bits.  Does anyone 
> know what's being done with C integer binding on the AMD
> "Hammer" architecture?  They're looking at the same problem,
> 10 years further on.

 Well, SPARC is another mature example that works this way.  And the
PA-RISC, PPC, and S390 ports may have similar experiences, but I don't
know the details.  MIPS is quite unique with the n32 ABI as the ABI is
64-bit but with 32-bit addressing.  I'll see if and how they handle such a
case, but it's likely they have plain 32-bit and plain 64-bit ABIs only.

 BTW, I've found an interesting type size analyzis in the SUSv2 at: 
'http://www.usenix.org/publications/login/standards/10.data.html' and they
simply opt for LP64 for 64-bit systems. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
