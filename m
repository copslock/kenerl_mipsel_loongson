Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g798bYRw001875
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 01:37:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g798bYRR001874
	for linux-mips-outgoing; Fri, 9 Aug 2002 01:37:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g798bMRw001862;
	Fri, 9 Aug 2002 01:37:23 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA00579;
	Fri, 9 Aug 2002 10:39:57 +0200 (MET DST)
Date: Fri, 9 Aug 2002 10:39:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: siginfo structure in 64-bit kernel
In-Reply-To: <3D52CE5B.CD8C72C4@mips.com>
Message-ID: <Pine.GSO.3.96.1020809102112.29687D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 8 Aug 2002, Carsten Langgaard wrote:

> >  I checked the patch and discovered you somehow made the order of struct
> > members wrong.
> 
> Good spotted, that's what happens when MIPS is the only one that put
> 'si_code' before 'si_errno' in the structure. 

 That's why I'm always using MIPS-specific definitions as a reference
first.  The actual reason of the differences is the SysV ABI supplement
for MIPS which defines things a bit differently than the others here and
there, often with no justified reason (well, the reason is really Irix,
but then again, there is no justified reason for Irix to be different
there).

> >  Here is an updated version that works for me.  It includes
> > both the ordering fix and unsigned type changes I suggested before.
> 
> With your sign changes we are doing things a little bit different than
> others, I know that's not really an argument, but does the unsigned
> types not work for you ? 

 Others are different here, actually.  With a signed type if a 32-bit
address is cast to "long" or "void *" implicitly (the latter is normally
spotted by the compiler and marked with a warning; the former is usually
silent), it becomes a valid 64-bit address that still refers to the same
location.  With an unsigned one it doesn't work for KSEG addresses
anymore.  That's because addresses are signed on MIPS -- 32-bit addresses
are sign-extended (as opposed to zero-extended) by the hardware the 32-bit
address space is in the middle of the 64-bit one (and not at the bottom as
in the zero-extension variant). 

 I suppose the unsigned types would usually work if casts were applied
carefully everywhere.  I'd prefer code to work automatically, though,
without corner cases triggered every now and then. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
