Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 13:47:21 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:21946 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122958AbSIELrU>; Thu, 5 Sep 2002 13:47:20 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA05373;
	Thu, 5 Sep 2002 13:47:39 +0200 (MET DST)
Date: Thu, 5 Sep 2002 13:47:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Tor Arntsen <tor@spacetec.no>
cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
In-Reply-To: <200209050930.LAA30701@pallas.spacetec.no>
Message-ID: <Pine.GSO.3.96.1020905134606.2423G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Sep 2002, Tor Arntsen wrote:

> > Any reference?  AFAIK, long is 64-bit for n32 and only void * is 32-bit. 
> >It doesn't make sense otherwise. 
> 
> On SGI/Irix n32 long and void* are 32-bit, only long long is 64-bit.
> On SGI/Irix n64 long and void* are 64-bit too.

 Hmm, it looks pretty much broken if that's true (especially given long
long was non-standard untile very recently).  I'll check the docs, yet.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
