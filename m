Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 14:09:15 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:8137 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224915AbUAUOJO>; Wed, 21 Jan 2004 14:09:14 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 982644C3BC; Wed, 21 Jan 2004 15:09:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 1CE904787B; Wed, 21 Jan 2004 15:09:12 +0100 (CET)
Date: Wed, 21 Jan 2004 15:09:12 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
In-Reply-To: <20040120204026.GA9470@sonycom.com>
Message-ID: <Pine.LNX.4.55.0401211449170.11137@jurand.ds.pg.gda.pl>
References: <20031223114644.GA5458@sonycom.com>
 <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl> <20040120204026.GA9470@sonycom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Jan 2004, Dimitri Torfs wrote:

> >  It took a bit longer than I planned, sorry.  Anyway, here are two
> > functionally equivalent patches, for 2.4 and the head, that remove an ISA
> > specification if a tool supports "-march=" and "-mabi=" at the same time.  
> > Please try the appropriate one.
> 
> Tried the head one, it had some typos (patch follows). Unfortunately, as I wrote

 Oops, thanks for the correction -- as I still have only gcc 2.95.4, I
wasn't able to see the typos immediately.

> earlier, gcc-3.2 doesn't set the ISA correctly when using -march=, so
> it doesn't work for 3.2. 

 But do we care of the ISA?  I don't think so -- it's just a leftover from
the days the MIPS world was less complicated.  If gcc 3.2 correctly emits
code for the selected processor and obeys the selected ABI, then
everything is fine.  Are the binaries correct?  If so, I'd like to apply
the patch.

 The few remaining bits in <asm/asm.h> that still depend on _MIPS_ISA
should be rewritten to make use of appropriate CONFIG_CPU_HAS_* settings.  
Or perhaps we can just scrap them -- nothing uses them at all (and current
gcc is able to emit conditional move instructions itself).  OTOH, for
hand-coded assembly it might be a good idea to put them into gas as macros
-- similarly to what gas does for the Alpha for certain instructions that
are only available with later architecture revisions.  I'll work on it in
some spare time.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
