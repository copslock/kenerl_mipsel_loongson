Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 13:38:01 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:56467 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225206AbTEOMh7>; Thu, 15 May 2003 13:37:59 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA16816;
	Thu, 15 May 2003 14:38:46 +0200 (MET DST)
Date: Thu, 15 May 2003 14:38:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
In-Reply-To: <20030515115032.GP8833@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030515142409.16026D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 15 May 2003, Thiemo Seufer wrote:

> >  Hmm, I would assume "mipsn32*-linux" defaults to n32 and "mips64*-linux" 
> > -- to (n)64.  It isn't the case, indeed.
> 
> IMHO it's not particularily useful to have both of these. I assume a n64
> capable system will always implement n32 also, for better performance
> and less memory consumption, and the majority of applications will run
> as n32. IOW, there's little need for a n64-defaulting configuration.
> 
> But IIRC we disagree about this point.

 It's not about whether we agree or not -- it's about letting a user make
a choice what suits him better.  We need not force anyone to accept our
points of view -- it's one of the main advantages of free software. 

 Also I would like to allow glibc to be configured without n32 and won't
object disallowing (n)64 alternatively.  I already run kernels that
support o32 and (n)64 only (o32 is temporary, of course, until glibc
supports (n)64), so it's not true an (n)64-capable system always supports
n32. 

 BTW, you may want a program to be built as (n)64 whenever it uses mmap() 
and can operate on the so called "large files".  So there may be
significantly more programs requiring the (n)64 format than it may seem at
the first thought. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
