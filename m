Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 15:40:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:47092 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225072AbTHLOkT>; Tue, 12 Aug 2003 15:40:19 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08773
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 16:40:16 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 12 Aug 2003 16:40:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
In-Reply-To: <20030812140452.GD10792@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030812163438.7029F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 12 Aug 2003, Thiemo Seufer wrote:

> > > If the intention is to use mfc0 for 32bit kernels and dmfc0 for 64bit,
> > > the check should probably be
> > > 
> > > #ifdef __mips64
> > > # define MFC0		dmfc0
> > > # define MTC0		dmtc0
> > > #else
> > > # define MFC0		mfc0
> > > # define MTC0		mtc0
> > > #endif
> > 
> >  I'd go for CONFIG_MIPS64 here.
> 
> This would work as well, but I prefer compiler intrinsic defines
> over custom configury.

 Well, for Linux it seems appropriate to use a kernel's configuration to
select run-time behaviour -- in this case it's CONFIG_MIPS64 that was
selected by a user that matters (i.e. that we use 64-bit addressing) and
not a compiler's configuration.  Just the opposite to what's expected in
the userland. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
